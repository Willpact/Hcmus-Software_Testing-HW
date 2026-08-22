# [HW06][DEF-09] Mật khẩu mới được lưu dưới dạng plaintext

## Mã lỗi

DEF-09

## Cụm nguyên nhân gốc

RC-01-N03

## API / Endpoint

`POST /api/reset-password`

## Yêu cầu liên quan

- `API01-REQ-008`: Mật khẩu không được lưu dưới dạng plaintext (văn bản thuần).

## Môi trường kiểm thử

- Hệ thống: EShop chạy cục bộ
- Base URL: `http://localhost:3000`
- Newman: `6.2.2`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Lần chạy kiểm thử: `run-002`
- Cơ sở dữ liệu: SQLite cục bộ dành riêng cho kiểm thử

## Điều kiện tiên quyết

1. Đăng ký một người dùng dùng một lần dành riêng cho test case trong cơ sở dữ liệu runtime cô lập.
2. Cấp OTP mới gắn với email.
3. Hoàn tất một lần reset hợp lệ về các điều kiện còn lại cho người dùng đó.
4. Xác định chính xác dòng dữ liệu sau reset bằng định danh dùng một lần của test case.

## Các bước tái hiện

1. Thực thi `API01-AI-035` bằng người dùng dùng một lần và OTP mới.
2. Xác nhận thao tác reset hoàn tất.
3. Thực hiện phép so sánh SQLite chỉ đọc đã được phê duyệt với field mật khẩu của đúng dòng người dùng.
4. Chỉ ghi lại kết quả boolean; không in giá trị thông tin xác thực đã gửi hoặc đã lưu.

## Kết quả mong đợi

Biểu diễn mật khẩu được lưu phải khác mật khẩu plaintext đã gửi.

## Kết quả thực tế

Đúng dòng người dùng dành riêng cho test case đã được tìm thấy và phép so sánh chỉ đọc an toàn trả về:

```text
PLAINTEXT_EQUAL:
YES
```

Không có giá trị mật khẩu nào được log.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — reset được thực thi và nhận HTTP `200`; đây chỉ là execution-context evidence.
- `NEWMAN_ASSERTION_FAILED: NO`.
- `EXTERNAL_VERIFICATION_USED: YES` — xác minh SQLite chỉ đọc ghi `user_found = true`, `PLAINTEXT_EQUAL = YES`, `password_value_logged = false`.
- `PRIMARY_FAILURE_EVIDENCE: EXTERNAL_STATE`.

## Mức độ ảnh hưởng

Bất kỳ ai có quyền đọc datastore đều có thể trực tiếp lấy mật khẩu reset bị ảnh hưởng thay vì phải đối mặt với cơ chế xác minh mật khẩu một chiều. Bằng chứng chỉ chứng minh sự trùng khớp plaintext cho luồng reset cô lập đã được kiểm thử.

## Mức độ nghiêm trọng

**Cao (High)**

Lý do: Lưu thông tin xác thực dưới dạng plaintext tạo rủi ro nghiêm trọng về tính bí mật và an toàn tài khoản; bằng chứng không chứng minh một vụ xâm nhập datastore hoặc định lượng phạm vi tài khoản rộng hơn.

## Test case chính

`API01-AI-035`

## Các test case hỗ trợ

- Không có.

## Bằng chứng thực thi

- Newman JSON: `test-results/hw06/run-002/newman.json`
- Newman HTML: `test-results/hw06/run-002/newman.html`
- Xác minh bên ngoài: `test-results/hw06/run-002/external-verification-results.json`
- Bằng chứng trạng thái hỗ trợ: `test-results/hw06/run-002/external-hook-evidence.json`
- Bằng chứng quyết định an toàn: `PLAINTEXT_EQUAL: YES`; không chứa mật khẩu plaintext, password hash, JWT, Student ID hoặc thông tin xác thực.

## Ảnh minh chứng

- Request/response: `docs/defects/screenshots/DEF-09-A-request-response.png`.
- External/state: `docs/defects/screenshots/DEF-09-B-state-evidence.png`.

## Xác nhận của sinh viên

`CONFIRMED_PRODUCT_DEFECT`
