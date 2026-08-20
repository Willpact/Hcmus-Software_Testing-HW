# API-02 Requirement Analysis — Checkout

## 1. API Overview

| Field | Value |
| --- | --- |
| API ID | API-02 |
| Feature | FR-08 — Checkout |
| Endpoint | `POST /api/checkout` |
| Analysis scope | Requirement analysis, implementation comparison, and coverage planning only |
| Status | `REQUIREMENT_ANALYSIS_APPROVED` |

## 2. Sources

| Source | Classification | Role |
| --- | --- | --- |
| `eshop-sut/README.md` §FR-08, §Security SEC-02/SEC-05 | `AUTHORITATIVE` | Direct checkout, authentication, and database-security requirements |
| `eshop-sut/README.md` §FR-07, §FR-09 | `SUPPORTING` | Cart precondition and coupon cross-feature context; not direct `/api/checkout` oracles without documented integration |
| `eshop-sut/api_specification.md` §4.1–4.6 | `AUTHORITATIVE` | Endpoint, bearer-header requirement, documented body |
| `eshop-sut/backend/server.js` lines 284–309 | `IMPLEMENTATION_ONLY` | In-memory cart and checkout route behavior |
| `eshop-sut/backend/database.js` lines 73–81 | `IMPLEMENTATION_ONLY` | Observable order persistence fields |

## 3. Source Classification

- `AUTHORITATIVE`: README FR-08/security requirements and API specification determine expected checkout behavior.
- `SUPPORTING`: FR-07 cart details and FR-09 coupon behavior inform precondition/cross-feature planning only; they do not independently define `/api/checkout` expected results.
- `IMPLEMENTATION_ONLY`: server/database source is comparison evidence only.
- No supporting source independently defines an expected checkout result.

## 4. Atomic Requirements

| ID | Source | Source classification | Requirement statement | Relevant parameters/state/security | Notes |
| --- | --- | --- | --- | --- | --- |
| API02-REQ-001 | API specification §4.3 | `AUTHORITATIVE` | The endpoint is `POST /api/checkout`. | Method/path | |
| API02-REQ-002 | API specification §4 | `AUTHORITATIVE` | Cart/order APIs require `Authorization: Bearer <token>`. | Header/authentication | |
| API02-REQ-003 | API specification §4.3 | `AUTHORITATIVE` | The documented JSON body has `total_amount` and `shipping_address`. | Request body | Requiredness and validation rules are not stated. |
| API02-REQ-004 | README FR-08 | `AUTHORITATIVE` | Only an authenticated user may check out. | JWT/user identity | |
| API02-REQ-005 | README FR-08 | `AUTHORITATIVE` | Payment total is calculated automatically from cart and not directly editable by user. | Cart/total | |
| API02-REQ-006 | README FR-08 | `AUTHORITATIVE` | Backend recalculates the total and must not accept client-supplied `total_amount`. | Trust boundary | |
| API02-REQ-007 | README FR-08 | `AUTHORITATIVE` | A successful checkout clears the cart. | Cart → checkout side effect | |
| API02-REQ-008 | README FR-07 | `SUPPORTING` | FR-07 describes cart contents and same-product quantity behavior as precondition context. | Cart context | Do not use as a direct checkout oracle unless FR-08 or the endpoint contract explicitly links the detail. |
| API02-REQ-009 | README FR-09 | `SUPPORTING` | FR-09 describes coupon eligibility as cross-feature context. | Coupon context | Do not use as a direct checkout oracle without documented integration. |
| API02-REQ-010 | README SEC-02 | `AUTHORITATIVE` | Sensitive APIs require a valid JWT token. | Authentication | |
| API02-REQ-011 | README SEC-05 | `AUTHORITATIVE` | Database queries use parameterized queries. | Persistence implementation constraint | |

## 5. Parameter Analysis

| Parameter/dependency | Authoritative facts | Planned dimensions; not test cases |
| --- | --- | --- |
| `Authorization` | Bearer JWT required; authenticated user only. | Missing/malformed/invalid/valid token; user identity isolation. |
| `total_amount` | Documented field, but backend must recompute and not trust it. | Any client-supplied numeric/value class is a trust-boundary input; authoritative final amount comes from cart. |
| `shipping_address` | Documented body field. | Present/absent/format/length handling is unresolved. |
| Cart | FR-08 states checkout derives total from cart and success clears it; FR-07 supplies supporting precondition detail. | Empty/non-empty cart and authenticated-user isolation; FR-07-specific structure is not a direct oracle unless linked by FR-08. |
| Coupon | FR-09 is supporting cross-feature context. | Eligible/ineligible coupon state only if a documented checkout integration is clarified. |

## 6. Domain Partition Planning

- `DOMAIN_PARTITION`: authentication classes, cart content/state, client-supplied total values, shipping-address presence/format after clarification, coupon eligibility.
- `BOUNDARY`: cart total/minimum-order coupon thresholds where checkout integration is confirmed; shipping-address limits are a gap.
- `STATE_TRANSITION`: cart populated → checkout success → cart cleared; failure should preserve/alter cart only if clarified.
- `SECURITY`: valid JWT and user/cart ownership; client total as a trust boundary.
- `SCHEMA`: bearer header and documented JSON fields/response contract.
- `BUSINESS_RULE`: server-side total calculation, cart clearing, coupon rules if integrated.

## 7. Business Rules

- User must be authenticated.
- Total is derived from cart by backend, not accepted from client.
- Successful checkout clears the cart.
- Coupon behavior is supporting cross-feature context; it is not a direct checkout oracle without documented integration.

## 8. State Rules

| State/rule | Evidence | Analysis |
| --- | --- | --- |
| Authenticated identity precedes checkout | README FR-08; API specification §4 | Required precondition. |
| Cart is the source of total | README FR-08 | The route must obtain a cart-derived amount. |
| Success clears cart | README FR-08 | Required side effect. |
| Order creation/initial status | API specification identifies orders but not initial state. | `REQUIREMENT_GAP`; implementation value is not authoritative. |
| Failure effect on cart/order | Not specified. | `REQUIREMENT_GAP`. |

## 9. Security Requirements

| ID | Applicability | Requirement or consideration |
| --- | --- | --- |
| SEC-02 | Applicable | Valid JWT is required. |
| SEC-05 | Applicable implementation constraint | Persistence query must be parameterized. |
| SECURITY_TEST_CONSIDERATION | Non-authoritative risk | Cross-user cart access, manipulated `total_amount`, replay/repeated checkout, and race-like cart changes warrant later analysis without ungrounded expectations. |

## 10. Schema / Response Contract

- Authoritative request: bearer authorization plus JSON `total_amount` and `shipping_address`.
- Authoritative sources do not define success status/body, error statuses, shipping-address validation, order schema, or idempotency/replay contract.
- FR-08 overrides a literal reading of client `total_amount`: it is documented as a field but must not determine the accepted total.

## 11. Requirement Gaps

| ID | Gap | Why it matters for testing | Affected technique | Recommended handling |
| --- | --- | --- | --- | --- |
| API02-RG-001 | Success/error status and response schemas are unspecified. | Contract assertions cannot be requirement-backed. | `SCHEMA` | `NEEDS_HUMAN_DECISION` |
| API02-RG-002 | Shipping-address requiredness/format/limits are unspecified. | Input partitions lack an authoritative oracle. | `DOMAIN_PARTITION`, `BOUNDARY` | `NEEDS_HUMAN_DECISION` |
| API02-RG-003 | Empty-cart behavior, order-line persistence, inventory handling, and initial order status are unspecified. | Precondition/state coverage is incomplete; absence of order-line persistence is not a discrepancy oracle until an authoritative contract defines it. | `STATE_TRANSITION`, `BUSINESS_RULE` | `NEEDS_HUMAN_DECISION` |
| API02-RG-004 | FR-09 coupon rules do not state how/if `POST /api/checkout` receives an applied coupon result. | Total/coupon interaction cannot be assigned to this endpoint. | `BUSINESS_RULE` | `NEEDS_HUMAN_DECISION` |
| API02-RG-005 | Repeated-checkout/idempotency behavior is unspecified. | Replays can produce uncertain state assertions. | `STATE_TRANSITION`, `SECURITY` | `SECURITY_TEST_CONSIDERATION` |

## 12. Implementation Observations

- Observed route uses `authenticateToken`, obtains `req.user.id`, inserts the request's `total_amount` with status `pending`, and returns a message/order ID.
- Observed cart storage is in-memory per user ID; checkout route does not read or clear it.
- Observed SQL uses parameter placeholders for order insertion.
- These observations do not change authoritative expectations.

## 13. Implementation Discrepancies

### Potential discrepancies

| ID | Relevant requirement | Expected from authoritative source | Observed implementation | Potential testing impact | Status |
| --- | --- | --- | --- | --- | --- |
| API02-ID-001 | API02-REQ-005/006 | Backend derives total from cart and rejects client total as authority. | Route inserts client-provided `total_amount` directly. | Total-trust behavior requires real verification. | `POTENTIAL_DISCREPANCY` |
| API02-ID-002 | API02-REQ-007 | Successful checkout clears cart. | Checkout route does not access/clear `userCarts`. | Cart may remain after success. | `POTENTIAL_DISCREPANCY` |
| API02-ID-003 | API02-REQ-005/006 | Backend derives checkout total from the cart. | Checkout route does not read the authenticated user's cart. | Cart-derived total behavior may be absent and requires real verification. | `POTENTIAL_DISCREPANCY` |

### Implementation-only observations

| ID | Relevant requirement | Expected from authoritative source | Observed implementation | Potential testing impact | Status |
| --- | --- | --- | --- | --- | --- |
| API02-ID-004 | API02-REQ-010/011 | JWT and parameterized persistence apply. | Route uses `authenticateToken` and parameterized insert placeholders. | Observed alignment; no defect claim. | `IMPLEMENTATION_ONLY_OBSERVATION` |

Classification count: **3** `POTENTIAL_DISCREPANCY` + **1** `IMPLEMENTATION_ONLY_OBSERVATION`.

## 14. Coverage Plan

- `DOMAIN_PARTITION`: token class, cart state/content, client total input, address when clarified.
- `BOUNDARY`: cart/discount totals only when a checkout contract defines them.
- `STATE_TRANSITION`: cart → order → cart cleared; failure/replay behavior needs decision.
- `SECURITY`: JWT validity, user-cart ownership, client-total manipulation.
- `SCHEMA`: header, body, response/error contracts after clarification.
- `BUSINESS_RULE`: recalculation and cart clearing; coupon integration remains supporting context until documented.

## 15. Open Questions

1. Is `total_amount` retained only for compatibility, and what response exposes the server-calculated total?
2. What happens for an empty cart or invalid/missing shipping address?
3. What initial order status and inventory side effects are required? Order-line persistence remains unspecified and is not treated as a discrepancy.
4. Is a coupon result associated with checkout at all, and if so, through which documented contract?
5. Is repeated submission intended to be idempotent?

## 16. Analysis Status

`REQUIREMENT_ANALYSIS_APPROVED` — Human corrections applied; A-002 Human Review and A-003 interaction audit verified. Test generation has not started.
