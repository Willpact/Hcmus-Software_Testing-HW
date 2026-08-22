# [HW06][DEF-04] Import sản phẩm chấp nhận giá không dương

## Mã lỗi

DEF-04

## Cụm nguyên nhân gốc

RC-03-01

## API / Endpoint

`POST /api/admin/import-products`

## Yêu cầu liên quan

- `API03-REQ-007`: Tên của mỗi sản phẩm import phải không rỗng và giá phải là số dương.
- `API03-REQ-009`: Bất kỳ lỗi dòng nào cũng phải rollback toàn bộ lần import.
- `API03-REQ-010`: Hệ thống báo cáo số dòng thành công, số dòng lỗi và nguyên nhân; response schema chính xác không được quy định.

## Môi trường kiểm thử

- Hệ thống: EShop chạy cục bộ
- Base URL: `http://localhost:3000`
- Newman: `6.2.2`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Lần chạy kiểm thử: `run-001`
- Cơ sở dữ liệu: SQLite cục bộ dành riêng cho kiểm thử

## Điều kiện tiên quyết

1. Có JWT Admin hợp lệ.
2. Batch import sử dụng tên sản phẩm dùng một lần và không trùng nhau.
3. Ít nhất một dòng import có giá bằng `0` hoặc là số âm.

## Các bước tái hiện

1. Gửi `POST /api/admin/import-products` với một sản phẩm có tên dùng một lần và giá `0`.
2. Lặp lại với một sản phẩm có tên dùng một lần và giá âm, hoặc đưa dòng đó vào một batch hỗn hợp.
3. Kiểm tra response.
4. Xác minh các dòng sản phẩm tương ứng trong SQLite dành riêng cho kiểm thử.

## Kết quả mong đợi

Giá của mỗi sản phẩm import phải là số dương. Dòng có giá không dương là không hợp lệ và không được lưu.

## Kết quả thực tế

Các dòng có giá `0` và `-1` được báo là đã thêm và thực tế tồn tại trong SQLite. Bằng chứng ánh xạ mọi phân vùng giá vào cùng một lỗi gốc thiếu validation giá dương.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — primary case gửi `price = 0` và nhận HTTP `200`, `inserted = 1`, `errors = 0`.
- `NEWMAN_ASSERTION_FAILED: NO`.
- `EXTERNAL_VERIFICATION_USED: YES` — SQLite xác nhận sản phẩm giá `0` persisted.
- `PRIMARY_FAILURE_EVIDENCE: BOTH`.

External verification được bổ sung trong bước hậu kiểm sau thực thi của Human triage để xác minh trạng thái persisted trong SQLite; metadata và artifact test case gốc không bị viết lại.

## Mức độ ảnh hưởng

Giá sản phẩm không hợp lệ có thể đi vào dữ liệu lưu trữ và lan truyền sang hiển thị sản phẩm, giỏ hàng, checkout và báo cáo.

## Mức độ nghiêm trọng

**Cao (High)**

Lý do: Giá không hợp lệ được lưu lâu dài làm ảnh hưởng đến tính toàn vẹn của catalog và các thao tác tiền tệ phía sau.

## Test case chính

`API03-AI-009`

## Các test case hỗ trợ

- `API03-AI-010`
- `API03-AI-018`
- `API03-AI-022`
- `API03-AI-038`
- `API03-STU-003`

## Bằng chứng thực thi

- Newman JSON: `test-results/hw06/run-001/newman.json`
- Newman HTML: `test-results/hw06/run-001/newman.html`
- Xác minh bên ngoài: `test-results/hw06/run-001/external-verification-results.json`
- SQLite nguồn: `test-results/hw06/runtime/sut-db-003/database.sqlite`
- Đối chiếu kết quả: `test-results/hw06/run-001/case-accounting.json`

## Ảnh minh chứng

- Request/response: `docs/defects/screenshots/DEF-04-A-request-response.png`.
- External/state: `docs/defects/screenshots/DEF-04-B-state-evidence.png`.

## Xác nhận của sinh viên

`CONFIRMED_PRODUCT_DEFECT`
