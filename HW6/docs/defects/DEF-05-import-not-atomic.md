# DEF-05 — Import sản phẩm không đảm bảo tính nguyên tử

- Mã lỗi: `DEF-05`
- Tên kỹ thuật: `IMPORT_NOT_ATOMIC`
- API: `POST /api/admin/import-products`
- Yêu cầu liên quan: `API03-REQ-007`, `API03-REQ-009`
- Cụm nguyên nhân gốc: `RC-03-02`
- Test case chính: `API03-AI-017`
- Các test case hỗ trợ: `[API03-AI-019, API03-AI-020, API03-AI-021]`
- Lần chạy kiểm thử: `run-001`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Xác nhận của sinh viên: `CONFIRMED_PRODUCT_DEFECT`

## Môi trường kiểm thử

Backend EShop Node/Express chạy cục bộ tại `http://localhost:3000`, cơ sở dữ liệu SQLite ghi được và dành riêng cho lần chạy kiểm thử, Newman `6.2.2` và cơ chế kiểm tra chỉ đọc trạng thái sản phẩm trước/sau import.

## Điều kiện tiên quyết

1. Có JWT Admin hợp lệ.
2. Trạng thái sản phẩm được ghi nhận trước khi import.
3. Một batch có tên dùng một lần chứa ít nhất một dòng hợp lệ và một dòng không hợp lệ theo hợp đồng có thẩm quyền.

## Các bước tái hiện

1. Gửi batch của `API03-AI-017`, trong đó dòng thứ nhất có `name` rỗng và dòng thứ hai là sản phẩm hợp lệ có tên dùng một lần.
2. Quan sát số lượng dòng đã thêm và số lượng lỗi.
3. Kiểm tra SQLite đối với từng dòng có tên dùng một lần trong batch.

## Kết quả mong đợi

Nếu bất kỳ dòng nào làm batch không hợp lệ, toàn bộ batch phải được rollback và không dòng nào của batch được lưu. Đây là yêu cầu về tính nguyên tử (atomicity / all-or-nothing).

## Kết quả thực tế

Endpoint trả HTTP `200`, báo `inserted = 1` và `errors = 1`: dòng đầu có tên rỗng bị báo lỗi nhưng dòng hợp lệ thứ hai của cùng batch vẫn được lưu. SQLite xác nhận dòng hợp lệ persisted, trái với yêu cầu rollback toàn bộ batch.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — `API03-AI-017` ghi nhận đúng thứ tự dòng: dòng đầu `name` rỗng, dòng thứ hai hợp lệ; response là HTTP `200`, `inserted = 1`, `errors = 1`.
- `NEWMAN_ASSERTION_FAILED: NO` — Newman ghi nhận partial success; không có assertion thất bại trong report.
- `EXTERNAL_VERIFICATION_USED: YES` — SQLite xác nhận dòng hợp lệ thứ hai thực sự persisted từ batch không hợp lệ.
- `PRIMARY_FAILURE_EVIDENCE: BOTH` — response chứng minh xử lý không all-or-nothing và SQLite xác nhận partial persistence.

External verification được bổ sung trong bước hậu kiểm sau thực thi của Human triage để xác minh trạng thái persisted trong SQLite. Đây là evidence hậu kiểm, không thay đổi metadata `EXTERNAL_VERIFICATION: NONE` của test case gốc hoặc artifact thực thi lịch sử.

## Mức độ ảnh hưởng

Một lần import thất bại có thể để lại dữ liệu catalog một phần và gây hiểu nhầm, đồng thời làm cho các lần thử lại trở nên không xác định.

## Mức độ nghiêm trọng đề xuất

**Cao (High)**

Lỗi vi phạm tính toàn vẹn giao dịch và có thể âm thầm làm sai lệch kết quả bulk import.

## Đường dẫn bằng chứng

- `test-results/hw06/run-001/newman.json`
- `test-results/hw06/run-001/external-verification-results.json`
- `test-results/hw06/runtime/sut-db-003/database.sqlite`
- `test-results/hw06/run-001/case-accounting.json`
- `docs/execution-results/human-failure-triage-packet.md`

## Ảnh minh chứng

- Request/response execution: `docs/defects/screenshots/DEF-05-A-request-response.png`.
- External/state SQLite chỉ đọc: `docs/defects/screenshots/DEF-05-B-state-evidence.png`.
