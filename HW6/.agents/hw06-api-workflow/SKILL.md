---
name: hw06-api-workflow
description: Điều phối phân tích requirement API, thiết kế test theo kỹ thuật, AI audit và extension candidates cho HW06 API Testing; dừng tại các human-review checkpoint và không tạo hoặc chạy Postman/Newman.
---

# HW06 API workflow

## Purpose and boundary

Use this skill for one selected HW06 API after the student provides its feature, endpoint, authoritative API/requirement source, and output location. It creates **draft design artifacts only**. Do not use it to create Postman collections, execute requests, declare bugs, or bypass review. Do not start substantive work for a selected API until the student explicitly asks for that API.

Read the shared [canonical test-case schema](references/canonical-test-case-schema.yaml) before producing or consuming a test case. The other HW06 skills use that same file; do not create a per-skill variant.

When a substantive AI-generated design artifact is produced, use `log-ai-audit` if its log is initialized. Preserve the original candidate and record audit metadata through that skill; this workflow must not create a second audit log or fabricate timestamps, model metadata, or human decisions.

## Required input and evidence labels

Required input: `api_id`, `feature_id`, endpoint and method, authoritative requirement/API specification paths, selected security requirements, and an explicit draft output directory. Optional input: implementation paths used only for comparison, existing cases, data dictionary, and known state dependencies.

For each extracted statement, label the source as exactly one of:

- `AUTHORITATIVE_REQUIREMENT`: course requirement, approved specification, or stated acceptance criterion.
- `SUPPORTING_INFORMATION`: contextual material that cannot establish an expected result by itself.
- `IMPLEMENTATION_OBSERVATION`: source/runtime behavior used to identify a discrepancy or a question; never silently promote it to a requirement.

If authoritative sources conflict or omit an assertion needed for a test, record the ambiguity and stop at the relevant review checkpoint instead of guessing.

## Design workflow

1. Extract method, purpose, path/query parameters, headers, body fields, authentication, authorization, business rules, state rules, security requirements, response/status contract, schema expectations, ambiguities, and any labeled implementation observations.
2. Produce a traceable test-condition inventory across `DOMAIN_PARTITION`, `BOUNDARY`, `STATE_TRANSITION`, `SECURITY`, `SCHEMA`, and `BUSINESS_RULE`. A case may list more than one technique but must have a primary technique.
3. Generate approximately 38–42 **AI-generated draft** cases. Deduplicate by normalized request, precondition/state, assertion target, and requirement trace. Do not pad the result: after deduplication, either retain at least 35 unique `AI_GENERATED` cases or report the authoritative-information gap.
4. Apply an explicit audit to every AI-generated case. Preserve the original fields. Assign only `VALID`, `INVALID`, or `INCOMPLETE`, with concrete `audit_reason` and a `correction` for non-VALID cases. Audit verdicts are draft review recommendations until the human provides a decision.
5. Analyze residual coverage gaps. Propose at least five `STUDENT_EXTENSION_CANDIDATE` records per API where the evidence supports them, prioritizing authorization/IDOR, cross-user behavior, replay/repeated operation, invalid state transition, cross-endpoint dependency, business invariant, and suitable race/idempotency-like risks. Set their `source` to `AI_GENERATED`, never `STUDENT_ADDED`, until the student explicitly adopts them. Include `why_ai_missed` and a reason category such as `PROMPT_LIMITATION`, `MODEL_ASSUMPTION`, `SPEC_AMBIGUITY`, `STATEFUL_REASONING_GAP`, `SECURITY_REASONING_GAP`, or `CROSS_ENDPOINT_DEPENDENCY`.
6. Produce a requirement-to-case coverage table and a stable-ID draft. Re-runs must merge by stable ID/content fingerprint, not duplicate cases or overwrite a human-approved artifact.

## State and approval gates

Use these states in the workflow-status artifact: `API_SELECTED`, `REQUIREMENT_ANALYSIS_COMPLETE`, `REQUIREMENT_REVIEW_REQUIRED`, `TEST_GENERATION_COMPLETE`, `AI_AUDIT_COMPLETE`, `EXTENSION_CANDIDATES_COMPLETE`, `TEST_DESIGN_REVIEW_REQUIRED`, `TEST_DESIGN_APPROVED`, `POSTMAN_IMPLEMENTATION_REQUIRED`, `POSTMAN_IMPLEMENTATION_COMPLETE`, `AUTOMATION_REVIEW_REQUIRED`, `REAL_EXECUTION_REQUIRED`, `EXECUTION_COMPLETE`, `EXECUTION_REVIEW_REQUIRED`, and `API_COMPLETE`.

Required stops:

- After extraction: emit `REQUIREMENT_REVIEW_REQUIRED`; advance only on explicit student approval.
- After audit, corrections, coverage, and extension candidates: emit `TEST_DESIGN_REVIEW_REQUIRED`; advance only on an explicit approval such as `APPROVE TEST DESIGN`.
- On approval, mark the exact approved revision `TEST_DESIGN_APPROVED` and return `POSTMAN_IMPLEMENTATION_REQUIRED`. Do not invoke `postman-api-runner` automatically.

Never overwrite an approved revision. Write a separately versioned proposed revision and request review.

## Required output

Keep Markdown/JSON/YAML text artifacts in the caller-approved draft directory. Include requirement analysis with evidence labels, condition/coverage matrix, canonical-schema test-case data, per-case audit outcome, extension candidates, and `workflow-status` with checkpoint. Report `REAL_EXECUTION_REQUIRED` rather than inventing runtime evidence.

For an isolated non-SUT smoke test, run [scripts/smoke-test.ps1](scripts/smoke-test.ps1). It verifies a synthetic schema/audit/checkpoint contract only; it neither invokes an LLM nor produces HW06 test cases.
