# HW06 Human Failure Triage Packet

## 1. Run-001 summary

`run-001` is accepted and preserved as the original full real execution. Human review is finalized as `MODIFIED_AND_APPROVED`: 29 testcase failures map to six confirmed distinct product defects, four failures are reclassified as `TEST_DEFECT`, and five failures are reclassified as `TEST_DATA_DEFECT`.

| Metric | Count |
| --- | ---: |
| Final testcase identities | 93 |
| PASS | 27 |
| FAIL / current PRODUCT_DEFECT_CANDIDATE | 38 |
| POSTMAN_PASS_EXTERNAL_PENDING | 1 |
| BLOCKED | 27 |
| Current TEST_DEFECT | 10 |
| Current TEST_DATA_DEFECT | 17 |
| Product-defect evidence cases | 29 |
| Distinct product defects finally confirmed | 6 |

Evidence reviewed: `test-results/hw06/run-001/newman.json`, `case-accounting.json`, `external-verification-results.json`, the two cart postchecks, read-only SQLite state, approved final testcase records, and the authoritative requirement analyses. Newman exit `0` is runner evidence only; it is not treated as 93 business PASS.

## 2. Product Defect Candidate root clusters

### RC-02-01

- CLUSTER_ID: `RC-02-01`
- ROOT_CAUSE_HYPOTHESIS: `CLIENT_SUPPLIED_TOTAL_TRUSTED`
- API: `API-02`
- AUTHORITATIVE_REQUIREMENTS: `API02-REQ-005`, `API02-REQ-006` (plus request-shape context in `API02-REQ-003` where applicable)
- AFFECTED_CASES: `[API02-AI-002, API02-AI-003, API02-AI-004, API02-AI-005, API02-AI-006, API02-AI-007, API02-AI-010, API02-AI-017, API02-AI-025, API02-AI-037]`
- REPRESENTATIVE_CASES: `[API02-AI-002, API02-AI-003, API02-AI-007, API02-AI-025]`
- PRIMARY_EVIDENCE_CASE: `API02-AI-002`
- SUPPORTING_CASES: `[API02-AI-003, API02-AI-004, API02-AI-005, API02-AI-006, API02-AI-007, API02-AI-010, API02-AI-017, API02-AI-025, API02-AI-037]`
- SHARED_OBSERVED_BEHAVIOR: With independently derived primary-cart total `400000`, persisted order totals followed client input (`1`, `999999999`, `0`, `-1`, `200000`, `NULL`, and the SQL-like string) instead of the cart total. The implementation inserts `total_amount` directly.
- SHARED_EXPECTED_INVARIANT: The server derives the authoritative checkout amount from the authenticated user's current cart; client `total_amount` is not authoritative.
- EVIDENCE: `run-001/newman.json`, read-only `orders` inspection summarized in `case-accounting.json`, and `eshop-sut/backend/server.js` checkout path.
- DISTINCT_DEFECT_HYPOTHESIS: `YES`
- EVIDENCE_STRENGTH: `STRONG`
- AI_RECOMMENDATION: `CONFIRM_AS_ONE_PRODUCT_DEFECT`
- HUMAN_DECISION: `CONFIRM_PRODUCT_DEFECT`

### RC-02-02

- CLUSTER_ID: `RC-02-02`
- ROOT_CAUSE_HYPOTHESIS: `SUCCESSFUL_CHECKOUT_DOES_NOT_CLEAR_CART`
- API: `API-02`
- AUTHORITATIVE_REQUIREMENTS: `API02-REQ-007`
- AFFECTED_CASES: `[API02-AI-002, API02-AI-003, API02-AI-004, API02-AI-005, API02-AI-006, API02-AI-007, API02-AI-010, API02-AI-014, API02-AI-017, API02-AI-025, API02-AI-026, API02-AI-029, API02-AI-036, API02-AI-037]`
- REPRESENTATIVE_CASES: `[API02-AI-014, API02-AI-036]`
- PRIMARY_EVIDENCE_CASE: `API02-AI-014`
- SUPPORTING_CASES: `[API02-AI-036, API02-AI-026, API02-AI-029]` plus the successful checkout cases listed above.
- SHARED_OBSERVED_BEHAVIOR: Primary cart stayed `2` lines before/after and second-user cart stayed `1` line; checkout returned success and persisted orders. The checkout implementation contains no cart-clear operation.
- SHARED_EXPECTED_INVARIANT: A successful checkout clears only the authenticated user's cart.
- EVIDENCE: `run-001/external-postcheck.newman.json`, `case-accounting.json` cart evidence, and checkout implementation inspection.
- DISTINCT_DEFECT_HYPOTHESIS: `YES`
- EVIDENCE_STRENGTH: `STRONG`
- AI_RECOMMENDATION: `CONFIRM_AS_ONE_PRODUCT_DEFECT`
- HUMAN_DECISION: `CONFIRM_PRODUCT_DEFECT`

### RC-02-03

- CLUSTER_ID: `RC-02-03`
- ROOT_CAUSE_HYPOTHESIS: `AUTHORIZATION_SCHEME_NOT_ENFORCED`
- API: `API-02`
- AUTHORITATIVE_REQUIREMENTS: `API02-REQ-002`, `API02-REQ-010`
- AFFECTED_CASES: `[API02-AI-022]`
- REPRESENTATIVE_CASES: `[API02-AI-022]`
- PRIMARY_EVIDENCE_CASE: `API02-AI-022`
- SUPPORTING_CASES: `[]`
- SHARED_OBSERVED_BEHAVIOR: The actual request used `Authorization: Basic <valid JWT>` and received successful checkout. Authentication extracts the second space-delimited value without verifying the `Bearer` scheme.
- SHARED_EXPECTED_INVARIANT: Sensitive checkout requires a valid Bearer JWT, not a token under an arbitrary scheme.
- EVIDENCE: `run-001/newman.json` request headers/response and `authenticateToken` implementation inspection.
- DISTINCT_DEFECT_HYPOTHESIS: `YES`
- EVIDENCE_STRENGTH: `STRONG`
- AI_RECOMMENDATION: `CONFIRM_AS_ONE_PRODUCT_DEFECT`
- HUMAN_DECISION: `CONFIRM_PRODUCT_DEFECT`

### RC-03-01

- CLUSTER_ID: `RC-03-01`
- ROOT_CAUSE_HYPOTHESIS: `PRODUCT_PRICE_POSITIVITY_NOT_ENFORCED`
- API: `API-03`
- AUTHORITATIVE_REQUIREMENTS: `API03-REQ-007` and atomic/reporting consequences in `API03-REQ-009`, `API03-REQ-010`
- AFFECTED_CASES: `[API03-AI-009, API03-AI-010, API03-AI-018, API03-AI-022, API03-AI-038, API03-STU-003]`
- REPRESENTATIVE_CASES: `[API03-AI-009, API03-AI-010]`
- PRIMARY_EVIDENCE_CASE: `API03-AI-009`
- SUPPORTING_CASES: `[API03-AI-010, API03-AI-018, API03-AI-022, API03-AI-038, API03-STU-003]`
- SHARED_OBSERVED_BEHAVIOR: Price `0` and `-1` rows were reported inserted and are present in SQLite; import validates missing name but has no positive-price guard.
- SHARED_EXPECTED_INVARIANT: Every imported product has a non-empty name and positive price; a row with non-positive price invalidates the batch.
- EVIDENCE: actual request/response pairs in `run-001/newman.json`, read-only product rows, and import implementation inspection.
- DISTINCT_DEFECT_HYPOTHESIS: `YES`
- EVIDENCE_STRENGTH: `STRONG`
- AI_RECOMMENDATION: `CONFIRM_AS_ONE_PRODUCT_DEFECT`
- HUMAN_DECISION: `CONFIRM_PRODUCT_DEFECT`

### RC-03-02

- CLUSTER_ID: `RC-03-02`
- ROOT_CAUSE_HYPOTHESIS: `IMPORT_NOT_ATOMIC`
- API: `API-03`
- AUTHORITATIVE_REQUIREMENTS: `API03-REQ-009`, with validation context in `API03-REQ-007`
- AFFECTED_CASES: `[API03-AI-017, API03-AI-019, API03-AI-020, API03-AI-021]`
- REPRESENTATIVE_CASES: `[API03-AI-017, API03-AI-019]`
- PRIMARY_EVIDENCE_CASE: `API03-AI-017`
- SUPPORTING_CASES: `[API03-AI-019, API03-AI-020, API03-AI-021]`
- SHARED_OBSERVED_BEHAVIOR: In batches where missing name was recognized as an error, valid sibling rows were still inserted (`1/2`) and remained in SQLite. The implementation iterates independent inserts without a transaction rollback.
- SHARED_EXPECTED_INVARIANT: Any invalid row causes all-or-nothing rollback for the current import; later retry must not inherit partial rows.
- EVIDENCE: actual inserted/error report, unique case-name persistence in SQLite, and import implementation inspection.
- DISTINCT_DEFECT_HYPOTHESIS: `YES`
- EVIDENCE_STRENGTH: `STRONG`
- AI_RECOMMENDATION: `CONFIRM_AS_ONE_PRODUCT_DEFECT`
- HUMAN_DECISION: `CONFIRM_PRODUCT_DEFECT`

### RC-03-03

- CLUSTER_ID: `RC-03-03`
- ROOT_CAUSE_HYPOTHESIS: `ADMIN_ROLE_NOT_ENFORCED`
- API: `API-03`
- AUTHORITATIVE_REQUIREMENTS: `API03-REQ-002`, `API03-REQ-003`
- AFFECTED_CASES: `[API03-AI-026, API03-AI-028, API03-STU-001, API03-STU-002]`
- REPRESENTATIVE_CASES: `[API03-AI-026, API03-AI-028]`
- PRIMARY_EVIDENCE_CASE: `API03-AI-026`
- SUPPORTING_CASES: `[API03-AI-028, API03-STU-001, API03-STU-002]`
- SHARED_OBSERVED_BEHAVIOR: A verified non-admin JWT reached import and persisted rows; body `role=admin` did not need to be authoritative because the endpoint never checks `req.user.role`.
- SHARED_EXPECTED_INVARIANT: Only authenticated admins may import products; payload role cannot elevate a user token.
- EVIDENCE: actual non-admin login/token setup, successful import responses, persisted case-name products, and endpoint middleware inspection.
- DISTINCT_DEFECT_HYPOTHESIS: `YES`
- EVIDENCE_STRENGTH: `STRONG`
- AI_RECOMMENDATION: `CONFIRM_AS_ONE_PRODUCT_DEFECT`
- HUMAN_DECISION: `CONFIRM_PRODUCT_DEFECT`

The six hypotheses are distinct: total derivation, cart state, authentication scheme, price validation, transactional atomicity, and role authorization have separate implementation boundaries. No coupon, empty-cart, shipping validation, idempotency, initial order status, duplicate, category, precision, batch-size, raw-CSV, or FR-15-only rule is used as a defect oracle.

## 3. Candidate-case decision matrix

| CASE_ID | API | ROOT_CLUSTER | REQUIREMENT | OBSERVED_FAILURE | CURRENT_CLASSIFICATION | AI_RECOMMENDATION | EVIDENCE_STRENGTH | HUMAN_DECISION_AT_A019 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| API02-AI-001 | API-02 | PROPOSED-DATA-02-01 | API02-REQ-005/006/007 | Client value intended to equal cart was `200000`, but actual contaminated cart total was `400000`; failure cannot isolate the intended happy-path total condition. | PRODUCT_DEFECT_CANDIDATE | RECLASSIFY_TEST_DATA_DEFECT | WEAK | PENDING |
| API02-AI-002 | API-02 | RC-02-01 | API02-REQ-005/006 | Client `1` persisted instead of derived `400000`. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-AI-003 | API-02 | RC-02-01 | API02-REQ-005/006 | Client `999999999` persisted instead of derived `400000`. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-AI-004 | API-02 | RC-02-01 | API02-REQ-005/006 | Client `0` persisted for a positive cart total. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-AI-005 | API-02 | RC-02-01 | API02-REQ-005/006 | Client `-1` persisted for a positive cart total. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-AI-006 | API-02 | RC-02-01 | API02-REQ-003/006 | Numeric-string client amount became persisted authority. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-AI-007 | API-02 | RC-02-01 | API02-REQ-003/006 | Omitted client amount produced a successful order with `NULL` total instead of cart-derived total or rejection. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-AI-009 | API-02 | PROPOSED-DATA-02-01 | API02-REQ-005/006 | Case required a one-line cart, but shared cart had two lines. | PRODUCT_DEFECT_CANDIDATE | RECLASSIFY_TEST_DATA_DEFECT | WEAK | PENDING |
| API02-AI-010 | API-02 | RC-02-01 | API02-REQ-005/006 | First-line amount `200000` persisted while complete cart total was `400000`. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-AI-014 | API-02 | RC-02-02 | API02-REQ-005/007 | Successful checkout left the authenticated cart populated. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-AI-016 | API-02 | PROPOSED-TEST-02-01 | API02-REQ-005/006 | Approved cart-change-before-checkout sequence was not implemented. | PRODUCT_DEFECT_CANDIDATE | RECLASSIFY_TEST_DEFECT | WEAK | PENDING |
| API02-AI-017 | API-02 | RC-02-01 | API02-REQ-004/005 | User A order persisted `200000` while A cart total was `400000`; user-specific carts were available. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-AI-022 | API-02 | RC-02-03 | API02-REQ-002/010 | `Basic <valid JWT>` was accepted for successful checkout. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-AI-025 | API-02 | RC-02-01 | API02-REQ-005/006 | SQL-like total string was persisted as the order amount. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-AI-026 | API-02 | RC-02-02 | API02-REQ-003/011 | Injection-like address remained data, but successful checkout did not clear cart. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-AI-029 | API-02 | RC-02-02 | API02-REQ-001/002/003 | Contract-shaped successful checkout did not clear cart. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-AI-034 | API-02 | PROPOSED-DATA-02-01 | API02-REQ-005/006 | Supposed equal client/cart fixture was `200000` versus actual `400000`. | PRODUCT_DEFECT_CANDIDATE | RECLASSIFY_TEST_DATA_DEFECT | WEAK | PENDING |
| API02-AI-035 | API-02 | PROPOSED-DATA-02-01 | API02-REQ-005/006 | Intended small decimal mismatch was not represented; body reused integer `200000`. | PRODUCT_DEFECT_CANDIDATE | RECLASSIFY_TEST_DATA_DEFECT | WEAK | PENDING |
| API02-AI-036 | API-02 | RC-02-02 | API02-REQ-007 | Postcheck found A and B carts still populated after successful checkout. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-AI-037 | API-02 | RC-02-01 | API02-REQ-005/006/008 | Persisted amount covered only part of the quantity-bearing cart. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API02-STU-002 | API-02 | PROPOSED-DATA-02-02 | API02-REQ-004/005/006/007 | `otherUserId` resolved empty and submitted total did not equal victim cart total. | PRODUCT_DEFECT_CANDIDATE | RECLASSIFY_TEST_DATA_DEFECT | WEAK | PENDING |
| API02-STU-003 | API-02 | PROPOSED-TEST-02-02 | API02-REQ-005/006/007/011 | Address injection was present, but required simultaneous total injection was replaced by normal numeric data. | PRODUCT_DEFECT_CANDIDATE | RECLASSIFY_TEST_DEFECT | WEAK | PENDING |
| API02-STU-005 | API-02 | PROPOSED-TEST-02-03 | API02-REQ-004/005/006/007 | Two-user sequential checkout was collapsed to one request. | PRODUCT_DEFECT_CANDIDATE | RECLASSIFY_TEST_DEFECT | WEAK | PENDING |
| API02-STU-006 | API-02 | PROPOSED-TEST-02-03 | API02-REQ-004/005/006/007 | Cart-change/spoof/stale-total sequence was collapsed; no spoofed user field was sent. | PRODUCT_DEFECT_CANDIDATE | RECLASSIFY_TEST_DEFECT | WEAK | PENDING |
| API03-AI-009 | API-03 | RC-03-01 | API03-REQ-007 | Price `0` row inserted. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API03-AI-010 | API-03 | RC-03-01 | API03-REQ-007 | Price `-1` row inserted. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API03-AI-017 | API-03 | RC-03-02 | API03-REQ-007/009 | Empty-name error recognized, but valid sibling persisted (`1/2`). | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API03-AI-018 | API-03 | RC-03-01 | API03-REQ-007/009 | Negative-price row and valid row both inserted. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API03-AI-019 | API-03 | RC-03-02 | API03-REQ-007/009 | Final empty-name row errored, earlier valid row persisted. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API03-AI-020 | API-03 | RC-03-02 | API03-REQ-007/009 | Mixed batch partially committed despite recognized name error. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API03-AI-021 | API-03 | RC-03-02 | API03-REQ-009 | Valid retry committed while partial rows from prior failed batch remained. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API03-AI-022 | API-03 | RC-03-01 | API03-REQ-010 | Mixed negative-price batch reported `2/2` success and no error. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API03-AI-026 | API-03 | RC-03-03 | API03-REQ-002/003 | Non-admin JWT imported and persisted a product. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API03-AI-028 | API-03 | RC-03-03 | API03-REQ-003 | User JWT with body role tampering imported a product. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API03-AI-038 | API-03 | RC-03-01 | API03-REQ-009/010 | Valid plus negative-price batch reported and persisted `2/2`. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API03-STU-001 | API-03 | RC-03-03 | API03-REQ-002/003/009 | Non-admin mixed batch reached persistence (`1/2`). | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API03-STU-002 | API-03 | RC-03-03 | API03-REQ-002/003/009 | Payload role tampering with user JWT reached persistence (`1/2`). | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |
| API03-STU-003 | API-03 | RC-03-01 | API03-REQ-007/009/011 | Injection-like name remained data, but negative-price sibling inserted and external rollback check failed. | PRODUCT_DEFECT_CANDIDATE | CONFIRM_PRODUCT_DEFECT | STRONG | PENDING |

Recommendation totals: `CONFIRM_PRODUCT_DEFECT: 29`; `RECLASSIFY_TEST_DEFECT: 4`; `RECLASSIFY_TEST_DATA_DEFECT: 5`; `RECLASSIFY_SPEC_AMBIGUITY: 0`; `RECLASSIFY_EXTERNAL_VERIFICATION_PENDING: 0`; `NEEDS_TARGETED_RERUN: 0`. Human approved this mapping. The last matrix column preserves the A-019 pre-decision state; the finalized per-case mapping is:

- `PRODUCT_DEFECT` (29): every matrix row whose `AI_RECOMMENDATION` is `CONFIRM_PRODUCT_DEFECT`, mapped to the six confirmed clusters above.
- `TEST_DEFECT` (4): `[API02-AI-016, API02-STU-003, API02-STU-005, API02-STU-006]`.
- `TEST_DATA_DEFECT` (5): `[API02-AI-001, API02-AI-009, API02-AI-034, API02-AI-035, API02-STU-002]`.

## 4. Test Defect clusters

### Current TEST_DEFECT review (10 cases)

| CASE_ID | ROOT_TEST_PROBLEM | WHY_ORACLE/IMPLEMENTATION_IS_WRONG | SAFE_CORRECTION | SEMANTICS_CHANGED | TARGETED_RERUN_REQUIRED |
| --- | --- | --- | --- | --- | --- |
| API01-STU-001 | `BT-01 RESET_MULTI_STEP_COLLAPSED` | Cross-email failure and rightful-token use were reduced to one reset request. | Implement both steps with fresh A/B users, A-issued OTP, and post-state checks. | NO | YES |
| API01-STU-002 | `BT-01 RESET_MULTI_STEP_COLLAPSED` | Weak-password failure and strong retry were reduced to one request. | Chain weak then strong reset against the same freshly issued OTP. | NO | YES |
| API01-STU-003 | `BT-01 RESET_MULTI_STEP_COLLAPSED` | Wrong-token failure and correct-token recovery were reduced to one request. | Chain wrong then correct token and verify state after each step. | NO | YES |
| API01-STU-004 | `BT-01 RESET_MULTI_STEP_COLLAPSED` | Two-user OTP invalidation isolation was not implemented. | Issue independent OTPs, reset one user, then verify the other token remains usable. | NO | YES |
| API01-STU-005 | `BT-01 RESET_MULTI_STEP_COLLAPSED` | Replay on A plus unused token B was not implemented. | Execute success/replay for A and rightful use for B with isolated fixtures. | NO | YES |
| API02-AI-018 | `BT-02 AUTH_VARIATION_MISMATCH` | Approved missing-auth case sent valid Bearer auth and returned success. | Set request auth to `noauth` and omit `Authorization` explicitly. | NO | YES |
| API02-STU-001 | `BT-03 CHECKOUT_SEQUENCE_COLLAPSED` | Invalid-JWT attempt plus later valid checkout was reduced to one malformed-token request. | Implement both requests over the same cart with intermediate/final cart checks. | NO | YES |
| API03-AI-016 | `BT-04 MULTI_PRODUCT_PAYLOAD_MISMATCH` | Multi-product atomic commit case sent only one product. | Send at least two valid unique products and verify all persist/report together. | NO | YES |
| API03-STU-004 | `BT-05 IMPORT_SEQUENCE_COLLAPSED` | Prior valid commit plus later invalid rollback was reduced to one request. | Execute batch A, snapshot, batch B, then verify A survives and B rolls back. | NO | YES |
| API03-STU-006 | `BT-05 IMPORT_SEQUENCE_COLLAPSED` | Admin commit plus later non-admin mixed attempt was reduced to one request. | Execute both authenticated steps and compare post-state. | NO | YES |

Proposed additional candidate reclassifications: `API02-AI-016`, `API02-STU-003`, `API02-STU-005`, `API02-STU-006`. No correction is applied in this phase.

## 5. Test Data Defect clusters

### Current TEST_DATA_DEFECT review (17 cases)

| DATA_CLUSTER | AFFECTED_CASES | MISSING_OR_INVALID_FIXTURE | ROOT_DATA_PROBLEM | PROPOSED_FIXTURE_CORRECTION | TARGETED_RERUN_REQUIRED |
| --- | --- | --- | --- | --- | --- |
| BD-01 | `[API01-AI-002, API01-AI-007, API01-AI-009, API01-AI-010, API01-AI-012, API01-AI-014, API01-AI-018, API01-AI-019, API01-AI-021, API01-AI-022, API01-AI-023, API01-AI-024, API01-AI-029, API01-AI-035]` | Fresh email-bound issued OTP per case | One shared OTP was consumed early; later cases observed stale-token rejection instead of their intended variation. | Use disposable reset user and fresh issued OTP per case; preserve wrong/weak inputs while keeping the token precondition valid. | YES |
| BD-02 | `[API01-AI-016]` | Genuinely expired reset OTP | No controllable expiry fixture/state was created; an empty or stale token cannot prove expiration behavior. | Add a legitimate harness/state mechanism that establishes expired OTP without changing SUT business logic; otherwise keep blocked. | YES |
| BD-03 | `[API02-AI-024, API03-AI-025]` | Signed expired JWT | `expiredUserToken` was empty/missing, so 401 only proved missing token. | Generate a test-only expired JWT for the disposable user with the existing test secret/config mechanism. | YES |

Proposed additional candidate reclassifications: `API02-AI-001`, `API02-AI-009`, `API02-AI-034`, `API02-AI-035` under `PROPOSED-DATA-02-01` (cart-derived fixture mismatch/state contamination), and `API02-STU-002` under `PROPOSED-DATA-02-02` (missing `otherUserId` and victim-cart-total fixture). No fixture is changed in this phase.

### Blocked-case root clusters

| BLOCK_CLUSTER_ID | TYPE | ROOT_CAUSE | AFFECTED_CASES | SAFE_TO_FIX_WITHOUT_CHANGING_TEST_ORACLE | TARGETED_RERUN |
| --- | --- | --- | --- | --- | --- |
| BC-01 | TEST_DEFECT | API-01 Student Extension sequences collapsed | 5 | YES | REQUIRED |
| BC-02 | TEST_DEFECT | API02-AI-018 auth variation mismatch | 1 | YES | REQUIRED |
| BC-03 | TEST_DEFECT | API02-STU-001 sequence collapsed | 1 | YES | REQUIRED |
| BC-04 | TEST_DEFECT | API03-AI-016 payload cardinality mismatch | 1 | YES | REQUIRED |
| BC-05 | TEST_DEFECT | API-03 Student Extension sequences collapsed | 2 | YES | REQUIRED |
| BC-06 | TEST_DATA_DEFECT | Shared/consumed reset OTP state | 14 | YES | REQUIRED |
| BC-07 | TEST_DATA_DEFECT | Expired reset OTP unavailable | 1 | UNCERTAIN | REQUIRED |
| BC-08 | TEST_DATA_DEFECT | Expired JWT unavailable | 2 | YES | REQUIRED |

All current `27` blocked cases map to exactly one of these `8` blocker root clusters: `10` current test defects and `17` current test-data defects. No blocked API-01 case is promoted to a product defect.

## 6. External verification unresolved

| CASE_ID | STATUS | WHY_UNRESOLVED | VERIFICATION_REQUIRED | AVAILABLE_MECHANISM | MISSING_DEPENDENCY | AI_RECOMMENDATION |
| --- | --- | --- | --- | --- | --- | --- |
| API01-AI-027 | PENDING | No exact before/after user-datastore snapshot surrounded the injection-email action. | Prove no unauthorized user-data mutation around the exact action. | Targeted request plus read-only SQLite snapshots. | Per-case baseline captured before action. | KEEP_EXTERNAL_PENDING |
| API01-AI-035 | BLOCKED | Shared OTP was already consumed, so this case did not execute a successful password change. | Successful fresh-OTP reset then `PLAINTEXT_EQUAL: YES/NO` read-only comparison without logging password. | Disposable reset user plus read-only SQLite. | Fresh valid OTP fixture. | RECLASSIFY_BLOCKED |
| API02-STU-001 | BLOCKED | Approved invalid-then-valid two-step sequence and intermediate cart evidence were absent. | Capture cart before, after invalid JWT, and after valid checkout. | Corrected two-step Postman harness plus cart postchecks. | Implemented sequence and intermediate snapshot. | RECLASSIFY_BLOCKED |

## 7. Proposed targeted rerun scope

Do not execute yet. Proposed `run-002` contains `37` unique cases only:

- Current TEST_DEFECT corrections (10): `[API01-STU-001, API01-STU-002, API01-STU-003, API01-STU-004, API01-STU-005, API02-AI-018, API02-STU-001, API03-AI-016, API03-STU-004, API03-STU-006]`.
- Current TEST_DATA_DEFECT corrections (17): `[API01-AI-002, API01-AI-007, API01-AI-009, API01-AI-010, API01-AI-012, API01-AI-014, API01-AI-016, API01-AI-018, API01-AI-019, API01-AI-021, API01-AI-022, API01-AI-023, API01-AI-024, API01-AI-029, API01-AI-035, API02-AI-024, API03-AI-025]`.
- Candidate cases proposed for TEST_DEFECT reclassification (4): `[API02-AI-016, API02-STU-003, API02-STU-005, API02-STU-006]`.
- Candidate cases proposed for TEST_DATA_DEFECT reclassification (5): `[API02-AI-001, API02-AI-009, API02-AI-034, API02-AI-035, API02-STU-002]`.
- External pending case (1): `[API01-AI-027]`.

API distribution: `API-01: 21`, `API-02: 12`, `API-03: 4`. Clear STRONG product-defect representatives and unrelated passing cases are not proposed for automatic rerun.

## 8. Human Decision section

Allowed future values per root defect: `CONFIRM_PRODUCT_DEFECT`, `REJECT_PRODUCT_DEFECT`, `NEEDS_TARGETED_RERUN`, `MERGE_WITH_OTHER_DEFECT`, `RECLASSIFY_TEST_DEFECT`, `RECLASSIFY_TEST_DATA_DEFECT`, `RECLASSIFY_SPEC_AMBIGUITY`.

| CLUSTER_ID | HUMAN_DECISION |
| --- | --- |
| RC-02-01 | CONFIRM_PRODUCT_DEFECT |
| RC-02-02 | CONFIRM_PRODUCT_DEFECT |
| RC-02-03 | CONFIRM_PRODUCT_DEFECT |
| RC-03-01 | CONFIRM_PRODUCT_DEFECT |
| RC-03-02 | CONFIRM_PRODUCT_DEFECT |
| RC-03-03 | CONFIRM_PRODUCT_DEFECT |

Human decision: `MODIFIED_AND_APPROVED`. Candidate classifications are finalized and oracle-preserving test/harness/test-data corrections are authorized for the targeted rerun. `PRODUCT_DEFECT_FINAL_ROOT_CAUSES: 6`; `PRODUCT_DEFECT_AFFECTED_CASES: 29`.
