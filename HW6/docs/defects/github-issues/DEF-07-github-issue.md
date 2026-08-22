# [HW06][DEF-07] Reset mật khẩu vẫn thành công khi thiếu mật khẩu mới

## Mã lỗi

DEF-07

## Cụm nguyên nhân gốc

RC-01-N01

## API / Endpoint

`POST /api/reset-password`

## Yêu cầu liên quan

- `API01-REQ-002`: Request body JSON được tài liệu hóa gồm `email`, `resetToken` và `newPassword`; nguồn không quy định chính xác transport khi field bắt buộc bị thiếu.
- `API01-REQ-004`: Bước reset thứ hai nhận OTP, mật khẩu mới và xác nhận mật khẩu.
- `API01-REQ-005`: Mật khẩu mới phải tuân theo quy tắc mật khẩu mạnh đã được phê duyệt.

## Môi trường kiểm thử

- Hệ thống: EShop chạy cục bộ
- Base URL: `http://localhost:3000`
- Newman: `6.2.2`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Lần chạy kiểm thử: `run-002`
- Cơ sở dữ liệu: SQLite cục bộ dành riêng cho kiểm thử

## Điều kiện tiên quyết

1. Đăng ký một người dùng dùng một lần dành riêng cho test case.
2. Cấp OTP reset mới gắn với email ngay trước thao tác của test case.
3. Xác nhận việc thiết lập người dùng và OTP trong môi trường cô lập đã thành công.

## Các bước tái hiện

1. Gửi `POST /api/reset-password` cho người dùng dùng một lần bằng OTP vừa được cấp.
2. Lược bỏ field `newPassword`.
3. Quan sát xem thao tác có được báo thành công hay không.
4. Kiểm tra trạng thái người dùng và token sau reset trong cơ sở dữ liệu cô lập.

## Kết quả mong đợi

Reset thiếu input mật khẩu mới không được coi là thành công. Trạng thái mật khẩu trước đó phải giữ nguyên và OTP không bị tiêu thụ như một lần sử dụng thành công. Không khẳng định HTTP status hoặc response schema cụ thể.

## Kết quả thực tế

SUT trả về response thành công, thay đổi trạng thái trong cơ sở dữ liệu cô lập và vô hiệu hóa OTP mới dù `newPassword` bị thiếu. Một lần thử lại hợp lệ sau đó không thể tái sử dụng token đã bị tiêu thụ.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — body chỉ có `email` và `resetToken`, nhưng response là HTTP `200`, `Password reset successfully`.
- `NEWMAN_ASSERTION_FAILED: NO` — request/response là business-failure evidence, không phải assertion failure.
- `EXTERNAL_VERIFICATION_USED: YES` — database đổi, token bị tiêu thụ và lần thử lại hợp lệ nhận HTTP `400`.
- `PRIMARY_FAILURE_EVIDENCE: BOTH`.

## Mức độ ảnh hưởng

Endpoint có thể đưa tài khoản vào trạng thái thông tin xác thực không hợp lệ hoặc không sử dụng được, đồng thời tiêu thụ token khôi phục hợp lệ mà không thiết lập mật khẩu mới bắt buộc.

## Mức độ nghiêm trọng

**Trung bình (Medium)**

Lý do: Lỗi làm hỏng tính toàn vẹn của trạng thái khôi phục tài khoản và có thể khiến người dùng không đăng nhập được; bằng chứng không chứng minh việc chiếm đoạt tài khoản trái phép.

## Test case chính

`API01-AI-007`

## Các test case hỗ trợ

- Không có.

## Bằng chứng thực thi

- Newman JSON: `test-results/hw06/run-002/newman.json`
- Newman HTML: `test-results/hw06/run-002/newman.html`
- Đối chiếu kết quả: `test-results/hw06/run-002/case-accounting.json`
- Xác minh bên ngoài: `test-results/hw06/run-002/external-hook-evidence.json`

## Ảnh minh chứng

- Request/response: `docs/defects/screenshots/DEF-07-A-request-response.png`.
- External/state: `docs/defects/screenshots/DEF-07-B-state-evidence.png`.

## Xác nhận của sinh viên

`CONFIRMED_PRODUCT_DEFECT`
