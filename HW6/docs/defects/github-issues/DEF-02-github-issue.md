# [HW06][DEF-02] Giỏ hàng không được xóa sau khi checkout thành công

## Mã lỗi

DEF-02

## Cụm nguyên nhân gốc

RC-02-02

## API / Endpoint

`POST /api/checkout`

## Yêu cầu liên quan

- `API02-REQ-007`: Checkout thành công phải xóa giỏ hàng của người dùng đã xác thực.

## Môi trường kiểm thử

- Hệ thống: EShop chạy cục bộ
- Base URL: `http://localhost:3000`
- Newman: `6.2.2`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Lần chạy kiểm thử: `run-001`
- Cơ sở dữ liệu: SQLite cục bộ dành riêng cho kiểm thử

## Điều kiện tiên quyết

1. Một người dùng dùng một lần đã xác thực có sản phẩm trong giỏ hàng.
2. Request có JWT Bearer hợp lệ và header `X-Student-Id`.
3. Trạng thái giỏ hàng của người dùng đã xác thực được ghi nhận ngay trước khi checkout.

## Các bước tái hiện

1. Đọc giỏ hàng của người dùng đã xác thực và ghi nhận số dòng hàng.
2. Hoàn tất thành công `POST /api/checkout`.
3. Đọc lại giỏ hàng của chính người dùng đó.
4. So sánh trạng thái giỏ hàng trước và sau checkout.

## Kết quả mong đợi

Checkout thành công phải xóa giỏ hàng của người dùng đã xác thực.

## Kết quả thực tế

Giỏ hàng của người dùng chính vẫn có hai dòng hàng cả trước và sau khi checkout thành công. Bằng chứng trạng thái độc lập xác nhận rằng checkout không thực hiện chuyển trạng thái xóa giỏ hàng.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — `API02-AI-014` ghi nhận checkout hoàn tất thành công.
- `NEWMAN_ASSERTION_FAILED: NO` — Newman là execution-context evidence.
- `EXTERNAL_VERIFICATION_USED: YES` — postcheck ghi nhận giỏ hàng chính còn `2` dòng và giỏ hàng thứ hai còn `1` dòng.
- `PRIMARY_FAILURE_EVIDENCE: EXTERNAL_STATE`.

## Mức độ ảnh hưởng

Các sản phẩm đã mua vẫn nằm trong giỏ hàng, có thể gây checkout trùng lặp, gây nhầm lẫn cho người dùng và tạo trạng thái giỏ hàng/đơn hàng không nhất quán.

## Mức độ nghiêm trọng

**Trung bình (Medium)**

Lý do: Lỗi làm hỏng tính toàn vẹn trạng thái checkout và có thể dẫn đến mua hàng trùng lặp ngoài ý muốn, nhưng bằng chứng quan sát được không cho thấy cơ chế xác thực bị vượt qua.

## Test case chính

`API02-AI-014`

## Các test case hỗ trợ

- `API02-AI-002`
- `API02-AI-003`
- `API02-AI-004`
- `API02-AI-005`
- `API02-AI-006`
- `API02-AI-007`
- `API02-AI-010`
- `API02-AI-017`
- `API02-AI-025`
- `API02-AI-026`
- `API02-AI-029`
- `API02-AI-036`
- `API02-AI-037`
- `API02-STU-001` (bằng chứng bổ sung từ `run-002` được ánh xạ vào cùng cụm nguyên nhân gốc)

## Bằng chứng thực thi

- Newman JSON: `test-results/hw06/run-001/newman.json`
- Newman HTML: `test-results/hw06/run-001/newman.html`
- Xác minh bên ngoài: `test-results/hw06/run-001/external-postcheck.newman.json`
- Tổng hợp external verification: `test-results/hw06/run-001/external-verification-results.json`
- Đối chiếu kết quả bổ sung: `test-results/hw06/run-002/case-accounting.json`

## Ảnh minh chứng

- Request/response: `docs/defects/screenshots/DEF-02-A-request-response.png`.
- External/state: `docs/defects/screenshots/DEF-02-B-state-evidence.png`.

## Xác nhận của sinh viên

`CONFIRMED_PRODUCT_DEFECT`
