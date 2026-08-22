# API-03 Real Execution Report

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
| 33 | 15 | 14 | 0 | 4 | 0 |

Newman exit `0` is retained as runner evidence, not promoted to business PASS without an implemented or external oracle. This table preserves the original preliminary state before Human Failure Triage.

## Case accounting

| CASE_ID | SOURCE | HTTP | RESULT | PRELIMINARY_CLASSIFICATION | EXTERNAL | REASON |
| --- | --- | ---: | --- | --- | --- | --- |
| API03-AI-001 | AI_CORRECTED | 200 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-AI-002 | AI_CORRECTED | 200 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-AI-003 | AI_CORRECTED | 400 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-AI-004 | AI_CORRECTED | 400 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-AI-005 | AI_CORRECTED | 400 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-AI-007 | AI_CORRECTED | 200 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-AI-008 | AI_CORRECTED | 200 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-AI-009 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | Actual import authorization/validation/atomic persistence contradicted the approved FR-16/SEC oracle. |
| API03-AI-010 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | Actual import authorization/validation/atomic persistence contradicted the approved FR-16/SEC oracle. |
| API03-AI-011 | AI_CORRECTED | 200 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-AI-016 | AI_CORRECTED | 200 | BLOCKED | TEST_DEFECT | NOT_PLANNED | The collection executes one action but does not implement the approved multi-step/request variation or fixture shape. |
| API03-AI-017 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | Actual import authorization/validation/atomic persistence contradicted the approved FR-16/SEC oracle. |
| API03-AI-018 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | Actual import authorization/validation/atomic persistence contradicted the approved FR-16/SEC oracle. |
| API03-AI-019 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | Actual import authorization/validation/atomic persistence contradicted the approved FR-16/SEC oracle. |
| API03-AI-020 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | Actual import authorization/validation/atomic persistence contradicted the approved FR-16/SEC oracle. |
| API03-AI-021 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | Actual import authorization/validation/atomic persistence contradicted the approved FR-16/SEC oracle. |
| API03-AI-022 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | Actual import authorization/validation/atomic persistence contradicted the approved FR-16/SEC oracle. |
| API03-AI-023 | AI_CORRECTED | 401 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-AI-024 | AI_CORRECTED | 403 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-AI-025 | AI_CORRECTED | 401 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | The required expired-token fixture was not created; an empty/missing token cannot verify expiration behavior. |
| API03-AI-026 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | Actual import authorization/validation/atomic persistence contradicted the approved FR-16/SEC oracle. |
| API03-AI-027 | AI_CORRECTED | 200 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-AI-028 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | Actual import authorization/validation/atomic persistence contradicted the approved FR-16/SEC oracle. |
| API03-AI-029 | AI_CORRECTED | 200 | PASS | PASS | PASS | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-AI-031 | AI_CORRECTED | 200 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-AI-035 | AI_CORRECTED | 200 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-AI-038 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | Actual import authorization/validation/atomic persistence contradicted the approved FR-16/SEC oracle. |
| API03-AI-039 | AI_CORRECTED | 200 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API03-STU-001 | STUDENT_ADDED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | Actual import authorization/validation/atomic persistence contradicted the approved FR-16/SEC oracle. |
| API03-STU-002 | STUDENT_ADDED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | Actual import authorization/validation/atomic persistence contradicted the approved FR-16/SEC oracle. |
| API03-STU-003 | STUDENT_ADDED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | Actual import authorization/validation/atomic persistence contradicted the approved FR-16/SEC oracle. |
| API03-STU-004 | STUDENT_ADDED | 200 | BLOCKED | TEST_DEFECT | NOT_PLANNED | The collection executes one action but does not implement the approved multi-step/request variation or fixture shape. |
| API03-STU-006 | STUDENT_ADDED | 200 | BLOCKED | TEST_DEFECT | NOT_PLANNED | The collection executes one action but does not implement the approved multi-step/request variation or fixture shape. |

## Final Human defect decision after run-001

Human confirmed three distinct API-03 defects: `RC-03-01 PRODUCT_PRICE_POSITIVITY_NOT_ENFORCED`, `RC-03-02 IMPORT_NOT_ATOMIC`, and `RC-03-03 ADMIN_ROLE_NOT_ENFORCED`.

## run-002 targeted corrective rerun

| SELECTED | PASS | FAIL | POSTMAN_PASS_EXTERNAL_PENDING | BLOCKED | NOT_RUN |
| ---: | ---: | ---: | ---: | ---: | ---: |
| 4 | 2 | 2 | 0 | 0 | 0 |

- `API03-AI-016` passed after a real two-product valid batch committed both products.
- `API03-AI-025` passed with a signed expired JWT and no product persistence.
- `API03-STU-004` failed because the later batch persisted its negative-price row, mapping to confirmed `RC-03-01`/`RC-03-02`.
- `API03-STU-006` failed because a non-admin JWT imported its mixed batch including a negative-price row, mapping to confirmed `RC-03-03`/`RC-03-01`.
- `NEW_PRODUCT_DEFECT_CANDIDATES: 0` for API-03.

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
- `docs/defects/DEF-04-import-price-validation.md`
- `docs/defects/DEF-05-import-not-atomic.md`
- `docs/defects/DEF-06-import-admin-role.md`
