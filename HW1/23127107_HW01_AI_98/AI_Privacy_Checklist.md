# AI Privacy Checklist

**Owner:** Nguyễn Huy Quân

**Project / Assignment:** Homework 01 - Software testing

**Date:** 07/06/2026

---

Purpose: Ensure personal and sensitive data is handled appropriately when using AI tools.

## Checklist

- [x] Data classification: Identify personal, sensitive, and public data.
- [x] Data minimization: Only include the minimum necessary data in prompts.
- [x] Consent obtained: Confirm any required consents are documented.
- [x] Anonymization / pseudonymization: Remove or mask direct identifiers.
- [x] Avoid sharing secrets: Do not include passwords, keys, or PII in prompts.
- [x] Storage controls: Record where AI outputs and inputs are stored and who has access.
- [x] Access control: Ensure only authorized personnel can view sensitive outputs.
- [x] Retention policy: Define retention period and deletion rules for AI artifacts.
- [x] Third-party sharing: Document any sharing with external services or providers.
- [x] Model governance: Note model version and provider; track updates and audits.
- [x] Verification: Validate AI outputs for accuracy before use.
- [x] Incident response: Define steps to take if a privacy issue is discovered.

## Notes / Findings

- Data classification: Dữ liệu sử dụng cho bài tập này chỉ là thông tin học thuật và nội dung mô tả bài tập; không chứa thông tin cá nhân nhạy cảm (PII). Nếu cần đưa dữ liệu thật có PII, phải phân loại và xin phép trước.
- Data minimization: Chỉ gửi cho AI phần thông tin tối thiểu cần thiết để hoàn thành tác vụ (tóm tắt requirement, không gửi toàn bộ dữ liệu thô nếu không cần thiết).
- Consent obtained: Hiện không có dữ liệu người thật hay nhạy cảm; nếu có, cần thu consent bằng văn bản trước khi đưa vào prompt.
- Anonymization / pseudonymization: Trước khi gửi dữ liệu thực, thay thế tên, mã số sinh viên, email bằng mã giả (ví dụ STUDENT_01) để giảm rủi ro rò rỉ.
- Avoid sharing secrets: Tuyệt đối không chèn mật khẩu, khóa API, token, thông tin thẻ ngân hàng hoặc các bí mật khác vào prompt hoặc output được lưu trữ.
- Storage controls: Tất cả input và output AI liên quan đã/ sẽ được lưu trong thư mục `evidence/AI Output/` trong workspace; quyền truy cập giới hạn cho chủ sở hữu dự án.
- Access control: Kiểm tra quyền chia sẻ repository và file trước khi công khai; chỉ chia sẻ artifacts với giảng viên hoặc nhóm khi cần thiết.
- Retention policy: Giữ dữ liệu thô tối đa 12 tháng cho mục đích đánh giá và backup; sau đó xóa hoặc lưu trữ bản tóm tắt đã loại bỏ dữ liệu nhạy cảm.
- Third-party sharing: Khi chia sẻ với nhà cung cấp AI (ví dụ Gemini, Claude), đã liệt kê nhà cung cấp trong báo cáo kiểm toán; không chia sẻ dữ liệu nhạy cảm với bên thứ ba.
- Model governance: Ghi rõ model và phiên bản, provider và timestamp trong `AI_Audit_Report.md` và `AI_Disclosure_Form.md` để phục vụ truy xuất và kiểm toán.
- Verification: Tất cả outputs từ AI phải được kiểm chứng thủ công; đã xác minh và sửa các lỗi đã phát hiện (ví dụ sửa mindmap ISTQB, cập nhật URL hỏng trong Artifact 4).
- Incident response: Nếu phát hiện rò rỉ dữ liệu hoặc lỗi lớn, dừng chia sẻ ngay lập tức, thông báo giảng viên và xóa dữ liệu nhạy cảm theo chính sách; ghi lại sự cố và các bước xử lý.

---

**Prepared by:** Nguyễn Huy Quân

**Signature:** Nguyễn Huy Quân

**Date:** 07/06/2026
