# DEF-07 — Reset mật khẩu vẫn thành công khi thiếu mật khẩu mới

- Mã lỗi: `DEF-07`
- Tên kỹ thuật: `MISSING_NEW_PASSWORD_ACCEPTED_AS_SUCCESSFUL_RESET`
- API: `POST /api/reset-password`
- Yêu cầu liên quan: `API01-REQ-002`, `API01-REQ-004`, `API01-REQ-005`
- Cụm nguyên nhân gốc: `RC-01-N01`
- Test case chính: `API01-AI-007`
- Các test case hỗ trợ: `[]`
- Lần chạy kiểm thử: `run-002`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Xác nhận của sinh viên: `CONFIRMED_PRODUCT_DEFECT`

## Yêu cầu liên quan

Request body reset được tài liệu hóa gồm `email`, `resetToken` và `newPassword`; bước reset nhận OTP và mật khẩu mới, đồng thời mật khẩu mới phải tuân theo quy tắc mật khẩu mạnh đã được phê duyệt. Nguồn có thẩm quyền không quy định chính xác HTTP status hoặc response schema khi thiếu field, nên oracle là bất biến nghiệp vụ/trạng thái: thao tác không có giá trị mật khẩu mới không được coi là reset thành công.

## Môi trường kiểm thử

Backend EShop Node/Express chạy cục bộ tại `http://localhost:3000`, cơ sở dữ liệu SQLite ghi được và dành riêng cho lần chạy kiểm thử, Newman `6.2.2` và `newman-reporter-htmlextra 1.23.1`.

## Điều kiện tiên quyết

1. Đăng ký một người dùng dùng một lần dành riêng cho test case.
2. Cấp OTP reset gắn với email ngay trước thao tác của test case.
3. Xác nhận việc thiết lập người dùng và OTP trong môi trường cô lập đã thành công.

## Các bước tái hiện

1. Gửi `POST /api/reset-password` cho người dùng dùng một lần bằng OTP vừa được cấp.
2. Lược bỏ field `newPassword`.
3. Quan sát response và kiểm tra trạng thái người dùng/token sau reset trong cơ sở dữ liệu cô lập.

## Kết quả mong đợi

Request không được coi là reset thành công, trạng thái mật khẩu hiện tại phải giữ nguyên và OTP không bị tiêu thụ như một lần sử dụng thành công. Không khẳng định HTTP status cụ thể vì nguồn có thẩm quyền không quy định giá trị đó cho khoảng trống này.

## Kết quả thực tế

SUT trả về response thành công, thay đổi trạng thái trong cơ sở dữ liệu cô lập và vô hiệu hóa OTP mới dù `newPassword` bị thiếu. Một lần thử lại hợp lệ sau đó không thể tái sử dụng token đã bị tiêu thụ.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — `API01-AI-007` gửi body chỉ có `email` và `resetToken`, không có `newPassword`, nhưng nhận HTTP `200` với thông báo `Password reset successfully`.
- `NEWMAN_ASSERTION_FAILED: NO` — request/response thật cho thấy bất biến nghiệp vụ bị vi phạm; runner không ghi nhận assertion thất bại.
- `EXTERNAL_VERIFICATION_USED: YES` — state evidence xác nhận database thay đổi, token bị tiêu thụ và lần thử lại hợp lệ nhận HTTP `400`.
- `PRIMARY_FAILURE_EVIDENCE: BOTH` — Newman là bằng chứng business-failure trực tiếp; external state xác nhận side effect.

## Mức độ ảnh hưởng

Endpoint có thể đưa tài khoản vào trạng thái thông tin xác thực không hợp lệ hoặc không sử dụng được, đồng thời tiêu thụ token khôi phục hợp lệ mà không thiết lập mật khẩu mới bắt buộc.

## Mức độ nghiêm trọng đề xuất

**Trung bình (Medium)**

Hành vi quan sát được làm hỏng tính toàn vẹn của trạng thái khôi phục tài khoản và có thể khiến người dùng không đăng nhập được. Bằng chứng không tự chứng minh việc chiếm đoạt tài khoản trái phép nên không đưa ra mức ảnh hưởng cao hơn.

## Đường dẫn bằng chứng

- `test-results/hw06/run-002/newman.json` — request/response thật của `API01-AI-007`.
- `test-results/hw06/run-002/case-accounting.json` — kết quả FAIL cuối cùng và ánh xạ `RC-01-N01`.
- `test-results/hw06/run-002/external-hook-evidence.json` — thay đổi hash/trạng thái của cơ sở dữ liệu theo test case và reset token không còn tồn tại.
- `docs/execution-results/run-002-new-defect-human-review-packet.md` — tái dựng cụm nguyên nhân đã được sinh viên review.
- `docs/requirement-analysis/api-01-reset-password.md` — truy vết yêu cầu có thẩm quyền và khoảng trống transport đã được tài liệu hóa.

## Ảnh minh chứng

- Request/response execution: `docs/defects/screenshots/DEF-07-A-request-response.png`.
- External/state: `docs/defects/screenshots/DEF-07-B-state-evidence.png`.
