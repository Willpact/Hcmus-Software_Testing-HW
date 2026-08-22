# [HW06][DEF-06] API import sản phẩm không kiểm tra quyền Admin

## Mã lỗi

DEF-06

## Cụm nguyên nhân gốc

RC-03-03

## API / Endpoint

`POST /api/admin/import-products`

## Yêu cầu liên quan

- `API03-REQ-002`: Các API Admin yêu cầu Bearer JWT và tài khoản Admin.
- `API03-REQ-003`: Các API Admin phải xác minh `role = 'admin'` trong token, không chỉ kiểm tra token tồn tại.

## Môi trường kiểm thử

- Hệ thống: EShop chạy cục bộ
- Base URL: `http://localhost:3000`
- Newman: `6.2.2`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Lần chạy kiểm thử: `run-001`
- Cơ sở dữ liệu: SQLite cục bộ dành riêng cho kiểm thử

## Điều kiện tiên quyết

1. Một người dùng dùng một lần không có quyền Admin sở hữu JWT hợp lệ.
2. Request import chứa các sản phẩm hợp lệ có tên dùng một lần.
3. Request có `X-Student-Id`.

## Các bước tái hiện

1. Xác thực bằng tài khoản người dùng thông thường và lấy JWT hợp lệ của tài khoản đó.
2. Gửi `POST /api/admin/import-products` bằng token không có quyền Admin.
3. Quan sát response import.
4. Xác minh sản phẩm có tên dùng một lần có được lưu trong SQLite dành riêng cho kiểm thử hay không.

## Kết quả mong đợi

Endpoint import dành cho Admin yêu cầu cả Bearer JWT hợp lệ và role `admin` đã được xác minh. Token hợp lệ của người dùng không có quyền Admin không được thực hiện import, và field trong request body không được nâng quyền.

## Kết quả thực tế

JWT hợp lệ của người dùng không có quyền Admin vẫn đi vào logic import và lưu sản phẩm. Các biến thể giả mạo role trong payload cũng đi đến bước lưu dữ liệu vì role Admin bắt buộc không được xác minh.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — primary case dùng JWT non-admin và nhận HTTP `200`, `inserted = 1`, `errors = 0`.
- `NEWMAN_ASSERTION_FAILED: NO`.
- `EXTERNAL_VERIFICATION_USED: YES` — SQLite xác nhận sản phẩm dùng một lần persisted sau request non-admin.
- `PRIMARY_FAILURE_EVIDENCE: BOTH`.

External verification được bổ sung trong bước hậu kiểm sau thực thi của Human triage để xác minh trạng thái persisted trong SQLite; metadata và artifact test case gốc không bị viết lại.

## Mức độ ảnh hưởng

Bất kỳ người dùng thông thường nào đã xác thực cũng có thể sửa dữ liệu catalog qua thao tác chỉ dành cho Admin, tạo rủi ro nâng quyền và làm ảnh hưởng dữ liệu được lưu.

## Mức độ nghiêm trọng

**Cao (High)**

Lý do: Lỗi vượt qua ranh giới phân quyền Admin và cho phép thay đổi catalog trái phép được lưu lâu dài.

## Test case chính

`API03-AI-026`

## Các test case hỗ trợ

- `API03-AI-028`
- `API03-STU-001`
- `API03-STU-002`

## Bằng chứng thực thi

- Newman JSON: `test-results/hw06/run-001/newman.json`
- Newman HTML: `test-results/hw06/run-001/newman.html`
- Xác minh bên ngoài: `test-results/hw06/run-001/external-verification-results.json`
- SQLite nguồn: `test-results/hw06/runtime/sut-db-003/database.sqlite`
- Đối chiếu kết quả: `test-results/hw06/run-001/case-accounting.json`

## Ảnh minh chứng

- Request/response: `docs/defects/screenshots/DEF-06-A-request-response.png`.
- External/state: `docs/defects/screenshots/DEF-06-B-state-evidence.png`.

## Xác nhận của sinh viên

`CONFIRMED_PRODUCT_DEFECT`
