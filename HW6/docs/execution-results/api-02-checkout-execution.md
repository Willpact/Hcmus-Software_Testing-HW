# API-02 Real Execution Report

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
| 30 | 3 | 24 | 0 | 3 | 0 |

Newman exit `0` is retained as runner evidence, not promoted to business PASS without an implemented or external oracle. This table preserves the original preliminary state before Human Failure Triage.

## Case accounting

| CASE_ID | SOURCE | HTTP | RESULT | PRELIMINARY_CLASSIFICATION | EXTERNAL | REASON |
| --- | --- | ---: | --- | --- | --- | --- |
| API02-AI-001 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-002 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-003 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-004 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-005 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-006 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-007 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-009 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-010 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-014 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-016 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-017 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-018 | AI_CORRECTED | 200 | BLOCKED | TEST_DEFECT | NOT_PLANNED | The collection executes one action but does not implement the approved multi-step/request variation or fixture shape. |
| API02-AI-021 | AI_CORRECTED | 401 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API02-AI-022 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-023 | AI_CORRECTED | 403 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API02-AI-024 | AI_CORRECTED | 401 | BLOCKED | TEST_DATA_DEFECT | NOT_PLANNED | The required expired-token fixture was not created; an empty/missing token cannot verify expiration behavior. |
| API02-AI-025 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-026 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-027 | AI_CORRECTED | 200 | PASS | PASS | NOT_PLANNED | Observed response/state satisfies the requirement-backed oracle available for this case. |
| API02-AI-029 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-034 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-035 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-036 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | NOT_PLANNED | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-AI-037 | AI_CORRECTED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-STU-001 | STUDENT_ADDED | 403 | BLOCKED | TEST_DEFECT | BLOCKED | The collection executes one action but does not implement the approved multi-step/request variation or fixture shape. |
| API02-STU-002 | STUDENT_ADDED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-STU-003 | STUDENT_ADDED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-STU-005 | STUDENT_ADDED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |
| API02-STU-006 | STUDENT_ADDED | 200 | FAIL | PRODUCT_DEFECT_CANDIDATE | FAIL | A successful checkout contradicted a requirement-backed invariant: authoritative cart total/auth handling/cart-clear state. |

## Final Human defect decision after run-001

Human confirmed three distinct API-02 defects: `RC-02-01 CLIENT_SUPPLIED_TOTAL_TRUSTED`, `RC-02-02 SUCCESSFUL_CHECKOUT_DOES_NOT_CLEAR_CART`, and `RC-02-03 AUTHORIZATION_SCHEME_NOT_ENFORCED`. Overlapping supporting cases remain evidence coverage, not duplicate defects.

## run-002 targeted corrective rerun

| SELECTED | PASS | FAIL | POSTMAN_PASS_EXTERNAL_PENDING | BLOCKED | NOT_RUN |
| ---: | ---: | ---: | ---: | ---: | ---: |
| 12 | 2 | 10 | 0 | 0 | 0 |

- `API02-AI-018` passed with genuinely missing Authorization and unchanged cart.
- `API02-AI-024` passed with a signed expired JWT and unchanged cart.
- The other ten corrected fixture/sequence cases produced meaningful failures mapped only to already confirmed `RC-02-01` and/or `RC-02-02`; `NEW_PRODUCT_DEFECT_CANDIDATES: 0` for API-02.
- `API02-STU-001` external verification is resolved: cart remained populated after the invalid JWT as expected, but also remained populated after successful authorized checkout, so the final result maps to confirmed `RC-02-02`.

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
- `docs/defects/DEF-01-checkout-client-total-trusted.md`
- `docs/defects/DEF-02-checkout-cart-not-cleared.md`
- `docs/defects/DEF-03-checkout-auth-not-enforced.md`
