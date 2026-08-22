# AI Audit Report

> Mandatory appendix for AI-assisted coursework. This log was provisionally initialized under an explicit immediate-audit request; it is not submission-ready until Student Information is provided and final review is complete.

---

## 1. Student Information

| Field | Value |
| --- | --- |
| Student name (printed) | |
| Student ID | |
| Class / Cohort | |
| Assignment ID | HW06 — API Testing |
| Assignment date | |
| AI tool(s) used | Codex |
| AI assistance declared | |

> Pending Student Information is intentionally left blank rather than fabricated.

---

## 2. Instructions

- Preserve verbatim prompt and AI output for each included substantive interaction.
- Do not reconstruct missing prompt, output, timestamp, Human Decision, or execution evidence.
- Keep this log append-only. Do not stage it before the final HW06 audit phase.

---

## 3. Audit Entries — Five Sections per Artifact

<!-- AUDIT_ENTRIES_START -->

### Artifact A-001 — HW06 audit policy integration

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-18 19:46:45 |
| Workflow Stage | HW06 audit-policy setup |
| Feature / Task | Continuous AI Audit policy and workflow guard |
| Related Artifact | `.agents/log-ai-audit/SKILL.md`; `.agents/hw06-api-workflow/SKILL.md`; `.agents/hw06-api-workflow/scripts/smoke-test.ps1` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-001-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-001-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | Continuous-audit policy and guard integration |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Current user prompt, sections 1–10 |
| Technical Documentation | `.agents/log-ai-audit/SKILL.md` and `.agents/hw06-api-workflow/SKILL.md` |
| Execution Evidence | Static validation and synthetic TEST-ONLY smoke test in this interaction |

**Review Notes**

* The policy update added immediate audit verification before every substantive phase transition and preserved verbatim prompt/output through external files.
* Student explicitly approved the policy patch; no correction to the policy artifact was requested.
* Student also confirmed that API selection remains unchanged and that no separate `docs/api-selection.md` artifact is required.
* `VALID` applies to the original policy-patch output within the stated Verdict Scope; no execution evidence is claimed.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `ACCEPTED_AS_IS` |
| Change Illustration | No change required. |
| Verification Method | `STATIC_REVIEW` |
| Verification Result | `PASSED` |
| Final File | `.agents/log-ai-audit/SKILL.md`; `.agents/hw06-api-workflow/SKILL.md` |
| Approval Status | `APPROVED` |

**Changes Made**

* Không cần sửa policy patch đã tạo ở interaction A-001.

**Correction Notes**

Student xác nhận policy được dùng tiếp cho HW06; API selection giữ nguyên và không tạo artifact selection riêng.

**Human Decision Evidence**

`HW06_AUDIT_POLICY_PATCH: APPROVED`

### Artifact A-002 — Three-API requirement analysis

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-18 20:10:20 |
| Workflow Stage | Requirement analysis for API-01, API-02, and API-03 |
| Feature / Task | FR-03 Password Reset; FR-08 Checkout; FR-16 Import Products |
| Related Artifact | `docs/requirement-analysis/api-01-reset-password.md`; `docs/requirement-analysis/api-02-checkout.md`; `docs/requirement-analysis/api-03-import-products.md` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-002-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-002-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `INCOMPLETE` |
| Verdict Scope | Requirement analysis artifacts and analysis-only checkpoint |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | `eshop-sut/README.md` FR-01/03/07/08/09/15/16 and SEC-01…SEC-07; `eshop-sut/api_specification.md` §§1/4/6 |
| Technical Documentation | `eshop-sut/backend/server.js`; `eshop-sut/backend/database.js` |
| Execution Evidence | No runtime execution; static source inspection and artifact-structure validation only |

**Review Notes**

* AI output ban đầu đã tách requirement khỏi implementation và không tạo test case, defect hoặc execution evidence.
* Human Review phát hiện API-02 đã nâng FR-07/FR-09 thành direct checkout oracle quá mức cần thiết và API-03 đã nâng FR-15 thành direct import requirement.
* Human Review yêu cầu thu hẹp API02-ID-003 về việc checkout không đọc cart, bỏ order-line persistence khỏi discrepancy oracle, và thu hẹp API03-ID-002 về name/positive-price được FR-16 hỗ trợ.
* Ba artifact đã được sửa theo decision, giữ CSV-vs-JSON là unresolved representation gap, tách rõ potential discrepancies khỏi implementation-only observations, và không bịa status/response schema.
* Vì original AI output cần các correction này, verdict giữ `INCOMPLETE`; các file sau sửa đã pass static review và được student approve.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `MODIFIED` |
| Change Illustration | See **Changes Made** below. |
| Verification Method | `STATIC_REVIEW` |
| Verification Result | `PASSED` |
| Final File | `docs/requirement-analysis/api-01-reset-password.md`; `docs/requirement-analysis/api-02-checkout.md`; `docs/requirement-analysis/api-03-import-products.md` |
| Approval Status | `APPROVED` |

**Changes Made**

* Tách các bảng `POTENTIAL_DISCREPANCY` và `IMPLEMENTATION_ONLY_OBSERVATION`; xác nhận count API-01 là 3+1, API-02 là 3+1, API-03 là 3+2.
* Chuyển FR-07/FR-09 của API-02 sang `SUPPORTING`, sửa API02-ID-003 chỉ còn absence of cart reading, và không dùng order-line persistence làm discrepancy.
* Chuyển FR-15/API03-REQ-008 sang `SUPPORTING`, sửa API03-ID-002 chỉ theo FR-16 name/positive-price, và giữ raw CSV ngoài endpoint contract khi chưa có source.
* Giữ requirement gaps không có invented expected status code/response schema và không promote implementation behavior.

**Correction Notes**

Original output cần Human-directed correction nên verdict là `INCOMPLETE`. Các artifact sau sửa đã được static-verify và được student chấp thuận để chuyển sang `REQUIREMENT_ANALYSIS_APPROVED`.

**Human Decision Evidence**

`STUDENT\_DECISION: MODIFIED\_AND\_APPROVED`

Full verbatim decision: `docs/ai-audit/interactions/A-003-prompt.md`.

### Artifact A-003 — Human-reviewed requirement-analysis corrections

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-20 23:24:36 |
| Workflow Stage | Requirement-analysis Human Review and correction |
| Feature / Task | FR-03 Password Reset; FR-08 Checkout; FR-16 Import Products |
| Related Artifact | `docs/requirement-analysis/api-01-reset-password.md`; `docs/requirement-analysis/api-02-checkout.md`; `docs/requirement-analysis/api-03-import-products.md` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-003-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-003-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | Human-directed corrections and approval-state transition |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Verbatim student decision in `docs/ai-audit/interactions/A-003-prompt.md` |
| Technical Documentation | Three requirement-analysis artifacts and original SUT sources cited within them |
| Execution Evidence | Static content/count validation only; no SUT execution |

**Review Notes**

* Human Review xác nhận `REQUIREMENT_ANALYSIS_REVIEW: PASS` cho kết quả sửa requirement analysis trong phạm vi A-003.
* Corrections đã được áp dụng và static-verify: API-01 giữ 3 potential discrepancies + 1 implementation observation; API-02 giữ FR-07/FR-09 ở SUPPORTING và không dùng order-line persistence làm requirement oracle; API-03 giữ FR-15 ở SUPPORTING, dùng JSON products contract và giữ CSV-vs-JSON là unresolved representation gap.
* Cả ba artifact đều ở trạng thái `REQUIREMENT_ANALYSIS_APPROVED`; A-003 không sinh test case và không chạy SUT.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `ACCEPTED_AS_IS` |
| Change Illustration | No further change required after the Human-directed corrections recorded by A-003. |
| Verification Method | `STATIC_REVIEW` |
| Verification Result | `PASSED` |
| Final File | `docs/requirement-analysis/api-01-reset-password.md`; `docs/requirement-analysis/api-02-checkout.md`; `docs/requirement-analysis/api-03-import-products.md` |
| Approval Status | `APPROVED` |

**Changes Made**

No further correction was required at this review checkpoint. The three approved requirement-analysis files are authorized as input for the next workflow phase.

**Correction Notes**

No correction is needed within the A-003 verdict scope after the previously requested edits were applied and verified.

**Human Decision Evidence**

`REQUIREMENT_ANALYSIS_REVIEW: PASS`

### Artifact A-004 — Three-API raw AI test generation

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-21 00:03:04 |
| Workflow Stage | AI Test Generation only |
| Feature / Task | FR-03 Password Reset; FR-08 Checkout; FR-16 Import Products |
| Related Artifact | `docs/test-generation/api-01-reset-password-ai-generated.md`; `docs/test-generation/api-02-checkout-ai-generated.md`; `docs/test-generation/api-03-import-products-ai-generated.md`; `test-cases/generated/api-01-reset-password.json`; `test-cases/generated/api-02-checkout.json`; `test-cases/generated/api-03-import-products.json` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-004-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-004-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | Raw AI-generated test candidates after format normalization and semantic deduplication |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact generation instructions in `docs/ai-audit/interactions/A-004-prompt.md` |
| Technical Documentation | Three approved requirement-analysis artifacts and canonical schema |
| Execution Evidence | Static JSON-schema, traceability, count, uniqueness, and Markdown/JSON consistency checks only; no SUT/Postman/Newman execution |

**Review Notes**

* AI đã sinh đúng 40 raw `AI_GENERATED` candidates cho mỗi API, 120 case tổng cộng, với `NOT_AUDITED` và `NOT_IMPLEMENTED`.
* Static checks đã xác minh count range, sáu primary techniques mỗi API, schema validity, stable unique IDs, traceability coverage và Markdown/JSON consistency.
* Human Review xác nhận `THREE_API_TEST_GENERATION: PASS` và yêu cầu giữ raw generation bất biến để chuyển sang AI Test Audit.
* Human approval này chỉ chấp thuận bộ raw candidates làm input audit; không phải verdict `VALID` cho từng test case và không phải execution evidence.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `ACCEPTED_AS_IS` |
| Change Illustration | No change required. |
| Verification Method | `STATIC_REVIEW` |
| Verification Result | `PASSED` |
| Final File | `docs/test-generation/api-01-reset-password-ai-generated.md`; `docs/test-generation/api-02-checkout-ai-generated.md`; `docs/test-generation/api-03-import-products-ai-generated.md`; `test-cases/generated/api-01-reset-password.json`; `test-cases/generated/api-02-checkout.json`; `test-cases/generated/api-03-import-products.json` |
| Approval Status | `APPROVED` |

**Changes Made**

Raw AI generation được giữ nguyên theo Human Decision và được phép dùng làm input cho phase AI Test Audit.

**Correction Notes**

Không cần correction trong Verdict Scope của A-004. Approval không thay thế việc audit độc lập từng case.

**Human Decision Evidence**

`STUDENT_DECISION: APPROVED_FOR_AI_TEST_AUDIT`

`THREE_API_TEST_GENERATION: PASS`

`RAW_AI_GENERATION: PRESERVE_UNCHANGED`

`NEXT_PHASE: AI_TEST_AUDIT`

### Artifact A-005 — Three-API AI-assisted test-case audit proposal

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-21 01:09:40 |
| Workflow Stage | AI Test Audit proposal only |
| Feature / Task | Audit 120 raw cases for FR-03 Password Reset; FR-08 Checkout; FR-16 Import Products |
| Related Artifact | `docs/test-audit/api-01-reset-password-audit.md`; `docs/test-audit/api-02-checkout-audit.md`; `docs/test-audit/api-03-import-products-audit.md`; `docs/test-audit/cross-api-failure-patterns.md`; `test-cases/audited/api-01-reset-password.json`; `test-cases/audited/api-02-checkout.json`; `test-cases/audited/api-03-import-products.json`; `test-cases/audited/cross-api-summary.json` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-005-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-005-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `INCOMPLETE` |
| Verdict Scope | AI-assisted per-case classification and proposed corrections; raw generation remains unchanged |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact audit instructions in `docs/ai-audit/interactions/A-005-prompt.md`; three approved requirement-analysis artifacts |
| Technical Documentation | 120 raw generated records, canonical schema, and raw generation Git checkpoints |
| Execution Evidence | Static per-ID audit, traceability/oracle/duplicate review, JSON/Markdown consistency, and raw-file Git comparison only; no SUT/Postman/Newman execution |

**Review Notes**

* Original AI audit đã bao phủ đủ 120/120 stable IDs, phát hiện hai semantic duplicates và giữ implementation behavior ngoài authoritative oracle.
* Human Review chấp thuận audit method nhưng sửa `API01-AI-040` từ `INCOMPLETE` thành `INVALID` vì precondition issuer phát hành OTP bảy chữ số không được FR-03 thiết lập.
* Human Review giữ `API02-AI-038` là `INCOMPLETE` và defer do thiếu coupon/checkout integration contract; giữ `API03-AI-035` `VALID` nhưng sửa primary trace sang `API03-REQ-004`; giữ `API01-AI-035` `VALID` và thêm external persistence verification metadata.
* Final classification sau Human Review là `69 VALID`, `4 INVALID`, `47 INCOMPLETE`; targeted sample decisions được ghi riêng và 95 case còn lại giữ nguyên AI reasoning/classification dưới aggregate-method approval, không bị mô tả sai là individually rewritten.
* Vì original proposal cần các Human-directed modifications trên, verdict của A-005 là `INCOMPLETE` dù artifacts sau sửa đã static-verify và được approve downstream.
* Raw generation không đổi; không có SUT/Postman/Newman execution evidence.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `MODIFIED` |
| Change Illustration | See **Changes Made** below. |
| Verification Method | `STATIC_REVIEW` |
| Verification Result | `PASSED` |
| Final File | `docs/test-audit/api-01-reset-password-audit.md`; `docs/test-audit/api-02-checkout-audit.md`; `docs/test-audit/api-03-import-products-audit.md`; `docs/test-audit/cross-api-failure-patterns.md`; `test-cases/audited/api-01-reset-password.json`; `test-cases/audited/api-02-checkout.json`; `test-cases/audited/api-03-import-products.json`; `test-cases/audited/cross-api-summary.json`; `docs/test-audit/human-review-packet.md` |
| Approval Status | `APPROVED` |

**Changes Made**

* Đổi `API01-AI-040` thành `INVALID` / `REMOVED_FROM_FINAL_EXECUTABLE_SUITE` với category `UNSUPPORTED_PRECONDITION`.
* Defer `API02-AI-038` thành `DEFERRED_REQUIREMENT_GAP` cho future scope `CROSS_FEATURE_COUPON_CHECKOUT_INTEGRATION`.
* Sửa traceability `API03-AI-035`: `API03-REQ-004` primary, `API03-RG-001` related gap, `API03-REQ-006` supporting context.
* Thêm automation note cho `API01-AI-035` yêu cầu database/external persistence verification trong isolated test environment.
* Ghi decisions cho 25 targeted cases; giữ nguyên reasoning/classification của các case ngoài sample và gắn aggregate-method status rõ ràng.

**Correction Notes**

Original audit proposal cần Human-directed correction nên verdict A-005 giữ `INCOMPLETE`. Artifacts sau sửa đã được static-verify với final count `69/4/47` và được Human approve để tạo corrected suite.

**Human Decision Evidence**

`STUDENT_DECISION: MODIFIED_AND_APPROVED`

`AI_TEST_AUDIT_METHOD: APPROVED`

`TARGETED_REVIEW: COMPLETED`

`API01-AI-040: CHANGE_TO_INVALID`

`API02-AI-038: DEFER_AS_REQUIREMENT_GAP`

`API03-AI-035: MODIFY_CORRECTION`

`API01-AI-035: MODIFY_CORRECTION`

### Artifact A-006 — Targeted Human Review Packet for AI Test Audit

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-21 01:19:17 |
| Workflow Stage | Targeted Human Review preparation only |
| Feature / Task | Selected review packet for the three-API AI Test Audit proposal |
| Related Artifact | `docs/test-audit/human-review-packet.md` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-006-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-006-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | Selection and presentation of targeted cases; no classification or correction change |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact targeted-review instructions in `docs/ai-audit/interactions/A-006-prompt.md` |
| Technical Documentation | Raw generated JSON, structured audited JSON, test-audit reports, and approved requirement analyses |
| Execution Evidence | Static extraction, ID/category coverage, content/hash, and Git-state checks only; no SUT/Postman/Newman execution |

**Review Notes**

* Packet chứa 25 case duy nhất: đủ 3/3 `INVALID`, 2/2 semantic duplicates, 1/1 traceability issue, 16 representative `INCOMPLETE` (5/6/5) và 6 representative `VALID` (2/API).
* Mỗi record giữ raw title/objective/request/test-data/oracle/state, hiển thị audit proposal và source-backed requirement/gap, đồng thời để Human điền decision/comment.
* Human xác nhận `AI_TEST_AUDIT_METHOD: APPROVED` và `TARGETED_REVIEW: COMPLETED`; packet đã phục vụ đúng mục tiêu review chọn mẫu.
* Các override case-level trong Human Decision mới thuộc bước áp dụng audit/correction tiếp theo; chúng không làm packet A-006 sai hoặc cần rewrite.
* Không có SUT/Postman/Newman execution evidence trong A-006.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `ACCEPTED_AS_IS` |
| Change Illustration | No change required. |
| Verification Method | `REVIEW` |
| Verification Result | `PASSED` |
| Final File | `docs/test-audit/human-review-packet.md` |
| Approval Status | `APPROVED` |

**Changes Made**

Không thay đổi packet. Human đã hoàn tất targeted review và cung cấp các case-level decisions cho bước áp dụng tiếp theo.

**Correction Notes**

Không cần correction trong Verdict Scope của A-006; override classification/correction được áp dụng vào audit artifacts riêng, không rewrite packet gốc.

**Human Decision Evidence**

`STUDENT_DECISION: MODIFIED_AND_APPROVED`

`AI_TEST_AUDIT_METHOD: APPROVED`

`TARGETED_REVIEW: COMPLETED`

### Artifact A-007 — AI Test Audit Finalization, Correction, and Student Extension

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-21 02:40:37 |
| Workflow Stage | AI Test Audit finalization, corrected-suite generation, and Student Extension preparation |
| Feature / Task | Apply targeted Human Review, commit corrected AI suites per API, and prepare uncommitted Student-added cases |
| Related Artifact | `docs/test-audit/`; `docs/test-correction/`; `test-cases/audited/`; `test-cases/corrected/`; `docs/test-extension/`; `test-cases/student-added/` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-007-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-007-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | Final audit/correction application and preparation of three-API Student Extension candidates for targeted Human Review; not approval of the candidates' substantive quality |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact finalization and extension instructions in `docs/ai-audit/interactions/A-007-prompt.md`; finalized A-005 and A-006 Human Review evidence |
| Technical Documentation | Approved requirement analyses, canonical test-case schema, raw/audited/corrected JSON, audit/correction reports, targeted-review packet, and Student Extension artifacts |
| Execution Evidence | Static schema, ID, count, traceability, duplicate, raw-immutability, commit-scope, staging-state, and Git-history checks only; no SUT/Postman/Newman/Excel execution |

**Review Notes**

* Applied all four explicit Human overrides and finalized the audited classification at `69 VALID`, `4 INVALID`, and `47 INCOMPLETE`.
* Corrected executable AI suites contain `25/25/28` cases for API-01/API-02/API-03; salvaged only source-supported incomplete cases and deferred the remaining requirement gaps without inventing status codes, schemas, or business rules.
* Created one scoped commit per API: `1a5ba3a920c6fb98f2ab82d0dbd0d20ad83b66f9`, `636fa1cb871c9bf0e09737c357e4a30189a4f1f3`, and `af669dbe57592c1dc94e840dca18551d218b9190`; no `docs/ai-audit/` file was staged or committed.
* Đã chuẩn bị năm `STUDENT_ADDED` cases/API, kèm closest raw-AI comparison và why-AI-missed rationale; cả 15 case vẫn `PENDING_HUMAN_REVIEW`, uncommitted và unstaged.
* Human xác nhận phần AI Test Audit và Correction là `APPROVED`, đồng thời xác nhận Student Extension chỉ mới `READY_FOR_TARGETED_HUMAN_REVIEW` và `NOT_YET_APPROVED`.
* Final executable previews là `30/30/33`. Không tạo filler; mốc 35 không phải blocker vì raw AI generation đã đạt 40 case/API.
* Raw AI-generated suites remain unchanged. Postman/Newman, the SUT, and Excel were not started.
* Output A-007 đáp ứng đúng gate chuẩn bị và dừng review nên verdict là `VALID`; verdict này không đánh giá trước chất lượng riêng của 15 case.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `ACCEPTED_AS_IS` |
| Change Illustration | No change required. |
| Verification Method | `STATIC_REVIEW` |
| Verification Result | `PASSED` |
| Final File | `docs/test-extension/api-01-reset-password-student-extension.md`; `docs/test-extension/api-02-checkout-student-extension.md`; `docs/test-extension/api-03-import-products-student-extension.md`; `docs/test-extension/final-suite-preview.md`; `test-cases/student-added/api-01-reset-password.json`; `test-cases/student-added/api-02-checkout.json`; `test-cases/student-added/api-03-import-products.json` |
| Approval Status | `APPROVED` |

**Changes Made**

Không thay đổi output A-007. Human chấp nhận audit/correction và việc chuẩn bị Student Extension để chuyển sang targeted review.

**Correction Notes**

Không cần correction trong Verdict Scope của A-007. `APPROVED` chỉ áp dụng cho audit/correction và trạng thái sẵn sàng review; 15 Student cases vẫn chưa được Human phê duyệt và không được tự động đưa vào final suite.

**Human Decision Evidence**

`STUDENT_DECISION: STUDENT_EXTENSION_READY_FOR_TARGETED_HUMAN_REVIEW`

`AI_TEST_AUDIT_AND_CORRECTION: APPROVED`

`STUDENT_EXTENSION: NOT_YET_APPROVED`

### Artifact A-008 — Student Extension Targeted Quality Review

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-21 18:55:56 |
| Workflow Stage | Student Extension targeted Human Review preparation |
| Feature / Task | Review exactly 15 `STUDENT_ADDED` cases against raw/corrected AI suites and authoritative requirements without modifying candidates |
| Related Artifact | `docs/test-extension/student-extension-human-review-packet.md` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-008-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-008-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | Completeness and quality of the targeted review packet and its advisory recommendations; replacement cases remain outside this verdict |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact targeted-review instructions in `docs/ai-audit/interactions/A-008-prompt.md`; three approved requirement-analysis artifacts |
| Technical Documentation | 15 structured Student cases, all 120 raw AI-generated cases, three corrected executable suites, canonical schema, and AI Test Audit traceability artifacts |
| Execution Evidence | Static case-by-case semantic/oracle/traceability/feasibility comparison only; no SUT/Postman/Newman/Excel execution |

**Review Notes**

* Review packet bao phủ đúng 15/15 `STUDENT_ADDED` cases và đúng 5 case/API; mỗi case có closest raw IDs, semantic difference, genuinely-missed status, oracle review, execution feasibility, AI recommendation và sáu quality checks.
* 13 case được đề xuất `APPROVE`; `API02-STU-004` được đề xuất `REPLACE` vì trùng recovery pattern của `API02-STU-001` và gắn `CROSS_ENDPOINT_DEPENDENCY` dù không gọi refresh endpoint.
* `API03-STU-005` được đề xuất `REPLACE` vì `API03-AI-020` đã bao phủ hai distinct FR-16 errors cùng counts/reasons và rollback; `API03-AI-038/022` đã bao phủ report-to-persistence correlation.
* Oracle review không dùng expiry duration/rate limit/JWT cho reset, shipping-address/empty-cart/coupon/idempotency/order-status cho checkout, hoặc batch-size/duplicate/category/precision/raw-CSV/FR-15-only rules cho import.
* Execution feasibility được phân loại `9 POSTMAN_WITH_PRECONDITION_SETUP` và `6 POSTMAN_PLUS_EXTERNAL_VERIFICATION`; không ép persistence checks thành Postman-direct.
* Tất cả `HUMAN_DECISION` vẫn `PENDING`; Student Extension gốc không bị sửa và không có replacement/filler được tạo.
* Review packet và audit files không được stage/commit; Postman/Newman, SUT, Excel, GitHub Issues và CI/CD không được khởi động.
* Human Review xác nhận đúng kết luận `13` existing cases approved và `2` cases cần replacement: `API02-STU-004` và `API03-STU-005`.
* Vì Human chấp nhận nguyên vẹn targeted-review findings, output A-008 là `VALID`; label `MODIFIED_AND_APPROVED` mô tả downstream Student Extension, không phải correction của review packet.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `ACCEPTED_AS_IS` |
| Change Illustration | No change required. |
| Verification Method | `REVIEW` |
| Verification Result | `PASSED` |
| Final File | `docs/test-extension/student-extension-human-review-packet.md` |
| Approval Status | `APPROVED` |

**Changes Made**

Không thay đổi packet A-008. Human chấp nhận 13 recommendation `APPROVE` và hai recommendation `REPLACE` đúng như review đã ghi.

**Correction Notes**

Không cần correction trong Verdict Scope của A-008. Downstream Student Extension cần hai replacement theo Human Decision, nhưng replacement generation là interaction tiếp theo và không rewrite review packet lịch sử.

**Human Decision Evidence**

`STUDENT_DECISION: MODIFIED_AND_APPROVED`

`API_01: 5/5 APPROVED`

`API_02: 4/5 APPROVED; 1 REPLACEMENT_REQUIRED`

`API_03: 4/5 APPROVED; 1 REPLACEMENT_REQUIRED`

`TOTAL_APPROVED_EXISTING: 13`

`TOTAL_REPLACEMENTS_REQUIRED: 2`

### Artifact A-009 — Student Extension Replacement Generation and Audit

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-21 19:33:13 |
| Workflow Stage | Student Extension replacement generation and mini Human Review preparation |
| Feature / Task | Preserve 13 approved cases, replace two rejected concepts with exactly one new candidate for API-02 and API-03, and stop before approval/execution |
| Related Artifact | `docs/test-extension/api-02-checkout-student-extension.md`; `docs/test-extension/api-03-import-products-student-extension.md`; `test-cases/student-added/api-02-checkout.json`; `test-cases/student-added/api-03-import-products.json`; `docs/test-extension/replacement-human-review-packet.md`; `docs/test-extension/final-suite-preview.md` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-009-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-009-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | Quality and traceability of `API02-STU-006` and `API03-STU-006` as replacement candidates |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact replacement instructions in `docs/ai-audit/interactions/A-009-prompt.md`; approved requirement analyses; finalized A-008 Human Decision |
| Technical Documentation | All 40 raw cases/API, corrected executable suites, approved Student cases, rejected-case review evidence, canonical schema, updated Student Extension JSON/Markdown, and mini review packet |
| Execution Evidence | Static schema, count, ID, traceability, semantic-fingerprint, nearest-case, oracle-boundary, disposition, and Git-state checks only; no SUT/Postman/Newman/Excel execution |

**Review Notes**

* Finalized A-008 trước khi tiếp tục; Human Decision xác định đúng `API02-STU-004` và `API03-STU-005` cần replacement vì `NOT_GENUINELY_MISSED_BY_AI`.
* Giữ hai rejected cases trong history với `REPLACE` / `REJECTED_AS_STUDENT_EXTENSION`; giữ 13 existing approved cases và không thay đổi semantic content của API-01.
* Tạo đúng `API02-STU-006`, kết hợp current-cart mutation, spoofed identity và stale total colliding with cart B; không raw/corrected/approved Student case nào chứa đồng thời ba authority signals này.
* Tạo đúng `API03-STU-006`, kết hợp prior authorized admin commit với later unauthorized mixed-batch attempt; không raw/corrected/approved Student case nào kiểm tra cross-principal transaction isolation này.
* Cả hai replacement dùng `source=STUDENT_ADDED`, `GENUINELY_MISSED=YES`, `ORACLE_REVIEW=SUFFICIENT`, status/schema unspecified, và `POSTMAN_PLUS_EXTERNAL_VERIFICATION`; không dùng các forbidden requirement gaps.
* Static validation bao phủ 40 raw cases/API, corrected suites `25/28`, bốn approved Student cases/API, canonical schema và exact semantic fingerprints; candidate đầu tiên của mỗi API được giữ nên discarded duplicate count là `0`.
* Mini packet chứa đúng hai replacement và cả hai `HUMAN_DECISION=PENDING`; Student Extension/audit files không commit/stage, không push, và không bắt đầu Postman/SUT/Excel/CI.
* Human Review phê duyệt cả `API02-STU-006` và `API03-STU-006`, giữ `GENUINELY_MISSED=YES`, `ORACLE_REVIEW=SUFFICIENT` và `POSTMAN_PLUS_EXTERNAL_VERIFICATION` như AI đề xuất.
* Human đồng thời xác nhận `API02-STU-004` và `API03-STU-005` phải được giữ trong history nhưng không count; kết quả trùng khớp packet nên A-009 là `VALID`.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `ACCEPTED_AS_IS` |
| Change Illustration | No change required. |
| Verification Method | `REVIEW` |
| Verification Result | `PASSED` |
| Final File | `docs/test-extension/replacement-human-review-packet.md` |
| Approval Status | `APPROVED` |

**Changes Made**

Không thay đổi replacement candidates. Human chấp nhận hai AI recommendations và phê duyệt cả hai candidate để đưa vào finalized Student Extension.

**Correction Notes**

Không cần correction trong Verdict Scope của A-009. Downstream artifacts được cập nhật metadata để count replacement đã Human-approve, trong khi rejected history vẫn được preserve.

**Human Decision Evidence**

`STUDENT_DECISION: APPROVED`

`API02-STU-004: REJECTED_AS_STUDENT_EXTENSION; REASON: NOT_GENUINELY_MISSED_BY_AI`

`API02-STU-006: APPROVED; GENUINELY_MISSED: YES; ORACLE_REVIEW: SUFFICIENT; EXECUTION_FEASIBILITY: POSTMAN_PLUS_EXTERNAL_VERIFICATION`

`API03-STU-005: REJECTED_AS_STUDENT_EXTENSION; REASON: NOT_GENUINELY_MISSED_BY_AI`

`API03-STU-006: APPROVED; GENUINELY_MISSED: YES; ORACLE_REVIEW: SUFFICIENT; EXECUTION_FEASIBILITY: POSTMAN_PLUS_EXTERNAL_VERIFICATION`

`FINAL_STUDENT_EXTENSION: API-01: 5 APPROVED; API-02: 5 APPROVED; API-03: 5 APPROVED; TOTAL: 15 APPROVED`

### Artifact A-010 — Student Extension Finalization and Blocked Postman Build

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-21 20:00:45 |
| Workflow Stage | Final Student Extension commit checkpoint before final inventory and Postman implementation |
| Feature / Task | Finalize 15 approved Student cases, commit the extension, then build static-only final inventory/Postman artifacts |
| Related Artifact | `docs/test-extension/`; `test-cases/student-added/`; intended downstream `test-cases/final/`, `postman/`, and `docs/postman/` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-010-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-010-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | Student Extension finalization changes and workflow stop caused by inability to write the parent repository Git index |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact workflow instructions in `docs/ai-audit/interactions/A-010-prompt.md`; finalized A-009 Human Decision |
| Technical Documentation | Finalized Student Extension JSON/Markdown, canonical schema, replacement review packet, Git status/index location, and repository permission profile |
| Execution Evidence | Static schema/count/disposition checks and attempted scoped `git add`; no SUT/Postman/Newman/API/Excel execution |

**Review Notes**

* Finalized A-009 và cập nhật Student Extension thành đúng `5/5/5`, tổng `15` counted `STUDENT_ADDED` cases Human-approved.
* Giữ `API02-STU-004` và `API03-STU-005` trong history với `REJECTED_AS_STUDENT_EXTENSION` và `COUNT_TOWARD_STUDENT_EXTENSION=NO`; replacements `API02-STU-006`/`API03-STU-006` được marked approved.
* Static schema/count validation pass trước commit attempt; API-01/02/03 mỗi API có đúng năm approved counted cases.
* Scoped `git add` thất bại trước staging vì repository index nằm ở parent `.git` ngoài writable root: `Unable to create .../.git/index.lock: Permission denied`.
* Staging area vẫn rỗng và không có audit file staged; không tạo commit, không push.
* User yêu cầu Student Extension commit phải hoàn tất trước final inventory/Postman. Vì checkpoint này thất bại, workflow dừng; `test-cases/final/`, `postman/`, và `docs/postman/` chưa được tạo.
* Không chạy SUT, Postman Runner, Newman, API request, Excel hoặc CI/CD.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `CONTINUE_WITH_GIT_PERMISSION_RECOVERY` |
| Change Illustration | Human accepted the finalized Student Extension and authorized the documented Git-permission recovery fallback: preserve an exact pending-commit manifest and continue the non-Git Postman implementation when `.git` remains unavailable. |
| Verification Method | `STATIC_REVIEW` |
| Verification Result | `PASSED` |
| Final File | `docs/test-extension/`; `test-cases/student-added/` |
| Approval Status | `ACCEPTED_AS_IS` |

**Changes Made**

Student Extension content đã final hóa nhưng chưa thể commit. A-010 đã dừng đúng checkpoint và báo cáo trung thực environment blocker; recovery decision sau đó cho phép tiếp tục bằng pending-commit manifest mà không thay đổi semantic content đã duyệt.

**Correction Notes**

Đây là environment/permission blocker, không phải test-design rejection. Recovery tiếp tục theo policy mới: không stage audit files, ghi chính xác pending commit set, và giữ `GIT_CHECKPOINT_STATUS` tách biệt với `CONTENT_WORKFLOW_STATUS`.

**Human Decision Evidence**

`STUDENT_DECISION: CONTINUE_WITH_GIT_PERMISSION_RECOVERY`; `STUDENT_EXTENSION: APPROVED`; `GIT_BLOCKER: ENVIRONMENT_PERMISSION_BLOCKER`. Human review chấp nhận A-010 as-is và cho phép downstream static Postman implementation với Git checkpoint vẫn pending.

### Artifact A-011 — Git Permission Recovery and Static Postman Implementation

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-21 20:20:19 +07:00 |
| Workflow Stage | Git recovery fallback, final executable inventory, and static Postman implementation |
| Feature / Task | Preserve the approved Student Extension, document the pending Git checkpoint, build the unified suite/Postman artifacts, and validate without execution |
| Related Artifact | `docs/git/student-extension-commit-manifest.md`; `test-cases/final/`; `docs/test-suite/`; `postman/`; `docs/postman/` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-011-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-011-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | Git recovery diagnosis/manifest, 93-case final inventory, 103-request Postman static draft, execution/external-verification documentation, and static validation |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact recovery instructions in `docs/ai-audit/interactions/A-011-prompt.md`; finalized A-010 recovery decision |
| Technical Documentation | Approved corrected/Student case JSON; `eshop-sut/api_specification.md`; selected SUT route source used only for setup feasibility and implementation-observation boundaries |
| Execution Evidence | Static JSON/identity/header/path/auth/exclusion/secret validation only; no SUT, HTTP, Postman Runner, Newman, Excel, or CI/CD execution |

**Review Notes**

* AI đã giữ đúng boundary static-only: hợp nhất 78 corrected executable AI cases với 15 approved Student cases thành 93 testcase, không đưa 38 deferred, 4 invalid hoặc rejected history vào final inventory.
* Collection giữ đúng 93 stable testcase identities và 10 setup/precheck helpers; validator xác nhận coverage `93/93` và `X-Student-Id` coverage `103/103`.
* Execution-mode classification và external verification plan được ghi rõ; output không bịa runtime PASS/FAIL, response schema, status oracle hoặc persisted-state evidence.
* Git blocker được tách khỏi content workflow bằng exact pending manifest; không tạo commit hash giả và không stage audit files.
* Human Review xác nhận `POSTMAN_IMPLEMENTATION_APPROVED_FOR_REAL_EXECUTION`, static validation PASS và chấp nhận artifact as-is; vì vậy original output được đánh giá `VALID`.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `ACCEPTED_AS_IS` |
| Change Illustration | No change required. |
| Verification Method | `STATIC_REVIEW` |
| Verification Result | `PASSED` |
| Final File | `test-cases/final/`; `docs/test-suite/final-executable-suite.md`; `postman/`; `docs/postman/`; `docs/git/student-extension-commit-manifest.md` |
| Approval Status | `APPROVED` |

**Changes Made**

Không cần sửa Postman implementation. Human đã approve revision hiện tại để chuyển sang real execution; Git checkpoint vẫn pending do environment permission và không làm thay đổi approval nội dung.

**Correction Notes**

Original A-011 output đúng trong Verdict Scope nên giữ verdict `VALID`. Approval này chỉ mở execution gate; nó không tự tạo runtime evidence hay thay đổi Git checkpoint.

**Human Decision Evidence**

```text
STUDENT_DECISION:
POSTMAN_IMPLEMENTATION_APPROVED_FOR_REAL_EXECUTION

POSTMAN_STATIC_VALIDATION:
PASS

TESTCASE_COVERAGE:
93/93

X_STUDENT_ID_COVERAGE:
103/103

GIT_CHECKPOINT:
PENDING_EXTERNAL_GIT_PERMISSION

GIT_BLOCKER_TYPE:
ENVIRONMENT_ONLY
```

### Artifact A-012 — Real API Execution Preflight Blocked Before Requests

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-21 20:32:37 +07:00 |
| Workflow Stage | Human-approved real-execution preflight |
| Feature / Task | Finalize A-011 approval, verify execution inputs/guards/tooling/SUT safety, and run smoke/full Newman only if mandatory guards pass |
| Related Artifact | `postman/`; `test-cases/final/`; `test-results/hw06/preflight-001/`; `docs/execution-results/` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-012-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-012-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | A-011 approval finalization, static input revalidation, local tool/SUT/database preflight, mandatory Student ID/secret guards, and blocked 93-case execution accounting |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact execution instructions in `docs/ai-audit/interactions/A-012-prompt.md`; explicit Human Decision approving A-011 for real execution |
| Technical Documentation | Approved Postman collection/environment/data; execution manifest; external verification plan; `eshop-sut/backend/database.js`; local process/listener state |
| Execution Evidence | Static validator output; redacted environment-key guard; Node/npm/Newman availability checks; port-3000 listener inspection; SHA-256 input hashes; no HTTP/Newman/SUT execution |

**Review Notes**

* A-011 đã được finalized đúng gate trước preflight; approved inputs tiếp tục pass static validation với 93/93 testcase identities và 103/103 structural header coverage.
* Mandatory runtime guard phát hiện `studentId` và disposable credentials chưa được cấu hình, nên AI dừng trước backend startup và trước mọi SUT request như policy yêu cầu.
* Preflight giữ evidence boundary đúng: không cài/chạy Newman, không tạo runtime report giả, không gán FAIL hoặc product defect cho case chưa chạy.
* `preflight-001` account đủ 93 stable IDs thành `BLOCKED / ENVIRONMENT_DEFECT` và giữ external verification planned 26 nhưng chưa thực hiện.
* Human Review xác nhận blocked preflight là hợp lệ, yêu cầu preserve `preflight-001` và resume bằng safe runtime configuration recovery; original output vì vậy được đánh giá `VALID`.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `ACCEPTED_AS_IS` |
| Change Illustration | No change required. |
| Verification Method | `STATIC_REVIEW` |
| Verification Result | `PASSED` |
| Final File | `test-results/hw06/preflight-001/`; `docs/execution-results/` |
| Approval Status | `APPROVED` |

**Changes Made**

Không sửa historical meaning hoặc artifact của `preflight-001`; Human chấp nhận output as-is và yêu cầu tạo recovery artifacts mới khi tiếp tục.

**Correction Notes**

Original output đúng trong Verdict Scope nên giữ `VALID`. Recovery action mới không biến blocked preflight thành runtime execution và không overwrite evidence cũ.

**Human Decision Evidence**

```text
STUDENT_DECISION:
PREFLIGHT_BLOCK_ACCEPTED

PREVIOUS_EXECUTION:
VALID_BLOCKED_PREFLIGHT

ACTION:
RECOVER_RUNTIME_CONFIGURATION_AND_RETRY

POLICY:
Resolve every configuration/tooling issue that can be safely resolved by the agent.
Only ask for human input when a required value cannot be established from trusted existing project configuration.

PRESERVE_PREFLIGHT_001:
YES
```

### Artifact A-013 — Runtime Configuration Recovery and Newman Tooling Blocker

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-21 20:46:43 +07:00 |
| Workflow Stage | Recovery preflight after accepted blocked execution |
| Feature / Task | Preserve preflight-001, recover trusted Student ID/fixture strategy, resolve Newman, prepare SUT, and execute only if every runtime guard passes |
| Related Artifact | `test-results/hw06/preflight-001/`; `test-results/hw06/preflight-002/`; `test-results/hw06/runtime/`; `docs/execution-results/`; `package.json` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-013-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-013-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `INCOMPLETE` |
| Verdict Scope | A-012 Human Decision finalization, trusted runtime identity/credential recovery, local Newman installation attempts, SUT preparation, preserved preflight evidence, and blocked 93-case accounting |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact recovery prompt in `docs/ai-audit/interactions/A-013-prompt.md`; explicit `PREFLIGHT_BLOCK_ACCEPTED` Human Decision |
| Technical Documentation | Three repository-local homework metadata files with explicit agreeing Student IDs; `eshop-sut/backend/database.js`; backend package/dependency state; approved Postman artifacts |
| Execution Evidence | Redacted trusted-source uniqueness check; runtime variable non-empty guard; Newman local/global/cache/install checks; backend syntax/dependency checks; preflight-001 hashes; preflight-002 case accounting; zero HTTP requests |

**Review Notes**

* A-012 được finalized đúng gate và `preflight-001` được preserve; Student ID, credential strategy và SUT preparation được recover an toàn mà không log secrets hoặc forge JWT.
* Newman recovery đã kiểm tra existing local/global dependency, offline cache và một registry install attempt; output dừng đúng khi tooling vẫn unavailable, không start SUT hoặc tạo runtime evidence giả.
* Human chấp nhận tooling blocker và cho phép thử recovery hoàn toàn trong writable HW6 bằng local cache/prefix/temp paths.
* Điểm thiếu của original output là gán 93 case chưa chạy thành `ENVIRONMENT_DEFECT`. Human yêu cầu sửa semantics thành `PRE_EXECUTION_BLOCKED: 93`, `RUNTIME_ENVIRONMENT_DEFECTS: 0`, với đúng một root tooling blocker.
* Vì output đúng về guard/tooling evidence nhưng cần correction về bookkeeping, verdict phù hợp là `INCOMPLETE`; raw `preflight-001`/`preflight-002` vẫn giữ nguyên làm historical evidence.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `MODIFIED` |
| Change Illustration | See **Changes Made** below. |
| Verification Method | `STATIC_REVIEW` |
| Verification Result | `PASSED` |
| Final File | `test-results/hw06/preflight-002/`; `test-results/hw06/runtime/runtime-configuration-metadata.json`; `docs/execution-results/`; `package.json` |
| Approval Status | `APPROVED` |

**Changes Made**

* Giữ nguyên raw evidence của `preflight-001` và `preflight-002`.
* Sửa các báo cáo preflight-only để phân biệt 93 `PRE_EXECUTION_BLOCKED` với 0 `RUNTIME_ENVIRONMENT_DEFECTS`.
* Cho phép một recovery attempt mới dùng `.tools/npm-cache`, `.tools/newman`, `.tools/npm-prefix` và `.tools/tmp` hoàn toàn trong writable HW6.

**Correction Notes**

Original A-013 output cần Human-directed bookkeeping correction nên verdict giữ `INCOMPLETE`; tooling blocker và zero-request evidence vẫn được chấp nhận. Không thay đổi testcase oracle hoặc historical raw preflight evidence.

**Human Decision Evidence**

```text
STUDENT_DECISION:
NEWMAN_TOOLING_BLOCK_ACCEPTED

PREVIOUS_PREFLIGHT:
VALID_BLOCKED_PREFLIGHT

ACTION:
ATTEMPT_WRITABLE_LOCAL_TOOLING_RECOVERY

POLICY:
Use an HW6-local npm cache, installation prefix, temp directory,
and node_modules so no write outside HW6 is required.

If external network/package access remains unavailable,
stop with exact Human commands instead of repeated retries.
```

### Artifact A-014 — Isolated Newman Recovery and External Install Handoff

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-21 21:03:02 +07:00 |
| Workflow Stage | Writable-local Newman tooling recovery after approved preflight blocker |
| Feature / Task | Correct pre-execution bookkeeping, isolate npm paths inside HW6, attempt bounded Newman/reporter recovery, and create external-install handoff if registry access remains unavailable |
| Related Artifact | `.tools/.gitignore`; `docs/runtime/newman-tooling-install-manifest.md`; `docs/runtime/newman-tooling-recovery-result.json`; `docs/execution-results/` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-014-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-014-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | A-013 finalization, reporting-semantics correction, isolated npm cache/prefix/temp recovery, bounded Newman/reporter install attempts, and external-install handoff |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact tooling-recovery prompt in `docs/ai-audit/interactions/A-014-prompt.md`; exact external-install Human Decision supplied in the continuation prompt |
| Technical Documentation | npm effective configuration; cache index/metadata; local tooling paths; approved Postman/runtime configuration; preserved preflight artifacts |
| Execution Evidence | Original bounded recovery evidence plus Human-reported installation result and current local verification of Newman `6.2.2` and `newman-reporter-htmlextra` `1.23.1` |

**Review Notes**

* A-013 được finalized `INCOMPLETE / MODIFIED / APPROVED`; raw `preflight-001` và `preflight-002` được preserve, còn reports được sửa thành `PRE_EXECUTION_BLOCKED: 93` và `RUNTIME_ENVIRONMENT_DEFECTS: 0`.
* `.tools/newman`, `.tools/npm-cache`, `.tools/npm-prefix`, `.tools/tmp` được tạo trong writable HW6; cache/prefix/temp đều pass local write probe và toàn bộ `.tools` payload được exclude bằng `.tools/.gitignore`.
* Strategy A xác nhận không có existing Newman local/global. Strategy B kiểm tra cache index thực tế nhưng offline install vẫn trả `ENOTCACHED`, nên cached package không usable như complete dependency graph.
* Strategy C dùng local cache/prefix/temp và thử cài `newman@6.2.2` cùng `newman-reporter-htmlextra` đúng một lần. npm local log ghi registry GET failures `EACCES`; process được dừng sau built-in retries, không phát install command lần nữa.
* Poststate xác nhận không có Newman binary/module, reporter, package-lock hoặc partial prefix package. SUT không start; request count và testcase execution count đều zero.
* External handoff chứa exact Git Bash/PowerShell commands để cài local trong `.tools/newman/` và exact resume verification; không yêu cầu global install hoặc permission weakening.
* Human đã thực hiện external local install theo handoff và xác nhận tooling blocker được resolve; kiểm tra hiện tại trả đúng Newman `6.2.2` và reporter `1.23.1` tại `.tools/newman/`.
* Original A-014 output hoàn thành đúng nhiệm vụ recovery/handoff và không cần correction, nên verdict là `VALID`; việc cài package sau đó là Human external action được ghi nhận riêng, không phải sửa lại original AI output.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `ACCEPTED_AS_IS` |
| Change Illustration | No change required. |
| Verification Method | `EXECUTION_EVIDENCE_REVIEW` |
| Verification Result | `PASSED` |
| Final File | `docs/runtime/newman-tooling-install-manifest.md`; `docs/runtime/newman-tooling-recovery-result.json`; `docs/execution-results/` |
| Approval Status | `APPROVED` |

**Changes Made**

Không sửa original A-014 output. Human đã thực hiện external installation theo handoff; tooling hiện có sẵn tại `.tools/newman/`.

**Correction Notes**

Không cần correction trong Verdict Scope của A-014. External state change đã hoàn tất và được verify; không có testcase, oracle, product code hoặc historical preflight evidence nào bị thay đổi.

**Human Decision Evidence**

```text
STUDENT_DECISION:
EXTERNAL_NEWMAN_TOOLING_VERIFIED

NEWMAN_TOOLING_BLOCKER:
RESOLVED

ACTION:
CONTINUE_REAL_HW06_EXECUTION
```

### Artifact A-015 — Real-Execution Recovery Preflight

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-22 19:34:27 +07:00 |
| Workflow Stage | Recovery preflight before real SUT execution |
| Feature / Task | Verify externally installed Newman tooling, finalize A-014, validate runtime guards, and prepare smoke-001 |
| Related Artifact | `test-results/hw06/preflight-003/`; `test-results/hw06/smoke-001/smoke.postman_collection.json`; `postman/scripts/prepare-real-execution.js` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-015-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-015-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `PENDING_HUMAN_REVIEW` |
| Verdict |  |
| Verdict Scope | A-014 finalization, preflight-003 evidence, runtime identity/header/tooling guards, and runtime-only smoke collection preparation |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact continuation prompt in `docs/ai-audit/interactions/A-015-prompt.md`; exact external Newman Human Decision recorded in A-014 |
| Technical Documentation | Approved Postman collection/environment; three repository-local HW06 skills; expected EShop backend/database paths |
| Execution Evidence | Local Newman/reporter version checks, 103-request collection traversal, non-empty runtime guard, prior-preflight hashes, server syntax check, and zero-request port precheck |

**Review Notes**

* Pending targeted Human Review of preflight-003 and the runtime-only smoke preparation.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `PENDING_HUMAN_REVIEW` |
| Change Illustration | Pending Human Review. |
| Verification Method | `STATIC_REVIEW` |
| Verification Result | `NOT_EXECUTED` |
| Final File | `test-results/hw06/preflight-003/`; `test-results/hw06/smoke-001/smoke.postman_collection.json` |
| Approval Status | `PENDING` |

**Changes Made**

Pending Human Review.

**Correction Notes**

The preflight artifact is recorded before SUT startup; no runtime result is claimed in A-015.

**Human Decision Evidence**

Pending Human Review.

### Artifact A-016 — SUT Startup Recovery

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-22 19:40:04 +07:00 |
| Workflow Stage | SUT startup after successful recovery preflight |
| Feature / Task | Diagnose sandbox SQLite write failure and start the unmodified EShop backend with an isolated writable runtime database |
| Related Artifact | `test-results/hw06/runtime/sut-startup-metadata.md`; `test-results/hw06/runtime/sqlite-path-redirect.cjs`; `test-results/hw06/runtime/sut-001.*`; `test-results/hw06/runtime/sut-003.*` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-016-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-016-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `PENDING_HUMAN_REVIEW` |
| Verdict |  |
| Verdict Scope | Startup diagnostics, preserved failure evidence, runtime-only SQLite path redirect, and verified local SUT readiness |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact continuation prompt in `docs/ai-audit/interactions/A-016-prompt.md`, including allowed non-production harness/config fixes |
| Technical Documentation | Unmodified `eshop-sut/backend/server.js` and `database.js`; HW6 writable-root policy |
| Execution Evidence | Preserved startup stdout/stderr, SQLite write probe, source/runtime DB hashes, active Node listener ownership, and zero HTTP requests before smoke |

**Review Notes**

* Pending targeted Human Review of the environment-only startup correction and readiness evidence.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `PENDING_HUMAN_REVIEW` |
| Change Illustration | Pending Human Review. |
| Verification Method | `EXECUTION_EVIDENCE_REVIEW` |
| Verification Result | `NOT_EXECUTED` |
| Final File | `test-results/hw06/runtime/sut-startup-metadata.md`; `test-results/hw06/runtime/sqlite-path-redirect.cjs` |
| Approval Status | `PENDING` |

**Changes Made**

Pending Human Review.

**Correction Notes**

The harness redirects only the SQLite file path into the writable HW6 runtime area; production source and the source database remain unchanged.

**Human Decision Evidence**

Pending Human Review.

### Artifact A-017 — Real Smoke Execution and Harness Correction

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-22 19:45:47 +07:00 |
| Workflow Stage | Real smoke execution before full 93-case run |
| Feature / Task | Preserve smoke-001, correct setup-script variable scope, run smoke-002, and perform safe external smoke checks |
| Related Artifact | `test-results/hw06/smoke-001/`; `test-results/hw06/smoke-002/`; `postman/collections/HW06-API-Testing.postman_collection.json`; `postman/scripts/verify-smoke-external.py` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-017-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-017-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `PENDING_HUMAN_REVIEW` |
| Verdict |  |
| Verdict Scope | Genuine smoke evidence, harness-only correction, full-execution gate, and preliminary requirement-backed observations |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact continuation prompt in `docs/ai-audit/interactions/A-017-prompt.md`; approved testcase traceability and external-verification plan |
| Technical Documentation | Approved Postman collection/runtime environment and unmodified EShop backend |
| Execution Evidence | Preserved Newman JSON/HTML/stdout/stderr for smoke-001 and smoke-002; runtime header inspection; read-only SQLite evidence; one Newman cart postcheck |

**Review Notes**

* Pending targeted Human Review of the preserved failed smoke, harness-only fix, rerun gate, and preliminary candidate classifications.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `PENDING_HUMAN_REVIEW` |
| Change Illustration | Pending Human Review. |
| Verification Method | `EXECUTION_EVIDENCE_REVIEW` |
| Verification Result | `NOT_EXECUTED` |
| Final File | `test-results/hw06/smoke-001/`; `test-results/hw06/smoke-002/`; `postman/collections/HW06-API-Testing.postman_collection.json` |
| Approval Status | `PENDING` |

**Changes Made**

Pending Human Review.

**Correction Notes**

No production code or requirement oracle was changed. Preliminary product-defect candidates remain non-final pending Human Failure Triage.

**Human Decision Evidence**

Pending Human Review.

### Artifact A-018 — Full HW06 Real Execution and Preliminary Triage

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-22 19:56:30 +07:00 |
| Workflow Stage | Full real execution, external verification, accounting, and preliminary failure triage |
| Feature / Task | Execute all 93 testcase identities, preserve real Newman evidence, externally verify approved invariants, classify outcomes, and stop at Human Failure Triage |
| Related Artifact | `test-results/hw06/run-001/`; `docs/execution-results/`; `postman/collections/HW06-API-Testing.postman_collection.json` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-018-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-018-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | Real run-001 evidence, 93-case accounting, 26-case external verification, preliminary classifications, reports, and triage packet |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact continuation prompt in `docs/ai-audit/interactions/A-018-prompt.md`; approved final testcase inventory and external-verification plan |
| Technical Documentation | Approved Postman collection/runtime environment; unmodified EShop backend; three HW06 repository-local skills |
| Execution Evidence | Genuine run-001 Newman JSON/HTML/stdout/stderr; 103 collection requests; two Newman cart postchecks; read-only SQLite inspection; 93-case and 26-external-case accounting |

**Review Notes**

* AI output đã preserve genuine `run-001`, phân biệt Newman runner success với business/state result, và account đủ 93 testcase identities cùng 26 external-verification cases.
* Output giữ 38 findings ở mức `PRODUCT_DEFECT_CANDIDATE`, không tự xác nhận product defect, không tạo GitHub Issue và dừng đúng tại Human Failure Triage checkpoint.
* Human xác nhận `run-001` là original real execution hợp lệ để triage và yêu cầu preserve nguyên trạng; không có correction nào được yêu cầu đối với output A-018.
* Verdict `VALID` áp dụng cho execution evidence, preliminary classification và checkpoint handoff; nó không xác nhận 38 candidates là 38 distinct product defects.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `ACCEPTED_AS_IS` |
| Change Illustration | No change required. |
| Verification Method | `EXECUTION_EVIDENCE_REVIEW` |
| Verification Result | `PASSED` |
| Final File | `test-results/hw06/run-001/`; `docs/execution-results/` |
| Approval Status | `APPROVED` |

**Changes Made**

Không sửa original A-018 output hoặc `run-001`; Human chấp nhận evidence package làm input cho root-cause triage.

**Correction Notes**

Không cần correction trong Verdict Scope của A-018. Approval chỉ cho phép chuyển sang evidence-based root-cause triage; mọi product finding vẫn là candidate và Human defect decision vẫn pending.

**Human Decision Evidence**

```text
STUDENT_DECISION:
RUN_001_ACCEPTED_FOR_FAILURE_TRIAGE

RUN_001:
PRESERVE_AS_ORIGINAL_REAL_EXECUTION

PRODUCT_DEFECT_CANDIDATES:
NOT_YET_CONFIRMED

ACTION:
PERFORM_EVIDENCE_BASED_ROOT_CAUSE_TRIAGE
```

### Artifact A-019 — Human Failure Triage Preparation

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-22 20:12:25 +07:00 |
| Workflow Stage | Human Failure Triage preparation after preserved run-001 |
| Feature / Task | Review 38 Product Defect Candidates, 10 Test Defects, 17 Test Data Defects, 27 blocked cases, and unresolved external verification; cluster root causes and propose a targeted rerun without corrections or execution |
| Related Artifact | `docs/execution-results/human-failure-triage-packet.md`; `docs/execution-results/targeted-rerun-plan.md`; preserved `test-results/hw06/run-001/` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-019-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-019-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | Six proposed distinct product-root hypotheses, all 38 candidate recommendations, current test/test-data defect reviews, blocked/external clusters, and proposed 37-case targeted rerun scope |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact continuation prompt in `docs/ai-audit/interactions/A-019-prompt.md`; approved API-01/API-02/API-03 requirement analyses |
| Technical Documentation | Approved final testcase records, execution reports, Postman collection, and repository-local HW06 workflow/audit skills |
| Execution Evidence | Preserved `run-001` Newman JSON/HTML/logs, 93-case accounting, 26-case external-verification accounting, cart postchecks, read-only SQLite state, and read-only SUT implementation inspection |

**Review Notes**

* AI đã review đủ `38` Product Defect Candidates và đề xuất đúng mapping được Human chấp thuận: `29` case là evidence của product defect, `4` case reclassify thành Test Defect và `5` case reclassify thành Test Data Defect.
* Sáu root-cause hypothesis đều được Human xác nhận là sáu product defect riêng biệt; việc cluster tránh sai lệch `38 testcase failures = 38 bugs` và giữ đúng primary/supporting evidence của `run-001`.
* Phần review `10` Test Defects, `17` Test Data Defects, `8` blocker clusters và ba external-verification cases được Human dùng nguyên làm phạm vi correction/rerun tiếp theo.
* Human decision `MODIFIED_AND_APPROVED` chuyển trạng thái trong triage packet từ recommendation/pending sang final classification, nhưng không thay đổi sáu root hypotheses, các counts hoặc targeted scope `37` mà AI đã đề xuất.
* Verdict là `VALID` vì original A-019 analysis và recommendation được Human xác nhận; thay đổi downstream chỉ áp Human decision vào artifact, không sửa một lỗi phân tích trong original AI output.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `MODIFIED` |
| Change Illustration | See **Changes Made** below. |
| Verification Method | `REVIEW` |
| Verification Result | `PASSED` |
| Final File | `docs/execution-results/human-failure-triage-packet.md`; `docs/execution-results/targeted-rerun-plan.md` |
| Approval Status | `APPROVED` |

**Changes Made**

* Finalize cả sáu cluster `RC-02-01` đến `RC-03-03` thành `CONFIRM_PRODUCT_DEFECT`.
* Finalize mapping `29 PRODUCT_DEFECT`, `4 TEST_DEFECT`, `5 TEST_DATA_DEFECT` và giữ `29` là testcase evidence count, không phải distinct defect count.
* Authorize oracle-preserving corrections cho pool `36` test/test-data cases cùng external-pending case `API01-AI-027`, vẫn giữ targeted scope mặc định `37`.

**Correction Notes**

Original A-019 recommendation không bị thay đổi. Human approval chỉ finalize các quyết định còn pending và mở gate cho test/harness/test-data correction cùng targeted `run-002`; production defects vẫn không được sửa.

**Human Decision Evidence**

```text
STUDENT_DECISION:
MODIFIED_AND_APPROVED

RUN_001:
ACCEPTED_AS_VALID_REAL_EXECUTION

DISTINCT_PRODUCT_DEFECTS:
6
```

### Artifact A-020 — Defect Confirmation, Corrective Targeted Rerun, and Defect Reports

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-22 21:17:57 +07:00 |
| Workflow Stage | Human-confirmed defect finalization, test/harness/data correction, targeted run-002, and defect documentation |
| Feature / Task | Finalize six run-001 root defects; correct only approved test/harness/data problems; execute and classify 37 targeted identities; resolve external verification; create six Markdown defect reports without product fixes or GitHub Issues |
| Related Artifact | `test-results/hw06/run-002/`; `docs/execution-results/`; `docs/defects/`; preserved `test-results/hw06/run-001/` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-020-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-020-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | Preserved real run-002 execution/accounting, oracle-preserving correction evidence, three external verifications, six existing confirmed defect reports, and handoff to triage of three not-yet-confirmed new clusters; excludes final Human decisions on those clusters and screenshot completeness |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact continuation prompt in `docs/ai-audit/interactions/A-020-prompt.md`; Human-finalized triage packet; approved final testcase records |
| Technical Documentation | Repository-local workflow/Postman/audit skills; canonical schema; unmodified EShop backend; Newman `6.2.2`; htmlextra `1.23.1` |
| Execution Evidence | Genuine smoke and run-002 Newman JSON/HTML/stdout/stderr; 37-case history/accounting; runtime environment/cart observations; synchronous/read-only SQLite evidence; source/run-001 hash comparisons |

**Review Notes**

* AI đã giữ đúng distinction giữa `29 testcase evidence cases` và `6 distinct product defects`, đồng thời không tự confirm ba root cluster mới phát sinh từ run-002.
* Targeted `run-002` account đủ `37` stable IDs (`36` request thực thi, một intentional skip), giữ `API01-AI-016` ở `BLOCKED / TEST_DATA_DEFECT` thay vì giả lập expired OTP.
* Human chấp nhận `run-002` là real targeted execution hợp lệ để triage và yêu cầu preserve nguyên trạng; các count `15 PASS`, `21 FAIL`, `1 BLOCKED`, `9` new candidates và `3` candidate clusters được dùng làm input review.
* Sáu defect đã confirmed trước đó vẫn được giữ nguyên; Human chưa xác nhận ba cluster mới nên original A-020 dừng tại review checkpoint là đúng.
* Verdict `VALID` áp dụng cho execution/correction/evidence package và checkpoint handoff; nó không xác nhận product defect mới hoặc xác nhận screenshot completeness.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `ACCEPTED_AS_IS` |
| Change Illustration | No change required. |
| Verification Method | `EXECUTION_EVIDENCE_REVIEW` |
| Verification Result | `PASSED` |
| Final File | `test-results/hw06/run-002/`; `docs/execution-results/`; `docs/defects/` |
| Approval Status | `APPROVED` |

**Changes Made**

Không sửa original A-020 output hoặc `run-002`; Human chấp nhận execution package làm input cho triage ba cluster mới và genuine evidence preparation.

**Correction Notes**

Không cần correction trong Verdict Scope của A-020. Approval không tự xác nhận ba cluster mới và không mở GitHub Issue phase; các Human decision tương ứng vẫn pending.

**Human Decision Evidence**

```text
STUDENT_DECISION:
RUN_002_ACCEPTED_FOR_NEW_DEFECT_TRIAGE

RUN_002:
PRESERVE_AS_REAL_TARGETED_EXECUTION

EXISTING_CONFIRMED_DEFECTS:
6

NEW_ROOT_CLUSTERS:
NOT_YET_HUMAN_CONFIRMED

ACTION:
REVIEW_3_NEW_ROOT_CLUSTERS_AND_PREPARE_GENUINE_DEFECT_EVIDENCE
```

### Artifact A-021 — run-002 New-Defect Human Review Preparation and Genuine Evidence Capture

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-22 21:40:04 +07:00 |
| Workflow Stage | New defect cluster Human Review preparation and genuine evidence capture after preserved run-002 |
| Feature / Task | Review nine run-002 Product Defect Candidates; reconstruct and compare exactly three root clusters; validate plaintext persistence evidence; preserve the expired-OTP blocker; attempt genuine screenshots and prepare six-case manual capture evidence |
| Related Artifact | `docs/execution-results/run-002-new-defect-human-review-packet.md`; `docs/defects/evidence-matrix.md`; `docs/defects/screenshot-capture-plan.md`; preserved `test-results/hw06/run-001/` and `test-results/hw06/run-002/` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-021-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-021-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `FINALIZED` |
| Verdict | `VALID` |
| Verdict Scope | Nine run-002 candidate reviews, exactly three distinct API-01 root clusters, six-defect overlap analysis, API01-AI-035 read-only persistence evidence, API01-AI-016 blocked disposition, and genuine screenshot/manual-capture preparation |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact continuation prompt in `docs/ai-audit/interactions/A-021-prompt.md`; approved API-01 requirement analysis and final testcase records |
| Technical Documentation | Repository-local HW06 workflow/Postman/audit skills; external-verification plan; six existing confirmed defect reports |
| Execution Evidence | Preserved run-002 Newman JSON/HTML/stdout/stderr/metadata; 37-case accounting; isolated database hashes and user-state evidence; external verification booleans; preserved run-001 reports |

**Review Notes**

* AI đã review đủ `9` Product Defect Candidate và gom đúng thành `3` root cluster riêng biệt; Human xác nhận cả `RC-01-N01`, `RC-01-N02` và `RC-01-N03` là Product Defect.
* Phân tích overlap với `6` defect hiện hữu là đúng: ba cluster mới thuộc API reset-password và không trùng root behavior của checkout/import.
* Evidence cho `RC-01-N03` dùng đúng disposable user và post-reset row trong isolated SQLite; chỉ ghi boolean `plaintext_equal: true`, không lộ password, hash, JWT hoặc Student ID.
* AI giữ đúng `API01-AI-016` ở `BLOCKED_TEST_DATA` và không dùng case này làm product evidence; Human decision không yêu cầu sửa điểm này.
* Verdict là `VALID` vì Human chấp nhận nguyên ba recommendation, evidence strength, cluster mapping và evidence boundary; downstream inventory tăng từ `6` lên đúng `9` distinct confirmed defects.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `ACCEPTED_AS_IS` |
| Change Illustration | No change required. |
| Verification Method | `EXECUTION_EVIDENCE_REVIEW` |
| Verification Result | `PASSED` |
| Final File | `docs/execution-results/run-002-new-defect-human-review-packet.md`; `docs/defects/evidence-matrix.md`; `docs/defects/screenshot-capture-plan.md` |
| Approval Status | `APPROVED` |

**Changes Made**

Không thay đổi original A-021 output. Human xác nhận cả ba AI recommendation và cho phép dùng chúng để tạo `DEF-07`, `DEF-08`, `DEF-09`.

**Correction Notes**

Không cần correction trong Verdict Scope của A-021. Human approval chỉ finalize classification; không cho phép rerun, sửa SUT hoặc tạo GitHub Issues trước khi hoàn tất genuine screenshots.

**Human Decision Evidence**

```text
STUDENT_DECISION:
APPROVED

RC-01-N01:
CONFIRM_PRODUCT_DEFECT

RC-01-N02:
CONFIRM_PRODUCT_DEFECT

RC-01-N03:
CONFIRM_PRODUCT_DEFECT
```

### Artifact A-022 — Final Nine-Defect Confirmation and Evidence Preparation

#### (1) Prompt + Tool

| Field | Value |
| --- | --- |
| Tool | Codex |
| Model | Not exposed by the current environment |
| Date and Time | 2026-08-22 21:53:22 +07:00 |
| Workflow Stage | Human-approved run-002 cluster finalization, nine-defect documentation, and pre-GitHub evidence readiness |
| Feature / Task | Finalize three Human-confirmed API-01 defects; create DEF-07 through DEF-09; calculate unique evidence-case accounting; update the nine-defect matrix, manual screenshot plan, GitHub readiness, execution summary, and pending commit manifest without rerun or issue creation |
| Related Artifact | `docs/defects/DEF-07-reset-missing-new-password.md`; `docs/defects/DEF-08-reset-password-strength-not-enforced.md`; `docs/defects/DEF-09-reset-password-plaintext-storage.md`; `docs/defects/evidence-matrix.md`; `docs/defects/screenshot-capture-plan.md`; `docs/defects/github-issue-readiness.md`; `docs/execution-results/cross-api-execution-summary.md` |

**Verbatim Prompt**

Stored externally at `docs/ai-audit/interactions/A-022-prompt.md`.

#### (2) AI Output

| Field | Value |
| --- | --- |
| Output Storage | `EXTERNAL_FILE` |
| Full Output / Evidence Path | `docs/ai-audit/interactions/A-022-output.md` |

**Verbatim AI Output or Labelled Excerpt**

Stored externally at the exact path above.

#### (3) Verdict

| Field | Value |
| --- | --- |
| Review Status | `PENDING_HUMAN_REVIEW` |
| Verdict |  |
| Verdict Scope | A-021 Human-decision finalization; three new defect reports; exactly nine confirmed-defect matrix rows; unique 38-case accounting; nine-case manual screenshot plan; issue readiness and final execution accounting |

#### (4) Reasoning

**Evaluation Sources**

| Source Type | Reference |
| --- | --- |
| Requirement / Acceptance Criteria | Exact Human decision and continuation prompt in `docs/ai-audit/interactions/A-022-prompt.md`; approved API-01 requirement analysis |
| Technical Documentation | Canonical HW06 testcase schema; repository-local workflow/Postman/audit skills; nine defect reports and screenshot policy |
| Execution Evidence | Preserved run-001 and run-002 Newman reports, case accounting, Human triage packet, read-only external SQLite evidence, immutable-run SHA-256 baselines, and actual HTML case-presence checks |

**Review Notes**

* A-021 đã được finalize `VALID` bằng exact Human decision trước khi tạo downstream artifacts.
* Tạo `DEF-07`, `DEF-08`, `DEF-09` theo ba root cluster đã Human-confirm; không tách bảy password partitions thành nhiều defect và không đưa `API01-AI-016` vào product evidence.
* Đếm từ stable IDs thật cho kết quả canonical `29 + 9 = 38`, overlap bằng `0`; `38` là testcase evidence records cho `9` distinct defects, không phải số bug.
* Matrix có đúng `9` dòng confirmed, capture plan có đúng `9` primary target hiện diện trong Newman HTML, và readiness giữ `0` issue ready vì chưa có genuine screenshot.
* Không rerun Newman, không sửa tests/test data/SUT, không tạo image/GitHub Issue/CI/CD/Excel, và không stage audit files.

#### (5) Student Fix

| Field | Value |
| --- | --- |
| Student Decision | `PENDING_HUMAN_REVIEW` |
| Change Illustration | Pending Human Review. |
| Verification Method | `EXECUTION_EVIDENCE_REVIEW` |
| Verification Result | `NOT_EXECUTED` |
| Final File | `docs/defects/`; `docs/execution-results/cross-api-execution-summary.md`; `docs/git/run-002-defect-report-commit-manifest.md` |
| Approval Status | `PENDING` |

**Changes Made**

Pending Human Review.

**Correction Notes**

No Human correction has been applied to A-022. The workflow stops before genuine screenshot capture and GitHub Issue creation.

**Human Decision Evidence**

Pending Human Review.

<!-- AUDIT_ENTRIES_END -->

## 4. Summary of AI Accuracy

<!-- AUDIT_SUMMARY_START -->

| Metric | Count | Percentage |
| --- | ---: | ---: |
| Total AI-generated artifacts audited | 18 | 100% |
| VALID — correct, accepted as-is | 15 | 83.33% |
| INVALID — wrong, rejected | 0 | 0% |
| INCOMPLETE — acceptable after edits | 3 | 16.67% |

Entries with `PENDING_HUMAN_REVIEW` are not included in finalized verdict totals.

<!-- AUDIT_SUMMARY_END -->

---

## 5. Backfill Gaps

- Interaction: HW06 Agent Skills setup immediately before this policy patch.
- Evidence: exact prompt/output remain visible in the session, but original timestamp is not verifiable from reliable evidence.
- Status: `BACKFILL_GAP`
- Reason: `TIMESTAMP_NOT_VERIFIABLE`
- Action: no Artifact ID was created and no content was reconstructed.

- Interaction: HW06 overnight completion after Human approval of the screenshot pipeline (GitHub Issue creation, CI workflow preparation, reusable-skill handoff, final readiness documents, and procedural commits).
- Evidence: the repository contains resulting artifacts, but no immutable repository-local export preserves the exact current-session prompt, complete verbatim assistant output, and trustworthy interaction timestamp together.
- Status: `BACKFILL_GAP`
- Reason: `PROMPT_CONTENT_MISSING`; `AI_OUTPUT_CONTENT_MISSING`; `TIMESTAMP_NOT_VERIFIABLE`
- Action: no Artifact ID was created, no historical content was reconstructed, and the screenshot-capture exception remains `AI_AUDIT_USED: NO`.

- Interaction: CI workflow correction after GitHub reported two push-triggered workflow failures with no jobs/log, followed by a manual-dispatch-only guard.
- Evidence: the resulting workflow commit and GitHub run URLs are preserved, but no immutable repository-local record contains exact current-session prompt/output/timestamp for a full per-artifact audit entry.
- Status: `BACKFILL_GAP`
- Reason: `PROMPT_CONTENT_MISSING`; `AI_OUTPUT_CONTENT_MISSING`; `TIMESTAMP_NOT_VERIFIABLE`
- Action: no Artifact ID was created and no run was relabelled as intentional or PASS; Human must create genuine CI evidence after setting the required secret.

- Interaction: final AI Critique wording correction to remove a prohibited Newman-failure phrase while preserving the business/state-oracle lesson.
- Evidence: the resulting Git commit preserves the artifact diff, but an immutable repository-local transcript of exact current-session prompt/output/timestamp is unavailable for a full per-artifact audit entry.
- Status: `BACKFILL_GAP`
- Reason: `PROMPT_CONTENT_MISSING`; `AI_OUTPUT_CONTENT_MISSING`; `TIMESTAMP_NOT_VERIFIABLE`
- Action: no Artifact ID was created; the correction does not alter execution history, defect classification, or any assertion count.

---

## 6. Conclusion — When Should AI Be Used or Not?

Pending final audit review.

---

## 7. Mandatory Disclosure

Pending student completion before submission.

---

## 8. Student Confirmation

Pending student completion before submission.
