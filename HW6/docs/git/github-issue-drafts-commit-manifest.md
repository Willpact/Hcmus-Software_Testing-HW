# Pending Commit Manifest — GitHub Issue Draft Preparation

```text
STATUS:
PENDING_EXTERNAL_GIT_PERMISSION

COMMIT_HASH:
NOT_CREATED

INTENDED_COMMIT:
docs(HW6): prepare nine confirmed GitHub issue drafts

ISSUE_DRAFTS:
9/9

SCREENSHOT_CAPTURE_METHOD:
MANUAL_BY_STUDENT

SCREENSHOT_AUTOMATION:
CLOSED

SCREENSHOTS_INCLUDED:
NO

AI_AUDIT_FILES_INCLUDED:
NO

PRODUCTION_CODE_INCLUDED:
NO
```

## Pending logical checkpoints reviewed

1. Student Extension checkpoint — still `PENDING_EXTERNAL_GIT_PERMISSION`; exact scope remains in `docs/git/student-extension-commit-manifest.md`.
2. run-002 evidence and nine confirmed defect-report checkpoint — still `PENDING_EXTERNAL_GIT_PERMISSION`; scope remains in `docs/git/run-002-defect-report-commit-manifest.md`.
3. GitHub Issue draft preparation checkpoint — current manifest; stage only the explicit files below.
4. Final AI Audit checkpoint — intentionally deferred and must remain a separate final commit.

Do not combine these checkpoints implicitly. The Human may execute them in the documented logical order after external Git permission is available.

## Exact files for this checkpoint

- `HW6/docs/defects/github-issues/DEF-01-github-issue.md`
- `HW6/docs/defects/github-issues/DEF-02-github-issue.md`
- `HW6/docs/defects/github-issues/DEF-03-github-issue.md`
- `HW6/docs/defects/github-issues/DEF-04-github-issue.md`
- `HW6/docs/defects/github-issues/DEF-05-github-issue.md`
- `HW6/docs/defects/github-issues/DEF-06-github-issue.md`
- `HW6/docs/defects/github-issues/DEF-07-github-issue.md`
- `HW6/docs/defects/github-issues/DEF-08-github-issue.md`
- `HW6/docs/defects/github-issues/DEF-09-github-issue.md`
- `HW6/docs/defects/github-issues/GITHUB-ISSUE-TEMPLATE.md`
- `HW6/docs/defects/github-issues/README.md`
- `HW6/docs/defects/github-issue-readiness.md`
- `HW6/docs/defects/evidence-matrix.md`
- `HW6/docs/defects/screenshot-capture-plan.md`
- `HW6/docs/defects/native-windows-screenshot-result.md`
- `HW6/docs/execution-results/cross-api-execution-summary.md`
- `HW6/docs/git/github-issue-drafts-commit-manifest.md`

## Exact staging commands

Run from repository root `D:\Workspace\HCMUS\Software Testing\Homework\Hcmus-Software_Testing-HW`:

```powershell
git add -- "HW6/docs/defects/github-issues/DEF-01-github-issue.md" "HW6/docs/defects/github-issues/DEF-02-github-issue.md" "HW6/docs/defects/github-issues/DEF-03-github-issue.md"
git add -- "HW6/docs/defects/github-issues/DEF-04-github-issue.md" "HW6/docs/defects/github-issues/DEF-05-github-issue.md" "HW6/docs/defects/github-issues/DEF-06-github-issue.md"
git add -- "HW6/docs/defects/github-issues/DEF-07-github-issue.md" "HW6/docs/defects/github-issues/DEF-08-github-issue.md" "HW6/docs/defects/github-issues/DEF-09-github-issue.md"
git add -- "HW6/docs/defects/github-issues/GITHUB-ISSUE-TEMPLATE.md" "HW6/docs/defects/github-issues/README.md"
git add -- "HW6/docs/defects/github-issue-readiness.md" "HW6/docs/defects/evidence-matrix.md" "HW6/docs/defects/screenshot-capture-plan.md" "HW6/docs/defects/native-windows-screenshot-result.md"
git add -- "HW6/docs/execution-results/cross-api-execution-summary.md" "HW6/docs/git/github-issue-drafts-commit-manifest.md"
```

Do not use `git add -A`. Do not stage `HW6/docs/ai-audit/`, any screenshot file, SUT source, CI/CD artifacts, Excel files, or final-report files in this checkpoint.

## Cached-diff checks

```powershell
git status --short -- "HW6/docs/defects" "HW6/docs/execution-results/cross-api-execution-summary.md" "HW6/docs/git/github-issue-drafts-commit-manifest.md"
git diff --cached --name-status -- "HW6/docs/defects" "HW6/docs/execution-results/cross-api-execution-summary.md" "HW6/docs/git/github-issue-drafts-commit-manifest.md"
git diff --cached --check -- "HW6/docs/defects" "HW6/docs/execution-results/cross-api-execution-summary.md" "HW6/docs/git/github-issue-drafts-commit-manifest.md"
git diff --cached --name-only | Select-String -Pattern '^HW6/docs/ai-audit/'
```

The final command must return no matching path. Before commit, verify the cached name list contains exactly the 17 files listed in this manifest and no screenshot or production-code path.

## Commit command

```powershell
git commit -m "docs(HW6): prepare nine confirmed GitHub issue drafts"
```

No staging or commit command was executed by the agent for this checkpoint.
