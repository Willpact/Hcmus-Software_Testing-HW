# HW06 submission readiness

## Phạm vi audit

Bảng đối chiếu evidence và deliverable đang tồn tại theo bộ requirement HW06 đã được Human xác nhận. Không suy diễn yêu cầu ngoài bộ requirement này.

| Requirement | Expected artifact/evidence | Actual artifact | Status | Notes |
| --- | --- | --- | --- | --- |
| Assignment requirement reconciliation | Bộ requirement HW06 đã được Human xác nhận | `docs/final/HW06-SUBMISSION-CHECKLIST.md` | `PASS` | Table requirement → evidence → status được đối chiếu từ artifact thật. |
| 3 API selection | API-01/02/03 requirement analysis | `docs/requirement-analysis/` | `PASS` | Password Reset, Checkout, Import Products. |
| AI-generated test target | Generation artifact/traceability | `docs/test-generation/`, `test-cases/generated/` | `PASS` | Stable IDs được giữ. |
| Human Audit of generated tests | Audit và final cases | `docs/test-audit/`, `test-cases/final/` | `PASS` | Không thay bằng AI approval. |
| Student-added tests | Canonical cases | `test-cases/student-added/` | `PASS` | 15 case; không regenerate history. |
| Postman collection/environment | Collection + secret-free environment | `postman/collections/`, `postman/environments/` | `PASS` | Không expose runtime credential. |
| X-Student-Id requirement | Validation/manifest | `docs/postman/static-validation-report.json` | `PASS` | Giá trị không được expose. |
| Newman execution artifacts | Preserved run evidence + secret-safe delivery derivative | `test-results/hw06/run-001/`, `run-002/`; `docs/execution-results/redacted-newman/` | `PASS` | Không rerun; cả hai có 0 assertion failure. Source gốc giữ nguyên, ZIP dùng derivative redacted có hash manifest. |
| Business/state verification | External JSON/read-only SQLite evidence | `docs/defects/evidence-matrix.md` | `PASS` | Phân biệt với Newman. |
| Defect reports | 9 root-defect report | `docs/defects/DEF-*.md` | `PASS` | Không đổi root cause/classification. |
| Genuine screenshots | Valid, secret-safe PNG | `docs/defects/screenshots/` | `PASS` | 17 ảnh: 9 request/response + 8 state. |
| GitHub Issues | 9 issue number/URL target repo | `docs/defects/github-issue-readiness.md` | `PASS` | `DuyITLOR/group05_eshop` #393–#401. |
| CI/CD workflow | Workflow + procedure | `docs/ci/hw06-ci-cd.md` | `PASS` | Workflow clean-runner và intentional-fail design đã được chứng minh bằng run genuine. |
| PASS CI run | Genuine run URL/ID + artifact metadata | [#32660557339](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660557339), `hw06-ci-32660557339` | `PASS` | `normal`: 179 request, 116 assertion, 0 assertion failure, GitHub `success`. |
| Intentional FAIL CI run + restored healthy | Genuine run URL/ID + artifact metadata | [#32660601543](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660601543), [#32660658460](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660658460) | `PASS` | Intentional: exactly 1 Newman assertion failure, not configuration error; final normal run is 179/116/0 and `success`. |
| Agent Skill | Reusable skill | `.agents/api-test-generator/SKILL.md` | `PASS` | Có purpose/input/output/workflow/validation/pseudocode/demo/limitations. |
| Human-drawn Agent Skill diagram | Student-created diagram | `docs/agent-skill/api-test-generator-diagram.png`; `.agents/api-test-generator/diagram-handoff.md` | `PASS` | Human-created/exported Mermaid.io artifact; không do AI tạo hoặc redesign. |
| Agent Skill demonstration (encouraged) | Reusable skill demo link | [YouTube demo](https://youtu.be/HodItPORCTw) | `PASS` | `HW06 API Testing – Reusable API Test Generator Agent Skill Demo`; không được coi là requirement bắt buộc. |
| AI Critique | 200–300 word HW06-specific critique | `docs/final/AI-CRITIQUE.md` | `PASS` | Đã kiểm word count và scope. |
| AI Audit | Append-only log + Human decisions | `docs/ai-audit/AI_AUDIT_LOG.md`, `docs/final/hw06-human-audit-review-packet.md` | `PASS` | 22 entry finalized (19 VALID, 0 INVALID, 3 INCOMPLETE; 0 pending); Student Information/disclosure/confirmation và A-010 enum note đã có. |
| Excel/testcase export | Test Cases + Test Summary workbook | `docs/final/HW06-Test-Cases-and-Summary.xlsx` | `PASS` | 93 final testcase; 69/4/47 raw audit, 9 primary mappings đối chiếu 9/9 với evidence matrix, 38 evidence testcase record cho 9 defect. |
| Main final report | Narrative Việt, Markdown + PDF | `docs/final/HW06-MAIN-REPORT.md`, `docs/final/HW06-MAIN-REPORT.pdf` | `PASS` | Đã cập nhật three-run CI evidence; Human vẫn cần visual review trước nộp. |
| README/self-assessment | Root README | `README.md` | `PASS` | Link report, counts và limitation. |
| Self-assessed grade/archive name | Student-selected value | `SelfAssessedGrade = 100`; `23127107_HW06_AI_API_100.zip` | `PASS` | Human đã chọn `100/100`; không hạ điểm theo agent estimation. |
| Procedural commits | Logical commits sau Human review | Git history/working tree | `HUMAN_ACTION_REQUIRED` | Current task cấm commit/stage/push. |
| Git log export | Current HW06 commit log | `docs/final/HW06-GIT-COMMIT-LOG.md` | `PASS` | Read-only export; Human refresh sau final commit nếu có commit mới. |
| Secret scan | Scan delivery surface trước submit | `docs/final/HW06-SECRET-SCAN.md`, `docs/execution-results/redacted-newman/REDACTION-MANIFEST.md` | `HUMAN_ACTION_REQUIRED` | ZIP/final staging an toàn dùng redacted derivative. Raw historical Newman reports có JWT/request credential, phải tiếp tục bị loại khỏi ZIP; Human quyết định rotation/lịch sử theo policy repository. |

## Kết luận

`SUBMISSION_READINESS: 93% (25/27 PASS)`. Evidence defect, issue mapping, Excel workbook, main report hai định dạng, three-run CI evidence, AI Audit, Human-created Agent Skill diagram và demo video đã tồn tại thật. Hạng mục `HUMAN_ACTION_REQUIRED` là secret handling cho raw historical Newman reports, procedural final commit/log refresh và final visual/submission review; không phải thiếu execution evidence.
