# DEF-03 — Checkout không bắt buộc đúng Bearer authorization scheme

- Mã lỗi: `DEF-03`
- Tên kỹ thuật: `AUTHORIZATION_SCHEME_NOT_ENFORCED`
- API: `POST /api/checkout`
- Yêu cầu liên quan: `API02-REQ-002`, `API02-REQ-010`
- Cụm nguyên nhân gốc: `RC-02-03`
- Test case chính: `API02-AI-022`
- Các test case hỗ trợ: `[]`
- Lần chạy kiểm thử: `run-001`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Xác nhận của sinh viên: `CONFIRMED_PRODUCT_DEFECT`

## Môi trường kiểm thử

Backend EShop Node/Express chạy cục bộ tại `http://localhost:3000`, cơ sở dữ liệu SQLite ghi được và dành riêng cho lần chạy kiểm thử, cùng Newman `6.2.2`.

## Điều kiện tiên quyết

1. Một người dùng dùng một lần có JWT hợp lệ và có sản phẩm trong giỏ hàng.
2. JWT được cố ý đặt dưới một authorization scheme không phải Bearer.
3. Request có `X-Student-Id`.

## Các bước tái hiện

1. Lấy JWT hợp lệ của người dùng.
2. Gửi request checkout với `Authorization: Basic <valid-JWT>` thay vì Bearer scheme bắt buộc.
3. Quan sát xem request có thực hiện thành công việc tạo đơn hàng hay không.

## Kết quả mong đợi

Checkout phải từ chối authorization header không sử dụng Bearer JWT scheme theo yêu cầu. Kết quả mong đợi không khẳng định rằng JWT vắng mặt, mà kiểm tra việc enforce đúng scheme đã được quy định.

## Kết quả thực tế

Request sử dụng Basic scheme vẫn hoàn tất checkout thành công vì luồng xác thực lấy giá trị thứ hai được phân tách bằng khoảng trắng mà không enforce scheme.

Evidence chỉ chứng minh authorization scheme không được enforce: request vẫn mang một JWT hợp lệ. Evidence không chứng minh endpoint hoàn toàn không xác thực người dùng.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — `API02-AI-022` ghi nhận `Authorization: Basic <valid-JWT>` và HTTP `200` với thông báo `Checkout successful`.
- `NEWMAN_ASSERTION_FAILED: NO` — không có assertion thất bại; request/response quan sát được chính là bằng chứng hành vi nghiệp vụ sai.
- `EXTERNAL_VERIFICATION_USED: NO` — không cần state oracle bên ngoài để chứng minh scheme sai vẫn được chấp nhận.
- `PRIMARY_FAILURE_EVIDENCE: NEWMAN_REQUEST_RESPONSE`.

## Mức độ ảnh hưởng

Endpoint chấp nhận thông tin xác thực dưới một scheme ngoài dự kiến, làm suy yếu hợp đồng xác thực đã được tài liệu hóa và tăng rủi ro tại ranh giới tích hợp/bảo mật.

## Mức độ nghiêm trọng đề xuất

**Trung bình (Medium)**

Yêu cầu về scheme bị vượt qua, mặc dù request quan sát được vẫn sử dụng JWT hợp lệ về mặt mật mã.

## Đường dẫn bằng chứng

- `test-results/hw06/run-001/newman.json`
- `test-results/hw06/run-001/case-accounting.json`
- `docs/execution-results/human-failure-triage-packet.md`

## Ảnh minh chứng

`docs/defects/screenshots/DEF-03-A-request-response.png` — case ID, Basic scheme đã che credential, HTTP `200` và thông báo thành công.
