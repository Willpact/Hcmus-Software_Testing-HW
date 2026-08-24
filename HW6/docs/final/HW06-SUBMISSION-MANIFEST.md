# HW06 submission package manifest

## Intended archive

- Filename: `23127107_HW06_AI_API_100.zip`.
- Archive root: `23127107_HW06_AI_API_100/`.
- Primary public repository: [https://github.com/Willpact/Hcmus-Software_Testing-HW](https://github.com/Willpact/Hcmus-Software_Testing-HW).
- Do **not** create the ZIP until Human completes the final review in `HW06-SUBMISSION-CHECKLIST.md`.

## Include

Use the existing files; do not regenerate historical execution results.

```text
README.md
.agents/api-test-generator/
docs/agent-skill/api-test-generator-diagram.png
docs/ai-audit/
docs/ci/hw06-ci-cd.md
docs/defects/DEF-*.md
docs/defects/evidence-matrix.md
docs/defects/evidence-capture-result.md
docs/defects/github-issue-readiness.md
docs/defects/github-issues/
docs/defects/screenshots/
docs/execution-results/
docs/execution-results/redacted-newman/
docs/final/AI-CRITIQUE.md
docs/final/HW06-GIT-COMMIT-LOG.md
docs/final/HW06-MAIN-REPORT.md
docs/final/HW06-MAIN-REPORT.pdf
docs/final/HW06-SECRET-SCAN.md
docs/final/HW06-SUBMISSION-CHECKLIST.md
docs/final/HW06-SUBMISSION-MANIFEST.md
docs/final/HW06-FINAL-COMMIT-PLAN.md
docs/final/HW06-Test-Cases-and-Summary.xlsx
docs/final/sanitize_newman_evidence.py
docs/final/hw06-submission-readiness.md
docs/final/MORNING-HUMAN-ACTIONS.md
docs/postman/
docs/requirement-analysis/
docs/test-audit/
docs/test-generation/
docs/test-suite/
postman/collections/
postman/data/
postman/environments/HW06-Local.example.postman_environment.json
postman/scripts/
postman/README.md
test-cases/generated/
test-cases/corrected/
test-cases/final/
test-cases/student-added/
test-results/hw06/run-001/case-accounting.json
test-results/hw06/run-001/execution-metadata.md
test-results/hw06/run-001/external-postcheck.postman_collection.json
test-results/hw06/run-001/external-verification-results.json
test-results/hw06/run-002/case-accounting.json
test-results/hw06/run-002/case-history.json
test-results/hw06/run-002/execution-metadata.md
test-results/hw06/run-002/external-hook-evidence.json
test-results/hw06/run-002/external-verification-results.json
test-results/hw06/run-002/orchestration-result.json
test-results/hw06/run-002/runner-result.json
test-results/hw06/run-002/targeted-case-list.txt
test-results/hw06/run-002/targeted-scope-guard.json
```

The CI workflow is at the parent repository root. Include it at archive path `.github/workflows/hw06-api-newman.yml` only when packaging from the parent repository while preserving its repository-relative path; do not relocate or modify the workflow source.

## Exclude

```text
.git/
.tools/
node_modules/
docs/final/__pycache__/
*.pyc
docs/agent-skill/demo-output/
test-results/hw06/**/runtime-input.postman_environment.json
test-results/hw06/**/runtime-output.postman_environment.json
test-results/hw06/**/HW06-Local.runtime.postman_environment.json
test-results/hw06/**/runtime-db/
test-results/hw06/**/database.sqlite
test-results/hw06/**/sqlite-path-redirect.cjs
test-results/hw06/**/*.log
test-results/hw06/**/sut.stdout.log
test-results/hw06/**/sut.stderr.log
test-results/hw06/ci/
test-results/hw06/ci-runtime/
test-results/hw06/smoke-*/
test-results/hw06/smoke-rerun-001/
test-results/hw06/run-001/newman.html
test-results/hw06/run-001/newman.json
test-results/hw06/run-001/external-postcheck.newman.json
test-results/hw06/run-002/newman.html
test-results/hw06/run-002/newman.json
postman/environments/HW06-Local.postman_environment.json
.env
jmeter.log
any temporary runtime credential, browser profile or capture file outside the required evidence paths
any unrelated HW1/, HW2/, HW3/, HW4/ or HW5/ content
screenshots outside docs/defects/screenshots/
```

These exclusions prevent runtime credentials, databases, temporary orchestration material and unrelated build caches from entering the Moodle archive. They do not erase or rewrite historical artifacts in the working tree.

`docs/agent-skill/demo-output/` is excluded because draft-only generator output is not part of the approved HW06 testcase suite or execution evidence.

## Human visual checks before packaging

- Visually inspect the final PDF, the workbook and the 17 genuine screenshots.
- Review the redaction manifest before packaging; raw token-bearing Newman reports must stay excluded from the ZIP and final staging.
- Review the exact archive file list against this manifest.
- Review explicit staging groups in `docs/final/HW06-FINAL-COMMIT-PLAN.md`, then create the ZIP only after the reviewed final commit/log refresh.
