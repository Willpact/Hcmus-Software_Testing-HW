# [HW06][API Testing][BUG][Checkout API] Checkout tin tưởng total_amount do client gửi lên

## Mã lỗi

DEF-01

## Cụm nguyên nhân gốc

RC-02-01

## API / Endpoint

`POST /api/checkout`

## Yêu cầu liên quan

- `API02-REQ-005`: Tổng tiền thanh toán phải được tính tự động từ giỏ hàng và người dùng không được trực tiếp chỉnh sửa.
- `API02-REQ-006`: Backend phải tính lại tổng tiền và không được coi `total_amount` do client gửi lên là giá trị có thẩm quyền.

## Môi trường kiểm thử

- Hệ thống: EShop chạy cục bộ
- Base URL: `http://localhost:3000`
- Newman: `6.2.2`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Lần chạy kiểm thử: `run-001`
- Cơ sở dữ liệu: SQLite cục bộ dành riêng cho kiểm thử

## Điều kiện tiên quyết

1. Một người dùng dùng một lần đã xác thực có sản phẩm trong giỏ hàng.
2. Tổng tiền giỏ hàng hiện tại được tính độc lập; lần chạy chính ghi nhận `400000`.
3. Request có JWT Bearer hợp lệ và header `X-Student-Id`.

## Các bước tái hiện

1. Đọc giỏ hàng của người dùng đã xác thực và tính tổng tiền một cách độc lập.
2. Gửi `POST /api/checkout` với `total_amount` cố ý khác tổng tiền thực tế, chẳng hạn `1`, cùng địa chỉ giao hàng.
3. Kiểm tra response checkout.
4. Kiểm tra đơn hàng mới được lưu trong SQLite dành riêng cho kiểm thử.

## Kết quả mong đợi

Backend phải xác định tổng tiền checkout có thẩm quyền từ giỏ hàng hiện tại của người dùng đã xác thực và không được coi `total_amount` do client gửi lên là giá trị có thẩm quyền.

## Kết quả thực tế

Checkout thành công và tổng tiền của đơn hàng được lưu là `1`, thay vì tổng tiền giỏ hàng `400000` đã được tính độc lập. Các test case hỗ trợ tái hiện cùng hành vi tin tưởng tổng tiền do client gửi lên với những giá trị không hợp lệ hoặc không nhất quán khác.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — request gửi `total_amount = 1` và nhận HTTP `200`, `Checkout successful`.
- `NEWMAN_ASSERTION_FAILED: NO` — Newman chỉ là execution-context evidence.
- `EXTERNAL_VERIFICATION_USED: YES` — order ID `3` persisted với tổng `1`, trong khi tổng giỏ hàng tính độc lập là `400000`.
- `PRIMARY_FAILURE_EVIDENCE: EXTERNAL_STATE`.

## Mức độ ảnh hưởng

Client có thể thao túng số tiền được ghi nhận cho đơn hàng mà không phụ thuộc vào nội dung giỏ hàng, làm ảnh hưởng đến tính toàn vẹn của đơn hàng và dữ liệu tài chính.

## Mức độ nghiêm trọng

**Cao (High)**

Lý do: Tổng tiền do client kiểm soát có thể khiến đơn hàng được lưu với giá trị tiền tệ có thẩm quyền không chính xác.

## Test case chính

`API02-AI-002`

## Các test case hỗ trợ

- `API02-AI-003`
- `API02-AI-004`
- `API02-AI-005`
- `API02-AI-006`
- `API02-AI-007`
- `API02-AI-010`
- `API02-AI-017`
- `API02-AI-025`
- `API02-AI-037`

## Bằng chứng thực thi

- Newman JSON: `test-results/hw06/run-001/newman.json`
- Newman HTML: `test-results/hw06/run-001/newman.html`
- Xác minh trực tiếp: `test-results/hw06/run-001/external-verification-results.json`
- SQLite nguồn: `test-results/hw06/runtime/sut-db-003/database.sqlite`
- Human verdict: `docs/execution-results/human-failure-triage-packet.md`

## Ảnh minh chứng

- Request/response: `docs/defects/screenshots/DEF-01-A-request-response.png`.
- External/state: `docs/defects/screenshots/DEF-01-B-state-evidence.png`.

## Xác nhận của sinh viên

`CONFIRMED_PRODUCT_DEFECT`
