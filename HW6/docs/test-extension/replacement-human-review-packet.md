# Student Extension Replacement Human Review Packet

## Scope

- Contains exactly two replacement candidates: one for API-02 and one for API-03.
- Rejected history remains in the API-specific Markdown/JSON artifacts.
- Both replacements were Human-approved and count toward the finalized Student Extension.
- Rejected originals remain history and do not count.

## API-02 Replacement

CASE_ID: `API02-STU-006`

API: `API-02`

REPLACES: `API02-STU-004`

TITLE: Current-cart authority under stale cross-user collision

REQUIREMENTS: `API02-REQ-004`, `API02-REQ-005`, `API02-REQ-006`, `API02-REQ-007`

WHY_AI_MISSED_CATEGORY: `COMBINATION_INTERACTION_GAP`

WHY_AI_MISSED: Raw AI generation decomposed temporal cart recalculation and cross-user identity isolation into separate cases, so it did not exercise all three competing authorities—current cart A, spoofed user B, and stale client total—in one stateful request.

CLOSEST_AI_CASES: `API02-AI-016`, `API02-AI-017`, `API02-AI-027`, `API02-AI-036`

CLOSEST_STUDENT_CASES: `API02-STU-002`, `API02-STU-005`

SEMANTIC_DIFFERENCE: Raw and approved Student cases cover cart mutation, cross-user totals, identity spoofing, and correct cart clearing separately; none combines a temporal cart mutation with spoofed identity and a stale value deliberately colliding with another user's cart total. The oracle remains current authenticated cart A and clear-only-A after confirmed success.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT`

EXECUTION_FEASIBILITY: `POSTMAN_PLUS_EXTERNAL_VERIFICATION`

AI_RECOMMENDATION: `APPROVE`

HUMAN_DECISION: `APPROVED`

HUMAN_COMMENT:

## API-03 Replacement

CASE_ID: `API03-STU-006`

API: `API-03`

REPLACES: `API03-STU-005`

TITLE: Prior admin commit survives later non-admin mixed batch

REQUIREMENTS: `API03-REQ-002`, `API03-REQ-003`, `API03-REQ-007`, `API03-REQ-009`

WHY_AI_MISSED_CATEGORY: `COMBINATION_INTERACTION_GAP`

WHY_AI_MISSED: Raw AI generation separated admin/non-admin authorization, atomic mixed-batch rollback, and cross-request transaction scope, so it did not test whether a later unauthorized request can corrupt a previously committed authorized state.

CLOSEST_AI_CASES: `API03-AI-016`, `API03-AI-026`, `API03-AI-018`

CLOSEST_STUDENT_CASES: `API03-STU-001`, `API03-STU-004`

SEMANTIC_DIFFERENCE: Existing cases cover a non-admin mixed batch with no prior commit and an admin valid-then-invalid sequence with no principal change; none verifies cross-principal transaction isolation across an authorized commit followed by an unauthorized mixed-batch attempt.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT`

EXECUTION_FEASIBILITY: `POSTMAN_PLUS_EXTERNAL_VERIFICATION`

AI_RECOMMENDATION: `APPROVE`

HUMAN_DECISION: `APPROVED`

HUMAN_COMMENT:

## Summary

```text
REPLACEMENT_CANDIDATES: 2
API_02_REPLACEMENT: API02-STU-006
API_03_REPLACEMENT: API03-STU-006
CANDIDATES_DISCARDED_AS_DUPLICATES: 0

API_01:
APPROVED_EXISTING: 5
REPLACEMENT_PENDING: 0

API_02:
APPROVED_EXISTING: 4
REJECTED: 1
REPLACEMENT_APPROVED: 1

API_03:
APPROVED_EXISTING: 4
REJECTED: 1
REPLACEMENT_APPROVED: 1
```

`STUDENT_EXTENSION_APPROVED`
