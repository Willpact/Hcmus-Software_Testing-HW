# HW06 Targeted Corrective Rerun Metadata

- RUN_ID: `run-002`
- STARTED_UTC: `2026-08-22T14:09:40.583Z`
- ENDED_UTC: `2026-08-22T14:09:56.855Z`
- DURATION_SECONDS: `16.272`
- NEWMAN_VERSION: `6.2.2`
- HTML_REPORTER: `newman-reporter-htmlextra 1.23.1`
- EXPECTED_TARGETED_SCOPE: `37`
- ACTUAL_SCOPE_ACCOUNTED: `37`
- STABLE_CASE_REQUESTS_EXECUTED: `36`
- INTENTIONALLY_SKIPPED_NO_LEGITIMATE_FIXTURE: `API01-AI-016`
- TOTAL_COLLECTION_ITEMS: `180`
- REAL_SUT_REQUESTS_EXECUTED: `179`
- NEWMAN_ASSERTION_FAILURES: `0`
- X_STUDENT_ID_RUNTIME_COVERAGE: `179/179`
- RERUN_SMOKE_REQUIRED: `YES`
- RERUN_SMOKE_REASON: corrected reusable isolated-fixture and sequence harness
- RERUN_SMOKE_CASES: `3`
- RERUN_SMOKE_EXIT_CODE: `0`
- PRODUCT_DEFECT_CASES_RERUN_FROM_CONFIRMED_RUN_001_SET: `0`
- SOURCE_DATABASE_MODIFIED: `NO`
- PRODUCTION_CODE_MODIFIED: `NO`

## Exact orchestration command

`node postman/scripts/orchestrate-run-002.js`

The orchestrator ran a three-case smoke, restarted the SUT to reset its isolated SQLite state, ran the 37-identity targeted scope, generated genuine Newman JSON/HTML/stdout/stderr, and shut down the SUT. Newman assertion success is runner/harness evidence only; final business classifications are in `case-accounting.json` and combine raw responses, cart snapshots, and read-only SQLite evidence.
