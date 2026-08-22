# [HW06][DEF-05] Import sản phẩm không đảm bảo tính nguyên tử

## Mã lỗi

DEF-05

## Cụm nguyên nhân gốc

RC-03-02

## API / Endpoint

`POST /api/admin/import-products`

## Yêu cầu liên quan

- `API03-REQ-007`: Tên của mỗi sản phẩm import phải không rỗng và giá phải là số dương.
- `API03-REQ-009`: Bất kỳ lỗi dòng nào cũng phải rollback toàn bộ lần import; import phải có tính nguyên tử (atomicity / all-or-nothing).

## Môi trường kiểm thử

- Hệ thống: EShop chạy cục bộ
- Base URL: `http://localhost:3000`
- Newman: `6.2.2`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Lần chạy kiểm thử: `run-001`
- Cơ sở dữ liệu: SQLite cục bộ dành riêng cho kiểm thử

## Điều kiện tiên quyết

1. Có JWT Admin hợp lệ.
2. Trạng thái sản phẩm được ghi nhận trước khi import.
3. Một batch có tên dùng một lần chứa ít nhất một dòng hợp lệ và một dòng không hợp lệ theo hợp đồng import có thẩm quyền.

## Các bước tái hiện

1. Gửi batch `API03-AI-017`: dòng thứ nhất có `name` rỗng, dòng thứ hai là sản phẩm hợp lệ có tên dùng một lần.
2. Quan sát số lượng dòng đã thêm và số lượng lỗi.
3. Truy vấn SQLite dành riêng cho kiểm thử đối với từng dòng có tên dùng một lần trong batch.
4. So sánh trạng thái được lưu với yêu cầu all-or-nothing.

## Kết quả mong đợi

Nếu bất kỳ dòng import nào không hợp lệ, toàn bộ batch phải được rollback và không dòng nào của batch được lưu.

## Kết quả thực tế

Endpoint trả HTTP `200`, `inserted = 1`, `errors = 1`: dòng đầu có tên rỗng bị báo lỗi nhưng dòng hợp lệ thứ hai vẫn được lưu. SQLite sau thực thi xác nhận dữ liệu một phần được giữ lại.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — Newman ghi nhận đúng thứ tự hai dòng và partial success `1/2`.
- `NEWMAN_ASSERTION_FAILED: NO`.
- `EXTERNAL_VERIFICATION_USED: YES` — SQLite xác nhận dòng hợp lệ thứ hai persisted từ batch không hợp lệ.
- `PRIMARY_FAILURE_EVIDENCE: BOTH`.

External verification được bổ sung trong bước hậu kiểm sau thực thi của Human triage để xác minh trạng thái persisted trong SQLite; metadata và artifact test case gốc không bị viết lại.

## Mức độ ảnh hưởng

Một lần import thất bại có thể để lại dữ liệu catalog một phần và không nhất quán, đồng thời làm cho các lần thử lại sau đó gây hiểu nhầm hoặc không xác định.

## Mức độ nghiêm trọng

**Cao (High)**

Lý do: Lỗi vi phạm tính toàn vẹn giao dịch và có thể âm thầm để lại dữ liệu được lưu từ một thao tác bulk import thất bại.

## Test case chính

`API03-AI-017`

## Các test case hỗ trợ

- `API03-AI-019`
- `API03-AI-020`
- `API03-AI-021`

## Bằng chứng thực thi

- Newman JSON: `test-results/hw06/run-001/newman.json`
- Newman HTML: `test-results/hw06/run-001/newman.html`
- Xác minh bên ngoài: `test-results/hw06/run-001/external-verification-results.json`
- SQLite nguồn: `test-results/hw06/runtime/sut-db-003/database.sqlite`
- Đối chiếu kết quả: `test-results/hw06/run-001/case-accounting.json`

## Ảnh minh chứng

- Request/response: `docs/defects/screenshots/DEF-05-A-request-response.png`.
- External/state: `docs/defects/screenshots/DEF-05-B-state-evidence.png`.

## Xác nhận của sinh viên

`CONFIRMED_PRODUCT_DEFECT`
