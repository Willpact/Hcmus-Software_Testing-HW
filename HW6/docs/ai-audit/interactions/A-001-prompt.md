Bộ Agent Skills cho HW06 đã được setup và smoke-test thành công.

Trước khi bắt đầu substantive work cho ba API, hãy cập nhật workflow và `log-ai-audit` để áp dụng chính sách AI Audit dưới đây cho toàn bộ HW06.

# 1. Mục tiêu

Từ thời điểm này, AI Audit phải được cập nhật **ngay trong workflow**, không được để đến cuối bài mới reconstruct lại lịch sử.

Mọi prompt/interaction quan trọng có ảnh hưởng đến bài làm phải được audit ngay sau khi interaction hoàn tất.

Prompt hiện tại **cũng là một interaction cần được ghi vào AI Audit**.

---

# 2. Phạm vi interaction phải audit

Tối thiểu phải audit các interaction liên quan đến:

* API selection hoặc thay đổi API selection.
* Requirement analysis.
* Requirement review.
* Test generation.
* Test-case audit.
* Test-case correction.
* Coverage evaluation.
* Student-extension analysis.
* Human review decisions làm thay đổi artifact.
* Postman collection/test generation.
* Test-data design hoặc thay đổi test data.
* Execution planning.
* Newman execution analysis.
* Failure triage.
* Bug classification.
* Bug report generation/review.
* Security analysis.
* State-transition analysis.
* Schema analysis.
* CI/CD design hoặc review.
* AI test-generator design/pseudocode.
* Report generation/review.
* AI critique.
* Submission validation.
* Bất kỳ prompt nào đưa ra quyết định có ảnh hưởng thực tế đến deliverable HW06.

Không cần audit các thao tác cơ học không tạo ra reasoning/substantive output, ví dụ:

* `git status`;
* liệt kê file đơn giản;
* move/copy file không thay đổi nội dung;
* format file thuần túy;
* kiểm tra path;
* các command housekeeping không ảnh hưởng nội dung bài.

Nếu không chắc một interaction có substantive hay không, ưu tiên audit.

---

# 3. Audit phải diễn ra ngay lập tức

Workflow chuẩn cho một substantive AI interaction phải là:

```text
PROMPT
  ↓
AI WORK
  ↓
ARTIFACT / DECISION / ANALYSIS PRODUCED
  ↓
log-ai-audit
  ↓
VERIFY AUDIT ENTRY EXISTS
  ↓
CHECKPOINT / STOP / NEXT ACTION
```

Không được:

```text
PROMPT
→ artifact
→ tiếp tục nhiều phase
→ cuối bài mới quay lại bổ sung audit
```

---

# 4. Human review cũng phải cập nhật audit

Khi student đưa ra một quyết định như:

```text
APPROVED
MODIFIED_AND_APPROVED
REJECTED
CORRECTION_REQUIRED
```

hoặc cung cấp correction ảnh hưởng đến artifact, agent phải:

1. áp dụng decision/correction;
2. cập nhật artifact tương ứng nếu cần;
3. ghi interaction này vào AI Audit ngay;
4. sau đó mới chuyển workflow sang state tiếp theo.

Ví dụ:

```text
TEST_DESIGN_REVIEW_REQUIRED
        ↓
Student modifies TC-017
        ↓
Agent updates TC-017
        ↓
log-ai-audit
        ↓
TEST_DESIGN_APPROVED
```

Không được chuyển `APPROVED` nếu substantive review interaction chưa được audit.

---

# 5. Preserve verbatim audit data

Tiếp tục sử dụng interface hiện tại của `log-ai-audit`.

Audit entry phải giữ chính xác theo capability hiện tại của skill:

* AI tool/model;
* date/time;
* verbatim prompt;
* verbatim AI output;
* relevant phase/artifact metadata;
* human-review information nếu có.

Không summarize prompt/output thay cho verbatim content nếu skill hiện tại yêu cầu verbatim.

Không reconstruct một prompt cũ từ trí nhớ.

Nếu exact prompt/output của một interaction trước đây không còn truy xuất được, ghi rõ limitation thay vì fabricate.

---

# 6. Prompt setup trước đó

Kiểm tra xem prompt đã dùng để tạo bộ HW06 Agent Skills trước interaction hiện tại có được ghi audit chưa.

Nếu:

* exact prompt;
* exact output

vẫn có thể truy xuất chính xác từ session/work log hiện tại, hãy ghi interaction đó vào audit.

Nếu không còn exact content, **không reconstruct hoặc fabricate**.

Ghi limitation nếu cần.

---

# 7. Prompt hiện tại phải được audit

Sau khi hoàn thành các thay đổi policy trong phiên này, gọi `log-ai-audit` để ghi:

* prompt hiện tại;
* output thực tế của interaction;
* các artifact được sửa;
* policy decision được áp dụng.

Không bỏ qua interaction này chỉ vì nó liên quan đến audit infrastructure.

---

# 8. Audit Log commit policy

AI Audit Log phải được cập nhật liên tục trong working tree nhưng là **file cuối cùng được commit cho HW06**.

Áp dụng policy:

```text
AUDIT_LOG_UPDATE:
CONTINUOUS

AUDIT_LOG_STAGE:
FORBIDDEN_BEFORE_FINAL_AUDIT_PHASE

AUDIT_LOG_COMMIT:
FINAL_HW06_COMMIT_ONLY
```

Không tự stage Audit Log trong các commit trung gian.

Không đưa Audit Log vào commit của:

* requirement analysis;
* test generation;
* Postman;
* Newman;
* bug reports;
* CI/CD;
* report;
* Agent Skill deliverables.

Ở final phase, Audit Log sẽ được review toàn bộ trước khi commit riêng.

Suggested final commit:

```text
docs(HW6): finalize AI audit log
```

---

# 9. Guard chống quên Audit

Cập nhật `hw06-api-workflow` để substantive phase không được coi là hoàn thành nếu audit entry bắt buộc chưa được ghi.

Có thể sử dụng state/guard tương đương:

```text
AUDIT_ENTRY_REQUIRED
AUDIT_ENTRY_WRITTEN
AUDIT_ENTRY_VERIFIED
AUDIT_WRITE_FAILED
```

Nếu audit write thất bại:

```text
WORKFLOW_STATUS:
BLOCKED

BLOCKER:
AUDIT_WRITE_FAILED
```

Không tiếp tục sang substantive phase kế tiếp.

---

# 10. Idempotency

Audit integration phải:

* append-only;
* tránh duplicate entry khi workflow resume;
* sử dụng stable interaction identifier nếu hệ thống hiện tại hỗ trợ;
* không overwrite audit history cũ;
* không duplicate cùng prompt/output chỉ vì workflow được rerun.

Nếu entry đã tồn tại, verify và reuse thay vì append duplicate.

---

# 11. Scope của thay đổi hiện tại

Trong phiên này chỉ:

1. inspect `log-ai-audit`;
2. inspect `hw06-api-workflow`;
3. cập nhật audit policy/integration nếu cần;
4. verify policy bằng một safe smoke/static validation;
5. ghi prompt hiện tại vào AI Audit;
6. nếu có thể truy xuất chính xác, bổ sung interaction setup-skill trước đó nếu đang thiếu;
7. dừng.

Không:

* bắt đầu requirement analysis;
* generate test cases;
* tạo Postman assignment collection;
* chạy Newman;
* bắt đầu API-01;
* commit;
* push.

---

# 12. Output cuối phiên

Trả về:

```text
HW06_AUDIT_POLICY_PATCH: PASS | PARTIAL | FAIL

AUDIT_SKILL:
<path>

WORKFLOW_SKILL:
<path>

CURRENT_PROMPT_AUDITED:
YES | NO

PREVIOUS_SKILL_SETUP_PROMPT:
ALREADY_AUDITED | ADDED | EXACT_CONTENT_UNAVAILABLE

AUDIT_TIMING_POLICY:
IMMEDIATE_AFTER_SUBSTANTIVE_INTERACTION

HUMAN_REVIEW_AUDIT:
ENABLED | DISABLED

AUDIT_GUARD:
ENABLED | DISABLED

AUDIT_LOG_COMMIT_POLICY:
FINAL_HW06_COMMIT_ONLY

AUDIT_LOG_CURRENT_GIT_POLICY:
DO_NOT_STAGE

FILES_CREATED:
<list>

FILES_MODIFIED:
<list>

BLOCKERS:
<none hoặc danh sách>

NEXT_CHECKPOINT:
HW06_AUDIT_POLICY_REVIEW_REQUIRED
```

Sau đó STOP.

Không bắt đầu substantive API work cho đến khi tôi approve checkpoint này.
