Student Extension replacement review đã hoàn tất.

Human decision:

```text
STUDENT_DECISION:
APPROVED

API_01:
5/5 APPROVED

API_02:
API02-STU-004:
REJECTED_AS_STUDENT_EXTENSION
REASON:
NOT_GENUINELY_MISSED_BY_AI

API02-STU-006:
APPROVED
GENUINELY_MISSED:
YES
ORACLE_REVIEW:
SUFFICIENT
EXECUTION_FEASIBILITY:
POSTMAN_PLUS_EXTERNAL_VERIFICATION

API_03:
API03-STU-005:
REJECTED_AS_STUDENT_EXTENSION
REASON:
NOT_GENUINELY_MISSED_BY_AI

API03-STU-006:
APPROVED
GENUINELY_MISSED:
YES
ORACLE_REVIEW:
SUFFICIENT
EXECUTION_FEASIBILITY:
POSTMAN_PLUS_EXTERNAL_VERIFICATION

FINAL_STUDENT_EXTENSION:
API-01: 5 APPROVED
API-02: 5 APPROVED
API-03: 5 APPROVED
TOTAL: 15 APPROVED
```

Current audit entry:

```text
A-009 — AUDIT_ENTRY_VERIFIED
```

Use:

```text
hw06-api-workflow
postman-api-runner
log-ai-audit
```

for this workflow.

Main objectives:

```text
1. Finalize replacement human review
2. Finalize all 15 approved STUDENT_ADDED cases
3. Commit Student Extension safely
4. Build final executable test inventory
5. Generate Postman Collection
6. Generate Postman Environment
7. Generate required test data / state setup
8. Implement Postman assertions
9. Mark external-verification requirements correctly
10. Perform static/structural validation only
11. Audit the interaction
12. STOP before real API execution / Newman
```

Do not run the SUT or Newman in this interaction.

---

# 1. Finalize A-009 / replacement Human Review

Record the human decisions above.

Specifically:

```text
API02-STU-006:
HUMAN_REVIEW_STATUS:
APPROVED

API03-STU-006:
HUMAN_REVIEW_STATUS:
APPROVED
```

Rejected originals:

```text
API02-STU-004
API03-STU-005
```

must remain preserved in history with:

```text
FINAL_DISPOSITION:
REJECTED_AS_STUDENT_EXTENSION

COUNT_TOWARD_STUDENT_EXTENSION:
NO
```

Do not delete their historical records.

The approved replacements count instead.

Verify the audit update before continuing.

If audit finalization fails:

```text
WORKFLOW_STATUS:
BLOCKED

BLOCKER:
REPLACEMENT_HUMAN_REVIEW_AUDIT_FAILED
```

and STOP.

Audit files must remain unstaged.

---

# 2. Finalize Student Extension artifacts

Update:

```text
docs/test-extension/api-01-reset-password-student-extension.md
docs/test-extension/api-02-checkout-student-extension.md
docs/test-extension/api-03-import-products-student-extension.md
docs/test-extension/final-suite-preview.md

test-cases/student-added/
```

Final approved counts must be:

```text
API-01:
APPROVED_STUDENT_ADDED: 5

API-02:
APPROVED_STUDENT_ADDED: 5

API-03:
APPROVED_STUDENT_ADDED: 5

TOTAL:
15
```

All counted cases must contain:

```text
source:
STUDENT_ADDED

human_review_status:
APPROVED
```

and meaningful:

```text
why_ai_missed
difference_from_ai_generated_suite
closest_ai_cases
```

Rejected cases must not count toward the five.

---

# 3. Preserve traceability

Do not modify raw AI generation:

```text
docs/test-generation/
test-cases/generated/
```

Do not rewrite the AI audit history to hide rejected or incomplete cases.

The repository must preserve this chain:

```text
RAW_AI_GENERATED
        ↓
AI_AUDIT_PROPOSAL
        ↓
HUMAN_REVIEW
        ↓
CORRECTED_AI_CASE
        ↓
STUDENT_EXTENSION
        ↓
POSTMAN_IMPLEMENTATION
```

---

# 4. Commit finalized Student Extension

After finalization succeeds, commit Student Extension.

Repository contains multiple homework directories, so use only HW6-scoped paths.

Do not use:

```bash
git add -A
```

Do not stage:

```text
docs/ai-audit/
```

Before staging:

```bash
git status --short -- .
```

Stage only finalized Student Extension artifacts and related non-audit review metadata necessary to preserve the approved extension.

Suggested commit:

```text
test(HW6): finalize student-added API test cases
```

Before commit verify:

```bash
git diff --cached --name-status -- .
```

Ensure:

```text
docs/ai-audit/
```

does not appear.

Do not push.

---

# 5. Build final executable test inventory

After the Student Extension commit, construct a unified implementation inventory.

Inputs:

```text
test-cases/corrected/
test-cases/student-added/
```

Do not use INVALID or deferred requirement-gap cases as executable blocking tests.

Build an artifact such as:

```text
test-cases/final/
├── api-01-reset-password.json
├── api-02-checkout.json
├── api-03-import-products.json
└── cross-api-final-summary.json
```

and optionally:

```text
docs/test-suite/final-executable-suite.md
```

Use repository convention if a better existing location exists.

---

# 6. Final executable counts

Previous preview:

```text
API-01: 30
API-02: 30
API-03: 33
```

Recalculate from actual artifacts.

Do not add filler merely to reach 35.

The raw AI-generation requirement was already satisfied with:

```text
40 AI-generated cases / API
```

The final executable suite should contain only cases that survived audit/correction plus approved Student Extension.

Report:

```text
AI_CORRECTED_EXECUTABLE:
STUDENT_ADDED_EXECUTABLE:
EXTERNAL_VERIFICATION_REQUIRED:
TOTAL_EXECUTABLE:
DEFERRED_REQUIREMENT_GAPS:
```

per API.

---

# 7. Execution-mode classification

Every final executable case must receive one implementation mode:

```text
POSTMAN_DIRECT
POSTMAN_WITH_PRECONDITION_SETUP
POSTMAN_PLUS_EXTERNAL_VERIFICATION
```

No final executable case should be:

```text
NOT_CURRENTLY_EXECUTABLE
```

without being clearly separated from the executable inventory.

For external-verification cases, record what must be verified externally.

Examples:

```text
DATABASE_STATE
PASSWORD_PERSISTENCE
CART_STATE
ORDER_STATE
PRODUCT_PERSISTENCE
ATOMIC_ROLLBACK
CROSS_USER_ISOLATION
```

Do not claim Postman alone verifies something it cannot observe.

---

# 8. Generate Postman workspace artifacts

Create Postman artifacts for all three APIs.

Suggested structure:

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

Use existing repository convention if present.

One collection is preferred, with folders:

```text
HW06 API Testing
│
├── API-01 Reset Password
│   ├── Setup
│   └── Test Cases
│
├── API-02 Checkout
│   ├── Setup
│   └── Test Cases
│
└── API-03 Import Products
    ├── Setup
    └── Test Cases
```

Further subfolders may be used for:

```text
DOMAIN_PARTITION
BOUNDARY
STATE_TRANSITION
SECURITY
SCHEMA
BUSINESS_RULE
```

if that improves traceability without making execution unnecessarily complex.

---

# 9. Mandatory X-Student-Id

Every assignment request must support:

```http
X-Student-Id: {{studentId}}
```

Do not hardcode a real Student ID if a variable is available.

Environment:

```text
studentId
```

must be defined.

For every assignment request, ensure the resolved request contains:

```text
X-Student-Id
```

Prefer collection-level logic where possible so it cannot be accidentally omitted.

However verify it is inherited/resolved for **every actual test request**.

Do not fabricate screenshots or execution evidence at this stage.

---

# 10. Environment variables

Environment should use variables such as:

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

Add more only when necessary.

Use:

```text
baseUrl:
http://localhost:3000
```

for local template if consistent with repository specification.

Do not commit real secrets.

For secret/token values, use empty/example placeholders where appropriate.

---

# 11. Secret policy

Do not commit:

```text
real JWTs
real passwords
private tokens
personal secrets
```

Example environment must be safe to commit.

If Postman current-value semantics are involved, ensure exported committed environments do not expose real secrets.

---

# 12. Stable testcase traceability

Every executable Postman request must include its stable testcase ID.

Examples:

```text
API01-AI-...
API01-STU-...

API02-AI-...
API02-STU-...

API03-AI-...
API03-STU-...
```

Recommended request name:

```text
[API02-STU-006] <test title>
```

Each request description should include:

```text
Test Case ID
Source: AI_GENERATED | STUDENT_ADDED
Requirement IDs
Primary Technique
Oracle Basis
Execution Mode
External Verification Requirement
```

if applicable.

---

# 13. Do not renumber testcase IDs

Do not make the final suite appear as though removed cases never existed.

Preserve stable IDs.

Gaps in numbering are acceptable.

Traceability is more important than sequential numbering.

---

# 14. API-01 Postman implementation

Endpoint:

```text
POST /api/reset-password
```

Implement setup as necessary using documented flow such as:

```text
POST /api/forgot-password
```

when needed to obtain/reset a disposable OTP for test setup.

Do not assume JWT for reset-password unless authoritative contract requires it.

Support isolated disposable user/reset fixtures where possible.

---

# 15. API-01 assertions

Automate requirement-backed assertions such as:

```text
valid issued OTP can perform intended reset
email/token binding
OTP cannot be reused after successful reset
strong-password business rules where test oracle exists
failed reset must not satisfy protected state transition where authoritative
```

Exact HTTP status remains flexible when specification does not define it.

Prefer business/state assertions over fabricated status assertions.

---

# 16. API-01 external verification

Cases requiring password persistence inspection must be tagged:

```text
POSTMAN_PLUS_EXTERNAL_VERIFICATION
```

For example, SEC-01 plaintext persistence verification.

Do not write:

```javascript
pm.expect(... database ...)
```

unless a legitimate API/database verification mechanism exists.

Instead generate external verification metadata/checklist.

---

# 17. API-02 Postman implementation

Endpoint:

```text
POST /api/checkout
```

Use valid bearer JWT where required.

Implement deterministic cart setup using documented cart API before checkout cases requiring non-empty cart.

Setup should support disposable state.

---

# 18. API-02 core assertions

Prioritize:

```text
authenticated checkout
server-side total trust boundary
client total manipulation
cart-derived behavior
successful checkout clears cart
user/cart isolation
```

Do not assert direct FR-09 coupon behavior unless an approved executable case has a requirement-backed oracle.

Do not invent:

```text
empty-cart expected error
shipping validation limits
idempotency policy
initial order status
```

---

# 19. API-02 client total manipulation

For cases with manipulated:

```text
total_amount
```

do not treat the submitted client value as authoritative.

Assertions should verify business behavior based on the authoritative rule that server total is derived from cart.

If Postman cannot directly inspect authoritative persisted total via documented APIs, mark the required external verification instead of faking an assertion.

---

# 20. API-02 cart-state verification

Where the API permits retrieving cart before/after:

use setup/postcondition requests to verify:

```text
before checkout:
cart populated

after confirmed successful checkout:
cart cleared
```

Do not rely only on checkout response text if the state requirement concerns cart state.

---

# 21. API-03 Postman implementation

Endpoint:

```text
POST /api/admin/import-products
```

Use:

```text
Authorization: Bearer {{adminToken}}
```

for admin cases.

For non-admin authorization cases, use user token.

Request contract:

```json
{
  "products": [...]
}
```

Do not implement raw CSV multipart tests in the selected endpoint suite.

---

# 22. API-03 assertions

Automate requirement-backed behavior:

```text
Admin role required
non-admin must not import
name non-empty
price positive
atomic all-or-nothing import
success/error count/reason semantics
```

Do not invent exact response JSON field names if authoritative source does not define them.

Where exact schema is unspecified, assert business effect/state instead.

---

# 23. API-03 atomic rollback verification

For mixed-validity batches:

capture product state before execution if possible.

After execution, verify:

```text
invalid batch
        ↓
no products from that batch persisted
```

If no documented API can verify product persistence sufficiently, classify the testcase:

```text
POSTMAN_PLUS_EXTERNAL_VERIFICATION
```

and generate explicit external verification instructions.

Do not claim a PASS from response alone when the requirement is transaction rollback.

---

# 24. Setup and teardown design

Design reusable setup flows.

Avoid repeating login/setup manually for every testcase.

Possible setup concepts:

```text
authenticate normal user
authenticate admin
prepare reset OTP
prepare cart
snapshot cart
snapshot product state
generate unique testRunId
```

Use:

```text
{{$timestamp}}
{{$guid}}
```

or an equivalent safe unique mechanism where appropriate.

Do not create uncontrollable persistent pollution.

---

# 25. Test isolation

Test cases should not accidentally depend on execution order unless state-transition sequence is explicitly required.

Where ordering is necessary, document:

```text
ORDER_DEPENDENT:
YES

DEPENDENCY:
<case/setup ID>
```

Otherwise:

```text
ORDER_DEPENDENT:
NO
```

---

# 26. Data-driven support

Where multiple final cases share one request structure but differ in data partitions, support data-driven execution if doing so preserves testcase traceability.

Do not collapse distinct stable testcases into an opaque loop that makes Newman evidence hard to map.

Every testcase must remain identifiable in results.

---

# 27. Postman assertions philosophy

Do not manufacture expected status codes.

If authoritative source does not state exact status:

avoid assertions such as:

```javascript
pm.response.to.have.status(400);
```

unless another approved requirement/source defines it.

Instead use meaningful assertions such as:

```text
protected state did not change
token cannot be reused
non-admin did not import
cart-derived business invariant holds
batch rollback holds
```

where observable.

Transport response may still be logged as observed evidence.

---

# 28. Response schema assertions

Only implement strict schema assertions where the authoritative contract supports them.

If exact response shape is not defined:

do not invent one.

Record:

```text
SCHEMA_ASSERTION:
NOT_AUTHORITATIVELY_DEFINED
```

where appropriate.

---

# 29. External verification artifact

Create:

```text
docs/postman/external-verification-plan.md
```

For every:

```text
POSTMAN_PLUS_EXTERNAL_VERIFICATION
```

case, record:

```text
CASE_ID
API
WHAT_POSTMAN_VERIFIES
WHAT_EXTERNAL_VERIFICATION_IS_REQUIRED
HOW_TO_VERIFY
EXPECTED_INVARIANT
EVIDENCE_TO_CAPTURE
```

Do not run those verifications yet.

Examples:

```text
database password not plaintext
order persisted total
product rollback
cross-user state isolation
```

Only include actual final cases requiring them.

---

# 30. Final execution manifest

Create:

```text
docs/postman/execution-manifest.md
```

Include:

```text
CASE_ID
SOURCE
API
TECHNIQUE
POSTMAN_REQUEST_NAME
EXECUTION_MODE
SETUP_REQUIRED
EXTERNAL_VERIFICATION
REQUIREMENT_IDS
```

All final executable cases must appear exactly once.

Verify counts against final executable inventory.

---

# 31. Collection structure validation

Perform static validation without sending network requests.

Check:

```text
valid Postman JSON
valid Environment JSON
unique request names / TC IDs
every final executable case represented
every request includes/inherits X-Student-Id
correct endpoint paths
correct HTTP methods
required auth strategy present
stable testcase IDs preserved
no INVALID cases included
no DEFERRED cases included as blocking executable tests
no rejected Student cases counted
```

---

# 32. Student Extension verification

Ensure final collection includes:

```text
API-01:
5 approved STUDENT_ADDED cases

API-02:
5 approved STUDENT_ADDED cases including API02-STU-006

API-03:
5 approved STUDENT_ADDED cases including API03-STU-006
```

Ensure excluded:

```text
API02-STU-004
API03-STU-005
```

as counted/executable Student Extension cases.

Their historical review records remain preserved.

---

# 33. Validate X-Student-Id coverage

Statically inspect every collection request that will actually execute.

Report:

```text
TOTAL_EXECUTABLE_REQUESTS:
...

X_STUDENT_ID_COVERAGE:
<n>/<n>

MISSING_X_STUDENT_ID:
[]
```

Target:

```text
100%
```

If not 100%, fix before checkpoint.

Do not claim header evidence from runtime yet.

---

# 34. Do not execute requests

This interaction is implementation preparation only.

Do not:

```text
start backend
restart backend
send API requests
run Postman Runner
run Newman
capture screenshots
generate Newman HTML
classify runtime failures
declare product defects
create GitHub Issues
```

Real execution occurs after human review of the Postman implementation.

---

# 35. Git policy for Postman artifacts

Student Extension should be committed because it is now human-approved.

Postman implementation should remain:

```text
UNCOMMITTED
```

until human review of:

```text
POSTMAN_IMPLEMENTATION_REVIEW_REQUIRED
```

Do not commit Postman collection/environment/test data yet.

This preserves a clean checkpoint where Postman implementation can be corrected before committing.

---

# 36. Continuous AI Audit

This entire interaction is substantive.

After:

```text
Student Extension finalization
Student Extension commit
Final executable inventory
Postman implementation
Static validation
```

use:

```text
log-ai-audit
```

Record:

```text
exact prompt
exact substantive output
human approval decisions
Student Extension commit hash
Postman artifact paths
static validation results
```

Verify entry.

Audit files must remain:

```text
NOT_STAGED
NOT_COMMITTED
```

If Audit write fails:

```text
WORKFLOW_STATUS:
BLOCKED

BLOCKER:
AUDIT_WRITE_FAILED
```

and STOP.

---

# 37. No Excel yet

Do not create final Excel testcase workbook in this interaction.

Excel should be generated after:

```text
final suite finalized
+
execution statuses available
```

so it can include actual execution results and classifications.

---

# 38. No CI/CD yet

Do not:

```text
create CI workflow
run CI
create pass/fail sample commits
```

That happens after local Newman execution is stable.

---

# 39. Self-review

Before returning verify:

```text
[ ] A-009 replacement human review finalized

[ ] API01 Student Extension 5/5 approved
[ ] API02 Student Extension 5/5 approved
[ ] API03 Student Extension 5/5 approved
[ ] API02-STU-004 rejected and not counted
[ ] API03-STU-005 rejected and not counted
[ ] API02-STU-006 approved
[ ] API03-STU-006 approved

[ ] Student Extension committed
[ ] Audit files excluded from commit

[ ] Final executable inventory created
[ ] No INVALID cases executable
[ ] No DEFERRED requirement-gap cases treated as blocking executable tests

[ ] Postman collection generated
[ ] Environment generated
[ ] Data/setup generated
[ ] Execution manifest generated
[ ] External verification plan generated

[ ] Every testcase preserves stable ID
[ ] All 15 approved STUDENT_ADDED cases represented

[ ] X-Student-Id coverage 100%
[ ] No real student secret hardcoded
[ ] No real JWT/password committed

[ ] No unsupported HTTP status invented
[ ] No unsupported response schema invented
[ ] FR-07/FR-09 not promoted for Checkout
[ ] FR-15 not promoted for Import
[ ] Raw CSV upload not assumed

[ ] External-verification cases not falsely marked Postman-direct
[ ] Postman JSON structurally valid
[ ] Environment JSON structurally valid

[ ] No request executed
[ ] Newman not started
[ ] Excel not created
[ ] CI/CD not started

[ ] Postman artifacts uncommitted
[ ] Current interaction audited
[ ] Audit entry verified
[ ] Audit files unstaged
[ ] No push
```

---

# 40. Final output

Return:

```text
STUDENT_EXTENSION_FINALIZATION_AND_POSTMAN_BUILD: PASS | PARTIAL | FAIL

PREVIOUS_REPLACEMENT_REVIEW:
FINALIZED | FAILED

STUDENT_EXTENSION:

API_01:
APPROVED: 5

API_02:
APPROVED: 5
REJECTED_HISTORY:
API02-STU-004
REPLACEMENT_APPROVED:
API02-STU-006

API_03:
APPROVED: 5
REJECTED_HISTORY:
API03-STU-005
REPLACEMENT_APPROVED:
API03-STU-006

TOTAL_STUDENT_ADDED_APPROVED:
15

STUDENT_EXTENSION_COMMIT:
<hash>

AUDIT_FILES_INCLUDED_IN_STUDENT_COMMIT:
NO

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

POSTMAN:

COLLECTION:
<path>

ENVIRONMENT:
<path>

DATA:
<paths>

EXECUTION_MANIFEST:
<path>

EXTERNAL_VERIFICATION_PLAN:
<path>

POSTMAN_REQUESTS:
<count>

TESTCASE_COVERAGE:
<covered>/<final executable>

X_STUDENT_ID_COVERAGE:
<n>/<n>

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

BLOCKERS:
<none or list>

NEXT_CHECKPOINT:
POSTMAN_IMPLEMENTATION_REVIEW_REQUIRED
```

After returning the summary, STOP.

Do not run the SUT.
Do not run Newman.
Do not commit Postman implementation.
Do not start execution or CI/CD until human review.

