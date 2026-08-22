Student Extension targeted review đã hoàn tất.

Kết quả human review:

```text
STUDENT_DECISION:
MODIFIED_AND_APPROVED

API_01:
5/5 APPROVED

API_02:
4/5 APPROVED
1 REPLACEMENT_REQUIRED

API_03:
4/5 APPROVED
1 REPLACEMENT_REQUIRED

TOTAL_APPROVED_EXISTING:
13

TOTAL_REPLACEMENTS_REQUIRED:
2
```

Review trước đó:

```text
CASES_REVIEWED: 15

GENUINELY_MISSED:
YES: 13
NO: 2
UNCERTAIN: 0
```

Audit interaction gần nhất:

```text
A-008 — AUDIT_ENTRY_VERIFIED
```

Sử dụng:

```text
hw06-api-workflow
log-ai-audit
```

Mục tiêu phiên này:

1. finalize human review của A-008;
2. xác định chính xác 1 Student case cần replace ở API-02;
3. xác định chính xác 1 Student case cần replace ở API-03;
4. giữ nguyên 13 approved cases;
5. generate đúng 1 replacement cho API-02;
6. generate đúng 1 replacement cho API-03;
7. audit hai replacement candidate;
8. tạo mini human-review packet;
9. STOP.

Không commit Student Extension.

Không bắt đầu Postman.

---

# 1. Finalize targeted-review decision

Ghi nhận human decision:

```text
STUDENT_EXTENSION_TARGETED_REVIEW:
MODIFIED_AND_APPROVED

API_01:
5 APPROVED

API_02:
4 APPROVED
1 REPLACEMENT_REQUIRED

API_03:
4 APPROVED
1 REPLACEMENT_REQUIRED
```

Finalize interaction A-008 hoặc interaction tương ứng thực tế.

Verify audit entry.

Nếu finalize thất bại:

```text
WORKFLOW_STATUS:
BLOCKED

BLOCKER:
HUMAN_REVIEW_AUDIT_FINALIZATION_FAILED
```

và STOP.

Không stage:

```text
docs/ai-audit/
```

---

# 2. Identify rejected Student cases

Đọc:

```text
docs/test-extension/student-extension-human-review-packet.md
docs/test-extension/api-02-checkout-student-extension.md
docs/test-extension/api-03-import-products-student-extension.md

test-cases/student-added/
```

Xác định đúng:

```text
API_02_REJECTED_CASE:
<case id>

API_03_REJECTED_CASE:
<case id>
```

Reason phải lấy từ targeted review hiện tại.

Hai case đó phải có:

```text
GENUINELY_MISSED:
NO
```

Không tự chọn một case khác.

---

# 3. Preserve rejected cases in history

Không xóa dấu vết của hai case rejected khỏi audit/history.

Trong Student Extension artifacts có thể ghi:

```text
HUMAN_DECISION:
REPLACE

FINAL_DISPOSITION:
REJECTED_AS_STUDENT_EXTENSION

REASON:
NOT_GENUINELY_MISSED_BY_AI
```

Nhưng chúng **không được tính** vào requirement:

```text
>=5 approved STUDENT_ADDED cases / API
```

Không reuse ID của rejected case cho replacement nếu điều đó làm mất traceability.

Ưu tiên stable replacement ID kiểu:

```text
API02-STU-006
API03-STU-006
```

hoặc convention tương đương nếu schema hiện tại yêu cầu.

---

# 4. Generate exactly one API-02 replacement

Endpoint:

```text
POST /api/checkout
```

Generate đúng:

```text
1 replacement Student Extension case
```

Case phải thực sự nằm ngoài semantic coverage của:

```text
40 raw AI-generated API-02 cases
+
corrected executable API-02 suite
+
4 approved Student Extension API-02 cases
```

Không tạo filler.

---

# 5. API-02 authoritative focus

Replacement ưu tiên một interaction/risk có authoritative oracle trong các vùng:

```text
server-calculated total
client total trust boundary
authenticated user/cart isolation
cart-derived total
successful checkout clears cart
JWT + business-rule interaction
cross-user state isolation
state consistency after authoritative success
```

Ưu tiên **combination interaction** mà AI đã cover riêng lẻ nhưng chưa cover cùng nhau.

Ví dụ kiểu reasoning được phép:

```text
valid authenticated user
+
cart belonging to that user
+
manipulated client total
+
server must still use cart-derived total
+
on confirmed success only that user's cart is cleared
```

Chỉ dùng ví dụ này nếu semantic comparison chứng minh raw AI suite chưa có case tương đương.

---

# 6. API-02 forbidden replacement areas

Không dùng một case phụ thuộc hoàn toàn vào:

```text
empty-cart policy
shipping_address format/length/requiredness
coupon integration
idempotency policy
initial order status
order-line persistence
```

vì các contract đó vẫn unresolved.

Không chỉ đổi numeric value của `total_amount` rồi gọi đó là case mới.

---

# 7. Generate exactly one API-03 replacement

Endpoint:

```text
POST /api/admin/import-products
```

Generate đúng:

```text
1 replacement Student Extension case
```

Case phải genuinely missed bởi:

```text
40 raw AI-generated API-03 cases
+
corrected executable API-03 suite
+
4 approved Student Extension API-03 cases
```

---

# 8. API-03 authoritative focus

Ưu tiên combination/stateful coverage quanh:

```text
admin role enforcement
mixed-validity batch
atomic rollback
multiple invalid rows
invalid row position
positive price
non-empty name
report success/error counts and reasons
security + atomicity interaction
```

Ưu tiên một case kết hợp nhiều authoritative invariants mà raw generation chưa kiểm tra cùng nhau.

Ví dụ có thể xem xét:

```text
admin-valid batch
+
multiple rows
+
more than one invalid row using direct FR-16 validation
+
verify entire batch rollback
+
verify reporting captures error reasons/count semantics without inventing JSON field names
```

Chỉ giữ nếu semantic comparison chứng minh case thật sự distinct.

---

# 9. API-03 forbidden replacement areas

Không dùng:

```text
maximum batch size
duplicate policy
category existence behavior
price precision
raw CSV multipart upload
FR-15-only constraints as direct oracle
```

Giữ:

```text
FR-15:
SUPPORTING_ONLY

CSV_VS_JSON:
UNRESOLVED_REPRESENTATION_GAP
```

---

# 10. Replacement case schema

Mỗi replacement phải dùng:

```text
source:
STUDENT_ADDED
```

và có đầy đủ:

```yaml
id:
api_id:
source: STUDENT_ADDED
title:
objective:
requirement_ids:
primary_technique:
secondary_techniques:
preconditions:
request:
test_data:
expected_status:
expected_business_result:
expected_state:
oracle_basis:
why_ai_missed:
difference_from_ai_generated_suite:
closest_ai_cases:
human_review_status:
```

Ban đầu:

```text
human_review_status:
PENDING_HUMAN_REVIEW
```

---

# 11. Why AI missed must be specific

Không dùng generic explanation.

Ưu tiên các category thực sự phù hợp:

```text
COMBINATION_INTERACTION_GAP
STATEFUL_REASONING_GAP
SECURITY_REASONING_GAP
COVERAGE_BLIND_SPOT
PROMPT_LIMITATION
```

Ví dụ:

```text
WHY_AI_MISSED_CATEGORY:
COMBINATION_INTERACTION_GAP

WHY_AI_MISSED:
Raw AI generation covered client-total manipulation and cart-state transition separately, but did not combine the trust-boundary manipulation with authenticated-user state verification in a single stateful scenario.
```

Chỉ dùng nếu đúng với actual suite.

---

# 12. Mandatory semantic comparison

Trước khi giữ replacement, compare nó với:

```text
all 40 raw cases
all corrected AI cases
all approved Student Extension cases
```

của cùng API.

Record:

```text
CLOSEST_AI_CASES:
...

CLOSEST_STUDENT_CASES:
...

SEMANTIC_DIFFERENCE:
...

GENUINELY_MISSED:
YES | NO
```

Replacement chỉ được giữ nếu:

```text
GENUINELY_MISSED:
YES
```

Nếu candidate đầu tiên là duplicate:

* discard candidate;
* generate another genuine candidate;
* record count trong summary.

Không giữ weak case chỉ để đủ 5.

---

# 13. Oracle audit

Replacement chỉ đạt nếu:

```text
ORACLE_REVIEW:
SUFFICIENT
```

Exact HTTP status có thể:

```text
UNSPECIFIED_BY_AUTHORITATIVE_SOURCE
```

nếu business/security/state oracle vẫn đủ pass/fail.

Không invent transport details.

---

# 14. Execution feasibility

Classify replacement:

```text
POSTMAN_DIRECT
POSTMAN_WITH_PRECONDITION_SETUP
POSTMAN_PLUS_EXTERNAL_VERIFICATION
NOT_CURRENTLY_EXECUTABLE
```

Ưu tiên replacement có thể:

```text
POSTMAN_WITH_PRECONDITION_SETUP
```

nhưng không hy sinh chất lượng requirement để ép automation.

---

# 15. Update draft Student Extension artifacts

Chỉ sau khi tìm được replacement genuinely missed:

update draft:

```text
docs/test-extension/api-02-checkout-student-extension.md
docs/test-extension/api-03-import-products-student-extension.md

test-cases/student-added/api-02-checkout.json
test-cases/student-added/api-03-import-products.json
```

Giữ rejected case history/disposition nếu workflow hiện tại hỗ trợ.

Không mark replacement human-approved.

---

# 16. API-01 must remain untouched semantically

API-01 đã:

```text
5/5 APPROVED
```

Không regenerate.

Không modify semantic content.

Chỉ có thể cập nhật human-review metadata nếu cần.

---

# 17. Do not commit Student Extension yet

Ngay cả sau replacement:

```text
STUDENT_EXTENSION_COMMITTED:
NO
```

Human vẫn phải review hai replacement mới.

Không stage:

```text
docs/ai-audit/
```

Không push.

---

# 18. Create mini review packet

Tạo:

```text
docs/test-extension/replacement-human-review-packet.md
```

Chỉ chứa hai replacement:

```text
1 API-02 replacement
1 API-03 replacement
```

Mỗi record:

```text
CASE_ID:
API:
REPLACES:
TITLE:

REQUIREMENTS:

WHY_AI_MISSED_CATEGORY:
WHY_AI_MISSED:

CLOSEST_AI_CASES:
CLOSEST_STUDENT_CASES:

SEMANTIC_DIFFERENCE:

GENUINELY_MISSED:
YES

ORACLE_REVIEW:
SUFFICIENT

EXECUTION_FEASIBILITY:

AI_RECOMMENDATION:
APPROVE | REJECT

HUMAN_DECISION:
PENDING

HUMAN_COMMENT:
```

---

# 19. Extension counts after replacement

Preview phải phân biệt:

```text
APPROVED_EXISTING
REJECTED
REPLACEMENT_PENDING
```

Expected:

```text
API_01:
APPROVED_EXISTING: 5
REPLACEMENT_PENDING: 0

API_02:
APPROVED_EXISTING: 4
REJECTED: 1
REPLACEMENT_PENDING: 1

API_03:
APPROVED_EXISTING: 4
REJECTED: 1
REPLACEMENT_PENDING: 1
```

Không được báo:

```text
API-02 APPROVED: 5
API-03 APPROVED: 5
```

trước human decision mới.

---

# 20. Continuous AI Audit

Interaction hiện tại là substantive.

Sau khi replacement generation và review packet hoàn tất:

1. use `log-ai-audit`;
2. record exact prompt;
3. record exact substantive output;
4. record rejected IDs;
5. record replacement IDs;
6. record artifact paths;
7. verify audit entry.

Không stage audit files.

Nếu audit fails:

```text
WORKFLOW_STATUS:
BLOCKED

BLOCKER:
AUDIT_WRITE_FAILED
```

và STOP.

---

# 21. No Postman yet

Không:

```text
build Postman
build Newman
run SUT
execute API tests
generate Excel
create bug reports
start CI/CD
```

Hai replacement phải được human-approved trước.

---

# 22. Self-review

Verify:

```text
[ ] A-008/human targeted-review finalized

[ ] Exact rejected API-02 case identified
[ ] Exact rejected API-03 case identified

[ ] API-01 5 approved cases preserved

[ ] Exactly 1 API-02 replacement generated
[ ] Exactly 1 API-03 replacement generated

[ ] Both replacement cases source=STUDENT_ADDED
[ ] Both genuinely missed=YES
[ ] Both compared with all 40 raw cases
[ ] Both compared with corrected suite
[ ] Both compared with approved Student cases

[ ] No requirement-gap oracle invented
[ ] why_ai_missed is specific
[ ] Execution feasibility classified

[ ] Mini human-review packet created
[ ] Replacement human decision=PENDING

[ ] Student Extension not committed
[ ] Postman not started

[ ] Current interaction audited
[ ] Audit entry verified
[ ] Audit files not staged

[ ] No push
```

---

# 23. Output final

Trả:

```text
STUDENT_EXTENSION_REPLACEMENT: PASS | PARTIAL | FAIL

PREVIOUS_HUMAN_REVIEW:
FINALIZED

API_01:
APPROVED_EXISTING: 5
CHANGED: NO

API_02:
ORIGINAL_APPROVED: 4
REJECTED_CASE:
REJECTION_REASON:
REPLACEMENT_CASE:
GENUINELY_MISSED:
ORACLE_REVIEW:
EXECUTION_FEASIBILITY:
AI_RECOMMENDATION:
REPLACEMENT_HUMAN_STATUS: PENDING

API_03:
ORIGINAL_APPROVED: 4
REJECTED_CASE:
REJECTION_REASON:
REPLACEMENT_CASE:
GENUINELY_MISSED:
ORACLE_REVIEW:
EXECUTION_FEASIBILITY:
AI_RECOMMENDATION:
REPLACEMENT_HUMAN_STATUS: PENDING

CANDIDATES_DISCARDED_AS_DUPLICATES:

REVIEW_PACKET:
docs/test-extension/replacement-human-review-packet.md

CURRENT_EXTENSION_STATUS:
API_01: 5 APPROVED
API_02: 4 APPROVED + 1 PENDING
API_03: 4 APPROVED + 1 PENDING

STUDENT_EXTENSION_COMMITTED:
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
STUDENT_EXTENSION_REPLACEMENT_HUMAN_REVIEW_REQUIRED
```

Sau đó STOP.

Không tự approve replacements.
Không commit Student Extension.
Không bắt đầu Postman.

