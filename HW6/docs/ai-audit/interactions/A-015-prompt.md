External Newman tooling installation has been completed successfully by the Human.

Verified manually from HW6:

```text
NEWMAN_VERSION:
6.2.2

HTML_REPORTER:
newman-reporter-htmlextra 1.23.1

INSTALL_ROOT:
.tools/newman/

NEWMAN_EXECUTABLE:
.tools/newman/node_modules/.bin/newman.cmd
```

The npm installation completed successfully.

Deprecation warnings from transitive dependencies are informational only and are not a blocker for HW06 execution.

Previous checkpoint:

```text
NEWMAN_TOOLING_RECOVERY:
BLOCKED_FOR_EXTERNAL_INSTALL

AUDIT_ENTRY:
A-014 — AUDIT_ENTRY_VERIFIED

STUDENT_ID:
READY

CREDENTIALS:
READY

SUT:
PREPARED

POSTMAN_SUITE:
READY

FINAL_EXECUTABLE_TESTCASES:
93

PRE_EXECUTION_BLOCKED:
93

RUNTIME_ENVIRONMENT_DEFECTS:
0
```

Human decision:

```text
STUDENT_DECISION:
EXTERNAL_NEWMAN_TOOLING_VERIFIED

NEWMAN_TOOLING_BLOCKER:
RESOLVED

ACTION:
CONTINUE_REAL_HW06_EXECUTION
```

Use:

```text
postman-api-runner
hw06-api-workflow
log-ai-audit
```

This is a continuation.

Do not redo:

```text
requirement analysis
AI test generation
AI audit
human audit
Student Extension
Postman generation
static Postman validation
```

Do not reinstall Newman.

Do not upgrade packages.

---

# 1. Verify local tooling only

Verify the existing local executables:

```text
.tools/newman/node_modules/.bin/newman.cmd
```

and reporter package:

```text
.tools/newman/node_modules/newman-reporter-htmlextra/
```

Expected:

```text
NEWMAN_VERSION:
6.2.2

HTML_REPORTER:
newman-reporter-htmlextra 1.23.1
```

Use the local Newman executable explicitly for all execution.

Do not use global Newman.

Do not run another:

```text
npm install
npm update
npm audit fix
```

---

# 2. Tooling folders are runtime-only

Treat:

```text
.tools/newman/
.tools/npm-cache/
.tools/npm-prefix/
.tools/tmp/
```

as local tooling/cache.

Ensure these paths are excluded from normal HW06 commits/submission where appropriate.

Do not stage or commit the package cache/node_modules.

Do not let Git permission issues block runtime execution.

---

# 3. Finalize A-014 tooling recovery

Record:

```text
EXTERNAL_TOOLING_INSTALL:
COMPLETED_BY_HUMAN

NEWMAN:
AVAILABLE

HTML_REPORTER:
AVAILABLE

TOOLING_BLOCKER:
RESOLVED
```

Finalize the previous tooling interaction according to continuous AI Audit policy.

Do not expose secrets or the actual Student ID.

Keep:

```text
docs/ai-audit/
```

unstaged.

---

# 4. Preserve prior preflights

Preserve:

```text
preflight-001
preflight-002
```

Do not overwrite them.

Historical interpretation:

```text
REAL_REQUESTS_EXECUTED:
0

PRE_EXECUTION_BLOCKED:
93

RUNTIME_ENVIRONMENT_DEFECTS:
0
```

Do not rewrite them as runtime test failures.

---

# 5. Create preflight-003

Before starting real execution create a fresh execution preflight:

```text
preflight-003
```

Verify:

```text
studentId:
READY / NON_EMPTY

normal user:
READY

second user:
READY

admin:
READY

reset user:
READY

runtime Postman environment:
READY

Newman:
6.2.2

HTML reporter:
newman-reporter-htmlextra 1.23.1

SUT startup strategy:
READY

SQLite homework database:
SAFE LOCAL TEST DATABASE
```

Runtime environment already prepared:

```text
test-results/hw06/runtime/HW06-Local.runtime.postman_environment.json
```

Verify that this runtime environment is not intended for Git commit.

---

# 6. Runtime X-Student-Id guard

Static result already passed:

```text
103/103
```

Before sending any real SUT request verify runtime:

```text
studentId != empty
```

and every SUT request resolves:

```http
X-Student-Id: {{studentId}}
```

including:

```text
setup requests
login requests
fixture requests
testcase requests
postcondition/helper requests
```

Do not log the actual Student ID unless absolutely required.

---

# 7. Start SUT

Prepared SUT command:

```text
node server.js
```

Expected base URL:

```text
http://localhost:3000
```

Expected local database:

```text
SQLite
../eshop-sut/backend/database.sqlite
```

Start the backend from the correct backend working directory.

Record:

```text
SUT_WORKDIR
SUT_START_COMMAND
SUT_PID
SUT_STDOUT
SUT_STDERR
```

Wait until the intended EShop backend is actually ready.

Do not accept an unrelated process on port 3000.

Do not modify production source code.

---

# 8. SUT startup failure rule

If startup fails:

diagnose first.

Allowed fixes:

```text
missing runtime env
wrong working directory
wrong startup command
non-production harness/config issue
```

Forbidden:

```text
editing business logic
changing endpoint behavior
modifying requirements
changing DB schema to satisfy tests
```

If production code itself is broken, preserve evidence and stop for Human review.

---

# 9. Run real smoke first

After preflight-003 passes and SUT is ready, run a genuine smoke.

Create:

```text
smoke-001
```

or next unused smoke ID.

Cover at least:

### API-01

```text
forgot/reset setup
+
one valid reset-password flow
```

### API-02

```text
normal-user login
+
cart setup
+
one checkout flow
```

### API-03

```text
admin login
+
one valid import-products flow
```

This smoke must send actual HTTP requests to the local SUT.

Every request must contain resolved `X-Student-Id`.

---

# 10. Smoke evidence

Preserve genuine smoke artifacts:

```text
stdout
stderr
Newman JSON if generated
HTML if generated
execution metadata
```

Do not fabricate missing files.

---

# 11. Smoke failure classification

Classify failures as:

```text
HARNESS_DEFECT
TEST_DATA_DEFECT
ENVIRONMENT_DEFECT
PRODUCT_DEFECT_CANDIDATE
```

Do not call a setup or Postman-script error a product defect.

---

# 12. Harness-only fixes allowed

Allowed:

```text
Postman variable scope
runtime token assignment
setup request chaining
fixture naming
test-data filepath
Newman command syntax
reporter flags
Postman script syntax
request helper ordering
```

Do not change:

```text
requirement oracle
expected business result
security expectation
production code
```

If smoke needs a harness fix:

preserve `smoke-001`,
apply only the legitimate harness correction,
then run:

```text
smoke-002
```

Record exactly what changed.

---

# 13. Full execution gate

Run the full suite only when smoke demonstrates that:

```text
SUT is reachable
auth setup works
fixtures work
Postman scripts work
stable case IDs are preserved
X-Student-Id resolves
Newman/reporters work
```

Then execute all final testcase identities.

Expected:

```text
API-01: 30
API-02: 30
API-03: 33

TOTAL: 93
```

Collection structure:

```text
POSTMAN_TESTCASE_IDENTITIES:
93

POSTMAN_TOTAL_REQUESTS:
103
```

Do not confuse helper requests with testcases.

---

# 14. Use local Newman explicitly

Use the real local executable equivalent to:

```text
.tools/newman/node_modules/.bin/newman.cmd
```

against:

```text
postman/collections/HW06-API-Testing.postman_collection.json
```

with:

```text
test-results/hw06/runtime/HW06-Local.runtime.postman_environment.json
```

Use reporters:

```text
cli
json
htmlextra
```

where supported by the verified installed versions.

Record the exact final Newman command in execution metadata.

---

# 15. Real execution evidence

Create:

```text
test-results/hw06/run-001/
```

or the next unused real run ID.

Preserve genuine:

```text
newman.json
newman.html
stdout.log
stderr.log
execution-metadata.md
```

If htmlextra produces another filename, preserve the actual filename.

No synthetic reports.

---

# 16. Avoid data multiplication

Confirm test data wiring does NOT accidentally produce:

```text
93 × all data rows
```

The full execution must still map to exactly:

```text
93 testcase identities
```

Setup/helper requests may make total raw requests larger.

---

# 17. Account for every testcase

Every final testcase receives one state:

```text
PASS
FAIL
POSTMAN_PASS_EXTERNAL_PENDING
BLOCKED
NOT_RUN
```

Accounting must satisfy:

```text
API-01 total = 30
API-02 total = 30
API-03 total = 33

TOTAL = 93
```

No testcase may disappear from reporting.

---

# 18. External verification

Approved external verification plan:

```text
docs/postman/external-verification-plan.md
```

Planned:

```text
26 cases
```

Perform legitimate external verification where supported by the isolated local environment.

Do not automatically turn Newman PASS into final PASS when a testcase requires external verification.

---

# 19. SQLite verification policy

The SUT uses a local homework SQLite database.

Read-only DB inspection is allowed where required by the approved plan.

Prefer:

```text
read-only SQL
existing DB helper
Python sqlite3 read-only inspection
existing Node DB access
```

Do not directly mutate database rows to make a test pass.

---

# 20. API-01 external checks

For applicable password-storage cases verify:

```text
persisted password != supplied plaintext password
```

Do not print the plaintext password.

Evidence should use safe indicators such as:

```text
PLAINTEXT_EQUAL:
YES | NO
```

OTP lifecycle/state checks may also use legitimate state inspection where required.

---

# 21. API-02 external checks

API-02 has the largest external-verification set.

Verify only requirement-backed invariants such as:

```text
server-derived total
client total not authoritative
cart clear after successful checkout
cross-user/cart isolation
```

For persisted total:

compare actual persisted value against an independently derived cart total.

Do not use:

```text
coupon behavior
idempotency
initial order status
shipping-address validation
```

as invented direct oracle.

---

# 22. API-03 external checks

For atomic import rollback:

```text
capture baseline
send mixed-invalid batch
inspect post-state
```

Expected when applicable:

```text
none of the invalid batch products persisted
```

Do not infer atomicity only from error response.

---

# 23. External-verification statuses

Use:

```text
PASS
FAIL
PENDING
BLOCKED
```

Mapping:

```text
Postman pass
+
external pass
=
PASS
```

```text
Postman pass
+
external unavailable
=
POSTMAN_PASS_EXTERNAL_PENDING
```

```text
Postman pass
+
requirement-backed external invariant fails
=
FAIL
+
PRODUCT_DEFECT_CANDIDATE
```

---

# 24. Preliminary runtime classification

For non-final successful cases use:

```text
PRODUCT_DEFECT_CANDIDATE
TEST_DEFECT
TEST_DATA_DEFECT
ENVIRONMENT_DEFECT
SPEC_AMBIGUITY
EXTERNAL_VERIFICATION_PENDING
NEEDS_HUMAN_REVIEW
```

Do NOT use final:

```text
PRODUCT_DEFECT
```

in this interaction.

---

# 25. Product defect candidate guard

Only classify:

```text
PRODUCT_DEFECT_CANDIDATE
```

when all are true:

```text
authoritative requirement exists
oracle is valid
setup/test data is valid
actual execution occurred
failure contradicts requirement
evidence is preserved
```

Otherwise classify more conservatively.

---

# 26. Preserve meaningful failures

Do not repeatedly change the suite until green.

If `run-001` exposes harness/test-data problems that justify a rerun:

preserve `run-001`.

Then run:

```text
run-002
```

Record:

```text
WHY_RERUN
WHAT_CHANGED
PREVIOUS_FAILURE_CLASSIFICATION
```

Never erase the first meaningful run.

---

# 27. Do not modify product code

Forbidden:

```text
password hashing fixes
OTP fixes
checkout total fixes
cart-clearing fixes
authorization fixes
import transaction fixes
validation fixes
schema changes
```

This phase is testing only.

---

# 28. Update execution reports

Update:

```text
docs/execution-results/api-01-reset-password-execution.md
docs/execution-results/api-02-checkout-execution.md
docs/execution-results/api-03-import-products-execution.md
docs/execution-results/cross-api-execution-summary.md
```

Distinguish clearly:

```text
preflight-001
preflight-002
preflight-003
smoke run(s)
full run(s)
```

---

# 29. Failure triage packet

If any of these exist:

```text
PRODUCT_DEFECT_CANDIDATE
TEST_DEFECT
SPEC_AMBIGUITY
NEEDS_HUMAN_REVIEW
```

create/update:

```text
docs/execution-results/failure-triage-packet.md
```

Each entry:

```text
CASE_ID
API
SOURCE
REQUIREMENT
ORACLE
SETUP
REQUEST SUMMARY
OBSERVED RESULT
EXPECTED INVARIANT
POSTMAN ASSERTION
EXTERNAL VERIFICATION
PRELIMINARY CLASSIFICATION
EVIDENCE PATHS

HUMAN_DECISION:
PENDING
```

Do not create GitHub Issues.

---

# 30. Runtime X-Student-Id evidence

After real execution report:

```text
TOTAL_REAL_SUT_REQUESTS:
<n>

X_STUDENT_ID_RUNTIME_COVERAGE:
<n>/<n>

MISSING_OR_EMPTY:
[]
```

Target:

```text
100%
```

Do not expose the ID value.

---

# 31. Git permission remains separate

Current `.git` write blocker remains an environment issue.

Do not retry unsafe permission changes.

Do not let it block execution.

Keep:

```text
GIT_CHECKPOINT_STATUS:
PENDING_EXTERNAL_GIT_PERMISSION
```

unless Human later provides real external commit information.

---

# 32. No later phases yet

Do not start:

```text
GitHub Issues
CI/CD
final Excel
final report
product fixes
```

Human Failure Triage is the next content checkpoint.

---

# 33. Continuous AI Audit

After real execution and preliminary triage use:

```text
log-ai-audit
```

Record:

```text
exact prompt
exact substantive output
Human external Newman verification
Newman 6.2.2
htmlextra 1.23.1
preflight-003
SUT startup
smoke IDs
harness corrections
full-run IDs
Newman command
runtime results
external verification results
preliminary classifications
evidence paths
Git checkpoint state
```

Do not record secrets or actual Student ID.

Verify the new audit entry.

Keep Audit files unstaged.

---

# 34. Self-review

Before stopping verify:

```text
[ ] Newman 6.2.2 verified locally
[ ] htmlextra 1.23.1 verified
[ ] no reinstall performed

[ ] A-014 finalized
[ ] preflight-001 preserved
[ ] preflight-002 preserved
[ ] preflight-003 completed

[ ] studentId non-empty
[ ] credentials ready
[ ] SUT local DB safe
[ ] SUT genuinely running

[ ] runtime X-Student-Id valid
[ ] smoke genuinely executed
[ ] harness corrections documented

[ ] full suite executed only after usable smoke
[ ] exactly 93 testcase identities accounted for

[ ] genuine newman.json
[ ] genuine newman.html
[ ] genuine stdout/stderr
[ ] exact Newman command recorded

[ ] 26 external-verification cases accounted for
[ ] pending external cases not falsely marked PASS

[ ] PRODUCT_DEFECT_FINAL = 0
[ ] no production code modified
[ ] no GitHub Issues
[ ] no CI/CD
[ ] no final Excel

[ ] audit entry verified
[ ] audit files unstaged
```

---

# 35. Final output

Return:

```text
HW06_REAL_EXECUTION_AFTER_TOOLING:
PASS | PARTIAL | FAIL | BLOCKED

TOOLING:

NEWMAN:
AVAILABLE

NEWMAN_VERSION:
6.2.2

HTML_REPORTER:
newman-reporter-htmlextra 1.23.1

PREVIOUS_PREFLIGHTS:
preflight-001 — PRESERVED
preflight-002 — PRESERVED

RECOVERY_PREFLIGHT:
preflight-003

SUT:
STATUS:
START_COMMAND:
BASE_URL:

SMOKE:
RUN_ID:
STATUS:
HARNESS_CORRECTIONS:

FULL_EXECUTION:
RUN | NOT_RUN

RUN_ID:
...

FINAL_EXECUTABLE_TESTCASES:
93

RESULTS:

API_01:
TOTAL: 30
PASS:
FAIL:
POSTMAN_PASS_EXTERNAL_PENDING:
BLOCKED:
NOT_RUN:

API_02:
TOTAL: 30
PASS:
FAIL:
POSTMAN_PASS_EXTERNAL_PENDING:
BLOCKED:
NOT_RUN:

API_03:
TOTAL: 33
PASS:
FAIL:
POSTMAN_PASS_EXTERNAL_PENDING:
BLOCKED:
NOT_RUN:

TOTAL:
TOTAL: 93
PASS:
FAIL:
POSTMAN_PASS_EXTERNAL_PENDING:
BLOCKED:
NOT_RUN:

EXTERNAL_VERIFICATION:
PLANNED: 26
COMPLETED:
PASSED:
FAILED:
PENDING:
BLOCKED:

PRELIMINARY_CLASSIFICATION:

PRODUCT_DEFECT_CANDIDATE:
TEST_DEFECT:
TEST_DATA_DEFECT:
ENVIRONMENT_DEFECT:
SPEC_AMBIGUITY:
EXTERNAL_VERIFICATION_PENDING:
NEEDS_HUMAN_REVIEW:

PRODUCT_DEFECT_FINAL:
0

EVIDENCE:

NEWMAN_JSON:
...

NEWMAN_HTML:
...

STDOUT:
...

STDERR:
...

EXECUTION_METADATA:
...

FAILURE_TRIAGE_PACKET:
...

API_01_REPORT:
...

API_02_REPORT:
...

API_03_REPORT:
...

CROSS_API_SUMMARY:
...

REAL_REQUESTS_EXECUTED:
YES | NO

TOTAL_REAL_SUT_REQUESTS:
...

X_STUDENT_ID_RUNTIME_COVERAGE:
<n>/<n>

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
HW06_EXECUTION_FAILURE_TRIAGE_REQUIRED
```

Then STOP.

Do not fix product code.
Do not create GitHub Issues.
Do not start CI/CD.
