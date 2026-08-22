# AI Critique — HW06 API Testing

AI hỗ trợ HW06 chủ yếu ở ba lớp: phân rã specification của ba API, sinh các candidate test có stable ID theo domain/boundary/state/security/schema/business rule, và tổng hợp traceability sang Postman/Newman artifacts. Giá trị thực tế là giảm thời gian bao phủ các partition và chỉ ra các phụ thuộc state như cart, reset token, quyền Admin và persistence. Tuy nhiên, Human Audit đã phải sửa hoặc chặn các candidate không thể dùng ngay: ví dụ các case có expectation suy ra từ implementation thay vì requirement được đánh dấu `INCOMPLETE`/`INVALID`, và các testcase password/OTP không có fixture hợp lệ không được biến thành kết luận Product Defect.

Hai run thật cho thấy một giới hạn quan trọng: `run-001` và `run-002` đều có Newman assertion failures bằng `0`, nhưng vẫn xác nhận chín Product Defect. Newman ở đây chứng minh request/response đã diễn ra; nó không tự là business oracle. Với `DEF-01`, HTTP `200` chỉ cho thấy checkout chạy, còn mismatch giữa `total_amount = 1` đã lưu và cart total `400000` mới là bằng chứng quyết định. Tương tự, DEF-04–DEF-09 cần SQLite read-only hoặc external post-state để xác nhận persistence/side effect.

Nếu tin output AI mà không Human review, có thể nhầm response thành đúng business behavior, ghi lộ token/password, tách một root cause thành nhiều issue, hoặc báo sai “Newman test failed”. Vì vậy AI hữu ích nhất như trợ lý tạo cấu trúc, tìm coverage gap và chuẩn bị evidence an toàn; Human vẫn phải xác nhận requirement, oracle, snapshot state, screenshot, diagram và quyết định submit.

