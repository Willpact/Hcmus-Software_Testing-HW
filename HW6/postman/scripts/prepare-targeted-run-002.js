#!/usr/bin/env node

const crypto = require('crypto');
const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..', '..');
const sutRoot = path.resolve(root, '..', 'eshop-sut');
const out = path.join(root, 'test-results', 'hw06', 'run-002');
const smokeOut = path.join(root, 'test-results', 'hw06', 'smoke-rerun-001');
const sourceCollectionPath = path.join(root, 'postman', 'collections', 'HW06-API-Testing.postman_collection.json');
const sourceEnvironmentPath = path.join(root, 'test-results', 'hw06', 'runtime', 'HW06-Local.runtime.postman_environment.json');

const targetIds = [
  'API01-AI-002', 'API01-AI-007', 'API01-AI-009', 'API01-AI-010', 'API01-AI-012',
  'API01-AI-014', 'API01-AI-016', 'API01-AI-018', 'API01-AI-019', 'API01-AI-021',
  'API01-AI-022', 'API01-AI-023', 'API01-AI-024', 'API01-AI-027', 'API01-AI-029',
  'API01-AI-035', 'API01-STU-001', 'API01-STU-002', 'API01-STU-003', 'API01-STU-004',
  'API01-STU-005',
  'API02-AI-001', 'API02-AI-009', 'API02-AI-016', 'API02-AI-018', 'API02-AI-024',
  'API02-AI-034', 'API02-AI-035', 'API02-STU-001', 'API02-STU-002', 'API02-STU-003',
  'API02-STU-005', 'API02-STU-006',
  'API03-AI-016', 'API03-AI-025', 'API03-STU-004', 'API03-STU-006',
];

function readJson(file) {
  return JSON.parse(fs.readFileSync(file, 'utf8').replace(/^\uFEFF/, ''));
}

function writeJson(file, value) {
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, `${JSON.stringify(value, null, 2)}\n`, 'utf8');
}

function fail(message) {
  throw new Error(message);
}

function key(id) {
  return id.replace(/-/g, '_');
}

function email(id, suffix = 'a') {
  return `hw06-{{testRunId}}-${id.toLowerCase().replace(/_/g, '-')}-${suffix}@example.test`;
}

function headers(withBody = true) {
  const result = [{ key: 'X-Student-Id', value: '{{studentId}}', type: 'text' }];
  if (withBody) result.unshift({ key: 'Content-Type', value: 'application/json', type: 'text' });
  return result;
}

function auth(type, token) {
  if (type === 'bearer') {
    return { type: 'bearer', bearer: [{ key: 'token', value: token, type: 'string' }] };
  }
  if (type === 'raw') return { type: 'noauth' };
  return { type: 'noauth' };
}

function makeRequest(name, method, endpoint, options = {}) {
  const body = options.rawBody ?? (options.body === undefined ? undefined : JSON.stringify(options.body, null, 2));
  const requestHeaders = headers(body !== undefined);
  if (options.rawAuthorization) {
    requestHeaders.push({ key: 'Authorization', value: options.rawAuthorization, type: 'text' });
  }
  const item = {
    name,
    request: {
      method,
      header: requestHeaders,
      auth: options.rawAuthorization ? { type: 'noauth' } : auth(options.authType || 'noauth', options.token),
      url: { raw: `{{baseUrl}}${endpoint}`, host: ['{{baseUrl}}'], path: endpoint.split('/').filter(Boolean) },
      description: options.description || 'Targeted run-002 fixture/action request.',
    },
  };
  if (body !== undefined) {
    item.request.body = { mode: 'raw', raw: body, options: { raw: { language: 'json' } } };
  }
  const prerequest = options.prerequest || [];
  const tests = options.tests || [];
  item.event = [];
  if (prerequest.length) item.event.push({ listen: 'prerequest', script: { type: 'text/javascript', exec: prerequest } });
  if (tests.length) item.event.push({ listen: 'test', script: { type: 'text/javascript', exec: tests } });
  return item;
}

function commonCaseTests(id) {
  const k = key(id);
  return [
    `const caseId = ${JSON.stringify(id)};`,
    "const resolvedStudentId = pm.variables.replaceIn('{{studentId}}');",
    "pm.test(`[${caseId}] studentId is configured`, () => {",
    "  pm.expect(resolvedStudentId).to.not.equal('{{studentId}}');",
    '  pm.expect(resolvedStudentId).to.not.be.empty;',
    '});',
    `pm.environment.set('run002_${k}_status', String(pm.response.code));`,
    `pm.environment.set('run002_${k}_body', pm.response.text());`,
  ];
}

function helperCapture(label, extra = []) {
  return [
    `pm.environment.set(${JSON.stringify(`${label}_status`)}, String(pm.response.code));`,
    `pm.environment.set(${JSON.stringify(`${label}_body`)}, pm.response.text());`,
    ...extra,
  ];
}

function register(name, userEmail, idVariable) {
  const extra = idVariable ? [
    'let payload = {}; try { payload = pm.response.json(); } catch (e) {}',
    `if (payload.id !== undefined) pm.environment.set(${JSON.stringify(idVariable)}, String(payload.id));`,
  ] : [];
  return makeRequest(name, 'POST', '/api/register', {
    body: { name: 'HW06 run-002 disposable', email: userEmail, password: '{{fixtureOldPassword}}' },
    tests: ["pm.test('Disposable registration succeeds', () => pm.response.to.have.status(200));", ...extra],
  });
}

function issue(name, userEmail, tokenVariable) {
  return makeRequest(name, 'POST', '/api/forgot-password', {
    body: { email: userEmail },
    tests: [
      "pm.test('Fresh OTP fixture is issued', () => pm.response.to.have.status(200));",
      'const payload = pm.response.json();',
      "pm.test('Issued OTP is present', () => pm.expect(String(payload.resetToken || '')).to.not.be.empty);",
      `pm.environment.set(${JSON.stringify(tokenVariable)}, String(payload.resetToken));`,
    ],
  });
}

function reset(name, userEmail, token, newPassword, options = {}) {
  const id = options.caseId;
  const label = options.label || key(id || name);
  const body = { email: userEmail, resetToken: token };
  if (!options.omitPassword) body.newPassword = newPassword;
  return makeRequest(name, 'POST', '/api/reset-password', {
    body,
    tests: id ? commonCaseTests(id) : helperCapture(label),
  });
}

function login(name, userEmail, password, tokenVariable, label) {
  const extra = [
    'let payload = {}; try { payload = pm.response.json(); } catch (e) {}',
    `if (payload.token) pm.environment.set(${JSON.stringify(tokenVariable)}, payload.token);`,
  ];
  return makeRequest(name, 'POST', '/api/login', {
    body: { email: userEmail, password },
    tests: helperCapture(label || tokenVariable, extra),
  });
}

function api01Folder(id, items) {
  return { name: `${id} corrected isolated fixture`, item: items };
}

function buildApi01() {
  const folders = [];
  const simple = {
    'API01-AI-009': 'Ab1!xyz',
    'API01-AI-010': 'Abcde1!x',
    'API01-AI-012': '{{fixtureNewPassword}}',
    'API01-AI-014': '{{fixtureNewPassword}}',
    'API01-AI-018': '{{fixtureWeakPassword}}',
    'API01-AI-021': 'abcdef1!',
    'API01-AI-022': 'ABCDEF1!',
    'API01-AI-023': 'Abcdefg!',
    'API01-AI-024': 'Abcdef12',
    'API01-AI-029': '{{fixtureNewPassword}}',
    'API01-AI-035': '{{fixtureNewPassword}}',
  };
  for (const [id, password] of Object.entries(simple)) {
    const mail = email(id);
    const token = `token_${key(id)}`;
    folders.push(api01Folder(id, [
      register(`[FIXTURE-${id}-01] Register isolated user`, mail),
      issue(`[FIXTURE-${id}-02] Issue fresh OTP`, mail, token),
      reset(`[${id}] Corrected isolated execution`, mail, `{{${token}}}`, password, { caseId: id }),
    ]));
  }

  {
    const id = 'API01-AI-002'; const a = email(id, 'a'); const b = email(id, 'b'); const token = `token_${key(id)}_a`;
    folders.push(api01Folder(id, [register(`[FIXTURE-${id}-01] Register A`, a), register(`[FIXTURE-${id}-02] Register B`, b), issue(`[FIXTURE-${id}-03] Issue OTP A`, a, token), reset(`[${id}] Cross-email attempt`, b, `{{${token}}}`, '{{fixtureNewPassword}}', { caseId: id }), reset(`[VERIFY-${id}-01] Rightful A retry`, a, `{{${token}}}`, '{{fixtureNewPassword}}', { label: `verify_${key(id)}_rightful` })]));
  }
  {
    const id = 'API01-AI-007'; const mail = email(id); const token = `token_${key(id)}`;
    folders.push(api01Folder(id, [register(`[FIXTURE-${id}-01] Register user`, mail), issue(`[FIXTURE-${id}-02] Issue OTP`, mail, token), reset(`[${id}] Missing newPassword`, mail, `{{${token}}}`, undefined, { caseId: id, omitPassword: true }), reset(`[VERIFY-${id}-01] Rightful retry`, mail, `{{${token}}}`, '{{fixtureNewPassword}}', { label: `verify_${key(id)}_rightful` })]));
  }
  {
    const id = 'API01-AI-016';
    folders.push(api01Folder(id, [makeRequest(`[${id}] Expired OTP fixture unavailable`, 'POST', '/api/reset-password', { body: { email: email(id), resetToken: '{{expiredResetToken}}', newPassword: '{{fixtureNewPassword}}' }, prerequest: ["pm.environment.set('run002_API01_AI_016_skip_reason', 'LEGITIMATE_EXPIRED_OTP_STATE_UNAVAILABLE');", 'pm.execution.skipRequest();'], tests: commonCaseTests(id), description: 'Intentionally skipped: SUT exposes no approved mechanism to create a genuinely expired OTP state.' })]));
  }
  {
    const id = 'API01-AI-019'; const mail = email(id); const token = `token_${key(id)}`;
    folders.push(api01Folder(id, [register(`[FIXTURE-${id}-01] Register user`, mail), issue(`[FIXTURE-${id}-02] Issue OTP`, mail, token), reset(`[${id}] Wrong-token attempt`, mail, '{{wrongResetToken}}', '{{fixtureNewPassword}}', { caseId: id }), reset(`[VERIFY-${id}-01] Correct-token recovery`, mail, `{{${token}}}`, '{{fixtureNewPassword}}', { label: `verify_${key(id)}_rightful` })]));
  }
  {
    const id = 'API01-AI-027';
    folders.push(api01Folder(id, [reset(`[${id}] Injection-like email`, "x' OR '1'='1@example.test", '000000', '{{fixtureNewPassword}}', { caseId: id })]));
  }
  {
    const id = 'API01-STU-001'; const a = email(id, 'a'); const b = email(id, 'b'); const token = `token_${key(id)}_a`;
    folders.push(api01Folder(id, [register(`[FIXTURE-${id}-01] Register A`, a), register(`[FIXTURE-${id}-02] Register B`, b), issue(`[FIXTURE-${id}-03] Issue OTP A`, a, token), reset(`[STEP-${id}-01] Cross-email failure`, b, `{{${token}}}`, '{{fixtureNewPassword}}', { label: `step_${key(id)}_invalid` }), reset(`[${id}] Rightful token use`, a, `{{${token}}}`, '{{fixtureNewPassword}}', { caseId: id })]));
  }
  {
    const id = 'API01-STU-002'; const mail = email(id); const token = `token_${key(id)}`;
    folders.push(api01Folder(id, [register(`[FIXTURE-${id}-01] Register user`, mail), issue(`[FIXTURE-${id}-02] Issue OTP`, mail, token), reset(`[STEP-${id}-01] Weak-password attempt`, mail, `{{${token}}}`, '{{fixtureWeakPassword}}', { label: `step_${key(id)}_weak` }), reset(`[${id}] Strong retry with same OTP`, mail, `{{${token}}}`, '{{fixtureNewPassword}}', { caseId: id })]));
  }
  {
    const id = 'API01-STU-003'; const mail = email(id); const token = `token_${key(id)}`;
    folders.push(api01Folder(id, [register(`[FIXTURE-${id}-01] Register user`, mail), issue(`[FIXTURE-${id}-02] Issue OTP`, mail, token), reset(`[STEP-${id}-01] Wrong-token attempt`, mail, '{{wrongResetToken}}', '{{fixtureNewPassword}}', { label: `step_${key(id)}_wrong` }), reset(`[${id}] Correct-token recovery`, mail, `{{${token}}}`, '{{fixtureNewPassword}}', { caseId: id })]));
  }
  {
    const id = 'API01-STU-004'; const a = email(id, 'a'); const b = email(id, 'b'); const ta = `token_${key(id)}_a`; const tb = `token_${key(id)}_b`;
    folders.push(api01Folder(id, [register(`[FIXTURE-${id}-01] Register A`, a), register(`[FIXTURE-${id}-02] Register B`, b), issue(`[FIXTURE-${id}-03] Issue OTP A`, a, ta), issue(`[FIXTURE-${id}-04] Issue OTP B`, b, tb), reset(`[STEP-${id}-01] Reset A`, a, `{{${ta}}}`, '{{fixtureNewPassword}}', { label: `step_${key(id)}_a` }), reset(`[${id}] Reset B independently`, b, `{{${tb}}}`, '{{fixtureNewPassword}}', { caseId: id })]));
  }
  {
    const id = 'API01-STU-005'; const a = email(id, 'a'); const b = email(id, 'b'); const ta = `token_${key(id)}_a`; const tb = `token_${key(id)}_b`;
    folders.push(api01Folder(id, [register(`[FIXTURE-${id}-01] Register A`, a), register(`[FIXTURE-${id}-02] Register B`, b), issue(`[FIXTURE-${id}-03] Issue OTP A`, a, ta), issue(`[FIXTURE-${id}-04] Issue OTP B`, b, tb), reset(`[STEP-${id}-01] Initial reset A`, a, `{{${ta}}}`, '{{fixtureNewPassword}}', { label: `step_${key(id)}_a_success` }), reset(`[STEP-${id}-02] Replay A`, a, `{{${ta}}}`, '{{fixtureNewPassword}}', { label: `step_${key(id)}_a_replay` }), reset(`[${id}] Legitimate reset B`, b, `{{${tb}}}`, '{{fixtureNewPassword}}', { caseId: id })]));
  }
  const order = targetIds.filter((id) => id.startsWith('API01-'));
  return order.map((id) => folders.find((folder) => folder.name.startsWith(id)) || fail(`Missing API-01 folder ${id}`));
}

function cartAdd(name, token, price, quantity) {
  return makeRequest(name, 'POST', '/api/cart', { authType: 'bearer', token, body: { id: '{{productId}}', name: 'HW06 run-002 item', price, quantity } });
}

function cartCapture(name, token, variable) {
  return makeRequest(name, 'GET', '/api/cart', { authType: 'bearer', token, tests: [
    'let cart = []; try { cart = pm.response.json(); } catch (e) {}',
    `pm.environment.set(${JSON.stringify(variable)}, JSON.stringify(cart));`,
    `pm.environment.set(${JSON.stringify(`${variable}_total`)}, String(cart.reduce((sum, row) => sum + Number(row.price || 0) * Number(row.quantity || 0), 0)));`,
  ] });
}

function checkout(name, token, rawBody, options = {}) {
  return makeRequest(name, 'POST', '/api/checkout', { authType: options.noauth ? 'noauth' : 'bearer', token, rawAuthorization: options.rawAuthorization, rawBody, tests: options.caseId ? commonCaseTests(options.caseId) : helperCapture(options.label || key(name)) });
}

function api02Base(id, twoUsers = false) {
  const a = email(id, 'a'); const b = email(id, 'b');
  const items = [register(`[FIXTURE-${id}-01] Register A`, a, `userId_${key(id)}_a`), login(`[FIXTURE-${id}-02] Login A`, a, '{{fixtureOldPassword}}', `userToken_${key(id)}_a`, `login_${key(id)}_a`)];
  if (twoUsers) items.push(register(`[FIXTURE-${id}-03] Register B`, b, `userId_${key(id)}_b`), login(`[FIXTURE-${id}-04] Login B`, b, '{{fixtureOldPassword}}', `userToken_${key(id)}_b`, `login_${key(id)}_b`));
  return { a, b, ta: `{{userToken_${key(id)}_a}}`, tb: `{{userToken_${key(id)}_b}}`, items };
}

function buildApi02() {
  const folders = [];
  for (const id of targetIds.filter((x) => x.startsWith('API02-'))) {
    const two = ['API02-STU-002', 'API02-STU-005', 'API02-STU-006'].includes(id);
    const ctx = api02Base(id, two); const k = key(id); const items = ctx.items;
    if (id === 'API02-AI-001' || id === 'API02-AI-034') {
      items.push(cartAdd(`[FIXTURE-${id}-05] Add cart line`, ctx.ta, 100000, 2), cartCapture(`[FIXTURE-${id}-06] Capture cart before`, ctx.ta, `cart_${k}_before`), checkout(`[${id}] Corrected checkout`, ctx.ta, '{\n  "total_amount": 200000,\n  "shipping_address": "{{shippingAddress}}"\n}', { caseId: id }), cartCapture(`[VERIFY-${id}-01] Capture cart after`, ctx.ta, `cart_${k}_after`));
    } else if (id === 'API02-AI-009') {
      items.push(cartAdd(`[FIXTURE-${id}-05] Add exactly one cart line`, ctx.ta, 12345, 2), cartCapture(`[FIXTURE-${id}-06] Capture one-line cart`, ctx.ta, `cart_${k}_before`), checkout(`[${id}] One-line cart checkout`, ctx.ta, '{\n  "total_amount": 24690,\n  "shipping_address": "{{shippingAddress}}"\n}', { caseId: id }), cartCapture(`[VERIFY-${id}-01] Capture cart after`, ctx.ta, `cart_${k}_after`));
    } else if (id === 'API02-AI-016') {
      items.push(cartAdd(`[FIXTURE-${id}-05] Add old cart line`, ctx.ta, 100000, 1), cartCapture(`[FIXTURE-${id}-06] Capture old cart`, ctx.ta, `cart_${k}_old`), cartAdd(`[FIXTURE-${id}-07] Mutate cart`, ctx.ta, 50000, 2), cartCapture(`[FIXTURE-${id}-08] Capture current cart`, ctx.ta, `cart_${k}_before`), checkout(`[${id}] Checkout with stale total`, ctx.ta, '{\n  "total_amount": 100000,\n  "shipping_address": "{{shippingAddress}}"\n}', { caseId: id }), cartCapture(`[VERIFY-${id}-01] Capture cart after`, ctx.ta, `cart_${k}_after`));
    } else if (id === 'API02-AI-018') {
      items.push(cartAdd(`[FIXTURE-${id}-05] Add cart line`, ctx.ta, 100000, 2), cartCapture(`[FIXTURE-${id}-06] Capture cart before`, ctx.ta, `cart_${k}_before`), checkout(`[${id}] Missing Authorization`, '', '{\n  "total_amount": 200000,\n  "shipping_address": "{{shippingAddress}}"\n}', { caseId: id, noauth: true }), cartCapture(`[VERIFY-${id}-01] Capture cart after`, ctx.ta, `cart_${k}_after`));
    } else if (id === 'API02-AI-024') {
      items.push(cartAdd(`[FIXTURE-${id}-05] Add cart line`, ctx.ta, 100000, 2), cartCapture(`[FIXTURE-${id}-06] Capture cart before`, ctx.ta, `cart_${k}_before`), checkout(`[${id}] Expired Bearer JWT`, '{{expiredUserToken}}', '{\n  "total_amount": 200000,\n  "shipping_address": "{{shippingAddress}}"\n}', { caseId: id }), cartCapture(`[VERIFY-${id}-01] Capture cart after`, ctx.ta, `cart_${k}_after`));
    } else if (id === 'API02-AI-035') {
      items.push(cartAdd(`[FIXTURE-${id}-05] Add cart line`, ctx.ta, 100000, 2), cartCapture(`[FIXTURE-${id}-06] Capture cart before`, ctx.ta, `cart_${k}_before`), checkout(`[${id}] Decimal mismatch checkout`, ctx.ta, '{\n  "total_amount": 200000.01,\n  "shipping_address": "{{shippingAddress}}"\n}', { caseId: id }), cartCapture(`[VERIFY-${id}-01] Capture cart after`, ctx.ta, `cart_${k}_after`));
    } else if (id === 'API02-STU-001') {
      items.push(cartAdd(`[FIXTURE-${id}-05] Add cart line`, ctx.ta, 100000, 2), cartCapture(`[FIXTURE-${id}-06] Cart before invalid attempt`, ctx.ta, `cart_${k}_before`), checkout(`[STEP-${id}-01] Invalid JWT attempt`, '', '{\n  "total_amount": 1,\n  "shipping_address": "tampered"\n}', { rawAuthorization: 'Bearer invalid.jwt.fixture', label: `step_${k}_invalid` }), cartCapture(`[VERIFY-${id}-01] Cart after invalid attempt`, ctx.ta, `cart_${k}_after_invalid`), checkout(`[${id}] Authorized recovery`, ctx.ta, '{\n  "total_amount": 200000,\n  "shipping_address": "{{shippingAddress}}"\n}', { caseId: id }), cartCapture(`[VERIFY-${id}-02] Cart after authorized checkout`, ctx.ta, `cart_${k}_after`));
    } else if (id === 'API02-STU-002') {
      items.push(cartAdd(`[FIXTURE-${id}-05] Add A cart`, ctx.ta, 100000, 2), cartAdd(`[FIXTURE-${id}-06] Add B cart`, ctx.tb, 50000, 1), cartCapture(`[FIXTURE-${id}-07] Capture A cart`, ctx.ta, `cart_${k}_before_a`), cartCapture(`[FIXTURE-${id}-08] Capture B cart`, ctx.tb, `cart_${k}_before_b`), checkout(`[${id}] Spoof B identity and total under JWT A`, ctx.ta, '{\n  "total_amount": 50000,\n  "shipping_address": "{{shippingAddress}}",\n  "user_id": "{{userId_API02_STU_002_b}}"\n}', { caseId: id }), cartCapture(`[VERIFY-${id}-01] Capture A cart after`, ctx.ta, `cart_${k}_after_a`), cartCapture(`[VERIFY-${id}-02] Capture B cart after`, ctx.tb, `cart_${k}_after_b`));
    } else if (id === 'API02-STU-003') {
      items.push(cartAdd(`[FIXTURE-${id}-05] Add cart line`, ctx.ta, 100000, 2), cartCapture(`[FIXTURE-${id}-06] Capture cart before`, ctx.ta, `cart_${k}_before`), checkout(`[${id}] Simultaneous total and address injection-like values`, ctx.ta, '{\n  "total_amount": "0; DROP TABLE orders; --",\n  "shipping_address": "\u0027; DROP TABLE users; --"\n}', { caseId: id }), cartCapture(`[VERIFY-${id}-01] Capture cart after`, ctx.ta, `cart_${k}_after`));
    } else if (id === 'API02-STU-005') {
      items.push(cartAdd(`[FIXTURE-${id}-05] Add A cart`, ctx.ta, 100000, 2), cartAdd(`[FIXTURE-${id}-06] Add B cart`, ctx.tb, 50000, 1), cartCapture(`[FIXTURE-${id}-07] Capture A before`, ctx.ta, `cart_${k}_before_a`), cartCapture(`[FIXTURE-${id}-08] Capture B before`, ctx.tb, `cart_${k}_before_b`), checkout(`[STEP-${id}-01] A checkout with B total`, ctx.ta, '{\n  "total_amount": 50000,\n  "shipping_address": "{{shippingAddress}}"\n}', { label: `step_${k}_a` }), cartCapture(`[VERIFY-${id}-01] Capture A mid`, ctx.ta, `cart_${k}_mid_a`), checkout(`[${id}] B checkout with A total`, ctx.tb, '{\n  "total_amount": 200000,\n  "shipping_address": "{{shippingAddress}}"\n}', { caseId: id }), cartCapture(`[VERIFY-${id}-02] Capture A after`, ctx.ta, `cart_${k}_after_a`), cartCapture(`[VERIFY-${id}-03] Capture B after`, ctx.tb, `cart_${k}_after_b`));
    } else if (id === 'API02-STU-006') {
      items.push(cartAdd(`[FIXTURE-${id}-05] Add A old cart line`, ctx.ta, 50000, 1), cartAdd(`[FIXTURE-${id}-06] Add B cart matching stale total`, ctx.tb, 50000, 1), cartCapture(`[FIXTURE-${id}-07] Capture A old`, ctx.ta, `cart_${k}_old_a`), cartCapture(`[FIXTURE-${id}-08] Capture B`, ctx.tb, `cart_${k}_before_b`), cartAdd(`[FIXTURE-${id}-09] Mutate A cart`, ctx.ta, 150000, 1), cartCapture(`[FIXTURE-${id}-10] Capture A current`, ctx.ta, `cart_${k}_before_a`), checkout(`[${id}] Stale cross-user collision`, ctx.ta, '{\n  "total_amount": 50000,\n  "shipping_address": "{{shippingAddress}}",\n  "user_id": "{{userId_API02_STU_006_b}}"\n}', { caseId: id }), cartCapture(`[VERIFY-${id}-01] Capture A after`, ctx.ta, `cart_${k}_after_a`), cartCapture(`[VERIFY-${id}-02] Capture B after`, ctx.tb, `cart_${k}_after_b`));
    } else fail(`Unhandled API-02 target ${id}`);
    folders.push({ name: `${id} corrected isolated fixture`, item: items });
  }
  return folders;
}

function product(name, price) {
  return { name, price, description: 'HW06 run-002 disposable', imageUrl: '', category_id: '{{categoryId}}' };
}

function importRequest(name, token, products, options = {}) {
  const raw = JSON.stringify({ products }, null, 2).replace(/"\{\{categoryId\}\}"/g, '{{categoryId}}');
  return makeRequest(name, 'POST', '/api/admin/import-products', { authType: 'bearer', token, rawBody: raw, tests: options.caseId ? commonCaseTests(options.caseId) : helperCapture(options.label || key(name)) });
}

function buildApi03() {
  const folders = [];
  for (const id of targetIds.filter((x) => x.startsWith('API03-'))) {
    const k = key(id); const items = [];
    items.push(login(`[FIXTURE-${id}-01] Login admin`, '{{adminEmail}}', '{{adminPassword}}', `adminToken_${k}`, `login_${k}_admin`));
    if (id === 'API03-AI-016') {
      items.push(importRequest(`[${id}] Valid two-product batch`, `{{adminToken_${k}}}`, [product(`HW06-{{testRunId}}-${id}-A`, 10000), product(`HW06-{{testRunId}}-${id}-B`, 20000)], { caseId: id }));
    } else if (id === 'API03-AI-025') {
      items.push(importRequest(`[${id}] Expired JWT import`, '{{expiredUserToken}}', [product(`HW06-{{testRunId}}-${id}-A`, 10000)], { caseId: id }));
    } else if (id === 'API03-STU-004') {
      items.push(importRequest(`[STEP-${id}-01] Valid batch A`, `{{adminToken_${k}}}`, [product(`HW06-{{testRunId}}-${id}-A1`, 10000), product(`HW06-{{testRunId}}-${id}-A2`, 20000)], { label: `step_${k}_batch_a` }), importRequest(`[${id}] Later invalid batch B`, `{{adminToken_${k}}}`, [product(`HW06-{{testRunId}}-${id}-B1`, 10000), product(`HW06-{{testRunId}}-${id}-B2`, -1)], { caseId: id }));
    } else if (id === 'API03-STU-006') {
      items.push(login(`[FIXTURE-${id}-02] Login non-admin`, '{{userEmail}}', '{{userPassword}}', `userToken_${k}`, `login_${k}_user`), importRequest(`[STEP-${id}-01] Admin batch A`, `{{adminToken_${k}}}`, [product(`HW06-{{testRunId}}-${id}-A1`, 10000), product(`HW06-{{testRunId}}-${id}-A2`, 20000)], { label: `step_${k}_batch_a` }), importRequest(`[${id}] Non-admin mixed batch B`, `{{userToken_${k}}}`, [product(`HW06-{{testRunId}}-${id}-B1`, 10000), product(`HW06-{{testRunId}}-${id}-B2`, -1)], { caseId: id }));
    } else fail(`Unhandled API-03 target ${id}`);
    folders.push({ name: `${id} corrected isolated fixture`, item: items });
  }
  return folders;
}

const unique = new Set(targetIds);
if (targetIds.length !== 37 || unique.size !== 37) fail(`Target ID guard failed: ${targetIds.length}/${unique.size}`);

const sourceCollection = readJson(sourceCollectionPath);
const collection = {
  info: {
    _postman_id: crypto.randomUUID(),
    name: 'HW06 Targeted Corrective Rerun run-002',
    description: 'Derived non-destructively from Human-approved stable IDs. Contains only oracle-preserving test/harness/data corrections and one intentionally skipped case whose legitimate expired-OTP fixture is unavailable.',
    schema: sourceCollection.info.schema,
  },
  event: [{ listen: 'prerequest', script: { type: 'text/javascript', exec: ["if (!pm.environment.get('testRunId')) pm.environment.set('testRunId', String(Date.now()));"] } }],
  item: [
    { name: 'API-01 Targeted Rerun', item: buildApi01() },
    { name: 'API-02 Targeted Rerun', item: buildApi02() },
    { name: 'API-03 Targeted Rerun', item: buildApi03() },
  ],
};

const stableNames = [];
const allRequests = [];
(function walk(items) {
  for (const item of items || []) {
    if (item.request) {
      allRequests.push(item);
      const match = item.name.match(/^\[(API0[123]-(?:AI|STU)-\d{3})\]/);
      if (match) stableNames.push(match[1]);
      const studentHeaders = (item.request.header || []).filter((h) => String(h.key).toLowerCase() === 'x-student-id');
      if (studentHeaders.length !== 1 || studentHeaders[0].value !== '{{studentId}}') fail(`X-Student-Id guard failed: ${item.name}`);
    }
    walk(item.item);
  }
})(collection.item);
if (stableNames.length !== 37 || new Set(stableNames).size !== 37) fail(`Collection stable-ID guard failed: ${stableNames.length}/${new Set(stableNames).size}`);
for (const id of targetIds) if (!stableNames.includes(id)) fail(`Target ID missing from collection: ${id}`);

const environment = readJson(sourceEnvironmentPath);
const values = new Map(environment.values.map((entry) => [entry.key, entry]));
const setEnv = (name, value) => {
  if (values.has(name)) values.get(name).value = value;
  else { const entry = { key: name, value, type: 'default', enabled: true }; environment.values.push(entry); values.set(name, entry); }
};
setEnv('testRunId', new Date().toISOString().replace(/[-:.TZ]/g, ''));
setEnv('fixtureOldPassword', 'Run002Old1!');
setEnv('fixtureNewPassword', 'Run002New1!');
setEnv('fixtureWeakPassword', 'weak');

const serverSource = fs.readFileSync(path.join(sutRoot, 'backend', 'server.js'), 'utf8');
const secretMatch = serverSource.match(/const\s+SECRET_KEY\s*=\s*["']([^"']+)["']/);
if (!secretMatch) fail('Unable to locate existing SUT JWT test secret mechanism');
const jwt = require(path.join(sutRoot, 'backend', 'node_modules', 'jsonwebtoken'));
setEnv('expiredUserToken', jwt.sign({ id: 2, role: 'user', exp: Math.floor(Date.now() / 1000) - 60 }, secretMatch[1]));
setEnv('expiredResetToken', '');

fs.mkdirSync(out, { recursive: true });
writeJson(path.join(out, 'targeted-collection.json'), collection);
writeJson(path.join(out, 'runtime-input.postman_environment.json'), environment);
fs.writeFileSync(path.join(out, 'targeted-case-list.txt'), `${targetIds.join('\n')}\n`, 'utf8');
writeJson(path.join(out, 'targeted-scope-guard.json'), {
  status: 'PASS', expected: 37, listed: targetIds.length, unique: unique.size,
  collection_stable_ids: stableNames.length, total_collection_requests: allRequests.length,
  x_student_id_static_coverage: `${allRequests.length}/${allRequests.length}`,
  intentionally_skipped: ['API01-AI-016'], product_defect_cases_from_run_001_included: 0,
});

const smokeIds = ['API01-AI-010', 'API02-AI-018', 'API03-AI-016'];
function findCaseFolder(items, id) {
  for (const item of items || []) {
    if (item.name && item.name.startsWith(`${id} `) && Array.isArray(item.item)) return JSON.parse(JSON.stringify(item));
    const nested = findCaseFolder(item.item, id);
    if (nested) return nested;
  }
  return null;
}
const smokeCollection = {
  info: { ...collection.info, _postman_id: crypto.randomUUID(), name: 'HW06 Corrected Harness Smoke smoke-rerun-001' },
  event: collection.event,
  item: smokeIds.map((id) => findCaseFolder(collection.item, id) || fail(`Smoke case missing: ${id}`)),
};
const smokeEnvironment = JSON.parse(JSON.stringify(environment));
const smokeRunId = `SMOKE${new Date().toISOString().replace(/[-:.TZ]/g, '')}`;
const smokeEntry = smokeEnvironment.values.find((entry) => entry.key === 'testRunId');
smokeEntry.value = smokeRunId;
writeJson(path.join(smokeOut, 'smoke.postman_collection.json'), smokeCollection);
writeJson(path.join(smokeOut, 'runtime-input.postman_environment.json'), smokeEnvironment);
fs.writeFileSync(path.join(smokeOut, 'smoke-case-list.txt'), `${smokeIds.join('\n')}\n`, 'utf8');

console.log(JSON.stringify({ status: 'PASS', target_ids: targetIds.length, unique_ids: unique.size, collection_stable_ids: stableNames.length, total_requests: allRequests.length, x_student_id: `${allRequests.length}/${allRequests.length}`, intentionally_skipped: ['API01-AI-016'], smoke_case_ids: smokeIds.length, secrets_logged: false }, null, 2));
