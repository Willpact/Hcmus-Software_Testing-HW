# API-01 Student Extension Candidates

- Source: `STUDENT_ADDED`; Human Review: `APPROVED`; execution: `NOT_IMPLEMENTED`.
- Corrected executable AI cases: **25**; approved Student-added cases: **5**; rejected history: **0**; deferred gaps: **12**; executable total: **30**.
- These five approved cases count toward the final Student Extension and are ready for implementation mapping.

## API01-STU-001 — Cross-email failure then rightful token use

- Source: `STUDENT_ADDED`; primary: `STATE_TRANSITION`; secondary: `SECURITY, BUSINESS_RULE`
- Requirements: `API01-REQ-007, API01-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Verify that a cross-email misuse attempt neither changes an account nor consumes the rightful owner's issued OTP.
- Preconditions: Users A and B are registered; OTP A is issued for email A
- Request/sequence: Step 1 sends email B with OTP A and a strong password; step 2 sends email A with the same OTP A
- Test data: Two-step sequence using disposable users and OTP A
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Step 1 must not reset either account; step 2 may complete the authoritative owner-bound reset.
- Expected state: After step 1 OTP A remains available for rightful use; after step 2 only A changes and OTP A is invalidated.
- Closest AI cases: `API01-AI-002, API01-AI-014, API01-AI-019`
- Difference: Adds a second authoritative owner-use step after the cross-email failure and verifies token state across both requests.
- Why AI missed category: `STATEFUL_REASONING_GAP`
- Why AI missed: The AI tested cross-email binding and valid reset separately but did not execute the recovery sequence proving a failed foreign use does not consume the owner's token.
- HUMAN_REVIEW_STATUS: `APPROVED`

## API01-STU-002 — Weak-password failure then strong retry with same OTP

- Source: `STUDENT_ADDED`; primary: `STATE_TRANSITION`; secondary: `BUSINESS_RULE`
- Requirements: `API01-REQ-005, API01-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Verify that a password-policy failure is not treated as successful OTP use and a corrected strong password can use the same issued OTP.
- Preconditions: A valid email-bound OTP is issued
- Request/sequence: Step 1 uses a weak password; step 2 retries the same OTP with a strong password
- Test data: Weak password missing required classes, followed by a compliant password
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: The weak attempt must not complete reset; the strong retry may complete reset with the same still-valid OTP.
- Expected state: Password remains old after step 1; after step 2 it changes and the OTP is invalidated.
- Closest AI cases: `API01-AI-018, API01-AI-014`
- Difference: Adds an explicit retry transition with the same OTP, making token preservation after business validation failure observable.
- Why AI missed category: `STATEFUL_REASONING_GAP`
- Why AI missed: The AI stated that a weak-password failure should not consume the token but did not prove recoverability with a follow-up compliant retry.
- HUMAN_REVIEW_STATUS: `APPROVED`

## API01-STU-003 — Wrong-token failure then correct-token recovery

- Source: `STUDENT_ADDED`; primary: `STATE_TRANSITION`; secondary: `SECURITY`
- Requirements: `API01-REQ-007, API01-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Verify that submitting a different six-digit token does not invalidate the actually issued token for the email.
- Preconditions: A valid OTP is issued for email A
- Request/sequence: Step 1 submits a different six-digit token; step 2 submits the issued token with a strong password
- Test data: wrongToken differs from issuedToken while both are six digits
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: The wrong-token request must not reset the password; the issued token remains eligible for its rightful request.
- Expected state: After step 1 password and issued-token state remain unchanged; after step 2 password changes and issued token is invalidated.
- Closest AI cases: `API01-AI-019, API01-AI-014`
- Difference: Adds a recovery step using the real token and validates non-consumption after a wrong guess.
- Why AI missed category: `SECURITY_REASONING_GAP`
- Why AI missed: The AI covered wrong-token rejection but did not execute the follow-up correct use needed to verify that an attacker guess cannot consume the real token.
- HUMAN_REVIEW_STATUS: `APPROVED`

## API01-STU-004 — Independent users' OTP invalidation isolation

- Source: `STUDENT_ADDED`; primary: `STATE_TRANSITION`; secondary: `SECURITY`
- Requirements: `API01-REQ-007, API01-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Verify that successful use of OTP A invalidates only OTP A and does not invalidate independently issued OTP B.
- Preconditions: Users A and B each have a valid issued OTP
- Request/sequence: Reset A successfully, then reset B using OTP B
- Test data: Two independent email-token-password fixtures
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Each user can reset only with their own token; success for A must not revoke B's independent token.
- Expected state: A password changes and OTP A invalidates first; B remains unchanged/valid until its own successful reset, then OTP B invalidates.
- Closest AI cases: `API01-AI-002, API01-AI-015, API01-AI-014`
- Difference: Uses two simultaneously valid owner-bound tokens and verifies invalidation is scoped to the token used.
- Why AI missed category: `COVERAGE_BLIND_SPOT`
- Why AI missed: The AI checked cross-email misuse and replay but did not cover isolation of two independently valid token lifecycles.
- HUMAN_REVIEW_STATUS: `APPROVED`

## API01-STU-005 — Replay on user A does not disturb unused token B

- Source: `STUDENT_ADDED`; primary: `STATE_TRANSITION`; secondary: `SECURITY`
- Requirements: `API01-REQ-007, API01-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Verify that replaying A's already-used OTP is rejected without consuming or altering B's unused OTP.
- Preconditions: A and B have valid OTPs; A has completed a successful reset and OTP A is invalidated
- Request/sequence: Replay OTP A, then use still-unused OTP B for B
- Test data: Used OTP A and unused OTP B
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: A replay must not create a second reset; B's independent legitimate reset must remain possible.
- Expected state: A remains at its first reset state; B changes only on its own request and OTP B then invalidates.
- Closest AI cases: `API01-AI-015, API01-AI-002`
- Difference: Adds a second user's pending token and proves a replay event cannot cause cross-user lifecycle mutation.
- Why AI missed category: `SECURITY_REASONING_GAP`
- Why AI missed: The AI covered replay for one user but did not combine replay handling with isolation of another user's pending reset state.
- HUMAN_REVIEW_STATUS: `APPROVED`
