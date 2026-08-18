---
name: log-ai-audit
description: Tạo và duy trì AI Audit Report theo FIT@HCMUS 5-section Template per Artifact cho HW06 API Testing, lưu verbatim prompt/output, human verdict, student fix và verification mà không sửa các artifact kiểm thử khác.
---

# log-ai-audit

## 1. Skill Name

`log-ai-audit`

## 2. Primary Objective

Tạo và duy trì:
`docs/ai-audit/AI_AUDIT_LOG.md`

theo FIT@HCMUS 5-section Template per Artifact.

Skill phải:

- dùng Markdown;
- giữ exact English section headings/field names/status labels;
- lưu verbatim prompts và AI outputs;
- một entry cho mỗi AI-generated artifact hoặc meaningful prompt-output interaction;
- lưu human verdict riêng với Student Fix;
- tự tính summary;
- không fabricate audit data.

## 3. Scope

Skill chỉ được đọc/ghi trong:

- `docs/ai-audit/`
- `docs/ai-audit/interactions/`

Template source có thể đọc từ:

- `templates/AI_Audit_Report_Template_EN.md`
- `references/human-review-format-vi.md` khi thực hiện `UPDATE_REVIEW` hoặc finalizing Human Review.

Template chỉ được sửa khi user explicitly authorizes template modification.

Skill **không được sửa**:

- test cases;
- automation plans;
- test data;
- Playwright scripts;
- SUT source;
- Git history;
- unrelated docs.

### Chính sách scope HW06

Trước `INITIALIZE_AUDIT`, `CREATE_ENTRY` hoặc `UPDATE_REVIEW`, phân loại interaction theo output thực tế, không chỉ theo tên Agent Skill:

| `AUDIT_SCOPE` | Khi nào áp dụng | Hành động |
|---|---|---|
| `INCLUDED_HW06_ARTIFACT_INTERACTION` | AI trực tiếp tạo, phân tích, review hoặc sửa artifact/kết quả dùng cho bài HW06: requirement/API analysis, API test design, Postman collection/environment/data, Newman output/failure analysis, confirmed bug report candidate, AI-driven API test-generator design hoặc submission report/draft. | Ghi per-artifact entry khi có exact timestamp, verbatim prompt và verbatim output. |
| `EXCLUDED_AGENT_SKILL_DEVELOPMENT` | AI tạo/sửa/repair `SKILL.md`, script/tooling skill, smoke/contract test, synthetic `TEST-ONLY` fixture, orchestration integration chỉ nhằm validate implementation skill, hay meta-discussion về Agent Skill. | Không tạo Artifact ID và không tạo audit entry. Đây không có nghĩa interaction không dùng AI; chỉ nằm ngoài per-artifact audit scope. |

Phân biệt bắt buộc: một Agent Skill được **phát triển** là excluded; chính skill đó được **invoke để tạo artifact HW06 thực** là included. Ví dụ, smoke test bằng fixture tổng hợp là excluded, còn test design hoặc Postman collection cho API HW06 là included theo artifact tương ứng.

Khi khởi tạo HW06 audit log, thêm scope note sau, không coi note là artifact entry:

> Per-artifact audit entries focus on AI interactions that directly produced, analysed, reviewed, or modified HW06 assignment artifacts and results. Agent Skill implementation, maintenance, repair, smoke-testing, and other tooling-development interactions are excluded from individual audit entries.

### Safe backfill

Chỉ backfill `INCLUDED_HW06_ARTIFACT_INTERACTION` nếu phục hồi được đồng thời exact timestamp, verbatim prompt và verbatim AI output từ transcript/evidence đáng tin cậy. Không reconstruct hoặc paraphrase. Thiếu một trong ba thì ghi `BACKFILL_GAP` ngoài `AUDIT_ENTRIES` với reason `PROMPT_CONTENT_MISSING`, `AI_OUTPUT_CONTENT_MISSING` hoặc `TIMESTAMP_NOT_VERIFIABLE`; gap không nhận Artifact ID.

## 4. Recommended Workflow Position

Nên initialize audit **trước artifact AI đầu tiên** của project/workflow.

Recommended order:

1. `INITIALIZE_AUDIT`
2. `CREATE_ENTRY`
3. Human review
4. `UPDATE_REVIEW`
5. Optional `ADD_CORRECTION_NOTE`
6. `FINALIZE_AUDIT`

Audit failure không được tự động sửa hoặc thay đổi artifact kiểm thử.

## 5. Required Structural Markers

Current-format audit log phải chứa:

```text
<!-- AUDIT_ENTRIES_START -->
<!-- AUDIT_ENTRIES_END -->
<!-- AUDIT_SUMMARY_START -->
<!-- AUDIT_SUMMARY_END -->
```

Markers phải:

- tồn tại đúng cặp;
- đúng thứ tự;
- không duplicate.

## 6. Initialization Behavior

Operation:
`INITIALIZE_AUDIT`

Nếu log chưa tồn tại:

1. đọc template;
2. request missing Student Information;
3. nếu thiếu:
   `AUDIT_INITIALIZATION_INFORMATION_REQUIRED`
4. tạo log;
5. preserve all markers;
6. không tạo fake artifact entry;
7. return:
   `AUDIT_LOG_INITIALIZED`

Nếu log đã tồn tại:

- không duplicate header;
- không duplicate Student Information;
- validate markers;
- không rewrite lịch sử.

## 7. Existing Log Classification

Khi log tồn tại, classify:

### Current format + markers valid

Tiếp tục bình thường.

### Current format nhưng marker bị thiếu/hỏng

Return:
`AUDIT_MARKER_MISSING`

Không append mù.

Tạo repair plan nhưng không sửa cho tới khi user approve:
`APPROVE AUDIT MARKER REPAIR`

### Legacy format

Nếu structure khác template hiện tại:
`LEGACY_AUDIT_FORMAT_DETECTED`

Không rewrite.

Tạo migration plan và chờ:
`APPROVE AI AUDIT FORMAT MIGRATION`

Missing marker **không đồng nghĩa** legacy format.

## 8. Supported Operations

### `INITIALIZE_AUDIT`

Khởi tạo hoặc validate current log.

### `CREATE_ENTRY`

- xác minh `AUDIT_SCOPE: INCLUDED_HW06_ARTIFACT_INTERACTION`; excluded interaction dừng tại classification, không cấp Artifact ID;
- next unique Artifact ID;
- insert trước `AUDIT_ENTRIES_END`;
- preserve prompt/output;
- default Review Status:
  `PENDING_HUMAN_REVIEW`
- recalculates summary only from finalized entries.

### `UPDATE_REVIEW`

Chỉ finalize khi có exact Human Decision evidence. Nếu thiếu, giữ `Review Status: PENDING_HUMAN_REVIEW` và báo evidence còn thiếu. Khi đủ evidence, update:

- Verdict
- Verdict Scope
- Reasoning
- Student Fix
- Verification
- Approval Status

Không alter original prompt/output.

Áp dụng **REPLACE/UPSERT semantics** trong đúng Artifact ID block:

1. Locate block từ `### Artifact <ID>` tới Artifact kế tiếp hoặc `AUDIT_ENTRIES_END`.
2. Replace nội dung hiện có của đúng một section `(3)`, `(4)`, `(5)`; không append section/subsection duplicate.
3. Trong `(4)` preserve `Evaluation Sources`, replace/upsert đúng một `Review Notes`.
4. Trong `(5)` replace/upsert đúng một `Changes Made`, `Correction Notes`, `Human Decision Evidence`.
5. Validate mỗi heading/subheading xuất hiện đúng một lần trong entry sau update.

### `ADD_CORRECTION_NOTE`

Append timestamped note.
Không xóa verdict/fix cũ.

### `ATTACH_EXTERNAL_OUTPUT`

Store long output ở:

- `docs/ai-audit/interactions/<artifact-id>-prompt.md`
- `docs/ai-audit/interactions/<artifact-id>-output.md`

Verify file tồn tại.

### `REPAIR_MARKERS`

Chỉ sau:
`APPROVE AUDIT MARKER REPAIR`

Rules:

- backup log first trong `docs/ai-audit/backups/`;
- repair markers tối thiểu;
- không rewrite entries;
- không renumber Artifact IDs;
- validate structure sau repair.

### `FINALIZE_AUDIT`

Validate toàn bộ document.

## 9. Required Artifact Entry Format

### (1) Prompt + Tool

Exact labels:

- Tool
- Model
- Date and Time
- Workflow Stage
- Feature / Task
- Related Artifact
- Verbatim Prompt

### (2) AI Output

Exact labels:

- Output Storage
- Full Output / Evidence Path
- Verbatim AI Output or Labelled Excerpt

Output Storage:

- `INLINE`
- `EXTERNAL_FILE`
- `SCREENSHOT_REFERENCE`

### (3) Verdict

Canonical finalized layout:

```markdown
#### (3) Verdict

| Field         | Value       |
| ------------- | ----------- |
| Review Status | `FINALIZED` |
| Verdict       | `<VERDICT>` |
| Verdict Scope | `<SCOPE>`   |
```

- Allowed Verdict: `VALID`, `INVALID`, `INCOMPLETE`.
- Before exact Human Decision evidence: `Review Status = PENDING_HUMAN_REVIEW`, Verdict blank, không finalize.
- Existing legacy entry dùng `COMPLETED` có thể được tính là finalized nếu đủ verdict/evidence; không rewrite chỉ vì cosmetic style. Mọi newly-finalized entry dùng `FINALIZED`.

### (4) Reasoning

Giữ English headings/labels: `#### (4) Reasoning`, `Evaluation Sources`, `Review Notes`. Preserve source table hiện có. `Review Notes` bắt buộc là bullet list, body chủ yếu bằng tiếng Việt và concrete:

- AI làm đúng điểm nào;
- sai/thiếu/fragile/unsupported gì;
- Human Review phát hiện/sửa gì;
- vì sao chọn verdict;
- downstream effect nếu relevant.

Không bịa citation/ISTQB/RFC/execution result.

Không có evaluation source:
`AUDIT_REASONING_SOURCE_REQUIRED`

### (5) Student Fix

Canonical table:

```markdown
#### (5) Student Fix

| Field               | Value                       |
| ------------------- | --------------------------- |
| Student Decision    | `<DECISION>`                |
| Change Illustration | See **Changes Made** below. |
| Verification Method | `<METHOD>`                  |
| Verification Result | `PASSED`                    |
| Final File          | `<PATH>`                    |
| Approval Status     | `<STATUS>`                  |

**Changes Made**

* ...

**Correction Notes**

...

**Human Decision Evidence**

`<EXACT_DECISION>`
```

Body của `Changes Made` và `Correction Notes` chủ yếu bằng tiếng Việt. Giữ English headings, table headers, enums, technical names, code/path/identifiers.

Student Decision:

- `ACCEPTED_AS_IS`
- `MODIFIED`
- `REJECTED`

Verification Result:

- `PASSED`
- `FAILED`
- `NOT_EXECUTED`
- `NOT_APPLICABLE`

Approval Status:

- `PENDING`
- `APPROVED`
- `REJECTED`
- `DEFERRED`

Preferred Verification Method:

- `REVIEW`: Human đọc/đối chiếu design/report.
- `STATIC_REVIEW`: verify JMX/CSV/source/config tĩnh.
- `EXECUTION_EVIDENCE_REVIEW`: verify real execution artifacts.
- `RAW_JTL_VERIFICATION`: verify metric trực tiếp từ raw JTL.

`Change Illustration` dùng `See **Changes Made** below.` khi có từ hai changes; chỉ inline khi đúng một change ngắn. Mọi finalized entry phải có exact `Human Decision Evidence`; không paraphrase. Đọc `references/human-review-format-vi.md` để dùng canonical variants `VALID`, `INCOMPLETE`, `INVALID`.

## 10. Verdict Semantics

Verdict đánh giá **AI output tại thời điểm review**, không phải trạng thái cuối của artifact sau khi sửa.

Ví dụ:

- AI output ban đầu thiếu/sai một phần → `INCOMPLETE`
- Student sửa → `Student Decision: MODIFIED`
- Review lại đạt → `Verification Result: PASSED`
- Final artifact approved → `Approval Status: APPROVED`

Không đổi `INCOMPLETE` thành `VALID` chỉ vì correction sau đó đã pass.

Final artifact `APPROVED` sau correction và original AI verdict `INCOMPLETE` là trạng thái hợp lệ, không mâu thuẫn.

Nếu output ban đầu đúng và accepted as-is:

- Verdict `VALID`
- Student Decision `ACCEPTED_AS_IS`

Nếu output sai và bị reject:

- Verdict `INVALID`
- Student Decision `REJECTED`

## 11. Verbatim Content Rules

Prompt/output phải giữ nguyên:

- không paraphrase;
- không translate;
- không sửa spelling;
- không shorten nếu chưa lưu full external copy.

Main log có thể chứa excerpt nếu:

- full prompt/output đã lưu external;
- exact path được ghi rõ.

Không overwrite rejected/old AI output.

## 12. Artifact ID Rules

- sequential: `A-001`, `A-002`, ...
- không reuse;
- không renumber historical entries;
- duplicate → `DUPLICATE_ARTIFACT_ID`

Một revision có thể:

- update cùng artifact nếu là correction trực tiếp của chính output đó; hoặc
- tạo artifact mới nếu là meaningful new prompt-output interaction độc lập.

Không tạo artifact giả chỉ để tăng số lượng audit.

## 13. Summary Calculation

Summary:

| Metric                               | Count | Percentage |
| ------------------------------------ | ----: | ---------: |
| Total AI-generated artifacts audited |     N |       100% |
| VALID — correct, accepted as-is      |     N |         N% |
| INVALID — wrong, rejected            |     N |         N% |
| INCOMPLETE — acceptable after edits  |     N |         N% |

Formula:
`Percentage = verdict count / total finalized artifacts × 100`

Rules:

- chỉ finalized verdicts;
- exclude `PENDING_HUMAN_REVIEW`;
- round 2 decimals;
- total 0 → `0%`;
- không hardcode.

Update content giữa:
`AUDIT_SUMMARY_START`
và
`AUDIT_SUMMARY_END`

## 14. Conclusion Rules

Chỉ generate/rewrite khi:

- `FINALIZE_AUDIT`; hoặc
- user explicitly requests.

Length:
80–150 words.

Phải cover:

- AI strengths;
- AI weaknesses;
- recurring patterns;
- recommendations.

## 15. Mandatory Disclosure

Preserve template disclosure text.

Không tự fill bracketed placeholders.

Finalization phải detect unresolved placeholders.

## 16. Marker Repair Policy

Khi `AUDIT_MARKER_MISSING`:

1. không append;
2. inspect current structure;
3. distinguish marker damage vs legacy format;
4. produce exact repair plan;
5. wait for approval;
6. backup;
7. minimal repair;
8. validate;
9. continue requested audit operation nếu user vẫn muốn.

Không để audit-marker issue tự động sửa test/automation artifacts.

`Can Continue` field phải chỉ rõ:

- audit operation có bị block không;
- unrelated automation workflow có thể tiếp tục hay không.

## 17. Finalization Checks

`FINALIZE_AUDIT` kiểm tra:

- Student Information;
- required headings;
- all markers;
- sequential unique IDs;
- pending entries;
- invalid verdict/status;
- missing evaluation source;
- missing Student Fix;
- missing Verdict Scope trong finalized/newly-finalized entry;
- missing hoặc duplicate `Review Notes`, `Changes Made`, `Correction Notes`, `Human Decision Evidence`;
- Human Decision Evidence không exact hoặc không có nguồn;
- summary accuracy;
- unresolved placeholders;
- broken external file refs;
- conclusion length;
- disclosure;
- confirmation;
- references.

Nếu fail:
`AUDIT_FINALIZATION_BLOCKED`

## 18. Required Status Response Shape

Mỗi status response phải có:

- Status
- Artifact ID (nếu applicable)
- Description
- Affected File
- Required User Action
- Can Continue

## 19. Supported Statuses

- `EXISTING_SKILL_NOT_FOUND`
- `AUDIT_INITIALIZATION_INFORMATION_REQUIRED`
- `AUDIT_LOG_NOT_FOUND`
- `AUDIT_LOG_INITIALIZED`
- `AUDIT_ENTRY_RECORDED`
- `AUDIT_ENTRY_UPDATED`
- `AUDIT_ENTRY_NOT_FOUND`
- `DUPLICATE_ARTIFACT_ID`
- `AUDIT_ENTRY_INCOMPLETE`
- `AUDIT_REVIEW_PENDING`
- `AUDIT_REASONING_SOURCE_REQUIRED`
- `PROMPT_CONTENT_MISSING`
- `AI_OUTPUT_CONTENT_MISSING`
- `INVALID_TIMESTAMP`
- `INVALID_VERDICT`
- `INVALID_VERIFICATION_RESULT`
- `INVALID_APPROVAL_STATUS`
- `EXTERNAL_OUTPUT_FILE_MISSING`
- `AUDIT_MARKER_MISSING`
- `AUDIT_MARKER_REPAIR_REQUIRED`
- `AUDIT_MARKERS_REPAIRED`
- `AUDIT_SUMMARY_UPDATED`
- `LEGACY_AUDIT_FORMAT_DETECTED`
- `AUDIT_FINALIZATION_BLOCKED`
- `AUDIT_FINALIZED`

## 20. Safety Rules

Skill không được:

- fabricate prompt;
- fabricate AI output;
- fabricate timestamp;
- fabricate verdict;
- fabricate evaluation source;
- fabricate execution evidence;
- fabricate Student Fix;
- alter historical entry để che sai;
- overwrite legacy log chưa approve;
- repair marker chưa approve;
- remove rejected output;
- store secrets;
- sửa files ngoài `docs/ai-audit/`;
- sửa test cases;
- sửa test data;
- sửa automation scripts;
- sửa SUT;
- commit/rewrite Git history.

## 21. Acceptance Criteria

Skill hợp lệ khi:

- current-format log có markers đúng;
- verbatim prompt/output được preserve;
- verdict semantics đúng;
- Student Fix tách khỏi verdict;
- newly-finalized Human Review theo canonical `(3)-(5)` format và body giải thích chủ yếu bằng tiếng Việt;
- `UPDATE_REVIEW` không tạo duplicate section/subsection;
- không finalize nếu thiếu exact Human Decision evidence;
- summary chỉ tính finalized entries;
- marker damage và legacy format được phân biệt;
- có backup trước marker repair;
- không sửa artifact ngoài audit scope;
- finalization detect pending/missing fields;
- không fabricate.

## 22. Example — Modified Artifact

```text
Verdict: INCOMPLETE

Student Decision: MODIFIED
Verification Method: REVIEW
Verification Result: PASSED
Approval Status: APPROVED
```

Ý nghĩa:
AI output ban đầu cần chỉnh sửa, student đã sửa và final artifact đã được verify/approve.

## 23. Related Skills

Có thể audit outputs từ:

- `generate-test-cases-from-requirements`
- `playwright-feature-workflow`
- `validate-hw04-submission`

Skill không gọi tự động các skill khác.
