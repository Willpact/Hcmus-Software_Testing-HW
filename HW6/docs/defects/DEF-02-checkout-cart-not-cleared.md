# DEF-02 — Giỏ hàng không được xóa sau khi checkout thành công

- Mã lỗi: `DEF-02`
- Tên kỹ thuật: `SUCCESSFUL_CHECKOUT_DOES_NOT_CLEAR_CART`
- API: `POST /api/checkout`
- Yêu cầu liên quan: `API02-REQ-007`
- Cụm nguyên nhân gốc: `RC-02-02`
- Test case chính: `API02-AI-014`
- Các test case hỗ trợ: `[API02-AI-002, API02-AI-003, API02-AI-004, API02-AI-005, API02-AI-006, API02-AI-007, API02-AI-010, API02-AI-017, API02-AI-025, API02-AI-026, API02-AI-029, API02-AI-036, API02-AI-037]`
- Lần chạy kiểm thử: `run-001`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Xác nhận của sinh viên: `CONFIRMED_PRODUCT_DEFECT`

## Môi trường kiểm thử

Backend EShop Node/Express chạy cục bộ tại `http://localhost:3000`, cơ sở dữ liệu SQLite ghi được và dành riêng cho lần chạy kiểm thử, Newman `6.2.2` và các request kiểm tra lại trạng thái giỏ hàng qua HTTP thật.

## Điều kiện tiên quyết

1. Một người dùng dùng một lần đã xác thực có sản phẩm trong giỏ hàng.
2. Request có JWT Bearer hợp lệ và header `X-Student-Id`.
3. Trạng thái giỏ hàng được ghi nhận ngay trước khi checkout.

## Các bước tái hiện

1. Đọc giỏ hàng của người dùng đã xác thực và ghi nhận số dòng hàng.
2. Thực hiện thành công `POST /api/checkout`.
3. Đọc lại giỏ hàng của chính người dùng đó.

## Kết quả mong đợi

Sau khi checkout thành công, giỏ hàng của người dùng đã xác thực phải rỗng; giỏ hàng của người dùng khác không bị ảnh hưởng.

## Kết quả thực tế

Giỏ hàng của người dùng chính vẫn có hai dòng hàng cả trước và sau khi checkout thành công. Giỏ hàng độc lập của người dùng thứ hai cũng giữ nguyên một dòng, xác nhận rằng checkout không thực hiện chuyển trạng thái xóa giỏ hàng.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — `API02-AI-014` ghi nhận checkout thực sự hoàn tất thành công.
- `NEWMAN_ASSERTION_FAILED: NO` — Newman chỉ cung cấp bối cảnh checkout; không có assertion thất bại trong report.
- `EXTERNAL_VERIFICATION_USED: YES` — postcheck HTTP thật ghi nhận giỏ hàng người dùng chính còn `2` dòng và giỏ hàng người dùng thứ hai còn `1` dòng.
- `PRIMARY_FAILURE_EVIDENCE: EXTERNAL_STATE` — trạng thái giỏ hàng không đổi sau checkout là bằng chứng quyết định.

## Mức độ ảnh hưởng

Các sản phẩm đã mua vẫn nằm trong giỏ hàng, có thể gây checkout trùng lặp, gây nhầm lẫn cho người dùng và tạo trạng thái giỏ hàng/đơn hàng không nhất quán.

## Mức độ nghiêm trọng đề xuất

**Trung bình (Medium)**

Lỗi làm hỏng tính toàn vẹn của luồng và trạng thái, đồng thời có thể dẫn đến mua hàng trùng lặp, nhưng bản thân bằng chứng không cho thấy cơ chế xác thực bị vượt qua.

## Đường dẫn bằng chứng

- `test-results/hw06/run-001/external-postcheck.newman.json`
- `test-results/hw06/run-001/external-verification-results.json`
- `test-results/hw06/run-001/case-accounting.json`
- `test-results/hw06/run-001/newman.html`
- `docs/execution-results/human-failure-triage-packet.md`
- `test-results/hw06/run-002/case-accounting.json` — `API02-STU-001` là bằng chứng bổ sung từ trình tự đã được sửa và được ánh xạ vào cùng `RC-02-02`; test case này không tạo lỗi mới.

## Ảnh minh chứng

- Request/response execution: `docs/defects/screenshots/DEF-02-A-request-response.png`.
- External/state: `docs/defects/screenshots/DEF-02-B-state-evidence.png`.
