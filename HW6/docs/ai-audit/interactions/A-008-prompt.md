Phase AI Test Audit + Correction + Student Extension đã hoàn tất ở mức draft.

Trạng thái hiện tại:

```text
HUMAN_REVIEW:
MODIFIED_AND_APPROVED

FINAL_AI_CLASSIFICATION:
VALID: 69
INVALID: 4
INCOMPLETE: 47

CORRECTED_EXECUTABLE_AI_SUITE:
API-01: 25
API-02: 25
API-03: 28

STUDENT_EXTENSION:
API-01: 5
API-02: 5
API-03: 5
TOTAL: 15

FINAL_EXECUTABLE_PREVIEW:
API-01: 30
API-02: 30
API-03: 33

STUDENT_EXTENSION_HUMAN_REVIEW:
PENDING
```

A-007 đã được ghi và verify.

Không thêm filler chỉ để final executable suite đạt 35.

Requirement `>=35/API` đã được đáp ứng ở phase raw AI generation với 40 AI-generated cases/API.

Mục tiêu hiện tại là **review chất lượng của 15 STUDENT_ADDED cases**, không tăng số lượng một cách máy móc.

Sử dụng:

```text
hw06-api-workflow
log-ai-audit
```

---

# 1. Finalize interaction trước

Ghi nhận human decision hiện tại:

```text
STUDENT_DECISION:
STUDENT_EXTENSION_READY_FOR_TARGETED_HUMAN_REVIEW

AI_TEST_AUDIT_AND_CORRECTION:
APPROVED

STUDENT_EXTENSION:
NOT_YET_APPROVED
```

Nếu interaction A-007 đang chờ human review/finalization thì finalize nó theo decision phù hợp trước khi tiếp tục.

Verify audit entry.

Không stage hoặc commit:

```text
docs/ai-audit/
```

---

# 2. Artifacts cần inspect

Đọc toàn bộ:

```text
docs/test-extension/api-01-reset-password-student-extension.md
docs/test-extension/api-02-checkout-student-extension.md
docs/test-extension/api-03-import-products-student-extension.md
docs/test-extension/final-suite-preview.md
```

Structured Student Extension:

```text
test-cases/student-added/
```

Corrected AI suites:

```text
test-cases/corrected/
```

Raw AI-generated suites:

```text
test-cases/generated/
```

Requirement analyses:

```text
docs/requirement-analysis/
```

AI Test Audit artifacts nếu cần traceability:

```text
docs/test-audit/
test-cases/audited/
```

---

# 3. Mục tiêu review

Review **đúng 15 STUDENT_ADDED cases**.

Mỗi case phải được kiểm tra theo 6 tiêu chí:

```text
1. GENUINELY_MISSED_BY_AI
2. SEMANTICALLY_UNIQUE
3. REQUIREMENT_OR_SECURITY_BACKED
4. NO_INVENTED_ORACLE
5. WHY_AI_MISSED_IS_DEFENSIBLE
6. EXECUTION_FEASIBILITY_IDENTIFIED
```

Không auto-approve case chỉ vì schema hợp lệ.

---

# 4. Genuinely missed by AI

Với mỗi Student case:

so sánh với toàn bộ:

```text
40 raw AI-generated cases của cùng API
```

và corrected AI suite.

Phải xác định:

```text
CLOSEST_AI_CASES:
<IDs>

SEMANTIC_DIFFERENCE:
<difference>

GENUINELY_MISSED:
YES | NO | UNCERTAIN
```

Nếu một Student case thực chất đã được AI cover:

```text
GENUINELY_MISSED:
NO
```

và đề xuất:

```text
HUMAN_REVIEW_RECOMMENDATION:
REPLACE_EXTENSION_CASE
```

Không tự generate replacement trong phase này.

---

# 5. Semantic uniqueness

Không coi các variation kiểu:

```text
invalid ở vị trí first
invalid ở vị trí middle
invalid ở vị trí last
```

là ba Student cases riêng nếu objective/oracle/state hoàn toàn giống nhau và chỉ đổi vị trí nhưng không tạo risk khác.

Tuy nhiên chúng có thể distinct nếu vị trí tạo state/persistence risk khác thật sự, ví dụ partial-write/atomic rollback detection.

Phải giải thích semantic distinction.

---

# 6. Oracle validation

Mỗi case phải trace được về:

```text
AUTHORITATIVE_REQUIREMENT
SECURITY_REQUIREMENT
AUTHORITATIVE_STATE_INVARIANT
```

hoặc combination hợp lệ.

Không approve Student case nếu pass/fail phụ thuộc hoàn toàn vào một requirement gap.

Không invent:

### API-01

```text
OTP expiry duration
rate-limit threshold
user-enumeration response equivalence
undocumented confirmation API field
JWT requirement for reset-password
```

### API-02

```text
shipping-address validation
empty-cart policy
coupon integration
idempotency policy
initial order status
```

### API-03

```text
maximum batch size
duplicate policy
category existence behavior
price precision
raw CSV upload behavior
FR-15-only rules as direct FR-16 oracle
```

---

# 7. Why AI missed

Kiểm tra:

```text
why_ai_missed
```

có thực sự mô tả nguyên nhân AI generation bỏ sót hay không.

Không chấp nhận explanation generic kiểu:

```text
AI missed this because it is complex.
```

Ưu tiên category:

```text
PROMPT_LIMITATION
MODEL_ASSUMPTION
SPEC_AMBIGUITY
STATEFUL_REASONING_GAP
SECURITY_REASONING_GAP
CROSS_ENDPOINT_DEPENDENCY
COVERAGE_BLIND_SPOT
COMBINATION_INTERACTION_GAP
```

Mỗi case phải có explanation cụ thể.

---

# 8. API-01 review focus

Review 5 Student cases cho:

```text
POST /api/reset-password
```

Đặc biệt xác minh chúng tạo coverage mới quanh:

```text
email-token binding
cross-user reset
OTP one-time lifecycle
failed-reset state mutation
password-policy combinations
password-storage/security invariant
replay/state sequencing
```

Không approve case chỉ vì nó là variation mới của một OTP/password partition AI đã cover.

---

# 9. API-02 review focus

Review 5 Student cases cho:

```text
POST /api/checkout
```

Đặc biệt xác minh coverage mới quanh:

```text
server-calculated total
client-total manipulation
authenticated-user/cart isolation
cart state after success
security + business-rule interaction
state consistency
```

FR-07/FR-09 vẫn chỉ là supporting context.

Không approve direct coupon/idempotency/empty-cart oracle nếu chưa có authoritative contract.

---

# 10. API-03 review focus

Review 5 Student cases cho:

```text
POST /api/admin/import-products
```

Ưu tiên genuine additions quanh:

```text
admin authorization
mixed-validity batch
atomic rollback
multiple-invalid-row interaction
invalid-position effects
report counts/reasons
name/positive-price direct FR-16 rules
security + atomicity combinations
```

FR-15 vẫn:

```text
SUPPORTING_ONLY
```

CSV-vs-JSON vẫn:

```text
UNRESOLVED_REPRESENTATION_GAP
```

---

# 11. Execution feasibility

Mỗi Student case phải được classify:

```text
POSTMAN_DIRECT
POSTMAN_WITH_PRECONDITION_SETUP
POSTMAN_PLUS_EXTERNAL_VERIFICATION
NOT_CURRENTLY_EXECUTABLE
```

Ví dụ:

* response/body assertion → `POSTMAN_DIRECT`
* cần tạo cart/OTP trước → `POSTMAN_WITH_PRECONDITION_SETUP`
* cần inspect DB persistence → `POSTMAN_PLUS_EXTERNAL_VERIFICATION`
* thiếu authoritative oracle → `NOT_CURRENTLY_EXECUTABLE`

Không sửa case chỉ để ép nó thành Postman-direct.

---

# 12. Human review recommendation

Với mỗi Student case, đưa ra một recommendation:

```text
APPROVE
MODIFY
REPLACE
DEFER
```

Ý nghĩa:

### APPROVE

Case thực sự bị AI bỏ sót, unique, có oracle tốt.

### MODIFY

Concept tốt nhưng cần sửa setup/oracle/why_ai_missed.

### REPLACE

Không thực sự là Student Extension mới hoặc duplicate AI coverage.

### DEFER

Risk hợp lý nhưng chưa có oracle đủ để tính vào final executable suite.

Đây chỉ là:

```text
AI_RECOMMENDATION
```

Không phải Human Decision.

---

# 13. Tạo review artifact

Tạo:

```text
docs/test-extension/student-extension-human-review-packet.md
```

Không sửa semantic content của 15 Student cases ở phase này.

---

# 14. Format mỗi record

Mỗi case:

```text
CASE_ID:
API:
TITLE:

SOURCE:
STUDENT_ADDED

REQUIREMENTS:
...

WHY_AI_MISSED:
...

CLOSEST_AI_CASES:
...

SEMANTIC_DIFFERENCE:
...

GENUINELY_MISSED:
YES | NO | UNCERTAIN

ORACLE_REVIEW:
SUFFICIENT | PARTIAL | INSUFFICIENT

EXECUTION_FEASIBILITY:
POSTMAN_DIRECT |
POSTMAN_WITH_PRECONDITION_SETUP |
POSTMAN_PLUS_EXTERNAL_VERIFICATION |
NOT_CURRENTLY_EXECUTABLE

AI_RECOMMENDATION:
APPROVE | MODIFY | REPLACE | DEFER

AI_REVIEW_REASON:
...

HUMAN_DECISION:
PENDING

HUMAN_COMMENT:
```

---

# 15. Summary

Cuối packet:

```text
API_01:
TOTAL: 5
RECOMMEND_APPROVE:
RECOMMEND_MODIFY:
RECOMMEND_REPLACE:
RECOMMEND_DEFER:

API_02:
...

API_03:
...

TOTAL:
STUDENT_CASES_REVIEWED: 15

GENUINELY_MISSED_YES:
GENUINELY_MISSED_NO:
GENUINELY_MISSED_UNCERTAIN:

EXECUTION_FEASIBILITY:
POSTMAN_DIRECT:
POSTMAN_WITH_PRECONDITION_SETUP:
POSTMAN_PLUS_EXTERNAL_VERIFICATION:
NOT_CURRENTLY_EXECUTABLE:
```

---

# 16. Check >=5/API carefully

Assignment requires:

```text
>=5 STUDENT_ADDED / API
```

However:

do not preserve a weak/duplicate case merely to keep the number 5.

If review finds:

```text
API-02 only has 4 acceptable Student cases
```

report:

```text
API_02_EXTENSION_SHORTFALL:
1 REPLACEMENT_REQUIRED
```

Do not generate filler.

Replacement generation will happen only after human review.

---

# 17. Final executable counts

Current preview:

```text
API-01: 30
API-02: 30
API-03: 33
```

Do not treat these as a blocker solely because they are below 35.

The assignment's AI generation target was already satisfied:

```text
40 AI-generated cases / API
```

Do not add cases merely to force:

```text
FINAL_EXECUTABLE >=35
```

Quality over filler.

---

# 18. No Student Extension modification yet

Do not:

* rewrite Student cases;
* replace Student cases;
* generate additional Student cases;
* change STUDENT_ADDED IDs;
* mark HUMAN_REVIEW_STATUS approved;
* merge suite;
* generate Excel.

Only review.

---

# 19. Git policy

Do not commit Student Extension artifacts yet.

Do not commit review packet yet.

Do not stage:

```text
docs/ai-audit/
```

Do not push.

---

# 20. Continuous AI Audit

This interaction is substantive.

After completing review packet:

1. use `log-ai-audit`;
2. record exact prompt;
3. record exact substantive output;
4. record review packet path;
5. verify audit entry;
6. leave audit files unstaged.

If audit fails:

```text
WORKFLOW_STATUS:
BLOCKED

BLOCKER:
AUDIT_WRITE_FAILED
```

and STOP.

---

# 21. Do not start Postman

Do not:

```text
create Postman collection
create Postman environment
run SUT
run Newman
generate execution evidence
create Excel
create GitHub Issues
start CI/CD
```

Student Extension must be human-approved first.

---

# 22. Self-review

Verify:

```text
[ ] Exactly 15 Student cases reviewed
[ ] Exactly 5 cases per API reviewed

[ ] Every case compared with raw 40-case AI suite
[ ] Closest AI case IDs recorded
[ ] Semantic distinction documented
[ ] Genuinely-missed status assigned

[ ] Requirement/security oracle reviewed
[ ] No requirement-gap oracle invented
[ ] why_ai_missed reviewed
[ ] Execution feasibility classified

[ ] AI recommendation exists for all 15
[ ] HUMAN_DECISION remains PENDING

[ ] Student cases not modified
[ ] No replacement generated
[ ] No filler generated

[ ] Postman not started
[ ] Excel not created

[ ] Current interaction audited
[ ] Audit entry verified
[ ] Audit files not staged

[ ] No commit
[ ] No push
```

---

# 23. Output cuối phiên

Trả:

```text
STUDENT_EXTENSION_TARGETED_REVIEW: PASS | PARTIAL | FAIL

PREVIOUS_INTERACTION:
FINALIZED | FAILED

CASES_REVIEWED:
15

API_01:
TOTAL: 5
RECOMMEND_APPROVE:
RECOMMEND_MODIFY:
RECOMMEND_REPLACE:
RECOMMEND_DEFER:
REPLACEMENT_REQUIRED:

API_02:
TOTAL: 5
RECOMMEND_APPROVE:
RECOMMEND_MODIFY:
RECOMMEND_REPLACE:
RECOMMEND_DEFER:
REPLACEMENT_REQUIRED:

API_03:
TOTAL: 5
RECOMMEND_APPROVE:
RECOMMEND_MODIFY:
RECOMMEND_REPLACE:
RECOMMEND_DEFER:
REPLACEMENT_REQUIRED:

GENUINELY_MISSED:
YES:
NO:
UNCERTAIN:

EXECUTION_FEASIBILITY:
POSTMAN_DIRECT:
POSTMAN_WITH_PRECONDITION_SETUP:
POSTMAN_PLUS_EXTERNAL_VERIFICATION:
NOT_CURRENTLY_EXECUTABLE:

REVIEW_PACKET:
docs/test-extension/student-extension-human-review-packet.md

STUDENT_EXTENSION_FILES_MODIFIED:
NO

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
STUDENT_EXTENSION_HUMAN_DECISION_REQUIRED
```

Sau đó STOP.

Không apply recommendation cho tới khi student đưa Human Decision.

