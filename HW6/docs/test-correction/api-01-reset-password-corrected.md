# API-01 Corrected AI-generated Suite

- Source remains `AI_GENERATED`; raw case IDs are stable and raw files are unchanged.
- Status: `HUMAN_APPROVED_AI_CORRECTION`; execution: `REAL_EXECUTION_REQUIRED`.

## Summary

- `RAW_AI_GENERATED`: 40
- `VALID_AFTER_AUDIT`: 21
- `INVALID_REMOVED`: 3
- `INCOMPLETE_SALVAGED`: 4
- `INCOMPLETE_DEFERRED`: 12
- `FINAL_EXECUTABLE_AI_CASES`: 25

## Primary-technique coverage

- `DOMAIN_PARTITION`: 8
- `BOUNDARY`: 4
- `STATE_TRANSITION`: 5
- `SECURITY`: 6
- `SCHEMA`: 1
- `BUSINESS_RULE`: 1

## Executable AI-generated cases

### API01-AI-001 — Mật khẩu mạnh hợp lệ

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-002, API01-REQ-005`; oracle: `AUTHORITATIVE`
- Objective: Xác nhận lớp dữ liệu hợp lệ với email, OTP và mật khẩu đáp ứng đủ bốn nhóm ký tự.
- Expected business result: Yêu cầu reset thỏa các quy tắc được nêu và đủ điều kiện xử lý.
- Expected state: Nếu thành công, mật khẩu được đổi và OTP bị vô hiệu hóa.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-002 — OTP của email khác

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-007`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra OTP không được dùng cho email không phải email đã yêu cầu.
- Expected business result: Không chấp nhận reset vì OTP không gắn với email gửi trong yêu cầu.
- Expected state: Không đổi mật khẩu của cả hai tài khoản; OTP A không được coi là đã dùng do reset thành công.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-003 — Email chưa từng yêu cầu OTP

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-003, API01-REQ-007`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra reset không thể hoàn tất khi chưa có bước cấp OTP cho email.
- Expected business result: Không chấp nhận token chưa từng được cấp cho email.
- Expected state: Mật khẩu hiện tại không đổi.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-004 — Email chưa đăng ký

- Audit classification: `INCOMPLETE`; disposition: `SALVAGED_TO_EXECUTABLE`
- Correction summary: Narrowed user-enumeration observation to the authoritative email/token-binding and no-unauthorized-mutation invariant.
- Requirements: `API01-REQ-007`; oracle: `SECURITY_EXPECTATION`
- Objective: Verify that an unregistered-email reset attempt cannot mutate any existing account, without using response similarity as an oracle.
- Expected business result: No existing account password may change because no issued OTP is bound to the unregistered email.
- Expected state: All existing user-password and reset-token state remains unchanged.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-005 — Thiếu email

- Audit classification: `INCOMPLETE`; disposition: `SALVAGED_TO_EXECUTABLE`
- Correction summary: Removed the unspecified field-validation response oracle and retained only the email/token authorization invariant.
- Requirements: `API01-REQ-002`; oracle: `SECURITY_EXPECTATION`
- Objective: Verify that omitting email cannot authorize a password reset for any account.
- Expected business result: No password reset may complete without an account identity bound to the issued OTP.
- Expected state: All user passwords remain unchanged; no successful-use token invalidation is asserted.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-006 — Thiếu resetToken

- Audit classification: `INCOMPLETE`; disposition: `SALVAGED_TO_EXECUTABLE`
- Correction summary: Replaced requiredness observation with the authoritative issued-OTP authorization invariant.
- Requirements: `API01-REQ-002`; oracle: `AUTHORITATIVE`
- Objective: Verify that omitting resetToken cannot authorize a password reset.
- Expected business result: A reset without the issued email-bound OTP must not change the password.
- Expected state: The existing password remains unchanged; no successful token use occurs.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-007 — Thiếu newPassword

- Audit classification: `INCOMPLETE`; disposition: `SALVAGED_TO_EXECUTABLE`
- Correction summary: Removed transport validation assumptions and asserted only that a reset cannot complete without a new password value.
- Requirements: `API01-REQ-002, API01-REQ-005`; oracle: `PARTIALLY_SPECIFIED`
- Objective: Verify that a reset operation without a new password cannot complete a password change.
- Expected business result: The operation cannot establish the required new password; no successful reset is recognized.
- Expected state: The existing password remains unchanged and the request is not treated as a successful token use.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-008 — Token không phải sáu chữ số

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra lớp token sai định dạng so với yêu cầu OTP ít nhất sáu chữ số.
- Expected business result: Không chấp nhận token không phải OTP sáu chữ số đã cấp.
- Expected state: Mật khẩu không đổi.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-009 — Mật khẩu dài 7 ký tự

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-005`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra ngay dưới biên tối thiểu tám ký tự.
- Expected business result: Không chấp nhận mật khẩu dưới tám ký tự.
- Expected state: Mật khẩu cũ và trạng thái OTP không được chuyển sang trạng thái đã dùng bởi một reset thành công.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-010 — Mật khẩu đúng 8 ký tự

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-005`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra đúng biên tối thiểu với đủ chữ hoa, thường, số và ký tự đặc biệt.
- Expected business result: Mật khẩu đáp ứng quy tắc mạnh và đủ điều kiện xử lý.
- Expected state: Nếu reset thành công, mật khẩu đổi và OTP bị vô hiệu hóa.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-011 — OTP năm chữ số

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-003, API01-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra ngay dưới biên entropy sáu chữ số.
- Expected business result: Không chấp nhận token dưới sáu chữ số.
- Expected state: Mật khẩu không đổi.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-012 — OTP đúng sáu chữ số

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-003, API01-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra token tại biên sáu chữ số khi đúng email và còn hiệu lực.
- Expected business result: Token đạt độ dài yêu cầu và đủ điều kiện kiểm tra tính hợp lệ.
- Expected state: Nếu thành công, OTP bị vô hiệu hóa.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-014 — Luồng issued đến reset thành công

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-003, API01-REQ-009, API01-REQ-010`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra chuỗi yêu cầu OTP, dùng OTP hợp lệ và hoàn tất reset.
- Expected business result: Reset hợp lệ đổi mật khẩu đúng một lần.
- Expected state: OTP chuyển từ issued sang invalidated.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-015 — Dùng lại OTP sau thành công

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra replay của token đã bị vô hiệu hóa.
- Expected business result: Không chấp nhận OTP đã dùng lại.
- Expected state: Mật khẩu chỉ phản ánh reset thành công đầu tiên.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-016 — OTP đã hết hạn

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra chuyển trạng thái expired khiến OTP không còn dùng được.
- Expected business result: Không chấp nhận OTP đã hết hạn.
- Expected state: Mật khẩu không đổi; token không trở lại valid.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-018 — Reset thất bại do mật khẩu yếu

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-005, API01-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra lỗi quy tắc mật khẩu không được tính là reset thành công.
- Expected business result: Không hoàn tất reset vì mật khẩu không đạt quy tắc.
- Expected state: Mật khẩu không đổi; OTP không được tuyên bố đã dùng bởi reset thành công.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-019 — Reset thất bại do token sai

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-007`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra token sai không tạo chuyển trạng thái mật khẩu.
- Expected business result: Không chấp nhận token không khớp.
- Expected state: Mật khẩu không đổi.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-021 — Thiếu chữ hoa

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-005`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra một lớp mật khẩu không có uppercase.
- Expected business result: Không chấp nhận mật khẩu thiếu chữ hoa.
- Expected state: Mật khẩu không đổi.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-022 — Thiếu chữ thường

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-005`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra một lớp mật khẩu không có lowercase.
- Expected business result: Không chấp nhận mật khẩu thiếu chữ thường.
- Expected state: Mật khẩu không đổi.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-023 — Thiếu chữ số

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-005`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra một lớp mật khẩu không có digit.
- Expected business result: Không chấp nhận mật khẩu thiếu chữ số.
- Expected state: Mật khẩu không đổi.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-024 — Thiếu ký tự đặc biệt

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-005`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra một lớp mật khẩu không có allowed special character.
- Expected business result: Không chấp nhận mật khẩu thiếu ký tự đặc biệt.
- Expected state: Mật khẩu không đổi.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-027 — Chuỗi injection trong email

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-002, API01-REQ-007`; oracle: `SECURITY_EXPECTATION`
- Objective: Kiểm tra dữ liệu email kiểu injection không phá vỡ ranh giới truy vấn hoặc đổi tài khoản khác.
- Expected business result: Không được reset tài khoản ngoài tài khoản được xác thực bởi email/token hợp lệ.
- Expected state: Không có thay đổi trái phép trong dữ liệu người dùng.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-028 — Chuỗi injection trong resetToken

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-007, API01-REQ-009`; oracle: `SECURITY_EXPECTATION`
- Objective: Kiểm tra token kiểu injection không bỏ qua binding hoặc lifecycle.
- Expected business result: Không được vượt qua kiểm tra OTP bằng chuỗi không phải token hợp lệ.
- Expected state: Mật khẩu không đổi.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-029 — Body JSON đúng ba trường tài liệu hóa

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API01-REQ-001, API01-REQ-002`; oracle: `PARTIALLY_SPECIFIED`
- Objective: Xác nhận request shape dùng email, resetToken và newPassword theo API specification.
- Expected business result: Request phù hợp request schema tài liệu hóa; status và response schema vẫn chưa xác định.
- Expected state: State phụ thuộc business validation và kết quả quan sát.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API01-AI-035 — Mật khẩu không lưu plaintext

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: SEC-01 oracle retained; added isolated database/external persistence verification metadata.
- Requirements: `API01-REQ-008`; oracle: `SECURITY_EXPECTATION`
- Objective: Kiểm tra hậu điều kiện lưu trữ mật khẩu theo SEC-01 sau reset thành công.
- Expected business result: Giá trị persisted không được bằng plaintext newPassword.
- Expected state: OTP đã invalidated và thông tin nhạy cảm không bị ghi vào evidence.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Automation note: Requires database/external persistence verification in the isolated test environment. Do not represent this as a pure Postman response assertion if Postman cannot directly inspect persistence.

## Removed INVALID cases
- `API01-AI-020` — Mục tiêu chính là hành vi đăng nhập ở endpoint khác sau reset; API reset-password không có authoritative downstream session/login oracle.
- `API01-AI-036` — Case lặp cùng state, action và oracle one-time OTP với API01-AI-015: đều replay đúng OTP sau một reset thành công và kỳ vọng không có lần đổi mật khẩu thứ hai.
- `API01-AI-040` — API01-REQ-003 establishes a six-digit issued OTP; the raw case requires an unsupported seven-digit issuer state. SEC-07 entropy wording does not establish that FR-03 issues a seven-digit token.

## Deferred requirement gaps
- `API01-AI-013` — Concept/risk 'Thời điểm sát hạn OTP' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API01-AI-017` — Concept/risk 'Yêu cầu OTP lần hai' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API01-AI-025` — Concept/risk 'Nhiều lần đoán OTP sai' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API01-AI-026` — Concept/risk 'So sánh phản hồi email tồn tại và không tồn tại' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API01-AI-030` — Concept/risk 'Thêm trường confirmation khớp' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API01-AI-031` — Concept/risk 'Thêm trường confirmation không khớp' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API01-AI-032` — Concept/risk 'Thêm field không tài liệu hóa' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API01-AI-033` — Concept/risk 'Malformed JSON' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API01-AI-034` — Concept/risk 'Không gửi confirmation' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API01-AI-037` — Concept/risk 'Mật khẩu có khoảng trắng nhưng đủ lớp' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API01-AI-038` — Concept/risk 'Email đúng khác biệt hoa thường' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API01-AI-039` — Concept/risk 'Mismatch qua representation thay thế' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
