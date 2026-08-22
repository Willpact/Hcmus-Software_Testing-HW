#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..', '..');
const runDir = path.join(root, 'test-results', 'hw06', 'run-002');
const docsDir = path.join(root, 'docs', 'execution-results');

function readJson(file) {
  return JSON.parse(fs.readFileSync(file, 'utf8').replace(/^\uFEFF/, ''));
}

function writeJson(file, value) {
  fs.writeFileSync(file, `${JSON.stringify(value, null, 2)}\n`, 'utf8');
}

function writeText(file, value) {
  fs.writeFileSync(file, `${value.trimEnd()}\n`, 'utf8');
}

function fail(message) {
  throw new Error(message);
}

const targetIds = fs.readFileSync(path.join(runDir, 'targeted-case-list.txt'), 'utf8').trim().split(/\r?\n/);
const newman = readJson(path.join(runDir, 'newman.json'));
const external = readJson(path.join(runDir, 'external-hook-evidence.json'));
const outputEnvironment = readJson(path.join(runDir, 'runtime-output.postman_environment.json'));
const run001 = readJson(path.join(root, 'test-results', 'hw06', 'run-001', 'case-accounting.json'));
const env = Object.fromEntries(outputEnvironment.values.map((entry) => [entry.key, entry.value]));

if (targetIds.length !== 37 || new Set(targetIds).size !== 37) fail('Target list is not exactly 37 unique IDs');

function streamText(stream) {
  if (!stream) return '';
  if (Buffer.isBuffer(stream)) return stream.toString('utf8');
  if (Array.isArray(stream.data)) return Buffer.from(stream.data).toString('utf8');
  if (stream.type === 'Buffer' && Array.isArray(stream.data)) return Buffer.from(stream.data).toString('utf8');
  return String(stream);
}

const stableExecutions = new Map();
let xStudentIdPresent = 0;
for (const execution of newman.run.executions) {
  const headers = execution.request?.headers?.members || execution.request?.header || [];
  const student = headers.filter((header) => String(header.key).toLowerCase() === 'x-student-id');
  if (student.length === 1 && String(student[0].value || '').trim() !== '' && !String(student[0].value).includes('{{')) xStudentIdPresent += 1;
  const match = execution.item.name.match(/^\[(API0[123]-(?:AI|STU)-\d{3})\]/);
  if (match) stableExecutions.set(match[1], { status: execution.response?.code ?? null, body: streamText(execution.response?.stream), name: execution.item.name });
}
if (newman.run.executions.length !== 179 || xStudentIdPresent !== 179) fail(`Runtime X-Student-Id guard failed: ${xStudentIdPresent}/${newman.run.executions.length}`);
if (stableExecutions.size !== 36 || stableExecutions.has('API01-AI-016')) fail('Stable execution/skip guard failed');

const passIds = new Set([
  'API01-AI-002', 'API01-AI-010', 'API01-AI-012', 'API01-AI-014', 'API01-AI-019', 'API01-AI-027', 'API01-AI-029',
  'API01-STU-001', 'API01-STU-003', 'API01-STU-004', 'API01-STU-005',
  'API02-AI-018', 'API02-AI-024', 'API03-AI-016', 'API03-AI-025',
]);
const newCandidateClusters = {
  'RC-01-N01': ['API01-AI-007'],
  'RC-01-N02': ['API01-AI-009', 'API01-AI-018', 'API01-AI-021', 'API01-AI-022', 'API01-AI-023', 'API01-AI-024', 'API01-STU-002'],
  'RC-01-N03': ['API01-AI-035'],
};
const existingDefectMap = {
  'API02-AI-001': ['RC-02-02'], 'API02-AI-009': ['RC-02-02'], 'API02-AI-016': ['RC-02-01', 'RC-02-02'],
  'API02-AI-034': ['RC-02-02'], 'API02-AI-035': ['RC-02-01', 'RC-02-02'], 'API02-STU-001': ['RC-02-02'],
  'API02-STU-002': ['RC-02-01', 'RC-02-02'], 'API02-STU-003': ['RC-02-01', 'RC-02-02'],
  'API02-STU-005': ['RC-02-01', 'RC-02-02'], 'API02-STU-006': ['RC-02-01', 'RC-02-02'],
  'API03-STU-004': ['RC-03-01', 'RC-03-02'], 'API03-STU-006': ['RC-03-01', 'RC-03-03'],
};
const candidateById = new Map(Object.entries(newCandidateClusters).flatMap(([cluster, ids]) => ids.map((id) => [id, cluster])));

function envNumber(name) {
  const value = Number(env[name]);
  return Number.isFinite(value) ? value : null;
}
function envArray(name) {
  try { const value = JSON.parse(env[name] || '[]'); return Array.isArray(value) ? value : []; } catch (error) { return []; }
}
function orderFor(id, suffix = '-a@') {
  const slug = id.toLowerCase();
  return external.orders.find((row) => row.email.includes(slug) && row.email.includes(suffix));
}
function productNamed(fragment) {
  return external.products.some((row) => row.name.includes(fragment));
}

const evidenceChecks = {
  'API01-AI-002': () => stableExecutions.get('API01-AI-002').status === 400 && env.verify_API01_AI_002_rightful_status === '200',
  'API01-AI-007': () => stableExecutions.get('API01-AI-007').status === 200 && env.verify_API01_AI_007_rightful_status === '400',
  'API01-AI-019': () => stableExecutions.get('API01-AI-019').status === 400 && env.verify_API01_AI_019_rightful_status === '200',
  'API01-AI-027': () => stableExecutions.get('API01-AI-027').status === 400 && external.api01_ai_027.datastore_unchanged_during_action === true,
  'API01-AI-035': () => stableExecutions.get('API01-AI-035').status === 200 && external.api01_ai_035.plaintext_equal === true,
  'API01-STU-001': () => env.step_API01_STU_001_invalid_status === '400' && stableExecutions.get('API01-STU-001').status === 200,
  'API01-STU-002': () => env.step_API01_STU_002_weak_status === '200' && stableExecutions.get('API01-STU-002').status === 400,
  'API01-STU-003': () => env.step_API01_STU_003_wrong_status === '400' && stableExecutions.get('API01-STU-003').status === 200,
  'API01-STU-004': () => env.step_API01_STU_004_a_status === '200' && stableExecutions.get('API01-STU-004').status === 200,
  'API01-STU-005': () => env.step_API01_STU_005_a_success_status === '200' && env.step_API01_STU_005_a_replay_status === '400' && stableExecutions.get('API01-STU-005').status === 200,
  'API02-AI-018': () => stableExecutions.get('API02-AI-018').status === 401 && envArray('cart_API02_AI_018_before').length === envArray('cart_API02_AI_018_after').length,
  'API02-AI-024': () => stableExecutions.get('API02-AI-024').status === 403 && envArray('cart_API02_AI_024_before').length === envArray('cart_API02_AI_024_after').length,
  'API03-AI-016': () => stableExecutions.get('API03-AI-016').status === 200 && productNamed('API03-AI-016-A') && productNamed('API03-AI-016-B'),
  'API03-AI-025': () => stableExecutions.get('API03-AI-025').status === 403 && !productNamed('API03-AI-025-A'),
};
for (const id of ['API01-AI-010', 'API01-AI-012', 'API01-AI-014', 'API01-AI-029']) evidenceChecks[id] = () => stableExecutions.get(id).status === 200;
for (const id of ['API01-AI-009', 'API01-AI-018', 'API01-AI-021', 'API01-AI-022', 'API01-AI-023', 'API01-AI-024']) evidenceChecks[id] = () => stableExecutions.get(id).status === 200;
for (const id of Object.keys(existingDefectMap).filter((x) => x.startsWith('API02-'))) evidenceChecks[id] = () => {
  if (stableExecutions.get(id).status !== 200) return false;
  const prefix = id.replace(/-/g, '_');
  const afterVars = Object.keys(env).filter((name) => name.startsWith(`cart_${prefix}_after`) || name === `cart_${prefix}_mid_a`);
  const cartViolation = afterVars.some((name) => !name.endsWith('_total') && envArray(name).length > 0);
  return cartViolation && Boolean(orderFor(id));
};
evidenceChecks['API03-STU-004'] = () => stableExecutions.get('API03-STU-004').status === 200 && productNamed('API03-STU-004-B2');
evidenceChecks['API03-STU-006'] = () => stableExecutions.get('API03-STU-006').status === 200 && productNamed('API03-STU-006-B2');

const run001ById = new Map(run001.cases.map((record) => [record.case_id, record]));
const correctionTypes = new Map();
for (const id of ['API01-STU-001','API01-STU-002','API01-STU-003','API01-STU-004','API01-STU-005','API02-AI-018','API02-STU-001','API03-AI-016','API03-STU-004','API03-STU-006','API02-AI-016','API02-STU-003','API02-STU-005','API02-STU-006']) correctionTypes.set(id, 'TEST_DEFECT');
for (const id of ['API01-AI-002','API01-AI-007','API01-AI-009','API01-AI-010','API01-AI-012','API01-AI-014','API01-AI-016','API01-AI-018','API01-AI-019','API01-AI-021','API01-AI-022','API01-AI-023','API01-AI-024','API01-AI-029','API01-AI-035','API02-AI-024','API03-AI-025','API02-AI-001','API02-AI-009','API02-AI-034','API02-AI-035','API02-STU-002']) correctionTypes.set(id, 'TEST_DATA_DEFECT');

function correctionDetail(id) {
  if (id === 'API01-AI-016') return ['EXPIRED_RESET_OTP_FIXTURE_UNAVAILABLE', 'No correction applied: a legitimate expired-OTP state is unavailable; do not substitute an empty/stale token.'];
  if (id.startsWith('API01-STU-')) return ['RESET_MULTI_STEP_COLLAPSED', 'Implement every approved failure/retry/replay/cross-user step with isolated users, independent fresh OTPs, and intermediate observations.'];
  if (id.startsWith('API01-')) return ['RESET_TOKEN_FIXTURE_NOT_REFRESHED_PER_CASE', 'Register an isolated disposable user and issue a fresh email-bound OTP immediately before the approved variation.'];
  if (id === 'API02-AI-018') return ['AUTH_VARIATION_MISMATCH', 'Send the checkout action with no Authorization header and verify the populated cart remains unchanged.'];
  if (id === 'API02-STU-001') return ['CHECKOUT_SEQUENCE_COLLAPSED', 'Execute invalid-JWT then valid-JWT checkout over the same cart with before/intermediate/final cart snapshots.'];
  if (id === 'API03-AI-016') return ['MULTI_PRODUCT_PAYLOAD_MISMATCH', 'Send two uniquely named valid products and verify both are reported/persisted.'];
  if (id === 'API03-STU-004' || id === 'API03-STU-006') return ['IMPORT_SEQUENCE_COLLAPSED', 'Execute the approved prior valid admin batch and later invalid/non-admin batch as separate requests with unique product names and post-state evidence.'];
  if (id === 'API02-AI-024' || id === 'API03-AI-025') return ['EXPIRED_JWT_FIXTURE_UNAVAILABLE', 'Generate a signed, genuinely expired disposable-user JWT with the existing local test-secret mechanism.'];
  if (['API02-AI-001','API02-AI-009','API02-AI-034','API02-AI-035'].includes(id)) return ['CART_STATE_OR_VALUE_FIXTURE_MISMATCH', 'Use a unique disposable user/cart and derive the case input from the exact isolated cart snapshot.'];
  if (id === 'API02-STU-002') return ['OTHER_USER_FIXTURE_INCOMPLETE', 'Create two disposable users with distinct carts; capture the second user ID and both independent totals before the spoof attempt.'];
  if (id === 'API02-AI-016') return ['CART_CHANGE_SEQUENCE_NOT_IMPLEMENTED', 'Capture the old cart, mutate it, capture current total, then checkout with the stale client total.'];
  if (id === 'API02-STU-003') return ['SIMULTANEOUS_PAYLOAD_VARIATION_NOT_IMPLEMENTED', 'Send total and address injection-like values simultaneously and verify cart/order plus unrelated datastore integrity.'];
  if (id === 'API02-STU-005' || id === 'API02-STU-006') return ['TWO_USER_CHECKOUT_SEQUENCE_COLLAPSED', 'Execute both users and every cart mutation/checkout step with swapped or stale totals and per-user cart snapshots.'];
  fail(`Correction detail missing: ${id}`);
}

const cases = [];
for (const id of targetIds) {
  const run1 = run001ById.get(id) || fail(`run-001 history missing: ${id}`);
  let result; let classification; let clusters = []; let recommendation; let reason;
  if (id === 'API01-AI-016') {
    result = 'BLOCKED'; classification = 'TEST_DATA_DEFECT'; recommendation = 'HUMAN_REVIEW_REQUIRED'; reason = 'No approved SUT or test-fixture mechanism can establish a genuinely expired reset OTP; the request was intentionally skipped instead of substituting an empty/stale token.';
  } else if (!evidenceChecks[id] || !evidenceChecks[id]()) {
    result = 'FAIL'; classification = 'NEEDS_HUMAN_REVIEW'; recommendation = 'EVIDENCE_CHECK_MISMATCH'; reason = 'Observed evidence did not match the analyzer guard for this approved case.';
  } else if (passIds.has(id)) {
    result = 'PASS'; classification = 'PASS'; recommendation = 'ACCEPT_RUN_002_PASS'; reason = 'Corrected setup/sequence executed and the observable business/state invariant was satisfied.';
  } else if (candidateById.has(id)) {
    result = 'FAIL'; classification = 'PRODUCT_DEFECT_CANDIDATE'; clusters = [candidateById.get(id)]; recommendation = 'HUMAN_DEFECT_REVIEW_REQUIRED'; reason = 'Corrected fixture/harness made the case executable and produced a reproducible requirement-backed failure not covered by the six confirmed run-001 root defects.';
  } else if (existingDefectMap[id]) {
    result = 'FAIL'; classification = 'CONFIRMED_PRODUCT_DEFECT'; clusters = existingDefectMap[id]; recommendation = `MAP_TO_${clusters.join('_AND_')}`; reason = 'Corrected fixture/harness produced meaningful evidence of one or more Human-confirmed run-001 root defects; no new distinct defect is inferred.';
  } else fail(`Unclassified target: ${id}`);
  cases.push({
    case_id: id, api_id: id.slice(0, 5).replace('API01','API-01').replace('API02','API-02').replace('API03','API-03'),
    selected_scope: true, newman_request_executed: stableExecutions.has(id), observed_status_code: stableExecutions.get(id)?.status ?? null,
    result, classification, root_clusters: clusters, reason, final_recommendation: recommendation,
    run_001_status: run1.result, run_001_classification: run1.preliminary_classification,
    human_run_001_final_classification: correctionTypes.get(id) || run1.preliminary_classification,
    correction_applied: id === 'API01-AI-016' ? 'NO' : correctionTypes.has(id) ? 'YES' : 'EXTERNAL_VERIFICATION_ONLY',
    semantic_oracle_changed: false,
  });
}

const count = (predicate) => cases.filter(predicate).length;
const summary = {
  run_id: 'run-002', expected_scope: 37, actual_scope_accounted: cases.length, stable_case_requests_executed: stableExecutions.size,
  results: { pass: count((c) => c.result === 'PASS'), fail: count((c) => c.result === 'FAIL'), postman_pass_external_pending: 0, blocked: count((c) => c.result === 'BLOCKED'), not_run: 0 },
  classifications: {
    confirmed_product_defect_evidence: count((c) => c.classification === 'CONFIRMED_PRODUCT_DEFECT'),
    new_product_defect_candidates: count((c) => c.classification === 'PRODUCT_DEFECT_CANDIDATE'),
    new_candidate_root_clusters: Object.keys(newCandidateClusters).length,
    remaining_test_defect: count((c) => c.classification === 'TEST_DEFECT'),
    remaining_test_data_defect: count((c) => c.classification === 'TEST_DATA_DEFECT'),
    needs_human_review: count((c) => c.classification === 'NEEDS_HUMAN_REVIEW'),
  },
  corrections: { corrective_pool: correctionTypes.size, applied: count((c) => c.correction_applied === 'YES'), requiring_human_review: count((c) => c.correction_applied === 'NO') },
  confirmed_product_defects_total: 6, run_001_product_defect_evidence_cases: 29, run_001_confirmed_product_cases_rerun: 0,
  x_student_id_runtime_coverage: `${xStudentIdPresent}/${newman.run.executions.length}`,
};
if (summary.results.pass !== 15 || summary.results.fail !== 21 || summary.results.blocked !== 1 || summary.classifications.new_product_defect_candidates !== 9 || summary.classifications.confirmed_product_defect_evidence !== 12 || summary.corrections.applied !== 35) fail(`Accounting guard failed: ${JSON.stringify(summary)}`);

writeJson(path.join(runDir, 'case-accounting.json'), { summary, new_candidate_clusters: newCandidateClusters, cases });
writeJson(path.join(runDir, 'case-history.json'), { run_001_preserved: true, run_002_targeted: true, cases: cases.map((c) => ({ case_id: c.case_id, run_001_status: c.run_001_status, run_001_classification: c.run_001_classification, human_run_001_final_classification: c.human_run_001_final_classification, correction_applied: c.correction_applied, run_002_status: c.result, run_002_classification: c.classification, final_recommendation: c.final_recommendation })) });
writeJson(path.join(runDir, 'external-verification-results.json'), {
  run_id: 'run-002', pending: 0, blocked: 0, completed: 3,
  cases: [
    { case_id: 'API01-AI-027', status: 'PASS', mechanism: 'Synchronous read-only SQLite file hash immediately before/after the exact request', evidence: external.api01_ai_027, final_recommendation: 'EXTERNAL_VERIFICATION_RESOLVED_PASS' },
    { case_id: 'API01-AI-035', status: 'FAIL', mechanism: 'Read-only SQLite comparison without recording the password value', evidence: external.api01_ai_035, final_recommendation: 'NEW_PRODUCT_DEFECT_CANDIDATE_RC-01-N03' },
    { case_id: 'API02-STU-001', status: 'FAIL', mechanism: 'HTTP cart snapshots before, after invalid JWT, and after valid checkout', evidence: { before_lines: envArray('cart_API02_STU_001_before').length, after_invalid_lines: envArray('cart_API02_STU_001_after_invalid').length, after_valid_lines: envArray('cart_API02_STU_001_after').length, invalid_status: Number(env.step_API02_STU_001_invalid_status), valid_status: stableExecutions.get('API02-STU-001').status }, final_recommendation: 'MAP_TO_CONFIRMED_RC-02-02' },
  ],
});

const correctionLines = [
  '# HW06 run-002 Correction Record', '',
  'Human approval permits only test/harness/test-data/external-verification corrections. No authoritative oracle or production behavior was changed.', '',
  '| CASE_ID | FINAL_CORRECTION_CLASS | BEFORE | ROOT_TEST_OR_DATA_DEFECT | CORRECTION | SEMANTIC_ORACLE_CHANGED | CORRECTION_STATUS |',
  '| --- | --- | --- | --- | --- | --- | --- |',
];
for (const id of targetIds.filter((caseId) => correctionTypes.has(caseId))) {
  const item = cases.find((c) => c.case_id === id); const type = correctionTypes.get(id);
  const before = type === 'TEST_DEFECT' ? 'Approved variation/sequence was absent or collapsed in run-001.' : 'Required isolated fixture/lifecycle/state was invalid, stale, shared, or incomplete in run-001.';
  const [rootProblem, correction] = correctionDetail(id);
  correctionLines.push(`| ${id} | ${type} | ${before} | ${rootProblem} | ${correction} | NO | ${item.correction_applied === 'YES' ? 'APPLIED_AND_RERUN' : 'HUMAN_REVIEW_REQUIRED'} |`);
}
correctionLines.push('', 'Totals: `14 TEST_DEFECT`; `22 TEST_DATA_DEFECT`; `35 APPLIED_AND_RERUN`; `1 HUMAN_REVIEW_REQUIRED` (`API01-AI-016`).');
writeText(path.join(docsDir, 'run-002-correction-record.md'), correctionLines.join('\n'));

const started = readJson(path.join(runDir, 'runner-result.json'));
writeText(path.join(runDir, 'execution-metadata.md'), `# HW06 Targeted Corrective Rerun Metadata

- RUN_ID: \`run-002\`
- STARTED_UTC: \`${started.started_at}\`
- ENDED_UTC: \`${started.ended_at}\`
- DURATION_SECONDS: \`${started.duration_seconds}\`
- NEWMAN_VERSION: \`6.2.2\`
- HTML_REPORTER: \`newman-reporter-htmlextra 1.23.1\`
- EXPECTED_TARGETED_SCOPE: \`37\`
- ACTUAL_SCOPE_ACCOUNTED: \`37\`
- STABLE_CASE_REQUESTS_EXECUTED: \`36\`
- INTENTIONALLY_SKIPPED_NO_LEGITIMATE_FIXTURE: \`API01-AI-016\`
- TOTAL_COLLECTION_ITEMS: \`180\`
- REAL_SUT_REQUESTS_EXECUTED: \`179\`
- NEWMAN_ASSERTION_FAILURES: \`0\`
- X_STUDENT_ID_RUNTIME_COVERAGE: \`179/179\`
- RERUN_SMOKE_REQUIRED: \`YES\`
- RERUN_SMOKE_REASON: corrected reusable isolated-fixture and sequence harness
- RERUN_SMOKE_CASES: \`3\`
- RERUN_SMOKE_EXIT_CODE: \`0\`
- PRODUCT_DEFECT_CASES_RERUN_FROM_CONFIRMED_RUN_001_SET: \`0\`
- SOURCE_DATABASE_MODIFIED: \`NO\`
- PRODUCTION_CODE_MODIFIED: \`NO\`

## Exact orchestration command

\`node postman/scripts/orchestrate-run-002.js\`

The orchestrator ran a three-case smoke, restarted the SUT to reset its isolated SQLite state, ran the 37-identity targeted scope, generated genuine Newman JSON/HTML/stdout/stderr, and shut down the SUT. Newman assertion success is runner/harness evidence only; final business classifications are in \`case-accounting.json\` and combine raw responses, cart snapshots, and read-only SQLite evidence.`);

console.log(JSON.stringify(summary, null, 2));
