# 🧪 Quy Trình Kiểm Thử Cơ Bản ISTQB

> Sơ đồ tư duy mô tả **ISTQB Fundamental Test Process** — bao gồm 5 giai đoạn chính từ lập kế hoạch đến kết thúc kiểm thử.

---

```mermaid
mindmap
  root((🧪 ISTQB<br/>Fundamental<br/>Test Process))

    (1️⃣ Test Planning<br/>Lập Kế Hoạch Kiểm Thử)
      Xác định phạm vi kiểm thử
        Mục tiêu kiểm thử
        Phạm vi trong và ngoài
      Phân tích rủi ro
        Rủi ro sản phẩm
        Rủi ro dự án
      Xác định nguồn lực
        Nhân lực
        Công cụ và môi trường
        Thời gian và ngân sách
      Lịch trình kiểm thử
        Ưu tiên test case
        Mốc thời gian
      Tiêu chí bắt đầu & kết thúc
        Entry criteria
        Exit criteria

    (2️⃣ Test Monitoring & Control<br/>Giám Sát và Kiểm Soát)
      Theo dõi tiến độ
        Số test case thực thi
        Tỷ lệ pass/fail
        Độ phủ kiểm thử
      Đo lường chỉ số
        Defect density
        Test execution rate
        Coverage metrics
      Báo cáo kiểm thử
        Test progress report
        Test summary report
      Hành động điều chỉnh
        Điều chỉnh kế hoạch
        Tái phân bổ nguồn lực

    (3️⃣ Test Analysis<br/>Phân Tích Kiểm Thử)
      Xem xét test basis
        Yêu cầu phần mềm SRS
        Thiết kế hệ thống
        Use case & user story
        Code và kiến trúc
      Xác định điều kiện kiểm thử
        Điều kiện kiểm thử chức năng
        Điều kiện kiểm thử phi chức năng
      Phân tích testability
        Tính có thể kiểm thử
        Xác định rủi ro chất lượng
      Ưu tiên điều kiện kiểm thử
        Dựa trên mức độ rủi ro
        Dựa trên mức độ quan trọng

    (4️⃣ Test Design<br/>Thiết Kế Kiểm Thử)
      Kỹ thuật kiểm thử hộp đen
        Equivalence Partitioning
        Boundary Value Analysis
        Decision Table
        State Transition
        Use Case Testing
      Kỹ thuật kiểm thử hộp trắng
        Statement Coverage
        Branch Coverage
        Path Coverage
      Kỹ thuật dựa trên kinh nghiệm
        Error Guessing
        Exploratory Testing
        Checklist-based Testing
      Thiết kế test case
        Test case ID và mô tả
        Điều kiện tiên quyết
        Bước thực hiện
        Kết quả mong đợi
      Thiết kế test data
        Dữ liệu hợp lệ
        Dữ liệu không hợp lệ
        Dữ liệu biên

    (5️⃣ Test Implementation<br/>Triển Khai Kiểm Thử)
      Xây dựng test suite
        Sắp xếp thứ tự test case
        Nhóm test case theo chức năng
      Chuẩn bị môi trường kiểm thử
        Cài đặt phần mềm cần test
        Cấu hình test environment
        Chuẩn bị dữ liệu kiểm thử
      Chuẩn bị công cụ kiểm thử
        Test management tools
        Automation tools
        Defect tracking tools
      Xác minh test environment
        Smoke test môi trường
        Kiểm tra công cụ hoạt động

    (6️⃣ Test Execution<br/>Thực Thi Kiểm Thử)
      Chạy test case
        Thực thi thủ công
        Thực thi tự động
      Ghi nhận kết quả
        Kết quả pass/fail
        Log thực thi
        Screenshots và evidence
      So sánh kết quả thực tế vs mong đợi
        Phân tích sai lệch
        Xác nhận lỗi
      Báo cáo lỗi
        Mô tả lỗi rõ ràng
        Mức độ nghiêm trọng Severity
        Mức độ ưu tiên Priority
        Bước tái hiện lỗi
      Regression testing
        Re-test sau khi fix lỗi
        Kiểm tra tác động lan truyền

    (7️⃣ Test Completion<br/>Hoàn Thành Kiểm Thử)
      Kiểm tra tiêu chí kết thúc
        Đã đạt exit criteria chưa
        Xử lý các lỗi còn tồn đọng
      Lưu trữ tài liệu
        Test cases và test data
        Test logs và reports
        Defect reports
      Bàn giao sản phẩm kiểm thử
        Tóm tắt kết quả cho stakeholders
        Đề xuất rủi ro còn lại
      Bài học kinh nghiệm
        Lessons learned
        Cải tiến quy trình
      Giải phóng tài nguyên
        Môi trường kiểm thử
        Nhân lực và công cụ
```

---

## 📋 Tóm Tắt Các Giai Đoạn

| # | Giai Đoạn | Mục Tiêu Chính |
|---|-----------|----------------|
| 1 | **Test Planning** | Xác định phạm vi, nguồn lực, lịch trình và tiêu chí kiểm thử |
| 2 | **Test Monitoring & Control** | Theo dõi tiến độ và điều chỉnh kế hoạch kịp thời |
| 3 | **Test Analysis** | Phân tích yêu cầu để xác định *cần kiểm thử cái gì* |
| 4 | **Test Design** | Thiết kế test case và test data — *kiểm thử như thế nào* |
| 5 | **Test Implementation** | Chuẩn bị môi trường, dữ liệu và công cụ thực thi |
| 6 | **Test Execution** | Chạy kiểm thử, ghi nhận kết quả và báo cáo lỗi |
| 7 | **Test Completion** | Đánh giá hoàn tất, lưu trữ tài liệu và rút kinh nghiệm |

> 💡 **Lưu ý:** Theo ISTQB, **Test Monitoring & Control** là hoạt động diễn ra **xuyên suốt** toàn bộ quy trình, không phải chỉ ở một giai đoạn riêng lẻ.




