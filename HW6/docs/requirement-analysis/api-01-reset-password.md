# API-01 Requirement Analysis — Password Reset

## 1. API Overview

| Field | Value |
| --- | --- |
| API ID | API-01 |
| Feature | FR-03 — Quên mật khẩu & Đặt lại mật khẩu |
| Endpoint | `POST /api/reset-password` |
| Analysis scope | Requirement analysis, implementation comparison, and coverage planning only |
| Status | `REQUIREMENT_ANALYSIS_APPROVED` |

## 2. Sources

| Source | Classification | Role |
| --- | --- | --- |
| `eshop-sut/README.md` §FR-01, §FR-03, §Security SEC-01…SEC-07 | `AUTHORITATIVE` | Password, reset-flow, and security requirements |
| `eshop-sut/api_specification.md` §1.3–1.4 | `AUTHORITATIVE` | Endpoint, HTTP method, documented JSON body |
| `eshop-sut/backend/server.js` lines 68–98 | `IMPLEMENTATION_ONLY` | Observable forgot/reset route behavior |
| `eshop-sut/backend/database.js` lines 48–60 | `IMPLEMENTATION_ONLY` | Observable user/reset-token persistence fields |

## 3. Source Classification

- `AUTHORITATIVE`: README and API specification define expected behavior.
- `IMPLEMENTATION_ONLY`: server/database source is used only to compare observed behavior. It does not define expected results.
- No supporting source was needed for an expected behavior.

## 4. Atomic Requirements

| ID | Source | Source classification | Requirement statement | Relevant parameters/state/security | Notes |
| --- | --- | --- | --- | --- | --- |
| API01-REQ-001 | API specification §1.4 | `AUTHORITATIVE` | The endpoint is `POST /api/reset-password`. | Method/path | |
| API01-REQ-002 | API specification §1.4 | `AUTHORITATIVE` | The documented JSON body contains `email`, `resetToken`, and `newPassword`. | Request body | Requiredness is not stated. |
| API01-REQ-003 | README FR-03 | `AUTHORITATIVE` | Step 1 generates a random six-digit OTP for a registered email. | Email; reset-token issuance | The selected endpoint is step 2; issuance is a state dependency. |
| API01-REQ-004 | README FR-03 | `AUTHORITATIVE` | Step 2 accepts OTP, new password, and password confirmation. | resetToken; newPassword; confirmation | API contract does not document confirmation. |
| API01-REQ-005 | README FR-03 and FR-01 | `AUTHORITATIVE` | The new password follows the FR-01 strong-password rule: minimum 8 characters with uppercase, lowercase, digit, and allowed special character. | newPassword | |
| API01-REQ-006 | README FR-03 | `AUTHORITATIVE` | The system rejects non-matching password and confirmation values. | Confirmation/newPassword | API-level representation is unspecified. |
| API01-REQ-007 | README FR-03 | `AUTHORITATIVE` | An OTP is valid only for the email that requested it. | email/resetToken binding | |
| API01-REQ-008 | README SEC-01 | `AUTHORITATIVE` | Passwords must not be stored as plaintext. | Password persistence | |
| API01-REQ-009 | README SEC-07 | `AUTHORITATIVE` | Reset OTP has at least six-digit entropy, an expiry, and is invalidated after use. | reset-token lifecycle | |
| API01-REQ-010 | API specification §1.3 | `AUTHORITATIVE` | `POST /api/forgot-password` exposes the reset token in the demo response. | State setup | This is a documented demo setup dependency, not an authorization rule. |

## 5. Parameter Analysis

| Parameter | Authoritative facts | Planned dimensions; not test cases |
| --- | --- | --- |
| `email` | Present in documented body; OTP must bind to the requested email. | Registered/requesting email; other registered email; unregistered email; absent/format behavior only where contract is clarified. |
| `resetToken` | OTP is six-digit, has expiry, is one-time, and binds to email. | Issued matching token; token for another email; already-used token; expired token; malformed/absent token. |
| `newPassword` | Strong-password rule is explicit. | Meets all four classes/minimum; each missing class; length boundary; absent value. |
| Confirmation | Required by FR-03 UI flow. | Equal/different/absent once API-level contract is clarified. |
| Content type | API specification labels JSON body. | JSON versus missing/unsupported type is a contract-validation consideration; expected status is not stated. |

## 6. Domain Partition Planning

- `DOMAIN_PARTITION`: email/token binding, token lifecycle classes, password-strength equivalence classes, confirmation match/mismatch.
- `BOUNDARY`: password length 8 threshold; OTP digit-length requirement where observable.
- `STATE_TRANSITION`: requested → issued → reset succeeds → token invalidated; expiry transition.
- `SECURITY`: credential-reset authorization through email/token binding, replay resistance, password-storage handling.
- `SCHEMA`: JSON body fields and response shape once documented.
- `BUSINESS_RULE`: password policy and confirmation rule.

## 7. Business Rules

- New password must meet FR-01 strength constraints.
- Confirmation must match new password.
- OTP may only be used for its requesting email.
- OTP must be invalidated after use.

## 8. State Rules

| State/rule | Evidence | Analysis |
| --- | --- | --- |
| Reset request precedes use | README FR-03; API spec §1.3 | A token is produced in step 1 before step 2 can use it. |
| Token/email association | README FR-03 | Cross-email token use must not be accepted. |
| One-time token | README SEC-07 | Successful use must invalidate token. |
| Expiry | README SEC-07 | Expiry must exist; duration is unspecified. |
| Post-reset login | Not specified for this endpoint | `REQUIREMENT_GAP`; do not infer a response/behavior. |

## 9. Security Requirements

| ID | Applicability | Requirement or consideration |
| --- | --- | --- |
| SEC-01 | Applicable | Do not persist reset password in plaintext. |
| SEC-02 | Needs clarification | The reset flow uses OTP; authoritative sources do not state that this endpoint needs JWT. |
| SEC-05 | Applicable implementation constraint | Database access should be parameterized. |
| SEC-07 | Applicable | Six-digit-or-stronger OTP, expiry, and invalidation after use. |
| SECURITY_TEST_CONSIDERATION | Non-authoritative risk | Token replay, cross-email use, brute-force resistance, and user enumeration should be investigated without assigning unspecified expected results. |

## 10. Schema / Response Contract

- Authoritative request contract: JSON object with `email`, `resetToken`, `newPassword`.
- No authoritative success status, success response body, validation-error schema, or content-type failure response is defined.
- Password confirmation is required by FR-03 but absent from the endpoint body documentation.

## 11. Requirement Gaps

| ID | Gap | Why it matters for testing | Affected technique | Recommended handling |
| --- | --- | --- | --- | --- |
| API01-RG-001 | API contract does not state required/optional fields or validation status/response schema. | Assertions cannot be requirement-backed. | `SCHEMA`, `DOMAIN_PARTITION` | `NEEDS_HUMAN_DECISION` |
| API01-RG-002 | Confirmation field is required by FR-03 but missing from documented API body. | API/UI contract scope is ambiguous. | `BUSINESS_RULE`, `SCHEMA` | `NEEDS_HUMAN_DECISION` |
| API01-RG-003 | OTP expiry duration and failed-attempt/rate-limit behavior are unspecified. | Boundary and state assertions cannot be fixed. | `BOUNDARY`, `STATE_TRANSITION`, `SECURITY` | `SECURITY_TEST_CONSIDERATION` |
| API01-RG-004 | Post-reset authentication/session behavior is unspecified. | Downstream state cannot be asserted. | `STATE_TRANSITION` | `NEEDS_HUMAN_DECISION` |

## 12. Implementation Observations

- `server.js` accepts `email`, `resetToken`, and `newPassword`; it updates where both email and token match, then clears `reset_token`.
- `forgot-password` generates a four-digit numeric value in the observed source.
- The observed database schema has `reset_token` but no expiry field.
- The observed route directly assigns the supplied password to `users.password`.
- These are implementation observations only.

## 13. Implementation Discrepancies

### Potential discrepancies

| ID | Relevant requirement | Expected from authoritative source | Observed implementation | Potential testing impact | Status |
| --- | --- | --- | --- | --- | --- |
| API01-ID-001 | API01-REQ-004/006 | Confirmation is collected and mismatch rejected. | Reset API body/route has no confirmation field or comparison. | Confirmation behavior may be absent at API level. | `POTENTIAL_DISCREPANCY` |
| API01-ID-002 | API01-REQ-008 | Password is not stored plaintext. | Route writes supplied password to `users.password`; seed/schema use a plain `password` field. | Requires real execution/data inspection before defect classification. | `POTENTIAL_DISCREPANCY` |
| API01-ID-003 | API01-REQ-009 | OTP has at least six-digit entropy and expiry. | Observed issuance is four-digit; no expiry field/check is visible. | Token lifecycle/security behavior needs later verification. | `POTENTIAL_DISCREPANCY` |

### Implementation-only observations

| ID | Relevant requirement | Expected from authoritative source | Observed implementation | Potential testing impact | Status |
| --- | --- | --- | --- | --- | --- |
| API01-ID-004 | API01-REQ-009 | OTP becomes invalid after use. | Route clears `reset_token` on successful matching update. | Observed alignment; not a defect claim. | `IMPLEMENTATION_ONLY_OBSERVATION` |

Classification count: **3** `POTENTIAL_DISCREPANCY` + **1** `IMPLEMENTATION_ONLY_OBSERVATION`.

## 14. Coverage Plan

- `DOMAIN_PARTITION`: email/token association; strong/weak password groups; confirmation relation.
- `BOUNDARY`: password minimum length; token digit-length and lifecycle thresholds only after clarification.
- `STATE_TRANSITION`: issuance, use, invalidation, expiry.
- `SECURITY`: reset-token misuse/replay, cross-email binding, password handling.
- `SCHEMA`: documented JSON fields and unresolved error/success contract.
- `BUSINESS_RULE`: password strength and confirmation match.

## 15. Open Questions

1. Is password confirmation an API field or solely a client-side control?
2. What status/body is required for success and each validation failure?
3. What exact token expiry and rate-limit/attempt rules apply?
4. Does `POST /api/reset-password` require JWT under SEC-02, or is the OTP the sole authorization mechanism?

## 16. Analysis Status

`REQUIREMENT_ANALYSIS_APPROVED` — Human corrections applied; A-002 Human Review and A-003 interaction audit verified. Test generation has not started.
