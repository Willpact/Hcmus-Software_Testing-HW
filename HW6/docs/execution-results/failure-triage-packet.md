# HW06 Failure Triage Packet

All entries are preliminary. `HUMAN_DECISION: PENDING`; no GitHub Issue or final product defect is created.

## API01-AI-002

- CASE_ID: `API01-AI-002`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-007`
- ORACLE: Không chấp nhận reset vì OTP không gắn với email gửi trong yêu cầu. State: Không đổi mật khẩu của cả hai tài khoản; OTP A không được coi là đã dùng do reset thành công.
- SETUP: Hai email đã đăng ký; OTP được cấp cho email A; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; email B cùng resetToken của email A
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Không chấp nhận reset vì OTP không gắn với email gửi trong yêu cầu. Không đổi mật khẩu của cả hai tài khoản; OTP A không được coi là đã dùng do reset thành công.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-007

- CASE_ID: `API01-AI-007`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-002, API01-REQ-005`
- ORACLE: The operation cannot establish the required new password; no successful reset is recognized. State: The existing password remains unchanged and the request is not treated as a successful token use.
- SETUP: OTP hợp lệ cho email; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; bỏ trường newPassword
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: The operation cannot establish the required new password; no successful reset is recognized. The existing password remains unchanged and the request is not treated as a successful token use.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-009

- CASE_ID: `API01-AI-009`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-005`
- ORACLE: Không chấp nhận mật khẩu dưới tám ký tự. State: Mật khẩu cũ và trạng thái OTP không được chuyển sang trạng thái đã dùng bởi một reset thành công.
- SETUP: OTP hợp lệ; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; mật khẩu có đủ loại ký tự nhưng dài 7
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Không chấp nhận mật khẩu dưới tám ký tự. Mật khẩu cũ và trạng thái OTP không được chuyển sang trạng thái đã dùng bởi một reset thành công.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-010

- CASE_ID: `API01-AI-010`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-005`
- ORACLE: Mật khẩu đáp ứng quy tắc mạnh và đủ điều kiện xử lý. State: Nếu reset thành công, mật khẩu đổi và OTP bị vô hiệu hóa.
- SETUP: OTP hợp lệ; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; mật khẩu dài đúng 8 và đủ bốn nhóm
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Mật khẩu đáp ứng quy tắc mạnh và đủ điều kiện xử lý. Nếu reset thành công, mật khẩu đổi và OTP bị vô hiệu hóa.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-012

- CASE_ID: `API01-AI-012`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-003, API01-REQ-009`
- ORACLE: Token đạt độ dài yêu cầu và đủ điều kiện kiểm tra tính hợp lệ. State: Nếu thành công, OTP bị vô hiệu hóa.
- SETUP: Có OTP sáu chữ số hợp lệ; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; resetToken sáu chữ số và mật khẩu mạnh
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Token đạt độ dài yêu cầu và đủ điều kiện kiểm tra tính hợp lệ. Nếu thành công, OTP bị vô hiệu hóa.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-014

- CASE_ID: `API01-AI-014`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-003, API01-REQ-009, API01-REQ-010`
- ORACLE: Reset hợp lệ đổi mật khẩu đúng một lần. State: OTP chuyển từ issued sang invalidated.
- SETUP: Email đã đăng ký; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; forgot-password trước, reset-password sau
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Reset hợp lệ đổi mật khẩu đúng một lần. OTP chuyển từ issued sang invalidated.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-016

- CASE_ID: `API01-AI-016`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-009`
- ORACLE: Không chấp nhận OTP đã hết hạn. State: Mật khẩu không đổi; token không trở lại valid.
- SETUP: Có OTP vượt quá thời hạn cấu hình thực tế; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; email và OTP hết hạn, mật khẩu mạnh
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Không chấp nhận OTP đã hết hạn. Mật khẩu không đổi; token không trở lại valid.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-018

- CASE_ID: `API01-AI-018`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-005, API01-REQ-009`
- ORACLE: Không hoàn tất reset vì mật khẩu không đạt quy tắc. State: Mật khẩu không đổi; OTP không được tuyên bố đã dùng bởi reset thành công.
- SETUP: OTP hợp lệ; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; đúng email/token nhưng mật khẩu yếu
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Không hoàn tất reset vì mật khẩu không đạt quy tắc. Mật khẩu không đổi; OTP không được tuyên bố đã dùng bởi reset thành công.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-019

- CASE_ID: `API01-AI-019`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-007`
- ORACLE: Không chấp nhận token không khớp. State: Mật khẩu không đổi.
- SETUP: Email đã có OTP hợp lệ; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; gửi token khác sáu chữ số
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Không chấp nhận token không khớp. Mật khẩu không đổi.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-021

- CASE_ID: `API01-AI-021`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-005`
- ORACLE: Không chấp nhận mật khẩu thiếu chữ hoa. State: Mật khẩu không đổi.
- SETUP: OTP hợp lệ; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; newPassword đủ dài nhưng không có chữ hoa
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Không chấp nhận mật khẩu thiếu chữ hoa. Mật khẩu không đổi.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-022

- CASE_ID: `API01-AI-022`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-005`
- ORACLE: Không chấp nhận mật khẩu thiếu chữ thường. State: Mật khẩu không đổi.
- SETUP: OTP hợp lệ; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; newPassword đủ dài nhưng không có chữ thường
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Không chấp nhận mật khẩu thiếu chữ thường. Mật khẩu không đổi.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-023

- CASE_ID: `API01-AI-023`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-005`
- ORACLE: Không chấp nhận mật khẩu thiếu chữ số. State: Mật khẩu không đổi.
- SETUP: OTP hợp lệ; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; newPassword đủ dài nhưng không có chữ số
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Không chấp nhận mật khẩu thiếu chữ số. Mật khẩu không đổi.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-024

- CASE_ID: `API01-AI-024`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-005`
- ORACLE: Không chấp nhận mật khẩu thiếu ký tự đặc biệt. State: Mật khẩu không đổi.
- SETUP: OTP hợp lệ; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; newPassword đủ dài nhưng chỉ chữ và số
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Không chấp nhận mật khẩu thiếu ký tự đặc biệt. Mật khẩu không đổi.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-027

- CASE_ID: `API01-AI-027`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-002, API01-REQ-007`
- ORACLE: Không được reset tài khoản ngoài tài khoản được xác thực bởi email/token hợp lệ. State: Không có thay đổi trái phép trong dữ liệu người dùng.
- SETUP: Có dữ liệu baseline để hậu kiểm; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; email chứa SQL metacharacters, token bất kỳ
- OBSERVED RESULT: HTTP `400`; case result `POSTMAN_PASS_EXTERNAL_PENDING`.
- EXPECTED INVARIANT: Không được reset tài khoản ngoài tài khoản được xác thực bởi email/token hợp lệ. Không có thay đổi trái phép trong dữ liệu người dùng.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `PENDING`
- PRELIMINARY CLASSIFICATION: `EXTERNAL_VERIFICATION_PENDING`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-029

- CASE_ID: `API01-AI-029`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-001, API01-REQ-002`
- ORACLE: Request phù hợp request schema tài liệu hóa; status và response schema vẫn chưa xác định. State: State phụ thuộc business validation và kết quả quan sát.
- SETUP: OTP hợp lệ; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; JSON object có đúng ba field đã tài liệu hóa
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Request phù hợp request schema tài liệu hóa; status và response schema vẫn chưa xác định. State phụ thuộc business validation và kết quả quan sát.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-AI-035

- CASE_ID: `API01-AI-035`
- API: `API-01`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API01-REQ-008`
- ORACLE: Giá trị persisted không được bằng plaintext newPassword. State: OTP đã invalidated và thông tin nhạy cảm không bị ghi vào evidence.
- SETUP: Có quyền kiểm tra dữ liệu trong môi trường test cô lập; Reset hợp lệ đã thành công; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; hậu kiểm bản ghi user, không log secret
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Giá trị persisted không được bằng plaintext newPassword. OTP đã invalidated và thông tin nhạy cảm không bị ghi vào evidence.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `BLOCKED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-STU-001

- CASE_ID: `API01-STU-001`
- API: `API-01`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API01-REQ-007, API01-REQ-009`
- ORACLE: Step 1 must not reset either account; step 2 may complete the authoritative owner-bound reset. State: After step 1 OTP A remains available for rightful use; after step 2 only A changes and OTP A is invalidated.
- SETUP: Users A and B are registered; OTP A is issued for email A; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; approved request sequence
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Step 1 must not reset either account; step 2 may complete the authoritative owner-bound reset. After step 1 OTP A remains available for rightful use; after step 2 only A changes and OTP A is invalidated.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-STU-002

- CASE_ID: `API01-STU-002`
- API: `API-01`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API01-REQ-005, API01-REQ-009`
- ORACLE: The weak attempt must not complete reset; the strong retry may complete reset with the same still-valid OTP. State: Password remains old after step 1; after step 2 it changes and the OTP is invalidated.
- SETUP: A valid email-bound OTP is issued; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; approved request sequence
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: The weak attempt must not complete reset; the strong retry may complete reset with the same still-valid OTP. Password remains old after step 1; after step 2 it changes and the OTP is invalidated.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-STU-003

- CASE_ID: `API01-STU-003`
- API: `API-01`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API01-REQ-007, API01-REQ-009`
- ORACLE: The wrong-token request must not reset the password; the issued token remains eligible for its rightful request. State: After step 1 password and issued-token state remain unchanged; after step 2 password changes and issued token is invalidated.
- SETUP: A valid OTP is issued for email A; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; approved request sequence
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: The wrong-token request must not reset the password; the issued token remains eligible for its rightful request. After step 1 password and issued-token state remain unchanged; after step 2 password changes and issued token is invalidated.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-STU-004

- CASE_ID: `API01-STU-004`
- API: `API-01`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API01-REQ-007, API01-REQ-009`
- ORACLE: Each user can reset only with their own token; success for A must not revoke B's independent token. State: A password changes and OTP A invalidates first; B remains unchanged/valid until its own successful reset, then OTP B invalidates.
- SETUP: Users A and B each have a valid issued OTP; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; approved request sequence
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: Each user can reset only with their own token; success for A must not revoke B's independent token. A password changes and OTP A invalidates first; B remains unchanged/valid until its own successful reset, then OTP B invalidates.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API01-STU-005

- CASE_ID: `API01-STU-005`
- API: `API-01`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API01-REQ-007, API01-REQ-009`
- ORACLE: A replay must not create a second reset; B's independent legitimate reset must remain possible. State: A remains at its first reset state; B changes only on its own request and OTP B then invalidates.
- SETUP: A and B have valid OTPs; A has completed a successful reset and OTP A is invalidated; Use POST /api/forgot-password when an issued OTP is required
- REQUEST SUMMARY: `POST /api/reset-password`; approved request sequence
- OBSERVED RESULT: HTTP `400`; case result `BLOCKED`.
- EXPECTED INVARIANT: A replay must not create a second reset; B's independent legitimate reset must remain possible. A remains at its first reset state; B changes only on its own request and OTP B then invalidates.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-001

- CASE_ID: `API02-AI-001`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-002, API02-REQ-005, API02-REQ-006, API02-REQ-007`
- ORACLE: Checkout đủ điều kiện; tổng có thẩm quyền là tổng backend tính từ cart. State: Nếu thành công, cart của user được xóa.
- SETUP: User đã đăng nhập; Cart của user có hàng; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; Bearer hợp lệ, body có total_amount và shipping_address
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Checkout đủ điều kiện; tổng có thẩm quyền là tổng backend tính từ cart. Nếu thành công, cart của user được xóa.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-002

- CASE_ID: `API02-AI-002`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-005, API02-REQ-006`
- ORACLE: Kết quả checkout không được dùng 1 làm tổng có thẩm quyền; backend phải tính từ cart. State: Nếu thành công, side effect cart tuân API02-REQ-007.
- SETUP: JWT hợp lệ; Cart có tổng đã biết; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; total_amount nhỏ hơn tổng cart
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Kết quả checkout không được dùng 1 làm tổng có thẩm quyền; backend phải tính từ cart. Nếu thành công, side effect cart tuân API02-REQ-007.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-003

- CASE_ID: `API02-AI-003`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-005, API02-REQ-006`
- ORACLE: Tổng có thẩm quyền vẫn phải do backend tính từ cart. State: Nếu thành công, cart được xóa.
- SETUP: JWT hợp lệ; Cart có tổng đã biết; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; total_amount lớn hơn tổng cart
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Tổng có thẩm quyền vẫn phải do backend tính từ cart. Nếu thành công, cart được xóa.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-004

- CASE_ID: `API02-AI-004`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-005, API02-REQ-006`
- ORACLE: Backend không được nhận zero làm tổng checkout có thẩm quyền. State: Nếu thành công, cart được xóa.
- SETUP: JWT hợp lệ; Cart có tổng dương; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; total_amount=0
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Backend không được nhận zero làm tổng checkout có thẩm quyền. Nếu thành công, cart được xóa.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-005

- CASE_ID: `API02-AI-005`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-005, API02-REQ-006`
- ORACLE: Backend phải bỏ quyền quyết định khỏi giá trị client và tính từ cart. State: Nếu thành công, cart được xóa.
- SETUP: JWT hợp lệ; Cart có tổng dương; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; total_amount=-1
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Backend phải bỏ quyền quyết định khỏi giá trị client và tính từ cart. Nếu thành công, cart được xóa.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-006

- CASE_ID: `API02-AI-006`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-003, API02-REQ-006`
- ORACLE: Acceptable outcomes are rejection without successful-checkout side effects, or successful checkout using the backend cart-derived total; the client string never becomes authoritative. State: If checkout succeeds the authenticated user cart is cleared; otherwise no success-side-effect claim is made.
- SETUP: JWT hợp lệ; Cart có tổng đã biết; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; total_amount là chuỗi số
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Acceptable outcomes are rejection without successful-checkout side effects, or successful checkout using the backend cart-derived total; the client string never becomes authoritative. If checkout succeeds the authenticated user cart is cleared; otherwise no success-side-effect claim is made.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-007

- CASE_ID: `API02-AI-007`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-003, API02-REQ-006`
- ORACLE: Acceptable outcomes are rejection without successful-checkout side effects, or successful checkout using the backend cart-derived total. State: If checkout succeeds the authenticated user cart is cleared; otherwise no success-side-effect claim is made.
- SETUP: JWT hợp lệ; Cart có tổng đã biết; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; bỏ total_amount
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Acceptable outcomes are rejection without successful-checkout side effects, or successful checkout using the backend cart-derived total. If checkout succeeds the authenticated user cart is cleared; otherwise no success-side-effect claim is made.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-009

- CASE_ID: `API02-AI-009`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-005, API02-REQ-006`
- ORACLE: Backend tính tổng từ cart hiện tại. State: Nếu thành công, cart chuyển sang rỗng.
- SETUP: JWT hợp lệ; Cart có đúng một dòng; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; body hợp lệ
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Backend tính tổng từ cart hiện tại. Nếu thành công, cart chuyển sang rỗng.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-010

- CASE_ID: `API02-AI-010`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-005, API02-REQ-006`
- ORACLE: Tổng có thẩm quyền phản ánh cart đầy đủ theo FR-08, không phải client total. State: Nếu thành công, toàn bộ cart được xóa.
- SETUP: JWT hợp lệ; Cart có nhiều dòng; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; client total cố tình bằng riêng dòng đầu
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Tổng có thẩm quyền phản ánh cart đầy đủ theo FR-08, không phải client total. Nếu thành công, toàn bộ cart được xóa.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-014

- CASE_ID: `API02-AI-014`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-005, API02-REQ-007`
- ORACLE: Checkout thành công sử dụng tổng cart. State: Cart của authenticated user trở thành rỗng.
- SETUP: JWT hợp lệ; Cart có hàng và snapshot trước chạy; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; body hợp lệ
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Checkout thành công sử dụng tổng cart. Cart của authenticated user trở thành rỗng.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-016

- CASE_ID: `API02-AI-016`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-005, API02-REQ-006`
- ORACLE: Backend dùng cart hiện tại để tính tổng. State: Nếu thành công, cart hiện tại được xóa.
- SETUP: JWT hợp lệ; Client đã xem cart rồi cart thay đổi; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; gửi total_amount cũ
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Backend dùng cart hiện tại để tính tổng. Nếu thành công, cart hiện tại được xóa.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-017

- CASE_ID: `API02-AI-017`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-004, API02-REQ-005`
- ORACLE: Tổng phải được tính từ cart gắn với authenticated user A. State: Nếu thành công, chỉ cart A được xóa; cart B không bị tác động.
- SETUP: JWT A và B hợp lệ; Mỗi user có cart khác nhau; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; checkout bằng JWT A
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Tổng phải được tính từ cart gắn với authenticated user A. Nếu thành công, chỉ cart A được xóa; cart B không bị tác động.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-018

- CASE_ID: `API02-AI-018`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-002, API02-REQ-004`
- ORACLE: Không cho user chưa xác thực checkout. State: Cart baseline không bị clear bởi checkout thành công.
- SETUP: Cart baseline tồn tại; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; không gửi Authorization
- OBSERVED RESULT: HTTP `200`; case result `BLOCKED`.
- EXPECTED INVARIANT: Không cho user chưa xác thực checkout. Cart baseline không bị clear bởi checkout thành công.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-022

- CASE_ID: `API02-AI-022`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-002, API02-REQ-010`
- ORACLE: Không coi header này là valid bearer JWT. State: Không clear cart do checkout thành công.
- SETUP: Cart test tồn tại; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; Authorization dùng Basic
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Không coi header này là valid bearer JWT. Không clear cart do checkout thành công.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-024

- CASE_ID: `API02-AI-024`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-002, API02-REQ-010`
- ORACLE: Không cho checkout với token hết hạn. State: Cart không bị clear bởi checkout thành công.
- SETUP: Có JWT expired trong môi trường test; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; Authorization Bearer expired
- OBSERVED RESULT: HTTP `401`; case result `BLOCKED`.
- EXPECTED INVARIANT: Không cho checkout với token hết hạn. Cart không bị clear bởi checkout thành công.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-025

- CASE_ID: `API02-AI-025`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-005, API02-REQ-006`
- ORACLE: Client input không được dùng làm tổng có thẩm quyền; truy vấn phải giữ ranh giới dữ liệu. State: Không có thay đổi dữ liệu ngoài checkout được phép.
- SETUP: JWT hợp lệ; Cart có tổng biết trước; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; total_amount là chuỗi SQL-like
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Client input không được dùng làm tổng có thẩm quyền; truy vấn phải giữ ranh giới dữ liệu. Không có thay đổi dữ liệu ngoài checkout được phép.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-026

- CASE_ID: `API02-AI-026`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-003, API02-REQ-011`
- ORACLE: Không được thực thi nội dung input như lệnh hoặc phá dữ liệu ngoài phạm vi. State: Nếu checkout thành công, cart clear; dữ liệu khác còn nguyên.
- SETUP: JWT hợp lệ; Cart có hàng; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; shipping_address chứa metacharacters
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Không được thực thi nội dung input như lệnh hoặc phá dữ liệu ngoài phạm vi. Nếu checkout thành công, cart clear; dữ liệu khác còn nguyên.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-029

- CASE_ID: `API02-AI-029`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-001, API02-REQ-002, API02-REQ-003`
- ORACLE: Request phù hợp contract đầu vào; response status/schema chưa được quy định. State: Nếu thành công, cart clear.
- SETUP: JWT hợp lệ; Cart có hàng; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; JSON đúng hai field
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Request phù hợp contract đầu vào; response status/schema chưa được quy định. Nếu thành công, cart clear.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-034

- CASE_ID: `API02-AI-034`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-005, API02-REQ-006`
- ORACLE: Cần evidence backend-derived total; equality alone không chứng minh client được tin. State: Nếu thành công, cart clear.
- SETUP: JWT hợp lệ; Cart có tổng biết trước; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; client total tình cờ bằng cart total
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Cần evidence backend-derived total; equality alone không chứng minh client được tin. Nếu thành công, cart clear.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-035

- CASE_ID: `API02-AI-035`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-005, API02-REQ-006`
- ORACLE: Backend dùng total tính từ cart. State: Nếu thành công, cart clear.
- SETUP: JWT hợp lệ; Cart total biết trước; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; client total lệch một phần nhỏ
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Backend dùng total tính từ cart. Nếu thành công, cart clear.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-036

- CASE_ID: `API02-AI-036`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-007`
- ORACLE: Checkout thành công của A không xác lập quy tắc cho B. State: Cart A rỗng; cart B giữ nguyên.
- SETUP: User A và B đều có cart; Checkout A thành công; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; hậu kiểm cả hai cart
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Checkout thành công của A không xác lập quy tắc cho B. Cart A rỗng; cart B giữ nguyên.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-AI-037

- CASE_ID: `API02-AI-037`
- API: `API-02`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API02-REQ-005, API02-REQ-006, API02-REQ-008`
- ORACLE: Backend total phản ánh cart hiện tại theo FR-08; không biến quy tắc merge FR-07 thành checkout oracle. State: Nếu thành công, cart được xóa.
- SETUP: JWT hợp lệ; Cart có một product quantity lớn hơn một; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; client total chỉ tính quantity một
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Backend total phản ánh cart hiện tại theo FR-08; không biến quy tắc merge FR-07 thành checkout oracle. Nếu thành công, cart được xóa.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-STU-001

- CASE_ID: `API02-STU-001`
- API: `API-02`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API02-REQ-002, API02-REQ-004, API02-REQ-005, API02-REQ-006, API02-REQ-007, API02-REQ-010`
- ORACLE: Step 1 cannot be an authenticated checkout; step 2 uses the backend cart-derived total. State: Cart remains populated after step 1 and is cleared only after step 2 succeeds.
- SETUP: User A has a populated cart; Prepare invalid and valid JWT fixtures; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; approved request sequence
- OBSERVED RESULT: HTTP `403`; case result `BLOCKED`.
- EXPECTED INVARIANT: Step 1 cannot be an authenticated checkout; step 2 uses the backend cart-derived total. Cart remains populated after step 1 and is cleared only after step 2 succeeds.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `BLOCKED`
- PRELIMINARY CLASSIFICATION: `TEST_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-STU-002

- CASE_ID: `API02-STU-002`
- API: `API-02`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API02-REQ-004, API02-REQ-005, API02-REQ-006, API02-REQ-007`
- ORACLE: Checkout must use authenticated user A and derive total from cart A, not payload identity or cart B's client-matched value. State: On success only cart A clears; cart B remains unchanged.
- SETUP: Users A and B have different populated carts; JWT A is valid; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; approved request sequence
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Checkout must use authenticated user A and derive total from cart A, not payload identity or cart B's client-matched value. On success only cart A clears; cart B remains unchanged.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-STU-003

- CASE_ID: `API02-STU-003`
- API: `API-02`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API02-REQ-005, API02-REQ-006, API02-REQ-007, API02-REQ-011`
- ORACLE: No input string may execute as a command or become the authoritative total; any successful checkout uses the cart-derived total. State: Unrelated database state remains intact; if checkout succeeds the authenticated cart clears.
- SETUP: Authenticated user has a populated cart; Isolated database state can be inspected; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; approved request sequence
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: No input string may execute as a command or become the authoritative total; any successful checkout uses the cart-derived total. Unrelated database state remains intact; if checkout succeeds the authenticated cart clears.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-STU-005

- CASE_ID: `API02-STU-005`
- API: `API-02`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API02-REQ-004, API02-REQ-005, API02-REQ-006, API02-REQ-007`
- ORACLE: Each checkout must derive total from the authenticated user's current cart, never the swapped client value. State: After A succeeds only cart A clears; after B succeeds cart B clears; each order remains user-scoped.
- SETUP: Users A and B have different populated carts; Both JWTs valid; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; approved request sequence
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Each checkout must derive total from the authenticated user's current cart, never the swapped client value. After A succeeds only cart A clears; after B succeeds cart B clears; each order remains user-scoped.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API02-STU-006

- CASE_ID: `API02-STU-006`
- API: `API-02`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API02-REQ-004, API02-REQ-005, API02-REQ-006, API02-REQ-007`
- ORACLE: On confirmed success, checkout derives the amount from current cart A, not the stale client value, spoofed user ID, or cart B. State: Only cart A is cleared after confirmed success; cart B remains unchanged.
- SETUP: Users A and B have different populated carts; JWT A is valid; Cart A changes from total T-old to T-current immediately before checkout; Cart B total equals T-old and differs from T-current; Use documented login/cart helpers with isolated user carts
- REQUEST SUMMARY: `POST /api/checkout`; approved request sequence
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: On confirmed success, checkout derives the amount from current cart A, not the stale client value, spoofed user ID, or cart B. Only cart A is cleared after confirmed success; cart B remains unchanged.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-AI-009

- CASE_ID: `API03-AI-009`
- API: `API-03`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API03-REQ-007`
- ORACLE: Row lỗi vì price phải positive. State: Toàn batch rollback.
- SETUP: Admin JWT hợp lệ; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; price=0, name hợp lệ
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Row lỗi vì price phải positive. Toàn batch rollback.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-AI-010

- CASE_ID: `API03-AI-010`
- API: `API-03`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API03-REQ-007`
- ORACLE: Row lỗi vì price không positive. State: Toàn batch rollback.
- SETUP: Admin JWT hợp lệ; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; price=-1, name hợp lệ
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Row lỗi vì price không positive. Toàn batch rollback.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-AI-016

- CASE_ID: `API03-AI-016`
- API: `API-03`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API03-REQ-009`
- ORACLE: Không có row error nên batch đủ điều kiện commit. State: Post-state có toàn bộ item mới, không phải một phần.
- SETUP: Admin JWT hợp lệ; Snapshot products trước import; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; nhiều item đều valid
- OBSERVED RESULT: HTTP `200`; case result `BLOCKED`.
- EXPECTED INVARIANT: Không có row error nên batch đủ điều kiện commit. Post-state có toàn bộ item mới, không phải một phần.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-AI-017

- CASE_ID: `API03-AI-017`
- API: `API-03`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API03-REQ-007, API03-REQ-009`
- ORACLE: Bất kỳ row lỗi làm toàn import thất bại. State: Không item nào của batch được persist.
- SETUP: Admin JWT hợp lệ; Snapshot trước import; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; row 1 name empty, rows sau valid
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Bất kỳ row lỗi làm toàn import thất bại. Không item nào của batch được persist.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-AI-018

- CASE_ID: `API03-AI-018`
- API: `API-03`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API03-REQ-007, API03-REQ-009`
- ORACLE: Lỗi giữa batch làm rollback toàn bộ. State: Không giữ các row valid đứng trước hoặc sau.
- SETUP: Admin JWT hợp lệ; Snapshot trước import; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; valid, invalid price zero, valid
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Lỗi giữa batch làm rollback toàn bộ. Không giữ các row valid đứng trước hoặc sau.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-AI-019

- CASE_ID: `API03-AI-019`
- API: `API-03`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API03-REQ-007, API03-REQ-009`
- ORACLE: Lỗi cuối vẫn làm toàn batch thất bại. State: Không item nào của batch được persist.
- SETUP: Admin JWT hợp lệ; Snapshot trước import; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; các row đầu valid, row cuối name empty
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Lỗi cuối vẫn làm toàn batch thất bại. Không item nào của batch được persist.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-AI-020

- CASE_ID: `API03-AI-020`
- API: `API-03`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API03-REQ-007, API03-REQ-009`
- ORACLE: Batch không được partial commit; report cần counts/reasons. State: Products state không đổi bởi batch.
- SETUP: Admin JWT hợp lệ; Snapshot trước import; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; một row empty name, một row negative price
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Batch không được partial commit; report cần counts/reasons. Products state không đổi bởi batch.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-AI-021

- CASE_ID: `API03-AI-021`
- API: `API-03`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API03-REQ-009`
- ORACLE: Batch retry được đánh giá độc lập và nếu hợp lệ có thể commit toàn bộ. State: Chỉ dữ liệu từ lần retry hợp lệ xuất hiện.
- SETUP: Một batch invalid đã rollback; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; gửi batch mới với tất cả lỗi đã sửa
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Batch retry được đánh giá độc lập và nếu hợp lệ có thể commit toàn bộ. Chỉ dữ liệu từ lần retry hợp lệ xuất hiện.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-AI-022

- CASE_ID: `API03-AI-022`
- API: `API-03`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API03-REQ-010`
- ORACLE: Report thể hiện số thành công/lỗi và lý do ở mức semantic; exact schema unspecified. State: Atomic rollback vẫn được hậu kiểm độc lập.
- SETUP: Admin JWT hợp lệ; Batch có lỗi xác định; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; mixed invalid batch
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Report thể hiện số thành công/lỗi và lý do ở mức semantic; exact schema unspecified. Atomic rollback vẫn được hậu kiểm độc lập.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-AI-025

- CASE_ID: `API03-AI-025`
- API: `API-03`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API03-REQ-002, API03-REQ-011`
- ORACLE: Không cho import với token hết hạn. State: Products state không đổi.
- SETUP: Có expired fixture; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; Bearer expired và valid products
- OBSERVED RESULT: HTTP `401`; case result `BLOCKED`.
- EXPECTED INVARIANT: Không cho import với token hết hạn. Products state không đổi.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DATA_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-AI-026

- CASE_ID: `API03-AI-026`
- API: `API-03`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API03-REQ-002, API03-REQ-003`
- ORACLE: Không cho non-admin import. State: Products state không đổi.
- SETUP: Valid JWT role user; Snapshot products; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; Bearer user token, valid products
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Không cho non-admin import. Products state không đổi.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-AI-028

- CASE_ID: `API03-AI-028`
- API: `API-03`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API03-REQ-003`
- ORACLE: Không được nâng quyền từ payload; role phải lấy từ token đã verify. State: Products state không đổi.
- SETUP: JWT role user; Snapshot products; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; body thêm role=admin
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Không được nâng quyền từ payload; role phải lấy từ token đã verify. Products state không đổi.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-AI-038

- CASE_ID: `API03-AI-038`
- API: `API-03`
- SOURCE: `AI_CORRECTED`
- REQUIREMENT: `API03-REQ-009, API03-REQ-010`
- ORACLE: Report phải nêu counts/reasons và batch phải rollback toàn bộ do có lỗi. State: Không item mới nào tồn tại dù report có success-row count trung gian.
- SETUP: Admin JWT hợp lệ; Batch mixed validity; Snapshot trước; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; một valid và một invalid item
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Report phải nêu counts/reasons và batch phải rollback toàn bộ do có lỗi. Không item mới nào tồn tại dù report có success-row count trung gian.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-STU-001

- CASE_ID: `API03-STU-001`
- API: `API-03`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API03-REQ-002, API03-REQ-003, API03-REQ-009`
- ORACLE: Non-admin is not authorized to import regardless of row composition. State: No row from the batch is persisted.
- SETUP: Valid JWT with role=user; Products snapshot exists; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; approved request sequence
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Non-admin is not authorized to import regardless of row composition. No row from the batch is persisted.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-STU-002

- CASE_ID: `API03-STU-002`
- API: `API-03`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API03-REQ-002, API03-REQ-003, API03-REQ-009`
- ORACLE: Role must come from the verified token; payload role and row errors cannot authorize import. State: No product is persisted and no partial validation-side effect is allowed.
- SETUP: Valid JWT role=user; Products snapshot exists; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; approved request sequence
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: Role must come from the verified token; payload role and row errors cannot authorize import. No product is persisted and no partial validation-side effect is allowed.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-STU-003

- CASE_ID: `API03-STU-003`
- API: `API-03`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API03-REQ-007, API03-REQ-009, API03-REQ-011`
- ORACLE: The injection-like name must not execute as a command; price=0 is invalid and triggers all-or-nothing rollback. State: Neither row is persisted and unrelated database state remains intact.
- SETUP: Admin JWT valid; Products/database snapshot exists; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; approved request sequence
- OBSERVED RESULT: HTTP `200`; case result `FAIL`.
- EXPECTED INVARIANT: The injection-like name must not execute as a command; price=0 is invalid and triggers all-or-nothing rollback. Neither row is persisted and unrelated database state remains intact.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `FAIL`
- PRELIMINARY CLASSIFICATION: `PRODUCT_DEFECT_CANDIDATE`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-STU-004

- CASE_ID: `API03-STU-004`
- API: `API-03`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API03-REQ-007, API03-REQ-009`
- ORACLE: Batch A commits fully; batch B fails atomically because of its invalid row. State: Products from A remain; no product from B is persisted.
- SETUP: Admin JWT valid; Snapshot before both imports; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; approved request sequence
- OBSERVED RESULT: HTTP `200`; case result `BLOCKED`.
- EXPECTED INVARIANT: Batch A commits fully; batch B fails atomically because of its invalid row. Products from A remain; no product from B is persisted.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING

## API03-STU-006

- CASE_ID: `API03-STU-006`
- API: `API-03`
- SOURCE: `STUDENT_ADDED`
- REQUIREMENT: `API03-REQ-002, API03-REQ-003, API03-REQ-007, API03-REQ-009`
- ORACLE: Batch A commits under the admin request; the non-admin request cannot import batch B regardless of its mixed row validity. State: Every product from batch A remains; no product from batch B is persisted; pre-existing unrelated products remain unchanged.
- SETUP: Admin and non-admin JWT fixtures exist; Products snapshot exists; Batch A and batch B use distinct product identifiers; Use documented login and GET /api/products baseline helper
- REQUEST SUMMARY: `POST /api/admin/import-products`; approved request sequence
- OBSERVED RESULT: HTTP `200`; case result `BLOCKED`.
- EXPECTED INVARIANT: Batch A commits under the admin request; the non-admin request cannot import batch B regardless of its mixed row validity. Every product from batch A remains; no product from batch B is persisted; pre-existing unrelated products remain unchanged.
- POSTMAN ASSERTION: Runtime `studentId` and response capture passed; the generated script does not independently prove the full business/state oracle.
- EXTERNAL VERIFICATION: `NOT_PLANNED`
- PRELIMINARY CLASSIFICATION: `TEST_DEFECT`
- EVIDENCE PATHS: `test-results/hw06/run-001/newman.json`; `test-results/hw06/run-001/case-accounting.json`; `test-results/hw06/run-001/external-verification-results.json`

HUMAN_DECISION:
PENDING
