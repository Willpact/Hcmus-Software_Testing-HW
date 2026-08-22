# run-002 new-defect Human Review packet

## Review boundary and run summary

- RUN_ID: `run-002`
- RUN_STATUS: `PRESERVED_REAL_TARGETED_EXECUTION`
- EXPECTED_TARGETED_SCOPE: `37`
- ACTUAL_SCOPE: `37`
- STABLE_CASE_REQUESTS_EXECUTED: `36`
- PASS: `15`
- FAIL: `21`
- BLOCKED: `1`
- NEW_PRODUCT_DEFECT_CANDIDATES_REVIEWED: `9`
- NEW_ROOT_CLUSTERS_RECONSTRUCTED: `3`
- EXISTING_HUMAN_CONFIRMED_DEFECTS: `6`
- ADDITIONAL_RERUN_REQUIRED: `NO`
- HUMAN_DECISIONS: `FINALIZED`

Evidence was read from the genuine `run-002` Newman JSON/HTML/log/metadata, case accounting, approved final tests, requirement analysis, and read-only external verification. Newman recorded `0` runner assertion failures; those assertions establish harness execution only. The FAIL classifications below come from the approved business/state oracles applied to real responses and isolated post-state evidence.

## Nine-candidate matrix

| CASE_ID | API | ROOT_CLUSTER | REQUIREMENT | RUN_002_STATUS | OBSERVED_FAILURE | EXTERNAL_VERIFICATION | EVIDENCE_STRENGTH | AI_RECOMMENDATION | HUMAN_DECISION |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| API01-AI-007 | API-01 | RC-01-N01 | API01-REQ-002, API01-REQ-005 | FAIL; HTTP 200 | A reset without `newPassword` was reported successful; post-state changed and the fresh OTP was invalidated. | Isolated user state changed; token absent; rightful follow-up could not reuse it. | STRONG | CONFIRM_PRODUCT_DEFECT | CONFIRM_PRODUCT_DEFECT |
| API01-AI-009 | API-01 | RC-01-N02 | API01-REQ-005 | FAIL; HTTP 200 | A seven-character password was accepted as a successful reset. | Isolated user row changed and token was invalidated. | STRONG | CONFIRM_PRODUCT_DEFECT | CONFIRM_PRODUCT_DEFECT |
| API01-AI-018 | API-01 | RC-01-N02 | API01-REQ-005, API01-REQ-009 | FAIL; HTTP 200 | A weak password was accepted as a successful reset. | Isolated row classified `WEAK_PLAINTEXT`; token absent. | STRONG | CONFIRM_PRODUCT_DEFECT | CONFIRM_PRODUCT_DEFECT |
| API01-AI-021 | API-01 | RC-01-N02 | API01-REQ-005 | FAIL; HTTP 200 | A password missing uppercase was accepted. | Isolated user row changed; token absent. | STRONG | CONFIRM_PRODUCT_DEFECT | CONFIRM_PRODUCT_DEFECT |
| API01-AI-022 | API-01 | RC-01-N02 | API01-REQ-005 | FAIL; HTTP 200 | A password missing lowercase was accepted. | Isolated user row changed; token absent. | STRONG | CONFIRM_PRODUCT_DEFECT | CONFIRM_PRODUCT_DEFECT |
| API01-AI-023 | API-01 | RC-01-N02 | API01-REQ-005 | FAIL; HTTP 200 | A password missing a digit was accepted. | Isolated user row changed; token absent. | STRONG | CONFIRM_PRODUCT_DEFECT | CONFIRM_PRODUCT_DEFECT |
| API01-AI-024 | API-01 | RC-01-N02 | API01-REQ-005 | FAIL; HTTP 200 | A password missing an allowed special character was accepted. | Isolated user row changed; token absent. | STRONG | CONFIRM_PRODUCT_DEFECT | CONFIRM_PRODUCT_DEFECT |
| API01-AI-035 | API-01 | RC-01-N03 | API01-REQ-008 | FAIL; HTTP 200 plus external FAIL | The successful reset persisted a value equal to the submitted plaintext. | Correct case-specific disposable user was found in the isolated run-002 database; boolean equality was true; password value was not logged. | STRONG | CONFIRM_PRODUCT_DEFECT | CONFIRM_PRODUCT_DEFECT |
| API01-STU-002 | API-01 | RC-01-N02 | API01-REQ-005, API01-REQ-009 | FAIL; final HTTP 400 | Weak step succeeded; corrected strong retry with the same OTP then failed because the token had already been consumed. | Isolated row classified `WEAK_PLAINTEXT`; token absent after weak step. | STRONG | CONFIRM_PRODUCT_DEFECT | CONFIRM_PRODUCT_DEFECT |

## Per-case source verification

| CASE_ID | ORACLE | SETUP | REQUEST VARIATION | POSTMAN ASSERTION | CURRENT CLASSIFICATION |
| --- | --- | --- | --- | --- | --- |
| API01-AI-007 | A reset cannot establish the required new password when `newPassword` is absent; no successful reset/state transition. | Fresh email-bound OTP for an isolated disposable user. | Omit `newPassword`. | Runner/harness assertions passed; final business oracle failed from HTTP and post-state. | PRODUCT_DEFECT_CANDIDATE |
| API01-AI-009 | Password shorter than 8 characters is not accepted. | Fresh email-bound OTP. | Seven-character value containing the required classes. | Runner/harness assertions passed; business oracle failed. | PRODUCT_DEFECT_CANDIDATE |
| API01-AI-018 | Weak-password validation must not complete reset or consume the OTP. | Fresh email-bound OTP. | Weak value missing required classes. | Runner/harness assertions passed; business/state oracle failed. | PRODUCT_DEFECT_CANDIDATE |
| API01-AI-021 | Missing-uppercase password is not accepted. | Fresh email-bound OTP. | Sufficient length, no uppercase. | Runner/harness assertions passed; business oracle failed. | PRODUCT_DEFECT_CANDIDATE |
| API01-AI-022 | Missing-lowercase password is not accepted. | Fresh email-bound OTP. | Sufficient length, no lowercase. | Runner/harness assertions passed; business oracle failed. | PRODUCT_DEFECT_CANDIDATE |
| API01-AI-023 | Missing-digit password is not accepted. | Fresh email-bound OTP. | Sufficient length, no digit. | Runner/harness assertions passed; business oracle failed. | PRODUCT_DEFECT_CANDIDATE |
| API01-AI-024 | Missing-special-character password is not accepted. | Fresh email-bound OTP. | Sufficient length, no allowed special character. | Runner/harness assertions passed; business oracle failed. | PRODUCT_DEFECT_CANDIDATE |
| API01-AI-035 | Persisted password must not equal submitted plaintext. | Successful reset for a case-specific disposable user; read-only access to the isolated runtime datastore. | Valid reset followed by safe persistence comparison. | Runner/harness assertions passed; required external oracle returned FAIL. | PRODUCT_DEFECT_CANDIDATE |
| API01-STU-002 | Failed weak validation must not consume the token; a corrected strong retry may use it. | One fresh email-bound OTP and isolated user. | Weak attempt, then strong retry with the same OTP. | Runner/harness assertions passed; sequence/state oracle failed. | PRODUCT_DEFECT_CANDIDATE |

No invented status-code or response-schema oracle is used: authoritative sources leave those transport details unspecified.

## RC-01-N01

- CLUSTER_ID: `RC-01-N01`
- API: `POST /api/reset-password`
- HYPOTHESIS: `MISSING_NEW_PASSWORD_ACCEPTED_AS_SUCCESSFUL_RESET`
- AFFECTED_CASES: `[API01-AI-007]`
- PRIMARY_EVIDENCE_CASE: `API01-AI-007`
- SUPPORTING_CASES: `[]`
- AUTHORITATIVE_REQUIREMENTS: `[API01-REQ-002, API01-REQ-005]`
- EXPECTED_INVARIANT: A reset cannot establish a required new password or complete the successful-reset transition when `newPassword` is absent.
- OBSERVED_BEHAVIOR: With a valid isolated email/OTP setup and omitted `newPassword`, the SUT returned HTTP 200 success, changed the isolated database, and invalidated the OTP.
- EXTERNAL_EVIDENCE: `case-accounting.json` plus `external-hook-evidence.json` show changed database hash, case-specific post-state, and absent reset token; the approved post-action check could not reuse the token.
- RUN_ID: `run-002`
- EVIDENCE_STRENGTH: `STRONG`
- AI_RECOMMENDATION: `CONFIRM_PRODUCT_DEFECT`
- HUMAN_DECISION: `CONFIRM_PRODUCT_DEFECT`
- OVERLAPS_EXISTING_DEFECT: `NO`
- MERGE_REASON: The six confirmed clusters concern checkout amount/cart/auth or product import validation/atomicity/admin role; none covers reset request required-field handling.
- RECOMMENDED_SCREENSHOT_SOURCE: genuine `run-002/newman.html` request card plus external JSON as state evidence
- RECOMMENDED_CASE: `API01-AI-007`
- REPORT_PATH: `test-results/hw06/run-002/newman.html`

## RC-01-N02

- CLUSTER_ID: `RC-01-N02`
- API: `POST /api/reset-password`
- HYPOTHESIS: `RESET_PASSWORD_STRENGTH_RULE_NOT_ENFORCED`
- AFFECTED_CASES: `[API01-AI-009, API01-AI-018, API01-AI-021, API01-AI-022, API01-AI-023, API01-AI-024, API01-STU-002]`
- PRIMARY_EVIDENCE_CASE: `API01-AI-018`
- SUPPORTING_CASES: `[API01-AI-009, API01-AI-021, API01-AI-022, API01-AI-023, API01-AI-024, API01-STU-002]`
- AUTHORITATIVE_REQUIREMENTS: `[API01-REQ-005, API01-REQ-009]`
- EXPECTED_INVARIANT: A password that violates minimum length or any required character class cannot complete reset; a validation failure cannot consume the OTP as successful use.
- OBSERVED_BEHAVIOR: All seven variations demonstrate acceptance of a weak password. The six single-action cases returned HTTP 200; the two-step student case showed weak success followed by HTTP 400 on a compliant same-token retry.
- EXTERNAL_EVIDENCE: Per-case isolated database hashes changed, affected user rows changed, and reset tokens were absent. `API01-AI-018` and `API01-STU-002` were explicitly classified `WEAK_PLAINTEXT` without recording the value.
- RUN_ID: `run-002`
- EVIDENCE_STRENGTH: `STRONG`
- AI_RECOMMENDATION: `CONFIRM_PRODUCT_DEFECT`
- HUMAN_DECISION: `CONFIRM_PRODUCT_DEFECT`
- OVERLAPS_EXISTING_DEFECT: `NO`
- MERGE_REASON: No confirmed checkout/import defect represents password-strength validation or reset-token consumption after a weak-password attempt.
- RECOMMENDED_SCREENSHOT_SOURCE: genuine `run-002/newman.html` sequence/card plus `external-hook-evidence.json`
- RECOMMENDED_CASE: `API01-AI-018`
- REPORT_PATH: `test-results/hw06/run-002/newman.html`

## RC-01-N03

- CLUSTER_ID: `RC-01-N03`
- API: `POST /api/reset-password`
- HYPOTHESIS: `RESET_PASSWORD_STORES_PASSWORD_AS_PLAINTEXT`
- AFFECTED_CASES: `[API01-AI-035]`
- PRIMARY_EVIDENCE_CASE: `API01-AI-035`
- SUPPORTING_CASES: `[]`
- AUTHORITATIVE_REQUIREMENTS: `[API01-REQ-008]`
- EXPECTED_INVARIANT: The post-reset persisted password representation must not equal the submitted plaintext password.
- OBSERVED_BEHAVIOR: The reset completed, and read-only comparison of the case-specific post-reset row returned `plaintext_equal: true`.
- EXTERNAL_EVIDENCE: `external-verification-results.json` records `user_found: true`, `plaintext_equal: true`, and `password_value_logged: false`. `external-hook-evidence.json` identifies the case-specific disposable user, its changed per-case database hash, `NEW_STRONG` post-state label, and invalidated token. The run metadata ties verification to the isolated writable runtime database. No unrelated field or user was compared, and no shared/stale fixture remains in this corrected case.
- RUN_ID: `run-002`
- EVIDENCE_STRENGTH: `STRONG`
- AI_RECOMMENDATION: `CONFIRM_PRODUCT_DEFECT`
- HUMAN_DECISION: `CONFIRM_PRODUCT_DEFECT`
- OVERLAPS_EXISTING_DEFECT: `NO`
- MERGE_REASON: None of the six confirmed checkout/import clusters covers password persistence protection.
- RECOMMENDED_SCREENSHOT_SOURCE: genuine `run-002/newman.html` successful-reset card plus redacted external verification view
- RECOMMENDED_CASE: `API01-AI-035`
- REPORT_PATH: `test-results/hw06/run-002/newman.html`

## Existing-defect overlap matrix

| NEW_CLUSTER | RC-02-01 / DEF-01 | RC-02-02 / DEF-02 | RC-02-03 / DEF-03 | RC-03-01 / DEF-04 | RC-03-02 / DEF-05 | RC-03-03 / DEF-06 | RESULT |
| --- | --- | --- | --- | --- | --- | --- | --- |
| RC-01-N01 | Different API/invariant | Different API/invariant | Different API/invariant | Different API/invariant | Different API/invariant | Different API/invariant | NO OVERLAP |
| RC-01-N02 | Different API/invariant | Different API/invariant | Different API/invariant | Different API/invariant | Different API/invariant | Different API/invariant | NO OVERLAP |
| RC-01-N03 | Different API/invariant | Different API/invariant | Different API/invariant | Different API/invariant | Different API/invariant | Different API/invariant | NO OVERLAP |

`API02-STU-001` is excluded from the nine new candidates and preserved only as run-002 corroboration for existing `DEF-02 / RC-02-02`.

## API01-AI-016 non-product disposition

- FINAL_CURRENT_STATUS: `BLOCKED_TEST_DATA`
- ROOT_CAUSE: `EXPIRED_OTP_FIXTURE_UNAVAILABLE`
- PRODUCT_INFERENCE_ALLOWED: `NO`
- AUTHORITATIVE_CONTEXT: `API01-REQ-009` requires expiry, but the approved analysis does not define an expiry duration or a controllable endpoint/fixture for advancing an issued token into an unambiguous expired state.
- DETERMINATION: The immediate execution blocker is inability to deterministically create a legitimate expired state. No fake empty/stale token, invented duration, request execution, or product inference is permitted.

## Human decision outcome

Human Review approved all three strong clusters as distinct Product Defects. DEF-07, DEF-08, and DEF-09 reports are now created; GitHub Issues and screenshot files remain uncreated.

- RC-01-N01 HUMAN_DECISION: `CONFIRM_PRODUCT_DEFECT`
- RC-01-N02 HUMAN_DECISION: `CONFIRM_PRODUCT_DEFECT`
- RC-01-N03 HUMAN_DECISION: `CONFIRM_PRODUCT_DEFECT`
- ADDITIONAL_RERUN_REQUIRED: `NO`

```text
STUDENT_DECISION:
APPROVED

RC-01-N01:
CONFIRM_PRODUCT_DEFECT

RC-01-N02:
CONFIRM_PRODUCT_DEFECT

RC-01-N03:
CONFIRM_PRODUCT_DEFECT
```
