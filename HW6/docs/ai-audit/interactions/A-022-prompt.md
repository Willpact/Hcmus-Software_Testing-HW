Human review cho ba root cluster mới từ `run-002` đã hoàn tất.

Current reviewed clusters:

```text
RC-01-N01
MISSING_NEW_PASSWORD_ACCEPTED_AS_SUCCESSFUL_RESET

RC-01-N02
RESET_PASSWORD_STRENGTH_RULE_NOT_ENFORCED

RC-01-N03
RESET_PASSWORD_STORES_PASSWORD_AS_PLAINTEXT
```

All three have:

```text
EVIDENCE_STRENGTH:
STRONG

AI_RECOMMENDATION:
CONFIRM_PRODUCT_DEFECT
```

Current Audit:

```text
A-021 — AUDIT_ENTRY_VERIFIED
```

Human decision:

```text
STUDENT_DECISION:
APPROVED

RC-01-N01:
CONFIRM_PRODUCT_DEFECT

RC-01-N02:
CONFIRM_PRODUCT_DEFECT

RC-01-N03:
CONFIRM_PRODUCT_DEFECT
```

Therefore final distinct confirmed Product Defects now become:

```text
EXISTING_CONFIRMED:
6

NEW_CONFIRMED:
3

TOTAL_DISTINCT_PRODUCT_DEFECTS:
9
```

Use:

```text
postman-api-runner
hw06-api-workflow
log-ai-audit
```

This phase should:

```text
1. Finalize Human decisions for the three new defects
2. Create DEF-07, DEF-08, DEF-09 Markdown defect reports
3. Update the global 9-defect evidence matrix
4. Update screenshot capture plan from 6 → 9 defects
5. Finalize execution/defect accounting
6. Prepare GitHub-Issue-ready artifacts
7. Audit this interaction
8. STOP before GitHub Issue creation
```

Do not rerun Newman.

Do not modify tests.

Do not modify test data.

Do not modify production code.

Do not create GitHub Issues yet.

---

# 1. Finalize A-021 Human Review

Record:

```text
RUN_002_NEW_DEFECT_HUMAN_REVIEW:
APPROVED

RC-01-N01:
CONFIRMED_PRODUCT_DEFECT

RC-01-N02:
CONFIRMED_PRODUCT_DEFECT

RC-01-N03:
CONFIRMED_PRODUCT_DEFECT
```

Finalize the pending A-021/current interaction according to continuous audit policy.

Verify it before continuing.

Keep:

```text
docs/ai-audit/
```

unstaged.

---

# 2. Confirm RC-01-N01

```text
DEFECT:
MISSING_NEW_PASSWORD_ACCEPTED_AS_SUCCESSFUL_RESET

CLUSTER:
RC-01-N01

API:
POST /api/reset-password

AFFECTED_CASES:
API01-AI-007

PRIMARY_EVIDENCE_CASE:
API01-AI-007

RUN:
run-002

HUMAN_DECISION:
CONFIRM_PRODUCT_DEFECT
```

The defect report must trace to the authoritative requirement that a reset operation requires a new password and must not be treated as successful when that required reset input is absent.

Do not invent exact HTTP status if unspecified.

Use the business outcome/state as the defect oracle.

---

# 3. Confirm RC-01-N02

```text
DEFECT:
RESET_PASSWORD_STRENGTH_RULE_NOT_ENFORCED

CLUSTER:
RC-01-N02

API:
POST /api/reset-password

AFFECTED_CASES:
API01-AI-009
API01-AI-018
API01-AI-021
API01-AI-022
API01-AI-023
API01-AI-024
API01-STU-002

PRIMARY_EVIDENCE_CASE:
API01-AI-018

RUN:
run-002

HUMAN_DECISION:
CONFIRM_PRODUCT_DEFECT
```

Authoritative password-strength rule:

```text
minimum 8 characters
uppercase
lowercase
digit
allowed special character
```

Use the exact approved requirement wording from the requirement-analysis artifact.

Do not make separate bugs for each weak-password partition.

The seven failing cases represent one root defect:

```text
PASSWORD STRENGTH VALIDATION NOT ENFORCED
```

---

# 4. Confirm RC-01-N03

```text
DEFECT:
RESET_PASSWORD_STORES_PASSWORD_AS_PLAINTEXT

CLUSTER:
RC-01-N03

API:
POST /api/reset-password

AFFECTED_CASES:
API01-AI-035

PRIMARY_EVIDENCE_CASE:
API01-AI-035

RUN:
run-002

HUMAN_DECISION:
CONFIRM_PRODUCT_DEFECT
```

The external verification has established:

```text
PLAINTEXT_EQUALITY_EVIDENCE:
CONFIRMED
```

Use the real read-only SQLite evidence.

Security invariant:

```text
persisted password must not equal submitted plaintext password
```

Do not expose:

```text
actual password
hash
JWT
Student ID
```

in defect documentation or screenshots.

Safe evidence wording:

```text
PLAINTEXT_EQUAL:
YES
```

---

# 5. Final Product Defect inventory

There are now exactly nine confirmed distinct root defects.

Maintain this canonical order:

```text
DEF-01
RC-02-01
CLIENT_SUPPLIED_TOTAL_TRUSTED

DEF-02
RC-02-02
SUCCESSFUL_CHECKOUT_DOES_NOT_CLEAR_CART

DEF-03
RC-02-03
AUTHORIZATION_SCHEME_NOT_ENFORCED

DEF-04
RC-03-01
PRODUCT_PRICE_POSITIVITY_NOT_ENFORCED

DEF-05
RC-03-02
IMPORT_NOT_ATOMIC

DEF-06
RC-03-03
ADMIN_ROLE_NOT_ENFORCED

DEF-07
RC-01-N01
MISSING_NEW_PASSWORD_ACCEPTED_AS_SUCCESSFUL_RESET

DEF-08
RC-01-N02
RESET_PASSWORD_STRENGTH_RULE_NOT_ENFORCED

DEF-09
RC-01-N03
RESET_PASSWORD_STORES_PASSWORD_AS_PLAINTEXT
```

Do not renumber existing DEF-01..DEF-06.

---

# 6. Product-defect testcase accounting

Preserve distinction between:

```text
DISTINCT_PRODUCT_DEFECTS:
9
```

and testcase failures/evidence.

Existing confirmed root defects from run-001:

```text
29 affected testcase failures
```

New confirmed root defects from run-002:

```text
9 affected testcase failures
```

If the actual artifact review confirms no overlap between those sets, report:

```text
PRODUCT_DEFECT_EVIDENCE_CASES:
38
```

If there is overlap, calculate the unique count from actual stable case IDs instead of forcing 38.

Never report:

```text
38 product defects
```

Correct language:

```text
38 failing testcase evidence records mapped to 9 distinct confirmed defects
```

only if the unique-case count actually equals 38.

---

# 7. API01-AI-016 remains non-product

Preserve:

```text
CASE:
API01-AI-016

STATUS:
BLOCKED_TEST_DATA

ROOT_CAUSE:
LEGITIMATE_EXPIRED_OTP_FIXTURE_UNAVAILABLE

PRODUCT_INFERENCE:
NO
```

Do not invent an OTP expiry duration.

Do not fabricate an expired token.

Do not include this case as evidence for any defect.

---

# 8. Create DEF-07 report

Create:

```text
docs/defects/DEF-07-reset-missing-new-password.md
```

or equivalent repository-convention name.

Include:

```text
DEFECT_ID:
DEF-07

ROOT_CLUSTER:
RC-01-N01

TITLE:
Missing new password accepted as successful reset

API:
POST /api/reset-password

PRIMARY_CASE:
API01-AI-007

RUN:
run-002
```

Then standard defect sections:

```text
Related Requirement
Environment
Preconditions
Steps to Reproduce
Expected Result
Actual Result
Impact
Severity Recommendation
Primary Evidence
Supporting Evidence
X-Student-Id Presence
Human Confirmation
Screenshot
```

Do not invent HTTP status expectations.

---

# 9. Create DEF-08 report

Create:

```text
docs/defects/DEF-08-reset-password-strength-not-enforced.md
```

Include:

```text
ROOT_CLUSTER:
RC-01-N02

PRIMARY_CASE:
API01-AI-018

SUPPORTING_CASES:
API01-AI-009
API01-AI-021
API01-AI-022
API01-AI-023
API01-AI-024
API01-STU-002
```

Explain that multiple partitions of the same password-strength requirement fail because one validation rule family is not enforced.

Do not create one defect per password rule partition.

---

# 10. Create DEF-09 report

Create:

```text
docs/defects/DEF-09-reset-password-plaintext-storage.md
```

Include:

```text
ROOT_CLUSTER:
RC-01-N03

PRIMARY_CASE:
API01-AI-035

RUN:
run-002
```

Evidence must reference actual read-only SQLite verification.

Record only safe result such as:

```text
PLAINTEXT_EQUAL:
YES
```

Never include the actual plaintext.

Because this is a credential-storage security defect, severity recommendation should be evaluated conservatively based on impact.

Do not exaggerate beyond the observed evidence.

---

# 11. Review existing DEF-01..DEF-06

Read:

```text
docs/defects/DEF-01-checkout-client-total-trusted.md
docs/defects/DEF-02-checkout-cart-not-cleared.md
docs/defects/DEF-03-checkout-auth-not-enforced.md
docs/defects/DEF-04-import-price-validation.md
docs/defects/DEF-05-import-not-atomic.md
docs/defects/DEF-06-import-admin-role.md
```

Do not alter their confirmed root cause.

You may update:

```text
supporting evidence
run-002 corroboration
screenshot status
evidence matrix links
```

where real evidence exists.

Example:

```text
API02-STU-001
```

may support DEF-02.

---

# 12. Final 9-defect evidence matrix

Update:

```text
docs/defects/evidence-matrix.md
```

It must contain exactly nine confirmed defects.

Columns:

```text
DEFECT_ID
ROOT_CLUSTER
API
TITLE
PRIMARY_CASE
SUPPORTING_CASES
RUN_ID
AUTHORITATIVE_REQUIREMENT
NEWMAN_JSON
NEWMAN_HTML
EXTERNAL_EVIDENCE
SCREENSHOT
SCREENSHOT_STATUS
HUMAN_STATUS
```

Set:

```text
HUMAN_STATUS:
CONFIRMED_PRODUCT_DEFECT
```

for all nine.

---

# 13. Genuine screenshot situation

Current automated screenshot state:

```text
GENUINE_SCREENSHOTS_CREATED:
0
```

The current execution agent cannot genuinely capture Newman HTML screenshots.

Do not fabricate any image.

Do not convert text/JSON into fake screenshot evidence.

---

# 14. Expand manual capture plan to 9 defects

Update:

```text
docs/defects/screenshot-capture-plan.md
```

from six defects to nine.

Exactly one minimum primary screenshot per defect.

Suggested targets:

```text
DEF-01
run-001/newman.html
API02-AI-002

DEF-02
run-001/newman.html
API02-AI-014

DEF-03
run-001/newman.html
API02-AI-022

DEF-04
run-001/newman.html
API03-AI-009

DEF-05
run-001/newman.html
API03-AI-017

DEF-06
run-001/newman.html
API03-AI-026

DEF-07
run-002/newman.html
API01-AI-007

DEF-08
run-002/newman.html
API01-AI-018

DEF-09
run-002/newman.html
API01-AI-035
```

Verify actual report contents before finalizing each instruction.

---

# 15. Screenshot instructions must be precise

For each defect include:

```text
DEFECT_ID:
...

REPORT:
...

CASE:
...

WHAT_TO_CAPTURE:
case/test name
failed assertion
actual response/result
relevant expected invariant if visible

OPTIONAL_SECONDARY_CAPTURE:
<external/state evidence if useful>

SAVE_AS:
docs/defects/screenshots/<stable filename>.png

REDACT:
password
JWT
Student ID
personal data
```

---

# 16. Recommended filenames

Use:

```text
docs/defects/screenshots/
```

Suggested:

```text
DEF-01-API02-AI-002-newman.png
DEF-02-API02-AI-014-newman.png
DEF-03-API02-AI-022-newman.png
DEF-04-API03-AI-009-newman.png
DEF-05-API03-AI-017-newman.png
DEF-06-API03-AI-026-newman.png
DEF-07-API01-AI-007-newman.png
DEF-08-API01-AI-018-newman.png
DEF-09-API01-AI-035-newman.png
```

Do not mark them captured until real files exist.

---

# 17. DEF-09 secondary screenshot guidance

Because DEF-09 relies on DB evidence, the Newman screenshot alone may not prove plaintext storage.

The capture plan should recommend a second genuine evidence capture if practical:

```text
safe terminal / SQLite verification output
```

showing only:

```text
PLAINTEXT_EQUAL = YES
```

or equivalent redacted result.

Never display the real password.

This can be:

```text
SECONDARY_EVIDENCE:
RECOMMENDED
```

while the primary Newman screenshot still shows the reset testcase context.

---

# 18. DEF-02 and DEF-05 external-state screenshots

Likewise consider optional secondary captures for:

```text
DEF-02:
cart still present after confirmed successful checkout

DEF-05:
partial products persisted from invalid batch
```

Only if genuine state evidence can be displayed safely.

Do not manufacture screenshots if it cannot.

---

# 19. GitHub Issue readiness artifact

Create:

```text
docs/defects/github-issue-readiness.md
```

For each of the nine defects record:

```text
DEFECT_ID
MARKDOWN_REPORT:
READY | NOT_READY

PRIMARY_EVIDENCE:
READY | NOT_READY

SCREENSHOT:
READY | PENDING_HUMAN_CAPTURE

HUMAN_CONFIRMED:
YES

READY_FOR_GITHUB_ISSUE:
YES | NO
```

Because screenshots are currently absent:

expected current value:

```text
READY_FOR_GITHUB_ISSUE:
NO
```

for defects requiring screenshot evidence.

Do not create the issues yet.

---

# 20. Final execution accounting

Update:

```text
docs/execution-results/cross-api-execution-summary.md
```

to reflect final reviewed state.

It must distinguish:

```text
run-001
run-002
test defects
test-data defects
confirmed product defects
blocked unresolved test-data case
```

Canonical reviewed findings:

```text
DISTINCT_CONFIRMED_PRODUCT_DEFECTS:
9

REMAINING_TEST_DEFECT:
0

REMAINING_TEST_DATA_BLOCKER:
1

REMAINING_TEST_DATA_CASE:
API01-AI-016
```

Calculate final testcase evidence counts from actual artifacts.

Do not force aggregate numbers where case sets overlap.

---

# 21. No further execution now

Do not rerun:

```text
run-003
```

The only remaining testcase blocker `API01-AI-016` lacks a legitimate expired-OTP fixture and cannot be resolved without inventing requirement details.

Record:

```text
ADDITIONAL_RERUN_REQUIRED:
NO
```

unless artifact evidence identifies another unresolved execution problem.

---

# 22. Git status remains separate

Current:

```text
GIT_CHECKPOINT_STATUS:
PENDING_EXTERNAL_GIT_PERMISSION
```

Do not retry `.git/index.lock`.

Do not fabricate commit hashes.

Prepare exact pending commit manifests if needed for:

```text
Student Extension
Postman implementation
execution evidence
defect reports
```

Do not stage AI Audit.

---

# 23. Do not create GitHub Issues

Still:

```text
GITHUB_ISSUES_CREATED:
0
```

Next Human action is genuine screenshot capture.

Only after screenshots exist should the workflow create the nine GitHub Issues.

---

# 24. Do not start CI/CD

Still:

```text
CI_CD_STARTED:
NO
```

---

# 25. Do not create final Excel yet

Still:

```text
FINAL_EXCEL_CREATED:
NO
```

We will generate final testcase/export artifacts only after defect evidence/GitHub Issues are settled.

---

# 26. Continuous AI Audit

This interaction is substantive.

Finalize A-021 using Human decisions above.

After creating/updating:

```text
DEF-07
DEF-08
DEF-09
evidence-matrix
screenshot-capture-plan
github-issue-readiness
cross-api execution summary
```

invoke `log-ai-audit`.

Record:

```text
exact prompt
exact substantive output

3 newly confirmed product defects
total 9 confirmed defects

defect report paths

screenshot status

API01-AI-016 unresolved test-data status

Git state
```

Do not log secrets.

Verify new Audit entry.

Keep Audit files unstaged.

---

# 27. Self-review

Verify:

```text
[ ] A-021 Human decisions finalized

[ ] RC-01-N01 confirmed
[ ] RC-01-N02 confirmed
[ ] RC-01-N03 confirmed

[ ] total distinct confirmed defects = 9

[ ] DEF-07 created
[ ] DEF-08 created
[ ] DEF-09 created

[ ] DEF-01..DEF-06 preserved

[ ] no duplicate defect inflation
[ ] product-defect evidence testcase count calculated from actual unique IDs

[ ] API01-AI-016 remains BLOCKED_TEST_DATA
[ ] API01-AI-016 not counted as product defect

[ ] evidence matrix contains exactly 9 confirmed defects
[ ] screenshot capture plan contains exactly 9 primary screenshots

[ ] no fake screenshot produced
[ ] all screenshots remain PENDING_HUMAN_CAPTURE until files actually exist

[ ] DEF-09 secondary DB evidence instruction redacts secrets

[ ] GitHub Issue readiness created
[ ] no GitHub Issues created

[ ] no rerun
[ ] no test modification
[ ] no production modification
[ ] no CI/CD
[ ] no final Excel

[ ] audit entry verified
[ ] audit files unstaged
```

---

# 28. Final output

Return:

```text
HW06_FINAL_DEFECT_CONFIRMATION_AND_EVIDENCE_PREP:
PASS | PARTIAL | FAIL

NEW_HUMAN_DECISIONS:
FINALIZED

NEW_CONFIRMED_DEFECTS:
3

TOTAL_CONFIRMED_DEFECTS:
9

NEW_DEFECTS:

DEF_07:
CLUSTER:
RC-01-N01
TITLE:
MISSING_NEW_PASSWORD_ACCEPTED_AS_SUCCESSFUL_RESET
PRIMARY_CASE:
API01-AI-007
REPORT:
<path>

DEF_08:
CLUSTER:
RC-01-N02
TITLE:
RESET_PASSWORD_STRENGTH_RULE_NOT_ENFORCED
PRIMARY_CASE:
API01-AI-018
REPORT:
<path>

DEF_09:
CLUSTER:
RC-01-N03
TITLE:
RESET_PASSWORD_STORES_PASSWORD_AS_PLAINTEXT
PRIMARY_CASE:
API01-AI-035
REPORT:
<path>

PRODUCT_DEFECT_EVIDENCE_CASES:
<count unique IDs>

REMAINING_TEST_DEFECT:
0

REMAINING_TEST_DATA_DEFECT:
1

REMAINING_TEST_DATA_CASE:
API01-AI-016

ADDITIONAL_RERUN_REQUIRED:
NO

EVIDENCE:

DEFECT_REPORTS:
9

EVIDENCE_MATRIX:
docs/defects/evidence-matrix.md

SCREENSHOT_CAPTURE_PLAN:
docs/defects/screenshot-capture-plan.md

GENUINE_SCREENSHOTS_CREATED:
0

SCREENSHOTS_PENDING_HUMAN_CAPTURE:
9

GITHUB_ISSUE_READINESS:
docs/defects/github-issue-readiness.md

READY_FOR_GITHUB_ISSUE_COUNT:
0

GITHUB_ISSUES_CREATED:
0

RUN_001_MODIFIED:
NO

RUN_002_MODIFIED:
NO

PRODUCTION_CODE_MODIFIED:
NO

CI_CD_STARTED:
NO

FINAL_EXCEL_CREATED:
NO

GIT_CHECKPOINT_STATUS:
PENDING_EXTERNAL_GIT_PERMISSION

AUDIT_ENTRY:
<id> — AUDIT_ENTRY_VERIFIED

AUDIT_FILES_STAGED:
NO

BLOCKERS:
9_GENUINE_SCREENSHOTS_PENDING_HUMAN_CAPTURE
PENDING_EXTERNAL_GIT_PERMISSION

NEXT_CHECKPOINT:
HW06_GENUINE_SCREENSHOT_CAPTURE_REQUIRED
```

Then STOP.

Do not create GitHub Issues.
Do not fabricate screenshots.
Do not rerun Newman.
