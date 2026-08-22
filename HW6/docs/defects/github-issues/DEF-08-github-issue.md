# [HW06][DEF-08] Quy tắc độ mạnh mật khẩu không được kiểm tra khi reset

## Mã lỗi

DEF-08

## Cụm nguyên nhân gốc

RC-01-N02

## API / Endpoint

`POST /api/reset-password`

## Yêu cầu liên quan

- `API01-REQ-005`: Mật khẩu mới phải có tối thiểu 8 ký tự, gồm chữ hoa, chữ thường, chữ số và ký tự đặc biệt được phép.
- `API01-REQ-009`: OTP reset có thời hạn và bị vô hiệu hóa sau khi sử dụng thành công.

## Môi trường kiểm thử

- Hệ thống: EShop chạy cục bộ
- Base URL: `http://localhost:3000`
- Newman: `6.2.2`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Lần chạy kiểm thử: `run-002`
- Cơ sở dữ liệu: SQLite cục bộ dành riêng cho kiểm thử

## Điều kiện tiên quyết

1. Đăng ký một người dùng dùng một lần trong môi trường cô lập cho từng phân vùng độ mạnh mật khẩu.
2. Cấp OTP mới gắn với email ngay trước mỗi test case.
3. Giữ mọi input reset hợp lệ, ngoại trừ đúng phân vùng độ mạnh mật khẩu đang được kiểm tra.

## Các bước tái hiện

1. Gửi request reset với mật khẩu ngắn hơn 8 ký tự nhưng vẫn giữ các nhóm ký tự bắt buộc còn lại.
2. Lặp lại độc lập với mật khẩu lần lượt thiếu chữ hoa, chữ thường, chữ số hoặc ký tự đặc biệt được phép.
3. Với test case theo trình tự, gửi mật khẩu yếu rồi thử lại bằng mật khẩu tuân thủ quy tắc với cùng OTP.
4. Kiểm tra trạng thái mật khẩu và token sau reset trong từng môi trường cô lập mà không ghi lại giá trị mật khẩu.

## Kết quả mong đợi

Mỗi mật khẩu vi phạm quy tắc độ mạnh đã được phê duyệt phải bị từ chối ở mức quy tắc nghiệp vụ. Trạng thái mật khẩu trước đó phải giữ nguyên và OTP vẫn dùng được sau lỗi validation. Không khẳng định HTTP status hoặc response schema cụ thể.

## Kết quả thực tế

Sáu phân vùng mật khẩu yếu độc lập hoàn tất với response thành công và làm thay đổi trạng thái người dùng tương ứng. Trong `API01-STU-002`, lần thử mật khẩu yếu cũng tiêu thụ OTP nên lần thử lại bằng mật khẩu tuân thủ quy tắc với cùng OTP thất bại. Bằng chứng ánh xạ mọi phân vùng vào cùng một lỗi gốc thiếu validation độ mạnh mật khẩu.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — primary case dùng mật khẩu dài `4` ký tự, thiếu chữ hoa, chữ số và ký tự đặc biệt nhưng nhận HTTP `200`, `Password reset successfully`.
- `NEWMAN_ASSERTION_FAILED: NO` — request/response là business-failure evidence, không phải assertion failure.
- `EXTERNAL_VERIFICATION_USED: YES` — state evidence ghi `WEAK_PLAINTEXT`, database đổi và token bị tiêu thụ mà không log mật khẩu.
- `PRIMARY_FAILURE_EVIDENCE: BOTH`.

## Mức độ ảnh hưởng

Người dùng có thể đặt mật khẩu vi phạm chính sách độ mạnh bắt buộc, làm giảm khả năng chống tấn công vào thông tin xác thực. Một lần thử mật khẩu yếu cũng có thể tiêu thụ token khôi phục và ngăn lần thử sửa đúng.

## Mức độ nghiêm trọng

**Cao (High)**

Lý do: Lỗi bypass lâu dài mọi chiều của quy tắc độ mạnh mật khẩu và làm suy yếu thông tin xác thực được lưu; bằng chứng không khẳng định việc xâm phạm tài khoản ngoài phạm vi bypass chính sách quan sát được.

## Test case chính

`API01-AI-018`

## Các test case hỗ trợ

- `API01-AI-009`
- `API01-AI-021`
- `API01-AI-022`
- `API01-AI-023`
- `API01-AI-024`
- `API01-STU-002`

## Bằng chứng thực thi

- Newman JSON: `test-results/hw06/run-002/newman.json`
- Newman HTML: `test-results/hw06/run-002/newman.html`
- Đối chiếu kết quả: `test-results/hw06/run-002/case-accounting.json`
- Xác minh bên ngoài: `test-results/hw06/run-002/external-hook-evidence.json`

## Ảnh minh chứng

- Request/response: `docs/defects/screenshots/DEF-08-A-request-response.png`.
- External/state: `docs/defects/screenshots/DEF-08-B-state-evidence.png`.

## Xác nhận của sinh viên

`CONFIRMED_PRODUCT_DEFECT`
