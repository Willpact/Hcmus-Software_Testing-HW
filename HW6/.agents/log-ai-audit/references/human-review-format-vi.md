# Canonical Human Review Format

Đọc reference này khi thực hiện `UPDATE_REVIEW` hoặc finalize Human Review. Đây là internal generation reference; không thay thế course-provided template.

## Common Rules

- Giữ English cho section headings, subsection headings, table headers, field labels, status/enums, code/path và identifiers.
- Viết phần giải thích chủ yếu bằng tiếng Việt.
- Preserve `Evaluation Sources` hiện có.
- `Review Notes` là bullet list concrete.
- Không finalize nếu thiếu exact Human Decision evidence.
- Verdict đánh giá original AI output. Artifact sửa xong được `APPROVED` không biến original `INCOMPLETE` thành `VALID`.
- `UPDATE_REVIEW` replace/upsert `(3)-(5)` và ba subsections; không append duplicate.

## Verdict

```markdown
#### (3) Verdict

| Field         | Value       |
| ------------- | ----------- |
| Review Status | `FINALIZED` |
| Verdict       | `<VALID | INVALID | INCOMPLETE>` |
| Verdict Scope | `<SCOPE>`   |
```

## Reasoning

```markdown
#### (4) Reasoning

**Evaluation Sources**

<preserve actual source table>

**Review Notes**

* <AI làm đúng điểm nào, kèm evidence.>
* <AI sai/thiếu điểm nào, kèm evidence.>
* <Human Review phát hiện/sửa gì.>
* <Vì sao verdict phù hợp và downstream effect.>
```

## Student Fix

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

* <specific change hoặc xác nhận không cần change>

**Correction Notes**

<Giải thích quan hệ giữa original verdict và final artifact status.>

**Human Decision Evidence**

`<EXACT_DECISION>`
```

## VALID Variant

- `Student Decision: ACCEPTED_AS_IS`
- `Change Illustration: No change required.`
- `Verification Result: PASSED`
- `Approval Status: APPROVED`
- `Changes Made` xác nhận không đổi AI output và artifact được dùng downstream as-is.
- `Correction Notes` nêu không cần correction trong Verdict Scope.

## INCOMPLETE Variant

- `Student Decision: MODIFIED`
- `Change Illustration: See **Changes Made** below.`
- `Verification Result: PASSED`
- `Approval Status: APPROVED`
- Liệt kê từng Human-directed correction.
- `Correction Notes`: AI output ban đầu cần Human-directed correction nên original verdict giữ `INCOMPLETE`; artifact sau sửa đã được review lại và `APPROVED` downstream.

## INVALID Variant

- `Student Decision: REJECTED`
- `Change Illustration: See **Changes Made** below.`
- `Approval Status: REJECTED`
- `Changes Made` ghi artifact bị loại khỏi final use và replacement/reselection nếu có.
- `Correction Notes` giải thích vì sao original output không được dùng.

## Verification Methods

- `REVIEW`: đọc/đối chiếu design/report.
- `STATIC_REVIEW`: verify generated JMX/CSV/source/config.
- `EXECUTION_EVIDENCE_REVIEW`: verify real execution artifacts.
- `RAW_JTL_VERIFICATION`: verify metrics trực tiếp từ raw JTL.
