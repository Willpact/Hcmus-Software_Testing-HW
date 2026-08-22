# DEF-04 — Import sản phẩm chấp nhận giá không dương

- Mã lỗi: `DEF-04`
- Tên kỹ thuật: `PRODUCT_PRICE_POSITIVITY_NOT_ENFORCED`
- API: `POST /api/admin/import-products`
- Yêu cầu liên quan: `API03-REQ-007`, `API03-REQ-009`, `API03-REQ-010`
- Cụm nguyên nhân gốc: `RC-03-01`
- Test case chính: `API03-AI-009`
- Các test case hỗ trợ: `[API03-AI-010, API03-AI-018, API03-AI-022, API03-AI-038, API03-STU-003]`
- Lần chạy kiểm thử: `run-001`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Xác nhận của sinh viên: `CONFIRMED_PRODUCT_DEFECT`

## Môi trường kiểm thử

Backend EShop Node/Express chạy cục bộ tại `http://localhost:3000`, cơ sở dữ liệu SQLite ghi được và dành riêng cho lần chạy kiểm thử, Newman `6.2.2` và cơ chế kiểm tra chỉ đọc bảng sản phẩm.

## Điều kiện tiên quyết

1. Có JWT Admin hợp lệ.
2. Batch import sử dụng tên sản phẩm dùng một lần và không trùng nhau.
3. Ít nhất một dòng có giá bằng `0` hoặc là số âm.

## Các bước tái hiện

1. Gửi `POST /api/admin/import-products` với một sản phẩm import có giá `0`.
2. Lặp lại với giá âm hoặc đưa dòng có giá âm vào một batch hỗn hợp.
3. Kiểm tra response và các dòng sản phẩm trong SQLite dành riêng cho kiểm thử.

## Kết quả mong đợi

Giá của mỗi sản phẩm import phải là số dương; dòng có giá không dương là không hợp lệ và không được lưu.

## Kết quả thực tế

Các dòng có giá `0` và `-1` được báo là đã thêm và thực tế tồn tại trong SQLite. Endpoint kiểm tra tên bị thiếu nhưng không enforce điều kiện giá dương.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — `API03-AI-009` gửi sản phẩm có `price = 0` và nhận HTTP `200`, `inserted = 1`, `errors = 0`.
- `NEWMAN_ASSERTION_FAILED: NO` — response Newman là bằng chứng hành vi quan sát được, không phải assertion failure.
- `EXTERNAL_VERIFICATION_USED: YES` — SQLite xác nhận dòng sản phẩm của primary case với `price = 0` thực sự persisted.
- `PRIMARY_FAILURE_EVIDENCE: BOTH` — request/response cho thấy endpoint chấp nhận dữ liệu, còn SQLite xác nhận side effect persisted.

External verification được bổ sung trong bước hậu kiểm sau thực thi của Human triage để xác minh trạng thái persisted trong SQLite. Đây là evidence hậu kiểm, không thay đổi metadata `EXTERNAL_VERIFICATION: NONE` của test case gốc hoặc artifact thực thi lịch sử.

## Mức độ ảnh hưởng

Giá sản phẩm không hợp lệ có thể đi vào dữ liệu lưu trữ và lan truyền sang hiển thị sản phẩm, giỏ hàng, checkout và báo cáo.

## Mức độ nghiêm trọng đề xuất

**Cao (High)**

Giá không hợp lệ được lưu lâu dài làm ảnh hưởng đến tính toàn vẹn của catalog và các thao tác tiền tệ phía sau.

## Đường dẫn bằng chứng

- `test-results/hw06/run-001/newman.json`
- `test-results/hw06/run-001/external-verification-results.json`
- `test-results/hw06/runtime/sut-db-003/database.sqlite`
- `test-results/hw06/run-001/case-accounting.json`
- `docs/execution-results/human-failure-triage-packet.md`

## Ảnh minh chứng

- Request/response execution: `docs/defects/screenshots/DEF-04-A-request-response.png`.
- External/state SQLite chỉ đọc: `docs/defects/screenshots/DEF-04-B-state-evidence.png`.
