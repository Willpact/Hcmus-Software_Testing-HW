Targeted Human Review cho AI Test Audit đã hoàn tất.

Sử dụng:

```text
hw06-api-workflow
log-ai-audit
```

để áp dụng human decisions dưới đây, finalize audit, tạo corrected AI-generated suite, sau đó tạo Student Extension cho cả ba API.

Không bắt đầu Postman trong phiên này.

---

# 1. Human Review Decision

Human decision tổng thể:

```text
STUDENT_DECISION:
MODIFIED_AND_APPROVED

AI_TEST_AUDIT_METHOD:
APPROVED

TARGETED_REVIEW:
COMPLETED
```

Các classification/correction trong targeted review packet được approve, ngoại trừ các override cụ thể dưới đây.

---

# 2. Explicit Human Overrides

## API01-AI-040

Current:

```text
INCOMPLETE
```

Human decision:

```text
HUMAN_DECISION:
CHANGE_TO_INVALID
```

Reason:

`API01-REQ-003` states that step 1 generates a six-digit OTP.

The raw case assumes:

```text
issued token length = 7
```

and requires the test environment to issue a token longer than six digits.

That precondition is not established by the authoritative endpoint/feature contract.

Although SEC-07 describes at-least-six-digit entropy, the raw case as written specifically tests an issuer state not established for FR-03.

Final handling:

```text
classification:
INVALID

proposed_action:
REMOVE_FROM_FINAL_EXECUTABLE_SUITE

reason_category:
UNSUPPORTED_PRECONDITION
```

Preserve raw generation unchanged.

---

## API02-AI-038

Classification remains:

```text
INCOMPLETE
```

Human decision:

```text
HUMAN_DECISION:
DEFER_AS_REQUIREMENT_GAP
```

Reason:

FR-09 coupon behavior is supporting/cross-feature context only.

No authoritative source establishes how an applied coupon result is integrated into:

```text
POST /api/checkout
```

Final handling:

```text
classification:
INCOMPLETE

final_disposition:
DEFERRED_REQUIREMENT_GAP

final_suite:
EXCLUDE_FROM_EXECUTABLE_CHECKOUT_SUITE

future_scope:
CROSS_FEATURE_COUPON_CHECKOUT_INTEGRATION
```

Do not invent an integration oracle.

---

## API03-AI-035

Classification remains:

```text
VALID
```

Human decision:

```text
HUMAN_DECISION:
MODIFY_CORRECTION
```

The test itself is valid because it exercises the selected endpoint using its documented JSON representation.

However its traceability must be corrected.

Primary authoritative endpoint requirement should be:

```text
API03-REQ-004
```

because that requirement defines:

```text
products: [...]
```

as the JSON API request.

Also retain:

```text
API03-RG-001
```

as representation-gap context.

`API03-REQ-006` may remain contextual because it describes the CSV feature, but it must not be the sole/direct oracle for the JSON endpoint test.

Corrected traceability:

```text
PRIMARY_REQUIREMENT:
API03-REQ-004

RELATED_GAP:
API03-RG-001

SUPPORTING_CONTEXT:
API03-REQ-006
```

Classification stays:

```text
VALID
```

---

## API01-AI-035

Classification remains:

```text
VALID
```

Human decision:

```text
HUMAN_DECISION:
MODIFY_CORRECTION
```

Keep the security oracle:

```text
persisted password != supplied plaintext password
```

because it is backed by SEC-01.

However add execution metadata:

```text
AUTOMATION_NOTE:
Requires database/external persistence verification in the isolated test environment.
Do not represent this as a pure Postman response assertion if Postman cannot directly inspect persistence.
```

Do not weaken the security requirement merely because automation is more difficult.

---

# 3. Remaining Targeted Cases

For every other case included in:

```text
docs/test-audit/human-review-packet.md
```

apply:

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION
```

unless one of the explicit overrides above applies.

This includes approval of:

* existing INVALID classifications;
* existing semantic duplicate findings;
* sampled VALID classifications;
* sampled INCOMPLETE classifications.

---

# 4. Expected aggregate after Human Review

Before:

```text
VALID: 69
INVALID: 3
INCOMPLETE: 48
```

Expected after API01-AI-040 override:

```text
VALID: 69
INVALID: 4
INCOMPLETE: 47
```

Verify these counts from actual artifacts.

Do not force them if repository data proves otherwise.

If counts differ, report why.

---

# 5. Apply Human Review to audit artifacts

Update:

```text
docs/test-audit/api-01-reset-password-audit.md
docs/test-audit/api-02-checkout-audit.md
docs/test-audit/api-03-import-products-audit.md
docs/test-audit/cross-api-failure-patterns.md

test-cases/audited/api-01-reset-password.json
test-cases/audited/api-02-checkout.json
test-cases/audited/api-03-import-products.json
test-cases/audited/cross-api-summary.json

docs/test-audit/human-review-packet.md
```

Do not modify:

```text
docs/test-generation/
test-cases/generated/
```

Raw AI generation remains immutable.

---

# 6. Human-review status

For targeted reviewed cases, record the explicit human decision.

For the remaining audited cases, preserve their existing AI audit reasoning and classification.

Do not fabricate a claim that the student individually rewrote every audit record.

The final artifact should clearly distinguish:

```text
AI_GENERATED
AI_AUDIT_PROPOSAL
HUMAN_REVIEW_DECISION
FINAL_DISPOSITION
```

---

# 7. Create Corrected AI Test Suite

After applying human decisions, create a corrected AI-generated suite separate from raw generation and audit artifacts.

Suggested structure:

```text
test-cases/corrected/
├── api-01-reset-password.json
├── api-02-checkout.json
└── api-03-import-products.json
```

and human-readable artifacts if useful:

```text
docs/test-correction/
├── api-01-reset-password-corrected.md
├── api-02-checkout-corrected.md
└── api-03-import-products-corrected.md
```

Do not overwrite raw generated cases.

---

# 8. Corrected-suite rules

## VALID

Keep in corrected suite unless there is a specific execution blocker.

Preserve stable TC ID.

---

## INVALID

Do not place in final executable suite.

Preserve them in generation/audit history.

Record:

```text
FINAL_DISPOSITION:
REMOVED_FROM_FINAL_EXECUTABLE_SUITE
```

---

## INCOMPLETE

For every INCOMPLETE case, evaluate whether it can be corrected **without inventing a requirement**.

### Salvage only when:

* authoritative business/security rule exists;
* missing detail can be removed from oracle;
* precondition can be made deterministic;
* test can still produce meaningful pass/fail behavior.

### Example

If exact HTTP status is unspecified but business rule clearly states an operation must not be allowed:

the test may still become executable using:

```text
expected_status:
UNSPECIFIED_BY_AUTHORITATIVE_SOURCE
```

and a state/business assertion.

### Do not salvage by inventing:

* status codes;
* maximum lengths;
* expiry duration;
* rate-limit threshold;
* duplicate policy;
* idempotency policy;
* shipping-address rules;
* coupon integration;
* category behavior;
* price precision;
* response property names.

If an incomplete case cannot be safely corrected:

```text
FINAL_DISPOSITION:
DEFERRED_REQUIREMENT_GAP
```

Keep it in a deferred/observational section, not as a blocking final executable test.

---

# 9. Preserve traceability

Every corrected case must retain:

```text
original_ai_case_id
source: AI_GENERATED
audit_classification
human_review_status
correction_summary
requirement_ids
oracle_basis
final_disposition
```

Do not convert a corrected AI-generated case into:

```text
STUDENT_ADDED
```

It remains AI-generated.

---

# 10. Corrected-suite summary

For each API report:

```text
RAW_AI_GENERATED:
VALID_AFTER_AUDIT:
INVALID_REMOVED:
INCOMPLETE_SALVAGED:
INCOMPLETE_DEFERRED:
FINAL_EXECUTABLE_AI_CASES:
```

Also report technique coverage after correction.

If final executable AI cases fall below 35, do not fabricate replacements.

Student Extension can later increase final suite size if genuine uncovered risks exist.

---

# 11. Commit Human-Approved Audit Artifacts

After human decisions and corrected AI suite have been successfully produced, create Git checkpoints for the audit step.

Repository contains several homework folders.

Use HW6-scoped staging only.

Do not use:

```bash
git add -A
```

Do not stage:

```text
docs/ai-audit/
```

AI Audit Log remains the final HW06 commit only.

Create separate commits where practical.

Suggested commits:

```text
test(HW6): audit reset password AI test cases
test(HW6): audit checkout AI test cases
test(HW6): audit import products AI test cases
```

Include corresponding:

```text
docs/test-audit/
test-cases/audited/
docs/test-correction/
test-cases/corrected/
```

files in the logically appropriate commit.

Cross-API summary may be included with the final audit commit or a small separate docs commit if necessary.

Before each commit verify staged files with:

```bash
git diff --cached --name-status -- .
```

Audit Log files must not appear.

Do not push.

---

# 12. Begin Student Extension only after corrected suite exists

Now perform the assignment's Student Extension phase.

Requirement:

```text
>=5 STUDENT_ADDED cases per API
```

Therefore minimum:

```text
API-01 >=5
API-02 >=5
API-03 >=5

TOTAL >=15
```

Do not treat the previous 10 `FUTURE_EXTENSION_GAPS` as automatically satisfying this requirement.

---

# 13. Student Extension principle

Student Extension cases must represent meaningful cases that the original AI-generated set **missed**.

Do not merely:

* copy an INVALID AI case;
* copy an INCOMPLETE case and rename it;
* change one test-data value;
* duplicate an existing equivalence partition;
* generate filler to reach five.

Each extension case must have a defensible reason that the original AI generation failed to cover it adequately.

---

# 14. Extension source

Every extension test must use:

```text
source:
STUDENT_ADDED
```

and include:

```text
why_ai_missed:
```

with a concrete explanation.

Use categories such as:

```text
PROMPT_LIMITATION
MODEL_ASSUMPTION
SPEC_AMBIGUITY
STATEFUL_REASONING_GAP
SECURITY_REASONING_GAP
CROSS_ENDPOINT_DEPENDENCY
COVERAGE_BLIND_SPOT
```

Do not assign a generic reason to every case.

---

# 15. API-01 Extension Focus

Find at least 5 genuine additional cases for:

```text
POST /api/reset-password
```

Prioritize uncovered or weakly covered areas such as:

* email/token binding;
* one-time lifecycle combinations;
* state mutation after failed reset;
* password-security invariants;
* security combinations AI separated but did not combine;
* cross-user reset attempts;
* replay/state sequencing;
* edge combinations involving a valid authoritative password policy.

Do not create cases whose only oracle depends on unspecified:

* rate-limit threshold;
* expiry duration;
* user-enumeration response uniformity;
* undocumented confirmation API field.

Such items may stay requirement-gap observations.

---

# 16. API-02 Extension Focus

Find at least 5 genuine additional cases for:

```text
POST /api/checkout
```

Prioritize:

* server-calculated total trust boundary;
* authenticated-user/cart isolation;
* cart state before/after successful checkout;
* manipulated client total combined with cart state;
* authorization + business-rule combinations;
* state consistency across checkout outcomes where authoritative oracle exists.

Do not invent:

* empty-cart policy;
* shipping-address validation rules;
* coupon integration;
* idempotency semantics;
* initial order status.

---

# 17. API-03 Extension Focus

Find at least 5 genuine additional cases for:

```text
POST /api/admin/import-products
```

Prioritize:

* admin role enforcement;
* mixed-validity batches;
* atomic rollback;
* multiple invalid rows;
* invalid item at first/middle/last position;
* reporting counts/reasons;
* positive-price/name requirements;
* unexpected input combined with batch atomicity when an authoritative invariant exists.

Do not invent:

* maximum batch size;
* duplicate policy;
* category-existence behavior;
* price precision;
* raw CSV upload behavior.

Remember:

```text
FR-15:
SUPPORTING ONLY

CSV_VS_JSON:
UNRESOLVED_REPRESENTATION_GAP
```

---

# 18. Extension case quality

Each extension case must contain at least:

```yaml
id:
api_id:
source: STUDENT_ADDED
title:
objective:
requirement_ids:
primary_technique:
secondary_techniques:
preconditions:
request:
test_data:
expected_status:
expected_business_result:
expected_state:
oracle_basis:
why_ai_missed:
difference_from_ai_generated_suite:
```

Stable IDs suggested:

```text
API01-STU-001
API01-STU-002
...

API02-STU-001
...

API03-STU-001
...
```

---

# 19. Prove that AI missed each Student case

For each Student Extension case, compare it against all 40 raw AI-generated cases for that API.

Record:

```text
CLOSEST_AI_CASES:
<IDs>

DIFFERENCE:
<why this is semantically distinct>

WHY_AI_MISSED:
<reason>
```

If an extension case is actually already covered by an AI case:

do not keep it.

Generate/analyze another genuine gap instead.

---

# 20. Extension artifacts

Create:

```text
docs/test-extension/
├── api-01-reset-password-student-extension.md
├── api-02-checkout-student-extension.md
└── api-03-import-products-student-extension.md
```

Structured form:

```text
test-cases/student-added/
├── api-01-reset-password.json
├── api-02-checkout.json
└── api-03-import-products.json
```

Do not generate Excel yet.

Do not merge raw/corrected/student cases into Postman yet.

---

# 21. Final-suite preview

After Student Extension generation, create a preview summary only.

Do not yet create the final Excel/Postman suite.

Report per API:

```text
FINAL_EXECUTABLE_AI_CASES:
STUDENT_ADDED:
DEFERRED_REQUIREMENT_GAPS:
TOTAL_EXECUTABLE_PREVIEW:
```

Check:

```text
STUDENT_ADDED >=5/API
```

Also report whether:

```text
TOTAL_EXECUTABLE_PREVIEW >=35/API
```

If not:

do not generate filler.

Report the gap for human decision.

---

# 22. Student Extension is not yet human-approved

All new extension cases must initially have:

```text
HUMAN_REVIEW_STATUS:
PENDING_HUMAN_REVIEW
```

Do not mark them student-approved merely because they were generated in this interaction.

Do not commit Student Extension artifacts yet.

Student will review them at the next checkpoint.

---

# 23. Continuous AI Audit

This interaction is substantive.

Before doing the work, finalize the previous targeted-review interaction using the human decisions in this prompt.

After completing:

* human audit application;
* corrected AI suite;
* Student Extension generation;

invoke/use `log-ai-audit`.

Record:

* exact prompt;
* exact substantive output;
* artifacts;
* commits created;
* human decisions applied.

Verify the entry.

Do not stage or commit:

```text
docs/ai-audit/
```

If audit fails:

```text
WORKFLOW_STATUS:
BLOCKED

BLOCKER:
AUDIT_WRITE_FAILED
```

and STOP.

---

# 24. Git policy

Allowed commits in this interaction:

```text
Human-approved AI Test Audit / corrected AI suite
```

Not allowed:

```text
Student Extension
```

because extension is still awaiting human review.

Not allowed:

```text
AI Audit Log
```

because that remains final HW06 commit.

Do not push.

---

# 25. Do not start Postman

Do not:

* generate Postman collection;
* create Newman scripts;
* run backend;
* execute requests;
* generate evidence;
* classify real product defects;
* create GitHub Issues;
* start CI/CD;
* create Excel;
* write Main Report.

Next phase is still Student Extension Human Review.

---

# 26. Self-review

Before stopping verify:

```text
[ ] Human targeted-review decisions applied
[ ] API01-AI-040 changed to INVALID
[ ] API02-AI-038 deferred as requirement gap
[ ] API03-AI-035 traceability corrected
[ ] API01-AI-035 automation note added

[ ] Raw generated artifacts unchanged
[ ] Audit artifacts updated
[ ] Corrected suite created

[ ] INVALID AI cases excluded from final executable suite
[ ] INCOMPLETE cases salvaged only with requirement-backed oracle
[ ] Remaining ambiguous cases deferred
[ ] No requirement invented

[ ] Audit/corrected-suite commits created safely
[ ] AI Audit files excluded from commits

[ ] API-01 Student Extension >=5
[ ] API-02 Student Extension >=5
[ ] API-03 Student Extension >=5
[ ] Every Student case source = STUDENT_ADDED
[ ] Every Student case has why_ai_missed
[ ] Every Student case compared against raw AI suite
[ ] No semantic duplicate extension cases

[ ] Student Extension not committed
[ ] Postman not started
[ ] Excel not created

[ ] Current interaction audited
[ ] Audit entry verified
[ ] Audit files not staged
```

---

# 27. Output cuối phiên

Trả:

```text
AI_TEST_AUDIT_FINALIZATION_AND_EXTENSION: PASS | PARTIAL | FAIL

HUMAN_REVIEW:
STATUS: MODIFIED_AND_APPROVED

FINAL_CLASSIFICATION:
VALID:
INVALID:
INCOMPLETE:

EXPLICIT_OVERRIDES:
API01-AI-040:
API02-AI-038:
API03-AI-035:
API01-AI-035:

API_01_CORRECTION:
RAW_AI_GENERATED: 40
VALID_AFTER_AUDIT:
INVALID_REMOVED:
INCOMPLETE_SALVAGED:
INCOMPLETE_DEFERRED:
FINAL_EXECUTABLE_AI_CASES:

API_02_CORRECTION:
RAW_AI_GENERATED: 40
VALID_AFTER_AUDIT:
INVALID_REMOVED:
INCOMPLETE_SALVAGED:
INCOMPLETE_DEFERRED:
FINAL_EXECUTABLE_AI_CASES:

API_03_CORRECTION:
RAW_AI_GENERATED: 40
VALID_AFTER_AUDIT:
INVALID_REMOVED:
INCOMPLETE_SALVAGED:
INCOMPLETE_DEFERRED:
FINAL_EXECUTABLE_AI_CASES:

AUDIT_COMMITS:
API_01:
API_02:
API_03:

AUDIT_FILES_INCLUDED_IN_COMMITS:
NO

STUDENT_EXTENSION:

API_01:
STUDENT_ADDED:
WHY_AI_MISSED_CATEGORIES:
TOTAL_EXECUTABLE_PREVIEW:

API_02:
STUDENT_ADDED:
WHY_AI_MISSED_CATEGORIES:
TOTAL_EXECUTABLE_PREVIEW:

API_03:
STUDENT_ADDED:
WHY_AI_MISSED_CATEGORIES:
TOTAL_EXECUTABLE_PREVIEW:

STUDENT_EXTENSION_TOTAL:

EXTENSION_DUPLICATES_FOUND_AND_REPLACED:

EXTENSION_ARTIFACTS:
<paths>

STUDENT_EXTENSION_COMMITTED:
NO

STUDENT_EXTENSION_HUMAN_REVIEW:
PENDING

POSTMAN_STARTED:
NO

AUDIT_ENTRY:
<id> — AUDIT_ENTRY_VERIFIED

AUDIT_FILES_STAGED:
NO

BLOCKERS:
<none hoặc list>

NEXT_CHECKPOINT:
THREE_API_STUDENT_EXTENSION_REVIEW_REQUIRED
```

Sau đó STOP.

Không bắt đầu Postman cho đến khi Student Extension được human review.
