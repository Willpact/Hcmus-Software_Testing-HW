# HW06 submission readiness

## Phạm vi audit

Assignment brief gốc không có trong workspace tại thời điểm audit. Bảng này đối chiếu theo các yêu cầu được nêu trong workflow HW06 hiện có và yêu cầu overnight run; những mục phụ thuộc rubric gốc không được tự đánh `PASS`.

| Requirement | Expected artifact/evidence | Actual artifact | Status | Notes |
| --- | --- | --- | --- | --- |
| Assignment brief/rubric | Bản đề gốc có thể truy xuất | Không tìm thấy trong HW6 hoặc thư mục cha | `BLOCKED` | Human cần đặt/link assignment gốc trước final packaging. |
| 3 API selection | API-01/02/03 requirement analysis | `docs/requirement-analysis/` | `PASS` | Ba API được xác định rõ. |
| AI-generated test target | AI test-generation artifacts | `docs/test-generation/` | `PASS` | Giữ stable IDs và traceability. |
| Human Audit of generated tests | Audit packets và human review | `docs/test-audit/`, `docs/test-extension/` | `PASS` | Không thay thế bằng AI approval. |
| Student-added tests | Canonical student-added cases | `test-cases/student-added/` | `PASS` | Không regenerate trong overnight run. |
| Postman collection/environment | Collection và secret-free example environment | `postman/collections/`, `postman/environments/HW06-Local.example.postman_environment.json` | `PASS` | Runtime credentials không thuộc deliverable commit. |
| X-Student-Id requirement | Static validation/manifest | `docs/postman/static-validation-report.json`, `docs/postman/execution-manifest.md` | `PASS` | Giá trị không được expose. |
| Newman execution artifacts | Genuine run-001/run-002 JSON/HTML | `test-results/hw06/run-001/`, `test-results/hw06/run-002/` | `PASS` | Không rerun; cả hai có zero assertion failure. |
| Business/state verification | External JSON và read-only SQLite evidence | `docs/defects/evidence-matrix.md` | `PASS` | Evidence quyết định được phân biệt với Newman. |
| Defect reports | 9 confirmed root-defect reports | `docs/defects/DEF-*.md` | `PASS` | Không đổi root cause/classification. |
| Genuine screenshots | Valid PNG, safe terminal capture | `docs/defects/screenshots/` | `PASS` | 17 ảnh: 9 request/response + 8 external/state. |
| GitHub Issues | 9 online issue URL/number | `docs/defects/github-issue-readiness.md` | `PASS` | Issues #6–#14 đã tạo sau khi evidence được push. |
| CI/CD workflow | GitHub Actions workflow và run URLs | `.github/workflows/hw06-api-newman.yml`, `docs/ci/hw06-ci-cd.md` | `PARTIAL` | Workflow ready; needs runtime secret and genuine runs. |
| PASS CI run | Run URL/ID | Chưa có | `HUMAN_ACTION_REQUIRED` | Không fabricate. |
| Intentional FAIL CI run | Run URL/ID + restored healthy state | Chưa có | `HUMAN_ACTION_REQUIRED` | Chỉ temporary workflow dispatch; final mode phải `normal`. |
| Agent Skill | Reusable generator skill | `.agents/api-test-generator/SKILL.md` | `PASS` | Có purpose/input/output/workflow/validation/pseudocode/limitations. |
| Human-drawn Agent Skill diagram | Student-created diagram | `diagram-handoff.md` only | `HUMAN_ACTION_REQUIRED` | AI không tạo final diagram. |
| AI Critique | 200–300 words, HW06-specific | `docs/final/AI-CRITIQUE.md` | `PASS` | Nêu Human Audit, zero Newman failure và state oracle. |
| AI Audit | Append-only valid final audit | `docs/ai-audit/AI_AUDIT_LOG.md` | `PARTIAL` | Existing pending Human reviews and overnight interaction need final audit handling. |
| Procedural commits | Explicit logical commits | Git history | `PARTIAL` | Working tree contains uncommitted HW6 material. |
| Git log export | `git-commit-log-hw6.txt` | Chưa có | `HUMAN_ACTION_REQUIRED` | Chỉ export sau audit-final commit. |
| Final report/export | Assignment-aligned final report/export | `test-cases/final/`; no rubric-aligned final report | `PARTIAL` | Testcase export exists; report structure needs original assignment. |
| Secret scan | No secret in committed/docs screenshot surface | Capture whitelist + final pre-commit scan | `PARTIAL` | Screenshot/parser check pass; full staged-surface scan required before commit. |

## Kết luận

`SUBMISSION_READINESS: PARTIAL`. Evidence defect đã complete, nhưng online GitHub Issues, genuine CI runs, Human-drawn diagram, audit finalization, procedural commits và rubric-aligned packaging chưa có genuine completion evidence.
