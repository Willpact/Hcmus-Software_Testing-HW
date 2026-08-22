# API-03 Student Extension Candidates

- Source: `STUDENT_ADDED`; Human Review: `APPROVED`; execution: `NOT_IMPLEMENTED`.
- Corrected executable AI cases: **28**; approved Student-added cases: **5**; rejected history: **1**; replacement pending: **0**; deferred gaps: **12**; executable total: **33**.
- Five approved cases count toward the final Student Extension; the rejected original remains history only.

## API03-STU-001 — Non-admin mixed batch cannot reach persistence

- Source: `STUDENT_ADDED`; primary: `SECURITY`; secondary: `STATE_TRANSITION, BUSINESS_RULE`
- Requirements: `API03-REQ-002, API03-REQ-003, API03-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Verify authorization rejects a non-admin before a mixed-validity batch can create any partial product state.
- Preconditions: Valid JWT with role=user; Products snapshot exists
- Request/sequence: Non-admin JWT with one valid and one invalid product
- Test data: Valid row plus empty-name row
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Non-admin is not authorized to import regardless of row composition.
- Expected state: No row from the batch is persisted.
- Closest AI cases: `API03-AI-026, API03-AI-018`
- Difference: Combines role enforcement with mixed validity and verifies the unauthorized request never reaches persistence side effects.
- Why AI missed category: `SECURITY_REASONING_GAP`
- Why AI missed: The AI tested non-admin authorization and mixed-batch atomicity separately, but not precedence of authorization over a batch that could expose partial processing.
- HUMAN_REVIEW_STATUS: `APPROVED`

## API03-STU-002 — Role-tampering payload with invalid batch

- Source: `STUDENT_ADDED`; primary: `SECURITY`; secondary: `STATE_TRANSITION, BUSINESS_RULE`
- Requirements: `API03-REQ-002, API03-REQ-003, API03-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Verify body role=admin cannot elevate a user JWT even when the batch itself contains validation errors.
- Preconditions: Valid JWT role=user; Products snapshot exists
- Request/sequence: JWT user, body role=admin, products contain valid and zero-price rows
- Test data: Role-tampering field plus mixed-validity products
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Role must come from the verified token; payload role and row errors cannot authorize import.
- Expected state: No product is persisted and no partial validation-side effect is allowed.
- Closest AI cases: `API03-AI-028, API03-AI-018`
- Difference: Adds mixed validity to the role-escalation attempt and checks authorization/persistence ordering.
- Why AI missed category: `SECURITY_REASONING_GAP`
- Why AI missed: The AI tested role tampering only with a valid products body and did not combine authorization bypass input with atomicity-sensitive invalid rows.
- HUMAN_REVIEW_STATUS: `APPROVED`

## API03-STU-003 — Injection-like name plus invalid-price rollback

- Source: `STUDENT_ADDED`; primary: `SECURITY`; secondary: `STATE_TRANSITION, BUSINESS_RULE`
- Requirements: `API03-REQ-007, API03-REQ-009, API03-REQ-011`; oracle: `SECURITY_EXPECTATION`
- Objective: Verify an injection-like non-empty name remains data, while a separate invalid price causes the entire admin batch to roll back.
- Preconditions: Admin JWT valid; Products/database snapshot exists
- Request/sequence: Row 1 has injection-like non-empty name and positive price; row 2 has valid name and price=0
- Test data: Two-row mixed batch
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: The injection-like name must not execute as a command; price=0 is invalid and triggers all-or-nothing rollback.
- Expected state: Neither row is persisted and unrelated database state remains intact.
- Closest AI cases: `API03-AI-029, API03-AI-018`
- Difference: Combines parameterized-input resilience with a direct FR-16 validation error and atomic rollback.
- Why AI missed category: `SECURITY_REASONING_GAP`
- Why AI missed: The AI covered injection input and invalid-row rollback separately, missing their combined transaction/security path.
- HUMAN_REVIEW_STATUS: `APPROVED`

## API03-STU-004 — Committed batch survives later invalid import rollback

- Source: `STUDENT_ADDED`; primary: `STATE_TRANSITION`; secondary: `BUSINESS_RULE`
- Requirements: `API03-REQ-007, API03-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Verify atomic rollback is scoped to the current import and does not undo products committed by an earlier valid import.
- Preconditions: Admin JWT valid; Snapshot before both imports
- Request/sequence: Import valid batch A, then import batch B containing an invalid row
- Test data: Distinct product identifiers for A and B
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Batch A commits fully; batch B fails atomically because of its invalid row.
- Expected state: Products from A remain; no product from B is persisted.
- Closest AI cases: `API03-AI-016, API03-AI-021`
- Difference: Reverses the sequence and checks transaction scope across two imports, not merely within one batch.
- Why AI missed category: `STATEFUL_REASONING_GAP`
- Why AI missed: The AI tested rollback then corrected retry, but not the opposite sequence where a later rollback must preserve an earlier committed transaction.
- HUMAN_REVIEW_STATUS: `APPROVED`

## API03-STU-005 — Two distinct row errors correlate with report and rollback

- Source: `STUDENT_ADDED`; primary: `BUSINESS_RULE`; secondary: `STATE_TRANSITION, SCHEMA`
- Requirements: `API03-REQ-007, API03-REQ-009, API03-REQ-010`; oracle: `AUTHORITATIVE`
- Objective: Verify a batch with two different invalid rows reports both semantic reasons/counts while committing none of the valid middle row.
- Preconditions: Admin JWT valid; Products snapshot exists
- Request/sequence: Empty-name row, valid middle row, negative-price row
- Test data: Three rows with two distinct FR-16 violations
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Report semantics reflect two errors and their reasons; any row error requires entire-batch rollback. Exact JSON keys remain unspecified.
- Expected state: No row from the batch is persisted.
- Closest AI cases: `API03-AI-020, API03-AI-038`
- Difference: Adds a report-to-input correlation assertion for two different invalid reasons while preserving exact-schema agnosticism.
- Why AI missed category: `COVERAGE_BLIND_SPOT`
- Why AI missed: The AI had multiple-invalid and report cases but did not explicitly correlate two distinct FR-16 violations with report semantics and the valid middle row's rollback.
- HUMAN_REVIEW_STATUS: `REPLACE`
- FINAL_DISPOSITION: `REJECTED_AS_STUDENT_EXTENSION`
- REASON: `NOT_GENUINELY_MISSED_BY_AI`
- COUNT_TOWARD_STUDENT_EXTENSION: `NO`

## API03-STU-006 — Prior admin commit survives later non-admin mixed batch

- Replaces: `API03-STU-005`
- Source: `STUDENT_ADDED`; primary: `STATE_TRANSITION`; secondary: `SECURITY, BUSINESS_RULE`
- Requirements: `API03-REQ-002, API03-REQ-003, API03-REQ-007, API03-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Verify a later non-admin mixed-batch attempt cannot roll back an earlier authorized commit or partially persist any attempted row.
- Preconditions: Admin and non-admin JWT fixtures exist; products snapshot exists; batch A and batch B use distinct product identifiers
- Request/sequence: Admin imports valid batch A successfully; then a non-admin submits batch B containing one valid row and one zero-price row
- Test data: Valid multi-row batch A; batch B has one positive-price row and one `price=0` row
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Batch A commits under the admin request; the non-admin request cannot import batch B regardless of its mixed row validity.
- Expected state: Every product from batch A remains; no product from batch B is persisted; pre-existing unrelated products remain unchanged.
- Closest AI cases: `API03-AI-016, API03-AI-026, API03-AI-018`
- Closest approved Student cases: `API03-STU-001, API03-STU-004`
- Difference: Existing cases cover a non-admin mixed batch with no prior commit and an admin valid-then-invalid sequence with no principal change; none verifies cross-principal transaction isolation across an authorized commit followed by an unauthorized mixed-batch attempt.
- Genuinely missed: `YES`
- Why AI missed category: `COMBINATION_INTERACTION_GAP`
- Why AI missed: Raw AI generation separated admin/non-admin authorization, atomic mixed-batch rollback, and cross-request transaction scope, so it did not test whether a later unauthorized request can corrupt a previously committed authorized state.
- Oracle review: `SUFFICIENT`
- Execution feasibility: `POSTMAN_PLUS_EXTERNAL_VERIFICATION`
- AI recommendation: `APPROVE`
- HUMAN_REVIEW_STATUS: `APPROVED`
- COUNT_TOWARD_STUDENT_EXTENSION: `YES`
