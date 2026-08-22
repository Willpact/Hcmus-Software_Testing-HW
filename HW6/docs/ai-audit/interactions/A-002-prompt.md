Bộ Agent Skills và chính sách continuous AI Audit cho HW06 đã được setup và approve.

Không cần tạo artifact riêng cho API selection.

Ba API đã được student chọn và sẽ chỉ được mô tả ngắn trong Main Report sau này.

## Selected APIs

### API-01 — Pool A

* Feature: FR-03 Password Reset
* Endpoint: `POST /api/reset-password`

### API-02 — Pool B

* Feature: FR-08 Checkout
* Endpoint: `POST /api/checkout`

### API-03 — Pool C

* Feature: FR-16 Import Products
* Endpoint: `POST /api/admin/import-products`

Các API này đã được chọn để tránh trùng với các endpoint mà các thành viên khác trong nhóm đã sử dụng.

Không thay đổi API selection trong phiên này.

---

# 1. Audit interaction trước đó

Trước khi bắt đầu substantive work:

1. Ghi nhận human decision vừa rồi:

   * `HW06_AUDIT_POLICY_PATCH: APPROVED`
   * API selection giữ nguyên.
   * Student quyết định không tạo `docs/api-selection.md`; selection sẽ chỉ được mô tả ngắn trong Main Report.

2. Dùng `log-ai-audit` theo policy hiện tại để ghi interaction/decision này nếu policy yêu cầu.

3. Không stage hoặc commit AI Audit Log.

Sau đó mới tiếp tục requirement analysis.

---

# 2. Mục tiêu phiên hiện tại

Dùng skill:

`hw06-api-workflow`

để thực hiện **Requirement Analysis cho cả ba API trong cùng một phiên**.

Không generate test cases ở phiên này.

Pipeline:

```text
Repository / Requirements / API Specification
                ↓
       Source Classification
                ↓
       Requirement Extraction
                ↓
       Parameter Analysis
                ↓
       Domain Partition Planning
                ↓
       Business Rules
                ↓
       State Rules
                ↓
       Security Requirements
                ↓
       Response / Schema Contract
                ↓
       Requirement Gaps
                ↓
       Implementation Inspection
                ↓
       Implementation Discrepancies
                ↓
       Coverage Planning
                ↓
       AI Audit
                ↓
       HUMAN REVIEW CHECKPOINT
```

---

# 3. Source inspection

Trước hết inspect repository để tìm các nguồn liên quan đến ba API.

Ưu tiên tìm và đọc:

* `api_specification.md`
* requirement/feature documentation cho FR-03
* requirement/feature documentation cho FR-08
* requirement/feature documentation cho FR-16
* security requirements SEC-01 → SEC-07
* README hoặc requirement documents có liên quan
* source code implementation tương ứng
* database/schema/seed data chỉ khi cần để hiểu observable implementation hoặc chuẩn bị test-data planning

Không assume path; hãy tìm file thực tế trong repository.

---

# 4. Source classification

Mỗi nguồn phải được classify rõ:

```text
AUTHORITATIVE
SUPPORTING
IMPLEMENTATION_ONLY
```

Quy tắc:

### AUTHORITATIVE

Nguồn định nghĩa expected behavior, ví dụ:

* requirement specification
* feature requirement
* API specification
* security requirement

### SUPPORTING

Nguồn giúp hiểu context nhưng không tự mình định nghĩa expected behavior.

### IMPLEMENTATION_ONLY

Source code, database handler, controller, service, route hoặc implementation hiện tại.

Cực kỳ quan trọng:

```text
IMPLEMENTATION BEHAVIOR != REQUIREMENT
```

Không được biến behavior hiện tại của code thành expected result chỉ vì code đang làm như vậy.

Nếu implementation khác specification:

```text
Expected = authoritative requirement
Actual implementation = implementation observation
```

và ghi thành discrepancy.

---

# 5. Requirement extraction

Cho từng API, extract thành **atomic requirements** có stable ID.

Ví dụ:

```text
API01-REQ-001
API01-REQ-002
...

API02-REQ-001
...

API03-REQ-001
...
```

Một requirement chỉ nên chứa một behavior/rule có thể test riêng.

Mỗi requirement phải có:

```text
ID
Source
Source classification
Requirement statement
Relevant parameters/state/security
Notes
```

Nếu requirement không được source support đầy đủ, không tự điền bằng kiến thức chung.

Ghi thành:

```text
REQUIREMENT_GAP
```

hoặc:

```text
NEEDS_CLARIFICATION
```

---

# 6. API-01 — POST /api/reset-password

Phân tích tối thiểu:

## Request

* `email`
* `resetToken`
* `newPassword`
* content type
* required/optional fields nếu source định nghĩa

## Authentication / Authorization

Xác định từ source:

* endpoint có cần JWT không;
* reset token đóng vai trò gì;
* identity được ràng buộc với email/token như thế nào nếu specification nói rõ.

Không tự assume.

## Domain partitions

Lập kế hoạch partition cho từng parameter dựa trên requirement thực tế.

Ví dụ các dimension cần xem xét nếu source support:

```text
email
resetToken
newPassword
```

Chưa tạo test cases.

## State behavior

Tìm requirement liên quan:

```text
forgot-password
        ↓
reset token issued
        ↓
reset-password
        ↓
password changed
```

Xác định nếu source có nói về:

* token valid/invalid;
* expiration;
* token reuse;
* password state;
* previous password;
* login sau reset.

Nếu source không định nghĩa thì ghi gap, không invent.

## Security

Map các SEC requirement thực sự applicable.

Quan tâm đặc biệt tới các risk như:

```text
credential reset authorization
token misuse
replay
user enumeration
brute-force-like behavior
input injection
```

Nhưng chỉ đưa vào expected requirement nếu có source support.

Risk chưa được specification định nghĩa vẫn có thể ghi ở:

```text
SECURITY_TEST_CONSIDERATION
```

không phải authoritative requirement.

---

# 7. API-02 — POST /api/checkout

Phân tích tối thiểu:

## Request

* Authorization header
* `total_amount`
* `shipping_address`

và mọi dependency khác được requirement/source xác nhận.

## Preconditions

Tìm requirement liên quan:

* authenticated user;
* cart state;
* cart ownership;
* cart contents;
* product state;
* order creation.

Không assume nếu spec không nói.

## Business rules

Tìm các rule về:

```text
cart
total
shipping address
order creation
inventory
coupon/discount interaction
```

chỉ khi authoritative source thực sự định nghĩa.

## State behavior

Tìm state transition liên quan:

```text
cart state
        ↓
checkout
        ↓
order creation
        ↓
initial order status
```

và các side effect khác nếu specification định nghĩa.

## Security

Map SEC requirements applicable.

Đặc biệt inspect potential trust-boundary issue:

```text
client-provided total_amount
```

Nhưng phải phân biệt:

```text
SPECIFICATION EXPECTATION
vs
IMPLEMENTATION OBSERVATION
```

Không tự kết luận bug ở phase này.

---

# 8. API-03 — POST /api/admin/import-products

Phân tích tối thiểu:

## Authentication / Authorization

Xác định requirement về:

```text
Bearer token
Admin role
```

và các security requirements liên quan.

## Request structure

Phân tích:

```text
products[]
```

và từng field nếu source định nghĩa:

```text
name
price
description
imageUrl
category_id
```

## Domain partitions

Xác định dimensions như:

```text
array presence/type
array size
individual product fields
numeric boundaries
category references
duplicate values
mixed-validity batch
```

Chưa generate cases.

## Batch semantics

Kiểm tra xem authoritative source có định nghĩa:

```text
all-or-nothing
partial success
rollback
error per item
duplicate handling
maximum batch size
```

Nếu không có, ghi:

```text
REQUIREMENT_GAP
```

Không suy diễn từ implementation.

## Security

Map:

```text
authentication
admin authorization
role escalation
input injection
mass assignment
unexpected fields
```

tùy theo requirements thực tế.

---

# 9. Requirement gaps

Cho mỗi API, tạo danh sách riêng:

```text
API01-RG-001
API02-RG-001
API03-RG-001
```

Mỗi gap phải có:

```text
Gap
Why it matters for testing
Affected test technique
Recommended handling
```

Handling có thể là:

```text
TEST_OBSERVABLE_BEHAVIOR
NEEDS_HUMAN_DECISION
SECURITY_TEST_CONSIDERATION
IMPLEMENTATION_COMPARISON_ONLY
```

Không tự đặt expected result cho behavior không được specification định nghĩa.

---

# 10. Implementation inspection

Sau khi requirement extraction hoàn tất, inspect implementation của ba endpoint.

Mục tiêu:

* hiểu system hiện tại;
* chuẩn bị automation/test-data về sau;
* phát hiện difference giữa requirement và implementation.

Không sửa production code.

Không report bug.

Không thay requirement bằng implementation.

---

# 11. Implementation discrepancies

Stable IDs:

```text
API01-ID-001
API02-ID-001
API03-ID-001
```

Mỗi discrepancy:

```text
Relevant requirement
Expected from authoritative source
Observed implementation
Potential testing impact
Status
```

Status:

```text
POTENTIAL_DISCREPANCY
SPEC_AMBIGUITY
IMPLEMENTATION_ONLY_OBSERVATION
```

Không dùng `PRODUCT_DEFECT` ở phase requirement analysis.

Product defect chỉ được xác nhận sau real execution và human triage.

---

# 12. Coverage planning

Cho mỗi API, lập coverage plan nhưng **không viết test case**.

Các categories:

```text
DOMAIN_PARTITION
BOUNDARY
STATE_TRANSITION
SECURITY
SCHEMA
BUSINESS_RULE
```

Output ví dụ:

```text
DOMAIN_PARTITION:
- email format
- resetToken classes
...

STATE_TRANSITION:
- ...
```

Không tạo TC ID.

Không generate expected request/response cụ thể.

Mục tiêu chỉ để chuẩn bị cho phase test generation tiếp theo.

---

# 13. Artifact structure

Tạo ba artifact riêng.

Ưu tiên structure:

```text
docs/requirement-analysis/
├── api-01-reset-password.md
├── api-02-checkout.md
└── api-03-import-products.md
```

Nếu repository đã có convention tốt hơn thì reuse convention hiện có.

Mỗi artifact nên chứa:

```text
1. API Overview
2. Sources
3. Source Classification
4. Atomic Requirements
5. Parameter Analysis
6. Domain Partition Planning
7. Business Rules
8. State Rules
9. Security Requirements
10. Schema / Response Contract
11. Requirement Gaps
12. Implementation Observations
13. Implementation Discrepancies
14. Coverage Plan
15. Open Questions
16. Analysis Status
```

---

# 14. Cross-API summary

Sau khi hoàn thành ba artifact, trả summary số lượng:

```text
API-01
AUTHORITATIVE_SOURCES:
SUPPORTING_SOURCES:
IMPLEMENTATION_ONLY_SOURCES:
ATOMIC_REQUIREMENTS:
REQUIREMENT_GAPS:
IMPLEMENTATION_DISCREPANCIES:
SECURITY_REQUIREMENTS:
STATE_RULES:

API-02
...

API-03
...
```

Không cần tạo artifact summary riêng trừ khi workflow hiện có yêu cầu.

---

# 15. AI Audit

Interaction hiện tại là substantive HW06 work và bắt buộc phải audit.

Sau khi artifacts đã được tạo:

1. gọi/use `log-ai-audit`;
2. append exact prompt;
3. append exact AI output;
4. ghi artifact paths;
5. verify audit entry;
6. chỉ sau khi audit entry được verify mới được chuyển checkpoint.

Nếu audit thất bại:

```text
WORKFLOW_STATUS:
BLOCKED

BLOCKER:
AUDIT_WRITE_FAILED
```

và STOP.

AI Audit files:

* được cập nhật;
* KHÔNG stage;
* KHÔNG commit.

Audit Log vẫn phải là final HW06 commit sau này.

---

# 16. Không làm trong phiên này

Không:

* generate ≥35 test cases;
* tạo test case IDs;
* add student-extension cases;
* tạo final Excel;
* tạo Postman collection;
* chạy Postman;
* chạy Newman;
* sửa production code;
* report product defect;
* tạo GitHub Issues;
* tạo CI/CD;
* viết Main Report;
* viết AI Critique;
* commit;
* push;
* stage AI Audit files.

---

# 17. Self-review trước khi kết thúc

Verify:

```text
[ ] 3 selected APIs unchanged
[ ] 3 requirement-analysis artifacts created
[ ] Authoritative vs implementation separated
[ ] Atomic requirements traceable to sources
[ ] No implementation behavior promoted to requirement
[ ] Requirement gaps explicitly recorded
[ ] Security requirements mapped
[ ] State rules identified
[ ] Schema contracts identified
[ ] Implementation discrepancies only marked as potential
[ ] Coverage plan exists
[ ] No test cases generated
[ ] No product defect declared
[ ] Current interaction audited
[ ] Audit files not staged
```

---

# 18. Output cuối phiên

Trả đúng summary:

```text
THREE_API_REQUIREMENT_ANALYSIS: PASS | PARTIAL | FAIL

API_01:
ENDPOINT: POST /api/reset-password
ATOMIC_REQUIREMENTS:
REQUIREMENT_GAPS:
IMPLEMENTATION_DISCREPANCIES:
SECURITY_RULES:
STATE_RULES:
STATUS:

API_02:
ENDPOINT: POST /api/checkout
ATOMIC_REQUIREMENTS:
REQUIREMENT_GAPS:
IMPLEMENTATION_DISCREPANCIES:
SECURITY_RULES:
STATE_RULES:
STATUS:

API_03:
ENDPOINT: POST /api/admin/import-products
ATOMIC_REQUIREMENTS:
REQUIREMENT_GAPS:
IMPLEMENTATION_DISCREPANCIES:
SECURITY_RULES:
STATE_RULES:
STATUS:

ARTIFACTS:
<paths>

AUDIT_ENTRY:
<id/status>

AUDIT_FILES_STAGED:
NO

BLOCKERS:
<none hoặc list>

NEXT_CHECKPOINT:
THREE_API_REQUIREMENT_ANALYSIS_REVIEW_REQUIRED
```

Sau đó **STOP**.

Không tự động chuyển sang test generation cho đến khi student review và approve requirement analysis.
