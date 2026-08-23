# HW06 Recovery Preflight Metadata

- PREFLIGHT_ID: `preflight-002`
- TIMESTAMP: `2026-08-21 20:46:43 +07:00`
- PREVIOUS_PREFLIGHT: `preflight-001 — PRESERVED`
- STUDENT_ID_CONFIGURED: `YES`
- STUDENT_ID_VALUE_LOGGED: `NO`
- CREDENTIAL_STRATEGY: `READY`
- RUNTIME_ENVIRONMENT: `test-results/hw06/runtime/HW06-Local.runtime.postman_environment.json`
- RUNTIME_ENVIRONMENT_INTENDED_FOR_COMMIT: `NO`
- NODE_VERSION: `v22.18.0`
- NPM_VERSION: `10.9.3`
- NEWMAN_VERSION: `UNAVAILABLE`
- HTML_REPORTER: `UNAVAILABLE`
- SUT_STATUS: `PREPARED_NOT_STARTED`
- SUT_START_COMMAND: `node server.js`
- DATABASE: `SQLite — ../eshop-sut/backend/database.sqlite`
- REAL_REQUESTS_EXECUTED: `NO`
- PRIMARY_BLOCKER: `NEWMAN_LOCAL_INSTALL_UNAVAILABLE_IN_CURRENT_SANDBOX`

## Trusted configuration sources

- `HW1/[student-id]_HW01_AI_Survey_98/AI_Disclosure_Form.md`
- `HW1/[student-id]_HW01_AI_Survey_98/report.md`
- `HW4/Inclass/[student-id]_MINILAB_POSTGRES/REPORT.md`

All trusted sources contained one identical explicit Student ID. The value is intentionally omitted.

## Newman resolution evidence

- Existing local/global Newman search: not found.
- Offline local installation: failed with `ENOTCACHED`; cache lacked required metadata/dependency responses.
- Registry local installation: failed with `EACCES` under the current network/permission sandbox.
- No package was represented as installed; no Newman version or HTML report was fabricated.

## SUT preparation

`server.js` passed `node --check`; Express/CORS/body-parser/JWT/SQLite dependencies resolve from the backend installation. The backend was not started because Newman remained a mandatory blocker, and zero requests were sent.
