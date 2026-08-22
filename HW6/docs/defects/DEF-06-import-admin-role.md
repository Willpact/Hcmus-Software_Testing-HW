# DEF-06 — API import sản phẩm không kiểm tra quyền Admin

- Mã lỗi: `DEF-06`
- Tên kỹ thuật: `ADMIN_ROLE_NOT_ENFORCED`
- API: `POST /api/admin/import-products`
- Yêu cầu liên quan: `API03-REQ-002`, `API03-REQ-003`
- Cụm nguyên nhân gốc: `RC-03-03`
- Test case chính: `API03-AI-026`
- Các test case hỗ trợ: `[API03-AI-028, API03-STU-001, API03-STU-002]`
- Lần chạy kiểm thử: `run-001`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Xác nhận của sinh viên: `CONFIRMED_PRODUCT_DEFECT`

## Môi trường kiểm thử

Backend EShop Node/Express chạy cục bộ tại `http://localhost:3000`, cơ sở dữ liệu SQLite ghi được và dành riêng cho lần chạy kiểm thử, Newman `6.2.2` và cơ chế kiểm tra chỉ đọc bảng sản phẩm.

## Điều kiện tiên quyết

1. Một người dùng dùng một lần không có quyền Admin sở hữu JWT hợp lệ.
2. Request chứa các sản phẩm hợp lệ có tên dùng một lần và không trùng nhau.
3. Request có `X-Student-Id`.

## Các bước tái hiện

1. Xác thực bằng tài khoản người dùng thông thường và lấy JWT của tài khoản đó.
2. Gửi `POST /api/admin/import-products` bằng token không có quyền Admin.
3. Kiểm tra response và xác minh sản phẩm có tên dùng một lần có được lưu hay không.

## Kết quả mong đợi

API import dành cho Admin phải từ chối JWT hợp lệ nếu role đã được xác minh không phải `admin`; một field trong request body không được dùng để nâng quyền.

## Kết quả thực tế

JWT hợp lệ của người dùng không có quyền Admin vẫn đi vào logic import và lưu sản phẩm. Các biến thể giả mạo role trong payload cũng đi đến bước lưu dữ liệu vì endpoint xác thực token nhưng không kiểm tra role đã được xác minh.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — `API03-AI-026` dùng JWT của user không phải Admin và nhận HTTP `200`, `inserted = 1`, `errors = 0`.
- `NEWMAN_ASSERTION_FAILED: NO` — Newman ghi nhận hành vi import thành công; không có assertion thất bại trong report.
- `EXTERNAL_VERIFICATION_USED: YES` — SQLite xác nhận sản phẩm có tên dùng một lần thực sự persisted sau request của non-admin.
- `PRIMARY_FAILURE_EVIDENCE: BOTH` — request/response chứng minh bypass role và SQLite xác nhận catalog đã bị thay đổi.

External verification được bổ sung trong bước hậu kiểm sau thực thi của Human triage để xác minh trạng thái persisted trong SQLite. Đây là evidence hậu kiểm, không thay đổi metadata `EXTERNAL_VERIFICATION: NONE` của test case gốc hoặc artifact thực thi lịch sử.

## Mức độ ảnh hưởng

Bất kỳ người dùng thông thường nào đã xác thực cũng có thể sửa dữ liệu catalog qua thao tác chỉ dành cho Admin, tạo rủi ro nâng quyền trực tiếp và làm ảnh hưởng tính toàn vẹn dữ liệu.

## Mức độ nghiêm trọng đề xuất

**Cao (High)**

Lỗi vượt qua ranh giới phân quyền Admin và cho phép thay đổi catalog trái phép được lưu lâu dài.

## Đường dẫn bằng chứng

- `test-results/hw06/run-001/newman.json`
- `test-results/hw06/run-001/external-verification-results.json`
- `test-results/hw06/runtime/sut-db-003/database.sqlite`
- `test-results/hw06/run-001/case-accounting.json`
- `docs/execution-results/human-failure-triage-packet.md`

## Ảnh minh chứng

- Request/response execution: `docs/defects/screenshots/DEF-06-A-request-response.png`.
- External/state SQLite chỉ đọc: `docs/defects/screenshots/DEF-06-B-state-evidence.png`.
