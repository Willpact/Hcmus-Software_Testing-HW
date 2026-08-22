Postman implementation đã hoàn tất static validation và được Human approve để chuyển sang real execution.

Current approved state:

```text id="ak2xsu"
POSTMAN_IMPLEMENTATION:
APPROVED_FOR_REAL_EXECUTION

FINAL_EXECUTABLE_TESTCASES:
93

POSTMAN_TESTCASE_IDENTITIES:
93

POSTMAN_TESTCASE_COVERAGE:
93/93

POSTMAN_TOTAL_REQUESTS:
103

TOTAL_SUT_REQUESTS:
103

X_STUDENT_ID_COVERAGE:
103/103

STATIC_VALIDATION:
PASS

INVALID_CASES_INCLUDED:
0

DEFERRED_CASES_INCLUDED_AS_BLOCKING:
0

REJECTED_STUDENT_CASES_INCLUDED:
0
```

Student Extension:

```text id="kj1ox0"
API-01: 5 APPROVED
API-02: 5 APPROVED
API-03: 5 APPROVED
TOTAL: 15
```

Current Git checkpoint:

```text id="egspno"
STUDENT_EXTENSION_COMMIT:
PENDING_EXTERNAL_GIT_PERMISSION

MANIFEST:
docs/git/student-extension-commit-manifest.md
```

This is an environment-only Git blocker.

Do not let it block real API execution.

Use:

```text id="8tju6s"
postman-api-runner
hw06-api-workflow
log-ai-audit
```

Main objectives:

```text id="6syuc8"
1. Finalize previous Postman implementation human approval in AI Audit
2. Perform execution preflight
3. Start/verify SUT safely
4. Run real Postman/Newman execution
5. Preserve raw execution evidence
6. Perform supported external verification
7. Classify failures preliminarily
8. Produce cross-API execution summaries
9. Audit the interaction
10. STOP for Human Failure Triage
```

Do not fix production defects.

Do not create GitHub Issues yet.

Do not start CI/CD yet.

---

# 1. Finalize previous Human Review

Record:

```text id="pco4uu"
STUDENT_DECISION:
POSTMAN_IMPLEMENTATION_APPROVED_FOR_REAL_EXECUTION

POSTMAN_STATIC_VALIDATION:
PASS

TESTCASE_COVERAGE:
93/93

X_STUDENT_ID_COVERAGE:
103/103

GIT_CHECKPOINT:
PENDING_EXTERNAL_GIT_PERMISSION

GIT_BLOCKER_TYPE:
ENVIRONMENT_ONLY
```

Finalize A-011 or the corresponding current interaction according to `log-ai-audit`.

Verify before substantive execution.

Do not stage Audit files.

---

# 2. Preserve Git blocker state

Do not repeatedly retry Git writes if the current sandbox still cannot write:

```text id="ryxko8"
.git/index.lock
```

Do not run unsafe permission commands.

Keep:

```text id="x6xcu6"
GIT_CHECKPOINT_STATUS:
PENDING_EXTERNAL_GIT_PERMISSION
```

The human will perform pending commits in an external terminal/context with repository Git permissions.

Do not fabricate commit hashes.

---

# 3. Execution inputs

Use the actual generated artifacts:

```text id="vva1lr"
postman/collections/HW06-API-Testing.postman_collection.json

postman/environments/HW06-Local.postman_environment.json

postman/data/api-01-reset-password.json
postman/data/api-02-checkout.json
postman/data/api-03-import-products.json

docs/postman/execution-manifest.md
docs/postman/external-verification-plan.md

test-cases/final/
```

Before execution revalidate that these artifacts still correspond to the approved versions.

---

# 4. Student ID guard

Before any SUT request is sent, verify:

```text id="nbjhz4"
studentId variable:
PRESENT
NON_EMPTY
```

Do not log the value unnecessarily.

Every SUT request must resolve:

```http id="6hve33"
X-Student-Id: {{studentId}}
```

If the runtime environment has no usable student ID:

```text id="5n6uvy"
EXECUTION_STATUS:
BLOCKED

BLOCKER:
STUDENT_ID_NOT_CONFIGURED
```

and STOP before sending assignment requests.

Do not invent a Student ID.

---

# 5. Secret guard

Before execution verify necessary disposable/test credentials are available.

Examples:

```text id="wtvd8k"
userEmail
userPassword

otherUserEmail
otherUserPassword

adminEmail
adminPassword

resetEmail

studentId
```

Tokens may be dynamically obtained through setup/login.

Do not hardcode or commit secrets.

Do not print sensitive values into reports unless absolutely required; redact where appropriate.

---

# 6. Tool availability preflight

Determine actual installed/runtime tools:

```text id="7m1on4"
node --version
npm --version
newman --version
```

and HTML reporter availability if planned.

Do not install unrelated dependencies globally unless needed.

If Newman is repository-local, use the repository-supported invocation.

If Newman is unavailable but npm installation is permitted and repository policy supports it, install the minimum required dependency in the appropriate local context.

Record exact versions used.

---

# 7. SUT preflight

Verify:

```text id="njcszo"
baseUrl:
http://localhost:3000
```

unless environment configuration specifies an approved equivalent.

Determine whether SUT is already running.

If running:

* verify it belongs to the intended EShop SUT;
* do not restart unnecessarily.

If not running:

* use repository-documented startup procedure;
* start only required backend services;
* record startup command/process;
* wait for readiness.

Do not modify production source code to make execution pass.

---

# 8. Database/test-data safety

This is a test SUT.

Before destructive/state-changing test execution:

* identify test database/environment;
* avoid production or unrelated user data;
* use disposable fixtures;
* record baseline if required by external verification plan.

Do not execute import/reset/checkout against a non-test environment.

If environment cannot be confirmed safe:

```text id="cdolp2"
EXECUTION_STATUS:
BLOCKED

BLOCKER:
TEST_ENVIRONMENT_SAFETY_UNCONFIRMED
```

and STOP.

---

# 9. Deterministic baseline/reset

Inspect existing repository mechanisms for:

```text id="qb3qcn"
seed
reset
fixture creation
database initialization
```

Use existing supported mechanisms where possible.

Do not invent a destructive reset command.

Prepare deterministic state for:

```text id="mquqct"
API-01 reset-password
API-02 checkout/cart
API-03 import-products
```

Document any unavoidable shared-state dependencies.

---

# 10. Real execution strategy

Execute all three API suites.

Preferred order:

```text id="pm090t"
API-01
↓
API-02
↓
API-03
```

unless collection dependencies require another documented order.

Do not execute all 93 blindly if a setup/environment failure immediately invalidates the entire run.

Use an initial smoke/preflight subset to verify:

```text id="71b9mh"
authentication
environment resolution
X-Student-Id
setup flow
collection scripting
```

before full run.

---

# 11. Smoke execution

Run a minimal representative set first.

Smoke should cover at least:

```text id="w85q9y"
API-01:
one setup + one valid reset flow

API-02:
login/cart setup + one checkout case

API-03:
admin auth + one import case
```

Smoke purpose:

```text id="uc1vc9"
verify harness/environment
```

not assignment evidence completeness.

Record:

```text id="2suvwn"
SMOKE:
PASS | FAIL
```

If smoke fails due harness/environment:

do not run full suite until resolved.

Harness-only corrections are allowed if they do not alter requirement oracle/test semantics.

---

# 12. Harness correction policy

Allowed before full run:

```text id="zj6u12"
environment variable wiring
setup request chaining
Postman script syntax
fixture naming
incorrect variable scope
Newman CLI arguments
reporter configuration
test data path resolution
```

Not allowed:

```text id="ncwl95"
changing expected business behavior to match implementation
removing legitimate failing tests
weakening security assertions
changing authoritative oracle
editing production SUT to pass
```

Every harness correction must be documented.

If a correction changes substantive testcase meaning:

```text id="n42qmy"
STOP_FOR_HUMAN_REVIEW
```

---

# 13. Preserve failed original execution

Do not erase a failed meaningful execution after fixing harness defects.

For each run preserve:

```text id="fut7tv"
run identifier
timestamp
collection version/hash if practical
environment used
Newman command
stdout
stderr
JSON/JUnit report if available
HTML report
```

A harness-failed smoke may be labeled separately and need not be treated as product evidence.

---

# 14. Full Newman execution

After smoke passes, run the real suite.

Prefer a machine-readable report plus HTML.

Suggested artifact structure:

```text id="t0b0ys"
test-results/hw06/
├── smoke/
├── run-001/
│   ├── newman.json
│   ├── newman.html
│   ├── stdout.log
│   ├── stderr.log
│   └── execution-metadata.md
└── ...
```

Use repository convention if equivalent exists.

Do not fake HTML results.

---

# 15. Execution identity

Each Newman result must remain traceable to stable case ID.

Request names already follow:

```text id="6dts90"
[CASE-ID] Title
```

Verify reports preserve enough identity to map result → testcase.

If helpers/setup requests appear as separate requests, distinguish them from testcase identities.

---

# 16. Result statuses

For each final executable testcase classify runtime state initially as one of:

```text id="nbe8n3"
PASS
FAIL
BLOCKED
NOT_RUN
POSTMAN_PASS_EXTERNAL_PENDING
```

Meaning:

### PASS

All required Postman-observable assertions pass and no external verification remains.

### POSTMAN_PASS_EXTERNAL_PENDING

Postman portion passed, but testcase requires external verification before final verdict.

### FAIL

A requirement-backed assertion failed.

### BLOCKED

Environment/test-data/setup prevents meaningful execution.

### NOT_RUN

No meaningful execution occurred.

---

# 17. External verification is mandatory where planned

Current execution modes include many:

```text id="xd1aos"
POSTMAN_PLUS_EXTERNAL_VERIFICATION
```

Do not turn Postman success into final PASS automatically.

Particularly API-02 has many external-verification cases.

Follow:

```text id="35a9b5"
docs/postman/external-verification-plan.md
```

for each such testcase.

---

# 18. External verification safety

Only perform external verification using legitimate test-environment access already available in the repository/runtime.

Examples:

```text id="gl8dve"
documented GET APIs
test database query
repository test helper
isolated state inspection
```

Do not add hidden production-only endpoints.

Do not modify source code to expose sensitive DB state merely for homework evidence unless the assignment explicitly permits it and Human approves.

If a verification mechanism is unavailable:

```text id="rgebhc"
FINAL_RUNTIME_STATUS:
POSTMAN_PASS_EXTERNAL_PENDING
```

or `BLOCKED` depending case semantics.

Record the limitation.

---

# 19. API-01 external verification

Potential examples include:

```text id="f5enbw"
password persistence is not plaintext
OTP persisted/invalidation state
```

For SEC-01:

do not claim PASS unless actual persisted value is inspected via legitimate isolated test mechanism.

Redact actual password values from evidence.

---

# 20. API-02 external verification

Pay particular attention to:

```text id="6jkyb8"
server-calculated/persisted total
cart clearing
cross-user isolation
order persistence/state where actually required
```

The authoritative rule is that client-supplied `total_amount` must not be trusted as final authority.

Do not infer server-side recalculation merely from a success response.

If persisted/calculated amount cannot be independently observed:

mark external verification pending.

---

# 21. API-03 external verification

For atomic rollback:

```text id="89qly3"
baseline product state
↓
mixed-invalid batch
↓
post-state
```

must demonstrate no partial products persisted.

Do not call rollback PASS solely because the endpoint returned an error string.

---

# 22. Do not invent strict transport failures

If exact status code was intentionally unspecified by authoritative source, a different HTTP status alone must not create a testcase failure unless:

* it prevents the authoritative business invariant from being evaluated; or
* an authoritative requirement defines that status.

Preserve observed statuses for evidence.

---

# 23. Preliminary failure classification

For every non-PASS case classify preliminary cause:

```text id="9b0b9z"
PRODUCT_DEFECT_CANDIDATE
TEST_DEFECT
TEST_DATA_DEFECT
ENVIRONMENT_DEFECT
SPEC_AMBIGUITY
EXTERNAL_VERIFICATION_PENDING
NEEDS_HUMAN_REVIEW
```

Do not classify anything directly as:

```text id="2zcqvv"
PRODUCT_DEFECT
```

in this phase.

Only:

```text id="19awn1"
PRODUCT_DEFECT_CANDIDATE
```

until Human triage.

---

# 24. Product defect candidate threshold

Use `PRODUCT_DEFECT_CANDIDATE` only when:

```text id="qh34th"
1. authoritative requirement exists;
2. setup/test data is verified;
3. harness assertion is correct;
4. failure is reproducible or evidence is strong;
5. result contradicts requirement-backed behavior.
```

Otherwise choose another classification.

---

# 25. Expected discrepancy areas

Approved requirement analysis identified potential discrepancies.

Pay special attention to execution evidence around:

### API-01

```text id="okmhwy"
confirmation/API contract gap
plaintext password storage
OTP length/expiry implementation
```

Do not declare defects for unresolved contract gaps.

### API-02

```text id="2l6gdv"
client total directly trusted
cart not cleared
checkout not derived from cart
```

### API-03

```text id="b1k6mm"
admin role enforcement
missing item validation
lack of atomic rollback
```

These are **investigation targets**, not predetermined failures.

Do not bias results to confirm them.

---

# 26. Runtime evidence

For meaningful failures preserve:

```text id="xb6l7g"
CASE_ID
request metadata
non-secret request data
response status
relevant response body
assertion failure
pre-state
post-state when applicable
external verification result
timestamp
run ID
```

Do not store real secrets in evidence.

---

# 27. Evidence screenshots

Do not fabricate screenshots.

If automated HTML/Newman reports exist, preserve the actual files.

Only create screenshot evidence if there is an actual runtime UI/report/page and the workflow/tooling supports genuine capture.

Do not manufacture a screenshot from text.

Bug screenshots are for confirmed defects later.

---

# 28. Per-API execution reports

Create:

```text id="p7shmn"
docs/execution-results/
├── api-01-reset-password-execution.md
├── api-02-checkout-execution.md
├── api-03-import-products-execution.md
└── cross-api-execution-summary.md
```

Each API report must contain:

```text id="akj14i"
TOTAL_EXECUTABLE
PASS
FAIL
POSTMAN_PASS_EXTERNAL_PENDING
BLOCKED
NOT_RUN

PRODUCT_DEFECT_CANDIDATE
TEST_DEFECT
TEST_DATA_DEFECT
ENVIRONMENT_DEFECT
SPEC_AMBIGUITY
EXTERNAL_VERIFICATION_PENDING
NEEDS_HUMAN_REVIEW
```

---

# 29. Do not silently rerun until green

A failing requirement-backed case must not be repeatedly altered until it passes.

If rerun is necessary:

record why.

Maintain:

```text id="qqy7m4"
run-001
run-002
...
```

and preserve original meaningful failure evidence.

---

# 30. Do not fix production code

Absolutely do not:

```text id="k5tqga"
edit backend production behavior
patch endpoint to satisfy testcase
change database schema
add role checks
add transaction handling
hash passwords
clear carts
```

in this phase.

Testing and evidence only.

---

# 31. Do not create GitHub Issues yet

Even if a failure looks obvious:

```text id="avlv9w"
PRODUCT_DEFECT_CANDIDATE
```

only.

Human will review the candidate evidence first.

After Human confirms:

```text id="k761vd"
PRODUCT_DEFECT
```

then bug Markdown/GitHub Issue can be created.

---

# 32. No CI/CD yet

Do not create or execute CI/CD workflow.

First obtain a stable local Newman execution and human-triaged failures.

---

# 33. No final Excel yet

Do not generate final Excel workbook yet.

Execution results may still change after human triage/harness correction.

---

# 34. Postman artifacts Git state

Current Postman artifacts were uncommitted at the previous checkpoint.

Because Git is externally blocked in this sandbox:

do not invent commit hashes.

Prepare an exact pending commit manifest after successful Human-reviewed execution preparation if needed.

Do not let Git permission block runtime testing.

---

# 35. Execution audit

After execution and preliminary triage:

use:

```text id="x88s4s"
log-ai-audit
```

Record exact:

```text id="dqhu2b"
prompt
substantive output
commands/invocations
Newman version
SUT/baseUrl
run IDs
execution result counts
preliminary failure classifications
external verification limitations
artifact paths
Git permission state
```

Verify Audit entry.

Audit files remain unstaged.

---

# 36. Human Review boundary

This phase must STOP before:

```text id="h6u9wp"
final PRODUCT_DEFECT confirmation
bug report creation
GitHub Issues
production fix
CI/CD
final Excel/report
```

Human must review failure candidates first.

---

# 37. Self-review

Before finishing verify:

```text id="en5kzq"
[ ] Previous Postman human approval finalized
[ ] studentId configured before SUT requests
[ ] X-Student-Id remains present
[ ] Test environment confirmed safe

[ ] Tool versions recorded
[ ] SUT availability verified
[ ] Smoke executed
[ ] Smoke harness issues resolved legitimately or execution stopped

[ ] Full execution actually performed if smoke passed
[ ] Raw Newman evidence preserved
[ ] Stable testcase IDs map to results

[ ] All 93 final cases accounted for:
    PASS
    FAIL
    POSTMAN_PASS_EXTERNAL_PENDING
    BLOCKED
    NOT_RUN

[ ] External verification performed where legitimately available
[ ] External pending cases not falsely marked PASS

[ ] No unsupported HTTP status used as sole failure oracle
[ ] No implementation behavior promoted to requirement

[ ] Preliminary classifications assigned
[ ] No PRODUCT_DEFECT final classifications made

[ ] No production code modified
[ ] No GitHub Issue created
[ ] No CI/CD started
[ ] No final Excel created

[ ] Audit entry verified
[ ] Audit files unstaged
```

---

# 38. Output cuối phiên

Return:

```text id="dq64op"
HW06_REAL_API_EXECUTION:
PASS | PARTIAL | FAIL | BLOCKED

PREFLIGHT:

STUDENT_ID_CONFIGURED:
YES | NO

TEST_ENVIRONMENT_SAFE:
YES | NO

NEWMAN_VERSION:
...

SUT:
RUNNING | STARTED | FAILED

BASE_URL:
...

SMOKE:
PASS | FAIL | BLOCKED

SMOKE_HARNESS_CORRECTIONS:
<count + brief list>

FULL_EXECUTION:
RUN | NOT_RUN

RUN_ID:
...

FINAL_EXECUTABLE_TESTCASES:
93

RESULTS:

API_01:
TOTAL:
PASS:
FAIL:
POSTMAN_PASS_EXTERNAL_PENDING:
BLOCKED:
NOT_RUN:

API_02:
TOTAL:
PASS:
FAIL:
POSTMAN_PASS_EXTERNAL_PENDING:
BLOCKED:
NOT_RUN:

API_03:
TOTAL:
PASS:
FAIL:
POSTMAN_PASS_EXTERNAL_PENDING:
BLOCKED:
NOT_RUN:

TOTAL:
PASS:
FAIL:
POSTMAN_PASS_EXTERNAL_PENDING:
BLOCKED:
NOT_RUN:

PRELIMINARY_FAILURE_CLASSIFICATION:

PRODUCT_DEFECT_CANDIDATE:
<count>

TEST_DEFECT:
<count>

TEST_DATA_DEFECT:
<count>

ENVIRONMENT_DEFECT:
<count>

SPEC_AMBIGUITY:
<count>

EXTERNAL_VERIFICATION_PENDING:
<count>

NEEDS_HUMAN_REVIEW:
<count>

PRODUCT_DEFECT_FINAL:
0

EXTERNAL_VERIFICATION:

PLANNED:
<count>

COMPLETED:
<count>

PASSED:
<count>

FAILED:
<count>

PENDING:
<count>

ARTIFACTS:

NEWMAN_JSON:
...

NEWMAN_HTML:
...

STDOUT:
...

STDERR:
...

API_01_REPORT:
...

API_02_REPORT:
...

API_03_REPORT:
...

CROSS_API_SUMMARY:
...

PRODUCTION_CODE_MODIFIED:
NO

GITHUB_ISSUES_CREATED:
0

CI_CD_STARTED:
NO

FINAL_EXCEL_CREATED:
NO

GIT_CHECKPOINT_STATUS:
PENDING_EXTERNAL_GIT_PERMISSION | <other real state>

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
