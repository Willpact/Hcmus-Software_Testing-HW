# HW06 final commit plan — Human execution only

No command in this plan has been executed. First review `git status --short`, confirm ownership of every changed path, and run the final checklist/manifest review. Do not use `git add -A`.

## Mandatory Human security action before final staging

The five raw Newman reports are credential-bearing files already tracked in `HEAD`/`origin/main`. `.gitignore` prevents future accidental additions but does not untrack them. After Human approves the credential-rotation decision, run the following **from the parent repository root** to stop tracking while preserving the local originals:

```powershell
git rm --cached -- `
  HW6/test-results/hw06/run-001/newman.html `
  HW6/test-results/hw06/run-001/newman.json `
  HW6/test-results/hw06/run-001/external-postcheck.newman.json `
  HW6/test-results/hw06/run-002/newman.html `
  HW6/test-results/hw06/run-002/newman.json
git status --short -- HW6/test-results/hw06/run-001/newman.html HW6/test-results/hw06/run-001/newman.json HW6/test-results/hw06/run-001/external-postcheck.newman.json HW6/test-results/hw06/run-002/newman.html HW6/test-results/hw06/run-002/newman.json
```

This is a prepared Human-only command; it has not been executed in this task. It removes the paths from a future `HEAD` only and does not rewrite prior history. Stage/include `docs/execution-results/redacted-newman/` instead.

## Commit 1 — final deliverables, evidence handoff and Agent Skill

Suggested message:

```text
docs(HW6): finalize Agent Skill and submission report
```

Stage only the reviewed, explicit delivery paths below (omit any path that Human did not approve):

```text
README.md
.agents/api-test-generator/SKILL.md
.agents/api-test-generator/diagram-handoff.md
.agents/api-test-generator/references/generator-design.md
docs/agent-skill/api-test-generator-diagram.png
docs/ci/hw06-ci-cd.md
docs/defects/github-issue-readiness.md
docs/final/HW06-MAIN-REPORT.md
docs/final/HW06-MAIN-REPORT.pdf
docs/final/HW06-Test-Cases-and-Summary.xlsx
docs/final/HW06-SECRET-SCAN.md
docs/final/sanitize_newman_evidence.py
docs/final/HW06-SUBMISSION-CHECKLIST.md
docs/final/HW06-SUBMISSION-MANIFEST.md
docs/final/MORNING-HUMAN-ACTIONS.md
docs/final/hw06-submission-readiness.md
docs/final/build_hw06_final_deliverables.py
docs/final/HW06-FINAL-COMMIT-PLAN.md
docs/execution-results/redacted-newman/
```

## Commit 2 — final AI Audit state (last substantive HW06 commit)

Suggested message:

```text
docs(HW6): finalize AI audit and submission evidence
```

Stage only the reviewed audit/traceability paths:

```text
docs/ai-audit/AI_AUDIT_LOG.md
docs/final/hw06-human-audit-review-packet.md
```

Do not stage `docs/agent-skill/demo-output/`, because draft-only generator output is not part of the approved testcase suite or execution evidence. If an earlier pending HW06 file (for example `docs/requirement-analysis/api-01-reset-password.md`, `test-results/hw06/run-002/targeted-collection.json`, or a defect-evidence document) is owned and approved by Human, handle it in its own logical commit before Commit 2. Do not bundle it merely because it appears in the working tree.

## After the two reviewed commits

1. Run the read-only export below and refresh `docs/final/HW06-GIT-COMMIT-LOG.md` for the final archive. Do not make another substantive commit merely to include the refreshed snapshot.

   ```powershell
   git log --grep="(HW6):" --pretty=format:"%h | %ad | %an | %s" --date=short > git-commit-log-hw6.txt
   ```

2. Re-run the secret scan against the exact manifest list, create the ZIP only after Human signs off, and verify the archive contents.

## Explicitly do not stage

```text
any ../HW3, ../HW4, ../HW5 or other parent-repository change
docs/final/__pycache__/
docs/agent-skill/demo-output/
test-results/hw06/**/runtime-input.postman_environment.json
test-results/hw06/**/runtime-output.postman_environment.json
test-results/hw06/**/runtime-db/
test-results/hw06/**/database.sqlite
test-results/hw06/**/sqlite-path-redirect.cjs
test-results/hw06/**/ci*/
test-results/hw06/**/smoke*/
test-results/hw06/run-001/newman.html
test-results/hw06/run-001/newman.json
test-results/hw06/run-001/external-postcheck.newman.json
test-results/hw06/run-002/newman.html
test-results/hw06/run-002/newman.json
.tools/
node_modules/
temporary browser/profile files and logs
```
