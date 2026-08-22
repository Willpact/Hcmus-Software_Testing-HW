Human Failure Triage cho `run-001` đã hoàn tất.

Current triage result:

```text
RUN:
run-001

FAILURE_CASES_REVIEWED:
38

PRODUCT_DEFECT_ROOT_CLUSTERS:
6

PRODUCT_DEFECT_CASES:
29

RECLASSIFY_TEST_DEFECT:
4

RECLASSIFY_TEST_DATA_DEFECT:
5

BLOCKED_CASES:
27

BLOCKED_TEST_DEFECT:
10

BLOCKED_TEST_DATA_DEFECT:
17

EXTERNAL_PENDING:
1

EXTERNAL_BLOCKED:
2

TARGETED_RERUN_RECOMMENDED:
37
```

Current Audit:

```text
A-019 — AUDIT_ENTRY_VERIFIED
```

Use:

```text
postman-api-runner
hw06-api-workflow
log-ai-audit
```

This interaction applies the Human defect decisions, corrects only test/harness/test-data problems, performs targeted `run-002`, completes legitimate external verification where possible, and creates defect documentation.

Do NOT modify production behavior.

Do NOT run all 93 cases again unless a newly discovered shared-state reason objectively requires it.

Do NOT create GitHub Issues yet.

---

# 1. Human Defect Decision

Human decision:

```text
STUDENT_DECISION:
MODIFIED_AND_APPROVED

RUN_001:
ACCEPTED_AS_VALID_REAL_EXECUTION

DISTINCT_PRODUCT_DEFECTS:
6
```

Confirm the following six root defects.

---

# 2. Confirm RC-02-01

```text
CLUSTER_ID:
RC-02-01

API:
API-02 — POST /api/checkout

PRODUCT_DEFECT:
CLIENT_SUPPLIED_TOTAL_TRUSTED

AFFECTED_CASES:
10

PRIMARY_EVIDENCE_CASE:
API02-AI-002

EVIDENCE_STRENGTH:
STRONG

HUMAN_DECISION:
CONFIRM_PRODUCT_DEFECT
```

Authoritative invariant:

```text
Backend recalculates checkout total from cart
and must not trust client-supplied total_amount as authority.
```

Treat the 10 affected testcase failures as evidence for **one distinct product defect**.

Do not create 10 bugs.

---

# 3. Confirm RC-02-02

```text
CLUSTER_ID:
RC-02-02

API:
API-02 — POST /api/checkout

PRODUCT_DEFECT:
SUCCESSFUL_CHECKOUT_DOES_NOT_CLEAR_CART

AFFECTED_CASES:
14

PRIMARY_EVIDENCE_CASE:
API02-AI-014

EVIDENCE_STRENGTH:
STRONG

HUMAN_DECISION:
CONFIRM_PRODUCT_DEFECT
```

Authoritative invariant:

```text
Successful checkout clears the authenticated user's cart.
```

Treat the 14 affected failures as one distinct root defect.

---

# 4. Confirm RC-02-03

```text
CLUSTER_ID:
RC-02-03

API:
API-02 — POST /api/checkout

PRODUCT_DEFECT:
AUTHORIZATION_SCHEME_NOT_ENFORCED

AFFECTED_CASES:
1

PRIMARY_EVIDENCE_CASE:
API02-AI-022

EVIDENCE_STRENGTH:
STRONG

HUMAN_DECISION:
CONFIRM_PRODUCT_DEFECT
```

Only authenticated users may checkout.

Keep this separate from cart-total and cart-clearing defects.

---

# 5. Confirm RC-03-01

```text
CLUSTER_ID:
RC-03-01

API:
API-03 — POST /api/admin/import-products

PRODUCT_DEFECT:
PRODUCT_PRICE_POSITIVITY_NOT_ENFORCED

AFFECTED_CASES:
6

PRIMARY_EVIDENCE_CASE:
API03-AI-009

EVIDENCE_STRENGTH:
STRONG

HUMAN_DECISION:
CONFIRM_PRODUCT_DEFECT
```

Authoritative invariant:

```text
Imported product price must be positive.
```

Treat all six affected failures as evidence for one defect where they share this root behavior.

---

# 6. Confirm RC-03-02

```text
CLUSTER_ID:
RC-03-02

API:
API-03 — POST /api/admin/import-products

PRODUCT_DEFECT:
IMPORT_NOT_ATOMIC

AFFECTED_CASES:
4

PRIMARY_EVIDENCE_CASE:
API03-AI-017

EVIDENCE_STRENGTH:
STRONG

HUMAN_DECISION:
CONFIRM_PRODUCT_DEFECT
```

Authoritative invariant:

```text
Import is atomic/all-or-nothing when an invalid row causes batch failure.
```

Use actual SQLite/post-state evidence from run-001.

Do not treat different invalid-row positions as separate bugs if they show the same transaction defect.

---

# 7. Confirm RC-03-03

```text
CLUSTER_ID:
RC-03-03

API:
API-03 — POST /api/admin/import-products

PRODUCT_DEFECT:
ADMIN_ROLE_NOT_ENFORCED

AFFECTED_CASES:
4

PRIMARY_EVIDENCE_CASE:
API03-AI-026

EVIDENCE_STRENGTH:
STRONG

HUMAN_DECISION:
CONFIRM_PRODUCT_DEFECT
```

Authoritative invariant:

```text
Admin API requires a valid JWT and role=admin.
```

Keep authorization failure distinct from validation/atomicity defects.

---

# 8. Final confirmed defect count

After Human decision:

```text
PRODUCT_DEFECT_FINAL_ROOT_CAUSES:
6

PRODUCT_DEFECT_AFFECTED_CASES:
29
```

Do not report:

```text
PRODUCT_DEFECTS:
29
```

Correct wording:

```text
29 testcase failures mapped to 6 confirmed product defects.
```

---

# 9. Reclassify remaining 9 failed cases

From the original 38 failed cases:

```text
29 → PRODUCT_DEFECT
4  → TEST_DEFECT
5  → TEST_DATA_DEFECT
```

Apply the recommendations already documented in:

```text
docs/execution-results/human-failure-triage-packet.md
```

for the exact case IDs.

Do not guess IDs from aggregate counts.

For each of the 4 Test Defects:

```text
FINAL_CLASSIFICATION:
TEST_DEFECT
```

For each of the 5 Test Data Defects:

```text
FINAL_CLASSIFICATION:
TEST_DATA_DEFECT
```

---

# 10. Blocked cases

Current blocked cases:

```text
TOTAL:
27

TEST_DEFECT:
10

TEST_DATA_DEFECT:
17
```

Use the root clusters already established in the Human Triage Packet.

Do not treat these as product defects.

---

# 11. Correction scope

Correction is allowed only for:

```text
TEST_DEFECT
TEST_DATA_DEFECT
HARNESS_DEFECT
EXTERNAL_VERIFICATION_MECHANISM
```

Product defects remain untouched.

---

# 12. Test-defect corrections

For each Test Defect, inspect the approved proposed correction.

Allowed examples:

```text
incorrect Postman assertion implementation
incorrect variable reference
helper sequencing
incorrect observable
Postman script defect
test implementation mismatch with approved testcase
```

Apply only corrections that preserve the original approved requirement/oracle.

Record:

```text
CASE_ID
BEFORE
ROOT_TEST_DEFECT
CORRECTION
SEMANTIC_ORACLE_CHANGED: NO
```

If a proposed correction would change the authoritative testcase meaning:

do NOT apply it.

Set:

```text
CORRECTION_STATUS:
HUMAN_REVIEW_REQUIRED
```

---

# 13. Test-data corrections

For the 22 total Test Data Defect cases:

```text
5 failed
+
17 blocked
=
22
```

repair legitimate fixtures/setup only.

Examples:

```text
missing disposable user
wrong token lifecycle
incorrect cart state
test product collision
stale reset token
invalid fixture sequencing
shared-state contamination
```

Do not change product behavior.

Record root fixture correction once when it fixes multiple cases.

---

# 14. Total corrective rerun pool

Expected corrective testcase pool:

```text
FAILED_RECLASSIFIED_TEST_DEFECT:
4

FAILED_RECLASSIFIED_TEST_DATA_DEFECT:
5

BLOCKED_TEST_DEFECT:
10

BLOCKED_TEST_DATA_DEFECT:
17
```

Total:

```text
36
```

These 36 should normally be targeted for rerun after correction.

---

# 15. External pending case

Also include:

```text
API01-AI-027
```

because it currently has:

```text
EXTERNAL_VERIFICATION_PENDING
```

Attempt to resolve its legitimate external verification dependency.

If resolvable:

include it in targeted evaluation.

If not resolvable:

retain:

```text
POSTMAN_PASS_EXTERNAL_PENDING
```

with evidence explaining why.

---

# 16. External blocked cases

Current external blocked:

```text
API01-AI-035
API02-STU-001
```

Inspect whether the missing external verification mechanism can now be resolved legitimately in the isolated SQLite/test environment.

Do NOT invent evidence.

If resolved as part of the test/test-data correction workflow, include them in run/post-verification accounting.

If they remain legitimately unavailable:

preserve:

```text
EXTERNAL_VERIFICATION:
BLOCKED
```

and explain exactly why.

---

# 17. Targeted run-002 scope

Default expected targeted rerun:

```text
36 corrected test/test-data cases
+
1 external pending case
=
37 cases
```

Use:

```text
docs/execution-results/targeted-rerun-plan.md
```

as source of exact case IDs.

Do not automatically include the 29 confirmed Product Defect cases.

Their run-001 evidence remains valid.

---

# 18. Product defect cases are not rerun merely to prove them again

Do not rerun the 29 confirmed product-defect cases unless:

```text
a shared harness/test-data correction invalidates their run-001 evidence
```

If no such reason exists:

```text
PRODUCT_DEFECT_CASES_RERUN:
0
```

Their evidence remains from:

```text
run-001
```

---

# 19. Do not rerun all 93 cases

Targeted execution is preferred.

Only expand beyond 37 if analysis shows a correction alters common setup for additional cases.

If scope expands, report:

```text
EXPECTED_TARGETED_SCOPE:
37

ACTUAL_SCOPE:
<n>

SCOPE_EXPANSION_REASON:
...
```

Never expand merely for convenience.

---

# 20. Preserve run-001

Absolutely preserve:

```text
test-results/hw06/run-001/
```

unchanged.

New execution:

```text
run-002
```

must be separate.

---

# 21. Build targeted run mechanism

Use the safest mechanism supported by the current collection.

Possible approaches:

```text
temporary targeted collection derived from stable IDs
folder/request filtering
generated run-002 collection containing only approved target IDs
```

Do not alter the canonical approved full collection destructively.

If a temporary collection is used create:

```text
test-results/hw06/run-002/targeted-collection.json
```

or equivalent.

Record the 37 stable case IDs.

---

# 22. Stable ID guard

Before execution verify:

```text
TARGETED_CASE_IDS:
all unique

EXPECTED:
37
```

Do not accidentally duplicate cases through data-driven iteration.

---

# 23. Runtime prerequisites

Reuse:

```text
Newman 6.2.2
newman-reporter-htmlextra 1.23.1
```

Reuse valid:

```text
studentId
runtime credentials
SQLite isolated runtime DB
```

Ensure every real SUT request still contains `X-Student-Id`.

---

# 24. Reset deterministic state

Because run-002 is a corrective rerun:

restore/recreate deterministic isolated fixtures required by the selected cases.

Do not directly edit database rows to make outcomes pass unless an existing approved test fixture mechanism explicitly uses DB seeding.

Application behavior must not be changed.

---

# 25. Run targeted smoke if correction affects shared setup

If corrections changed reusable setup infrastructure:

perform a very small:

```text
smoke-rerun-001
```

before run-002.

If correction is isolated and no shared setup changed, a separate smoke may be unnecessary.

Record decision:

```text
RERUN_SMOKE_REQUIRED:
YES | NO

REASON:
...
```

---

# 26. Execute run-002

Run only the approved targeted scope.

Preserve:

```text
test-results/hw06/run-002/
```

with genuine:

```text
newman.json
newman.html
stdout.log
stderr.log
execution-metadata.md
targeted-case-list.txt
```

and temporary collection if applicable.

---

# 27. Run-002 result classification

For the targeted cases assign:

```text
PASS
FAIL
POSTMAN_PASS_EXTERNAL_PENDING
BLOCKED
NOT_RUN
```

Then classify non-pass results:

```text
TEST_DEFECT
TEST_DATA_DEFECT
PRODUCT_DEFECT_CANDIDATE
EXTERNAL_VERIFICATION_PENDING
SPEC_AMBIGUITY
ENVIRONMENT_DEFECT
NEEDS_HUMAN_REVIEW
```

Do not automatically convert a formerly Test Defect into Product Defect merely because it fails after correction.

Review evidence first.

---

# 28. Expected goal of run-002

The purpose is not:

```text
make everything green
```

The purpose is:

```text
validate that corrected test/harness/data now produces a meaningful verdict.
```

Possible legitimate result:

```text
former TEST_DATA_DEFECT
→ executable after correction
→ actual requirement-backed failure
→ new PRODUCT_DEFECT_CANDIDATE
```

If that happens:

preserve evidence and flag for Human review.

Do not modify test again just to pass.

---

# 29. Update case history

For every rerun case preserve history:

```text
CASE_ID

RUN_001_STATUS
RUN_001_CLASSIFICATION

CORRECTION_APPLIED

RUN_002_STATUS
RUN_002_CLASSIFICATION

FINAL_RECOMMENDATION
```

Do not overwrite run-001 status.

---

# 30. Create six Markdown defect reports

Because Human has now confirmed six distinct product defects, create:

```text
docs/defects/
```

with one Markdown report per root defect.

Suggested:

```text
docs/defects/
├── DEF-01-checkout-client-total-trusted.md
├── DEF-02-checkout-cart-not-cleared.md
├── DEF-03-checkout-auth-not-enforced.md
├── DEF-04-import-price-validation.md
├── DEF-05-import-not-atomic.md
└── DEF-06-import-admin-role.md
```

Use repository naming convention if one already exists.

---

# 31. Defect report content

Each report must include:

```text
DEFECT_ID

TITLE

API

RELATED_REQUIREMENTS

ROOT_CAUSE_CLUSTER

PRIMARY_EVIDENCE_CASE

SUPPORTING_CASES

ENVIRONMENT

PRECONDITIONS

STEPS_TO_REPRODUCE

EXPECTED_RESULT

ACTUAL_RESULT

IMPACT

SEVERITY_RECOMMENDATION

EVIDENCE_PATHS

RUN_ID:
run-001

X-STUDENT-ID:
PRESENT — value redacted

HUMAN_CONFIRMATION:
CONFIRMED_PRODUCT_DEFECT
```

Do not expose credentials.

---

# 32. Severity recommendation

Provide an AI severity recommendation only:

```text
CRITICAL
HIGH
MEDIUM
LOW
```

with reason.

Do not invent assignment-specific severity scale if none exists.

Human-confirmed defect status is already approved; severity may remain recommendation unless separately reviewed.

---

# 33. Screenshots

The assignment requires genuine bug evidence.

Do not fabricate screenshots.

If `newman.html` can genuinely be opened/captured by available tooling, create a real screenshot for the strongest representative failure where practical.

Store genuine screenshots under paths such as:

```text
docs/defects/screenshots/
```

If screenshot tooling is unavailable:

do not manufacture one.

Record:

```text
SCREENSHOT:
PENDING_HUMAN_CAPTURE
```

The actual Newman HTML/JSON evidence remains authoritative.

---

# 34. Do not create GitHub Issues yet

Even though six defects are now confirmed:

```text
GITHUB_ISSUES_CREATED:
0
```

in this interaction.

Reason:

first complete run-002 corrections and ensure defect reports are internally clean.

Next phase can create exactly six GitHub Issues from the six confirmed defect reports.

---

# 35. Update execution summary

Update:

```text
docs/execution-results/api-01-reset-password-execution.md
docs/execution-results/api-02-checkout-execution.md
docs/execution-results/api-03-import-products-execution.md
docs/execution-results/cross-api-execution-summary.md
```

Clearly separate:

```text
RUN-001
RUN-002 TARGETED RERUN
FINAL HUMAN DEFECT DECISIONS
```

---

# 36. Final defect accounting

The summary must distinguish:

```text
TESTCASE_FAILURES:
...

DISTINCT_PRODUCT_DEFECTS:
6

PRODUCT_DEFECT_EVIDENCE_CASES:
29
```

Do not conflate these.

---

# 37. Git permission state

Git remains externally blocked in the current agent context.

Do not repeatedly retry `.git/index.lock`.

Create/update pending commit manifests for logically completed artifacts where useful.

Do not fabricate commit hashes.

Keep:

```text
GIT_CHECKPOINT_STATUS:
PENDING_EXTERNAL_GIT_PERMISSION
```

---

# 38. Do not modify production code

Absolutely forbidden:

```text
fix checkout total
clear cart
add authentication
add price validation
add DB transaction
add admin role enforcement
```

Defects are documentation/testing outputs only.

---

# 39. No CI/CD yet

Do not start CI/CD.

Wait until targeted rerun and defect documentation are reviewed.

---

# 40. No final Excel yet

Do not create final Excel yet.

Final execution statuses must first settle after run-002.

---

# 41. Continuous AI Audit

This interaction is substantive.

First finalize A-019 using the Human decisions in this prompt.

After:

```text
test/test-data corrections
run-002
external verification
defect report creation
```

invoke `log-ai-audit`.

Record:

```text
exact prompt
exact substantive output

six Human-confirmed defects

29 affected product-defect cases

test-defect corrections
test-data corrections

targeted run-002 scope
actual rerun scope

run-002 results

external verification results

six defect report paths

Git state
```

Do not include secrets.

Verify audit entry.

Keep audit files unstaged.

---

# 42. Self-review

Before stopping verify:

```text
[ ] A-019 Human decisions finalized

[ ] exactly 6 distinct product defects confirmed
[ ] 29 failing cases mapped to six defects
[ ] no duplicate bug-per-testcase inflation

[ ] 4 failed cases reclassified TEST_DEFECT
[ ] 5 failed cases reclassified TEST_DATA_DEFECT

[ ] 10 blocked TEST_DEFECT reviewed/corrected
[ ] 17 blocked TEST_DATA_DEFECT reviewed/corrected

[ ] corrections preserve original oracle
[ ] product code unchanged

[ ] API01-AI-027 external pending addressed
[ ] API01-AI-035 external blocked addressed/reported
[ ] API02-STU-001 external blocked addressed/reported

[ ] run-001 immutable
[ ] run-002 created separately

[ ] targeted scope near expected 37
[ ] scope expansion explained if any

[ ] stable case IDs preserved
[ ] runtime X-Student-Id present

[ ] run-002 genuine Newman JSON
[ ] run-002 genuine Newman HTML
[ ] stdout/stderr preserved

[ ] six defect Markdown reports created
[ ] genuine screenshots only, or clearly pending
[ ] no GitHub Issues yet

[ ] no CI/CD
[ ] no final Excel
[ ] no production fix

[ ] audit entry verified
[ ] audit files unstaged
```

---

# 43. Final output

Return:

```text
HW06_DEFECT_CONFIRMATION_AND_TARGETED_RERUN:
PASS | PARTIAL | FAIL

HUMAN_DEFECT_DECISION:
FINALIZED

CONFIRMED_PRODUCT_DEFECTS:
6

PRODUCT_DEFECTS:

DEF_01:
CLUSTER: RC-02-01
TITLE: CLIENT_SUPPLIED_TOTAL_TRUSTED
AFFECTED_RUN_001_CASES: 10
PRIMARY_CASE: API02-AI-002

DEF_02:
CLUSTER: RC-02-02
TITLE: SUCCESSFUL_CHECKOUT_DOES_NOT_CLEAR_CART
AFFECTED_RUN_001_CASES: 14
PRIMARY_CASE: API02-AI-014

DEF_03:
CLUSTER: RC-02-03
TITLE: AUTHORIZATION_SCHEME_NOT_ENFORCED
AFFECTED_RUN_001_CASES: 1
PRIMARY_CASE: API02-AI-022

DEF_04:
CLUSTER: RC-03-01
TITLE: PRODUCT_PRICE_POSITIVITY_NOT_ENFORCED
AFFECTED_RUN_001_CASES: 6
PRIMARY_CASE: API03-AI-009

DEF_05:
CLUSTER: RC-03-02
TITLE: IMPORT_NOT_ATOMIC
AFFECTED_RUN_001_CASES: 4
PRIMARY_CASE: API03-AI-017

DEF_06:
CLUSTER: RC-03-03
TITLE: ADMIN_ROLE_NOT_ENFORCED
AFFECTED_RUN_001_CASES: 4
PRIMARY_CASE: API03-AI-026

PRODUCT_DEFECT_AFFECTED_CASES:
29

CORRECTIONS:

TEST_DEFECT_CASES:
14

TEST_DATA_DEFECT_CASES:
22

CORRECTIONS_APPLIED:
<count>

CORRECTIONS_REQUIRING_HUMAN_REVIEW:
<count>

TARGETED_RUN:

EXPECTED_SCOPE:
37

ACTUAL_SCOPE:
<count>

SCOPE_EXPANSION_REASON:
<none or explanation>

RUN_ID:
run-002

RESULTS:

PASS:
FAIL:
POSTMAN_PASS_EXTERNAL_PENDING:
BLOCKED:
NOT_RUN:

NEW_PRODUCT_DEFECT_CANDIDATES_FROM_RERUN:
<count>

REMAINING_TEST_DEFECT:
<count>

REMAINING_TEST_DATA_DEFECT:
<count>

EXTERNAL_VERIFICATION:

API01_AI_027:
...

API01_AI_035:
...

API02_STU_001:
...

DEFECT_REPORTS:
6

DEFECT_REPORT_PATHS:
...

GENUINE_SCREENSHOTS_CREATED:
<count>

SCREENSHOTS_PENDING_HUMAN_CAPTURE:
<count>

GITHUB_ISSUES_CREATED:
0

RUN_001_MODIFIED:
NO

RUN_002_NEWMAN_JSON:
...

RUN_002_NEWMAN_HTML:
...

RUN_002_STDOUT:
...

RUN_002_STDERR:
...

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
<none or list>

NEXT_CHECKPOINT:
HW06_TARGETED_RERUN_AND_DEFECT_REPORT_REVIEW_REQUIRED
```

Then STOP.

Do not create GitHub Issues.
Do not fix product code.
Do not start CI/CD.
