# HW06 Execution Preflight Metadata

- PREFLIGHT_ID: `preflight-001`
- TIMESTAMP: `2026-08-21 20:32:37 +07:00`
- STATUS: `BLOCKED`
- PRIMARY_BLOCKER: `STUDENT_ID_NOT_CONFIGURED`
- BASE_URL: `http://localhost:3000`
- STUDENT_ID_PRESENT: `YES`
- STUDENT_ID_NON_EMPTY: `NO`
- STUDENT_ID_VALUE_LOGGED: `NO`
- NODE_VERSION: `v22.18.0`
- NPM_VERSION: `10.9.3`
- NEWMAN_VERSION: `UNAVAILABLE`
- PORT_3000_LISTENER: `NO`
- SUT_STARTED: `NO`
- SMOKE: `BLOCKED`
- FULL_EXECUTION: `NOT_RUN`
- REAL_REQUESTS_EXECUTED: `NO`
- NEWMAN_STARTED: `NO`

## Local commands invoked

```text
python postman\scripts\validate-static.py
node --version
npm.cmd --version
Get-Command newman.cmd,newman
Get-NetTCPConnection -LocalPort 3000 -State Listen
Get-FileHash <approved inputs> -Algorithm SHA256
```

No HTTP client, SUT startup command, Postman Runner, Newman command, package installation, database write, or external verifier was invoked.

## Approved input hashes (SHA-256)

- `A778144BF198CCAD0408777A5672189150396457238B3C28535D48395C6BB0DB` — `postman/collections/HW06-API-Testing.postman_collection.json`
- `152C28286BAD3ABDA09EB8DE448970EE0C5275C1CACFC48814EFA0B0D057EC55` — `postman/environments/HW06-Local.postman_environment.json`
- `C3572A809D82C94EBF3E4812FE570F239C504BC4ADB5361C8DC9ECE350FD94E9` — `postman/data/api-01-reset-password.json`
- `8582ED5AAED819CAE1701B902FA0BCA29F8F52067F1BB2CD9C14A70D6A072F47` — `postman/data/api-02-checkout.json`
- `1E255EB00EB455514530095DA8E491FE50F2396177F1198662E15CBC594A144E` — `postman/data/api-03-import-products.json`
- `4B7100AAFD3BAF011112A83A57F0ABDB266D75F1F9A1EA9DFF354D35BFA15E4A` — `docs/postman/execution-manifest.md`
- `EAB0DE038042FE7D1D92327BDB695D0C42969A5F17905A045B7E6FCE11D99964` — `docs/postman/external-verification-plan.md`
