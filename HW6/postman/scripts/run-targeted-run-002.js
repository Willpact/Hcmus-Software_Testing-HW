#!/usr/bin/env node

const crypto = require('crypto');
const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..', '..');
const sutRoot = path.resolve(root, '..', 'eshop-sut');
const out = path.join(root, 'test-results', 'hw06', 'run-002');
const databasePath = path.join(out, 'runtime-db', 'database.sqlite');
const collectionPath = path.join(out, 'targeted-collection.json');
const environmentPath = path.join(out, 'runtime-input.postman_environment.json');
const newman = require(path.join(root, '.tools', 'newman', 'node_modules', 'newman'));
const sqlite3 = require(path.join(sutRoot, 'backend', 'node_modules', 'sqlite3')).verbose();

function readJson(file) {
  return JSON.parse(fs.readFileSync(file, 'utf8').replace(/^\uFEFF/, ''));
}

function sha256(file) {
  return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex').toUpperCase();
}

function stableId(name) {
  const match = String(name || '').match(/^\[(API0[123]-(?:AI|STU)-\d{3})\]/);
  return match ? match[1] : null;
}

function allAsync(db, sql, params = []) {
  return new Promise((resolve, reject) => db.all(sql, params, (err, rows) => err ? reject(err) : resolve(rows)));
}

const environment = readJson(environmentPath);
const env = Object.fromEntries(environment.values.map((entry) => [entry.key, entry.value]));
const external = {
  run_id: 'run-002',
  db_path: 'test-results/hw06/run-002/runtime-db/database.sqlite',
  secrets_logged: false,
  stable_case_db_hashes: {},
};
const beforeHashes = new Map();
const startedAt = new Date();

const run = newman.run({
  collection: collectionPath,
  environment: environmentPath,
  reporters: ['cli', 'json', 'htmlextra'],
  reporter: {
    json: { export: path.join(out, 'newman.json') },
    htmlextra: { export: path.join(out, 'newman.html'), title: 'HW06 Targeted Corrective Rerun run-002' },
  },
  exportEnvironment: path.join(out, 'runtime-output.postman_environment.json'),
  suppressExitCode: true,
});

run.on('beforeItem', (_err, args) => {
  const id = stableId(args.item && args.item.name);
  if (id && fs.existsSync(databasePath)) beforeHashes.set(id, sha256(databasePath));
});

run.on('item', (_err, args) => {
  const id = stableId(args.item && args.item.name);
  if (!id || !fs.existsSync(databasePath)) return;
  external.stable_case_db_hashes[id] = {
    sha256_before: beforeHashes.get(id) || null,
    sha256_after: sha256(databasePath),
  };
});

run.on('done', async (err, summary) => {
  try {
    const db = new sqlite3.Database(databasePath, sqlite3.OPEN_READONLY);
    const users = await allAsync(db, "SELECT id, email, password, reset_token FROM users WHERE email LIKE 'hw06-%' ORDER BY id");
    const orders = await allAsync(db, "SELECT o.id, u.email, o.total_amount, o.shipping_address FROM orders o JOIN users u ON u.id = o.user_id WHERE u.email LIKE 'hw06-%' ORDER BY o.id");
    const products = await allAsync(db, "SELECT id, name, price FROM products WHERE name LIKE 'HW06-%' ORDER BY id");
    await new Promise((resolve) => db.close(resolve));

    external.api01_user_states = users.map((row) => ({
      id: row.id,
      email: row.email,
      password_state: row.password === env.fixtureOldPassword ? 'OLD' : row.password === env.fixtureNewPassword ? 'NEW_STRONG' : row.password === env.fixtureWeakPassword ? 'WEAK_PLAINTEXT' : 'OTHER',
      reset_token_present: row.reset_token !== null && String(row.reset_token) !== '',
    }));
    const ai035 = users.find((row) => row.email.includes('api01-ai-035'));
    external.api01_ai_035 = {
      user_found: Boolean(ai035),
      plaintext_equal: ai035 ? ai035.password === env.fixtureNewPassword : null,
      password_value_logged: false,
    };
    external.api01_ai_027 = {
      request_db_hash_before: external.stable_case_db_hashes['API01-AI-027']?.sha256_before || null,
      request_db_hash_after: external.stable_case_db_hashes['API01-AI-027']?.sha256_after || null,
      datastore_unchanged_during_action: Boolean(external.stable_case_db_hashes['API01-AI-027']) && external.stable_case_db_hashes['API01-AI-027'].sha256_before === external.stable_case_db_hashes['API01-AI-027'].sha256_after,
    };
    external.orders = orders;
    external.products = products;
    fs.writeFileSync(path.join(out, 'external-hook-evidence.json'), `${JSON.stringify(external, null, 2)}\n`, 'utf8');

    const endedAt = new Date();
    const result = {
      status: err ? 'NEWMAN_RUNTIME_ERROR' : 'COMPLETED',
      run_id: 'run-002',
      started_at: startedAt.toISOString(),
      ended_at: endedAt.toISOString(),
      duration_seconds: Number((endedAt - startedAt) / 1000),
      requests_executed: summary.run.executions.length,
      assertions: summary.run.stats.assertions.total,
      assertion_failures: summary.run.failures.length,
      skipped_requests: summary.run.stats.requests.pending,
      reports: ['newman.json', 'newman.html'],
      secrets_logged: false,
    };
    fs.writeFileSync(path.join(out, 'runner-result.json'), `${JSON.stringify(result, null, 2)}\n`, 'utf8');
    console.log(JSON.stringify(result, null, 2));
    process.exitCode = err ? 2 : 0;
  } catch (postError) {
    console.error(postError.stack || postError.message);
    process.exitCode = 3;
  }
});
