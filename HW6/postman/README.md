# HW06 Postman Static Review Draft

Status: `POSTMAN_IMPLEMENTATION_REVIEW_REQUIRED`  
Runtime evidence: `NONE`

This collection contains one stable testcase identity for each of the 93 final executable cases, plus 10 reusable setup/precheck helpers. It was generated from approved local artifacts only. It has not sent network traffic and must not be described as passed or failed.

## Files

- `collections/HW06-API-Testing.postman_collection.json`: one collection with three API folders, each split into `Setup` and `Test Cases`.
- `environments/HW06-Local.postman_environment.json`: local, secret-free environment to fill before execution.
- `environments/HW06-Local.example.postman_environment.json`: shareable example with no real credentials or tokens.
- `data/*.json`: one row per final testcase, including body variation, oracle, mode, setup, and dependency metadata.

## Review and later execution

1. Review the final inventory, request bodies, auth variants, setup dependencies, and external plan.
2. Fill disposable fixture credentials/tokens locally; do not commit secrets.
3. Keep `X-Student-Id: {{studentId}}` on every SUT request.
4. Execute only after explicit Human approval. The current checkpoint forbids SUT startup, Postman Runner, Newman, screenshots, and runtime verdicts.

Generic testcase scripts only verify configuration and capture the response. They intentionally do not invent status codes or response schemas. A testcase PASS/FAIL decision requires the business/state oracle and any declared postcondition/external verification.
