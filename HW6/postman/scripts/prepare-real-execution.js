#!/usr/bin/env node

const crypto = require('crypto');
const fs = require('fs');
const path = require('path');
const { execFileSync } = require('child_process');

const root = path.resolve(__dirname, '..', '..');
const sutRoot = path.resolve(root, '..', 'eshop-sut');
const backend = path.join(sutRoot, 'backend');
const collectionPath = path.join(root, 'postman', 'collections', 'HW06-API-Testing.postman_collection.json');
const environmentPath = path.join(root, 'test-results', 'hw06', 'runtime', 'HW06-Local.runtime.postman_environment.json');
const newman = path.join(root, '.tools', 'newman', 'node_modules', '.bin', 'newman.cmd');
const newmanJs = path.join(root, '.tools', 'newman', 'node_modules', 'newman', 'bin', 'newman.js');
const reporterPackage = path.join(root, '.tools', 'newman', 'node_modules', 'newman-reporter-htmlextra', 'package.json');
const out = path.join(root, 'test-results', 'hw06', 'preflight-003');
const smokeOut = path.join(root, 'test-results', 'hw06', 'smoke-001');

function readJson(file) {
  return JSON.parse(fs.readFileSync(file, 'utf8').replace(/^\uFEFF/, ''));
}

function sha256(file) {
  return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex').toUpperCase();
}

function writeJson(file, value) {
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, `${JSON.stringify(value, null, 2)}\n`, 'utf8');
}

function writeText(file, value) {
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, `${value.trimEnd()}\n`, 'utf8');
}

function fail(message) {
  throw new Error(message);
}

const collection = readJson(collectionPath);
const environment = readJson(environmentPath);
const environmentValues = Object.fromEntries(environment.values.map((entry) => [entry.key, entry.value]));
const mandatory = [
  'baseUrl', 'studentId', 'userEmail', 'userPassword', 'otherUserEmail',
  'otherUserPassword', 'adminEmail', 'adminPassword', 'resetEmail',
  'resetUserPassword', 'newPassword', 'shippingAddress', 'productId',
  'categoryId', 'clientTotal', 'testRunId',
];
const missing = mandatory.filter((key) => String(environmentValues[key] ?? '').trim() === '');
if (missing.length) fail(`Mandatory runtime variables are empty: ${missing.join(', ')}`);
if (environmentValues.baseUrl !== 'http://localhost:3000') fail('Unexpected baseUrl');

const requests = [];
function walk(items, parents = []) {
  for (const item of items || []) {
    const itemPath = [...parents, item.name];
    if (item.request) requests.push({ item, itemPath });
    walk(item.item, itemPath);
  }
}
walk(collection.item);

const caseRequests = requests.filter(({ item }) => /^\[(API01|API02|API03)-(AI|STU)-\d+\]/.test(item.name));
const headerFailures = [];
for (const { item, itemPath } of requests) {
  const headers = (item.request.header || []).filter((header) => String(header.key).toLowerCase() === 'x-student-id');
  if (headers.length !== 1 || headers[0].value !== '{{studentId}}') headerFailures.push(itemPath.join(' / '));
}
if (requests.length !== 103 || caseRequests.length !== 93 || headerFailures.length) {
  fail(`Collection guard failed: requests=${requests.length}, cases=${caseRequests.length}, headerFailures=${headerFailures.length}`);
}

if (!fs.existsSync(newman) || !fs.existsSync(newmanJs)) fail('Local Newman executable is missing');
if (!fs.existsSync(reporterPackage)) fail('htmlextra reporter package is missing');
const newmanVersion = execFileSync(process.execPath, [newmanJs, '--version'], { encoding: 'utf8' }).trim();
const reporterVersion = readJson(reporterPackage).version;
if (newmanVersion !== '6.2.2') fail(`Unexpected Newman version: ${newmanVersion}`);
if (reporterVersion !== '1.23.1') fail(`Unexpected htmlextra version: ${reporterVersion}`);

const databasePath = path.join(backend, 'database.sqlite');
const serverPath = path.join(backend, 'server.js');
if (!fs.existsSync(databasePath) || !fs.existsSync(serverPath)) fail('Expected local EShop backend/database is missing');
execFileSync(process.execPath, ['--check', serverPath], { stdio: 'pipe' });

const prior = ['preflight-001', 'preflight-002'].map((id) => {
  const dir = path.join(root, 'test-results', 'hw06', id);
  const json = path.join(dir, 'preflight.json');
  const metadata = path.join(dir, 'execution-metadata.md');
  if (!fs.existsSync(json) || !fs.existsSync(metadata)) fail(`${id} is incomplete`);
  return {
    id,
    preserved: true,
    preflight_json_sha256: sha256(json),
    execution_metadata_sha256: sha256(metadata),
  };
});

const timestamp = new Date().toISOString();
const preflight = {
  preflight_id: 'preflight-003',
  timestamp,
  status: 'PASS',
  previous_preflights: prior,
  student_id: { status: 'READY_NON_EMPTY', value_logged: false },
  credentials: {
    normal_user: 'READY',
    second_user: 'READY_TO_REGISTER_VIA_DOCUMENTED_ENDPOINT',
    admin: 'READY',
    reset_user: 'READY_TO_REGISTER_VIA_DOCUMENTED_ENDPOINT',
    secrets_logged: false,
  },
  runtime_environment: {
    status: 'READY',
    path: 'test-results/hw06/runtime/HW06-Local.runtime.postman_environment.json',
    intended_for_commit: false,
    mandatory_values_non_empty: true,
  },
  tooling: {
    newman: newmanVersion,
    executable: '.tools/newman/node_modules/.bin/newman.cmd',
    html_reporter: `newman-reporter-htmlextra ${reporterVersion}`,
    install_action_performed: false,
  },
  postman_guard: {
    testcase_identities: caseRequests.length,
    total_requests: requests.length,
    x_student_id_static_coverage: `${requests.length}/${requests.length}`,
    missing_or_invalid: headerFailures,
    runtime_student_id_resolves_non_empty: true,
  },
  sut: {
    startup_strategy: 'READY',
    workdir: '../eshop-sut/backend',
    start_command: 'node server.js',
    base_url: 'http://localhost:3000',
    server_syntax: 'PASS',
    database: 'SAFE_LOCAL_TEST_DATABASE',
    database_type: 'SQLite',
    database_path: '../eshop-sut/backend/database.sqlite',
    database_sha256_before_start: sha256(databasePath),
  },
  real_requests_executed: 0,
};
writeJson(path.join(out, 'preflight.json'), preflight);

writeText(path.join(out, 'execution-metadata.md'), `# HW06 Real-Execution Preflight Metadata

- PREFLIGHT_ID: \`preflight-003\`
- TIMESTAMP_UTC: \`${timestamp}\`
- STATUS: \`PASS\`
- PREVIOUS_PREFLIGHTS: \`preflight-001 — PRESERVED\`; \`preflight-002 — PRESERVED\`
- STUDENT_ID: \`READY_NON_EMPTY\`
- STUDENT_ID_VALUE_LOGGED: \`NO\`
- NORMAL_USER: \`READY\`
- SECOND_USER: \`READY_TO_REGISTER_VIA_DOCUMENTED_ENDPOINT\`
- ADMIN: \`READY\`
- RESET_USER: \`READY_TO_REGISTER_VIA_DOCUMENTED_ENDPOINT\`
- RUNTIME_ENVIRONMENT: \`READY\`
- RUNTIME_ENVIRONMENT_INTENDED_FOR_COMMIT: \`NO\`
- NEWMAN_VERSION: \`${newmanVersion}\`
- HTML_REPORTER: \`newman-reporter-htmlextra ${reporterVersion}\`
- SUT_STARTUP_STRATEGY: \`READY\`
- SUT_WORKDIR: \`../eshop-sut/backend\`
- SUT_START_COMMAND: \`node server.js\`
- BASE_URL: \`http://localhost:3000\`
- DATABASE: \`SQLite — SAFE_LOCAL_TEST_DATABASE\`
- DATABASE_PATH: \`../eshop-sut/backend/database.sqlite\`
- POSTMAN_TESTCASE_IDENTITIES: \`${caseRequests.length}\`
- POSTMAN_TOTAL_REQUESTS: \`${requests.length}\`
- X_STUDENT_ID_STATIC_COVERAGE: \`${requests.length}/${requests.length}\`
- RUNTIME_STUDENT_ID_GUARD: \`PASS_NON_EMPTY\`
- REAL_REQUESTS_EXECUTED: \`0\`

No credential, token, or Student ID value is recorded in this metadata.`);

const byName = new Map(requests.map(({ item }) => [item.name, item]));
function clone(name) {
  if (!byName.has(name)) fail(`Smoke source request not found: ${name}`);
  return JSON.parse(JSON.stringify(byName.get(name)));
}
function registration(name, emailVariable, passwordVariable) {
  return {
    name,
    request: {
      method: 'POST',
      header: [
        { key: 'Content-Type', value: 'application/json', type: 'text' },
        { key: 'X-Student-Id', value: '{{studentId}}', type: 'text' },
      ],
      auth: { type: 'noauth' },
      body: {
        mode: 'raw',
        raw: `{\n  "name": "HW06 disposable {{testRunId}}",\n  "email": "{{${emailVariable}}}",\n  "password": "{{${passwordVariable}}}"\n}`,
        options: { raw: { language: 'json' } },
      },
      url: { raw: '{{baseUrl}}/api/register', host: ['{{baseUrl}}'], path: ['api', 'register'] },
      description: 'Runtime-only documented fixture registration helper; not a final testcase identity.',
    },
    event: [{
      listen: 'test',
      script: { type: 'text/javascript', exec: ["pm.test('Disposable fixture registration succeeds', () => pm.response.to.have.status(200));"] },
    }],
  };
}

const smoke = {
  info: {
    _postman_id: crypto.randomUUID(),
    name: 'HW06 Real Smoke 001',
    description: 'Runtime-only smoke derived from the approved 93-case collection. Includes documented fixture registration and one stable testcase identity per API.',
    schema: collection.info.schema,
  },
  event: collection.event,
  item: [
    { name: 'Runtime Fixture Bootstrap', item: [
      registration('[SMOKE-SETUP-001] Register reset user', 'resetEmail', 'resetUserPassword'),
      registration('[SMOKE-SETUP-002] Register second user', 'otherUserEmail', 'otherUserPassword'),
    ] },
    { name: 'API-01 Reset Password Smoke', item: [
      clone('[SETUP-API01-001] Issue reset OTP'),
      clone('[API01-AI-014] Luồng issued đến reset thành công'),
    ] },
    { name: 'API-02 Checkout Smoke', item: [
      clone('[SETUP-API02-001] Login primary user'),
      clone('[SETUP-API02-003] Prepare primary cart'),
      clone('[SETUP-API02-005] Capture primary cart'),
      clone('[API02-AI-001] Checkout hợp lệ với cart có hàng'),
    ] },
    { name: 'API-03 Import Products Smoke', item: [
      clone('[SETUP-API03-001] Login admin'),
      clone('[SETUP-API03-003] Capture product baseline'),
      clone('[API03-AI-001] Admin import một product hợp lệ'),
    ] },
  ],
};
writeJson(path.join(smokeOut, 'smoke.postman_collection.json'), smoke);

console.log(JSON.stringify({
  status: 'PASS',
  preflight: 'preflight-003',
  newman: newmanVersion,
  reporter: reporterVersion,
  requests: requests.length,
  testcase_identities: caseRequests.length,
  x_student_id: `${requests.length}/${requests.length}`,
  student_id_value_logged: false,
  smoke_requests: smoke.item.flatMap((folder) => folder.item).length,
  smoke_case_identities: 3,
}, null, 2));
