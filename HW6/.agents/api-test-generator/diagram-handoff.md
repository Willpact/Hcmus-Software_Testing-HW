# Agent Skill diagram handoff — COMPLETED

`AGENT_SKILL_DIAGRAM: COMPLETE`

## Final Human-created artifact

[Figure — Workflow of the reusable AI-driven API Test Generator Agent Skill](../../docs/agent-skill/api-test-generator-diagram.png) là sơ đồ final do Human tạo/export bằng Mermaid.io. File này chỉ giữ design handoff gốc để traceability; không thay thế hoặc tái tạo hình final.

## Nodes cần vẽ

1. **API Specification** — input bắt buộc.
2. **Specification reader** — gắn nhãn `AUTHORITATIVE_REQUIREMENT`, `SUPPORTING_INFORMATION`, `IMPLEMENTATION_OBSERVATION`.
3. **Analysis modules** — sáu nhánh: Domain partition, Boundary, State transition, Security, Schema, Business rule.
4. **Candidate builder** — canonical draft cases, stable provisional ID và requirement traceability.
5. **Deduplication** — behavioral fingerprint; giữ provenance.
6. **Coverage check** — requirement/technique coverage và gap.
7. **Human review checkpoint** — `GENERATOR_OUTPUT_REVIEW_REQUIRED`.
8. **Structured candidate test cases** — output, không phải approved testcase hay execution evidence.

## Connections và labels

- `API Specification → Specification reader`: **read + classify evidence**.
- `Specification reader → Analysis modules`: **resolved requirements / explicit ambiguities**.
- `Analysis modules → Candidate builder`: **test conditions**.
- `Candidate builder → Deduplication`: **canonical draft cases**.
- `Deduplication → Coverage check`: **unique candidates + provenance**.
- `Coverage check → Human review checkpoint`: **coverage/gaps**.
- `Human review checkpoint → Structured candidate test cases`: **only after Human decision**.
- Thêm một mũi tên hồi tiếp từ checkpoint về Specification reader với nhãn **clarification or correction**.

## Layout đề xuất

Vẽ theo chiều trái sang phải, dùng một swimlane `AI-assisted generation` cho bước 2–6 và một lane riêng `Human control` cho checkpoint. Đặt output ở mép phải. Dùng đường viền nét đứt hoặc ghi chú dưới output: `Not execution evidence; not auto-approved`.

## Tiêu chí tự kiểm trước khi nộp hình

- Có đủ tám node, sáu technique và mũi tên hồi tiếp.
- Phân biệt requirement với implementation observation.
- Chỉ Human review mới nối sang output usable.
- Không vẽ AI như một thành phần tự quyết định PASS/FAIL hoặc Product Defect.
