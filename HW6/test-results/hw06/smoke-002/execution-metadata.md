# HW06 Smoke 002 Execution Metadata

- RUN_ID: `smoke-002`
- STARTED: `2026-08-22T19:42:55.7592803+07:00`
- ENDED: `2026-08-22T19:42:58.1689101+07:00`
- NEWMAN_EXIT_CODE: `0`
- STATUS: `PASS_FOR_FULL_EXECUTION_GATE_WITH_PRODUCT_DEFECT_CANDIDATES`
- REAL_MAIN_REQUESTS: `11`
- REAL_EXTERNAL_POSTCHECK_REQUESTS: `1`
- X_STUDENT_ID_RUNTIME_COVERAGE: `12/12`
- MISSING_OR_EMPTY: `[]`
- FINAL_TESTCASE_IDENTITIES_IN_SMOKE: `3`
- SOURCE_COLLECTION: `test-results/hw06/smoke-002/smoke.postman_collection.json`
- ENVIRONMENT: `test-results/hw06/runtime/HW06-Local.runtime.postman_environment.json`
- NEWMAN_JSON: `test-results/hw06/smoke-002/newman.json`
- NEWMAN_HTML: `test-results/hw06/smoke-002/newman.html`
- STDOUT: `test-results/hw06/smoke-002/stdout.log`
- STDERR: `test-results/hw06/smoke-002/stderr.log`
- EXTERNAL_VERIFICATION: `test-results/hw06/smoke-002/external-verification.json`

## Exact Newman command

```text
.tools/newman/node_modules/.bin/newman.cmd run test-results/hw06/smoke-002/smoke.postman_collection.json -e test-results/hw06/runtime/HW06-Local.runtime.postman_environment.json -r cli,json,htmlextra --reporter-json-export test-results/hw06/smoke-002/newman.json --reporter-htmlextra-export test-results/hw06/smoke-002/newman.html --export-environment test-results/hw06/smoke-002/runtime-output.postman_environment.json
```

## Harness correction

Renamed the five setup-script response variables to API/request-specific identifiers. No request, oracle, assertion intent, production behavior, or testcase identity changed.

## Smoke external observations

- `API01-AI-014`: valid reset flow and OTP invalidation passed.
- `API01-AI-035`: read-only DB comparison found `PLAINTEXT_EQUAL: YES`; preliminary `PRODUCT_DEFECT_CANDIDATE`.
- `API02-AI-001`: persisted total/user binding matched the independently derived cart, but the authenticated cart remained populated; preliminary `PRODUCT_DEFECT_CANDIDATE`.
- `API03-AI-001`: response reported one insert and read-only DB inspection found the product persisted.

These are preliminary smoke observations; no final product defect is declared.
