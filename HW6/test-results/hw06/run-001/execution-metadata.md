# HW06 Full Execution Metadata

- RUN_ID: `run-001`
- STARTED: `2026-08-22T19:46:36.8513182+07:00`
- ENDED: `2026-08-22T19:46:47.7991757+07:00`
- DURATION_SECONDS: `10.948`
- NEWMAN_EXIT_CODE: `0`
- NEWMAN_VERSION: `6.2.2`
- HTML_REPORTER: `newman-reporter-htmlextra 1.23.1`
- POSTMAN_TOTAL_REQUESTS: `103`
- FINAL_TESTCASE_IDENTITIES: `93`
- DATA_FILE: `NONE`
- DATA_MULTIPLICATION: `NO`
- NEWMAN_ASSERTION_FAILURES: `0`
- EXTERNAL_POSTCHECK_REQUESTS: `2`
- X_STUDENT_ID_RUNTIME_COVERAGE: `105/105`
- MISSING_OR_EMPTY: `[]`
- PRODUCT_DEFECT_FINAL: `0`
- PRODUCTION_CODE_MODIFIED: `NO`
- SOURCE_DATABASE_MODIFIED: `NO`
- RERUN: `NO`
- RERUN_REASON: Meaningful product/test/test-data outcomes are preserved for Human Failure Triage; the suite was not changed repeatedly to force green.

## Exact full Newman command

```text
.tools/newman/node_modules/.bin/newman.cmd run postman/collections/HW06-API-Testing.postman_collection.json -e test-results/hw06/runtime/HW06-Local.runtime.postman_environment.json -r cli,json,htmlextra --reporter-json-export test-results/hw06/run-001/newman.json --reporter-htmlextra-export test-results/hw06/run-001/newman.html --export-environment test-results/hw06/run-001/runtime-output.postman_environment.json
```

## Exact external cart postcheck command

```text
.tools/newman/node_modules/.bin/newman.cmd run test-results/hw06/run-001/external-postcheck.postman_collection.json -e test-results/hw06/run-001/runtime-output.postman_environment.json -r cli,json --reporter-json-export test-results/hw06/run-001/external-postcheck.newman.json
```

## Evidence boundary

Newman exit `0` proves the implemented Postman scripts ran without assertion/runtime failures. It does not by itself prove the approved business/state oracles because the case scripts capture responses rather than assert every business invariant. Final accounting therefore combines genuine Newman evidence with approved read-only external checks and marks invalid fixtures/harness coverage conservatively as `BLOCKED`, not product defects.
