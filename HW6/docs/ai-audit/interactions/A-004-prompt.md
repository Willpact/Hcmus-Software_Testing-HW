Requirement Analysis cho cả ba API đã được human review và `MODIFIED_AND_APPROVED`.

Trạng thái hiện tại:

```text
API-01 — POST /api/reset-password
REQUIREMENT_ANALYSIS_APPROVED

API-02 — POST /api/checkout
REQUIREMENT_ANALYSIS_APPROVED

API-03 — POST /api/admin/import-products
REQUIREMENT_ANALYSIS_APPROVED
```

Các artifact authoritative cho phase hiện tại:

```text
docs/requirement-analysis/api-01-reset-password.md
docs/requirement-analysis/api-02-checkout.md
docs/requirement-analysis/api-03-import-products.md
```

Hãy sử dụng skill:

```text
hw06-api-workflow
```

và integration với:

```text
log-ai-audit
```

để thực hiện **AI TEST GENERATION cho cả ba API trong cùng một phiên**.

Phiên này **CHỈ GENERATE AI TEST CASES**.

Không thực hiện AI test-case audit, student extension, Postman hay execution.

---

# 1. Xử lý Human Review Audit trước tiên

Trước khi bắt đầu test generation, interaction human review trước đó phải được hoàn tất theo continuous audit policy.

Hiện trạng được báo cáo:

```text
A-003:
AUDIT_ENTRY_VERIFIED
PENDING_HUMAN_REVIEW
```

Human decision hiện tại:

```text
REQUIREMENT_ANALYSIS_REVIEW:
PASS

API_01:
REQUIREMENT_ANALYSIS_APPROVED

API_02:
REQUIREMENT_ANALYSIS_APPROVED

API_03:
REQUIREMENT_ANALYSIS_APPROVED
```

Trước khi bắt đầu substantive test generation:

1. cập nhật/finalize `A-003` bằng human decision trên;
2. verify audit entry;
3. không stage audit files;
4. sau đó mới được bắt đầu test generation.

Nếu A-003 không thể finalize:

```text
WORKFLOW_STATUS:
BLOCKED

BLOCKER:
AUDIT_FINALIZATION_FAILED
```

và STOP.

---

# 2. Mục tiêu phase hiện tại

Sinh AI-generated test cases cho:

### API-01

```text
POST /api/reset-password
```

### API-02

```text
POST /api/checkout
```

### API-03

```text
POST /api/admin/import-products
```

Target cho mỗi API:

```text
GENERATED_TARGET:
38–42 unique AI-generated test cases
```

Hard minimum sau deduplication:

```text
>=35 unique AI-generated test cases / API
```

Tổng dự kiến:

```text
114–126 AI-generated cases
```

Không sinh case chỉ để đạt số lượng.

Mỗi case phải có một mục tiêu/risk/requirement riêng đủ rõ để chứng minh uniqueness.

---

# 3. Source of truth

Test generation phải dựa trước hết vào ba requirement-analysis artifact đã approved:

```text
docs/requirement-analysis/api-01-reset-password.md
docs/requirement-analysis/api-02-checkout.md
docs/requirement-analysis/api-03-import-products.md
```

Có thể đọc lại source gốc khi cần traceability:

* README requirements;
* API specification;
* SEC-01 → SEC-07;
* relevant authoritative documentation.

Implementation source code:

```text
IMPLEMENTATION_ONLY
```

Không được dùng implementation hiện tại để tự định nghĩa expected behavior.

Rule bắt buộc:

```text
AUTHORITATIVE REQUIREMENT
        ↓
expected behavior

IMPLEMENTATION
        ↓
observation only
```

---

# 4. Không undo các Human Review correction

Giữ nguyên các quyết định đã được approve.

## API-01

Classification hiện tại:

```text
3 POTENTIAL_DISCREPANCY
1 IMPLEMENTATION_ONLY_OBSERVATION
```

Không biến implementation observation thành requirement.

---

## API-02

FR-07 và FR-09 chỉ là:

```text
SUPPORTING CONTEXT
```

không phải direct oracle cho `POST /api/checkout`.

Do đó:

* không sinh một cụm testcase checkout chỉ để test toàn bộ FR-07;
* không coi coupon behavior FR-09 là direct checkout requirement;
* chỉ sử dụng chúng khi chúng thật sự tạo context/precondition/risk liên quan.

Đặc biệt:

```text
server-side total calculation
```

là requirement trực tiếp và phải được cover mạnh.

---

## API-03

FR-15 chỉ là:

```text
SUPPORTING CONTEXT
```

trừ requirement nào FR-16 nói trực tiếp.

Giữ nguyên:

```text
CSV_VS_JSON:
UNRESOLVED_REPRESENTATION_GAP
```

Không assume endpoint:

```text
POST /api/admin/import-products
```

nhận raw CSV/multipart upload.

API contract hiện tại được test ở representation:

```json
{
  "products": [...]
}
```

trừ khi có authoritative source khác chứng minh rõ ngược lại.

---

# 5. Test generation techniques

Mỗi API phải có coverage hợp lý trên các technique:

```text
DOMAIN_PARTITION
BOUNDARY
STATE_TRANSITION
SECURITY
SCHEMA
BUSINESS_RULE
```

Không cần ép số lượng bằng nhau.

Target tham khảo cho khoảng 40 case/API:

```text
DOMAIN_PARTITION     ~8–12
BOUNDARY             ~4–7
STATE_TRANSITION     ~5–8
SECURITY             ~7–10
SCHEMA               ~3–6
BUSINESS_RULE        ~4–7
```

Một test case có thể liên quan nhiều technique, nhưng phải có đúng một:

```text
primary_technique
```

để tránh double-count.

Có thể thêm:

```text
secondary_techniques
```

nếu canonical schema cho phép.

---

# 6. Canonical schema

Dùng canonical test-case schema hiện có:

```text
.agents/hw06-api-workflow/references/canonical-test-case-schema.yaml
```

Không tạo schema mới song song.

Mỗi generated case tối thiểu phải giữ được:

```yaml
id:
api_id:
feature_id:
endpoint:
source:
requirement_ids:
technique:
title:
objective:
preconditions:
request:
test_data:
expected_status:
expected_schema:
expected_business_result:
expected_state:
audit_status:
audit_reason:
correction:
why_ai_missed:
execution_status:
failure_classification:
bug_id:
notes:
```

Trong phase hiện tại:

```text
source:
AI_GENERATED
```

và:

```text
audit_status:
NOT_AUDITED
```

hoặc giá trị equivalent theo canonical schema.

Không dùng:

```text
VALID
INVALID
INCOMPLETE
```

ở phase này.

Đó là nhiệm vụ của phase AI Test Audit sau.

---

# 7. Oracle basis

Nếu canonical schema có thể mở rộng backward-compatible, thêm hoặc sử dụng metadata:

```text
oracle_basis
```

với một trong các giá trị:

```text
AUTHORITATIVE
PARTIALLY_SPECIFIED
OBSERVABLE_ONLY
SECURITY_EXPECTATION
```

Ý nghĩa:

### AUTHORITATIVE

Expected behavior được authoritative source quy định rõ.

### PARTIALLY_SPECIFIED

Requirement xác định intent/rule nhưng thiếu một phần contract như exact status/response schema.

### OBSERVABLE_ONLY

Requirement gap tồn tại; case được tạo để quan sát system behavior nhưng không được invent expected oracle.

### SECURITY_EXPECTATION

Security test dựa trên applicable security requirement/risk rõ ràng, nhưng exact transport response có thể chưa được specification định nghĩa.

Nếu việc thêm field phá canonical schema hiện tại, không sửa tùy tiện. Dùng `notes` hoặc metadata mechanism tương đương.

---

# 8. Tuyệt đối không invent oracle

Đây là guard quan trọng nhất của phase này.

Nếu requirement không định nghĩa exact HTTP status:

```text
KHÔNG tự ghi:
200
400
401
403
422
500
```

chỉ vì đó là common REST behavior.

Thay vào đó ghi:

```text
expected_status:
UNSPECIFIED_BY_AUTHORITATIVE_SOURCE
```

hoặc representation tương đương.

Nếu response schema không được định nghĩa:

```text
expected_schema:
UNSPECIFIED_BY_AUTHORITATIVE_SOURCE
```

Nếu behavior chỉ cần observe:

```text
oracle_basis:
OBSERVABLE_ONLY
```

Không biến implementation behavior thành oracle.

---

# 9. API-01 Generation Guidance — Reset Password

Endpoint:

```text
POST /api/reset-password
```

Phải cover hợp lý các dimensions đã approved.

## Domain

Ví dụ phạm vi cần khai thác khi requirement support:

```text
email
resetToken
newPassword
email-token relation
password confirmation ambiguity
```

## Boundary

Tập trung vào requirement-backed boundary:

```text
password minimum length
password character classes
OTP length/entropy requirement
```

Không invent expiry duration.

## State transition

Phải có coverage quanh lifecycle:

```text
reset requested
      ↓
token issued
      ↓
valid reset
      ↓
token invalidated
```

và các state/risk như:

```text
token reuse
cross-email token
expired token
```

nhưng không invent exact expiry duration.

## Security

Ưu tiên:

```text
email/token binding
OTP replay
password handling
reset authorization
brute-force/rate-limit observation where spec is incomplete
user-enumeration observation where appropriate
```

Không assume endpoint cần JWT nếu requirement vẫn không xác nhận điều đó.

## Schema

API contract chỉ document:

```text
email
resetToken
newPassword
```

Password confirmation là requirement-level ambiguity.

Không tự thêm field vào API request như thể contract đã xác nhận.

---

# 10. API-02 Generation Guidance — Checkout

Endpoint:

```text
POST /api/checkout
```

Phải ưu tiên requirement/risk mạnh nhất:

```text
AUTHENTICATION
SERVER-SIDE TOTAL CALCULATION
CART-DERIVED TOTAL
SUCCESSFUL CHECKOUT CLEARS CART
```

## `total_amount`

Đây là trust-boundary dimension quan trọng.

Generate cases quanh:

```text
correct client value
incorrect lower value
incorrect higher value
zero
negative
very large value
non-numeric value
missing value
```

nhưng expected business oracle phải dựa trên:

```text
backend determines authoritative total from cart
```

không dựa trên implementation hiện tại.

## Authentication

Cover:

```text
valid JWT
missing JWT
malformed JWT
invalid JWT
```

và user/cart isolation nếu source/risk support.

## Cart/state

Cover:

```text
cart populated
checkout success
cart-clearing requirement
repeated operation as security/state consideration
```

Empty-cart behavior là requirement gap.

Nếu test empty cart:

```text
oracle_basis:
OBSERVABLE_ONLY
```

không invent expected response.

## Shipping address

Requiredness/format/length chưa được authoritative source xác định.

Các invalid/edge input có thể được generated để observe behavior, nhưng không gắn oracle giả.

## FR-07 / FR-09

Không generate direct checkout requirements từ:

```text
FR-07
FR-09
```

nếu linkage với selected endpoint không được documented.

---

# 11. API-03 Generation Guidance — Import Products

Endpoint:

```text
POST /api/admin/import-products
```

Representation hiện tại:

```json
{
  "products": [...]
}
```

## Authorization

Cover mạnh:

```text
missing JWT
invalid JWT
valid non-admin JWT
valid admin JWT
role escalation
```

## Products array

Cover:

```text
missing
null
non-array
empty
single item
multiple items
mixed validity
```

Maximum batch size là requirement gap.

Không invent hard maximum.

## Item validation

Direct FR-16 requirements phải được ưu tiên:

```text
name non-empty
price positive
atomic import
report counts/reasons
```

FR-15-only constraints như:

```text
name max 255
category existing
```

chỉ được dùng dưới:

```text
SUPPORTING / TEST_CONSIDERATION
```

nếu FR-16 không trực tiếp áp dụng chúng.

Không biến chúng thành hard authoritative oracle.

## Atomicity

Đây là coverage quan trọng:

```text
all valid batch
        ↓
all committed

one invalid row in batch
        ↓
entire batch rolled back
```

Generate nhiều composition có ý nghĩa:

```text
valid + invalid
invalid first
invalid middle
invalid last
multiple invalid
```

nhưng tránh duplicate semantics.

## Report

Requirement nói report phải có:

```text
success/error counts
reasons
```

Exact JSON field names/status chưa được định nghĩa.

Không invent response schema.

## CSV vs JSON

Không generate raw CSV upload testcase trong selected endpoint suite.

Nếu cần ghi risk:

```text
CSV representation remains an unresolved feature/API boundary
```

nhưng không đưa nó thành direct executable API case trừ khi human approve sau.

---

# 12. Deduplication

Sau generation cho mỗi API:

1. kiểm tra semantic duplicates;
2. merge/remove duplicate case;
3. bảo đảm hard minimum vẫn `>=35`;
4. nếu dưới 35, generate thêm case dựa trên uncovered requirement/risk;
5. không tạo trivial variation chỉ để tăng count.

Hai case chỉ khác test-data value nhưng cùng partition/risk không nhất thiết là unique test case.

Ví dụ:

```text
password = abc
password = def
```

không phải hai unique cases nếu cùng equivalence partition.

---

# 13. Requirement traceability

Mỗi test case phải trace về:

```text
requirement_ids
```

hoặc nếu case xuất phát từ requirement gap/security consideration:

```text
gap_id
risk_id
```

nếu schema hỗ trợ.

Cuối mỗi API tạo coverage matrix:

```text
Requirement / Gap / Security Risk
        ↓
Generated Test Cases
```

Mục tiêu:

* mọi direct authoritative requirement testable đều có coverage;
* requirement gap có thể có observational cases;
* không ép mọi implementation observation thành testcase.

---

# 14. Generated artifacts

Tạo ba human-readable artifacts:

```text
docs/test-generation/
├── api-01-reset-password-ai-generated.md
├── api-02-checkout-ai-generated.md
└── api-03-import-products-ai-generated.md
```

Và nếu workflow hiện tại hỗ trợ structured representation, tạo:

```text
test-cases/generated/
├── api-01-reset-password.json
├── api-02-checkout.json
└── api-03-import-products.json
```

hoặc YAML theo convention hiện tại.

Human-readable và structured representations phải nhất quán.

Không tạo Excel ở phase này.

Excel chỉ được tạo sau khi:

```text
AI audit
+
correction
+
student extension
```

đã hoàn tất.

---

# 15. Preserve raw AI generation

Cực kỳ quan trọng:

Không sửa/correct AI-generated test case trong phase này chỉ vì agent tự nhận ra case có thể chưa hoàn hảo.

Phase sau phải có khả năng nhìn thấy:

```text
AI originally generated
        ↓
Human/AI audit classification
        ↓
Correction
```

Do đó generated artifact phải giữ nguyên semantic output của generation phase.

Chỉ được:

* normalize format;
* assign stable IDs;
* remove exact/semantic duplicate;
* fix formatting/schema serialization errors.

Không được sửa expected behavior để "làm case đúng hơn".

---

# 16. Không bắt đầu AI Test Audit

Không classify:

```text
VALID
INVALID
INCOMPLETE
```

Không thêm:

```text
audit_reason
correction
```

trừ default empty/not-audited values.

Không đánh giá case nào là tốt/xấu ở phase này.

Đây phải là raw AI-generated candidate set sau deduplication.

---

# 17. Không bắt đầu Student Extension

Không tạo hoặc promote:

```text
STUDENT_ADDED
```

Không sinh ≥5 student cases ở phase này.

Không ghi:

```text
why_ai_missed
```

trừ placeholder/default empty value.

Student extension chỉ bắt đầu sau AI-generated suite đã được audit.

---

# 18. Không Postman / Execution

Không:

* generate final Postman collection;
* generate Newman suite;
* chạy backend;
* chạy Postman;
* chạy Newman;
* classify product defect;
* tạo screenshot;
* tạo GitHub Issue;
* sửa production code;
* bắt đầu CI/CD.

---

# 19. AI Audit cho interaction hiện tại

Test generation này là substantive AI work.

Sau khi generation hoàn tất:

1. gọi `log-ai-audit`;
2. ghi exact prompt hiện tại;
3. ghi exact substantive output;
4. ghi paths của generated artifacts;
5. verify audit entry;
6. không stage audit files;
7. chỉ sau khi audit verified mới được trả final checkpoint.

Expected next audit ID có thể là `A-004` nếu sequence hiện tại cho phép, nhưng không hardcode ID nếu skill tự quản lý sequence.

Nếu audit write/verification thất bại:

```text
WORKFLOW_STATUS:
BLOCKED

BLOCKER:
AUDIT_WRITE_FAILED
```

và STOP.

---

# 20. Self-review trước khi dừng

Kiểm tra:

```text
[ ] A-003 human review finalized
[ ] 3 approved requirement analyses used
[ ] API selection unchanged

[ ] API-01 generated >=35 unique AI cases
[ ] API-02 generated >=35 unique AI cases
[ ] API-03 generated >=35 unique AI cases

[ ] Target 38–42 attempted for each API
[ ] All cases source = AI_GENERATED
[ ] No case source = STUDENT_ADDED

[ ] Domain coverage exists
[ ] Boundary coverage exists
[ ] State-transition coverage exists
[ ] Security coverage exists
[ ] Schema coverage exists
[ ] Business-rule coverage exists

[ ] No unsupported status code invented
[ ] No unsupported response schema invented
[ ] Implementation behavior not promoted to oracle

[ ] FR-07/FR-09 remain supporting for API-02
[ ] FR-15 remains supporting for API-03
[ ] CSV-vs-JSON remains unresolved
[ ] Raw CSV upload not assumed

[ ] Semantic duplicates removed
[ ] Traceability matrix exists
[ ] AI test audit NOT started
[ ] Student extension NOT started
[ ] Postman NOT started
[ ] Newman NOT started

[ ] Current interaction audited
[ ] Audit entry verified
[ ] Audit files NOT staged
```

---

# 21. Output cuối phiên

Trả summary theo format:

```text
THREE_API_TEST_GENERATION: PASS | PARTIAL | FAIL

PREVIOUS_HUMAN_REVIEW:
A-003: FINALIZED | FAILED

API_01:
ENDPOINT: POST /api/reset-password
GENERATED:
UNIQUE:
DOMAIN_PARTITION:
BOUNDARY:
STATE_TRANSITION:
SECURITY:
SCHEMA:
BUSINESS_RULE:
AUTHORITATIVE_ORACLE:
PARTIAL_ORACLE:
OBSERVABLE_ONLY:
REQUIREMENT_COVERAGE:
STATUS:

API_02:
ENDPOINT: POST /api/checkout
GENERATED:
UNIQUE:
DOMAIN_PARTITION:
BOUNDARY:
STATE_TRANSITION:
SECURITY:
SCHEMA:
BUSINESS_RULE:
AUTHORITATIVE_ORACLE:
PARTIAL_ORACLE:
OBSERVABLE_ONLY:
REQUIREMENT_COVERAGE:
STATUS:

API_03:
ENDPOINT: POST /api/admin/import-products
GENERATED:
UNIQUE:
DOMAIN_PARTITION:
BOUNDARY:
STATE_TRANSITION:
SECURITY:
SCHEMA:
BUSINESS_RULE:
AUTHORITATIVE_ORACLE:
PARTIAL_ORACLE:
OBSERVABLE_ONLY:
REQUIREMENT_COVERAGE:
STATUS:

TOTAL_GENERATED:
TOTAL_UNIQUE:

SEMANTIC_DUPLICATES_REMOVED:

UNRESOLVED_ORACLE_CASES:
<count + brief categories>

ARTIFACTS:
<paths>

AI_TEST_AUDIT_STARTED:
NO

STUDENT_EXTENSION_STARTED:
NO

POSTMAN_STARTED:
NO

AUDIT_ENTRY:
<id> — AUDIT_ENTRY_VERIFIED

AUDIT_FILES_STAGED:
NO

BLOCKERS:
<none hoặc list>

NEXT_CHECKPOINT:
THREE_API_TEST_GENERATION_REVIEW_REQUIRED
```

Sau đó **STOP**.

Không tự động chuyển sang `VALID / INVALID / INCOMPLETE` audit.

Không commit.

Không push.

Chờ student review AI-generated test suites trước khi bắt đầu phase AI Test Audit.
