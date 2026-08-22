# [HW06][DEF-03] Checkout không bắt buộc đúng Bearer authorization scheme

## Mã lỗi

DEF-03

## Cụm nguyên nhân gốc

RC-02-03

## API / Endpoint

`POST /api/checkout`

## Yêu cầu liên quan

- `API02-REQ-002`: Các API giỏ hàng và đơn hàng yêu cầu `Authorization: Bearer <token>`.
- `API02-REQ-010`: Các API nhạy cảm yêu cầu JWT hợp lệ.

## Môi trường kiểm thử

- Hệ thống: EShop chạy cục bộ
- Base URL: `http://localhost:3000`
- Newman: `6.2.2`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Lần chạy kiểm thử: `run-001`

## Điều kiện tiên quyết

1. Một người dùng dùng một lần đã xác thực có JWT hợp lệ và có sản phẩm trong giỏ hàng.
2. Request có `X-Student-Id`.
3. JWT hợp lệ được cố ý đặt dưới một authorization scheme không phải Bearer.

## Các bước tái hiện

1. Lấy JWT hợp lệ của người dùng.
2. Gửi `POST /api/checkout` với `Authorization: Basic <valid-JWT>` thay vì Bearer scheme bắt buộc.
3. Quan sát xem request có thực hiện thành công việc tạo đơn hàng hay không.

## Kết quả mong đợi

Checkout yêu cầu người dùng đã xác thực gửi JWT hợp lệ qua Bearer authorization scheme bắt buộc; authorization header sử dụng scheme khác phải bị từ chối.

## Kết quả thực tế

Request sử dụng Basic scheme vẫn hoàn tất checkout thành công. Luồng xác thực quan sát được chấp nhận giá trị token mà không enforce Bearer scheme đã được tài liệu hóa.

Evidence chỉ chứng minh scheme không được enforce vì request vẫn có JWT hợp lệ; issue này không tuyên bố endpoint hoàn toàn không xác thực người dùng.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — request dùng `Authorization: Basic <valid-JWT>` và nhận HTTP `200`, `Checkout successful`.
- `NEWMAN_ASSERTION_FAILED: NO` — request/response là defect evidence trực tiếp, không phải assertion failure.
- `EXTERNAL_VERIFICATION_USED: NO`.
- `PRIMARY_FAILURE_EVIDENCE: NEWMAN_REQUEST_RESPONSE`.

## Mức độ ảnh hưởng

Endpoint chấp nhận thông tin xác thực dưới một scheme ngoài dự kiến, làm suy yếu ranh giới xác thực đã được tài liệu hóa và tăng rủi ro bảo mật/tích hợp.

## Mức độ nghiêm trọng

**Trung bình (Medium)**

Lý do: Yêu cầu về authorization scheme bị vượt qua, mặc dù request quan sát được vẫn chứa JWT hợp lệ về mặt mật mã.

## Test case chính

`API02-AI-022`

## Các test case hỗ trợ

- Không có.

## Bằng chứng thực thi

- Newman JSON: `test-results/hw06/run-001/newman.json`
- Newman HTML: `test-results/hw06/run-001/newman.html`
- Đối chiếu kết quả: `test-results/hw06/run-001/case-accounting.json`

## Ảnh minh chứng

`docs/defects/screenshots/DEF-03-A-request-response.png`.

## Xác nhận của sinh viên

`CONFIRMED_PRODUCT_DEFECT`
