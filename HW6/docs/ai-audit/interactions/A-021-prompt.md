`run-002` targeted rerun đã hoàn tất và hiện cần Human Review cho các Product Defect Candidate mới.

Current state:

```text
RUN_001:
preserved

RUN_002:
completed

EXPECTED_TARGETED_SCOPE:
37

ACTUAL_SCOPE:
37

STABLE_CASE_REQUESTS_EXECUTED:
36

RESULTS:
PASS: 15
FAIL: 21
BLOCKED: 1

REMAINING_TEST_DEFECT:
0

REMAINING_TEST_DATA_DEFECT:
1
```

Existing Human-confirmed Product Defects:

```text
DEF-01 / RC-02-01:
CLIENT_SUPPLIED_TOTAL_TRUSTED

DEF-02 / RC-02-02:
SUCCESSFUL_CHECKOUT_DOES_NOT_CLEAR_CART

DEF-03 / RC-02-03:
AUTHORIZATION_SCHEME_NOT_ENFORCED

DEF-04 / RC-03-01:
PRODUCT_PRICE_POSITIVITY_NOT_ENFORCED

DEF-05 / RC-03-02:
IMPORT_NOT_ATOMIC

DEF-06 / RC-03-03:
ADMIN_ROLE_NOT_ENFORCED
```

New `run-002` result:

```text
NEW_PRODUCT_DEFECT_CANDIDATES:
9

NEW_PRODUCT_DEFECT_CANDIDATE_ROOT_CLUSTERS:
3
```

Known example:

```text
API01-AI-035:
RESOLVED_FAIL

EXTERNAL_VERIFICATION:
read-only persistence verification showed plaintext equality

PRELIMINARY_ROOT_CLUSTER:
RC-01-N03
```

Current unresolved Test Data case:

```text
API01-AI-016

ROOT_REASON:
LEGITIMATE_EXPIRED_OTP_FIXTURE_UNAVAILABLE
```

Screenshot status:

```text
GENUINE_SCREENSHOTS_CREATED:
0

SCREENSHOTS_PENDING_HUMAN_CAPTURE:
6
```

Current Audit:

```text
A-020 — AUDIT_ENTRY_VERIFIED
```

Use:

```text
postman-api-runner
hw06-api-workflow
log-ai-audit
```

This phase is:

```text
NEW DEFECT CLUSTER HUMAN REVIEW PREPARATION
+
GENUINE EVIDENCE CAPTURE
```

Do NOT rerun Newman.

Do NOT modify tests.

Do NOT modify test data.

Do NOT modify production code.

Do NOT create GitHub Issues yet.

---

# 1. Record Human checkpoint decision

Record:

```text
STUDENT_DECISION:
RUN_002_ACCEPTED_FOR_NEW_DEFECT_TRIAGE

RUN_002:
PRESERVE_AS_REAL_TARGETED_EXECUTION

EXISTING_CONFIRMED_DEFECTS:
6

NEW_ROOT_CLUSTERS:
NOT_YET_HUMAN_CONFIRMED

ACTION:
REVIEW_3_NEW_ROOT_CLUSTERS_AND_PREPARE_GENUINE_DEFECT_EVIDENCE
```

Finalize A-020/current interaction according to continuous AI Audit policy.

Keep:

```text
docs/ai-audit/
```

unstaged.

---

# 2. Preserve run evidence

Do not modify:

```text
test-results/hw06/run-001/
test-results/hw06/run-002/
```

These are immutable real execution evidence.

Do not rerun.

---

# 3. Review all 9 new Product Defect Candidate cases

Inspect actual run-002 evidence for all nine cases.

Use:

```text
test-results/hw06/run-002/newman.json
test-results/hw06/run-002/newman.html
test-results/hw06/run-002/stdout.log
test-results/hw06/run-002/stderr.log
test-results/hw06/run-002/execution-metadata.md

docs/execution-results/
docs/postman/external-verification-plan.md
```

For each candidate verify:

```text
CASE_ID
API
REQUIREMENT
ORACLE
SETUP
REQUEST
OBSERVED_RESULT
POSTMAN_ASSERTION
EXTERNAL_VERIFICATION
CURRENT_CLASSIFICATION
ROOT_CLUSTER
```

Do not rely only on previous summary.

---

# 4. Reconstruct exactly 3 new root clusters

Create exactly the root clusters actually supported by the nine candidates.

For each:

```text
CLUSTER_ID:
API:

HYPOTHESIS:

AFFECTED_CASES:
[...]

PRIMARY_EVIDENCE_CASE:

SUPPORTING_CASES:
[...]

AUTHORITATIVE_REQUIREMENTS:
[...]

EXPECTED_INVARIANT:

OBSERVED_BEHAVIOR:

EXTERNAL_EVIDENCE:

RUN_ID:
run-002

EVIDENCE_STRENGTH:
STRONG | MODERATE | WEAK

AI_RECOMMENDATION:
CONFIRM_PRODUCT_DEFECT |
MERGE_WITH_EXISTING_DEFECT |
RECLASSIFY_TEST_DATA_DEFECT |
RECLASSIFY_TEST_DEFECT |
NEEDS_TARGETED_RERUN |
REJECT_PRODUCT_DEFECT
```

Human decision remains:

```text
PENDING
```

---

# 5. Check merge against existing six defects

A new root cluster must not become a seventh/eighth/ninth defect if it is actually the same root behavior already represented by:

```text
RC-02-01
RC-02-02
RC-02-03
RC-03-01
RC-03-02
RC-03-03
```

For every new cluster record:

```text
OVERLAPS_EXISTING_DEFECT:
YES | NO

IF_YES:
EXISTING_DEFECT:
<DEF-ID / cluster>

MERGE_REASON:
...
```

Example already known:

```text
API02-STU-001
```

was resolved as failure but mapped to existing:

```text
RC-02-02
SUCCESSFUL_CHECKOUT_DOES_NOT_CLEAR_CART
```

That is NOT a new product defect.

Preserve it as supporting evidence for DEF-02.

---

# 6. Special review — RC-01-N03

Inspect the root cluster containing:

```text
API01-AI-035
```

Known observed evidence:

```text
read-only persistence verification found
persisted password == submitted plaintext password
```

Do not expose the actual password.

Check authoritative requirement:

```text
passwords must not be stored as plaintext
```

Validate:

```text
test setup was successful
correct disposable user was inspected
correct database was inspected
correct post-reset row was inspected
comparison did not accidentally compare against unrelated field
no test-data contamination explains the equality
```

If all are supported by actual evidence, recommend:

```text
CONFIRM_PRODUCT_DEFECT
```

Possible title:

```text
RESET_PASSWORD_STORES_PASSWORD_AS_PLAINTEXT
```

but use the actual evidence-derived title if more precise.

---

# 7. Evaluate evidence strength strictly

A cluster is `STRONG` only if:

```text
authoritative requirement
+
valid setup
+
real run-002 result
+
correct oracle
+
external evidence where necessary
+
no unresolved harness/test-data issue
```

If any point remains uncertain:

```text
MODERATE
```

or:

```text
WEAK
```

Do not inflate evidence strength.

---

# 8. Human triage recommendation

For the 3 clusters produce AI recommendation only.

Allowed values:

```text
CONFIRM_PRODUCT_DEFECT
MERGE_WITH_EXISTING_DEFECT
RECLASSIFY_TEST_DEFECT
RECLASSIFY_TEST_DATA_DEFECT
NEEDS_TARGETED_RERUN
REJECT_PRODUCT_DEFECT
```

Human decision:

```text
PENDING
```

Do not finalize new defects.

---

# 9. API01-AI-016 must remain non-product

Current blocker:

```text
API01-AI-016:
LEGITIMATE_EXPIRED_OTP_FIXTURE_UNAVAILABLE
```

Do not classify it as product defect.

Record:

```text
FINAL_CURRENT_STATUS:
BLOCKED_TEST_DATA

ROOT_CAUSE:
EXPIRED_OTP_FIXTURE_UNAVAILABLE

PRODUCT_INFERENCE_ALLOWED:
NO
```

Check whether this is fundamentally caused by:

```text
authoritative expiry duration not specified
```

or simply inability to deterministically create expired state.

Do not invent expiry duration.

Do not generate a fake expired OTP.

---

# 10. No further rerun plan unless absolutely required

The new candidate packet may recommend a future targeted rerun only if a cluster has `MODERATE/WEAK` evidence.

Do not run it now.

If all supported clusters are strong:

```text
ADDITIONAL_RERUN_REQUIRED:
NO
```

---

# 11. Existing six defect reports

Read:

```text
docs/defects/DEF-01-checkout-client-total-trusted.md
docs/defects/DEF-02-checkout-cart-not-cleared.md
docs/defects/DEF-03-checkout-auth-not-enforced.md
docs/defects/DEF-04-import-price-validation.md
docs/defects/DEF-05-import-not-atomic.md
docs/defects/DEF-06-import-admin-role.md
```

Do not change their confirmed root meaning.

You may enrich their evidence references using run-002 supporting cases where appropriate.

For example:

```text
API02-STU-001
```

may be added as supporting evidence for DEF-02.

Do not change primary run-001 evidence unless there is a compelling reason.

---

# 12. Genuine screenshot evidence requirement

Current:

```text
GENUINE_SCREENSHOTS_CREATED:
0
```

Attempt to create genuine screenshot evidence for the six confirmed defects.

Do not synthesize screenshots.

Do not render fake request/response text into an image and call it evidence.

Evidence must come from actual:

```text
run-001/newman.html
run-002/newman.html
real local HTML report
real execution evidence UI
```

---

# 13. Screenshot capture strategy

For each existing confirmed defect:

```text
DEF-01
DEF-02
DEF-03
DEF-04
DEF-05
DEF-06
```

open the genuine Newman HTML report at the representative case.

Capture at least:

```text
1 screenshot / confirmed defect
```

when tooling supports it.

Preferred content visible in screenshot:

```text
case ID
request/test name
failed assertion
actual result
response/status where useful
```

No secrets.

---

# 14. Screenshot paths

Use:

```text
docs/defects/screenshots/
```

Suggested stable names:

```text
DEF-01-API02-AI-002-newman.png
DEF-02-API02-AI-014-newman.png
DEF-03-API02-AI-022-newman.png
DEF-04-API03-AI-009-newman.png
DEF-05-API03-AI-017-newman.png
DEF-06-API03-AI-026-newman.png
```

Use actual corresponding case names if needed.

Do not overwrite unrelated evidence.

---

# 15. If screenshot tool is unavailable

Do not fabricate images.

For each defect create exact manual capture instruction:

```text
DEFECT:
DEF-01

REPORT:
test-results/hw06/run-001/newman.html

CASE:
API02-AI-002

CAPTURE:
failed assertion + actual response section

OUTPUT:
docs/defects/screenshots/DEF-01-API02-AI-002-newman.png
```

Create:

```text
docs/defects/screenshot-capture-plan.md
```

with instructions for all six.

Report:

```text
SCREENSHOT_AUTOMATION:
UNAVAILABLE

PENDING_HUMAN_CAPTURE:
6
```

---

# 16. External-state evidence screenshots

For defects requiring SQLite/state evidence:

do not fake terminal/database screenshots.

If genuine terminal/state capture is available, it may be used as secondary evidence.

Examples:

```text
cart still populated after successful checkout
partial import rows persisted
plaintext equality check
```

Redact:

```text
passwords
JWTs
student ID
personal information
```

If not captured, textual/JSON external verification evidence remains valid.

---

# 17. New defect screenshot policy

Do NOT create final screenshot folders/reports for the 3 new root clusters until Human confirms them.

However identify:

```text
RECOMMENDED_SCREENSHOT_SOURCE
RECOMMENDED_CASE
REPORT_PATH
```

for each new cluster so evidence can be captured immediately after Human approval.

---

# 18. Create new-cluster Human Review Packet

Create:

```text
docs/execution-results/run-002-new-defect-human-review-packet.md
```

Include:

```text
RUN-002 summary

9 candidate-case matrix

3 root clusters

overlap/merge analysis with existing six defects

evidence strength

recommended Human decision

recommended representative screenshot/evidence
```

---

# 19. Candidate-case matrix

All 9 candidate cases must appear:

```text
CASE_ID
API
ROOT_CLUSTER
REQUIREMENT
RUN_002_STATUS
OBSERVED_FAILURE
EXTERNAL_VERIFICATION
EVIDENCE_STRENGTH
AI_RECOMMENDATION
HUMAN_DECISION: PENDING
```

No omission.

---

# 20. Root-cluster Human Decision section

For each new cluster:

```text
HUMAN_DECISION:
PENDING
```

Future allowed values:

```text
CONFIRM_PRODUCT_DEFECT
MERGE_WITH_EXISTING_DEFECT
REJECT_PRODUCT_DEFECT
RECLASSIFY_TEST_DEFECT
RECLASSIFY_TEST_DATA_DEFECT
NEEDS_TARGETED_RERUN
```

Do not apply automatically.

---

# 21. Existing six defect screenshot matrix

Create/update:

```text
docs/defects/evidence-matrix.md
```

Rows:

```text
DEFECT_ID
ROOT_CLUSTER
PRIMARY_CASE
RUN
NEWMAN_JSON
NEWMAN_HTML
EXTERNAL_EVIDENCE
SCREENSHOT
SCREENSHOT_STATUS
```

For screenshot status:

```text
CAPTURED
PENDING_HUMAN_CAPTURE
NOT_REQUIRED
```

---

# 22. Do not create GitHub Issues

Still:

```text
GITHUB_ISSUES_CREATED:
0
```

Wait until Human review of new clusters and evidence completeness.

---

# 23. Do not start CI/CD

Still:

```text
CI_CD_STARTED:
NO
```

---

# 24. Do not create final Excel

Still:

```text
FINAL_EXCEL_CREATED:
NO
```

---

# 25. Git checkpoint

Current agent Git environment remains:

```text
PENDING_EXTERNAL_GIT_PERMISSION
```

Do not retry `.git/index.lock`.

Do not fabricate commit hashes.

Do not let Git block evidence review.

---

# 26. Continuous AI Audit

This interaction is substantive.

Finalize A-020 using the Human decision at the top.

After review/evidence preparation invoke:

```text
log-ai-audit
```

Record:

```text
exact prompt
exact substantive output

run-002 reviewed

9 new candidates

3 root clusters

merge analysis

RC-01-N03 review

API01-AI-016 blocked status

screenshot attempts
screenshots created
manual capture plan if needed

artifact paths
```

Do not log secrets.

Verify Audit entry.

Audit files stay unstaged.

---

# 27. Self-review

Before returning:

```text
[ ] A-020 finalized

[ ] run-001 unchanged
[ ] run-002 unchanged

[ ] exactly 9 new Product Defect Candidate cases reviewed
[ ] exactly 3 root clusters reconstructed
[ ] every cluster compared against existing 6 defects

[ ] API01-AI-035 external evidence reviewed carefully
[ ] no password value exposed

[ ] API01-AI-016 remains blocked/test-data, not product

[ ] evidence strength assigned
[ ] Human decisions remain PENDING

[ ] all six existing defect reports preserved

[ ] genuine screenshot capture attempted
[ ] no synthetic screenshots created
[ ] six screenshot statuses recorded
[ ] manual capture plan created if automation unavailable

[ ] no GitHub Issues
[ ] no rerun
[ ] no test modifications
[ ] no production modifications
[ ] no CI/CD
[ ] no final Excel

[ ] audit entry verified
[ ] audit files unstaged
```

---

# 28. Final output

Return:

```text
HW06_RUN_002_NEW_DEFECT_AND_EVIDENCE_REVIEW:
PASS | PARTIAL | FAIL

RUN_REVIEWED:
run-002

NEW_CANDIDATE_CASES_REVIEWED:
9

NEW_ROOT_CLUSTERS:
3

CLUSTER_01:

ID:
...

API:
...

HYPOTHESIS:
...

AFFECTED_CASES:
...

PRIMARY_CASE:
...

OVERLAPS_EXISTING_DEFECT:
YES | NO

IF_YES_EXISTING_DEFECT:
...

EVIDENCE_STRENGTH:
STRONG | MODERATE | WEAK

AI_RECOMMENDATION:
...

HUMAN_DECISION:
PENDING

CLUSTER_02:
...

CLUSTER_03:
...

API01_AI_035:

ROOT_CLUSTER:
...

PLAINTEXT_EQUALITY_EVIDENCE:
CONFIRMED | NOT_CONFIRMED

AI_RECOMMENDATION:
...

API01_AI_016:

STATUS:
BLOCKED_TEST_DATA

PRODUCT_INFERENCE:
NO

EXISTING_CONFIRMED_DEFECTS:
6

EXISTING_DEFECT_EVIDENCE:

DEF_01:
SCREENSHOT:
<path | PENDING_HUMAN_CAPTURE>

DEF_02:
SCREENSHOT:
...

DEF_03:
...

DEF_04:
...

DEF_05:
...

DEF_06:
...

GENUINE_SCREENSHOTS_CREATED:
<count>

SCREENSHOTS_PENDING_HUMAN_CAPTURE:
<count>

SCREENSHOT_CAPTURE_PLAN:
<path | NONE>

EVIDENCE_MATRIX:
docs/defects/evidence-matrix.md

NEW_CLUSTER_REVIEW_PACKET:
docs/execution-results/run-002-new-defect-human-review-packet.md

RERUN_PERFORMED:
NO

PRODUCTION_CODE_MODIFIED:
NO

GITHUB_ISSUES_CREATED:
0

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
HW06_RUN_002_NEW_DEFECT_HUMAN_DECISION_REQUIRED
```

Then STOP.

Do not confirm new product defects automatically.
Do not create GitHub Issues.
Do not rerun.
