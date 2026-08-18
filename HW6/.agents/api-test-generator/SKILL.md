---
name: api-test-generator
description: Thiết kế và chạy quy trình tái sử dụng để sinh draft API test cases có cấu trúc từ specification, có deduplication và coverage check; không thay cho workflow HW06 hoặc tạo diagram nộp bài.
---

# API test generator

## Purpose and boundary

This is the reusable HW06 AI-driven generator deliverable. It accepts a generic API specification and produces **candidate** structured test cases, not approved tests, Postman artifacts, execution evidence, or a final assignment diagram. It must work for other EShop APIs and APIs outside the three selected HW06 endpoints; never hardcode an endpoint, role, or status behavior.

Read the shared [canonical test-case schema](../hw06-api-workflow/references/canonical-test-case-schema.yaml) before output. Candidate records use `source: AI_GENERATED`, `lifecycle_state: DRAFT`, `audit_status: PENDING_HUMAN_REVIEW`, and `execution_status: NOT_IMPLEMENTED`. The generator cannot assign `STUDENT_ADDED`.

## Input, pipeline, and output

Required input: one readable authoritative API specification, an API identifier, and a caller-approved draft output location. Optional input: supporting requirements, data dictionary, state model, source comparison paths, and existing canonical cases for deduplication.

Perform this logical pipeline and retain traceability:

`API Specification -> Requirement Extraction -> Parameter & Domain Analysis -> Boundary Analysis -> State Model Analysis -> Security Analysis -> Schema Analysis -> Candidate Test Generation -> Deduplication -> Coverage Check -> Structured Test Cases`

Do not infer required behavior from implementation observations. Label extraction evidence as `AUTHORITATIVE_REQUIREMENT`, `SUPPORTING_INFORMATION`, or `IMPLEMENTATION_OBSERVATION`; unresolved requirements remain explicit ambiguities. Generate cases across `DOMAIN_PARTITION`, `BOUNDARY`, `STATE_TRANSITION`, `SECURITY`, `SCHEMA`, and `BUSINESS_RULE` where the specification supports them. Every case must include canonical fields and requirement IDs.

Deduplicate using a deterministic fingerprint of method/path, normalized input partition, precondition/state, authorization context, expected assertion, and requirement IDs. Merge only semantically identical candidates while retaining their source trace; do not delete a human-approved case. Create a technique/requirement coverage summary and return `GENERATOR_OUTPUT_REVIEW_REQUIRED` if source coverage is incomplete, a non-verifiable expectation was detected, or a human has not approved downstream use.

For detailed pseudocode and report-ready textual flow, read [references/generator-design.md](references/generator-design.md). It intentionally supplies no diagram. The final assignment diagram remains student-drawn.

Use `log-ai-audit` for a substantive generated artifact only when that audit workflow is initialized. Do not audit smoke fixtures as coursework artifacts.

Run [scripts/smoke-test.ps1](scripts/smoke-test.ps1) for a synthetic generic-spec check. It validates generation shape and deduplication without contacting an API or creating a HW06 test design.
