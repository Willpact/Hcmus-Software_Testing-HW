Phase **AI Test Generation** cho ba API đã hoàn thành và được student review.

Human decision hiện tại:

```text
STUDENT_DECISION:
APPROVED_FOR_AI_TEST_AUDIT

THREE_API_TEST_GENERATION:
PASS

RAW_AI_GENERATION:
PRESERVE_UNCHANGED

NEXT_PHASE:
AI_TEST_AUDIT
```

Kết quả generation đã được xác nhận:

```text
API-01 — POST /api/reset-password
40 generated / 40 unique

API-02 — POST /api/checkout
40 generated / 40 unique

API-03 — POST /api/admin/import-products
40 generated / 40 unique

TOTAL:
120 generated / 120 unique
```

Artifacts hiện tại:

```text
docs/test-generation/api-01-reset-password-ai-generated.md
docs/test-generation/api-02-checkout-ai-generated.md
docs/test-generation/api-03-import-products-ai-generated.md

test-cases/generated/api-01-reset-password.json
test-cases/generated/api-02-checkout.json
test-cases/generated/api-03-import-products.json
```

Requirement-analysis artifacts đã được approved:

```text
docs/requirement-analysis/api-01-reset-password.md
docs/requirement-analysis/api-02-checkout.md
docs/requirement-analysis/api-03-import-products.md
```

Sử dụng:

```text
hw06-api-workflow
log-ai-audit
```

để thực hiện toàn bộ workflow dưới đây.

---

# 1. Finalize Human Review của Test Generation

Trước khi làm AI Test Audit, ghi nhận human decision hiện tại vào continuous AI Audit.

Nếu audit entry của Test Generation hiện tại là `A-004`, hãy cập nhật/finalize nó bằng decision:

```text
APPROVED_FOR_AI_TEST_AUDIT
```

Không hardcode `A-004` nếu skill quản lý ID khác; sử dụng interaction tương ứng thực tế.

Phải:

1. append human decision;
2. verify audit entry;
3. không stage audit files;
4. chỉ tiếp tục nếu audit hoàn tất thành công.

Nếu thất bại:

```text
WORKFLOW_STATUS:
BLOCKED

BLOCKER:
PREVIOUS_HUMAN_REVIEW_AUDIT_FAILED
```

và STOP.

---

# 2. Commit raw AI Test Generation trước khi Audit

Raw AI-generated artifacts phải được giữ thành một Git checkpoint độc lập trước khi bước audit/correction bắt đầu.

Repository chứa nhiều homework trong cùng một Git repository.

Do đó:

* chỉ thao tác trong phạm vi HW6;
* không stage thay đổi từ HW3/HW4/HW5;
* không dùng `git add -A`;
* không dùng một lệnh stage toàn repository;
* không stage `docs/ai-audit/`.

Trước khi commit, dùng equivalent của:

```bash
git status --short -- .
```

và kiểm tra chính xác các files cần commit.

Tạo **ba commit riêng**, mỗi API một commit.

## API-01

Stage đúng:

```text
docs/test-generation/api-01-reset-password-ai-generated.md
test-cases/generated/api-01-reset-password.json
```

Commit message:

```text
test(HW6): generate reset password API test cases
```

## API-02

Stage đúng:

```text
docs/test-generation/api-02-checkout-ai-generated.md
test-cases/generated/api-02-checkout.json
```

Commit message:

```text
test(HW6): generate checkout API test cases
```

## API-03

Stage đúng:

```text
docs/test-generation/api-03-import-products-ai-generated.md
test-cases/generated/api-03-import-products.json
```

Commit message:

```text
test(HW6): generate import products API test cases
```

Trước mỗi commit, verify staged paths bằng equivalent:

```bash
git diff --cached --name-status -- .
```

Audit files phải luôn:

```text
NOT_STAGED
NOT_COMMITTED
```

Không push.

Nếu Git state không an toàn hoặc staged files ngoài intended scope tồn tại, không tự commit bừa.

Ghi:

```text
GENERATION_COMMIT_STATUS:
BLOCKED_NEEDS_HUMAN_REVIEW
```

và tiếp tục AI Test Audit chỉ nếu việc tiếp tục không làm mất raw artifacts.

---

# 3. Mục tiêu AI Test Audit

Audit toàn bộ:

```text
120 AI-generated test cases
```

cho ba API.

Đây là **AI-assisted audit proposal để student human-review**, chưa phải final human audit.

Mỗi raw test case phải được đánh giá độc lập và classify:

```text
VALID
INVALID
INCOMPLETE
```

Không được bỏ qua case.

Không ép tỷ lệ classification.

Nếu AI-generated suite thực sự có nhiều case sai hoặc thiếu thì phải phản ánh đúng.

---

# 4. Raw generation phải immutable về semantic content

Các files dưới đây là raw AI generation:

```text
docs/test-generation/
test-cases/generated/
```

Không sửa semantic content của chúng.

Không:

* sửa expected result;
* sửa test objective;
* thêm requirement mới;
* đổi test technique;
* đổi request;
* xóa case;
* merge case trực tiếp vào raw file;
* chuyển raw case thành student-added case.

Chỉ được đọc để audit.

Nếu phát hiện formatting issue nhưng semantic content vẫn đọc được, ghi issue trong audit thay vì sửa raw artifact.

Raw files phải đóng vai trò:

```text
AI ORIGINAL OUTPUT
```

để giữ traceability:

```text
AI generated
    ↓
AI-assisted audit proposal
    ↓
Human review
    ↓
Final correction
```

---

# 5. Classification Rules

## VALID

Chỉ classify `VALID` nếu case đáp ứng toàn bộ các điều kiện cần thiết:

* mục tiêu test rõ;
* thuộc scope selected API hoặc risk hợp lệ;
* trace đúng authoritative requirement/security rule/gap;
* không dựa vào implementation như oracle;
* không invent business requirement;
* precondition đủ để hiểu;
* request/test data meaningful;
* expected business behavior được source support đủ;
* không semantic duplicate với case khác;
* có khả năng trở thành executable final testcase.

Exact HTTP status hoặc exact response schema có thể chưa được specification định nghĩa.

Một case vẫn có thể VALID nếu:

```text
expected_status:
UNSPECIFIED_BY_AUTHORITATIVE_SOURCE
```

nhưng business/security oracle vẫn đủ rõ để xác định pass/fail.

---

## INVALID

Classify `INVALID` nếu bản chất case không nên tồn tại trong selected API suite.

Ví dụ:

### Generic

* semantic duplicate;
* contradicted by authoritative requirement;
* invented requirement;
* implementation behavior được dùng làm expected result;
* unrelated endpoint/feature;
* meaningless variation của cùng một equivalence partition;
* test objective không thực sự test selected API.

### API-01

Invalid nếu case:

* giả định `POST /api/reset-password` bắt buộc JWT khi authoritative requirements chưa xác nhận;
* tự thêm confirmation field vào API body như một confirmed API contract;
* invent OTP expiry duration;
* invent HTTP/error response contract.

### API-02

Invalid nếu case:

* biến FR-07 thành direct checkout requirement không được FR-08/API contract support;
* biến toàn bộ FR-09 coupon behavior thành direct checkout oracle;
* yêu cầu order-line persistence dù authoritative checkout contract chưa định nghĩa;
* dùng client-supplied total như authoritative checkout total.

### API-03

Invalid nếu case:

* giả định selected endpoint nhận raw CSV/multipart upload;
* biến FR-15 supporting constraints thành hard FR-16 oracle khi FR-16 không trực tiếp support;
* invent batch-size maximum;
* invent duplicate-product rule;
* invent category behavior không được authoritative source support.

---

# 6. INCOMPLETE Rules

Classify `INCOMPLETE` khi **concept/risk của case hợp lý**, nhưng case hiện tại chưa đủ để trở thành final executable pass/fail testcase.

Ví dụ thiếu:

* authoritative oracle;
* precondition;
* state setup;
* expected state;
* exact dependency;
* observable validation point;
* traceability;
* expected business result;
* requirement clarification.

Ví dụ:

```text
Checkout with empty cart
```

Nếu requirement không định nghĩa empty-cart behavior:

```text
INCOMPLETE
```

thường phù hợp hơn `INVALID`.

Tương tự:

```text
Reset OTP after unspecified expiry duration
```

Nếu risk expiry là requirement thật nhưng duration không được định nghĩa:

```text
INCOMPLETE
```

và correction không được tự invent duration.

---

# 7. Oracle review

Generation phase đã báo:

```text
53 unresolved-oracle cases
```

gồm:

```text
35 OBSERVABLE_ONLY
18 PARTIALLY_SPECIFIED
```

Audit phải review kỹ toàn bộ nhóm này.

Không mặc định:

```text
OBSERVABLE_ONLY = INCOMPLETE
```

và cũng không mặc định:

```text
PARTIALLY_SPECIFIED = VALID
```

Phải đánh giá semantic content từng case.

Một security test có thể:

```text
SECURITY_EXPECTATION
```

và vẫn VALID nếu authoritative security rule đủ để xác định hành vi phải được bảo vệ, dù exact status không xác định.

---

# 8. Semantic Duplicate Review

Generation phase báo:

```text
SEMANTIC_DUPLICATES_REMOVED:
0
```

Audit phải kiểm tra độc lập lại claim này.

Đặc biệt xem các nhóm:

```text
missing token
malformed token
invalid token
expired token
```

hoặc các boundary/partition gần nhau có thật sự:

* khác equivalence class;
* khác threat/risk;
* khác expected business result;

hay chỉ là trivial variations.

Nếu semantic duplicate:

```text
classification:
INVALID

reason:
SEMANTIC_DUPLICATE

duplicate_of:
<stable TC ID>
```

Không xóa raw case.

---

# 9. Requirement Traceability Review

Với từng case kiểm tra:

```text
requirement_ids
gap/risk reference
technique
oracle_basis
```

Không coi:

```text
IMPLEMENTATION_ONLY_OBSERVATION
```

là authoritative requirement.

Implementation discrepancy có thể được dùng để **prioritize verification**, nhưng expected behavior phải trace ngược về authoritative requirement.

Nếu case chỉ tồn tại vì implementation code có behavior nào đó:

```text
INVALID
```

hoặc:

```text
INCOMPLETE
```

tùy bản chất.

---

# 10. API-01 — Reset Password Audit Focus

Audit đặc biệt kỹ các vấn đề:

```text
email/token binding
OTP lifecycle
OTP invalidation after use
OTP expiry
password complexity
password confirmation ambiguity
password storage
reset authorization
replay
rate limiting
user enumeration
```

Guard:

### OTP expiry

Requirement nói expiry phải tồn tại nhưng duration chưa được định nghĩa.

Không chấp nhận case invent:

```text
5 minutes
10 minutes
15 minutes
30 minutes
```

nếu authoritative source không quy định.

### Confirmation

FR-level requirement có confirmation nhưng selected API contract không document field này.

Case giả định confirmation API field đã được confirm phải bị audit.

### JWT

Không assume selected reset endpoint cần JWT.

---

# 11. API-02 — Checkout Audit Focus

Audit đặc biệt:

```text
JWT
server-side total
cart-derived total
client total manipulation
cart clearing
user/cart isolation
shipping address
empty cart
replay/repeated checkout
order state
coupon interaction
```

### Server-side total

Các case phải giữ authoritative rule:

```text
backend recalculates total from cart
client total is not authoritative
```

Nếu case mong backend chấp nhận client-supplied total:

```text
INVALID
```

### FR-07

Chỉ supporting/precondition context.

### FR-09

Chỉ supporting/cross-feature context.

Không coi coupon flow như direct checkout behavior nếu integration chưa documented.

### Empty cart / replay / shipping-address limits

Nếu source không định nghĩa expected behavior:

thường là:

```text
INCOMPLETE
```

hoặc observational security/robustness case.

Không invent result.

---

# 12. API-03 — Import Products Audit Focus

Audit đặc biệt:

```text
JWT
admin role
products array
name
price
batch composition
atomic rollback
success/error reporting
mixed-validity batches
CSV-vs-JSON gap
FR-15 supporting constraints
```

### Representation

Selected endpoint suite dùng:

```json
{
  "products": [...]
}
```

Raw CSV/multipart test không được coi là valid selected endpoint test trừ khi authoritative endpoint source xác nhận.

### FR-15

Chỉ supporting context.

Không hardcode:

```text
name max 255
category existing
```

thành FR-16 oracle nếu source applicability chưa được xác nhận.

### Atomicity

FR-16 all-or-nothing là direct requirement.

Mixed-validity batch tests rất quan trọng.

Không classify chúng invalid chỉ vì implementation hiện tại có thể không hỗ trợ rollback.

### Response report

Counts/reasons là requirement.

Exact JSON property names không được invent.

---

# 13. Proposed correction

Với:

```text
INVALID
INCOMPLETE
```

phải đưa ra:

```text
proposed_correction
```

nhưng correction chỉ là **proposal**.

Không áp dụng vào raw generation.

Correction phải cố giữ stable test-case ID nếu concept còn salvageable.

Ví dụ:

```text
API02-TC-027

CLASSIFICATION:
INCOMPLETE

REASON:
Shipping address maximum length is not defined.

PROPOSED_CORRECTION:
Change the oracle from "must reject >255 chars"
to an observable robustness case with
UNSPECIFIED_BY_AUTHORITATIVE_SOURCE,
or defer until human decides whether the case
belongs in the final suite.
```

Nếu case không salvageable:

```text
PROPOSED_ACTION:
REMOVE_FROM_FINAL_SUITE
```

nhưng raw case vẫn được giữ.

---

# 14. Audit artifact structure

Tạo:

```text
docs/test-audit/
├── api-01-reset-password-audit.md
├── api-02-checkout-audit.md
└── api-03-import-products-audit.md
```

Và structured representation nếu workflow hỗ trợ:

```text
test-cases/audited/
├── api-01-reset-password.json
├── api-02-checkout.json
└── api-03-import-products.json
```

Structured audited artifact phải reference raw case bằng stable ID.

Không overwrite:

```text
test-cases/generated/
```

---

# 15. Mỗi audit record

Tối thiểu:

```yaml
test_case_id:
raw_source:
classification:
classification_reason:
requirement_traceability:
oracle_review:
duplicate_of:
issues:
proposed_correction:
proposed_action:
human_review_status:
```

Trong phase hiện tại:

```text
human_review_status:
PENDING_HUMAN_REVIEW
```

Không ghi:

```text
HUMAN_APPROVED
```

trước khi student thực sự review.

---

# 16. Audit summary per API

Cuối mỗi artifact có:

```text
TOTAL
VALID
INVALID
INCOMPLETE

PROPOSED_CORRECTIONS
PROPOSED_REMOVALS

SEMANTIC_DUPLICATES

AUTHORITATIVE_ORACLE_ISSUES
TRACEABILITY_ISSUES
STATE_SETUP_ISSUES
SECURITY_REASONING_ISSUES
CROSS_FEATURE_OVERREACH
IMPLEMENTATION_AS_ORACLE
```

Không target tỷ lệ cụ thể.

---

# 17. Cross-API AI Failure Pattern Analysis

Sau khi audit đủ 120 cases, phân tích các pattern AI làm chưa tốt.

Ví dụ chỉ ghi nếu thật sự xuất hiện:

```text
UNSUPPORTED_RESPONSE_ORACLE
REQUIREMENT_GAP_ASSUMPTION
CROSS_FEATURE_OVERREACH
IMPLEMENTATION_AS_ORACLE
SEMANTIC_DUPLICATION
MISSING_STATE_SETUP
SECURITY_REASONING_GAP
AMBIGUOUS_EXPECTED_RESULT
```

Cho mỗi pattern:

```text
count
affected APIs
representative TC IDs
why it happened
```

Phần này sau này sẽ hỗ trợ:

```text
Student Extension
AI Critique
Main Report
```

Nhưng chưa viết AI Critique trong phase này.

---

# 18. Candidate gaps cho Student Extension

Không tạo student-added tests.

Tuy nhiên audit có thể ghi lại các **coverage gaps mà 120 AI-generated cases vẫn chưa cover tốt**.

Đánh dấu:

```text
FUTURE_EXTENSION_GAP
```

Chưa:

```text
STUDENT_ADDED
```

Chưa generate final testcase.

Chưa viết `why_ai_missed` ở dạng final student artifact.

Phase Student Extension sẽ làm sau khi human approve audit.

---

# 19. Không correction final suite trong phase này

Không:

* sửa raw AI test cases;
* tạo final corrected test suite;
* promote corrected case thành final;
* remove raw cases;
* add student tests;
* tạo Excel;
* tạo Postman;
* chạy Newman;
* sửa production code;
* tạo bug report;
* tạo GitHub Issue;
* bắt đầu CI/CD.

Phase này chỉ:

```text
READ RAW TESTS
        ↓
AUDIT
        ↓
PROPOSE CLASSIFICATION
        ↓
PROPOSE CORRECTION
        ↓
HUMAN REVIEW
```

---

# 20. Continuous AI Audit

Interaction hiện tại là substantive HW06 work.

Sau khi hoàn tất AI Test Audit:

1. gọi `log-ai-audit`;
2. ghi exact prompt hiện tại;
3. ghi exact substantive output;
4. ghi artifact paths;
5. verify entry;
6. không stage audit files.

Nếu audit entry không được verify:

```text
WORKFLOW_STATUS:
BLOCKED

BLOCKER:
AUDIT_WRITE_FAILED
```

và STOP.

Audit Log vẫn phải:

```text
CONTINUOUSLY_UPDATED
NOT_STAGED
NOT_COMMITTED
```

cho tới final HW06 audit commit.

---

# 21. Git policy sau AI Test Audit

Không commit audit artifacts trong phiên này.

Reason:

Student phải human-review proposed classifications trước.

Chỉ sau:

```text
THREE_API_AI_TEST_AUDIT_REVIEW
```

được student approve/modify thì mới commit audit artifacts.

Do đó cuối phase:

```text
AUDIT_ARTIFACTS_COMMITTED:
NO
```

---

# 22. Self-review

Trước khi trả kết quả, verify:

```text
[ ] Previous Test Generation human review recorded
[ ] Raw generation committed separately if Git state allowed
[ ] Audit files excluded from generation commits

[ ] Exactly 40 API-01 cases audited
[ ] Exactly 40 API-02 cases audited
[ ] Exactly 40 API-03 cases audited
[ ] Total exactly 120 cases audited

[ ] Every case classified
[ ] VALID / INVALID / INCOMPLETE reasoning exists
[ ] Invalid/incomplete cases have proposed correction/action
[ ] No ratio was artificially targeted

[ ] Semantic duplicates independently reviewed
[ ] Requirement traceability reviewed
[ ] Oracle basis reviewed

[ ] FR-07/FR-09 remain supporting for API-02
[ ] FR-15 remains supporting for API-03
[ ] CSV-vs-JSON remains unresolved
[ ] Implementation behavior not promoted to oracle

[ ] Raw generated files semantically unchanged
[ ] No STUDENT_ADDED cases created
[ ] No final corrected suite created
[ ] No Excel created
[ ] No Postman started
[ ] No Newman started

[ ] Current interaction recorded by log-ai-audit
[ ] Audit entry verified
[ ] Audit files not staged
```

---

# 23. Output cuối phiên

Trả summary:

```text
THREE_API_AI_TEST_AUDIT: PASS | PARTIAL | FAIL

PREVIOUS_GENERATION_REVIEW:
FINALIZED | FAILED

GENERATION_COMMITS:

API_01_GENERATION_COMMIT:
<hash | BLOCKED>

API_02_GENERATION_COMMIT:
<hash | BLOCKED>

API_03_GENERATION_COMMIT:
<hash | BLOCKED>

AUDIT_FILES_INCLUDED_IN_GENERATION_COMMITS:
NO

API_01:
TOTAL: 40
VALID:
INVALID:
INCOMPLETE:
PROPOSED_CORRECTIONS:
PROPOSED_REMOVALS:
SEMANTIC_DUPLICATES:
TRACEABILITY_ISSUES:
ORACLE_ISSUES:
STATUS: AI_TEST_AUDIT_REVIEW_REQUIRED

API_02:
TOTAL: 40
VALID:
INVALID:
INCOMPLETE:
PROPOSED_CORRECTIONS:
PROPOSED_REMOVALS:
SEMANTIC_DUPLICATES:
TRACEABILITY_ISSUES:
ORACLE_ISSUES:
STATUS: AI_TEST_AUDIT_REVIEW_REQUIRED

API_03:
TOTAL: 40
VALID:
INVALID:
INCOMPLETE:
PROPOSED_CORRECTIONS:
PROPOSED_REMOVALS:
SEMANTIC_DUPLICATES:
TRACEABILITY_ISSUES:
ORACLE_ISSUES:
STATUS: AI_TEST_AUDIT_REVIEW_REQUIRED

TOTAL:
AUDITED: 120
VALID:
INVALID:
INCOMPLETE:

TOP_AI_FAILURE_PATTERNS:
1. <pattern> — <count>
2. ...
3. ...

FUTURE_EXTENSION_GAPS:
<count + short summary>

RAW_GENERATED_FILES_MODIFIED:
NO

AUDIT_ARTIFACTS:
<paths>

STRUCTURED_AUDIT_ARTIFACTS:
<paths or none>

FINAL_CORRECTION_STARTED:
NO

STUDENT_EXTENSION_STARTED:
NO

POSTMAN_STARTED:
NO

AUDIT_ENTRY:
<id> — AUDIT_ENTRY_VERIFIED

AUDIT_FILES_STAGED:
NO

AUDIT_ARTIFACTS_COMMITTED:
NO

BLOCKERS:
<none hoặc list>

NEXT_CHECKPOINT:
THREE_API_AI_TEST_AUDIT_REVIEW_REQUIRED
```

Sau đó **STOP**.

Không tự động áp dụng correction.

Không tự động thêm Student Extension cases.

Không tạo Postman.

Không commit AI Test Audit artifacts trước khi student human-review kết quả.
