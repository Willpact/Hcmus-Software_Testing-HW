# DEF-08 — Quy tắc độ mạnh mật khẩu không được kiểm tra khi reset

- Mã lỗi: `DEF-08`
- Tên kỹ thuật: `RESET_PASSWORD_STRENGTH_RULE_NOT_ENFORCED`
- API: `POST /api/reset-password`
- Yêu cầu liên quan: `API01-REQ-005`, `API01-REQ-009`
- Cụm nguyên nhân gốc: `RC-01-N02`
- Test case chính: `API01-AI-018`
- Các test case hỗ trợ: `[API01-AI-009, API01-AI-021, API01-AI-022, API01-AI-023, API01-AI-024, API01-STU-002]`
- Lần chạy kiểm thử: `run-002`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Xác nhận của sinh viên: `CONFIRMED_PRODUCT_DEFECT`

## Yêu cầu liên quan

Quy tắc có thẩm quyền đã được phê duyệt yêu cầu mật khẩu mới có tối thiểu 8 ký tự và chứa chữ hoa, chữ thường, chữ số cùng ký tự đặc biệt được phép. Lỗi chính sách mật khẩu không được coi là reset thành công hoặc làm OTP bị tiêu thụ như một lần sử dụng thành công.

## Môi trường kiểm thử

Backend EShop Node/Express chạy cục bộ tại `http://localhost:3000`, cơ sở dữ liệu SQLite ghi được và dành riêng cho lần chạy kiểm thử, Newman `6.2.2` và các người dùng reset dùng một lần theo từng test case.

## Điều kiện tiên quyết

1. Đăng ký một người dùng dùng một lần trong môi trường cô lập cho từng phân vùng kiểm thử.
2. Cấp OTP mới gắn với email ngay trước mỗi test case.
3. Giữ mọi input reset hợp lệ, ngoại trừ đúng phân vùng độ mạnh mật khẩu đang được kiểm tra.

## Các bước tái hiện

1. Gửi request reset với mật khẩu ngắn hơn 8 ký tự nhưng vẫn giữ các nhóm ký tự bắt buộc còn lại.
2. Lặp lại độc lập với các giá trị lần lượt thiếu chữ hoa, chữ thường, chữ số hoặc ký tự đặc biệt được phép.
3. Với test case theo trình tự, gửi mật khẩu yếu rồi thử lại bằng mật khẩu tuân thủ quy tắc với cùng OTP.
4. Kiểm tra trạng thái mật khẩu/token sau reset trong từng môi trường cô lập mà không ghi lại giá trị mật khẩu.

## Kết quả mong đợi

Mọi phân vùng mật khẩu yếu phải bị từ chối ở mức quy tắc nghiệp vụ, trạng thái mật khẩu trước đó phải giữ nguyên và OTP vẫn dùng được sau lỗi validation. Không khẳng định HTTP status hoặc response schema cụ thể.

## Kết quả thực tế

Sáu phân vùng mật khẩu yếu dạng single-action hoàn tất với response thành công và làm thay đổi trạng thái người dùng tương ứng. Trong `API01-STU-002`, lần thử mật khẩu yếu hoàn tất và tiêu thụ OTP; lần thử lại bằng mật khẩu mạnh với cùng OTP sau đó thất bại. Bảy test case này đại diện cho một họ lỗi validation độ mạnh mật khẩu, không phải bảy lỗi riêng biệt.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — primary case `API01-AI-018` dùng mật khẩu dài `4` ký tự, thiếu chữ hoa, chữ số và ký tự đặc biệt nhưng nhận HTTP `200` với thông báo `Password reset successfully`.
- `NEWMAN_ASSERTION_FAILED: NO` — request/response thật cho thấy chính sách mật khẩu không được enforce; runner không ghi nhận assertion thất bại.
- `EXTERNAL_VERIFICATION_USED: YES` — state evidence ghi nhãn an toàn `WEAK_PLAINTEXT`, database thay đổi và reset token bị tiêu thụ mà không log giá trị mật khẩu.
- `PRIMARY_FAILURE_EVIDENCE: BOTH` — Newman chứng minh mật khẩu yếu được chấp nhận; external state xác nhận thay đổi persisted.

## Mức độ ảnh hưởng

Người dùng có thể đặt mật khẩu vi phạm chính sách độ mạnh bắt buộc, làm giảm khả năng chống tấn công vào thông tin xác thực. Một lần thử mật khẩu yếu cũng có thể tiêu thụ token khôi phục và ngăn lần thử sửa đúng dự kiến.

## Mức độ nghiêm trọng đề xuất

**Cao (High)**

Hành vi này làm suy yếu lâu dài bảo mật thông tin xác thực trên mọi chiều của quy tắc độ mạnh bắt buộc. Kết luận không khẳng định việc tài khoản đã bị xâm phạm ngoài phạm vi bypass chính sách quan sát được.

## Đường dẫn bằng chứng

- `test-results/hw06/run-002/newman.json` — response reset mật khẩu yếu thật của `API01-AI-018`.
- `test-results/hw06/run-002/case-accounting.json` — bảy bản ghi FAIL được ánh xạ vào `RC-01-N02`.
- `test-results/hw06/run-002/external-hook-evidence.json` — thay đổi trạng thái cô lập, token không còn tồn tại và nhãn trạng thái an toàn `WEAK_PLAINTEXT` không chứa giá trị mật khẩu.
- `docs/requirement-analysis/api-01-reset-password.md` — quy tắc độ mạnh có thẩm quyền chính xác.

## Ảnh minh chứng

- Request/response execution: `docs/defects/screenshots/DEF-08-A-request-response.png`.
- External/state: `docs/defects/screenshots/DEF-08-B-state-evidence.png`.
