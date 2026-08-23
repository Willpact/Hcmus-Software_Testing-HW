#!/usr/bin/env node

const fs = require('fs');
const http = require('http');
const path = require('path');
const { spawn } = require('child_process');
const { runtimeLayout } = require('./hw06-runtime-layout');

const root = path.resolve(__dirname, '..', '..');
const layout = runtimeLayout(root);
const sutRoot = path.join(layout.sutRoot, 'backend');
const runOut = layout.runOut;
const smokeOut = layout.smokeOut;
const redirect = path.join(root, 'postman', 'scripts', 'sqlite-path-redirect.cjs');
const newmanJs = path.join(root, '.tools', 'newman', 'node_modules', 'newman', 'bin', 'newman.js');

function delay(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function requestProducts() {
  return new Promise((resolve, reject) => {
    const req = http.get('http://localhost:3000/api/products', { timeout: 1000 }, (res) => {
      let body = '';
      res.on('data', (chunk) => { body += chunk; });
      res.on('end', () => {
        try {
          const rows = JSON.parse(body);
          resolve(res.statusCode === 200 && Array.isArray(rows) && rows.length >= 5);
        } catch (error) { resolve(false); }
      });
    });
    req.on('timeout', () => req.destroy(new Error('timeout')));
    req.on('error', reject);
  });
}

async function ensurePortFree() {
  try {
    if (await requestProducts()) throw new Error('Port 3000 already serves a SUT; refusing to reuse an unowned process');
  } catch (error) {
    if (error.message.includes('refusing')) throw error;
  }
}

async function waitReady(child) {
  for (let index = 0; index < 60; index += 1) {
    if (child.exitCode !== null) throw new Error(`SUT exited before readiness: ${child.exitCode}`);
    try { if (await requestProducts()) return; } catch (error) { /* retry */ }
    await delay(250);
  }
  throw new Error('SUT readiness timeout');
}

function startSut(outputDir) {
  fs.mkdirSync(outputDir, { recursive: true });
  const runtimeDbDir = path.join(outputDir, 'runtime-db');
  const runtimeDb = path.join(runtimeDbDir, 'database.sqlite');
  const sourceDb = path.join(sutRoot, 'database.sqlite');
  if (!fs.existsSync(sourceDb)) throw new Error(`SUT source database is missing: ${sourceDb}`);
  if (!fs.existsSync(path.join(sutRoot, 'server.js'))) throw new Error(`SUT server is missing: ${sutRoot}`);
  fs.mkdirSync(runtimeDbDir, { recursive: true });
  fs.copyFileSync(sourceDb, runtimeDb);
  const stdout = fs.createWriteStream(path.join(outputDir, 'sut.stdout.log'));
  const stderr = fs.createWriteStream(path.join(outputDir, 'sut.stderr.log'));
  const child = spawn(process.execPath, ['--require', redirect, 'server.js'], {
    cwd: sutRoot,
    windowsHide: true,
    env: {
      ...process.env,
      HW06_SUT_DATABASE_PATH: sourceDb,
      HW06_RUNTIME_DATABASE_PATH: runtimeDb,
    },
  });
  child.stdout.pipe(stdout);
  child.stderr.pipe(stderr);
  child._hw6Streams = [stdout, stderr];
  return child;
}

async function stopSut(child) {
  if (child && child.exitCode === null) child.kill();
  if (child && child.exitCode === null) await Promise.race([new Promise((resolve) => child.once('exit', resolve)), delay(5000)]);
  for (const stream of child?._hw6Streams || []) stream.end();
}

function runProcess(file, args, cwd, stdoutPath, stderrPath) {
  return new Promise((resolve, reject) => {
    const stdout = fs.createWriteStream(stdoutPath);
    const stderr = fs.createWriteStream(stderrPath);
    const child = spawn(file, args, { cwd, windowsHide: true });
    child.stdout.pipe(stdout);
    child.stderr.pipe(stderr);
    child.on('error', reject);
    child.on('exit', (code) => {
      stdout.end(); stderr.end(); resolve(code);
    });
  });
}

async function main() {
  await ensurePortFree();
  const intentional = layout.mode === 'intentional-fail';
  const result = {
    smoke_required: true,
    smoke_reason: 'Corrected reusable isolated-fixture and sequence harness',
    run_id: 'run-002',
    ci_run_mode: layout.mode,
  };
  let sut;
  try {
    sut = startSut(smokeOut);
    await waitReady(sut);
    result.smoke_sut_pid = sut.pid;
    result.smoke_exit_code = await runProcess(process.execPath, [newmanJs, 'run', path.join(smokeOut, 'smoke.postman_collection.json'), '-e', path.join(smokeOut, 'runtime-input.postman_environment.json'), '-r', 'cli,json,htmlextra', '--reporter-json-export', path.join(smokeOut, 'newman.json'), '--reporter-htmlextra-export', path.join(smokeOut, 'newman.html'), '--export-environment', path.join(smokeOut, 'runtime-output.postman_environment.json')], root, path.join(smokeOut, 'stdout.log'), path.join(smokeOut, 'stderr.log'));
    if (result.smoke_exit_code !== 0) throw new Error(`Corrected harness smoke failed: ${result.smoke_exit_code}`);
    await stopSut(sut); sut = null;

    sut = startSut(runOut);
    await waitReady(sut);
    result.run002_sut_pid = sut.pid;
    result.run002_exit_code = await runProcess(process.execPath, [path.join(root, 'postman', 'scripts', 'run-targeted-run-002.js')], root, path.join(runOut, 'stdout.log'), path.join(runOut, 'stderr.log'));
    if (intentional && result.run002_exit_code !== 1) throw new Error(`intentional-fail wrapper expected exit 1; observed ${result.run002_exit_code}`);
    if (!intentional && result.run002_exit_code !== 0) throw new Error(`run-002 wrapper failed: ${result.run002_exit_code}`);
    result.status = intentional ? 'INTENTIONAL_FAILURE_VERIFIED' : 'PASS';
  } finally {
    await stopSut(sut);
  }
  fs.writeFileSync(path.join(runOut, 'orchestration-result.json'), `${JSON.stringify(result, null, 2)}\n`, 'utf8');
  console.log(JSON.stringify(result, null, 2));
  if (intentional) process.exitCode = 1;
}

main().catch((error) => {
  console.error(error.stack || error.message);
  process.exitCode = 1;
});
