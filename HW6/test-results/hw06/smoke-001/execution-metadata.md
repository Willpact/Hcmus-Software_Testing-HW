# HW06 Smoke 001 Execution Metadata

- RUN_ID: `smoke-001`
- STARTED: `2026-08-22T19:41:23.7726247+07:00`
- ENDED: `2026-08-22T19:41:29.5179662+07:00`
- NEWMAN_EXIT_CODE: `1`
- STATUS: `FAIL`
- PRELIMINARY_CLASSIFICATION: `HARNESS_DEFECT`
- REAL_REQUESTS: `11`
- X_STUDENT_ID_RUNTIME_COVERAGE: `11/11`
- MISSING_OR_EMPTY: `[]`
- FINAL_TESTCASE_IDENTITIES_IN_SMOKE: `3`
- SOURCE_COLLECTION: `test-results/hw06/smoke-001/smoke.postman_collection.json`
- ENVIRONMENT: `test-results/hw06/runtime/HW06-Local.runtime.postman_environment.json`
- NEWMAN_JSON: `test-results/hw06/smoke-001/newman.json`
- NEWMAN_HTML: `test-results/hw06/smoke-001/newman.html`
- STDOUT: `test-results/hw06/smoke-001/stdout.log`
- STDERR: `test-results/hw06/smoke-001/stderr.log`

## Exact Newman command

```text
.tools/newman/node_modules/.bin/newman.cmd run test-results/hw06/smoke-001/smoke.postman_collection.json -e test-results/hw06/runtime/HW06-Local.runtime.postman_environment.json -r cli,json,htmlextra --reporter-json-export test-results/hw06/smoke-001/newman.json --reporter-htmlextra-export test-results/hw06/smoke-001/newman.html --export-environment test-results/hw06/smoke-001/runtime-output.postman_environment.json
```

## Failure

Three setup test scripts redeclared the same top-level `const data` identifier in the shared Newman sandbox. Token/OTP assignment did not execute, so dependent actions returned `400`/`401`. This is a harness defect, not product evidence. The entire run is preserved unchanged.
