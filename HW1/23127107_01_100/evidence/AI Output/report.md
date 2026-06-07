# Báo cáo Bài tập HW01: QA/QC Jobs, 20 Defects, Test a Physical Product

**Thông tin sinh viên**
* **Họ và tên:** Nguyễn Huy Quân
* **MSSV:** 23127107
* **Trường:** University of Science, VNU-HCM (HCMUS)

**Các liên kết nộp bài**
* **GitHub Repo (Chứa Artifacts & Issues):** `[Chèn link GitHub của bạn vào đây]`
* **Link Playlist Video Youtube (Unlisted):** `[Chèn link danh sách video thực thi test case vào đây]`

---

## 1. Requirement 1: QA/QC Job Market 2026+ (40 pts)
> [cite_start]**Yêu cầu:** Tìm 10 tin tuyển dụng QA/QC được đăng trong vòng 60 ngày tính đến ngày nộp bài[cite: 18]. [cite_start]Bắt buộc có ít nhất 3 vị trí yêu cầu kỹ năng liên quan đến AI/LLM/Automation-AI[cite: 19]. 

*(Lặp lại format dưới đây cho đủ 10 tin tuyển dụng)*

### Job Posting 1 `[Ghi rõ tên vị trí - Công ty]` *(Ví dụ: AI QA Engineer - TechCorp)*
* [cite_start]**Link tin tuyển dụng:** `[Chèn link]` [cite: 20]
* [cite_start]**Ảnh chụp màn hình (Screenshot):** * `[Chèn hình ảnh có kèm tên tài khoản đăng nhập của bạn ở góc màn hình]` [cite: 20, 22]
* [cite_start]**Mô tả công việc (Job Description):** `[Tóm tắt ngắn gọn]` [cite: 20]
* [cite_start]**Kỹ năng yêu cầu (Required Skills):** `[Liệt kê kỹ năng, đặc biệt nhấn mạnh kỹ năng AI nếu có]` [cite: 20]
* [cite_start]**Mức lương (Salary):** `[Điền mức lương hoặc ghi "Không tiết lộ"]` [cite: 20]
* [cite_start]**Phân tích tác động của AI (AI Impact Analysis):** * `[Viết 1-2 câu phân tích về tác động của AI đối với vị trí này]` [cite: 21]

---

## 2. Requirement 2: 20 Software Defects 2022-2026 (20 pts)
> **Yêu cầu:** Tìm 20 lỗi phần mềm được công bố từ 2022-2026[cite: 25]. Bắt buộc có ít nhất 5 lỗi liên quan đến AI/LLM (hallucination, prompt injection, bias)[cite: 26]. **Mỗi lỗi (kể cả lỗi không phải AI) đều phải chỉ ra 1 điểm mà công cụ AI bị thiên kiến (bias) hoặc bịa đặt (hallucinate) khi nó giải thích về lỗi đó** (Tổng cộng 20 instances)[cite: 28, 29].

*(Lặp lại format dưới đây cho đủ 20 defects)*

### Defect 1: `[Tên lỗi phần mềm]`
* [cite_start]**Nguồn (Source link):** `[Chèn link bài báo/báo cáo]` [cite: 27]
* [cite_start]**Mô tả (Description):** `[Mô tả lỗi]` [cite: 27]
* [cite_start]**Mức độ nghiêm trọng (Severity):** `[Low/Medium/High/Critical]` [cite: 27]
* [cite_start]**Hậu quả (Consequences):** `[Thiệt hại về tiền, dữ liệu, uy tín...]` [cite: 27]
* [cite_start]**Giải pháp (Solution):** `[Cách họ đã khắc phục]` [cite: 27]
* [cite_start]**Phát hiện AI Hallucination/Bias:** `[Trình bày 1 chi tiết mà AI đã bịa đặt hoặc thiên kiến khi bạn yêu cầu nó giải thích về lỗi này]` [cite: 28, 29]

---

## 3. Requirement 3: Test cases for ONE physical product (40 pts)
> [cite_start]**Yêu cầu:** Chọn MỘT thiết bị gia dụng cụ thể (quạt, máy lọc nước, nồi cơm điện...)[cite: 31].

### 3.1. Thông tin thiết bị
* [cite_start]**Hình ảnh thiết bị:** `[Chèn 1 bức ảnh chụp chung THIẾT BỊ + THẺ SINH VIÊN của bạn trong cùng 1 khung hình]` [cite: 32, 67]
* [cite_start]**Thương hiệu:** `[Ví dụ: Panasonic]` [cite: 33]
* [cite_start]**Mẫu mã (Model):** `[Ví dụ: SR-MVN10PRA]` [cite: 33]
* [cite_start]**Năm sản xuất:** `[Ví dụ: 2023]` [cite: 33]
* [cite_start]**Số sê-ri (Serial number):** `[Ghi mã và che 4 ký tự ở giữa, VD: AB12****89]` [cite: 33]

### 3.2. Danh sách Test Cases & Edge Cases
> [cite_start]**Yêu cầu:** Thiết kế tổng cộng 15 test cases[cite: 36, 37]. [cite_start]Trong đó, có ít nhất 3 edge cases mà công cụ AI không thể tìm ra[cite: 39].

* [cite_start]**Link file Excel chứa 15 Test Cases:** `[Chèn link hoặc tham chiếu đến file Excel trong file .zip]` [cite: 84]
* [cite_start]**Các trường thông tin bắt buộc trong file Excel:** Objective, Input, Steps, Expected, Actual, Verdict[cite: 36].

**Phân tích 3 Edge Cases mà AI bỏ sót:**
* [cite_start]**Ảnh chụp màn hình chat AI:** `[Chèn ảnh chứng minh AI không tạo ra các test case này]` [cite: 40]
* [cite_start]**Giải thích:** `[Viết lý do tại sao AI lại bỏ sót các trường hợp kiểm thử biên này]` [cite: 40]

### 3.3. Thực thi và Báo cáo Lỗi (Defects)
> [cite_start]**Yêu cầu:** Thực thi ít nhất 5 test cases, quay video (dưới 60s) có kèm giọng nói thật của bạn[cite: 41, 67]. [cite_start]Đăng lỗi tìm được lên GitHub Issues[cite: 86].

* **Link YouTube Unlisted (5 videos):**
  1. [cite_start]`[Link Video 1]` [cite: 88]
  2. `[Link Video 2]`
  3. `[Link Video 3]`
  4. `[Link Video 4]`
  5. `[Link Video 5]`
* [cite_start]**Link GitHub Issues (Báo cáo $\ge5$ lỗi thực tế):** `[Chèn link dẫn đến trang Issues trên GitHub repo của bạn]` [cite: 86]
* [cite_start]**Ảnh chụp màn hình GitHub Issues:** `[Chèn ảnh chụp trang Issues, phải hiển thị rõ username GitHub của bạn]` [cite: 86]

---

## 4. AI Collaboration Protocol (Bắt buộc)

### 4.1. Sơ đồ tư duy (Mindmap) vai trò QA/QC
* [cite_start]**Sơ đồ tư duy (PNG/Markdown):** `[Chèn hình ảnh hoặc code Mermaid/Markdown Sơ đồ tư duy quy trình ISTQB do AI tạo ra]` [cite: 9, 90]
* [cite_start]**3 Lỗi sai của AI:** `[Chỉ ra và sửa 3 lỗi sai mà AI đã vẽ trong sơ đồ]` [cite: 9]

### 4.2. Phụ lục A: Nhật ký Prompt (Prompt Log)
* [cite_start]**File nhật ký:** Đã đính kèm file `prompt_log.md` (hoặc `.txt`) có chứa mốc thời gian (timestamps) cho mọi prompt đã gửi[cite: 69, 83].

### 4.3. [AI-02] AI Audit Report
> [cite_start]**Yêu cầu:** Mỗi tạo tác (artifact) tạo bởi AI (ví dụ: bộ 15 test cases) phải có một bảng đánh giá 5 phần[cite: 53, 54].

| Item | Content |
| :--- | :--- |
| **(1) Prompt + tool** | [cite_start]`[Toàn bộ câu prompt + Tên công cụ AI (ví dụ: Gemini/ChatGPT) + Thời gian HH:MM dd/mm/yyyy]` [cite: 57] |
| **(2) AI output** | [cite_start]`[Toàn bộ kết quả AI trả về hoặc ảnh chụp màn hình có viền đỏ chú thích - không tóm tắt]` [cite: 57] |
| **(3) Verdict** | [cite_start]`[Đánh giá: VALID / INVALID / INCOMPLETE kèm theo lý do dựa trên tài liệu học hoặc ISTQB]` [cite: 57] |
| **(4) Reasoning** | [cite_start]`[Viết 2-5 câu giải thích, trích dẫn rõ slide bài giảng hoặc phần nào của ISTQB]` [cite: 57] |
| **(5) Student fix** | [cite_start]`[Kết quả đã được bạn sửa lại (Test case/script...) - Highlight hoặc in đậm những gì bạn đã thay đổi]` [cite: 57] |

* [cite_start]**Tổng kết tỷ lệ chính xác của AI:** `[Nêu % VALID, % INVALID, % INCOMPLETE]` [cite: 58]
* [cite_start]**Kết luận:** Khi nào NÊN và KHÔNG NÊN sử dụng AI cho loại công việc này? [cite: 58]

### 4.4. Đánh giá AI (AI Critique)
> [cite_start]**Yêu cầu:** Viết 1 đoạn văn (200 - 300 chữ) đánh giá AI[cite: 59]. 

* `[Đoạn văn của bạn: AI đã làm sai, bị thiên kiến hay thiếu sót ở đâu? Tại sao AI lại không bắt được lỗi đó? [cite_start]Bạn đã học được nguyên tắc gì khi cộng tác với AI trong bài tập này?]` [cite: 60, 61]

### 4.5. Tuyên bố Bắt buộc (Mandatory Disclosure)
> [cite_start]**Yêu cầu:** Copy/Paste chính xác mẫu này và điền thông tin vào ngoặc vuông[cite: 63].

[cite_start]"[Tên các Artifacts, ví dụ: Bộ Test Cases / Danh sách defects] was initially generated by [Tên công cụ AI, ví dụ: Gemini]; I reviewed and modified [Tên phần đã sửa, ví dụ: Section 3.2], added [Tên các phần thêm vào, ví dụ: 3 edge cases, mô tả thiết bị]; [Tên phần tự làm, ví dụ: AI Critique, AI Audit Report] was written entirely by me. The detailed AI Audit Report is attached as Appendix A. I confirm I did not use AI to generate any artifact listed in the prohibited category below." [cite: 63]

---

## 5. Self-Assessment (Tự đánh giá)
> [cite_start]Bảng điểm tự đánh giá dựa trên Rubric[cite: 101, 103].

| No. | Criteria | Grade | Self-Assessed Grade |
| :--- | :--- | :--- | :--- |
| 1 | Job Market 2026+ (10 jobs $\times$ 3 pts + AI Impact) | 40 | `[Điền điểm của bạn: /40]` |
| 2 | Software Defects 2022-2026 (20 defects) | 20 | `[Điền điểm của bạn: /20]` |
| 3 | Physical-product test design (15 TCs + 5 videos) | 25 | `[Điền điểm của bạn: /25]` |
| AI-1 | [AI-02] AI Audit Report (5-section) attached | 8 | `[Điền điểm của bạn: /8]` |
| AI-2 | AI Critique 200-300 words + [AI-03] Disclosure attached | 4 | `[Điền điểm của bạn: /4]` |
| AI-3 | [AI-05] Checklist signed + anti-cheat artifacts | 3 | `[Điền điểm của bạn: /3]` |
| | **Total** | **100** | **`[Tổng điểm tự đánh giá]`** |

---
**Các biểu mẫu đính kèm (Ngoài file này):**
* [cite_start]Chắc chắn rằng bạn đã ký và đính kèm các mẫu trong folder 'AI Templates': **[AI-03] AI Disclosure Form**, **[AI-05] Privacy & Responsible Use Checklist**, và **[AI-06] Student Acknowledgement** (nếu chưa ký ở Tuần 1)[cite: 76, 77, 78, 95, 96].
* [cite_start]Đảm bảo tên file zip khi nộp là: `23127107_HW01_AI_<Điểm_tự_đánh_giá>.zip`[cite: 80].