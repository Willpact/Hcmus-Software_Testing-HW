# HW06 — API Testing

Artifact submission cho HW06 API Testing của EShop. Báo cáo chính: [docs/final/HW06-MAIN-REPORT.md](docs/final/HW06-MAIN-REPORT.md).

## Repository và demo Agent Skill

- Primary submission repository: [https://github.com/Willpact/Hcmus-Software_Testing-HW](https://github.com/Willpact/Hcmus-Software_Testing-HW). Repository này chứa toàn bộ artifact nộp HW06.
- SUT / GitHub Issues repository: [https://github.com/DuyITLOR/group05_eshop](https://github.com/DuyITLOR/group05_eshop). Repository này chỉ là đích SUT và 9 HW06 defect Issue, không phải nơi chứa artifact nộp HW06.
- Reusable `api-test-generator` demonstration: [HW06 API Testing – Reusable API Test Generator Agent Skill Demo](https://youtu.be/HodItPORCTw). Video demo là artifact khuyến khích, không được diễn đạt là yêu cầu bắt buộc.

## Tóm tắt có thể kiểm chứng

| Hạng mục | Kết quả | Artifact |
| --- | ---: | --- |
| API được chọn | 3 | `docs/requirement-analysis/` |
| AI-generated candidates | 120 | `test-cases/generated/` |
| AI testcase sau Human Audit | 78 | `test-cases/final/` |
| Student-added testcase | 15 | `test-cases/student-added/` |
| Executable testcase | 93 | `docs/test-suite/final-executable-suite.md` |
| Postman request | 103 (gồm 10 setup helper) | `postman/`, `docs/postman/static-validation-report.json` |
| Newman execution artifact | `run-001`, `run-002` | Preserved sources: `test-results/hw06/`; secret-safe delivery copies: `docs/execution-results/redacted-newman/` |
| Newman assertion failure | 0 ở mỗi run | `docs/execution-results/cross-api-execution-summary.md` |
| Confirmed Product Defect | 9 | `docs/defects/DEF-*.md` |
| Genuine screenshot | 17 | `docs/defects/screenshots/` |
| GitHub Issue online | 9 (#393–#401) | `docs/defects/github-issue-readiness.md` |
| Excel test cases + test summary | 1 workbook | `docs/final/HW06-Test-Cases-and-Summary.xlsx` |
| Main report | Markdown + PDF | `docs/final/HW06-MAIN-REPORT.md`, `docs/final/HW06-MAIN-REPORT.pdf` |
| Git commit log | Read-only HW06 export | `docs/final/HW06-GIT-COMMIT-LOG.md` |

`FAIL` trong business/state outcome không đồng nghĩa Newman assertion failure. Defect được xác nhận bằng request/response artifact cùng business/state oracle hoặc external verification theo evidence matrix.

## Cấu trúc

- `postman/`: collection, example environment, data và hướng dẫn Postman.
- `test-cases/`: generated, Human-reviewed final và student-added testcase source.
- `test-results/hw06/`: artifact execution lịch sử, không được rewrite.
- `docs/defects/`: 9 defect report, evidence matrix, screenshot và GitHub issue draft/index.
- `docs/final/`: report, AI Critique, readiness và Human-only checklist.
- `.agents/api-test-generator/`: reusable Agent Skill và diagram handoff do Human tự vẽ.

## Self-assessment

`SelfAssessedGrade = 100` (`100/100`) do Human lựa chọn. Tên archive dự kiến: `23127107_HW06_AI_API_100.zip`.

Lý do tự đánh giá dựa trên artifact đã có: ba API được chọn; 120 raw AI candidate, Human AI Test Audit và 15 testcase do sinh viên bổ sung; 93 testcase executable; Postman/Newman và X-Student-Id integration; 9 defect cùng 17 screenshot genuine và 9 GitHub Issue; CI PASS → intentional đúng một testcase failure → PASS cuối; workbook Excel; reusable Agent Skill, pseudocode, diagram do Human tạo và video demo; AI Critique, AI Audit đã finalized (22 entry: 19 VALID, 0 INVALID, 3 INCOMPLETE), Git history evidence và báo cáo Markdown/PDF.

| Mục | Trạng thái | Ghi chú |
| --- | --- | --- |
| Self-assessed grade | `100/100` | `SelfAssessedGrade = 100`; archive dự kiến `23127107_HW06_AI_API_100.zip`. |
| Requirement/test design, Postman, Newman artifact, state verification, defects, screenshots và issue mapping | `PASS` | Có artifact thật được liên kết trong báo cáo. |
| GitHub Actions PASS + intentional FAIL + restored healthy state | `PASS` | [#32660557339](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660557339) `normal` 179/116/0; [#32660601543](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660601543) intentional đúng 1 failure; [#32660658460](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660658460) final healthy 179/116/0. |
| Agent Skill diagram | `PASS` | Human-created/exported Mermaid.io figure: `docs/agent-skill/api-test-generator-diagram.png`. |
| Agent Skill demo (encouraged) | `PASS` | [YouTube demonstration](https://youtu.be/HodItPORCTw) cho reusable `api-test-generator`. |
| AI Audit | `PASS` | 22 entry finalized (19 VALID, 0 INVALID, 3 INCOMPLETE; 0 pending); Student Information, Mandatory Disclosure, Student Confirmation và A-010 schema normalization đã hoàn tất. |
| Excel test cases + test summary | `PASS` | Workbook thật gồm 93 testcase, test summary và 9 defect. |
| Assignment-rubric conformance/final submission | `PASS` | Đã đối chiếu theo bộ requirement HW06 đã được Human xác nhận; final visual review vẫn được khuyến nghị trước khi đóng gói. |

Chi tiết readiness: `docs/final/hw06-submission-readiness.md`. Final checklist, manifest và secret scan: `docs/final/HW06-SUBMISSION-CHECKLIST.md`, `docs/final/HW06-SUBMISSION-MANIFEST.md`, `docs/final/HW06-SECRET-SCAN.md`.
