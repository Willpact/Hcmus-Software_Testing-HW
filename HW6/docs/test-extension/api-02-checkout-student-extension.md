# API-02 Student Extension Candidates

- Source: `STUDENT_ADDED`; Human Review: `APPROVED`; execution: `NOT_IMPLEMENTED`.
- Corrected executable AI cases: **25**; approved Student-added cases: **5**; rejected history: **1**; replacement pending: **0**; deferred gaps: **14**; executable total: **30**.
- Five approved cases count toward the final Student Extension; the rejected original remains history only.

## API02-STU-001 — Unauthorized tampered checkout then authorized recovery

- Source: `STUDENT_ADDED`; primary: `STATE_TRANSITION`; secondary: `SECURITY, BUSINESS_RULE`
- Requirements: `API02-REQ-002, API02-REQ-004, API02-REQ-005, API02-REQ-006, API02-REQ-007, API02-REQ-010`; oracle: `AUTHORITATIVE`
- Objective: Verify an invalid-JWT checkout with a manipulated total causes no success side effects and does not prevent a later valid checkout of the same cart.
- Preconditions: User A has a populated cart; Prepare invalid and valid JWT fixtures
- Request/sequence: Step 1 uses invalid JWT and low total; step 2 uses valid JWT against the unchanged cart
- Test data: cart total=known positive; first client total=1; second body remains untrusted
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Step 1 cannot be an authenticated checkout; step 2 uses the backend cart-derived total.
- Expected state: Cart remains populated after step 1 and is cleared only after step 2 succeeds.
- Closest AI cases: `API02-AI-002, API02-AI-023, API02-AI-014`
- Difference: Adds a two-request recovery sequence and verifies the same cart survives unauthorized total manipulation before valid checkout.
- Why AI missed category: `STATEFUL_REASONING_GAP`
- Why AI missed: The AI tested authentication failures and valid checkout separately but did not prove cart recoverability across an unauthorized tampered attempt.
- HUMAN_REVIEW_STATUS: `APPROVED`

## API02-STU-002 — Identity spoof combined with victim-cart total

- Source: `STUDENT_ADDED`; primary: `SECURITY`; secondary: `BUSINESS_RULE, STATE_TRANSITION`
- Requirements: `API02-REQ-004, API02-REQ-005, API02-REQ-006, API02-REQ-007`; oracle: `AUTHORITATIVE`
- Objective: Verify JWT A remains the identity authority when payload claims user B and client total equals B's different cart total.
- Preconditions: Users A and B have different populated carts; JWT A is valid
- Request/sequence: JWT A with unexpected user_id=B and total_amount equal to cart B
- Test data: cartA total differs from cartB total
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Checkout must use authenticated user A and derive total from cart A, not payload identity or cart B's client-matched value.
- Expected state: On success only cart A clears; cart B remains unchanged.
- Closest AI cases: `API02-AI-017, API02-AI-027`
- Difference: Combines spoofed identity and a strategically chosen victim-cart total so both identity and total trust boundaries are tested together.
- Why AI missed category: `SECURITY_REASONING_GAP`
- Why AI missed: The AI covered user-id spoofing and cross-user total isolation in separate cases but did not combine both attacker-controlled signals.
- HUMAN_REVIEW_STATUS: `APPROVED`

## API02-STU-003 — Simultaneous total and address injection payloads

- Source: `STUDENT_ADDED`; primary: `SECURITY`; secondary: `BUSINESS_RULE, STATE_TRANSITION`
- Requirements: `API02-REQ-005, API02-REQ-006, API02-REQ-007, API02-REQ-011`; oracle: `SECURITY_EXPECTATION`
- Objective: Verify total and shipping-address metacharacters remain data while the authoritative total still comes from cart and no unintended database action occurs.
- Preconditions: Authenticated user has a populated cart; Isolated database state can be inspected
- Request/sequence: total_amount contains expression-like text and shipping_address contains SQL metacharacters in one request
- Test data: Combined payload plus before/after database snapshot
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: No input string may execute as a command or become the authoritative total; any successful checkout uses the cart-derived total.
- Expected state: Unrelated database state remains intact; if checkout succeeds the authenticated cart clears.
- Closest AI cases: `API02-AI-025, API02-AI-026, API02-AI-034`
- Difference: Exercises both hostile fields in one request and jointly checks parameterized persistence, server total and cart side effect.
- Why AI missed category: `SECURITY_REASONING_GAP`
- Why AI missed: The AI tested total injection and address injection independently, missing their combined parser/persistence path with the total business invariant.
- HUMAN_REVIEW_STATUS: `APPROVED`

## API02-STU-004 — Expired JWT then refreshed valid checkout

- Source: `STUDENT_ADDED`; primary: `STATE_TRANSITION`; secondary: `SECURITY, BUSINESS_RULE`
- Requirements: `API02-REQ-002, API02-REQ-004, API02-REQ-005, API02-REQ-007, API02-REQ-010`; oracle: `AUTHORITATIVE`
- Objective: Verify an expired-token attempt does not consume cart state and a later valid JWT can checkout that same cart.
- Preconditions: User has populated cart; Expired and fresh valid JWT fixtures represent the same user
- Request/sequence: Step 1 checkout with expired JWT; step 2 checkout with fresh valid JWT
- Test data: Same documented body for both requests
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Expired JWT cannot authorize checkout; fresh JWT checkout uses cart-derived business behavior.
- Expected state: Cart remains populated after expired-token attempt and clears only after the valid checkout succeeds.
- Closest AI cases: `API02-AI-024, API02-AI-014`
- Difference: Adds a fresh-token retry for the same cart and verifies authorization failure does not destroy later valid business state.
- Why AI missed category: `CROSS_ENDPOINT_DEPENDENCY`
- Why AI missed: The AI covered expired JWT rejection but did not model authentication refresh/recovery while preserving checkout state.
- HUMAN_REVIEW_STATUS: `REPLACE`
- FINAL_DISPOSITION: `REJECTED_AS_STUDENT_EXTENSION`
- REASON: `NOT_GENUINELY_MISSED_BY_AI`
- COUNT_TOWARD_STUDENT_EXTENSION: `NO`

## API02-STU-005 — Two-user sequential checkout with swapped client totals

- Source: `STUDENT_ADDED`; primary: `STATE_TRANSITION`; secondary: `SECURITY, BUSINESS_RULE`
- Requirements: `API02-REQ-004, API02-REQ-005, API02-REQ-006, API02-REQ-007`; oracle: `AUTHORITATIVE`
- Objective: Verify two users checking out sequentially each use their own cart total even when each client submits the other's total.
- Preconditions: Users A and B have different populated carts; Both JWTs valid
- Request/sequence: Checkout A with client total equal cart B, then checkout B with client total equal cart A's old total
- Test data: cartA and cartB totals are distinct and deliberately swapped in bodies
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Each checkout must derive total from the authenticated user's current cart, never the swapped client value.
- Expected state: After A succeeds only cart A clears; after B succeeds cart B clears; each order remains user-scoped.
- Closest AI cases: `API02-AI-017, API02-AI-036`
- Difference: Adds a second authenticated checkout and verifies user/cart isolation in both directions across changing cart states.
- Why AI missed category: `COVERAGE_BLIND_SPOT`
- Why AI missed: The AI tested one-direction cross-user isolation but did not verify bilateral sequential state transitions with swapped trust-boundary values.
- HUMAN_REVIEW_STATUS: `APPROVED`

## API02-STU-006 — Current-cart authority under stale cross-user collision

- Replaces: `API02-STU-004`
- Source: `STUDENT_ADDED`; primary: `STATE_TRANSITION`; secondary: `SECURITY, BUSINESS_RULE`
- Requirements: `API02-REQ-004, API02-REQ-005, API02-REQ-006, API02-REQ-007`; oracle: `AUTHORITATIVE`
- Objective: Verify checkout uses authenticated user A's current cart after that cart changes, even when the payload claims user B and supplies a stale total that also equals cart B's total.
- Preconditions: Users A and B have different populated carts; JWT A is valid; cart A changes from total T-old to T-current immediately before checkout; cart B total equals T-old and differs from T-current
- Request/sequence: Capture T-old for cart A, mutate cart A to T-current, then send checkout with JWT A, unexpected user_id=B, and total_amount=T-old
- Test data: `T-current != T-old`; `cartB total = T-old`; disposable two-user carts
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: On confirmed success, checkout derives the amount from current cart A, not the stale client value, spoofed user ID, or cart B.
- Expected state: Only cart A is cleared after confirmed success; cart B remains unchanged.
- Closest AI cases: `API02-AI-016, API02-AI-017, API02-AI-027, API02-AI-036`
- Closest approved Student cases: `API02-STU-002, API02-STU-005`
- Difference: Raw and approved Student cases cover cart mutation, cross-user totals, identity spoofing, and correct cart clearing separately; none combines a temporal cart mutation with spoofed identity and a stale value deliberately colliding with another user's cart total.
- Genuinely missed: `YES`
- Why AI missed category: `COMBINATION_INTERACTION_GAP`
- Why AI missed: Raw AI generation decomposed temporal cart recalculation and cross-user identity isolation into separate cases, so it did not exercise all three competing authorities—current cart A, spoofed user B, and stale client total—in one stateful request.
- Oracle review: `SUFFICIENT`
- Execution feasibility: `POSTMAN_PLUS_EXTERNAL_VERIFICATION`
- AI recommendation: `APPROVE`
- HUMAN_REVIEW_STATUS: `APPROVED`
- COUNT_TOWARD_STUDENT_EXTENSION: `YES`
