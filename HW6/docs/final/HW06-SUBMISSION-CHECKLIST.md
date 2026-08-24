# HW06 final submission checklist

Intended archive: `23127107_HW06_AI_API_100.zip`. Check marks below are based on repository artifacts and the final HW06 requirement set verified by Human on 2026-08-24. The sole unchecked gate is the final Human visual/procedural review before packaging.

## A. Student and submission identity

- [x] Student name: Nguyễn Huy Quân.
- [x] Student ID: `23127107`.
- [x] Class/Cohort: `23CLC (K23 – Chương trình Chất lượng cao)`.
- [x] Assignment: `HW06 — API Testing`.
- [x] Assignment date: `2026-08-24`.
- [x] Self-assessed grade: `100` (`SelfAssessedGrade = 100`).
- [x] Intended ZIP name: `23127107_HW06_AI_API_100.zip`.

## B. Main report

- [x] `docs/final/HW06-MAIN-REPORT.md` exists.
- [x] `docs/final/HW06-MAIN-REPORT.pdf` exists and is regenerated from the current Markdown.
- [x] Student Information is complete.
- [x] AI Audit and AI Critique are referenced.
- [x] Both GitHub repository links are present and distinguished.
- [x] Reusable Agent Skill YouTube demo link is present; the video is described as encouraged, not mandatory.
- [x] Human-created Agent Skill diagram is embedded and its provenance is accurately described.
- [x] Self-assessment `100/100` and intended ZIP name are present.
- [x] No current submission-facing placeholder was found.

## C. API testing scope

- [x] API-01 Pool A: `POST /api/reset-password`.
- [x] API-02 Pool B: `POST /api/checkout`.
- [x] API-03 Pool C: `POST /api/admin/import-products`.
- [x] 40 raw AI-generated candidates per API; 120 total.
- [x] AI Test Audit classification: 69 VALID / 4 INVALID / 47 INCOMPLETE.
- [x] Student-added cases: 5 per API, 15 total.
- [x] Final executable testcase identities: 93.

## D. Postman / Newman

- [x] Postman collection exists: `postman/collections/HW06-API-Testing.postman_collection.json`.
- [x] Safe environment/config artifacts exist under `postman/environments/`.
- [x] Structural validation records `X-Student-Id` coverage `103/103` without exposing its value.
- [x] Genuine runtime/header coverage evidence exists in the preserved execution artifacts; no value is reproduced here.
- [x] Newman HTML/JSON reports exist for `run-001` and `run-002`; archive dùng bản sao redacted xác định tại `docs/execution-results/redacted-newman/` để không đưa JWT/request credential lịch sử vào ZIP.
- [x] The documented local hostname is `http://localhost:3000`, and preserved runs are the assignment evidence.
- [x] Postman feature/validation documentation exists under `docs/postman/`.

## E. Defects

- [x] Exactly 9 distinct confirmed Product Defects.
- [x] Exactly 38 Product-Defect evidence testcase records; this is not described as 38 defects.
- [x] 17 genuine screenshots: 9 request/response and 8 external/state.
- [x] Screenshot secret check is PASS.
- [x] Nine verified GitHub Issues exist: [#393](https://github.com/DuyITLOR/group05_eshop/issues/393), [#394](https://github.com/DuyITLOR/group05_eshop/issues/394), [#395](https://github.com/DuyITLOR/group05_eshop/issues/395), [#396](https://github.com/DuyITLOR/group05_eshop/issues/396), [#397](https://github.com/DuyITLOR/group05_eshop/issues/397), [#398](https://github.com/DuyITLOR/group05_eshop/issues/398), [#399](https://github.com/DuyITLOR/group05_eshop/issues/399), [#400](https://github.com/DuyITLOR/group05_eshop/issues/400), [#401](https://github.com/DuyITLOR/group05_eshop/issues/401).
- [x] Report references defect documentation and the issue index.

## F. CI/CD

- [x] Repository-root workflow exists: `.github/workflows/hw06-api-newman.yml`.
- [x] Normal PASS: [#32660557339](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660557339), 179 requests / 116 assertions / 0 assertion failures.
- [x] Intentional failure: [#32660601543](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660601543), 180 requests / 117 assertions / exactly 1 Newman assertion failure.
- [x] Final healthy PASS: [#32660658460](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660658460), 179 requests / 116 assertions / 0 assertion failures.
- [x] CI report exists: `docs/ci/hw06-ci-cd.md`.
- [x] The intentional failure is testcase-level (`INTENTIONAL_FAILURE_VERIFIED`), not an infrastructure/configuration failure.

## G. Agent Skill

- [x] `.agents/api-test-generator/SKILL.md` exists.
- [x] Reusable design, canonical schema integration, pseudocode, validation and limitations exist.
- [x] Human-created diagram exists at `docs/agent-skill/api-test-generator-diagram.png` and is integrated into the report.
- [x] Demo link: [https://youtu.be/HodItPORCTw](https://youtu.be/HodItPORCTw).
- [x] Generator output requires Human Review and does not automatically execute APIs or declare Product Defects.

## H. AI requirements

- [x] AI Audit totals: 22 entries; 19 VALID; 0 INVALID; 3 INCOMPLETE; 0 pending Human Review.
- [x] Mandatory Disclosure and Student Confirmation are complete.
- [x] AI Critique is HW06-specific and 270 words (within 200–300 words).
- [x] No current audit placeholder remains; preserved historical prompt/output text is not treated as an unresolved submission state.

## I. Excel and supporting artifacts

- [x] `docs/final/HW06-Test-Cases-and-Summary.xlsx` exists.
- [x] Sheets `Test Cases`, `Test Summary` and `Defects` open successfully; no corrupted worksheet, broken formula or `#REF!` was found.
- [x] Testcase counts agree with the final report: 3 APIs; 120 raw AI candidates; 69 VALID / 4 INVALID / 47 INCOMPLETE; 93 executable identities; 15 Student-added cases; 9 defects and 38 evidence testcase records.
- [x] Primary-case mappings in sheet `Defects` are reconciled 9/9 with the authoritative `docs/defects/evidence-matrix.md`.
- [x] `docs/final/HW06-GIT-COMMIT-LOG.md` exists as current read-only history evidence.
- [x] README is updated.

## J. External links

- [x] Primary repository: [https://github.com/Willpact/Hcmus-Software_Testing-HW](https://github.com/Willpact/Hcmus-Software_Testing-HW).
- [x] SUT / GitHub Issues repository: [https://github.com/DuyITLOR/group05_eshop](https://github.com/DuyITLOR/group05_eshop).
- [x] Agent Skill demo: [https://youtu.be/HodItPORCTw](https://youtu.be/HodItPORCTw).
- [x] Three CI links and nine Issue links are listed above and in the linked evidence indexes.

## K. Final safety / integrity

- [x] `docs/final/HW06-SECRET-SCAN.md` xác nhận delivery/ZIP surface dùng redacted Newman derivatives không chứa JWT, GitHub PAT, Bearer value, password/reset-token value, API-key value hoặc `X-Student-Id` header value.
- [ ] Raw Newman report lịch sử có JWT/request credential và đã được loại khỏi ZIP/final staging; Human cần review `docs/execution-results/redacted-newman/REDACTION-MANIFEST.md` và quyết định xử lý lịch sử/rotation theo policy repository.
- [x] No tracked `.env` was found; runtime credential paths are excluded from the archive.
- [x] No fabricated screenshots or execution/CI evidence are claimed; genuine evidence locations are preserved.
- [x] No current submission-facing placeholder was found.
- [x] Agent Skill demo-output policy and diagram provenance are documented accurately.
- [x] Final report counts are internally consistent.

## L. Rubric reconciliation

| Requirement | Evidence | Status |
| --- | --- | --- |
| Exactly 3 APIs, one from Pools A/B/C | API-01 `POST /api/reset-password`, API-02 `POST /api/checkout`, API-03 `POST /api/admin/import-products`; `docs/requirement-analysis/` | `PASS` |
| AI-generated target >=35/API | `test-cases/generated/` and `test-cases/audited/cross-api-summary.json`: 40/API, 120 total | `PASS` |
| Partitions/state/security/schema coverage | Requirement-analysis and audited technique coverage in `test-cases/audited/cross-api-summary.json` | `PASS` |
| Human Audit labels every raw AI testcase | `docs/test-audit/`, `test-cases/audited/`: 69 VALID / 4 INVALID / 47 INCOMPLETE | `PASS` |
| Invalid/incomplete outputs handled | `test-cases/corrected/`, `test-cases/final/`, `docs/test-suite/final-executable-suite.md` | `PASS` |
| >=5 Student-written cases/API | `test-cases/student-added/`: 5/API, 15 total | `PASS` |
| Execute with Postman/Newman | `postman/`, `test-results/hw06/run-001/`, `test-results/hw06/run-002/` | `PASS` |
| Every request includes `X-Student-Id` | `docs/postman/static-validation-report.json` and preserved runtime evidence (without exposing value) | `PASS` |
| Defects, Issue links and genuine screenshots | `docs/defects/`, `docs/defects/github-issue-readiness.md`, 17 files in `docs/defects/screenshots/` | `PASS` |
| CI/CD with normal PASS, exactly-one-testcase FAIL, final PASS | `.github/workflows/hw06-api-newman.yml`, `docs/ci/hw06-ci-cd.md`, runs #32660557339/#32660601543/#32660658460 | `PASS` |
| Excel workbook and summary | `docs/final/HW06-Test-Cases-and-Summary.xlsx` | `PASS` |
| Main Markdown report and PDF | `docs/final/HW06-MAIN-REPORT.md`, `docs/final/HW06-MAIN-REPORT.pdf` | `PASS` |
| Public primary repository link | `README.md` and report: `https://github.com/Willpact/Hcmus-Software_Testing-HW` | `PASS` |
| Postman collection, Newman HTML and feature list | `postman/collections/`, `test-results/hw06/run-001/newman.html`, `run-002/newman.html`, `docs/postman/` | `PASS` |
| AI-driven API test generator design | `.agents/api-test-generator/SKILL.md` and references | `PASS` |
| Human-created Agent Skill diagram | `docs/agent-skill/api-test-generator-diagram.png`; provenance in report/handoff | `PASS` |
| Agent Skill pseudocode | `.agents/api-test-generator/SKILL.md` and `references/generator-design.md` | `PASS` |
| AI Critique (200–300 words) | `docs/final/AI-CRITIQUE.md` (270 words) | `PASS` |
| Mandatory AI Audit | `docs/ai-audit/AI_AUDIT_LOG.md`: 22 entries, 19 VALID / 0 INVALID / 3 INCOMPLETE, 0 pending | `PASS` |
| Git history / text git log | `docs/final/HW06-GIT-COMMIT-LOG.md` | `PASS` |
| README self-assessment and test summary | `README.md`: `SelfAssessedGrade = 100`, scope/count summary | `PASS` |

The reusable Agent Skill implementation and [YouTube demonstration](https://youtu.be/HodItPORCTw) are completed additional evidence. The demonstration is encouraged and is not marked as a mandatory requirement.

## M. Final submission package

- [x] `docs/final/HW06-SUBMISSION-MANIFEST.md` specifies the clean package contents and exclusions.
- [ ] Human visually reviews the final PDF, Excel workbook, 17 screenshots, exact ZIP file list, then performs the final commit and creates `23127107_HW06_AI_API_100.zip`.
