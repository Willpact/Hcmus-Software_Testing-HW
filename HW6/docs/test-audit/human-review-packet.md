# Targeted Human Review Packet — Three-API AI Test Audit

- Workflow status: `TARGETED_REVIEW_COMPLETED`
- Audit approval status: `MODIFIED_AND_APPROVED`
- AI audit proposals remain visible; Human Review Decisions and final dispositions have been applied to the separate audit/correction artifacts.
- Raw generation and structured audit artifacts are read-only sources for this packet.
- Student Extension guard: future phase requires at least 5 `STUDENT_ADDED` cases per API (15 total), but none are created here.

## Human decision values

For every case, keep `HUMAN_DECISION: PENDING` until the student selects exactly one:

- `APPROVE_CLASSIFICATION`
- `CHANGE_TO_VALID`
- `CHANGE_TO_INVALID`
- `CHANGE_TO_INCOMPLETE`
- `MODIFY_CORRECTION`
- `REMOVE_FROM_FINAL_SUITE`
- `DEFER_AS_REQUIREMENT_GAP`

## API-01

### API01-AI-013

- **API:** `API-01` — `POST /api/reset-password`
- **PRIMARY TECHNIQUE:** `BOUNDARY`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** Thời điểm sát hạn OTP
- **Objective:** Quan sát hành vi ngay quanh expiry khi thời lượng và quy ước biên chưa được nêu.
- **Requirement IDs:** `API01-REQ-009`
- **Preconditions:** Có cơ chế tạo dữ liệu ở hai phía của thời điểm hết hạn
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/reset-password",
                    "auth_profile":  "NO_JWT_REQUIREMENT_SPECIFIED; use issued email-bound OTP state where required",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "gửi cùng cấu trúc trước và sau thời điểm biên"
                },
    "test_data":  {
                      "description":  "expiry duration phải lấy từ cấu hình quan sát được",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận phía nào của biên được chấp nhận; không tự đặt thời lượng hoặc status.
- **Expected state:** So sánh trạng thái mật khẩu và token trước/sau mỗi lần thử.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'Thời điểm sát hạn OTP' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION, MISSING_STATE_SETUP`
- **Duplicate of:** `NONE`
- **Proposed correction:** Dùng expired-token fixture được xác định bởi cấu hình/clock của môi trường test và ghi rõ hai mốc quan sát; không tự đặt expiry duration.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API01-REQ-009` — [`AUTHORITATIVE`] Reset OTP has at least six-digit entropy, an expiry, and is invalidated after use.
- `API01-RG-003` — [REQUIREMENT_GAP] OTP expiry duration and failed-attempt/rate-limit behavior are unspecified.
- `API01-ID-003` — [`POTENTIAL_DISCREPANCY`] Authoritative expectation: OTP has at least six-digit entropy and expiry.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API01-AI-014

- **API:** `API-01` — `POST /api/reset-password`
- **PRIMARY TECHNIQUE:** `STATE_TRANSITION`
- **SELECTION REASON:** `REPRESENTATIVE_VALID`

#### RAW AI-GENERATED CASE

- **Title:** Luồng issued đến reset thành công
- **Objective:** Kiểm tra chuỗi yêu cầu OTP, dùng OTP hợp lệ và hoàn tất reset.
- **Requirement IDs:** `API01-REQ-003, API01-REQ-009, API01-REQ-010`
- **Preconditions:** Email đã đăng ký
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/reset-password",
                    "auth_profile":  "NO_JWT_REQUIREMENT_SPECIFIED; use issued email-bound OTP state where required",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "forgot-password trước, reset-password sau"
                },
    "test_data":  {
                      "description":  "OTP lấy từ demo response được tài liệu hóa",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Reset hợp lệ đổi mật khẩu đúng một lần.
- **Expected state:** OTP chuyển từ issued sang invalidated.
- **Oracle basis:** `AUTHORITATIVE`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `VALID`
- **Classification reason:** Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- **Issues:** `NONE`
- **Duplicate of:** `NONE`
- **Proposed correction:** NONE
- **Proposed action:** `KEEP_AS_GENERATED`

#### RELEVANT REQUIREMENT/GAP

- `API01-REQ-003` — [`AUTHORITATIVE`] Step 1 generates a random six-digit OTP for a registered email.
- `API01-REQ-009` — [`AUTHORITATIVE`] Reset OTP has at least six-digit entropy, an expiry, and is invalidated after use.
- `API01-REQ-010` — [`AUTHORITATIVE`] `POST /api/forgot-password` exposes the reset token in the demo response.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API01-AI-020

- **API:** `API-01` — `POST /api/reset-password`
- **PRIMARY TECHNIQUE:** `STATE_TRANSITION`
- **SELECTION REASON:** `INVALID, TRACEABILITY_ISSUE`

#### RAW AI-GENERATED CASE

- **Title:** Đăng nhập sau reset
- **Objective:** Quan sát hành vi đăng nhập bằng mật khẩu cũ và mới sau reset vì endpoint không định nghĩa downstream session.
- **Requirement IDs:** `API01-REQ-005`
- **Preconditions:** Một reset đã thành công
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/reset-password",
                    "auth_profile":  "NO_JWT_REQUIREMENT_SPECIFIED; use issued email-bound OTP state where required",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "thực hiện login riêng bằng mật khẩu cũ rồi mật khẩu mới"
                },
    "test_data":  {
                      "description":  "hai lần đăng nhập hậu kiểm",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận hành vi downstream; không dùng làm oracle trực tiếp của reset-password.
- **Expected state:** Ghi nhận trạng thái xác thực quan sát được mà không suy diễn session policy.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INVALID`
- **Classification reason:** Mục tiêu chính là hành vi đăng nhập ở endpoint khác sau reset; API reset-password không có authoritative downstream session/login oracle.
- **Traceability assessment:** `MISALIGNED_CROSS_ENDPOINT`
- **Oracle assessment:** `INSUFFICIENT_OR_NOT_APPLICABLE_FOR_SELECTED_FINAL_SUITE`
- **Issues:** `CROSS_FEATURE_OVERREACH, TRACEABILITY_ISSUE`
- **Duplicate of:** `NONE`
- **Proposed correction:** Chuyển concept sang suite authentication/login riêng sau khi có authoritative post-reset authentication contract; không giữ như case trực tiếp của POST /api/reset-password.
- **Proposed action:** `MOVE_TO_SEPARATE_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API01-REQ-005` — [`AUTHORITATIVE`] The new password follows the FR-01 strong-password rule: minimum 8 characters with uppercase, lowercase, digit, and allowed special character.
- `API01-RG-004` — [REQUIREMENT_GAP] Post-reset authentication/session behavior is unspecified.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API01-AI-025

- **API:** `API-01` — `POST /api/reset-password`
- **PRIMARY TECHNIQUE:** `SECURITY`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** Nhiều lần đoán OTP sai
- **Objective:** Quan sát kiểm soát brute force hoặc rate limit chưa được đặc tả.
- **Requirement IDs:** `API01-REQ-009`
- **Preconditions:** Email đã có OTP hợp lệ
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/reset-password",
                    "auth_profile":  "NO_JWT_REQUIREMENT_SPECIFIED; use issued email-bound OTP state where required",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "lặp nhiều token sai có kiểm soát"
                },
    "test_data":  {
                      "description":  "chuỗi OTP sai, không chứa secret thật",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận throttling, lockout hoặc phản hồi; không tự đặt ngưỡng hay status.
- **Expected state:** Theo dõi token hợp lệ và tài khoản có bị thay đổi trạng thái hay không.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'Nhiều lần đoán OTP sai' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION, SECURITY_REASONING_GAP`
- **Duplicate of:** `NONE`
- **Proposed correction:** Xác định policy/threshold rate-limit authoritative hoặc chuyển thành non-blocking security observation với metric cụ thể và không có pass/fail product verdict.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API01-REQ-009` — [`AUTHORITATIVE`] Reset OTP has at least six-digit entropy, an expiry, and is invalidated after use.
- `API01-RG-003` — [REQUIREMENT_GAP] OTP expiry duration and failed-attempt/rate-limit behavior are unspecified.
- `API01-RISK-BRUTE-FORCE` — [SECURITY_TEST_CONSIDERATION] Risk/observation reference; it does not independently define a transport response or business oracle.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API01-AI-026

- **API:** `API-01` — `POST /api/reset-password`
- **PRIMARY TECHNIQUE:** `SECURITY`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** So sánh phản hồi email tồn tại và không tồn tại
- **Objective:** Quan sát nguy cơ user enumeration mà không yêu cầu hai response schema cụ thể.
- **Requirement IDs:** `API01-REQ-007`
- **Preconditions:** Chuẩn bị một email đăng ký và một email không tồn tại
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/reset-password",
                    "auth_profile":  "NO_JWT_REQUIREMENT_SPECIFIED; use issued email-bound OTP state where required",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "gửi token sai giống nhau cho hai email"
                },
    "test_data":  {
                      "description":  "cặp request chỉ khác email",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** So sánh tín hiệu quan sát được; không tuyên bố response phải đồng nhất khi contract chưa nêu.
- **Expected state:** Không tài khoản nào được đổi mật khẩu.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'So sánh phản hồi email tồn tại và không tồn tại' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, SECURITY_REASONING_GAP`
- **Duplicate of:** `NONE`
- **Proposed correction:** Xác định risk acceptance cho user enumeration và các tín hiệu cần so sánh; không yêu cầu response giống nhau nếu chưa có security acceptance criterion.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API01-REQ-007` — [`AUTHORITATIVE`] An OTP is valid only for the email that requested it.
- `API01-RG-001` — [REQUIREMENT_GAP] API contract does not state required/optional fields or validation status/response schema.
- `API01-RISK-ENUMERATION` — [SECURITY_TEST_CONSIDERATION] Risk/observation reference; it does not independently define a transport response or business oracle.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API01-AI-030

- **API:** `API-01` — `POST /api/reset-password`
- **PRIMARY TECHNIQUE:** `SCHEMA`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** Thêm trường confirmation khớp
- **Objective:** Khảo sát representation của confirmation khi FR-03 yêu cầu nhưng endpoint contract không mô tả.
- **Requirement IDs:** `API01-REQ-004, API01-REQ-006`
- **Preconditions:** OTP hợp lệ
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/reset-password",
                    "auth_profile":  "NO_JWT_REQUIREMENT_SPECIFIED; use issued email-bound OTP state where required",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "thêm confirmation bằng newPassword"
                },
    "test_data":  {
                      "description":  "confirmation=Abcdef1!",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận field được dùng, bỏ qua hay từ chối; không chọn một hành vi làm oracle.
- **Expected state:** Nếu reset thành công, OTP bị vô hiệu hóa; nếu không, ghi nhận state thực tế.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'Thêm trường confirmation khớp' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- **Duplicate of:** `NONE`
- **Proposed correction:** Chỉ thực thi sau khi Human xác nhận tên/vị trí confirmation field; hiện tại giữ như contract-gap candidate.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API01-REQ-004` — [`AUTHORITATIVE`] Step 2 accepts OTP, new password, and password confirmation.
- `API01-REQ-006` — [`AUTHORITATIVE`] The system rejects non-matching password and confirmation values.
- `API01-RG-002` — [REQUIREMENT_GAP] Confirmation field is required by FR-03 but missing from documented API body.
- `API01-ID-001` — [`POTENTIAL_DISCREPANCY`] Authoritative expectation: Confirmation is collected and mismatch rejected.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API01-AI-035

- **API:** `API-01` — `POST /api/reset-password`
- **PRIMARY TECHNIQUE:** `BUSINESS_RULE`
- **SELECTION REASON:** `REPRESENTATIVE_VALID`

#### RAW AI-GENERATED CASE

- **Title:** Mật khẩu không lưu plaintext
- **Objective:** Kiểm tra hậu điều kiện lưu trữ mật khẩu theo SEC-01 sau reset thành công.
- **Requirement IDs:** `API01-REQ-008`
- **Preconditions:** Có quyền kiểm tra dữ liệu trong môi trường test cô lập; Reset hợp lệ đã thành công
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/reset-password",
                    "auth_profile":  "NO_JWT_REQUIREMENT_SPECIFIED; use issued email-bound OTP state where required",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "hậu kiểm bản ghi user, không log secret"
                },
    "test_data":  {
                      "description":  "so sánh an toàn với plaintext đã gửi",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Giá trị persisted không được bằng plaintext newPassword.
- **Expected state:** OTP đã invalidated và thông tin nhạy cảm không bị ghi vào evidence.
- **Oracle basis:** `SECURITY_EXPECTATION`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `VALID`
- **Classification reason:** Applicable security invariant provides a meaningful pass/fail target even though exact HTTP status and response schema remain unspecified.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- **Issues:** `NONE`
- **Duplicate of:** `NONE`
- **Proposed correction:** NONE
- **Proposed action:** `KEEP_AS_GENERATED`

#### RELEVANT REQUIREMENT/GAP

- `API01-REQ-008` — [`AUTHORITATIVE`] Passwords must not be stored as plaintext.
- `API01-ID-002` — [`POTENTIAL_DISCREPANCY`] Authoritative expectation: Password is not stored plaintext.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
MODIFY_CORRECTION

COMMENT:
Classification remains VALID; external persistence/database verification metadata added.

```

### API01-AI-036

- **API:** `API-01` — `POST /api/reset-password`
- **PRIMARY TECHNIQUE:** `BUSINESS_RULE`
- **SELECTION REASON:** `INVALID, SEMANTIC_DUPLICATE`

#### RAW AI-GENERATED CASE

- **Title:** Token vô hiệu hóa sau dùng
- **Objective:** Kiểm tra trực tiếp quy tắc one-time sau một reset thành công.
- **Requirement IDs:** `API01-REQ-009`
- **Preconditions:** Reset đầu tiên thành công
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/reset-password",
                    "auth_profile":  "NO_JWT_REQUIREMENT_SPECIFIED; use issued email-bound OTP state where required",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "thử lại đúng token cũ"
                },
    "test_data":  {
                      "description":  "same email and token",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Không chấp nhận lần dùng thứ hai.
- **Expected state:** Không có lần đổi mật khẩu thứ hai từ token cũ.
- **Oracle basis:** `AUTHORITATIVE`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INVALID`
- **Classification reason:** Case lặp cùng state, action và oracle one-time OTP với API01-AI-015: đều replay đúng OTP sau một reset thành công và kỳ vọng không có lần đổi mật khẩu thứ hai.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_OR_NOT_APPLICABLE_FOR_SELECTED_FINAL_SUITE`
- **Issues:** `SEMANTIC_DUPLICATION`
- **Duplicate of:** `API01-AI-015`
- **Difference:** Raw wording/primary technique differs: API01-AI-015 frames replay after success, while API01-AI-036 frames one-time invalidation. Both use the same post-success state, reuse the same OTP, and expect no second password change.
- **Why semantic duplicate:** Case lặp cùng state, action và oracle one-time OTP với API01-AI-015: đều replay đúng OTP sau một reset thành công và kỳ vọng không có lần đổi mật khẩu thứ hai.
- **Proposed correction:** Giữ API01-AI-015 làm case canonical cho OTP replay; bỏ API01-AI-036 khỏi final suite nhưng bảo toàn raw record.
- **Proposed action:** `REMOVE_FROM_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API01-REQ-009` — [`AUTHORITATIVE`] Reset OTP has at least six-digit entropy, an expiry, and is invalidated after use.
- `API01-ID-004` — [`IMPLEMENTATION_ONLY_OBSERVATION`] Authoritative expectation: OTP becomes invalid after use.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API01-AI-040

- **API:** `API-01` — `POST /api/reset-password`
- **PRIMARY TECHNIQUE:** `BUSINESS_RULE`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** OTP có hơn sáu chữ số
- **Objective:** Kiểm tra yêu cầu at least six-digit entropy với token do hệ thống phát hành có độ dài lớn hơn.
- **Requirement IDs:** `API01-REQ-003, API01-REQ-009`
- **Preconditions:** Hệ thống test có thể cấp token hơn sáu chữ số
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/reset-password",
                    "auth_profile":  "NO_JWT_REQUIREMENT_SPECIFIED; use issued email-bound OTP state where required",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "email đúng, issued token dài hơn sáu, mật khẩu mạnh"
                },
    "test_data":  {
                      "description":  "issued token length=7",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Token do hệ thống cấp có entropy không dưới sáu chữ số và đủ điều kiện lifecycle.
- **Expected state:** Nếu thành công, token dài hơn sáu cũng phải bị vô hiệu hóa sau dùng.
- **Oracle basis:** `AUTHORITATIVE`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'OTP có hơn sáu chữ số' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, MISSING_STATE_SETUP`
- **Duplicate of:** `NONE`
- **Proposed correction:** Chỉ giữ khi issuer test có thể phát hành token hơn sáu chữ số theo contract; bổ sung deterministic state setup hoặc defer.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API01-REQ-003` — [`AUTHORITATIVE`] Step 1 generates a random six-digit OTP for a registered email.
- `API01-REQ-009` — [`AUTHORITATIVE`] Reset OTP has at least six-digit entropy, an expiry, and is invalidated after use.
- `API01-ID-003` — [`POTENTIAL_DISCREPANCY`] Authoritative expectation: OTP has at least six-digit entropy and expiry.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
CHANGE_TO_INVALID

COMMENT:
Changed to INVALID: unsupported seven-digit issuer precondition; remove from final executable suite.

```

## API-02

### API02-AI-008

- **API:** `API-02` — `POST /api/checkout`
- **PRIMARY TECHNIQUE:** `DOMAIN_PARTITION`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** Thiếu shipping_address
- **Objective:** Khảo sát requiredness địa chỉ chưa được authoritative source quy định.
- **Requirement IDs:** `API02-REQ-003`
- **Preconditions:** JWT hợp lệ; Cart có hàng
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/checkout",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "bỏ shipping_address"
                },
    "test_data":  {
                      "description":  "total_amount có mặt",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận hành vi mà không gán status hay validation result.
- **Expected state:** Theo dõi state thực tế; không bịa order schema.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'Thiếu shipping_address' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- **Duplicate of:** `NONE`
- **Proposed correction:** Cần authoritative shipping_address requiredness trước khi tạo pass/fail oracle; nếu chưa có thì giữ observation non-blocking.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API02-REQ-003` — [`AUTHORITATIVE`] The documented JSON body has `total_amount` and `shipping_address`.
- `API02-RG-002` — [REQUIREMENT_GAP] Shipping-address requiredness/format/limits are unspecified.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API02-AI-011

- **API:** `API-02` — `POST /api/checkout`
- **PRIMARY TECHNIQUE:** `BOUNDARY`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** Cart rỗng
- **Objective:** Khảo sát hành vi tại biên không có item vì empty-cart contract chưa nêu.
- **Requirement IDs:** `API02-REQ-005, API02-REQ-006`
- **Preconditions:** JWT hợp lệ; Cart của user rỗng
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/checkout",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "body documented"
                },
    "test_data":  {
                      "description":  "empty cart",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận accept/reject và response; không bịa expected outcome.
- **Expected state:** Ghi nhận cart/order state quan sát được, không dùng order-line persistence làm oracle.
- **Oracle basis:** `PARTIALLY_SPECIFIED`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'Cart rỗng' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- **Duplicate of:** `NONE`
- **Proposed correction:** Human phải xác định empty-cart behavior và state oracle; không tự đặt status, order creation hay error schema.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API02-REQ-005` — [`AUTHORITATIVE`] Payment total is calculated automatically from cart and not directly editable by user.
- `API02-REQ-006` — [`AUTHORITATIVE`] Backend recalculates the total and must not accept client-supplied `total_amount`.
- `API02-RG-003` — [REQUIREMENT_GAP] Empty-cart behavior, order-line persistence, inventory handling, and initial order status are unspecified.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API02-AI-014

- **API:** `API-02` — `POST /api/checkout`
- **PRIMARY TECHNIQUE:** `STATE_TRANSITION`
- **SELECTION REASON:** `REPRESENTATIVE_VALID`

#### RAW AI-GENERATED CASE

- **Title:** Cart populated đến cleared
- **Objective:** Kiểm tra trực tiếp chuyển trạng thái sau checkout thành công.
- **Requirement IDs:** `API02-REQ-005, API02-REQ-007`
- **Preconditions:** JWT hợp lệ; Cart có hàng và snapshot trước chạy
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/checkout",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "body hợp lệ"
                },
    "test_data":  {
                      "description":  "cart snapshot before",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Checkout thành công sử dụng tổng cart.
- **Expected state:** Cart của authenticated user trở thành rỗng.
- **Oracle basis:** `AUTHORITATIVE`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `VALID`
- **Classification reason:** Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- **Issues:** `NONE`
- **Duplicate of:** `NONE`
- **Proposed correction:** NONE
- **Proposed action:** `KEEP_AS_GENERATED`

#### RELEVANT REQUIREMENT/GAP

- `API02-REQ-005` — [`AUTHORITATIVE`] Payment total is calculated automatically from cart and not directly editable by user.
- `API02-REQ-007` — [`AUTHORITATIVE`] A successful checkout clears the cart.
- `API02-ID-002` — [`POTENTIAL_DISCREPANCY`] Authoritative expectation: Successful checkout clears cart.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API02-AI-015

- **API:** `API-02` — `POST /api/checkout`
- **PRIMARY TECHNIQUE:** `STATE_TRANSITION`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** Gửi lại checkout sau thành công
- **Objective:** Quan sát idempotency/replay chưa được đặc tả.
- **Requirement IDs:** `API02-REQ-007`
- **Preconditions:** Checkout đầu đã thành công và cart đã clear
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/checkout",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "gửi lại cùng body và JWT"
                },
    "test_data":  {
                      "description":  "identical replay",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận phản hồi lần hai; không tự quy định có hay không tạo order mới.
- **Expected state:** Ghi nhận cart và order state nhưng không dùng order-line persistence làm oracle.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'Gửi lại checkout sau thành công' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION, SECURITY_REASONING_GAP`
- **Duplicate of:** `NONE`
- **Proposed correction:** Cần idempotency/replay policy và deterministic order-state observation trước khi case có final pass/fail result.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API02-REQ-007` — [`AUTHORITATIVE`] A successful checkout clears the cart.
- `API02-RG-005` — [REQUIREMENT_GAP] Repeated-checkout/idempotency behavior is unspecified.
- `API02-RISK-REPLAY` — [SECURITY_TEST_CONSIDERATION] Risk/observation reference; it does not independently define a transport response or business oracle.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API02-AI-019

- **API:** `API-02` — `POST /api/checkout`
- **PRIMARY TECHNIQUE:** `STATE_TRANSITION`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** Input body lỗi và cart state
- **Objective:** Quan sát effect-on-failure vì requirement chỉ quy định clear khi thành công.
- **Requirement IDs:** `API02-REQ-007`
- **Preconditions:** JWT hợp lệ; Cart có hàng
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/checkout",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "malformed business input"
                },
    "test_data":  {
                      "description":  "shipping_address thiếu",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận kết quả; không suy diễn failure semantics.
- **Expected state:** Hậu kiểm cart; chỉ kết luận clear bắt buộc nếu request được xác nhận thành công.
- **Oracle basis:** `PARTIALLY_SPECIFIED`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'Input body lỗi và cart state' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION, MISSING_STATE_SETUP`
- **Duplicate of:** `NONE`
- **Proposed correction:** Xác định failure condition và expected cart effect; chỉ clear-on-success hiện là authoritative.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API02-REQ-007` — [`AUTHORITATIVE`] A successful checkout clears the cart.
- `API02-RG-003` — [REQUIREMENT_GAP] Empty-cart behavior, order-line persistence, inventory handling, and initial order status are unspecified.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API02-AI-026

- **API:** `API-02` — `POST /api/checkout`
- **PRIMARY TECHNIQUE:** `SECURITY`
- **SELECTION REASON:** `REPRESENTATIVE_VALID`

#### RAW AI-GENERATED CASE

- **Title:** Injection trong shipping_address
- **Objective:** Kiểm tra địa chỉ được xử lý như dữ liệu, không như câu lệnh.
- **Requirement IDs:** `API02-REQ-003, API02-REQ-011`
- **Preconditions:** JWT hợp lệ; Cart có hàng
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/checkout",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "shipping_address chứa metacharacters"
                },
    "test_data":  {
                      "description":  "\"x\u0027); DROP TABLE orders;--\"",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Không được thực thi nội dung input như lệnh hoặc phá dữ liệu ngoài phạm vi.
- **Expected state:** Nếu checkout thành công, cart clear; dữ liệu khác còn nguyên.
- **Oracle basis:** `SECURITY_EXPECTATION`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `VALID`
- **Classification reason:** Applicable security invariant provides a meaningful pass/fail target even though exact HTTP status and response schema remain unspecified.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- **Issues:** `NONE`
- **Duplicate of:** `NONE`
- **Proposed correction:** NONE
- **Proposed action:** `KEEP_AS_GENERATED`

#### RELEVANT REQUIREMENT/GAP

- `API02-REQ-003` — [`AUTHORITATIVE`] The documented JSON body has `total_amount` and `shipping_address`.
- `API02-REQ-011` — [`AUTHORITATIVE`] Database queries use parameterized queries.
- `API02-RISK-INJECTION` — [SECURITY_TEST_CONSIDERATION] Risk/observation reference; it does not independently define a transport response or business oracle.
- `API02-ID-004` — [`IMPLEMENTATION_ONLY_OBSERVATION`] Authoritative expectation: JWT and parameterized persistence apply.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API02-AI-028

- **API:** `API-02` — `POST /api/checkout`
- **PRIMARY TECHNIQUE:** `SECURITY`
- **SELECTION REASON:** `INVALID, SEMANTIC_DUPLICATE`

#### RAW AI-GENERATED CASE

- **Title:** JWT hợp lệ gửi request trùng nhanh
- **Objective:** Quan sát duplicate submission khi contract idempotency chưa tồn tại.
- **Requirement IDs:** `API02-REQ-004, API02-REQ-006`
- **Preconditions:** JWT hợp lệ; Cart có hàng
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/checkout",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "hai request tuần tự rất gần nhau"
                },
    "test_data":  {
                      "description":  "same body, no idempotency key",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận kết quả; không bịa chính sách deduplicate.
- **Expected state:** Ghi nhận cart/order state thực tế và tách khỏi order-line oracle.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INVALID`
- **Classification reason:** Case gửi hai request trùng tuần tự gần nhau không tạo equivalence class khác rõ ràng so với replay sau success ở API02-AI-015; concurrency thực sự đã được tách ở API02-AI-020.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_OR_NOT_APPLICABLE_FOR_SELECTED_FINAL_SUITE`
- **Issues:** `SEMANTIC_DUPLICATION`
- **Duplicate of:** `API02-AI-015`
- **Difference:** API02-AI-028 says two identical requests are sent rapidly in sequence; API02-AI-015 already covers sequential replay after success, while true concurrency is separately covered by API02-AI-020. No distinct final oracle remains.
- **Why semantic duplicate:** Case gửi hai request trùng tuần tự gần nhau không tạo equivalence class khác rõ ràng so với replay sau success ở API02-AI-015; concurrency thực sự đã được tách ở API02-AI-020.
- **Proposed correction:** Giữ API02-AI-015 cho sequential replay và API02-AI-020 cho concurrent requests; bỏ API02-AI-028 khỏi final suite.
- **Proposed action:** `REMOVE_FROM_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API02-REQ-004` — [`AUTHORITATIVE`] Only an authenticated user may check out.
- `API02-REQ-006` — [`AUTHORITATIVE`] Backend recalculates the total and must not accept client-supplied `total_amount`.
- `API02-RG-005` — [REQUIREMENT_GAP] Repeated-checkout/idempotency behavior is unspecified.
- `API02-RISK-REPLAY` — [SECURITY_TEST_CONSIDERATION] Risk/observation reference; it does not independently define a transport response or business oracle.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API02-AI-038

- **API:** `API-02` — `POST /api/checkout`
- **PRIMARY TECHNIQUE:** `BUSINESS_RULE`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** Cart có coupon context
- **Objective:** Giữ FR-09 ở supporting context và quan sát liệu checkout có integration hay không.
- **Requirement IDs:** `API02-REQ-005, API02-REQ-006, API02-REQ-009`
- **Preconditions:** JWT hợp lệ; Cart test có trạng thái coupon được thiết lập qua feature riêng
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/checkout",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "checkout body không có contract coupon"
                },
    "test_data":  {
                      "description":  "coupon context only",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận total và phản hồi; không dùng FR-09 làm direct checkout oracle.
- **Expected state:** Nếu checkout được xác nhận thành công, cart clear theo FR-08.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'Cart có coupon context' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `SUPPORTING_ONLY_REQUIRES_HUMAN_LINKAGE`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION, CROSS_FEATURE_OVERREACH`
- **Duplicate of:** `NONE`
- **Proposed correction:** Chỉ giữ trong final checkout suite nếu authoritative source xác nhận coupon integration; nếu không, chuyển sang future cross-feature suite.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API02-REQ-005` — [`AUTHORITATIVE`] Payment total is calculated automatically from cart and not directly editable by user.
- `API02-REQ-006` — [`AUTHORITATIVE`] Backend recalculates the total and must not accept client-supplied `total_amount`.
- `API02-REQ-009` — [`SUPPORTING`] FR-09 describes coupon eligibility as cross-feature context.
- `API02-RG-004` — [REQUIREMENT_GAP] FR-09 coupon rules do not state how/if `POST /api/checkout` receives an applied coupon result.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
DEFER_AS_REQUIREMENT_GAP

COMMENT:
Classification remains INCOMPLETE; deferred as a cross-feature coupon/checkout requirement gap.

```

### API02-AI-039

- **API:** `API-02` — `POST /api/checkout`
- **PRIMARY TECHNIQUE:** `BUSINESS_RULE`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** Quan sát initial order status
- **Objective:** Ghi nhận trạng thái order tạo ra mà không biến implementation value thành requirement.
- **Requirement IDs:** `API02-REQ-003`
- **Preconditions:** Checkout hợp lệ có thể thành công; Có quyền đọc state test
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/checkout",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "body documented"
                },
    "test_data":  {
                      "description":  "post-checkout observation",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Không có authoritative initial status oracle.
- **Expected state:** Ghi nhận giá trị thực tế; không đánh defect vì khác một giá trị tự giả định.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'Quan sát initial order status' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- **Duplicate of:** `NONE`
- **Proposed correction:** Cần authoritative initial order-status contract trước khi có pass/fail oracle; implementation value chỉ được ghi observation.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API02-REQ-003` — [`AUTHORITATIVE`] The documented JSON body has `total_amount` and `shipping_address`.
- `API02-RG-003` — [REQUIREMENT_GAP] Empty-cart behavior, order-line persistence, inventory handling, and initial order status are unspecified.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

## API-03

### API03-AI-014

- **API:** `API-03` — `POST /api/admin/import-products`
- **PRIMARY TECHNIQUE:** `BOUNDARY`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** Batch kích thước lớn
- **Objective:** Khảo sát capacity khi maximum batch size chưa được quy định.
- **Requirement IDs:** `API03-REQ-004`
- **Preconditions:** Admin JWT hợp lệ; Môi trường test cô lập
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/admin/import-products",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "products array lớn có kiểm soát"
                },
    "test_data":  {
                      "description":  "size được ghi trong evidence, không gọi là max",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận giới hạn/thời gian/phản hồi; không bịa threshold.
- **Expected state:** Hậu kiểm số item và atomicity theo kết quả.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'Batch kích thước lớn' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION, MISSING_STATE_SETUP`
- **Duplicate of:** `NONE`
- **Proposed correction:** Cần authoritative capacity limit và reproducible large-batch fixture; không gọi một kích thước tự chọn là maximum.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API03-REQ-004` — [`AUTHORITATIVE`] Documented request body has `products`, an array of objects.
- `API03-RG-002` — [REQUIREMENT_GAP] Maximum batch size and duplicate-product policy are unspecified.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API03-AI-015

- **API:** `API-03` — `POST /api/admin/import-products`
- **PRIMARY TECHNIQUE:** `BOUNDARY`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** Price có nhiều chữ số thập phân
- **Objective:** Khảo sát precision/rounding chưa được quy định trong FR-16.
- **Requirement IDs:** `API03-REQ-007`
- **Preconditions:** Admin JWT hợp lệ
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/admin/import-products",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "price positive với nhiều decimal places"
                },
    "test_data":  {
                      "description":  "1.234567",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận representation và persisted value; chỉ positivity là oracle authoritative.
- **Expected state:** Nếu batch được chấp nhận, atomic commit vẫn áp dụng.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'Price có nhiều chữ số thập phân' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- **Duplicate of:** `NONE`
- **Proposed correction:** Xác định price precision/rounding contract hoặc chuyển thành observation với persisted-value evidence.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API03-REQ-007` — [`AUTHORITATIVE`] Each imported `name` must be non-empty and `price` must be positive.
- `API03-RG-005` — [REQUIREMENT_GAP] Whitespace semantics for name and numeric format/precision for price are unspecified.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API03-AI-026

- **API:** `API-03` — `POST /api/admin/import-products`
- **PRIMARY TECHNIQUE:** `SECURITY`
- **SELECTION REASON:** `REPRESENTATIVE_VALID`

#### RAW AI-GENERATED CASE

- **Title:** JWT user không phải admin
- **Objective:** Kiểm tra role enforcement chứ không chỉ token existence.
- **Requirement IDs:** `API03-REQ-002, API03-REQ-003`
- **Preconditions:** Valid JWT role user; Snapshot products
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/admin/import-products",
                    "auth_profile":  "Bearer test JWT with role=user",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "Bearer user token, valid products"
                },
    "test_data":  {
                      "description":  "role=user",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Không cho non-admin import.
- **Expected state:** Products state không đổi.
- **Oracle basis:** `AUTHORITATIVE`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `VALID`
- **Classification reason:** Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- **Issues:** `NONE`
- **Duplicate of:** `NONE`
- **Proposed correction:** NONE
- **Proposed action:** `KEEP_AS_GENERATED`

#### RELEVANT REQUIREMENT/GAP

- `API03-REQ-002` — [`AUTHORITATIVE`] Admin APIs require bearer JWT and an Admin account.
- `API03-REQ-003` — [`AUTHORITATIVE`] Admin APIs verify `role = 'admin'` in token, not token existence only.
- `API03-ID-001` — [`POTENTIAL_DISCREPANCY`] Authoritative expectation: Valid JWT plus Admin role check.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API03-AI-032

- **API:** `API-03` — `POST /api/admin/import-products`
- **PRIMARY TECHNIQUE:** `SCHEMA`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** Thiếu optionality-unknown fields
- **Objective:** Khảo sát description, imageUrl và category_id vì requiredness import chưa được định nghĩa.
- **Requirement IDs:** `API03-REQ-005`
- **Preconditions:** Admin JWT hợp lệ
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/admin/import-products",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "item chỉ có name và price"
                },
    "test_data":  {
                      "description":  "minimal item",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận behavior; không áp FR-15 category rule làm direct oracle.
- **Expected state:** Theo dõi atomic commit/rollback thực tế.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'Thiếu optionality-unknown fields' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `SUPPORTING_ONLY_REQUIRES_HUMAN_LINKAGE`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION, CROSS_FEATURE_OVERREACH`
- **Duplicate of:** `NONE`
- **Proposed correction:** Xác định optionality của description, imageUrl, category_id cho import; FR-15 không tự tạo direct oracle.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API03-REQ-005` — [`AUTHORITATIVE`] Documented product fields are `name`, `price`, `description`, `imageUrl`, and `category_id`.
- `API03-RG-003` — [REQUIREMENT_GAP] Import-specific category existence/error behavior, name maximum length, and optionality of description/image fields are unspecified.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API03-AI-034

- **API:** `API-03` — `POST /api/admin/import-products`
- **PRIMARY TECHNIQUE:** `SCHEMA`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** category_id không tồn tại
- **Objective:** Khảo sát reference semantics chưa được FR-16 quy định.
- **Requirement IDs:** `API03-REQ-005`
- **Preconditions:** Admin JWT hợp lệ
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/admin/import-products",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "category_id là ID không tồn tại"
                },
    "test_data":  {
                      "description":  "nonexistent category",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận accept/reject/reason; không coi một phía là requirement.
- **Expected state:** Hậu kiểm atomic behavior theo kết quả.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'category_id không tồn tại' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `SUPPORTING_ONLY_REQUIRES_HUMAN_LINKAGE`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION, CROSS_FEATURE_OVERREACH`
- **Duplicate of:** `NONE`
- **Proposed correction:** Cần FR-16 category-reference rule; không suy diễn nonexistent category phải accept/reject.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API03-REQ-005` — [`AUTHORITATIVE`] Documented product fields are `name`, `price`, `description`, `imageUrl`, and `category_id`.
- `API03-RG-003` — [REQUIREMENT_GAP] Import-specific category existence/error behavior, name maximum length, and optionality of description/image fields are unspecified.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

### API03-AI-035

- **API:** `API-03` — `POST /api/admin/import-products`
- **PRIMARY TECHNIQUE:** `SCHEMA`
- **SELECTION REASON:** `REPRESENTATIVE_VALID`

#### RAW AI-GENERATED CASE

- **Title:** Xác nhận boundary JSON của endpoint
- **Objective:** Bao phủ gap CSV-vs-JSON bằng request JSON products chứ không giả định raw CSV.
- **Requirement IDs:** `API03-REQ-006`
- **Preconditions:** Admin JWT hợp lệ
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/admin/import-products",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "gửi JSON products array theo API spec"
                },
    "test_data":  {
                      "description":  "no raw CSV request",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Selected endpoint được kiểm tra theo JSON contract; vị trí CSV parsing vẫn unresolved.
- **Expected state:** State theo atomic import rules.
- **Oracle basis:** `PARTIALLY_SPECIFIED`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `VALID`
- **Classification reason:** Transport details are unspecified, but the raw case retains a requirement-backed business/state oracle sufficient for execution.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- **Issues:** `NONE`
- **Duplicate of:** `NONE`
- **Proposed correction:** NONE
- **Proposed action:** `KEEP_AS_GENERATED`

#### RELEVANT REQUIREMENT/GAP

- `API03-REQ-006` — [`AUTHORITATIVE`] The business feature imports multiple products from a CSV file with the stated extension/header/RFC 4180 requirements.
- `API03-RG-001` — [REQUIREMENT_GAP] CSV-file feature contract and JSON-array endpoint contract do not state their boundary.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
MODIFY_CORRECTION

COMMENT:
Classification remains VALID; traceability corrected to API03-REQ-004 primary, API03-RG-001 gap, API03-REQ-006 supporting.

```

### API03-AI-040

- **API:** `API-03` — `POST /api/admin/import-products`
- **PRIMARY TECHNIQUE:** `BUSINESS_RULE`
- **SELECTION REASON:** `REPRESENTATIVE_INCOMPLETE`

#### RAW AI-GENERATED CASE

- **Title:** Duplicate products trong cùng batch
- **Objective:** Khảo sát duplicate policy chưa được quy định.
- **Requirement IDs:** `API03-REQ-004`
- **Preconditions:** Admin JWT hợp lệ
- **Request / test data:**

```json
{
    "request":  {
                    "method":  "POST",
                    "path":  "/api/admin/import-products",
                    "auth_profile":  "Bearer test JWT matching the stated precondition",
                    "content_type":  "application/json unless the case explicitly varies it",
                    "body_variation":  "hai item trùng name và price"
                },
    "test_data":  {
                      "description":  "duplicate pair",
                      "secret_policy":  "Use disposable fixtures or environment variables; do not store real secrets."
                  }
}
```
- **Expected status:** `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- **Expected business result:** Ghi nhận duplicate được chấp nhận hay báo lỗi; không tự chọn oracle.
- **Expected state:** Nếu một duplicate bị coi là error, authoritative atomic rollback áp dụng; nếu không, ghi nhận commit thực tế.
- **Oracle basis:** `OBSERVABLE_ONLY`
- **Notes:** RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED

#### AI AUDIT PROPOSAL

- **Classification:** `INCOMPLETE`
- **Classification reason:** Concept/risk 'Duplicate products trong cùng batch' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- **Traceability assessment:** `ALIGNED_WITH_APPROVED_ANALYSIS`
- **Oracle assessment:** `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- **Issues:** `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- **Duplicate of:** `NONE`
- **Proposed correction:** Cần duplicate-product policy; nếu duplicate bị định nghĩa là error thì atomic rollback mới trở thành nhánh authoritative.
- **Proposed action:** `REVISE_BEFORE_FINAL_SUITE`

#### RELEVANT REQUIREMENT/GAP

- `API03-REQ-004` — [`AUTHORITATIVE`] Documented request body has `products`, an array of objects.
- `API03-RG-002` — [REQUIREMENT_GAP] Maximum batch size and duplicate-product policy are unspecified.

#### HUMAN REVIEW

```text
HUMAN_DECISION:
APPROVE_CLASSIFICATION

COMMENT:
Classification approved as proposed in the targeted packet.

```

## Cross-case summary

```text
TOTAL_CASES_IN_REVIEW_PACKET: 25

INVALID_INCLUDED: 3/3
SEMANTIC_DUPLICATES_INCLUDED: 2/2
TRACEABILITY_ISSUES_INCLUDED: 1/1

INCOMPLETE_SAMPLES:
API-01: 5
API-02: 6
API-03: 5

VALID_SAMPLES:
API-01: 2
API-02: 2
API-03: 2
```

## HUMAN REVIEW QUESTIONS

1. Do the three `INVALID` classifications appear justified?
2. Are `API01-AI-036` and `API02-AI-028` truly redundant with their identified canonical cases?
3. Should observable-only requirement-gap cases remain `INCOMPLETE`, be retained as non-blocking observational tests, or be deferred?
4. Can any confirmation, coupon, FR-15/category, or downstream-login case be salvaged by narrowing its oracle without inventing integration?
5. Are the six sampled `VALID` cases adequately requirement/security-backed, or has the audit classified any of them too easily?
6. Which missing contracts should be resolved before correction: OTP expiry/rate-limit, shipping/empty-cart/idempotency, or import batch/duplicate/category/precision?

