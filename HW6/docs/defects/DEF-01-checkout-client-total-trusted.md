# DEF-01 — Checkout tin tưởng giá trị tổng tiền do client gửi lên

- Mã lỗi: `DEF-01`
- Tên kỹ thuật: `CLIENT_SUPPLIED_TOTAL_TRUSTED`
- API: `POST /api/checkout`
- Yêu cầu liên quan: `API02-REQ-005`, `API02-REQ-006`
- Cụm nguyên nhân gốc: `RC-02-01`
- Test case chính: `API02-AI-002`
- Các test case hỗ trợ: `[API02-AI-003, API02-AI-004, API02-AI-005, API02-AI-006, API02-AI-007, API02-AI-010, API02-AI-017, API02-AI-025, API02-AI-037]`
- Lần chạy kiểm thử: `run-001`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Xác nhận của sinh viên: `CONFIRMED_PRODUCT_DEFECT`

## Môi trường kiểm thử

Backend EShop Node/Express chạy cục bộ tại `http://localhost:3000`, cơ sở dữ liệu SQLite ghi được và dành riêng cho lần chạy kiểm thử, Newman `6.2.2` và `newman-reporter-htmlextra 1.23.1`.

## Điều kiện tiên quyết

1. Một người dùng dùng một lần đã xác thực có sản phẩm trong giỏ hàng.
2. Tổng tiền của giỏ hàng được tính độc lập từ các dòng hàng hiện tại; bằng chứng chính của `run-001` ghi nhận giá trị `400000`.
3. Request có JWT Bearer hợp lệ và header `X-Student-Id`.

## Các bước tái hiện

1. Đọc giỏ hàng của người dùng đã xác thực và tính tổng tiền một cách độc lập.
2. Gửi `POST /api/checkout` với `total_amount` cố ý khác tổng tiền thực tế, chẳng hạn `1`, cùng địa chỉ giao hàng.
3. Kiểm tra response và đơn hàng mới được lưu trong SQLite dành riêng cho kiểm thử.

## Kết quả mong đợi

Backend phải xác định tổng tiền checkout có thẩm quyền từ giỏ hàng hiện tại của người dùng đã xác thực và không được coi `total_amount` do client gửi lên là giá trị có thẩm quyền.

## Kết quả thực tế

Checkout thành công và tổng tiền của đơn hàng được lưu là `1`, thay vì tổng tiền giỏ hàng `400000` đã được tính độc lập. Các test case hỗ trợ tái hiện cùng hành vi với giá trị bằng không, số âm, bị lược bỏ, chuỗi số, số rất lớn, giỏ hàng một phần và giá trị có dạng injection.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — `API02-AI-002` đã gửi `total_amount = 1` và nhận HTTP `200` với thông báo `Checkout successful`.
- `NEWMAN_ASSERTION_FAILED: NO` — Newman là bằng chứng bối cảnh thực thi, không phải bằng chứng assertion thất bại.
- `EXTERNAL_VERIFICATION_USED: YES` — xác minh sau thực thi ghi nhận order ID `3` được lưu với `total_amount = 1`, trong khi tổng giỏ hàng được tính độc lập là `400000`.
- `PRIMARY_FAILURE_EVIDENCE: EXTERNAL_STATE` — trạng thái order persisted trong SQLite là bằng chứng quyết định của lỗi.

## Mức độ ảnh hưởng

Client có thể thao túng số tiền được ghi nhận cho đơn hàng mà không phụ thuộc vào nội dung giỏ hàng, làm ảnh hưởng đến tính toàn vẹn của đơn hàng và dữ liệu tài chính.

## Mức độ nghiêm trọng đề xuất

**Cao (High)**

Client có thể trực tiếp thao túng một giá trị tiền tệ có thẩm quyền. Đây là mức độ do AI đề xuất; việc duyệt mức độ cuối cùng vẫn thuộc về sinh viên.

## Đường dẫn bằng chứng

- `test-results/hw06/run-001/newman.json`
- `test-results/hw06/run-001/newman.html`
- `test-results/hw06/run-001/external-verification-results.json`
- `test-results/hw06/runtime/sut-db-003/database.sqlite`
- `test-results/hw06/run-001/case-accounting.json`
- `docs/execution-results/human-failure-triage-packet.md`

## Ảnh minh chứng

- Request/response execution: `docs/defects/screenshots/DEF-01-A-request-response.png`.
- External/state: `docs/defects/screenshots/DEF-01-B-state-evidence.png`.
