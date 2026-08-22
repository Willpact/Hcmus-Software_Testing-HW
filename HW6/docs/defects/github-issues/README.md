# Chỉ mục bản nháp GitHub Issue của HW06

Đúng 38 bản ghi bằng chứng test case được ánh xạ vào chín lỗi gốc đã được sinh viên xác nhận dưới đây. Mỗi lỗi gốc có đúng một bản nháp GitHub Issue; các test case thất bại được giữ làm bằng chứng chính/hỗ trợ và không bị tách thành các issue trùng lặp.

| Mã lỗi | Cụm nguyên nhân gốc | Tiêu đề | Test case chính | Lần chạy | Issue draft | Trạng thái ảnh | Trạng thái xác nhận |
| --- | --- | --- | --- | --- | --- | --- | --- |
| DEF-01 | RC-02-01 | Checkout tin tưởng giá trị tổng tiền do client gửi lên | API02-AI-002 | run-001 | [DEF-01-github-issue.md](DEF-01-github-issue.md) | CAPTURED_GENUINE_WINDOWS_TERMINAL | CONFIRMED_PRODUCT_DEFECT |
| DEF-02 | RC-02-02 | Giỏ hàng không được xóa sau khi checkout thành công | API02-AI-014 | run-001 | [DEF-02-github-issue.md](DEF-02-github-issue.md) | CAPTURED_GENUINE_WINDOWS_TERMINAL | CONFIRMED_PRODUCT_DEFECT |
| DEF-03 | RC-02-03 | Checkout không bắt buộc đúng Bearer authorization scheme | API02-AI-022 | run-001 | [DEF-03-github-issue.md](DEF-03-github-issue.md) | CAPTURED_GENUINE_WINDOWS_TERMINAL | CONFIRMED_PRODUCT_DEFECT |
| DEF-04 | RC-03-01 | Import sản phẩm chấp nhận giá không dương | API03-AI-009 | run-001 | [DEF-04-github-issue.md](DEF-04-github-issue.md) | CAPTURED_GENUINE_WINDOWS_TERMINAL | CONFIRMED_PRODUCT_DEFECT |
| DEF-05 | RC-03-02 | Import sản phẩm không đảm bảo tính nguyên tử | API03-AI-017 | run-001 | [DEF-05-github-issue.md](DEF-05-github-issue.md) | CAPTURED_GENUINE_WINDOWS_TERMINAL | CONFIRMED_PRODUCT_DEFECT |
| DEF-06 | RC-03-03 | API import sản phẩm không kiểm tra quyền Admin | API03-AI-026 | run-001 | [DEF-06-github-issue.md](DEF-06-github-issue.md) | CAPTURED_GENUINE_WINDOWS_TERMINAL | CONFIRMED_PRODUCT_DEFECT |
| DEF-07 | RC-01-N01 | Reset mật khẩu vẫn thành công khi thiếu mật khẩu mới | API01-AI-007 | run-002 | [DEF-07-github-issue.md](DEF-07-github-issue.md) | CAPTURED_GENUINE_WINDOWS_TERMINAL | CONFIRMED_PRODUCT_DEFECT |
| DEF-08 | RC-01-N02 | Quy tắc độ mạnh mật khẩu không được kiểm tra khi reset | API01-AI-018 | run-002 | [DEF-08-github-issue.md](DEF-08-github-issue.md) | CAPTURED_GENUINE_WINDOWS_TERMINAL | CONFIRMED_PRODUCT_DEFECT |
| DEF-09 | RC-01-N03 | Mật khẩu mới được lưu dưới dạng plaintext | API01-AI-035 | run-002 | [DEF-09-github-issue.md](DEF-09-github-issue.md) | CAPTURED_GENUINE_WINDOWS_TERMINAL | CONFIRMED_PRODUCT_DEFECT |

- Tổng số lỗi sản phẩm đã xác nhận: `9`
- Bản nháp GitHub Issue: `9/9`
- Phương thức chụp ảnh: `GENUINE_WINDOWS_TERMINAL_NATIVE_CAPTURE`.
- Evidence đã capture: `17` ảnh thật (`9` request/response; `8` external/state); xem `../evidence-capture-result.md`.
- Workflow nội dung có bị ảnh chặn hay không: `NO`
- Số GitHub Issue đã tạo: `0` tại thời điểm cập nhật index này; xem `../github-issue-readiness.md` để biết trạng thái online hiện tại.
- `API01-AI-016`: `EXCLUDED — BLOCKED_TEST_DATA / LEGITIMATE_EXPIRED_OTP_FIXTURE_UNAVAILABLE / PRODUCT_INFERENCE: NO`
