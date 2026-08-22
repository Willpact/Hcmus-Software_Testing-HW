# Student Extension Pending Commit Manifest

```text
INTENDED_COMMIT:
test(HW6): finalize student-added API test cases

FILES_TO_COMMIT:
HW6/docs/test-extension/api-01-reset-password-student-extension.md
HW6/docs/test-extension/api-02-checkout-student-extension.md
HW6/docs/test-extension/api-03-import-products-student-extension.md
HW6/docs/test-extension/final-suite-preview.md
HW6/docs/test-extension/replacement-human-review-packet.md
HW6/docs/test-extension/student-extension-human-review-packet.md
HW6/test-cases/student-added/api-01-reset-password.json
HW6/test-cases/student-added/api-02-checkout.json
HW6/test-cases/student-added/api-03-import-products.json

FILES_EXPLICITLY_EXCLUDED:
HW6/docs/ai-audit/
HW6/docs/git/student-extension-commit-manifest.md
HW6/postman/
HW6/docs/postman/
HW6/test-cases/final/
HW6/docs/test-suite/
all unrelated repository files and homework directories

PRE_COMMIT_CHECK:
git status --short -- HW6
git diff --cached --name-status -- HW6

STATUS:
PENDING_EXTERNAL_GIT_PERMISSION
```

## Exact staging commands

Run from the repository root:

```powershell
git add -- "HW6/docs/test-extension/api-01-reset-password-student-extension.md" "HW6/docs/test-extension/api-02-checkout-student-extension.md" "HW6/docs/test-extension/api-03-import-products-student-extension.md" "HW6/docs/test-extension/final-suite-preview.md" "HW6/docs/test-extension/replacement-human-review-packet.md" "HW6/docs/test-extension/student-extension-human-review-packet.md"
git add -- "HW6/test-cases/student-added/api-01-reset-password.json" "HW6/test-cases/student-added/api-02-checkout.json" "HW6/test-cases/student-added/api-03-import-products.json"
git status --short -- HW6
git diff --cached --name-status -- HW6
git commit -m "test(HW6): finalize student-added API test cases"
```

The audit directory and all downstream Postman/final-suite artifacts are intentionally excluded from this checkpoint. No broad `git add -A` or root-level staging is permitted.
