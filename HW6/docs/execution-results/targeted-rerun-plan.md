# HW06 Proposed Targeted Rerun Plan

Status: `HUMAN_APPROVED_AND_EXECUTED_AS_RUN_002`. The original plan selected 37 stable IDs; corrections preserved every authoritative oracle and `run-001` remained unchanged.

## Selection summary

| API | Proposed cases |
| --- | ---: |
| API-01 | 21 |
| API-02 | 12 |
| API-03 | 4 |
| **Total unique cases** | **37** |

Strong product-defect representatives from the six root clusters are not rerun automatically. Rerun selection is limited to cases affected by proposed test/harness corrections, test-data corrections, and unresolved external verification.

## Rerun work packages

### TR-01

- ROOT_CAUSE_OR_FIXTURE: `RESET_MULTI_STEP_COLLAPSED`
- CORRECTION_TYPE: `HARNESS`
- AFFECTED_CASES: `[API01-STU-001, API01-STU-002, API01-STU-003, API01-STU-004, API01-STU-005]`
- RERUN_CASES: same list
- WHY_RERUN_NEEDED: Approved multi-step state transitions were not executed; correction must prove each intermediate/final state without changing the oracle.

### TR-02

- ROOT_CAUSE_OR_FIXTURE: `RESET_TOKEN_FIXTURE_NOT_REFRESHED_PER_CASE`
- CORRECTION_TYPE: `TEST_DATA`
- AFFECTED_CASES: `[API01-AI-002, API01-AI-007, API01-AI-009, API01-AI-010, API01-AI-012, API01-AI-014, API01-AI-018, API01-AI-019, API01-AI-021, API01-AI-022, API01-AI-023, API01-AI-024, API01-AI-029, API01-AI-035]`
- RERUN_CASES: same list
- WHY_RERUN_NEEDED: Each case needs a fresh disposable email-bound OTP so its intended variation, rather than stale-token rejection, determines the outcome.

### TR-03

- ROOT_CAUSE_OR_FIXTURE: `EXPIRED_RESET_TOKEN_FIXTURE_UNAVAILABLE`
- CORRECTION_TYPE: `TEST_DATA`
- AFFECTED_CASES: `[API01-AI-016]`
- RERUN_CASES: `[API01-AI-016]`
- WHY_RERUN_NEEDED: A legitimate expired-reset-token state must exist before expiration behavior can be evaluated. If no non-production mechanism exists, keep blocked rather than inventing evidence.

### TR-04

- ROOT_CAUSE_OR_FIXTURE: `API01_INJECTION_EXTERNAL_BASELINE_MISSING`
- CORRECTION_TYPE: `EXTERNAL_VERIFICATION`
- AFFECTED_CASES: `[API01-AI-027]`
- RERUN_CASES: `[API01-AI-027]`
- WHY_RERUN_NEEDED: Capture read-only user-datastore snapshots immediately before and after the exact action.

### TR-05

- ROOT_CAUSE_OR_FIXTURE: `CHECKOUT_AUTH_VARIATION_OR_SEQUENCE_MISMATCH`
- CORRECTION_TYPE: `HARNESS`
- AFFECTED_CASES: `[API02-AI-018, API02-STU-001]`
- RERUN_CASES: same list
- WHY_RERUN_NEEDED: One case must truly omit auth; the other must run invalid then valid checkout over the same cart with intermediate/final postchecks.

### TR-06

- ROOT_CAUSE_OR_FIXTURE: `EXPIRED_JWT_FIXTURE_UNAVAILABLE`
- CORRECTION_TYPE: `TEST_DATA`
- AFFECTED_CASES: `[API02-AI-024, API03-AI-025]`
- RERUN_CASES: same list
- WHY_RERUN_NEEDED: A signed expired JWT is required; an empty token tests missing auth, not expiration.

### TR-07

- ROOT_CAUSE_OR_FIXTURE: `API02_CART_STATE_OR_VALUE_FIXTURE_MISMATCH`
- CORRECTION_TYPE: `TEST_DATA`
- AFFECTED_CASES: `[API02-AI-001, API02-AI-009, API02-AI-034, API02-AI-035]`
- RERUN_CASES: same list
- WHY_RERUN_NEEDED: Establish isolated cart shapes and derive equal/small-difference inputs from the actual cart snapshot before each action.

### TR-08

- ROOT_CAUSE_OR_FIXTURE: `API02_OTHER_USER_FIXTURE_INCOMPLETE`
- CORRECTION_TYPE: `TEST_DATA`
- AFFECTED_CASES: `[API02-STU-002]`
- RERUN_CASES: `[API02-STU-002]`
- WHY_RERUN_NEEDED: Populate `otherUserId` and the actual victim-cart total before identity-spoof execution.

### TR-09

- ROOT_CAUSE_OR_FIXTURE: `API02_APPROVED_SEQUENCE_OR_PAYLOAD_NOT_IMPLEMENTED`
- CORRECTION_TYPE: `HARNESS`
- AFFECTED_CASES: `[API02-AI-016, API02-STU-003, API02-STU-005, API02-STU-006]`
- RERUN_CASES: same list
- WHY_RERUN_NEEDED: Implement the declared cart mutation, simultaneous total/address injection, and two-user sequences exactly; do not weaken the oracle.

### TR-10

- ROOT_CAUSE_OR_FIXTURE: `API03_MULTI_PRODUCT_PAYLOAD_MISMATCH`
- CORRECTION_TYPE: `HARNESS`
- AFFECTED_CASES: `[API03-AI-016]`
- RERUN_CASES: `[API03-AI-016]`
- WHY_RERUN_NEEDED: Send multiple valid unique products and externally verify all commit/report together.

### TR-11

- ROOT_CAUSE_OR_FIXTURE: `API03_APPROVED_SEQUENCE_NOT_IMPLEMENTED`
- CORRECTION_TYPE: `HARNESS`
- AFFECTED_CASES: `[API03-STU-004, API03-STU-006]`
- RERUN_CASES: same list
- WHY_RERUN_NEEDED: Execute the prior commit and later invalid/non-admin attempt as separate steps with baseline/post-state evidence.

## Execution gate for future run-002

Before execution, Human must approve each proposed reclassification/correction. Then static-verify that stable case IDs and requirement oracles are unchanged, create fresh disposable fixtures, and run only the 37 selected identities with their required helper/postcondition requests. Preserve `run-001`; write all new raw evidence under `test-results/hw06/run-002/`.

Do not rerun the remaining 56 cases unless Human determines that a shared-state correction invalidates their run-001 evidence.

## run-002 outcome

- Target identities accounted: `37/37`, all unique.
- Stable case requests executed: `36`; `API01-AI-016` was intentionally skipped and classified `BLOCKED / TEST_DATA_DEFECT` because no legitimate expired-OTP fixture exists.
- Results: `15 PASS`, `21 FAIL`, `0 POSTMAN_PASS_EXTERNAL_PENDING`, `1 BLOCKED`, `0 NOT_RUN`.
- Corrective cases: `35 APPLIED_AND_RERUN`; `1 HUMAN_REVIEW_REQUIRED`.
- Existing confirmed-defect evidence: `12` failures; new API-01 Product Defect Candidate evidence: `9` failures across `3` proposed root clusters.
- Original 29-case Human-confirmed product-defect evidence set rerun: `0`.
- Evidence: `test-results/hw06/run-002/` and `docs/execution-results/run-002-correction-record.md`.
