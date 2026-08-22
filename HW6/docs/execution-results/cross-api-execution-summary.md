# HW06 Cross-API Real Execution Summary

## Execution history

- `preflight-001 — PRESERVED`: configuration guard stopped before any request; historical `PRE_EXECUTION_BLOCKED: 93`, runtime defects `0`.
- `preflight-002 — PRESERVED`: local Newman tooling unavailable; historical `PRE_EXECUTION_BLOCKED: 93`, runtime defects `0`.
- `preflight-003 — PASS`: Student ID non-empty, credentials ready, Newman `6.2.2`, htmlextra `1.23.1`, 103/103 static header coverage, safe isolated SQLite strategy.
- `smoke-001 — FAIL / HARNESS_DEFECT`: 11 real requests; duplicate setup-script variable identifier prevented OTP/token assignment; evidence preserved.
- `smoke-002 — PASS_FOR_FULL_EXECUTION_GATE_WITH_PRODUCT_DEFECT_CANDIDATES`: 11 main requests plus one cart postcheck; 12/12 runtime header coverage.
- `run-001 — COMPLETED`: 103 collection requests plus two read-only cart postchecks; 93 stable testcase identities; no data file and no multiplication.


## Final testcase accounting from run-001

| API | TOTAL | PASS | FAIL | POSTMAN_PASS_EXTERNAL_PENDING | BLOCKED | NOT_RUN |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| API-01 | 30 | 9 | 0 | 1 | 20 | 0 |
| API-02 | 30 | 3 | 24 | 0 | 3 | 0 |
| API-03 | 33 | 15 | 14 | 0 | 4 | 0 |
| **Total** | **93** | **27** | **38** | **1** | **27** | **0** |

## External verification

| PLANNED | COMPLETED | PASSED | FAILED | PENDING | BLOCKED |
| ---: | ---: | ---: | ---: | ---: | ---: |
| 26 | 23 | 1 | 22 | 1 | 2 |

## Preliminary classification

| Classification | Count |
| --- | ---: |
| PRODUCT_DEFECT_CANDIDATE | 38 |
| TEST_DEFECT | 10 |
| TEST_DATA_DEFECT | 17 |
| ENVIRONMENT_DEFECT | 0 |
| SPEC_AMBIGUITY | 0 |
| EXTERNAL_VERIFICATION_PENDING | 1 |
| NEEDS_HUMAN_REVIEW | 0 |

This is the preserved preliminary run-001 classification before Human review.

## Final Human defect decisions for run-001

- `TESTCASE_FAILURES_REVIEWED: 38`
- `PRODUCT_DEFECT_EVIDENCE_CASES: 29`
- `DISTINCT_PRODUCT_DEFECTS: 6`
- `RECLASSIFIED_TEST_DEFECT: 4`
- `RECLASSIFIED_TEST_DATA_DEFECT: 5`

The correct statement is: **29 testcase failures map to six Human-confirmed product defects**. The six defects are `RC-02-01`, `RC-02-02`, `RC-02-03`, `RC-03-01`, `RC-03-02`, and `RC-03-03`; overlapping supporting-case coverage is not counted as additional bugs.

## run-002 targeted corrective rerun

| API | SELECTED | PASS | FAIL | POSTMAN_PASS_EXTERNAL_PENDING | BLOCKED | NOT_RUN |
| --- | ---: | ---: | ---: | ---: | ---: | ---: |
| API-01 | 21 | 11 | 9 | 0 | 1 | 0 |
| API-02 | 12 | 2 | 10 | 0 | 0 | 0 |
| API-03 | 4 | 2 | 2 | 0 | 0 | 0 |
| **Total** | **37** | **15** | **21** | **0** | **1** | **0** |

- Corrective pool: `36` (`14 TEST_DEFECT`, `22 TEST_DATA_DEFECT`). Corrections applied and rerun: `35`; Human review required because no legitimate expired-OTP fixture exists: `1` (`API01-AI-016`).
- Stable testcase requests executed: `36`; the intentionally skipped identity remains accounted as `BLOCKED`.
- Runtime `X-Student-Id` coverage: `179/179` real SUT requests.
- `12` run-002 failures map to the six already confirmed defects.
- `9` run-002 failures form three new API-01 root clusters; Human Review confirmed all three as `DEF-07`, `DEF-08`, and `DEF-09`.
- Remaining Test Defect: `0`; remaining Test Data Defect: `1`; external pending/blocked from the original three-case set: `0/0`.
- No case from the 29-case confirmed run-001 evidence set was rerun merely to prove the defect again.

## Final reviewed defect accounting

- `DISTINCT_CONFIRMED_PRODUCT_DEFECTS: 9`
- `PRODUCT_DEFECT_EVIDENCE_CASES: 38` unique stable IDs in the canonical final inventory: `29` Human-confirmed affected run-001 identities plus `9` newly confirmed run-002 identities.
- `RUN_001_TO_RUN_002_NEW_CLUSTER_OVERLAP: 0`
- Correct language: **38 failing testcase evidence records map to nine distinct Human-confirmed product defects**.
- The `12` corrected run-002 failures mapped to existing DEF-01/02/04/05/06 are preserved as corroborating executions and do not create additional defects or inflate the canonical `29 + 9` inventory.
- `REMAINING_TEST_DEFECT: 0`
- `REMAINING_TEST_DATA_BLOCKER: 1`
- `REMAINING_TEST_DATA_CASE: API01-AI-016`
- `API01-AI-016 STATUS: BLOCKED_TEST_DATA`
- `API01-AI-016 ROOT_CAUSE: LEGITIMATE_EXPIRED_OTP_FIXTURE_UNAVAILABLE`
- `API01-AI-016 PRODUCT_INFERENCE: NO`
- `ADDITIONAL_RERUN_REQUIRED: NO`

Canonical confirmed root inventory: `RC-02-01`, `RC-02-02`, `RC-02-03`, `RC-03-01`, `RC-03-02`, `RC-03-03`, `RC-01-N01`, `RC-01-N02`, and `RC-01-N03`.

## Runtime request/header accounting

- Smoke and smoke postcheck requests: `23/23` with resolved non-empty `X-Student-Id`.
- Full run and full postcheck requests: `105/105` with resolved non-empty `X-Student-Id`.
- Total real SUT requests through the preserved smoke/run-001 sequence: `128`.
- Runtime header coverage through the preserved smoke/run-001 sequence: `128/128`.
- Targeted run-002 real SUT requests and header coverage: `179/179`.
- Missing or empty: `[]`.

## Evidence boundary

The machine-generated Newman report has zero script/assertion failures. The generated case scripts assert the runtime Student-ID guard and response capture, so Newman green is not treated as 93 business PASS. Case outcomes use approved business/state oracles, actual response/state evidence, and conservative blocking where fixtures or multi-step setup were not valid.

## run-002 evidence

- `test-results/hw06/run-002/newman.json`
- `test-results/hw06/run-002/newman.html`
- `test-results/hw06/run-002/stdout.log`
- `test-results/hw06/run-002/stderr.log`
- `test-results/hw06/run-002/execution-metadata.md`
- `test-results/hw06/run-002/case-accounting.json`
- `test-results/hw06/run-002/case-history.json`
- `test-results/hw06/run-002/external-verification-results.json`

## Next checkpoint

Screenshot capture is now `MANUAL_BY_STUDENT`, screenshot automation is `CLOSED`, and the nine pending screenshots do not block issue-content preparation.

`HW06_GIT_AND_ISSUE_PREPARATION_REVIEW_REQUIRED`
