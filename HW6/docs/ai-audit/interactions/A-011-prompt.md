Current workflow stopped because of an environment-level Git permission blocker.

Current state:

```text
STUDENT_EXTENSION_FINALIZATION_AND_POSTMAN_BUILD:
PARTIAL

WORKFLOW_STATUS:
BLOCKED

STUDENT_EXTENSION:
API-01: 5 APPROVED
API-02: 5 APPROVED
API-03: 5 APPROVED
TOTAL: 15 APPROVED

STUDENT_EXTENSION_COMMIT:
NOT_CREATED

FINAL_EXECUTABLE_SUITE:
NOT_CREATED

POSTMAN:
NOT_CREATED

AUDIT_ENTRY:
A-010 — AUDIT_ENTRY_VERIFIED

BLOCKER:
GIT_INDEX_WRITE_DENIED

DETAIL:
Unable to create repository .git/index.lock.
Current sandbox/filesystem profile permits writes inside HW6,
while repository .git metadata is outside the writable scope.
```

Use:

```text
hw06-api-workflow
postman-api-runner
log-ai-audit
```

This is a **recovery continuation**, not a restart.

Do not redo approved work.

---

# 1. Record Human Recovery Decision

Human decision:

```text
STUDENT_DECISION:
CONTINUE_WITH_GIT_PERMISSION_RECOVERY

STUDENT_EXTENSION:
APPROVED

GIT_BLOCKER:
ENVIRONMENT_PERMISSION_BLOCKER

POLICY:
Attempt a safe Git commit if permission escalation is supported.
If Git metadata remains unwritable, preserve an exact pending commit manifest
and continue non-Git Postman implementation work.

DO_NOT:
discard approved Student Extension
regenerate Student Extension
block all remaining non-Git work solely because .git is read-only
```

Finalize the previous interaction if required by continuous audit policy.

Do not rewrite A-010.

---

# 2. Diagnose Git blocker minimally

Determine:

```text
REPOSITORY_ROOT:
...

CURRENT_WORKDIR:
...

GIT_DIR:
...

HW6_PATH:
...
```

Verify that the issue is specifically inability to write:

```text
.git/index.lock
```

and not:

* stale existing index.lock;
* another Git process;
* corrupted repository;
* invalid repo root.

Do not delete `.git/index.lock` unless an actual stale lock exists and the environment permits safe deletion.

Do not modify unrelated homework directories.

---

# 3. Attempt safe Git permission escalation if supported

If the agent runtime supports an explicit elevated/expanded filesystem approval mechanism for Git operations, request/use that mechanism only for the necessary Git commands.

Attempt to perform the intended Student Extension commit.

Do not weaken sandbox protection globally.

Do not alter system permissions recursively.

Do not run unsafe commands such as:

```text
chmod -R 777
takeown /r
icacls ... /grant Everyone:F /t
```

Do not rewrite `.git`.

---

# 4. Student Extension commit target

The intended logical commit is:

```text
test(HW6): finalize student-added API test cases
```

Stage only finalized Student Extension/review artifacts that belong to this checkpoint.

Do not stage:

```text
docs/ai-audit/
```

Do not stage unrelated HW3/HW4/HW5 files.

Before commit use HW6-scoped inspection equivalent to:

```bash
git status --short -- .
git diff --cached --name-status -- .
```

If commit succeeds:

```text
STUDENT_EXTENSION_COMMIT:
<hash>
```

and continue.

---

# 5. Fallback when Git metadata remains read-only

If permission escalation is unavailable or Git still cannot write `.git/index`:

DO NOT remain globally blocked.

Set:

```text
STUDENT_EXTENSION_COMMIT:
PENDING_EXTERNAL_GIT_PERMISSION

GIT_BLOCKER:
ENVIRONMENT_PERMISSION_ONLY

SUBSTANTIVE_WORK_CAN_CONTINUE:
YES
```

Create:

```text
docs/git/student-extension-commit-manifest.md
```

containing:

```text
INTENDED_COMMIT:
test(HW6): finalize student-added API test cases

FILES_TO_COMMIT:
<exact HW6-relative files>

FILES_EXPLICITLY_EXCLUDED:
docs/ai-audit/
<other unrelated files if any>

PRE_COMMIT_CHECK:
git status --short -- .
git diff --cached --name-status -- .

COMMIT_COMMAND:
git commit -m "test(HW6): finalize student-added API test cases"

STATUS:
PENDING_EXTERNAL_GIT_PERMISSION
```

Also include exact staging commands using explicit paths.

Do not use:

```bash
git add -A
```

Do not use broad root-level staging.

---

# 6. Important workflow decision

A Git permission blocker must **not** prevent generation of non-Git artifacts inside writable HW6.

Therefore after either:

```text
STUDENT_EXTENSION_COMMIT:
<hash>
```

OR:

```text
STUDENT_EXTENSION_COMMIT:
PENDING_EXTERNAL_GIT_PERMISSION
```

continue with:

```text
FINAL EXECUTABLE INVENTORY
POSTMAN IMPLEMENTATION
STATIC VALIDATION
```

Real execution remains forbidden.

---

# 7. Finalize Student Extension state

Ensure final approved Student Extension remains:

```text
API-01:
5 APPROVED

API-02:
5 APPROVED
API02-STU-004:
REJECTED_HISTORY_ONLY
API02-STU-006:
APPROVED_REPLACEMENT

API-03:
5 APPROVED
API03-STU-005:
REJECTED_HISTORY_ONLY
API03-STU-006:
APPROVED_REPLACEMENT

TOTAL:
15 APPROVED
```

Do not regenerate any Student cases.

Do not change their semantics.

---

# 8. Build final executable inventory

Build the unified executable inventory from:

```text
test-cases/corrected/
test-cases/student-added/
```

Exclude:

```text
INVALID
DEFERRED_REQUIREMENT_GAP
REJECTED Student Extension cases
```

Create:

```text
test-cases/final/
├── api-01-reset-password.json
├── api-02-checkout.json
├── api-03-import-products.json
└── cross-api-final-summary.json
```

Create human-readable summary:

```text
docs/test-suite/final-executable-suite.md
```

if not already present.

---

# 9. Do not artificially force >=35 final executable cases

Raw AI generation already satisfied:

```text
40 AI-generated cases / API
```

Do not create filler because corrected executable counts are lower.

Recalculate actual counts.

Report per API:

```text
RAW_AI_GENERATED:
AI_CORRECTED_EXECUTABLE:
STUDENT_ADDED_APPROVED:
TOTAL_EXECUTABLE:
DEFERRED:
INVALID_REMOVED:
```

---

# 10. Execution-mode classification

Each final executable test must be classified:

```text
POSTMAN_DIRECT
POSTMAN_WITH_PRECONDITION_SETUP
POSTMAN_PLUS_EXTERNAL_VERIFICATION
```

If something is not executable with a meaningful oracle, it must not silently remain in the blocking executable inventory.

For `POSTMAN_PLUS_EXTERNAL_VERIFICATION`, record the external verification requirement explicitly.

---

# 11. Generate Postman artifacts

Create:

```text
postman/
├── collections/
│   └── HW06-API-Testing.postman_collection.json
├── environments/
│   ├── HW06-Local.postman_environment.json
│   └── HW06-Local.example.postman_environment.json
├── data/
│   ├── api-01-reset-password.json
│   ├── api-02-checkout.json
│   └── api-03-import-products.json
└── README.md
```

Use repository convention if an equivalent structure already exists.

One collection should contain:

```text
HW06 API Testing

├── API-01 Reset Password
│   ├── Setup
│   └── Test Cases

├── API-02 Checkout
│   ├── Setup
│   └── Test Cases

└── API-03 Import Products
    ├── Setup
    └── Test Cases
```

---

# 12. Mandatory X-Student-Id

Every executable assignment API request must resolve:

```http
X-Student-Id: {{studentId}}
```

Prefer collection-level inheritance/pre-request behavior when safe.

Environment must define:

```text
studentId
```

Do not hardcode the real student ID into individual requests when an environment variable can be used.

Static target:

```text
X_STUDENT_ID_COVERAGE:
100%
```

---

# 13. Environment variables

Support appropriate variables such as:

```text
baseUrl
studentId

userEmail
userPassword
userToken

otherUserEmail
otherUserToken

adminEmail
adminPassword
adminToken

resetEmail
resetToken
newPassword

shippingAddress

productId
categoryId

testRunId
```

Use:

```text
http://localhost:3000
```

as local base URL if consistent with the approved API specification.

Do not commit real JWTs/passwords/secrets.

---

# 14. Stable testcase identity

Every final executable Postman testcase must map back to exactly one stable case ID.

Request names should follow:

```text
[CASE-ID] Test title
```

Examples:

```text
[API01-AI-014] ...
[API01-STU-001] ...

[API02-AI-...] ...
[API02-STU-006] ...

[API03-AI-...] ...
[API03-STU-006] ...
```

Do not renumber surviving cases.

Do not hide gaps in IDs.

---

# 15. Request descriptions

Each test request description should contain:

```text
CASE_ID
SOURCE
REQUIREMENT_IDS
PRIMARY_TECHNIQUE
ORACLE_BASIS
EXECUTION_MODE
SETUP_REQUIREMENTS
EXTERNAL_VERIFICATION
```

where applicable.

---

# 16. API-01 implementation

Selected endpoint:

```text
POST /api/reset-password
```

Use documented:

```text
POST /api/forgot-password
```

as setup where a real issued OTP is required.

Do not assume reset-password requires JWT.

Use disposable fixtures.

Do not store real secrets.

Implement requirement-backed assertions for:

```text
email/token binding
one-time OTP lifecycle
valid reset state transition
password policy where authoritative
```

---

# 17. API-01 external verification

Password persistence/plaintext checks must be:

```text
POSTMAN_PLUS_EXTERNAL_VERIFICATION
```

unless an actual test-access mechanism exists.

Do not fake DB assertions inside Postman.

---

# 18. API-02 implementation

Selected endpoint:

```text
POST /api/checkout
```

Use documented cart/auth flows for deterministic preconditions.

Prioritize:

```text
valid authentication
server-side total calculation
client-total trust boundary
cart-derived total
successful checkout cart clearing
user/cart isolation
```

Do not invent:

```text
empty-cart policy
shipping-address limits
coupon integration
idempotency behavior
initial order status
```

---

# 19. API-02 state verification

Where cart can be queried before/after:

implement legitimate setup/postcondition requests.

For example:

```text
SETUP:
populate cart

PRECHECK:
verify expected cart state

ACTION:
checkout

POSTCHECK:
verify cart cleared after confirmed successful checkout
```

Keep testcase-to-evidence traceability.

---

# 20. API-02 external verification

If authoritative persisted total or cross-user state cannot be verified through documented APIs:

mark:

```text
POSTMAN_PLUS_EXTERNAL_VERIFICATION
```

Do not claim response-only verification proves persistence.

---

# 21. API-03 implementation

Selected endpoint:

```text
POST /api/admin/import-products
```

Request representation:

```json
{
  "products": [...]
}
```

Do not add raw CSV multipart tests.

Use:

```text
adminToken
userToken
```

appropriately for authorization cases.

---

# 22. API-03 assertions

Cover authoritative behavior:

```text
admin role enforcement
non-admin denial
name non-empty
price positive
atomic all-or-nothing import
success/error counts and reasons
```

Do not invent exact response field names where unspecified.

Prefer state/business assertions.

---

# 23. API-03 rollback verification

For atomicity:

```text
capture baseline
send mixed-invalid batch
verify no batch products persisted
```

If Postman cannot verify persistence through legitimate API access:

mark:

```text
POSTMAN_PLUS_EXTERNAL_VERIFICATION
```

Do not report rollback PASS from HTTP response alone.

---

# 24. External verification plan

Create:

```text
docs/postman/external-verification-plan.md
```

For every final case requiring external verification record:

```text
CASE_ID
API
POSTMAN_VERIFICATION
EXTERNAL_VERIFICATION
VERIFICATION_METHOD
EXPECTED_INVARIANT
EVIDENCE_REQUIRED
```

Do not execute it yet.

---

# 25. Execution manifest

Create:

```text
docs/postman/execution-manifest.md
```

One row per final executable testcase:

```text
CASE_ID
SOURCE
API
TECHNIQUE
POSTMAN_REQUEST
EXECUTION_MODE
SETUP_REQUIRED
EXTERNAL_VERIFICATION
REQUIREMENT_IDS
```

Every final executable test appears exactly once.

---

# 26. Setup design

Prefer reusable setup:

```text
login normal user
login second user
login admin
issue reset OTP
prepare cart
capture cart
capture product state
generate unique testRunId
```

Avoid duplicating identical setup logic into every test unnecessarily.

However ensure individual testcase result traceability remains clear.

---

# 27. Isolation rules

Do not create hidden order dependency.

Each test should be independently reproducible unless state-transition sequence itself requires ordering.

Record:

```text
ORDER_DEPENDENT:
YES | NO
```

If yes:

```text
DEPENDENCY:
...
```

---

# 28. Static Postman validation only

Do not send network traffic.

Validate structurally:

```text
Collection JSON parseable
Environment JSON parseable
All final case IDs represented
Stable IDs unique
Request names unique
Correct methods
Correct paths
Correct auth strategy
No invalid cases
No deferred blocking cases
No rejected Student cases
All 15 approved Student cases present
X-Student-Id inherited/resolved for every assignment request
No real secrets embedded
```

---

# 29. X-Student-Id audit

Report:

```text
TOTAL_EXECUTABLE_TESTCASES:
...

POSTMAN_TESTCASE_COVERAGE:
<n>/<n>

TOTAL_ASSIGNMENT_REQUESTS:
...

X_STUDENT_ID_COVERAGE:
<n>/<n>

MISSING_X_STUDENT_ID:
[]
```

Do not count setup requests incorrectly.

If setup requests are part of HW06 tested SUT requests and assignment requires the header on every request, include the header there too.

Prefer 100% across all SUT API requests in the collection.

---

# 30. Postman testcase coverage must be 1:1

The number of Postman **testcase identities** must equal final executable inventory.

Setup/helper requests may increase total raw request count.

Therefore distinguish:

```text
FINAL_EXECUTABLE_TESTCASES
POSTMAN_TESTCASE_IDENTITIES
POSTMAN_TOTAL_REQUESTS
```

Required:

```text
POSTMAN_TESTCASE_IDENTITIES
=
FINAL_EXECUTABLE_TESTCASES
```

Do not incorrectly demand total raw Postman request count equals testcase count because setup/helper requests may exist.

---

# 31. Do not execute

Explicitly forbidden:

```text
start SUT
restart backend
curl selected endpoints
send Postman requests
run Postman Runner
run Newman
generate HTML report
create runtime screenshots
classify runtime failures
create bug report
create GitHub Issues
```

No real network execution.

---

# 32. Git policy for newly generated Postman artifacts

Do not commit:

```text
postman/
docs/postman/
test-cases/final/
docs/test-suite/
```

yet.

These require human review first.

If Student Extension commit remains pending due Git permission:

Postman work may still proceed, but all new implementation artifacts remain uncommitted as well.

Do not push.

---

# 33. Continuous AI Audit

This recovery interaction is substantive.

After completion:

use `log-ai-audit`.

Record:

```text
exact prompt
exact substantive output
Git permission blocker
whether permission escalation was available
Student Extension commit hash OR pending manifest
final inventory
Postman artifacts
static validation
```

Verify audit entry.

Audit files remain unstaged.

Do not fabricate a Git commit hash.

---

# 34. Blocker semantics

At final output distinguish:

```text
CONTENT_WORKFLOW_STATUS
```

from:

```text
GIT_CHECKPOINT_STATUS
```

Example acceptable outcome:

```text
CONTENT_WORKFLOW_STATUS:
POSTMAN_IMPLEMENTATION_REVIEW_REQUIRED

GIT_CHECKPOINT_STATUS:
PENDING_EXTERNAL_GIT_PERMISSION
```

This is **not** a content-workflow failure.

Only block Postman construction if a content/data/schema blocker exists.

---

# 35. Self-review

Before returning verify:

```text
[ ] Git blocker diagnosed
[ ] Safe escalation attempted if available
[ ] No unsafe permission changes performed

[ ] Student Extension still 15 approved
[ ] Rejected Student cases excluded
[ ] Student commit created OR exact pending commit manifest created

[ ] Final executable inventory created
[ ] Corrected + approved Student cases merged correctly

[ ] Execution mode classified
[ ] Postman collection created
[ ] Environment created
[ ] Test data created
[ ] Execution manifest created
[ ] External verification plan created

[ ] Stable testcase IDs preserved
[ ] Postman testcase coverage 1:1
[ ] All 15 approved Student cases represented
[ ] X-Student-Id coverage 100%

[ ] No invented status codes
[ ] No invented response schemas
[ ] No raw CSV import assumption
[ ] FR-07/FR-09 remain supporting
[ ] FR-15 remains supporting

[ ] No real requests executed
[ ] Newman not started
[ ] No runtime evidence fabricated

[ ] Postman artifacts not committed
[ ] Audit entry verified
[ ] Audit files not staged
[ ] No push
```

---

# 36. Final output

Return:

```text
GIT_PERMISSION_RECOVERY_AND_POSTMAN_BUILD:
PASS | PARTIAL | FAIL

GIT:

REPOSITORY_ROOT:
...

GIT_PERMISSION_ESCALATION:
AVAILABLE | UNAVAILABLE | NOT_REQUIRED

STUDENT_EXTENSION_COMMIT:
<hash | PENDING_EXTERNAL_GIT_PERMISSION>

PENDING_COMMIT_MANIFEST:
<path | NONE>

CONTENT_WORKFLOW_STATUS:
POSTMAN_IMPLEMENTATION_REVIEW_REQUIRED | BLOCKED

STUDENT_EXTENSION:
API_01: 5 APPROVED
API_02: 5 APPROVED
API_03: 5 APPROVED
TOTAL: 15

FINAL_EXECUTABLE_SUITE:

API_01:
AI_CORRECTED:
STUDENT_ADDED:
TOTAL:
POSTMAN_DIRECT:
POSTMAN_WITH_PRECONDITION_SETUP:
POSTMAN_PLUS_EXTERNAL_VERIFICATION:

API_02:
AI_CORRECTED:
STUDENT_ADDED:
TOTAL:
POSTMAN_DIRECT:
POSTMAN_WITH_PRECONDITION_SETUP:
POSTMAN_PLUS_EXTERNAL_VERIFICATION:

API_03:
AI_CORRECTED:
STUDENT_ADDED:
TOTAL:
POSTMAN_DIRECT:
POSTMAN_WITH_PRECONDITION_SETUP:
POSTMAN_PLUS_EXTERNAL_VERIFICATION:

TOTAL_EXECUTABLE:
...

POSTMAN:

COLLECTION:
...

ENVIRONMENT:
...

DATA:
...

EXECUTION_MANIFEST:
...

EXTERNAL_VERIFICATION_PLAN:
...

FINAL_EXECUTABLE_TESTCASES:
...

POSTMAN_TESTCASE_IDENTITIES:
...

POSTMAN_TOTAL_REQUESTS:
...

POSTMAN_TESTCASE_COVERAGE:
<n>/<n>

TOTAL_SUT_REQUESTS:
...

X_STUDENT_ID_COVERAGE:
<n>/<n>

MISSING_X_STUDENT_ID:
[]

INVALID_CASES_INCLUDED:
0

DEFERRED_CASES_INCLUDED_AS_BLOCKING:
0

REJECTED_STUDENT_CASES_INCLUDED:
0

STATIC_VALIDATION:
PASS | FAIL

REAL_REQUESTS_EXECUTED:
NO

NEWMAN_STARTED:
NO

POSTMAN_ARTIFACTS_COMMITTED:
NO

AUDIT_ENTRY:
<id> — AUDIT_ENTRY_VERIFIED

AUDIT_FILES_STAGED:
NO

GIT_BLOCKERS:
<none or list>

CONTENT_BLOCKERS:
<none or list>

NEXT_CHECKPOINT:
POSTMAN_IMPLEMENTATION_REVIEW_REQUIRED
```

Then STOP.

Do not run Newman.
Do not execute the SUT.
Do not commit Postman artifacts.
