# AI Disclosure Form

**Document owner:** Nguyễn Huy Quân

**Name:** Nguyễn Huy Quân

**Student ID:** 23127107   

**Course:** CS423 / CSC15003 — SOFTWARE TESTING

**Date:** 07/06/2026

---

## Purpose
Ai giúp cho việc làm bài trở nên nhanh gọn. Nhưng mà chúng ta cũng phải lường đến các trường hợp chúng ta đưa thiết dữ liệu, khiến cho AI bị hiểu sai, hiểu thiếu đối với câu hỏi của chúng ta. Đồng thời, cũng phải kiểm soát và kiểm tra lại các output của AI một cách toàn diện. 

## AI Usage Summary

| Item | Details |
| :--- | :--- |
| **Tool name & version** | Gemini 3.1 Pro; Claude Sonnet 4.6; Claude code Opus 4.8 |
| **Provider** | Google (Gemini); Anthropic (Claude Sonnet, Claude code Opus) |
| **Timestamp(s)** | 2023-10-10 14:30 (Artifact 4); 05/06/2026 22:00 (Artifact 1); 06/06/2026 15:00 (Artifact 2); 07/06/2026 15:36 (Artifact 5). (Một số tương tác không có timestamp rõ ràng trong báo cáo.) |
| **Input (prompt)** | Tóm tắt: tạo template báo cáo (.md) từ đề bài HW01; vẽ sơ đồ tư duy ISTQB bằng Mermaid; thiết kế 15 test cases cho nồi cơm điện; tìm 20 lỗi phần mềm (2022–2026); viết báo cáo cho requirement 2. (Xem AI_Audit_Report.md để tham chiếu prompt đầy đủ.) |
| **Output (summary)** | 1) Template báo cáo Markdown hoàn chỉnh. 2) Sơ đồ tư duy ISTQB (Mermaid) đã sinh — cần chỉnh về ghi chú Monitoring & Control. 3) Bộ 15 test cases cho nồi cơm điện (đầy đủ). 4) Danh sách 20 lỗi phần mềm (có vài URL hỏng). 5) Báo cáo cho requirement 2 (file đính kèm trong evidence). |
| **User edits / post-processing** | - Chỉnh sửa lại format báo cáo (xóa các cite không cần thiết, tách phần `AI Collaboration Protocol` ra file riêng). - Sửa sơ đồ tư duy: làm rõ `Test Monitoring` vs `Test Control` là hoạt động song song xuyên suốt, tách `Confirmation Testing` và `Regression Testing`. - Sửa mục `Test Completion` (thêm "Đóng incident report" và chỉnh đối tượng bàn giao). - Xác minh và cập nhật các URL hỏng trong Artifact 4; giữ nguyên 15 test cases. |
| **Data used (sensitive?)** | No — không sử dụng dữ liệu cá nhân nhạy cảm trong các prompts hoặc outputs được báo cáo. |
| **Risk assessment** | Một số output chứa lỗi thực tế hoặc thiếu chính xác (ví dụ: sơ đồ mindmap đặt sai bản chất của "Test Monitoring & Control"; một số đường link trong danh sách lỗi bị chết). Có rủi ro hallucination khi AI sinh các URL hoặc trích dẫn không tồn tại. |
| **Mitigation actions** | Manual verification and fixes: đã chỉnh sửa nội dung không chính xác theo ghi chú trong AI_Audit_Report.md, đã xác minh và sửa các URL hỏng, tách/ổn định format, và duyệt lại đầu vào/đầu ra trước khi nộp. Các artifact đã được điều chỉnh và lưu trong `evidence/AI Output/` theo báo cáo kiểm toán.

---

## Affirmation
I confirm that the AI outputs included in this deliverable have been reviewed and verified to the best of my ability.

**Name:** Nguyễn Huy Quân

**Signature:** Nguyễn Huy Quân

**Date:**07/06/2026

