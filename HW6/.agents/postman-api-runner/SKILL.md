---
name: postman-api-runner
description: Chuyển test case API đã được human-approved thành Postman/Newman artifacts, chạy execution thật chỉ khi được phê duyệt, và phân loại failure mà không tự xác nhận product defect.
---

# Postman API runner

## Entry criteria and shared contract

Use this skill only when the exact test-design revision has `TEST_DESIGN_APPROVED` from `hw06-api-workflow`. Read the shared [canonical test-case schema](../hw06-api-workflow/references/canonical-test-case-schema.yaml); reject records that lack stable IDs, approved provenance, or evidence-based expectations. This skill does not perform requirement analysis, AI test generation, human audit, or generate reports/bugs.

## Build artifacts

Create a draft Postman collection with a folder per `api_id`, an environment, data file only when data-driven execution is warranted, and a trace table mapping Postman request names to canonical test-case IDs. Keep credentials/tokens in environment or collection variables, never in committed request bodies. Every request must include exactly:

```http
X-Student-Id: {{studentId}}
```

Use `Authorization: Bearer {{token}}` only when the approved case requires it. Add pre-request scripts for authorized variable/setup handling, and post-response tests for the approved status, schema, business result, and state expectation. Do not invent unavailable setup/cleanup endpoints; surface them as a setup dependency.

After generation, emit `AUTOMATION_REVIEW_REQUIRED`. Do not execute or represent artifacts as final until the student explicitly approves the generated collection and environment.

## Real execution and evidence

On explicit approval for real execution, prepare the exact Postman/Newman command, inputs, and output locations. Run only the approved scope. Preserve raw stdout/stderr and machine-generated report, and record command/time/environment reference without secrets. If execution was not performed or backend readiness is unavailable, return `REAL_EXECUTION_REQUIRED`; never fabricate console output, screenshots, hostname, GitHub Actions evidence, or PASS/FAIL.

Classify each real result as `PASS` or one of `PRODUCT_DEFECT_CANDIDATE`, `TEST_DEFECT`, `TEST_DATA_DEFECT`, `ENVIRONMENT_DEFECT`, `SPEC_AMBIGUITY`, `NEEDS_HUMAN_REVIEW`. A failed assertion is not a product defect by itself. Do not create an issue; only a student-confirmed product defect may become a bug report elsewhere.

When this skill creates a substantive Postman artifact, route its verbatim prompt/output through `log-ai-audit` if initialized. Audit entries retain human decisions; this skill never makes them up.

For an isolated structural smoke check, run [scripts/smoke-test.ps1](scripts/smoke-test.ps1). It builds and inspects an in-memory synthetic collection and parses a synthetic fixture; it does not invoke Newman or a SUT.
