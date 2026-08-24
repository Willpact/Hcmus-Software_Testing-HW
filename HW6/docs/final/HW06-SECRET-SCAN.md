# HW06 final secret scan

## Scope and safe method

The scan reports only paths, credential categories, Git state and recommendations. It never prints a credential value. The final delivery surface is the explicit list in `HW06-SUBMISSION-MANIFEST.md`; it excludes raw Newman reports, runtime environments, runtime databases and logs.

## Findings and classification

| File path(s) | Credential finding | Classification | Git state | Intended for ZIP | Recommended action |
| --- | --- | --- | --- | --- | --- |
| `test-results/hw06/run-001/newman.html`; `newman.json`; `external-postcheck.newman.json`; `run-002/newman.html`; `newman.json` | JWT in Authorization/runtime request data, including tokens without an expiry claim | `POTENTIALLY_LIVE_CREDENTIAL` | Tracked in `HEAD` and `origin/main` | No | Keep local only; Human coordinates revocation/rotation with the SUT owner before any history-remediation decision. |
| Same five raw Newman reports | Password/new-password fields from HW06 disposable request/response fixtures | `SYNTHETIC_TEST_FIXTURE` | Tracked in `HEAD` and `origin/main` | No | Do not publish raw reports; reset a test account only if it is shared outside the isolated HW06 environment. |
| Same five raw Newman reports | Reset-token values | `LOCAL_RUNTIME_CREDENTIAL` | Tracked in `HEAD` and `origin/main` | No | Do not publish; invalidate/regenerate only if the local SUT data is reused. |
| Same five raw Newman reports | `Postman-Token` tracing values | `SYNTHETIC_TEST_FIXTURE` | Tracked in `HEAD` and `origin/main` | No | Do not publish raw reports; no separate authentication rotation is implied by a tracing value. |
| Same five raw Newman reports | `X-Student-Id` runtime header value | `LOCAL_RUNTIME_CREDENTIAL` (identity header, not an authentication secret) | Tracked in `HEAD` and `origin/main` | No | Use only redacted derivatives in delivery evidence. |
| `test-results/hw06/run-001/runtime-output.postman_environment.json`; `test-results/hw06/run-002/runtime-input.postman_environment.json`; `runtime-output.postman_environment.json` | Local runtime environment values | `LOCAL_RUNTIME_CREDENTIAL` | Untracked and ignored | No | Keep local only; never stage or package. |

The first row is treated conservatively because the token signature cannot be validated here and at least one observed token has no expiry claim. Token rotation/revocation takes priority over any optional history rewrite.

## Redacted delivery evidence

`docs/execution-results/redacted-newman/` contains deterministic safe derivatives of the genuine raw reports. `REDACTION-MANIFEST.md` records each source/destination SHA-256 pair, redaction categories and the boundary: only credential-bearing values are replaced; testcase results, request/assertion counts, request names, timestamps, run status, HTTP/business evidence and defect interpretation are preserved. This is not a rerun and does not modify the historical source artifacts.

## Git and history boundary

- The five raw Newman reports are already tracked in `HEAD` and `origin/main`; `.gitignore` prevents future accidental additions but cannot untrack existing files.
- Removing them in a future Human-reviewed commit prevents future `HEAD` exposure, but does **not** erase them from Git history.
- No history rewrite is required for the HW06 ZIP because it contains only redacted derivatives. After credential rotation/revocation, history rewrite is optional and must be an explicit Human decision.

## Final delivery scan result

`FINAL_STAGED_CONTENT_SECRET_SCAN: PASS` for the explicit final-commit/ZIP list: it includes redacted Newman derivatives and excludes raw reports, runtime data, `.env`, logs, build caches and unrelated homework. This result does not claim that the existing pushed history is free of credentials.
