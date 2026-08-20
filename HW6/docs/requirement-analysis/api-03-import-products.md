# API-03 Requirement Analysis — Import Products

## 1. API Overview

| Field | Value |
| --- | --- |
| API ID | API-03 |
| Feature | FR-16 — Import Sản phẩm từ CSV |
| Endpoint | `POST /api/admin/import-products` |
| Analysis scope | Requirement analysis, implementation comparison, and coverage planning only |
| Status | `REQUIREMENT_ANALYSIS_APPROVED` |

## 2. Sources

| Source | Classification | Role |
| --- | --- | --- |
| `eshop-sut/README.md` §FR-16, §Security SEC-02/SEC-03/SEC-05 | `AUTHORITATIVE` | CSV feature, import validation/atomicity/reporting, admin/JWT/database security |
| `eshop-sut/README.md` §FR-15 | `SUPPORTING` | General Product CRUD constraints; not direct FR-16 import requirements unless explicitly linked |
| `eshop-sut/api_specification.md` §6 introductory rule and §6.3 | `AUTHORITATIVE` | Admin bearer/admin role requirement and documented `products` JSON-array body |
| `eshop-sut/backend/server.js` lines 198–241 | `IMPLEMENTATION_ONLY` | Observable import route behavior |
| `eshop-sut/backend/database.js` lines 23–25, 63–71, 83–103 | `IMPLEMENTATION_ONLY` | Observable categories/products schema and seed context |

## 3. Source Classification

- `AUTHORITATIVE`: README FR-16/security requirements and API specification define required import/security behavior.
- `SUPPORTING`: FR-15 describes general Product CRUD constraints but does not automatically establish import-specific expected results.
- `IMPLEMENTATION_ONLY`: backend/database code is inspected only for comparison and later data-planning context.
- No supporting source independently defines an expected import outcome.

## 4. Atomic Requirements

| ID | Source | Source classification | Requirement statement | Relevant parameters/state/security | Notes |
| --- | --- | --- | --- | --- | --- |
| API03-REQ-001 | API specification §6.3 | `AUTHORITATIVE` | The endpoint is `POST /api/admin/import-products`. | Method/path | |
| API03-REQ-002 | API specification §6 intro | `AUTHORITATIVE` | Admin APIs require bearer JWT and an Admin account. | Authentication/authorization | |
| API03-REQ-003 | README SEC-03 | `AUTHORITATIVE` | Admin APIs verify `role = 'admin'` in token, not token existence only. | Authorization | |
| API03-REQ-004 | API specification §6.3 | `AUTHORITATIVE` | Documented request body has `products`, an array of objects. | Body/array presence/type | |
| API03-REQ-005 | API specification §6.3 | `AUTHORITATIVE` | Documented product fields are `name`, `price`, `description`, `imageUrl`, and `category_id`. | Item schema | Requiredness not stated by API spec. |
| API03-REQ-006 | README FR-16 | `AUTHORITATIVE` | The business feature imports multiple products from a CSV file with the stated extension/header/RFC 4180 requirements. | File/CSV parsing | Representation boundary is unresolved; this does not establish that the selected endpoint accepts raw CSV. |
| API03-REQ-007 | README FR-16 | `AUTHORITATIVE` | Each imported `name` must be non-empty and `price` must be positive. | Per-item validation | |
| API03-REQ-008 | README FR-15 | `SUPPORTING` | FR-15 states general Product CRUD constraints: name required/max 255, price required/positive, and category required/from existing list. | Cross-feature product context | Do not apply max-length/category rules as direct FR-16 import oracles unless an authoritative source explicitly links them. |
| API03-REQ-009 | README FR-16 | `AUTHORITATIVE` | Any row error rolls back the entire import; import is atomic/all-or-nothing. | Batch transaction | |
| API03-REQ-010 | README FR-16 | `AUTHORITATIVE` | System reports successful/error row counts and reasons. | Batch response/reporting | Exact response schema is unspecified. |
| API03-REQ-011 | README SEC-02/SEC-05 | `AUTHORITATIVE` | Sensitive endpoint requires valid JWT and database queries are parameterized. | Authentication/persistence | |

## 5. Parameter Analysis

| Parameter/dependency | Authoritative facts | Planned dimensions; not test cases |
| --- | --- | --- |
| `Authorization` | Bearer JWT plus Admin role are required. | Missing/malformed/invalid JWT; valid non-admin; valid admin. |
| `products` | API spec documents an array; FR-16 is multi-product import. | Absent/null/non-array/empty/non-empty; size limits are unspecified. |
| `products[].name` | FR-16 requires non-empty; FR-15 max 255 is supporting only. | Missing/empty/whitespace interpretation; length boundary requires clarification before becoming an oracle. |
| `products[].price` | Positive and required. | Missing/non-numeric/zero/negative/positive; numeric representation is unspecified. |
| `description` / `imageUrl` | Documented fields only. | Presence/type/length are not defined. |
| `category_id` | API specification documents the field; FR-16 does not define its requiredness/reference validation. | Missing/invalid/nonexistent/existing reference as gap exploration only. |
| CSV representation | FR-16 defines a CSV feature; API specification defines this endpoint as JSON `products[]`. | Preserve the unresolved boundary; analyze the selected endpoint as JSON unless an authoritative endpoint source states it accepts raw CSV. |

## 6. Domain Partition Planning

- `DOMAIN_PARTITION`: authorization classes; array presence/type/size; per-item name/price/category partitions; batch composition.
- `BOUNDARY`: price at zero/positive boundary; name length 255 is supporting context pending explicit FR-16 linkage; maximum batch size is a gap.
- `STATE_TRANSITION`: pre-import product set → accepted atomic batch → all new products; invalid batch → no change.
- `SECURITY`: JWT/admin role, unexpected fields/mass-assignment risk as consideration, input-injection resilience.
- `SCHEMA`: JSON-array body versus CSV-upload ambiguity; item/report response fields.
- `BUSINESS_RULE`: all-or-nothing transaction, product validation, category reference, row-count/reason report.

## 7. Business Rules

- Only an admin with a valid JWT may import.
- FR-16 directly requires non-empty name and positive price; other FR-15 constraints remain supporting context.
- Any row error must roll back all rows.
- Import report shows success/error counts and reasons.
- CSV syntax is authoritative for the feature, while the selected endpoint contract documents JSON `products[]`; raw-CSV acceptance is not assumed and the boundary needs clarification.

## 8. State Rules

| State/rule | Evidence | Analysis |
| --- | --- | --- |
| Authorized admin precedes import | API specification §6; SEC-02/03 | Required precondition. |
| Valid batch | README FR-16 | Entire batch may be committed. |
| Invalid row | README FR-16 | Entire batch rolls back; no partial persistence. |
| Post-import report | README FR-16 | Counts and reasons are required. |
| Duplicate/category semantics | Not specified. | `REQUIREMENT_GAP`. |

## 9. Security Requirements

| ID | Applicability | Requirement or consideration |
| --- | --- | --- |
| SEC-02 | Applicable | Valid JWT required. |
| SEC-03 | Applicable | Token must represent `role = 'admin'`. |
| SEC-05 | Applicable implementation constraint | Database queries use parameterization. |
| SECURITY_TEST_CONSIDERATION | Non-authoritative risk | Unexpected fields, mixed-validity batch, category/reference spoofing, input injection, and role escalation should be considered later without inventing result contracts. |

## 10. Schema / Response Contract

- API specification documents JSON `products` array and item fields.
- FR-16 defines a CSV file/header/RFC 4180 feature contract; it does not state where parsing occurs. The selected endpoint remains JSON-based unless an authoritative endpoint source states raw-CSV acceptance.
- Response must report counts/reasons, but authoritative sources do not define status codes, response field names/types, item-level error structure, or maximum array/file size.

## 11. Requirement Gaps

| ID | Gap | Why it matters for testing | Affected technique | Recommended handling |
| --- | --- | --- | --- | --- |
| API03-RG-001 | CSV-file feature contract and JSON-array endpoint contract do not state their boundary. | Request representation and parser coverage have no single oracle. | `SCHEMA`, `DOMAIN_PARTITION` | `NEEDS_HUMAN_DECISION` |
| API03-RG-002 | Maximum batch size and duplicate-product policy are unspecified. | Size/duplicate boundaries cannot be asserted. | `BOUNDARY`, `BUSINESS_RULE` | `NEEDS_HUMAN_DECISION` |
| API03-RG-003 | Import-specific category existence/error behavior, name maximum length, and optionality of description/image fields are unspecified. | FR-15 is supporting only, so import assertions need a direct oracle. | `DOMAIN_PARTITION`, `BOUNDARY`, `SCHEMA` | `NEEDS_HUMAN_DECISION` |
| API03-RG-004 | Status/error/report JSON schema is unspecified. | Response assertions cannot be requirement-backed. | `SCHEMA` | `NEEDS_HUMAN_DECISION` |
| API03-RG-005 | Whitespace semantics for name and numeric format/precision for price are unspecified. | Equivalence partitions are incomplete; observation must not become an invented expected result. | `DOMAIN_PARTITION`, `BOUNDARY` | `TEST_OBSERVABLE_BEHAVIOR` |

## 12. Implementation Observations

- Observed route requires `authenticateToken`, but no explicit role check is visible.
- It rejects absent/non-array/empty `products`, checks only falsy `row.name`, prepares parameterized inserts, defaults absent category to 1, and returns `inserted`/error strings.
- It does not visibly use a transaction/rollback around the batch.
- Database schema has products/categories but no foreign-key constraint is visible.
- These observations are not authoritative behavior.

## 13. Implementation Discrepancies

### Potential discrepancies

| ID | Relevant requirement | Expected from authoritative source | Observed implementation | Potential testing impact | Status |
| --- | --- | --- | --- | --- | --- |
| API03-ID-001 | API03-REQ-002/003 | Valid JWT plus Admin role check. | Route uses `authenticateToken`; no explicit admin-role check is visible. | Non-admin access must be verified later. | `POTENTIAL_DISCREPANCY` |
| API03-ID-002 | API03-REQ-007 | FR-16 requires non-empty name and positive price. | Route checks only falsy name and does not validate positive price. | FR-16 item validation may differ; category defaulting is implementation-only because FR-16 does not define category validation. | `POTENTIAL_DISCREPANCY` |
| API03-ID-003 | API03-REQ-009 | Any invalid row rolls back entire import. | Inserts are prepared per row with no visible transaction/rollback. | Mixed-validity batch may persist partially. | `POTENTIAL_DISCREPANCY` |

### Implementation-only observations

| ID | Relevant requirement | Expected from authoritative source | Observed implementation | Potential testing impact | Status |
| --- | --- | --- | --- | --- | --- |
| API03-ID-004 | API03-REQ-010 | Report includes success/error counts and reasons. | Response returns `inserted` and `errors`. | Observed partial alignment; format/content still needs verification. | `IMPLEMENTATION_ONLY_OBSERVATION` |
| API03-ID-005 | API03-REQ-011 | Parameterized persistence applies. | Insert statement uses placeholders. | Observed alignment; no defect claim. | `IMPLEMENTATION_ONLY_OBSERVATION` |

Classification count: **3** `POTENTIAL_DISCREPANCY` + **2** `IMPLEMENTATION_ONLY_OBSERVATION`.

## 14. Coverage Plan

- `DOMAIN_PARTITION`: token/admin role, products array form, item field classes, category references, mixed validity.
- `BOUNDARY`: price zero/positive; product-name 255 only if FR-15 applicability is explicitly adopted; batch-size gap.
- `STATE_TRANSITION`: atomic commit versus rollback and report generation.
- `SECURITY`: JWT/role enforcement, unexpected fields, injection/resilience considerations.
- `SCHEMA`: CSV-versus-JSON boundary, item body, response/report contract.
- `BUSINESS_RULE`: validation, category, atomicity, report counts/reasons.

## 15. Open Questions

1. The selected endpoint is documented as JSON `products[]`; where does CSV parsing occur, and is raw CSV explicitly outside this endpoint's scope?
2. What maximum batch size, duplicate policy, and category-error response apply?
3. What exact status/body schema represents full success, validation failure, and rollback?
4. Does FR-15's 255-character limit explicitly apply to FR-16 import, and how is whitespace-only name handled?
5. Are description and image URL optional, validated, or sanitized by this API?

## 16. Analysis Status

`REQUIREMENT_ANALYSIS_APPROVED` — Human corrections applied; A-002 Human Review and A-003 interaction audit verified. Test generation has not started.
