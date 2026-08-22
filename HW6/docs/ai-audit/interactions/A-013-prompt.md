Current HW06 real execution was correctly blocked during preflight before any real SUT request was sent.

Current state:

```text
HW06_REAL_API_EXECUTION:
BLOCKED

PREFLIGHT_ID:
preflight-001

STUDENT_ID_CONFIGURED:
NO

REQUIRED_DISPOSABLE_CREDENTIALS_CONFIGURED:
NO

NEWMAN_VERSION:
UNAVAILABLE

SUT:
NOT_STARTED

REAL_REQUESTS_EXECUTED:
NO

FINAL_EXECUTABLE_TESTCASES:
93

EXTERNAL_VERIFICATION_PLANNED:
26

AUDIT_ENTRY:
A-012 — AUDIT_ENTRY_VERIFIED
```

Use:

```text
postman-api-runner
hw06-api-workflow
log-ai-audit
```

This is a continuation/recovery workflow.

Do not discard or overwrite `preflight-001`.

Do not regenerate the test suite or Postman collection.

Main objectives:

```text
1. Finalize the blocked-preflight human decision
2. Recover runtime configuration safely
3. Resolve studentId if already available from trusted project context
4. Resolve disposable test credentials from documented seed/test mechanisms
5. Install/resolve Newman locally
6. Start the local SUT
7. Run a real smoke
8. Correct harness-only problems if needed
9. Run the full 93-case suite
10. Perform legitimate external verification where possible
11. Produce real Newman evidence
12. Perform preliminary failure classification
13. Audit the complete interaction
14. STOP for Human Failure Triage
```

Do not modify production behavior.

Do not create GitHub Issues.

Do not start CI/CD.

---

# 1. Record Human Recovery Decision

Human decision:

```text
STUDENT_DECISION:
PREFLIGHT_BLOCK_ACCEPTED

PREVIOUS_EXECUTION:
VALID_BLOCKED_PREFLIGHT

ACTION:
RECOVER_RUNTIME_CONFIGURATION_AND_RETRY

POLICY:
Resolve every configuration/tooling issue that can be safely resolved by the agent.
Only ask for human input when a required value cannot be established from trusted existing project configuration.

PRESERVE_PREFLIGHT_001:
YES
```

Finalize A-012 or the corresponding interaction according to continuous audit policy.

Do not modify its historical meaning.

Verify the audit update.

Keep `docs/ai-audit/` unstaged.

---

# 2. Preserve preflight-001

Do not overwrite:

```text
test-results/hw06/preflight-001/
```

It is legitimate evidence that the first execution attempt was blocked before sending requests.

Create new recovery/runtime artifacts separately.

Suggested IDs:

```text
preflight-002
smoke-001
run-001
```

Use repository convention if equivalent exists.

---

# 3. Resolve studentId carefully

The assignment requires every SUT request to carry:

```http
X-Student-Id: {{studentId}}
```

Do NOT invent a Student ID.

Search only trusted existing project context for an already explicitly configured student ID.

Possible trusted locations:

```text
HW6 Postman environments
HW6 assignment metadata
existing homework configuration
repository-local student metadata
previous committed Postman/environment files
```

Do not infer it from:

```text
Windows username
email
Git author
folder name
random numeric values
```

If exactly one explicit student ID is already present and clearly belongs to this student's homework configuration:

use it as the runtime `studentId`.

Do not unnecessarily print the full value in logs/reports.

Report only:

```text
STUDENT_ID_SOURCE:
<path/config source>

STUDENT_ID_CONFIGURED:
YES
```

If no unambiguous trusted Student ID exists:

```text
EXECUTION_RECOVERY_STATUS:
BLOCKED_FOR_HUMAN_INPUT

ONLY_REQUIRED_HUMAN_INPUT:
studentId
```

Then continue resolving Newman/credentials/SUT preparation where possible, but do not send SUT requests.

At final output clearly ask Human to provide/configure only the missing `studentId`.

---

# 4. Runtime environment must not expose secrets

Do not place real credentials/tokens into committed example environments.

Keep committed/template environment safe.

If runtime secrets are needed, create a runtime-only environment such as:

```text
test-results/hw06/runtime/HW06-Local.runtime.postman_environment.json
```

or an equivalent ignored/local artifact.

Ensure it is not intended for Git commit.

Use safe values in:

```text
postman/environments/HW06-Local.example.postman_environment.json
```

Never write secrets into AI Audit output.

---

# 5. Resolve disposable credentials from SUT

Inspect documented/local SUT mechanisms for:

```text
seed users
seed admin
database initializer
test accounts
registration flow
fixture scripts
```

Prefer existing disposable/test accounts.

Determine credentials needed for:

```text
normal user
second normal user
admin
reset-password user
```

Do not use personal or production accounts.

If passwords are defined by local seed/test fixtures, load them into runtime variables without printing secrets into reports.

If normal disposable users can safely be created through the documented register endpoint:

that may be used after `studentId` is configured and the SUT is running.

Remember: those setup SUT requests must also carry `X-Student-Id`.

---

# 6. Admin credential rule

Do not fabricate an admin JWT.

Resolve admin access only through:

```text
documented seed account
documented test fixture
documented local DB initialization
legitimate admin login credentials in test configuration
```

Do not manually forge JWT claims.

If no legitimate admin fixture can be obtained:

report:

```text
ADMIN_TEST_FIXTURE_BLOCKED:
YES
```

and do not falsely execute API-03 as a valid admin.

---

# 7. Inspect local database setup

The previous preflight identified a local SQLite homework database.

Record:

```text
DATABASE_TYPE:
SQLite

DATABASE_PATH:
<actual local test path>
```

Confirm it belongs to the local homework SUT.

Do not expose unrelated databases.

Use the database only for legitimate isolated test setup/external verification.

Do not alter production schema.

---

# 8. Resolve Newman locally

Current:

```text
NEWMAN_VERSION:
UNAVAILABLE
```

Inspect:

```text
package.json
package-lock.json
node_modules
repository scripts
```

for existing Newman support.

Preferred order:

```text
1. Existing local Newman dependency
2. Existing repository npm script
3. Install Newman as a local development dependency where appropriate
```

Do not rely on a global installation if local/reproducible installation is possible.

If installation is needed, prefer:

```bash
npm install --save-dev newman
```

in the appropriate HW6/tooling scope.

For HTML evidence, inspect whether an HTML reporter already exists.

If necessary and compatible, install a local reporter such as the project-supported Newman HTML reporter.

Do not install unrelated packages.

Record exact versions.

---

# 9. Newman verification

After resolution, require:

```text
NEWMAN_AVAILABLE:
YES

NEWMAN_VERSION:
<actual>
```

Run only a version/help check before SUT execution.

Do not count that as API execution.

---

# 10. Start the SUT

Inspect repository documentation/package scripts.

Use the documented startup mechanism.

Do not modify backend source code.

Start only required backend services.

Base URL expected:

```text
http://localhost:3000
```

Wait for readiness.

Confirm the listener belongs to the intended EShop SUT.

Do not treat a random process on port 3000 as valid.

Record:

```text
SUT_START_COMMAND:
...

SUT_PID:
...

SUT_READY:
YES | NO
```

If SUT startup fails:

preserve stdout/stderr and classify:

```text
ENVIRONMENT_DEFECT
```

Do not change production source merely to start it.

---

# 11. Runtime configuration guard

Before first SUT request require:

```text
[ ] studentId non-empty
[ ] baseUrl correct
[ ] disposable normal-user strategy available
[ ] disposable second-user strategy available where needed
[ ] admin fixture available for API-03
[ ] reset-password fixture available
[ ] Newman available
[ ] SUT ready
[ ] test database confirmed local/safe
```

If any mandatory prerequisite prevents meaningful execution:

stop before sending test requests and report the smallest remaining blocker set.

---

# 12. X-Student-Id runtime guard

Static validation previously reported:

```text
103/103
```

Before execution also inspect runtime-resolved request headers.

Every SUT setup/helper/test request must carry:

```http
X-Student-Id: <resolved non-empty value>
```

Do not log the actual ID unless required.

If any SUT request would be missing/empty:

fix harness/configuration before execution.

---

# 13. Smoke-001

Once all mandatory configuration is ready, run a small real smoke.

Smoke must prove harness/runtime health, not assignment completeness.

At minimum cover:

### API-01

```text
setup/reset fixture
+
one valid reset flow
```

### API-02

```text
login
+
cart setup
+
one meaningful checkout flow
```

### API-03

```text
admin login/auth
+
one valid import flow
```

All SUT requests must include `X-Student-Id`.

Preserve actual smoke output.

---

# 14. Smoke classification

If smoke fails, distinguish:

```text
HARNESS_DEFECT
TEST_DATA_DEFECT
ENVIRONMENT_DEFECT
PRODUCT_DEFECT_CANDIDATE
```

Do not treat harness/config failures as product failures.

---

# 15. Harness-only correction allowed

Allowed:

```text
wrong variable scope
incorrect Postman environment wiring
missing runtime token assignment
incorrect setup chaining
incorrect Newman CLI path
incorrect reporter arguments
incorrect test-data filepath
Postman script syntax problem
request helper sequencing
```

Not allowed:

```text
changing authoritative expected behavior
weakening a failing requirement assertion
removing legitimate tests
changing expected business result to match SUT
editing backend implementation
```

Record every harness-only correction.

---

# 16. Preserve original smoke failure

If `smoke-001` produces a meaningful failure before a harness fix:

preserve it.

If the failure is purely harness/configuration and is corrected:

create:

```text
smoke-002
```

Do not silently overwrite `smoke-001`.

---

# 17. Full execution criteria

Run full suite only when smoke demonstrates:

```text
environment resolution works
authentication setup works
test fixtures work
stable IDs appear in results
X-Student-Id resolves
Newman collection scripts execute
```

Then run all:

```text
93 final executable testcase identities
```

---

# 18. Run-001 evidence

Create a real run directory such as:

```text
test-results/hw06/run-001/
```

Preserve at least:

```text
newman.json
newman.html
stdout.log
stderr.log
execution-metadata.md
```

If the available reporter produces a differently named HTML file, record the actual path.

Do not fake missing artifacts.

---

# 19. Execution metadata

Record:

```text
run ID
date/time
Node version
npm version
Newman version
HTML reporter/version if used
baseUrl
collection path
environment path
test data paths
SUT startup method
database/test fixture context
studentId configured YES/NO without exposing it unnecessarily
collection checksum/hash where practical
```

---

# 20. Account for all 93 cases

After run:

```text
API-01 total = 30
API-02 total = 30
API-03 total = 33

TOTAL = 93
```

Each case must be exactly one of:

```text
PASS
FAIL
POSTMAN_PASS_EXTERNAL_PENDING
BLOCKED
NOT_RUN
```

No case disappears.

---

# 21. Do not confuse helper requests with testcase results

Collection contains:

```text
93 testcase identities
103 total SUT requests
```

Setup/helper requests may fail and block related testcases.

Report separately:

```text
POSTMAN_TOTAL_REQUESTS
POSTMAN_TESTCASE_IDENTITIES
```

Do not claim 103 testcase results.

---

# 22. External verification plan

Current planned external verification:

```text
26 cases
```

Use:

```text
docs/postman/external-verification-plan.md
```

For each case determine whether external verification can be performed legitimately in the local test environment.

---

# 23. SQLite external verification

Because the SUT uses a local homework SQLite database, read-only state inspection may be used where required by the approved external verification plan.

Use legitimate techniques such as:

```text
SQLite CLI if installed
Node SQLite dependency already used by SUT
Python sqlite3 read-only inspection
repository-supported DB helper
```

Prefer read-only verification queries.

Do not mutate database state directly merely to make tests pass.

Test setup should use supported application/fixture mechanisms wherever possible.

---

# 24. API-01 external verification

For password-storage security cases:

verify the persisted password representation only when:

```text
local isolated DB
known disposable reset user
safe read-only inspection
```

Expected invariant:

```text
persisted_password != supplied plaintext password
```

Do not expose the password itself in evidence.

Report redacted evidence, e.g.:

```text
PLAINTEXT_EQUAL:
YES | NO
```

not raw secret values.

---

# 25. API-02 external verification

API-02 has many externally verified cases.

Use legitimate DB/cart/API state inspection for requirements such as:

```text
server-trusted total
cart clearing
cross-user isolation
persisted order state where relevant
```

Be careful:

only verify invariants actually required by the testcase.

Do not introduce new oracle assumptions.

For manipulated `total_amount`:

the critical requirement is that client value must not be accepted as authoritative total.

If database order record can be inspected safely, compare persisted amount with:

```text
cart-derived authoritative expected amount
```

not merely with client input.

---

# 26. API-03 external verification

For atomic rollback:

create uniquely identifiable disposable products in each test batch.

Capture baseline.

Run invalid batch.

Read post-state.

Expected invariant:

```text
none of the batch products persisted
```

when authoritative FR-16 atomic rollback applies.

Do not use category/duplicate/precision gaps as hard oracle.

---

# 27. External result states

For each planned external case:

```text
EXTERNAL_VERIFICATION:
PASS
FAIL
PENDING
BLOCKED
```

Then determine final testcase result.

Example:

```text
Postman assertions pass
+
external verification pass
=
PASS
```

```text
Postman assertions pass
+
external verification unavailable
=
POSTMAN_PASS_EXTERNAL_PENDING
```

```text
Postman assertions pass
+
requirement-backed external invariant fails
=
FAIL
+
PRODUCT_DEFECT_CANDIDATE
```

---

# 28. Never manufacture external evidence

Do not write expected DB rows into a Markdown file and call that verification.

The evidence must come from actual observed state.

Record queries/check method where appropriate, while redacting secrets.

---

# 29. Preliminary failure classification

For every FAIL/BLOCKED/non-final case classify:

```text
PRODUCT_DEFECT_CANDIDATE
TEST_DEFECT
TEST_DATA_DEFECT
ENVIRONMENT_DEFECT
SPEC_AMBIGUITY
EXTERNAL_VERIFICATION_PENDING
NEEDS_HUMAN_REVIEW
```

Do not use final:

```text
PRODUCT_DEFECT
```

yet.

---

# 30. Strong defect-candidate guard

`PRODUCT_DEFECT_CANDIDATE` requires:

```text
AUTHORITATIVE requirement
+
correct testcase oracle
+
valid deterministic setup
+
actual real execution
+
evidence contradicting requirement
```

If any of these are uncertain:

use:

```text
NEEDS_HUMAN_REVIEW
```

or another appropriate non-product category.

---

# 31. Important expected investigation targets

Do not predetermine outcomes, but pay close attention to requirement-backed areas already identified:

### API-01

```text
password storage not plaintext
OTP lifecycle/invalidation
OTP characteristics where directly authoritative
```

Do not classify confirmation/expiry-duration gaps as defects.

### API-02

```text
server recalculates total from cart
client total not trusted
successful checkout clears cart
checkout/cart relationship
```

### API-03

```text
admin role enforcement
positive price/name validation
atomic rollback
```

---

# 32. Preserve failures

Do not rerun only until green and discard failures.

If a rerun is required after harness/test-data correction:

use new run ID:

```text
run-002
```

Preserve `run-001`.

Document:

```text
WHY_RERUN
WHAT_CHANGED
CLASSIFICATION_OF_PREVIOUS_FAILURE
```

---

# 33. Do not patch product code

Forbidden:

```text
hash passwords
fix OTP generation
add checkout cart calculation
clear cart
add admin authorization
add transaction rollback
add validations
change DB schema
```

Testing only.

---

# 34. Generate execution reports

Update/create:

```text
docs/execution-results/api-01-reset-password-execution.md
docs/execution-results/api-02-checkout-execution.md
docs/execution-results/api-03-import-products-execution.md
docs/execution-results/cross-api-execution-summary.md
```

Do not overwrite the existence of `preflight-001`.

Reports should distinguish:

```text
PREVIOUS_BLOCKED_PREFLIGHT
CURRENT_REAL_RUN
```

---

# 35. Failure candidate packet

If any:

```text
PRODUCT_DEFECT_CANDIDATE
NEEDS_HUMAN_REVIEW
SPEC_AMBIGUITY
```

exists, create:

```text
docs/execution-results/failure-triage-packet.md
```

For each candidate include:

```text
CASE_ID
API
SOURCE
REQUIREMENT
TEST ORACLE
SETUP
REQUEST SUMMARY
OBSERVED RESULT
EXPECTED INVARIANT
POSTMAN ASSERTION RESULT
EXTERNAL VERIFICATION RESULT
EVIDENCE PATHS
PRELIMINARY CLASSIFICATION
WHY HUMAN REVIEW IS NEEDED
```

Do not create GitHub Issue.

---

# 36. Newman HTML requirement

The assignment ultimately requires Newman/HTML evidence.

If full run occurs, produce a genuine HTML report from the actual Newman execution.

If HTML reporter installation is impossible:

preserve JSON/JUnit evidence and report:

```text
HTML_REPORT_BLOCKER:
...
```

Do not fabricate an HTML report from synthetic data.

---

# 37. Git permission blocker

The sandbox still may not be able to write repository `.git`.

Do not spend repeated retries on this.

Do not fabricate commits.

Keep:

```text
GIT_CHECKPOINT_STATUS:
PENDING_EXTERNAL_GIT_PERMISSION
```

and update pending commit manifests if new execution/Postman artifacts eventually need human external commit.

Content/runtime execution is allowed to proceed.

---

# 38. No GitHub Issues

Even if obvious real failures are found:

```text
GITHUB_ISSUES_CREATED:
0
```

until Human triage.

---

# 39. No CI/CD

Still:

```text
CI_CD_STARTED:
NO
```

Local execution must be stabilized and triaged first.

---

# 40. No final Excel

Still:

```text
FINAL_EXCEL_CREATED:
NO
```

Execution verdicts are not human-final until failure triage.

---

# 41. Continuous AI Audit

After recovery/execution, use:

```text
log-ai-audit
```

Record:

```text
exact prompt
exact substantive output
human recovery decision
studentId source/configured status
credential source strategy
Newman installation/version
SUT startup
smoke run IDs
harness-only corrections
full Newman run IDs
result counts
external verification outcomes
preliminary classifications
artifact paths
Git permission blocker state
```

Do not include actual secrets/passwords/tokens.

Verify entry.

Audit files remain unstaged.

---

# 42. Self-review

Before returning:

```text
[ ] preflight-001 preserved
[ ] A-012 finalized correctly

[ ] studentId discovered from trusted config OR execution clearly blocked for only human studentId input
[ ] no studentId invented

[ ] disposable accounts resolved safely
[ ] admin fixture legitimate
[ ] reset fixture legitimate
[ ] runtime secrets not committed/logged

[ ] Newman resolved or exact blocker documented
[ ] SUT started using documented mechanism
[ ] local test DB confirmed safe

[ ] every real SUT request has non-empty X-Student-Id
[ ] smoke genuinely executed if prerequisites satisfied
[ ] harness corrections documented

[ ] full suite executed only after smoke success
[ ] all 93 cases accounted for
[ ] helper requests not confused with testcase identities

[ ] Newman JSON genuine
[ ] Newman HTML genuine if available
[ ] stdout/stderr preserved

[ ] 26 external-verification cases accounted for
[ ] no external pending case falsely marked PASS
[ ] SQLite evidence is actual observed state

[ ] failures classified preliminarily
[ ] PRODUCT_DEFECT_FINAL remains 0
[ ] no product code changed
[ ] no GitHub Issues
[ ] no CI/CD
[ ] no final Excel

[ ] audit entry verified
[ ] audit files unstaged
```

---

# 43. Final output when execution succeeds or partially succeeds

Return:

```text
HW06_EXECUTION_RECOVERY:
PASS | PARTIAL | BLOCKED | FAIL

PREVIOUS_PREFLIGHT:
preflight-001 — PRESERVED

RECOVERY_PREFLIGHT:
preflight-002

STUDENT_ID:
CONFIGURED: YES | NO
SOURCE: <trusted source | HUMAN_INPUT_REQUIRED>

CREDENTIALS:
NORMAL_USER: READY | BLOCKED
SECOND_USER: READY | BLOCKED
ADMIN: READY | BLOCKED
RESET_USER: READY | BLOCKED

TOOLS:
NODE_VERSION:
NPM_VERSION:
NEWMAN_VERSION:
HTML_REPORTER:

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
<path | NOT_CREATED>

NEWMAN_HTML:
<path | NOT_CREATED>

STDOUT:
<path | NOT_CREATED>

STDERR:
<path | NOT_CREATED>

FAILURE_TRIAGE_PACKET:
<path | NONE>

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

If the only unresolved prerequisite is `studentId`, instead return a minimal blocked result:

```text
HW06_EXECUTION_RECOVERY:
BLOCKED

READY:
NEWMAN: YES
SUT_PREPARED: YES
CREDENTIAL_STRATEGY: YES

ONLY_BLOCKER:
STUDENT_ID_HUMAN_INPUT_REQUIRED

REAL_REQUESTS_EXECUTED:
NO

NEXT_CHECKPOINT:
STUDENT_ID_CONFIGURATION_REQUIRED
```

Then STOP.

Do not invent the value.
