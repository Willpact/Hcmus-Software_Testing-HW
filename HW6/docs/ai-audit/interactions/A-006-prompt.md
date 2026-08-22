AI Test Audit cho 120 AI-generated test cases đã hoàn tất.

Kết quả hiện tại:

```text
THREE_API_AI_TEST_AUDIT:
PASS

TOTAL:
AUDITED: 120
VALID: 69
INVALID: 3
INCOMPLETE: 48

API-01:
VALID: 21
INVALID: 2
INCOMPLETE: 17

API-02:
VALID: 23
INVALID: 1
INCOMPLETE: 16

API-03:
VALID: 25
INVALID: 0
INCOMPLETE: 15
```

Audit artifacts:

```text
docs/test-audit/api-01-reset-password-audit.md
docs/test-audit/api-02-checkout-audit.md
docs/test-audit/api-03-import-products-audit.md
docs/test-audit/cross-api-failure-patterns.md

test-cases/audited/api-01-reset-password.json
test-cases/audited/api-02-checkout.json
test-cases/audited/api-03-import-products.json
test-cases/audited/cross-api-summary.json
```

Raw generation artifacts phải tiếp tục được giữ nguyên.

Sử dụng:

```text
hw06-api-workflow
log-ai-audit
```

Phiên này **chỉ chuẩn bị một Human Review Packet có chọn mẫu**.

Không correction test suite.
Không Student Extension.
Không Postman.

---

# 1. Ghi nhận human decision hiện tại

Human chưa approve toàn bộ AI Test Audit.

Human decision hiện tại là:

```text
STUDENT_DECISION:
AUDIT_SUMMARY_ACCEPTED_FOR_TARGETED_REVIEW

THREE_API_AI_TEST_AUDIT:
NOT_YET_FINAL_APPROVED

REASON:
Aggregate results are plausible, but targeted human review of individual classifications is required before final approval.
```

Ghi interaction này vào continuous AI Audit theo policy hiện tại.

Không finalize AI Test Audit thành `APPROVED`.

Không stage hoặc commit Audit Log.

---

# 2. Mục tiêu

Tạo một artifact:

```text
docs/test-audit/human-review-packet.md
```

Mục tiêu là cho student có thể human-review nhanh những classification quan trọng mà không phải đọc toàn bộ 120 case.

Packet phải lấy dữ liệu từ:

```text
test-cases/generated/
test-cases/audited/
docs/test-audit/
docs/requirement-analysis/
```

Không tạo classification mới.

Không thay đổi classification hiện tại.

Chỉ **trích xuất, đối chiếu và trình bày** những case cần human review.

---

# 3. Cases bắt buộc phải đưa vào packet

## A. TẤT CẢ INVALID

Phải đưa đủ toàn bộ:

```text
3 INVALID cases
```

Không bỏ case nào.

---

## B. TẤT CẢ semantic duplicate findings

Generation audit báo:

```text
SEMANTIC_DUPLICATES:
API-01: 1
API-02: 1
API-03: 0
```

Đưa cả hai duplicate findings vào packet.

Hiển thị:

```text
case_id
duplicate_of
difference
reason it was considered semantic duplicate
```

---

## C. TẤT CẢ traceability issues

Hiện có:

```text
API-01: 1
API-02: 0
API-03: 0
```

Đưa case này vào packet.

---

# 4. Representative INCOMPLETE cases

Chọn **ít nhất 4 INCOMPLETE cases / API**.

Tổng:

```text
>=12 representative INCOMPLETE cases
```

Việc chọn phải coverage các failure pattern khác nhau.

Ưu tiên lấy từ:

```text
AMBIGUOUS_EXPECTED_RESULT
REQUIREMENT_GAP_ASSUMPTION
CROSS_FEATURE_OVERREACH
SECURITY_REASONING_GAP
MISSING_STATE_SETUP
```

Không chọn bốn case cùng một kiểu nếu API có nhiều failure pattern khác nhau.

---

# 5. API-specific INCOMPLETE coverage

## API-01 — Reset Password

Representative set nên bao phủ nếu tồn tại:

```text
password confirmation ambiguity
OTP expiry duration
rate-limit / failed-attempt behavior
user enumeration
state setup / issued token
```

Ít nhất 4 case.

---

## API-02 — Checkout

Representative set nên bao phủ nếu tồn tại:

```text
shipping-address contract
empty-cart behavior
repeated checkout / idempotency
coupon integration
order state / side effects
```

Ít nhất 4 case.

---

## API-03 — Import Products

Representative set nên bao phủ nếu tồn tại:

```text
CSV-vs-JSON boundary
maximum batch size
duplicate policy
category contract
price precision
optional description/image fields
response/report schema
```

Ít nhất 4 case.

---

# 6. Representative VALID cases

Chọn:

```text
2 VALID cases / API
```

Tổng:

```text
6 VALID cases
```

Mỗi API nên có:

* 1 case requirement/business/state oriented;
* 1 case security-oriented nếu có thể.

Mục tiêu là kiểm tra agent có đang classify `VALID` quá dễ hay không.

---

# 7. Selection rules

Không cherry-pick chỉ các case dễ defend.

Nếu có case classification đáng ngờ, ưu tiên đưa vào packet.

Selection phải có lý do rõ ràng:

```text
SELECTION_REASON:
INVALID
SEMANTIC_DUPLICATE
TRACEABILITY_ISSUE
REPRESENTATIVE_INCOMPLETE
REPRESENTATIVE_VALID
```

Nếu một case thuộc nhiều nhóm, chỉ trình bày một lần và ghi tất cả lý do.

---

# 8. Nội dung mỗi review record

Với mỗi case trong packet, hiển thị tối thiểu:

```text
CASE ID
API
PRIMARY TECHNIQUE
SELECTION REASON

RAW AI-GENERATED CASE
- title
- objective
- requirement IDs
- preconditions
- request / test data
- expected status
- expected business result
- expected state
- oracle basis
- notes

AI AUDIT PROPOSAL
- classification
- classification reason
- traceability assessment
- oracle assessment
- issues
- duplicate_of if applicable
- proposed correction
- proposed action

RELEVANT REQUIREMENT/GAP
- referenced requirement IDs
- short source-backed statement

HUMAN REVIEW
Decision: PENDING
Comment:
```

Do not rewrite the raw case to make it look better.

Preserve its original semantic content.

---

# 9. Human decision values

Trong packet, mỗi case phải có placeholder:

```text
HUMAN_DECISION:
PENDING
```

Student sau này sẽ chọn một trong:

```text
APPROVE_CLASSIFICATION
CHANGE_TO_VALID
CHANGE_TO_INVALID
CHANGE_TO_INCOMPLETE
MODIFY_CORRECTION
REMOVE_FROM_FINAL_SUITE
DEFER_AS_REQUIREMENT_GAP
```

Không tự điền human decision.

---

# 10. Cross-case summary

Cuối packet tạo summary:

```text
TOTAL_CASES_IN_REVIEW_PACKET:

INVALID_INCLUDED:
3/3

SEMANTIC_DUPLICATES_INCLUDED:
2/2

TRACEABILITY_ISSUES_INCLUDED:
1/1

INCOMPLETE_SAMPLES:
API-01:
API-02:
API-03:

VALID_SAMPLES:
API-01: 2
API-02: 2
API-03: 2
```

Sau đó thêm section:

```text
HUMAN REVIEW QUESTIONS
```

gồm những câu hỏi cụ thể cần student quyết định.

Ví dụ:

```text
1. Do the three INVALID classifications appear justified?
2. Are the two semantic duplicates truly redundant?
3. Should observable-only requirement-gap cases remain INCOMPLETE or be retained as final observational tests?
4. Are any cross-feature cases salvageable by narrowing their oracle?
5. Are VALID cases adequately requirement-backed?
```

Không tự trả lời thay human trong section này.

---

# 11. Không thay đổi AI Test Audit

Trong phiên này tuyệt đối không:

* thay `VALID / INVALID / INCOMPLETE`;
* apply proposed correction;
* remove cases;
* modify raw generation;
* modify structured audited classifications;
* create corrected suite;
* create Student Extension cases.

Current classification phải vẫn là:

```text
AI_AUDIT_PROPOSAL
```

chờ human review.

---

# 12. Không commit audit artifacts

Không commit:

```text
docs/test-audit/
test-cases/audited/
docs/ai-audit/
```

trong phiên này.

Human review chưa hoàn tất.

Không push.

---

# 13. Continuous AI Audit

Interaction hiện tại có ảnh hưởng tới workflow HW06 nên phải được audit.

Sau khi tạo review packet:

1. gọi/use `log-ai-audit`;
2. ghi exact prompt;
3. ghi exact substantive output;
4. ghi path `docs/test-audit/human-review-packet.md`;
5. verify audit entry;
6. không stage audit files.

Nếu audit write thất bại:

```text
WORKFLOW_STATUS:
BLOCKED

BLOCKER:
AUDIT_WRITE_FAILED
```

và STOP.

---

# 14. Student Extension guard

Hiện:

```text
FUTURE_EXTENSION_GAPS:
10
```

Không được hiểu đây là đủ Student Extension.

Requirement sau này là:

```text
>=5 STUDENT_ADDED test cases / API
```

tức:

```text
API-01 >=5
API-02 >=5
API-03 >=5
TOTAL >=15
```

Nhưng **chưa tạo chúng trong phiên này**.

Chỉ giữ requirement này trong workflow state để phase sau không bị quên.

---

# 15. Self-review

Trước khi kết thúc verify:

```text
[ ] Human audit is NOT marked fully approved
[ ] 3/3 INVALID included
[ ] 2/2 semantic duplicates included
[ ] 1/1 traceability issue included

[ ] >=4 INCOMPLETE API-01 included
[ ] >=4 INCOMPLETE API-02 included
[ ] >=4 INCOMPLETE API-03 included

[ ] 2 VALID API-01 included
[ ] 2 VALID API-02 included
[ ] 2 VALID API-03 included

[ ] Relevant raw test content preserved
[ ] AI audit reasoning shown
[ ] Relevant requirement/gap shown
[ ] HUMAN_DECISION remains PENDING

[ ] No classification changed
[ ] No correction applied
[ ] Raw generation unchanged
[ ] Student Extension not started
[ ] Postman not started

[ ] Current interaction audited
[ ] Audit entry verified
[ ] Audit files not staged
[ ] No commit
[ ] No push
```

---

# 16. Output cuối phiên

Trả:

```text
HUMAN_AI_TEST_AUDIT_PACKET: PASS | PARTIAL | FAIL

AUDIT_APPROVAL_STATUS:
TARGETED_HUMAN_REVIEW_REQUIRED

PACKET:
docs/test-audit/human-review-packet.md

TOTAL_CASES_INCLUDED:

INVALID:
INCLUDED: 3/3

SEMANTIC_DUPLICATES:
INCLUDED: 2/2

TRACEABILITY_ISSUES:
INCLUDED: 1/1

INCOMPLETE_SAMPLES:
API_01:
API_02:
API_03:

VALID_SAMPLES:
API_01:
API_02:
API_03:

CLASSIFICATIONS_CHANGED:
NO

CORRECTIONS_APPLIED:
NO

RAW_GENERATED_FILES_MODIFIED:
NO

STUDENT_EXTENSION_STARTED:
NO

POSTMAN_STARTED:
NO

AUDIT_ENTRY:
<id> — AUDIT_ENTRY_VERIFIED

AUDIT_FILES_STAGED:
NO

FILES_COMMITTED:
NONE

BLOCKERS:
<none hoặc list>

NEXT_CHECKPOINT:
TARGETED_AI_TEST_AUDIT_HUMAN_REVIEW_REQUIRED
```

Sau đó STOP.

Không chuyển sang correction hoặc Student Extension cho đến khi student đưa human decision.
