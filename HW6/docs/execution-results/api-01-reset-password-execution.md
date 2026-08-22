# API-01 Real Execution Report

## Execution history

- `preflight-001 — PRESERVED`: configuration guard stopped before any request; historical `PRE_EXECUTION_BLOCKED: 93`, runtime defects `0`.
- `preflight-002 — PRESERVED`: local Newman tooling unavailable; historical `PRE_EXECUTION_BLOCKED: 93`, runtime defects `0`.
- `preflight-003 — PASS`: Student ID non-empty, credentials ready, Newman `6.2.2`, htmlextra `1.23.1`, 103/103 static header coverage, safe isolated SQLite strategy.
- `smoke-001 — FAIL / HARNESS_DEFECT`: 11 real requests; duplicate setup-script variable identifier prevented OTP/token assignment; evidence preserved.
- `smoke-002 — PASS_FOR_FULL_EXECUTION_GATE_WITH_PRODUCT_DEFECT_CANDIDATES`: 11 main requests plus one cart postcheck; 12/12 runtime header coverage.
- `run-001 — COMPLETED`: 103 collection requests plus two read-only cart postchecks; 93 stable testcase identities; no data file and no multiplication.

## run-001 accounting

| TOTAL | PASS | FAIL | POSTMAN_PASS_EXTERNAL_PENDING | BLOCKED | NOT_RUN |
| ---: | ---: | ---: | ---: | ---: | ---: |
| 30 | 9 | 0 | 1 | 20 | 0 |

Newman exit `0` is retained as runner evidence, not promoted to business PASS without an implemented or external oracle. This table preserves the original run-001 state before Human Failure Triage.

## Case accounting

| CASE_ID | SOURCE | HTTP | RESULT | PRELIMINARY_CLASSIFICATION | EXTERNAL | REASON |
| --- | --- | ---: | --- | --- | --- | --- |
| API01-AI-001 | AI_CORRECTED | 200 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API01-AI-002 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-AI-003 | AI_CORRECTED | 400 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API01-AI-004 | AI_CORRECTED | 400 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API01-AI-005 | AI_CORRECTED | 400 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API01-AI-006 | AI_CORRECTED | 400 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API01-AI-007 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-AI-008 | AI_CORRECTED | 400 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API01-AI-009 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-AI-010 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-AI-011 | AI_CORRECTED | 400 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API01-AI-012 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-AI-014 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-AI-015 | AI_CORRECTED | 400 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API01-AI-016 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-AI-018 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-AI-019 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-AI-021 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-AI-022 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-AI-023 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-AI-024 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-AI-027 | AI_CORRECTED | 400 | POSTMAN_PASS_EXTERNAL_PENDING | EXTERNAL_VERIFICATION_PENDING | PENDING | The approved before/after user-datastore snapshot was not captured around this exact action. |
| API01-AI-028 | AI_CORRECTED | 400 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API01-AI-029 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-AI-035 | AI_CORRECTED | 400 | BLOCKED | TEST_DATA_DEFECT | BLOCKED | Approved precondition/state was not freshly established for this testcase identity. |
| API01-STU-001 | STUDENT_ADDED | 400 | BLOCKED | TEST_DEFECT | NOT_PLANNED | The collection executes one action but does not implement the approved multi-step/request variation or fixture shape. |
| API01-STU-002 | STUDENT_ADDED | 400 | BLOCKED | TEST_DEFECT | NOT_PLANNED | The collection executes one action but does not implement the approved multi-step/request variation or fixture shape. |
| API01-STU-003 | STUDENT_ADDED | 400 | BLOCKED | TEST_DEFECT | NOT_PLANNED | The collection executes one action but does not implement the approved multi-step/request variation or fixture shape. |
| API01-STU-004 | STUDENT_ADDED | 400 | BLOCKED | TEST_DEFECT | NOT_PLANNED | The collection executes one action but does not implement the approved multi-step/request variation or fixture shape. |
| API01-STU-005 | STUDENT_ADDED | 400 | BLOCKED | TEST_DEFECT | NOT_PLANNED | The collection executes one action but does not implement the approved multi-step/request variation or fixture shape. |

## Final Human defect decision after run-001

Run-001 produced no direct API-01 Product Defect Candidate. Human confirmed six distinct defects from API-02/API-03 and authorized correction of API-01 test/data blockers; blocked API-01 cases were not promoted to product defects.

## run-002 targeted corrective rerun

| SELECTED | PASS | FAIL | POSTMAN_PASS_EXTERNAL_PENDING | BLOCKED | NOT_RUN |
| ---: | ---: | ---: | ---: | ---: | ---: |
| 21 | 11 | 9 | 0 | 1 | 0 |

- Fresh isolated user/OTP fixtures and all five approved Student Extension sequences were implemented without changing an oracle.
- `API01-AI-016` remains `BLOCKED / TEST_DATA_DEFECT`: no legitimate expired-OTP state exists; its request was intentionally skipped.
- Nine executable cases exposed three strong root clusters. Human Review confirmed `RC-01-N01 MISSING_NEW_PASSWORD_ACCEPTED_AS_SUCCESSFUL_RESET` (1) as DEF-07, `RC-01-N02 RESET_PASSWORD_STRENGTH_RULE_NOT_ENFORCED` (7) as DEF-08, and `RC-01-N03 RESET_PASSWORD_STORES_PASSWORD_AS_PLAINTEXT` (1) as DEF-09.
- `API01-AI-027` external verification resolved `PASS`: exact-action SQLite hash was unchanged.
- `API01-AI-035` external verification resolved `FAIL`: read-only comparison recorded `PLAINTEXT_EQUAL: YES` without recording the password value.

All three classifications were finalized only after explicit Human approval; no automatic product-defect promotion occurred.

## Evidence

- `test-results/hw06/run-001/newman.json`
- `test-results/hw06/run-001/newman.html`
- `test-results/hw06/run-001/stdout.log`
- `test-results/hw06/run-001/stderr.log`
- `test-results/hw06/run-001/execution-metadata.md`
- `test-results/hw06/run-001/case-accounting.json`
- `test-results/hw06/run-001/external-verification-results.json`
- `test-results/hw06/run-002/newman.json`
- `test-results/hw06/run-002/newman.html`
- `test-results/hw06/run-002/case-accounting.json`
- `test-results/hw06/run-002/external-verification-results.json`
- `docs/execution-results/run-002-correction-record.md`
