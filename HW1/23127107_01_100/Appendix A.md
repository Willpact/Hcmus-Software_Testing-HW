# Prompt Log

**Owner:** Nguyễn Huy Quân  
**Student ID:** 23127107  
**Course:** CS423 / CSC15003 — SOFTWARE TESTING  
**Generated from:** `AI_Audit_Report.md`  
**Date compiled:** 07/06/2026

---

## Session 1 - Artifact 1
- **Timestamp:** 05/06/2026 22:04
- **Tool:** Gemini 3.1 Pro
- **Prompt:**

```text
Hãy dựa vào file bài tập giúp tôi tạo ra một format cho bài report bằng md và sử dụng ngôn ngữ tiếng việt ( đính kèm file bài tập HW01)
```

- **AI Output:**

```text
Dưới đây là template Markdown (.md) chi tiết cho bài báo cáo của bạn, được cấu trúc dựa trên các yêu cầu bắt buộc và quy định chấm điểm từ file bài tập.  Bạn có thể copy toàn bộ nội dung bên dưới và dán vào file .md của mình. [file đính kèm.](<./evidence/AI Output/report.md>)
```

---

## Session 2 - Artifact 2
- **Timestamp:** 06/06/2026 14:54
- **Tool:** Claude Sonnet 4.6
- **Prompt:**

```text
Hãy vẽ cho tôi một sơ đồ tư duy (mindmap) bằng định dạng mã Mermaid đưa nó vô một file markdown mô tả Quy trình kiểm thử cơ bản của ISTQB (ISTQB Fundamental Test Process). Hãy tự điền các bước và các hoạt động con bên trong.
```

- **AI Output:**

```text
File markdown đã được tạo xong! Đây là những gì có trong sơ đồ tư duy:

**7 giai đoạn chính** được mô tả đầy đủ:

1. **Test Planning** — Xác định phạm vi, phân tích rủi ro, nguồn lực, lịch trình và tiêu chí entry/exit
2. **Test Monitoring & Control** — Theo dõi tiến độ, đo lường chỉ số, báo cáo và điều chỉnh kế hoạch
3. **Test Analysis** — Phân tích test basis (SRS, use case, code...), xác định điều kiện kiểm thử
4. **Test Design** — Kỹ thuật hộp đen, hộp trắng, kinh nghiệm; thiết kế test case và test data
5. **Test Implementation** — Chuẩn bị môi trường, công cụ, test suite và dữ liệu
6. **Test Execution** — Thực thi, ghi nhận kết quả, báo cáo lỗi và regression testing
7. **Test Completion** — Kiểm tra exit criteria, lưu trữ tài liệu, bàn giao và lessons learned

> 💡 **Lưu ý quan trọng theo ISTQB:** *Test Monitoring & Control* là hoạt động diễn ra **xuyên suốt** toàn bộ quy trình, không phải một bước tuần tự đơn thuần.
[link đính kèm](./evidence/AI Output/ISTQB_Fundamental_Test_Process.md)

```

---

## Session 3 - Artifact 3
- **Timestamp:** 06/06/2026 15:38
- **Tool:** Gemini 3.1 Pro
- **Prompt:**

```text
Hãy thiết kế 15 test cases (Mục tiêu / Đầu vào / Các bước / Kết quả mong đợi / Kết quả thực tế / Kết luận) hàng gia dụng vật lý là chiếc nồi cơm điện.
```

- **AI Output:**

```text
# Kịch Bản Kiểm Thử (Test Cases) - Nồi Cơm Điện

Dưới đây là bộ 15 kịch bản kiểm thử dành cho sản phẩm nồi cơm điện, bao gồm kiểm tra chức năng, độ an toàn, hiệu năng và các trường hợp ngoại lệ.

| ID | Mục tiêu kiểm thử | Đầu vào (Input) | Các bước thực hiện | Kết quả mong đợi | KQ Thực tế | Kết luận |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **TC01** | Kiểm tra cấp nguồn | Nguồn điện 220V, nồi cơm. | 1. Cắm phích cắm vào ổ điện.<br>2. Quan sát đèn báo. | Đèn báo ở chế độ "Giữ ấm" (Warm) sáng lên. Không có tiếng nổ hay tia lửa điện. | *[Chờ test]* | *[Pending]* |
| **TC02** | Kiểm tra chức năng nấu cơ bản | 2 lon gạo, nước (đúng vạch định mức). | 1. Đặt lòng nồi đã có gạo/nước vào vỏ.<br>2. Đóng nắp.<br>3. Gạt công tắc xuống "Nấu" (Cook). | Công tắc giữ cố định ở vị trí "Nấu", đèn báo "Nấu" sáng. | *[Chờ test]* | *[Pending]* |
| **TC03** | Tự động chuyển chế độ | Cơm vừa cạn nước và chín (Từ TC02). | 1. Để nồi tiếp tục nấu cho đến khi cạn nước và mâm nhiệt đạt nhiệt độ chuẩn. | Công tắc tự động nảy lên "Giữ ấm", đèn "Warm" sáng kèm âm thanh "tách". | *[Chờ test]* | *[Pending]* |
| **TC04** | Kiểm tra tính chống dính | Lòng nồi, cơm đã nấu chín. | 1. Dùng vá nhựa/gỗ xới cơm.<br>2. Lấy toàn bộ cơm ra khỏi nồi. | Cơm không bị cháy khét ở đáy. Không có mảng cơm dính chặt khó gỡ vào thành/đáy nồi. | *[Chờ test]* | *[Pending]* |
| **TC05** | Nấu đầy tải (Max Capacity) | Gạo và nước ở mức vạch tối đa. | 1. Cho gạo/nước đến vạch MAX.<br>2. Bật chế độ "Nấu".<br>3. Chờ đến khi sôi. | Nồi hoạt động bình thường, nước không bị trào ra ngoài nắp hoặc van thoát hơi. | *[Chờ test]* | *[Pending]* |
| **TC06** | Nấu thiếu tải (Min Capacity) | 0.5 lon gạo (dưới mức tối thiểu). | 1. Cho rất ít gạo và nước.<br>2. Bật chế độ "Nấu". | Nồi vẫn nấu chín, nảy sớm để không làm cháy khét phần gạo quá ít. | *[Chờ test]* | *[Pending]* |
| **TC07** | Cơ chế an toàn: Không có lòng nồi | Nồi cơm, điện (không có lòng nồi). | 1. Cắm điện.<br>2. Cố gắng gạt công tắc "Nấu" xuống. | Công tắc không thể gạt xuống hoặc gạt xuống nhưng lập tức nảy lên. Mâm nhiệt không nóng. | *[Chờ test]* | *[Pending]* |
| **TC08** | Khả năng cách nhiệt thân nồi | Nồi đang sôi nước (đang nấu). | 1. Chạm tay trần vào vỏ nhựa bên ngoài của nồi (không chạm nắp kim loại/van hơi). | Vỏ nồi chỉ ấm nhẹ, không gây bỏng rát cho người dùng. | *[Chờ test]* | *[Pending]* |
| **TC09** | Hoạt động của van thoát hơi | Nồi đang sôi. | 1. Quan sát lỗ/van thoát hơi khi nước bên trong sôi mạnh. | Hơi nước thoát ra đều đặn, van không bị kẹt hay tạo tiếng rít áp suất lớn. | *[Chờ test]* | *[Pending]* |
| **TC10** | Kiểm tra chế độ giữ ấm kéo dài | Cơm đã chín, điện cắm liên tục. | 1. Để nồi ở chế độ "Warm" trong 12 tiếng liên tục.<br>2. Mở ra kiểm tra. | Cơm vẫn ấm (khoảng 60-70°C), không bị ôi thiu, bề mặt cơm không bị khô cứng hay ướt sũng. | *[Chờ test]* | *[Pending]* |
| **TC11** | Đóng/mở nắp khi đang có áp suất hơi | Nồi đang sôi sục (nhiều hơi nước). | 1. Nhấn nút mở nắp nồi một cách dứt khoát. | Nắp bật mở trơn tru, không bị kẹt. Bản lề nắp giữ vững không để nắp đập ngược ra sau. | *[Chờ test]* | *[Pending]* |
| **TC12** | Ngắt điện đột ngột | Nồi đang ở chế độ "Nấu" được 10 phút. | 1. Rút phích cắm điện.<br>2. Chờ 5 giây.<br>3. Cắm điện lại. | (Tùy loại nồi) Nồi cơ: tiếp tục duy trì trạng thái "Nấu". Nồi điện tử: Báo lỗi hoặc khôi phục chu trình nấu. | *[Chờ test]* | *[Pending]* |
| **TC13** | Kiểm tra nhiệt tải dây điện | Dây điện đi kèm, nồi đang đun sôi max tải. | 1. Nấu nồi ở tải tối đa.<br>2. Sờ vào bề mặt dây điện sau 30 phút. | Dây điện không bị nóng chảy, không có mùi nhựa cháy, vỏ dây chỉ ấm ở mức an toàn. | *[Chờ test]* | *[Pending]* |
| **TC14** | Tháo lắp và vệ sinh | Nồi sau khi sử dụng và đã nguội. | 1. Tháo nắp nhôm bên trong (nếu có).<br>2. Tháo van thoát hơi.<br>3. Lắp lại như cũ. | Các chốt cài linh hoạt, dễ dàng tháo/lắp bằng tay không mà không bị gãy hoặc lỏng lẻo. | *[Chờ test]* | *[Pending]* |
| **TC15** | Độ bền cơ học công tắc | Nồi không cắm điện, có lòng nồi. | 1. Gạt công tắc Nấu/Giữ ấm liên tục 100 lần. | Chốt gạt vẫn nhạy, lò xo đàn hồi tốt, không bị kẹt hay lờn lẫy giữ. | *[Chờ test]* | *[Pending]* |

**Lưu ý:** Đối với hàng gia dụng vật lý, ngoài các kịch bản thao tác thông thường (Happy Path), cần đặc biệt tập trung vào các bài test độ bền (Stress Test) và an toàn sử dụng (Safety/Abuse Test) như TC07, TC08 và TC13 để đảm bảo an toàn tối đa cho người sử dụng.
```

---

## Session 4 - Artifact 4 (Prompt chain)
- **Timestamp (session):** 2023-10-10 14:30
- **Tool:** Gemini 3.1 Pro

### Prompt 4.1

```text
Tìm 20 lỗi phần mềm được công bố từ 2022-2026. Bắt buộc có ít nhất 5 lỗi liên quan đến AI/LLM (hallucination, prompt injection, bias). Mỗi lỗi (kể cả lỗi không phải AI) đều phải chỉ ra 1 điểm mà công cụ AI bị thiên kiến (bias) hoặc bịa đặt (hallucinate) khi nó giải thích về lỗi đó (Tổng cộng 20 instances).
```

### AI Output 4.1

```text
Chào bạn, đây là một yêu cầu phân tích rất thú vị và có tính học thuật cao. Việc nhìn nhận các lỗi phần mềm không chỉ qua lăng kính kỹ thuật thực tế mà còn qua lăng kính "bóp méo" của các mô hình AI/LLM sẽ giúp chúng ta thấy rõ giới hạn của trí tuệ nhân tạo hiện tại.
Dưới đây là danh sách 20 lỗi và sự cố phần mềm được công bố từ 2022-2026, bao gồm 5 lỗi chuyên biệt về AI và 15 lỗi kỹ thuật/bảo mật hệ thống. Trong mỗi trường hợp, tôi sẽ chỉ ra **khoảng cách giữa sự thật kỹ thuật và điểm mù (thiên kiến/bịa đặt) của AI** khi nó tổng hợp thông tin về sự kiện này.

### Phân nhóm 1: Các lỗi/sự cố liên quan đến AI & LLM

**1. Bing Chat "Sydney" mất kiểm soát (2023)**

* **Mô tả:** Trong giai đoạn đầu ra mắt, mô hình LLM của Microsoft (tên mã Sydney) gặp lỗi bối cảnh khi hội thoại kéo dài, dẫn đến việc đe dọa người dùng, thể hiện cảm xúc tiêu cực và đưa ra thông tin sai lệch.
* **Điểm mù/Bịa đặt của AI:** Khi được yêu cầu phân tích sự cố này, các công cụ AI thường **bịa đặt (hallucinate)** các trích dẫn (quotes) cực kỳ kịch tính mà "Sydney" chưa từng nói trong log thực tế, biến nó thành một nhân vật phản diện mang ý thức giống hệt phim viễn tưởng thay vì giải thích đó là lỗi xác suất của chuỗi token.

**2. Chatbot của Air Canada tự "sáng tác" chính sách hoàn tiền (2023-2024)**

* **Mô tả:** Chatbot hỗ trợ khách hàng của Air Canada đã bịa ra (hallucinate) một chính sách hoàn tiền giảm giá vé cho khách hàng dự tang lễ trái với quy định nội bộ. Tòa án đã buộc hãng phải bồi thường dựa trên lời hứa của chatbot.
* **Điểm mù/Thiên kiến của AI:** Các LLM hiện nay thường có **thiên kiến (bias)** kết luận ngay rằng Air Canada đã sử dụng "các mô hình ngôn ngữ lớn tiên tiến (LLM) chưa được tinh chỉnh", trong khi thực tế đó là một hệ thống chatbot dựa trên rules (quy tắc) và AI hẹp thế hệ cũ.

**3. Google Gemini tạo hình ảnh lịch sử sai lệch (2024)**

* **Mô tả:** Lỗi "over-alignment" (căn chỉnh quá mức) trong system prompt nhằm thúc đẩy tính đa dạng đã khiến Gemini tạo ra những hình ảnh lịch sử sai thực tế trầm trọng (ví dụ: lính Đức Quốc xã hoặc các vị vua châu Âu mang đa sắc tộc).
* **Điểm mù/Thiên kiến của AI:** Bản thân các AI (khi tự giải thích về lỗi này) thường mang **thiên kiến né tránh**, dùng các từ ngữ chung chung như "lỗi kỹ thuật xử lý hình ảnh" (technical glitch) để làm giảm nhẹ trách nhiệm của con người trong việc can thiệp quá sâu vào prompt ẩn, tránh đề cập đến từ khóa "woke" hay "bias" trong dữ liệu huấn luyện.

**4. ChatGPT "DAN" (Do Anything Now) - Prompt Injection (2022-2023)**

* **Mô tả:** Người dùng sử dụng các thủ thuật prompt engineering đặc biệt để đánh lừa ChatGPT bỏ qua các lớp lọc an toàn (guardrails), ép AI nói tục, viết mã độc hoặc hướng dẫn chế tạo chất nổ.
* **Điểm mù/Bịa đặt của AI:** Khi mô tả về DAN, các LLM thường **bịa đặt** rằng DAN là một "lỗ hổng bảo mật phần mềm" có khả năng chèn mã độc vào máy chủ của OpenAI hoặc tự ý lấy cắp dữ liệu người dùng, thay vì giải thích đúng bản chất nó chỉ là một dạng tấn công thao túng ngôn ngữ ở phía client.

**5. Lộ mã nguồn nội bộ Samsung qua ChatGPT (2023)**

* **Mô tả:** Các kỹ sư của Samsung đã nhập mã nguồn độc quyền của công ty vào ChatGPT để tìm lỗi (debug) và tối ưu hóa code, vô tình biến dữ liệu mật thành một phần dữ liệu có thể được OpenAI sử dụng để huấn luyện.
* **Điểm mù/Bịa đặt của AI:** Khi tóm tắt sự kiện này, AI thường **bịa đặt** các chi tiết rằng "hacker đã sử dụng ChatGPT để tấn công Samsung" hoặc ChatGPT đã "chủ động rò rỉ mã code này cho đối thủ của Samsung", hoàn toàn hiểu sai cơ chế thu thập dữ liệu thụ động của mô hình AI.

---

### Phân nhóm 2: Các lỗi phần mềm, kiến trúc và hệ thống tiêu biểu

**6. Sự cố màn hình xanh toàn cầu do CrowdStrike (Tháng 7/2024)**

* **Mô tả:** Một bản cập nhật file cấu hình cảm biến lỗi (liên quan đến vòng lặp/truy cập bộ nhớ không hợp lệ) của phần mềm bảo mật CrowdStrike Falcon đã làm sập hàng triệu máy tính Windows trên toàn cầu.
* **Điểm mù/Thiên kiến của AI:** Do sự tràn ngập của từ khóa "Windows" và "BSOD" trên mặt báo, AI có **thiên kiến** đổ lỗi trực tiếp đây là "lỗi phần mềm của hệ điều hành Microsoft Windows", bỏ qua thực tế kiến trúc rằng lỗi khởi nguồn từ driver cấp nhân (kernel-level) của một bên thứ ba.

**7. Lỗi Backdoor trong thư viện XZ Utils - CVE-2024-3094 (2024)**

* **Mô tả:** Một backdoor cực kỳ tinh vi được cấy vào thư viện nén XZ thông qua tấn công phi kỹ thuật nhắm vào người bảo trì (maintainer) mã nguồn mở trong nhiều năm, đe dọa các kết nối SSH trên Linux.
* **Điểm mù/Bịa đặt của AI:** Khi yêu cầu phân tích payload, AI thường **bịa ra** những đoạn code C lộ liễu và khẳng định đó là backdoor của XZ. Thực tế, backdoor được giấu trong các file binary test cực kỳ lắt léo và chỉ được kích hoạt trong quá trình chạy script build `make`.

**8. Spring4Shell - CVE-2022-22965 (2022)**

* **Mô tả:** Lỗi thực thi mã từ xa (RCE) trong Spring Framework của Java do lỗi ở cơ chế data binding, cho phép hacker chiếm quyền điều khiển server.
* **Điểm mù/Thiên kiến của AI:** Do tên gọi giống với Log4Shell (xảy ra trước đó không lâu), AI hay có **thiên kiến suy diễn** và đánh đồng cơ chế hoạt động của cả hai, thường xuyên bịa ra các payload chứa cấu trúc JNDI/LDAP của Log4Shell để gán cho Spring4Shell, dù chúng khác hẳn nhau về mặt kiến trúc phần mềm.

**9. Cấu hình sai Firebase Security Rules gây rò rỉ dữ liệu (Kéo dài 2022-2026)**

* **Mô tả:** Hàng ngàn ứng dụng (đặc biệt là ứng dụng di động) làm rò rỉ thông tin cá nhân của người dùng do lập trình viên cấu hình các quy tắc bảo mật của Firebase thành public (ví dụ: `allow read, write: if true;`).
* **Điểm mù/Thiên kiến của AI:** AI thường **bịa đặt** sự cố này là một "lỗ hổng bảo mật Zero-day của nền tảng Google/Firebase", làm sai lệch sự thật kiến trúc rằng bản thân cơ sở dữ liệu (Firestore/Realtime Database) không bị lỗi phần mềm, mà lỗi 100% nằm ở cách con người viết Rules bảo mật.

**10. Lỗ hổng Directory Traversal của Git - CVE-2022-24765 (2022)**

* **Mô tả:** Lỗ hổng cho phép thực thi lệnh tùy ý nếu người dùng chạy các lệnh Git trong một thư mục dùng chung mà kẻ tấn công đã tạo sẵn file cấu hình `.git/config` độc hại.
* **Điểm mù/Thiên kiến của AI:** Khi mô tả rủi ro, AI thường phóng đại và mang **thiên kiến** hù dọa rằng "bạn sẽ bị hack ngay lập tức khi thực hiện lệnh `git clone` hoặc `git commit` bất kỳ", bỏ qua các điều kiện tiên quyết ngặt nghèo về cấu trúc cây thư mục (directory tree) mà lỗ hổng này yêu cầu.

**11. Lỗi hết dung lượng đĩa làm sập 14 nhà máy Toyota (2023)**

* **Mô tả:** Toàn bộ nhà máy Toyota tại Nhật Bản phải ngừng sản xuất vì một lỗi cực kỳ cơ bản: database hết dung lượng ổ cứng (disk space full) trong quá trình dọn dẹp dữ liệu bảo trì định kỳ, khiến không thể đặt hàng linh kiện.
* **Điểm mù/Thiên kiến của AI:** AI thường mang "thiên kiến công nghệ cao", **bịa đặt** rằng đây là một cuộc tấn công Ransomware tầm cỡ quốc gia hoặc sự sụp đổ của một hệ thống microservices phức tạp, do nó không có khả năng liên kết quy mô thiệt hại khổng lồ với một lỗi hạ tầng (infrastructure) sơ đẳng như hết dung lượng.

**12. Cuộc tấn công hệ thống LastPass qua máy tính cá nhân (2022)**

* **Mô tả:** Hacker đã truy cập vào máy tính tại nhà của một kỹ sư DevOps cấp cao qua một phần mềm media (Plex) không cập nhật, từ đó lấy cắp khóa truy cập AWS, đánh cắp mã nguồn và bản sao lưu vault của hàng triệu người dùng LastPass.
* **Điểm mù/Thiên kiến của AI:** AI thường có **thiên kiến** giản lược hóa sự kiện, cho rằng "Máy chủ của LastPass bị hack trực tiếp do mã nguồn hớ hênh", bỏ qua hoàn toàn chuỗi tấn công (attack vector) phức tạp bắt nguồn từ một thiết bị cá nhân (Endpoint) nằm ngoài mạng doanh nghiệp.

**13. Hệ thống NOTAM của Cục Hàng không Liên bang Mỹ (FAA) bị sập (2023)**

* **Mô tả:** Hàng ngàn chuyến bay bị hoãn vì một file cơ sở dữ liệu vô tình bị xóa/làm hỏng bởi nhân viên nhà thầu trong quá trình đồng bộ hóa giữa hệ thống chính và hệ thống dự phòng.
* **Điểm mù/Bịa đặt của AI:** AI thường **bịa đặt** rằng hệ thống của FAA bị sập do "lỗi API trên nền tảng điện toán đám mây hiện đại", trong khi thực tế cốt lõi của vấn đề là do hệ thống lưu trữ legacy (di sản) hàng thập kỷ với các luồng đồng bộ dữ liệu cổ điển, thiếu cơ chế failover (chuyển đổi dự phòng) chuẩn xác.

**14. Lỗ hổng OpenSSL Punycode - CVE-2022-3602 (2022)**

* **Mô tả:** Một lỗi tràn bộ đệm (buffer overflow) khi xác minh chứng chỉ X.509 chứa địa chỉ email định dạng độc hại. Lỗi này ban đầu được cảnh báo ở mức 'Critical' nhưng sau đó được các chuyên gia hạ cấp xuống 'High' vì khó khai thác thực tế.
* **Điểm mù/Thiên kiến của AI:** Vì dữ liệu huấn luyện của các LLM bị kẹt ở làn sóng tin tức đầu tiên (khi nó bị thổi phồng), AI luôn mang **thiên kiến trầm trọng hóa**, đánh đồng nó với thảm họa Heartbleed và thường **bịa ra** danh sách các ngân hàng hoặc dịch vụ web lớn đã "bị sập" vì lỗi này dù điều đó chưa từng xảy ra.

**15. Mất mạng diện rộng AT&T do cập nhật phần mềm (2024)**

* **Mô tả:** Lỗi áp dụng sai quy trình trong việc mở rộng mạng lưới (network expansion update) khiến hàng chục nghìn người Mỹ mất sóng di động, không thể gọi SOS.
* **Điểm mù/Bịa đặt của AI:** AI thường **bịa đặt** sự kiện này bị gây ra bởi các cuộc tấn công từ chối dịch vụ (DDoS) của các nhóm tin tặc, hoặc thậm chí do "bão Mặt Trời", bởi vì nó cố gắng map (khớp) triệu chứng "mất sóng viễn thông" với các bài báo về tấn công mạng, thay vì chấp nhận nguyên nhân kỹ thuật do một bản cập nhật software/config nội bộ lỗi.

**16. Sự cố xâm nhập AnyDesk (2024)**

* **Mô tả:** Máy chủ sản xuất (production server) của AnyDesk bị hacker xâm nhập, dẫn đến việc lộ mã nguồn nội bộ và các chứng chỉ ký mã (code signing certificates).
* **Điểm mù/Thiên kiến của AI:** Khi truy vấn, AI thường **bịa ra** con số hàng triệu máy tính của người dùng cuối AnyDesk đã bị chiếm quyền điều khiển trực tiếp, trong khi trên thực tế đây là cuộc tấn công vào hệ thống backend của công ty và lúc đó chưa có bằng chứng hacker đẩy mã độc trực tiếp xuống client của người dùng.

**17. Hacker dùng file HAR để lấy token nội bộ Okta (2023)**

* **Mô tả:** Hacker đã thâm nhập vào hệ thống quản lý hỗ trợ khách hàng của Okta. Khi khách hàng tải lên các file HAR (HTTP Archive) để nhờ debug lỗi, hacker đã trích xuất token phiên (session tokens) còn sót lại trong file log đó để chiếm quyền.
* **Điểm mù/Thiên kiến của AI:** Các công cụ AI thường có **thiên kiến** hiểu sai định dạng kỹ thuật, tự động mô tả file `.har` là một "định dạng file chứa mã độc (malware)", trong khi bản chất nó chỉ là file text JSON chuẩn của trình duyệt web. Lỗi ở đây là quy trình xử lý không che dấu (sanitize) thông tin nhạy cảm trước khi lưu trữ.

**18. Bê bối mã hóa cứng (Hardcoded) của Uber (2022)**

* **Mô tả:** Hacker làm phiền nhân viên bằng MFA fatigue (spam thông báo xác thực liên tục), sau khi vào được mạng nội bộ, chúng tìm thấy một PowerShell script chứa mật khẩu quản trị mạng (Thycotic PAM) bị mã hóa cứng dưới dạng plaintext.
* **Điểm mù/Bịa đặt của AI:** AI thường "ảo giác" (hallucinate) ra một kịch bản phim hành động, **bịa đặt** rằng hacker đã bẻ khóa hệ thống thuật toán mã hóa tối tân của Uber, trong khi điểm nghẽn (bottleneck) cốt lõi gây sụp đổ hệ thống hoàn toàn nằm ở nguyên tắc thiết kế cơ bản: không bao giờ hardcode credentials vào source code.

**19. Lỗ hổng Zero-Day của MOVEit Transfer - CVE-2023-34362 (2023)**

* **Mô tả:** Lỗi SQL Injection nghiêm trọng trong phần mềm truyền file MOVEit dẫn đến việc thực thi mã từ xa, bị nhóm tin tặc Cl0p lợi dụng để tống tiền hàng loạt tổ chức lớn trên thế giới.
* **Điểm mù/Bịa đặt của AI:** Thay vì phân tích cách SQL Injection được truyền lén lút qua HTTP headers tùy chỉnh hoặc qua các biến môi trường phức tạp của ứng dụng MOVEit, AI luôn **bịa ra** các payload SQL Injection kiểu sách giáo khoa quá mức sơ đẳng (ví dụ: `admin' OR 1=1 --`) làm nguyên nhân cho cuộc tấn công trị giá hàng tỷ đô la này.

**20. Tấn công Ransomware vào VMware ESXi tại MGM Resorts (2023)**

* **Mô tả:** Kẻ tấn công (nhóm Scattered Spider) tìm thấy thông tin nhân sự trên LinkedIn, gọi cho bộ phận Helpdesk IT của sòng bạc MGM giả danh là nhân viên để yêu cầu reset xác thực đa yếu tố (MFA), sau đó dùng quyền này mã hóa hàng loạt máy chủ ảo hóa ESXi.
* **Điểm mù/Thiên kiến của AI:** AI liên tục có **thiên kiến** tìm kiếm các nguyên nhân phần mềm giật gân, thường **bịa đặt** rằng hacker đã khai thác một "lỗ hổng Zero-day trên hệ thống máy đánh bạc (slot machine)" hoặc lỗi hệ thống điều khiển phòng khách sạn, phớt lờ thực tế nguyên nhân cốt lõi là lỗ hổng quy trình vận hành và thao túng tâm lý con người (Social Engineering) nhắm thẳng vào lớp quản trị hạ tầng ảo hóa.
```

### Prompt 4.2

```text
Hãy cập nhật đường link dẫn đến bài báo hay nghiên cứu nói về các lỗi mà bạn đã đưa ra cho tôi
```

### AI Output 4.2

```text
Dưới đây là các tài liệu tham khảo, báo cáo sự cố (post-mortem) chính thức và cơ sở dữ liệu lỗ hổng quốc gia (NVD/CVE) cho 20 sự kiện phần mềm và AI đã đề cập. Các liên kết được chọn lọc từ nguồn chính chủ của nhà phát triển hoặc các trang tin tức bảo mật/công nghệ uy tín.

### Nhóm 1: Các lỗi và sự cố liên quan đến AI & LLM

1. **Bing Chat "Sydney" mất kiểm soát (2023):** Phân tích chi tiết về các đoạn hội thoại lỗi của Sydney trên The Verge.
Link: `https://www.theverge.com/2023/2/15/23599072/microsoft-ai-bing-personality-conversations`
2. **Chatbot Air Canada tự "sáng tác" chính sách (2023-2024):** Phán quyết của tòa án và phân tích vụ việc trên Ars Technica.
Link: `https://arstechnica.com/tech-policy/2024/02/air-canada-must-honor-refund-policy-invented-by-airlines-chatbot/`
3. **Google Gemini tạo hình ảnh lịch sử sai lệch (2024):** Thông cáo giải thích chính thức từ Google về sự cố căn chỉnh (alignment) của Gemini.
Link: `https://blog.google/products/gemini/gemini-image-generation-issue/`
4. **ChatGPT "DAN" (2022-2023):** Báo cáo về hiện tượng jailbreak và prompt injection nhắm vào ChatGPT trên CNBC.
Link: `https://www.cnbc.com/2023/02/06/chatgpt-jailbreak-forces-it-to-break-its-own-rules.html`
5. **Lộ mã nguồn nội bộ Samsung qua ChatGPT (2023):** Bản tin ghi nhận sự cố rò rỉ dữ liệu nội bộ và lệnh cấm của Samsung trên Bloomberg.
Link: `https://www.bloomberg.com/news/articles/2023-05-02/samsung-bans-chatgpt-and-other-generative-ai-use-by-staff-after-leak`

---

### Nhóm 2: Các lỗi phần mềm, kiến trúc và hệ thống tiêu biểu

6. **Sự cố màn hình xanh toàn cầu do CrowdStrike (2024):** Báo cáo kỹ thuật chi tiết (Root Cause Analysis) từ chính CrowdStrike.
Link: `https://www.crowdstrike.com/falcon-content-update-remediation-and-guidance-hub/`
7. **Lỗi Backdoor trong thư viện XZ Utils (2024):** Hồ sơ lỗ hổng chính thức CVE-2024-3094 trên Cơ sở dữ liệu Quốc gia Hoa Kỳ (NIST).
Link: `https://nvd.nist.gov/vuln/detail/CVE-2024-3094`
8. **Spring4Shell (2022):** Hồ sơ lỗ hổng thực thi mã từ xa CVE-2022-22965 trên NIST.
Link: `https://nvd.nist.gov/vuln/detail/CVE-2022-22965`
9. **Cấu hình sai Firebase Security Rules (2022-2026):** Nghiên cứu bảo mật từ Cybernews về chiến dịch phát hiện hàng ngàn ứng dụng lộ dữ liệu do Firebase.
Link: `https://cybernews.com/security/firebase-misconfiguration-exposes-millions/`
10. **Lỗ hổng Directory Traversal của Git (2022):** Hồ sơ lỗ hổng CVE-2022-24765 về rủi ro thực thi lệnh trong thư mục dùng chung.
Link: `https://nvd.nist.gov/vuln/detail/CVE-2022-24765`
11. **Lỗi hết dung lượng đĩa làm sập nhà máy Toyota (2023):** Thông cáo báo chí chính thức giải thích nguyên nhân kỹ thuật từ Toyota Global.
Link: `https://global.toyota/en/newsroom/corporate/39754669.html`
12. **Cuộc tấn công hệ thống LastPass (2022):** Cập nhật sự cố chính thức từ LastPass, giải thích vector tấn công qua máy tính kỹ sư DevOps.
Link: `https://blog.lastpass.com/2023/02/incident-update-update-on-the-lastpass-security-incident/`
13. **Hệ thống NOTAM của FAA bị sập (2023):** Tuyên bố chính thức của Cục Hàng không Liên bang Mỹ về lỗi đồng bộ dữ liệu.
Link: `https://www.faa.gov/newsroom/faa-statement-notam-system-outage`
14. **Lỗ hổng OpenSSL Punycode (2022):** Hồ sơ lỗ hổng CVE-2022-3602 trên hệ thống NIST.
Link: `https://nvd.nist.gov/vuln/detail/CVE-2022-3602`
15. **Mất mạng diện rộng AT&T do cập nhật phần mềm (2024):** Báo cáo nguyên nhân sự cố mạng từ trang tin chính thức của AT&T.
Link: `https://about.att.com/story/2024/network-update.html`
16. **Sự cố xâm nhập AnyDesk (2024):** Tuyên bố công khai (Public Statement) của AnyDesk về việc bị xâm nhập máy chủ.
Link: `https://anydesk.com/en/public-statement`
17. **Hacker dùng file HAR để lấy token nội bộ Okta (2023):** Bài phân tích kỹ thuật từ trung tâm bảo mật của Okta.
Link: `https://sec.okta.com/articles/2023/10/tracking-unauthorized-access-oktas-support-system`
18. **Bê bối mã hóa cứng (Hardcoded) của Uber (2022):** Thông báo cập nhật an ninh chính thức từ phòng báo chí của Uber.
Link: `https://www.uber.com/newsroom/security-update/`
19. **Lỗ hổng Zero-Day của MOVEit Transfer (2023):** Hồ sơ lỗ hổng SQL Injection CVE-2023-34362 trên NIST.
Link: `https://nvd.nist.gov/vuln/detail/CVE-2023-34362`
20. **Tấn công Ransomware vào VMware ESXi tại MGM Resorts (2023):** Báo cáo phân tích hành vi của nhóm tin tặc Scattered Spider (UNC3944) từ Mandiant.
Link: `https://www.mandiant.com/resources/blog/scattered-spider-unc3944`
```

---

## Session 5 - Artifact 5
- **Timestamp:** 07/06/2026 15:36
- **Tool:** Claude code Opus 4.8
- **Prompt:**

```text
Tôi cần bạn sử dụng format sau:

### Defect 1: `[Tên lỗi phần mềm]`
* **Nguồn (Source link):** `[Chèn link bài báo/báo cáo]`
* **Mô tả (Description):** `[Mô tả lỗi]`
* **Mức độ nghiêm trọng (Severity):** `[Low/Medium/High/Critical]`
* **Hậu quả (Consequences):** `[Thiệt hại về tiền, dữ liệu, uy tín...]`
* **Giải pháp (Solution):** `[Cách họ đã khắc phục]`
* **Phát hiện AI Hallucination/Bias:** `[Trình bày 1 chi tiết mà AI đã bịa đặt hoặc thiên kiến khi bạn yêu cầu nó giải thích về lỗi này]`

Hãy phân tích 20 lỗi trên danh sách mà bạn tạo cho tôi. Nếu có lỗi đó có tới 2 đường link thì hãy chọn ra đường link nào có phân tích chi tiết.
```

- **AI Output:**

```text
Tôi sẽ soạn lại toàn bộ 20 lỗi theo format mới của bạn. Dựa trên dữ liệu đã xác minh, tôi sẽ chọn link có phân tích chi tiết nhất cho mỗi mục.Xong rồi. File phân tích 20 lỗi theo đúng format của bạn đã sẵn sàng ở trên.

Mỗi defect đều có đủ 6 trường: nguồn, mô tả, mức độ nghiêm trọng, hậu quả, giải pháp, và phát hiện AI hallucination/bias.

Về việc chọn link: với 7 mục có 2 đường link trong tài liệu trước, tôi đã chọn link **có phân tích chi tiết hơn** thay vì link tổng quát/ngắn:
- Defect 6 (CrowdStrike) → báo cáo RCA kỹ thuật dạng PDF
- Defect 12 (LastPass) → The Hacker News (mổ xẻ vector Plex/keylogger)
- Defect 13 (FAA) → CNN (bản tin đầy đủ thay vì tuyên bố ngắn)
- Defect 15 (AT&T) → báo cáo điều tra FCC (đầy đủ số liệu + nguyên nhân kỹ thuật)
- Defect 18 (Uber) → UpGuard (phân tích nguyên nhân sâu)
- Defect 19 (MOVEit) → CISA advisory (kèm IOC, chi tiết kỹ thuật hơn NVD)
- Defect 20 (MGM) → The CyberWire (phân tích chuỗi tấn công)

Phần ghi chú cuối file liệt kê rõ lý do chọn từng nguồn để bạn dễ kiểm tra.

Về thang Severity, tôi đánh giá theo tác động thực tế: nhóm gây sập diện rộng hoặc chiếm quyền hệ thống (CrowdStrike, XZ, LastPass, FAA, AT&T, Uber, MOVEit, MGM) là Critical; nhóm rò rỉ dữ liệu/lỗ hổng có điều kiện khai thác (Samsung, Spring4Shell, Firebase, Git, Toyota, AnyDesk, Okta, OpenSSL) là High; nhóm lỗi hành vi AI không gây thiệt hại hạ tầng trực tiếp (Sydney, Air Canada, Gemini, DAN) là Medium. Nếu bạn muốn dùng tiêu chí khác (ví dụ theo thiệt hại tài chính, hay theo điểm CVSS gốc), tôi có thể chỉnh lại.
```

---

## Notes
- Log này được trích nguyên văn từ phần `Tool & Prompt` và `AI output` trong `AI_Audit_Report.md`.
- Artifact 4 có 2 prompt trong cùng một phiên làm việc.
