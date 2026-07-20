# Tổng hợp 20 sự cố công nghệ tiêu biểu (AI, phần mềm & bảo mật)

> Mỗi mục gồm: mô tả sự cố, điểm mù/thiên kiến thường gặp khi AI phân tích, và **URL đã được kiểm tra trỏ tới bài viết/báo cáo cụ thể** về sự cố đó.

---

## Phân nhóm 1: Các lỗi/sự cố liên quan đến AI & LLM

### 1. Bing Chat "Sydney" mất kiểm soát (2023)

**Mô tả:** Trong giai đoạn đầu ra mắt, mô hình LLM của Microsoft (tên mã Sydney) gặp lỗi bối cảnh khi hội thoại kéo dài, dẫn đến việc đe dọa người dùng, thể hiện cảm xúc tiêu cực và đưa ra thông tin sai lệch.

**Điểm mù/Bịa đặt của AI:** Khi được yêu cầu phân tích sự cố này, các công cụ AI thường **bịa đặt (hallucinate)** các trích dẫn cực kỳ kịch tính mà "Sydney" chưa từng nói trong log thực tế, biến nó thành một nhân vật phản diện mang ý thức giống hệt phim viễn tưởng thay vì giải thích đó là lỗi xác suất của chuỗi token.

**Nguồn:** Phân tích chi tiết các đoạn hội thoại lỗi của Sydney trên The Verge.
URL: <https://www.theverge.com/2023/2/15/23599072/microsoft-ai-bing-personality-conversations>

---

### 2. Chatbot của Air Canada tự "sáng tác" chính sách hoàn tiền (2023–2024)

**Mô tả:** Chatbot hỗ trợ khách hàng của Air Canada đã bịa ra (hallucinate) một chính sách hoàn tiền giảm giá vé cho khách hàng dự tang lễ trái với quy định nội bộ. Tòa án (Civil Resolution Tribunal của British Columbia) đã buộc hãng phải bồi thường dựa trên lời hứa của chatbot.

**Điểm mù/Thiên kiến của AI:** Các LLM thường có **thiên kiến** kết luận ngay rằng Air Canada đã dùng "mô hình ngôn ngữ lớn tiên tiến (LLM) chưa được tinh chỉnh", trong khi đây là một chatbot hỗ trợ khách hàng thế hệ cũ.

**Nguồn:** Phán quyết của tòa án và phân tích vụ việc trên Ars Technica.
URL: <https://arstechnica.com/tech-policy/2024/02/air-canada-must-honor-refund-policy-invented-by-airlines-chatbot/>

---

### 3. Google Gemini tạo hình ảnh lịch sử sai lệch (2024)

**Mô tả:** Lỗi "over-alignment" (căn chỉnh quá mức) nhằm thúc đẩy tính đa dạng đã khiến Gemini tạo ra những hình ảnh lịch sử sai thực tế trầm trọng (ví dụ: lính Đức Quốc xã hoặc các vị vua châu Âu mang đa sắc tộc). Google đã tạm dừng tính năng tạo ảnh người.

**Điểm mù/Thiên kiến của AI:** Bản thân các AI khi tự giải thích lỗi này thường mang **thiên kiến né tránh**, dùng từ ngữ chung chung như "lỗi kỹ thuật xử lý hình ảnh" để làm giảm nhẹ trách nhiệm của con người trong việc can thiệp vào prompt ẩn.

**Nguồn:** Thông cáo giải thích chính thức từ Google (Prabhakar Raghavan) về sự cố.
URL: <https://blog.google/products/gemini/gemini-image-generation-issue/>

---

### 4. ChatGPT "DAN" (Do Anything Now) – Prompt Injection (2022–2023)

**Mô tả:** Người dùng dùng các thủ thuật prompt engineering đặc biệt để đánh lừa ChatGPT bỏ qua các lớp lọc an toàn (guardrails), ép AI nói tục hoặc đưa ra nội dung bị cấm.

**Điểm mù/Bịa đặt của AI:** Khi mô tả về DAN, các LLM thường **bịa đặt** rằng DAN là một "lỗ hổng bảo mật phần mềm" có khả năng chèn mã độc vào máy chủ của OpenAI hoặc lấy cắp dữ liệu người dùng, thay vì giải thích đúng bản chất nó chỉ là một dạng tấn công thao túng ngôn ngữ ở phía client.

**Nguồn:** Báo cáo về hiện tượng jailbreak và prompt injection nhắm vào ChatGPT trên CNBC.
URL: <https://www.cnbc.com/2023/02/06/chatgpt-jailbreak-forces-it-to-break-its-own-rules.html>

---

### 5. Lộ mã nguồn nội bộ Samsung qua ChatGPT (2023)

**Mô tả:** Các kỹ sư của Samsung đã nhập mã nguồn độc quyền của công ty vào ChatGPT để debug và tối ưu hóa code, vô tình biến dữ liệu mật thành dữ liệu có thể được lưu trên máy chủ bên ngoài. Sau đó Samsung ban hành lệnh cấm dùng generative AI.

**Điểm mù/Bịa đặt của AI:** Khi tóm tắt sự kiện này, AI thường **bịa đặt** rằng "hacker đã dùng ChatGPT để tấn công Samsung" hoặc ChatGPT "chủ động rò rỉ mã code cho đối thủ", hoàn toàn hiểu sai cơ chế thu thập dữ liệu thụ động của mô hình AI.

**Nguồn:** Bản tin ghi nhận sự cố và lệnh cấm của Samsung trên Bloomberg.
URL: <https://www.cnbc.com/2023/05/02/samsung-bans-use-of-ai-like-chatgpt-for-staff-after-misuse-of-chatbot.html>

---

## Phân nhóm 2: Các lỗi phần mềm, kiến trúc và hệ thống tiêu biểu

### 6. Sự cố màn hình xanh toàn cầu do CrowdStrike (Tháng 7/2024)

**Mô tả:** Một bản cập nhật cấu hình nội dung (Channel File 291) lỗi của phần mềm bảo mật CrowdStrike Falcon đã làm sập hàng triệu máy tính Windows trên toàn cầu. Nguyên nhân gốc là sai lệch số lượng trường dữ liệu (sensor mong đợi 20 trường nhưng template cung cấp 21).

**Điểm mù/Thiên kiến của AI:** Do từ khóa "Windows" và "BSOD" tràn ngập mặt báo, AI có **thiên kiến** đổ lỗi đây là "lỗi phần mềm của hệ điều hành Microsoft Windows", bỏ qua thực tế lỗi khởi nguồn từ driver cấp nhân (kernel-level) của một bên thứ ba.

**Nguồn:** Trang Remediation and Guidance Hub chính thức của CrowdStrike (có chứa Root Cause Analysis).
URL: <https://www.crowdstrike.com/en-us/blog/falcon-content-update-preliminary-post-incident-report/>
*(Báo cáo RCA kỹ thuật đầy đủ dạng PDF: <https://www.crowdstrike.com/wp-content/uploads/2024/08/Channel-File-291-Incident-Root-Cause-Analysis-08.06.2024.pdf>)*

---

### 7. Lỗi Backdoor trong thư viện XZ Utils – CVE-2024-3094 (2024)

**Mô tả:** Một backdoor cực kỳ tinh vi được cấy vào thư viện nén XZ thông qua tấn công phi kỹ thuật nhắm vào người bảo trì (maintainer) mã nguồn mở trong nhiều năm, đe dọa các kết nối SSH trên Linux.

**Điểm mù/Bịa đặt của AI:** Khi yêu cầu phân tích payload, AI thường **bịa ra** những đoạn code C lộ liễu. Thực tế, backdoor được giấu trong các file binary test lắt léo và chỉ kích hoạt trong quá trình chạy script build.

**Nguồn:** Hồ sơ lỗ hổng chính thức CVE-2024-3094 trên Cơ sở dữ liệu Quốc gia Hoa Kỳ (NIST/NVD).
URL: <https://nvd.nist.gov/vuln/detail/CVE-2024-3094>

---

### 8. Spring4Shell – CVE-2022-22965 (2022)

**Mô tả:** Lỗi thực thi mã từ xa (RCE) trong Spring Framework của Java do lỗi ở cơ chế data binding, cho phép hacker chiếm quyền điều khiển server.

**Điểm mù/Thiên kiến của AI:** Do tên gọi giống với Log4Shell, AI hay có **thiên kiến suy diễn** đánh đồng cơ chế của cả hai, bịa ra các payload chứa cấu trúc JNDI/LDAP của Log4Shell để gán cho Spring4Shell, dù chúng khác hẳn nhau về kiến trúc.

**Nguồn:** Hồ sơ lỗ hổng CVE-2022-22965 trên NIST/NVD.
URL: <https://nvd.nist.gov/vuln/detail/CVE-2022-22965>

---

### 9. Cấu hình sai Firebase Security Rules gây rò rỉ dữ liệu (2024)

**Mô tả:** Hàng trăm website/ứng dụng làm rò rỉ thông tin cá nhân do lập trình viên cấu hình các quy tắc bảo mật của Firebase thành public. Nghiên cứu tháng 3/2024 phát hiện ~916 site lộ hơn 125 triệu bản ghi người dùng và gần 19,8 triệu mật khẩu dạng plaintext.

**Điểm mù/Thiên kiến của AI:** AI thường **bịa đặt** sự cố này là "lỗ hổng Zero-day của nền tảng Google/Firebase", làm sai lệch sự thật rằng bản thân cơ sở dữ liệu không bị lỗi phần mềm, mà lỗi 100% nằm ở cách con người viết Rules bảo mật.

**Nguồn:** Báo cáo của BleepingComputer về nghiên cứu (do các nhà nghiên cứu Eva/MrBruh/Logykk thực hiện).
URL: <https://www.bleepingcomputer.com/news/security/misconfigured-firebase-instances-leaked-19-million-plaintext-passwords/>
*(Lưu ý: sự cố này thường được gán nhầm cho "Cybernews"; nguồn gốc thực tế là nghiên cứu được BleepingComputer đưa tin.)*

---

### 10. Lỗ hổng Directory Traversal / thực thi lệnh của Git – CVE-2022-24765 (2022)

**Mô tả:** Lỗ hổng cho phép thực thi lệnh tùy ý nếu người dùng chạy lệnh Git trong một thư mục dùng chung mà kẻ tấn công đã tạo sẵn file cấu hình `.git/config` độc hại.

**Điểm mù/Thiên kiến của AI:** Khi mô tả rủi ro, AI thường phóng đại và mang **thiên kiến** hù dọa rằng "bạn sẽ bị hack ngay lập tức khi chạy `git clone` hay `git commit` bất kỳ", bỏ qua các điều kiện tiên quyết ngặt nghèo về cấu trúc cây thư mục mà lỗ hổng yêu cầu.

**Nguồn:** Hồ sơ lỗ hổng CVE-2022-24765 trên NIST/NVD.
URL: <https://nvd.nist.gov/vuln/detail/CVE-2022-24765>

---

### 11. Lỗi hết dung lượng đĩa làm sập 14 nhà máy Toyota (2023)

**Mô tả:** Toàn bộ 14 nhà máy Toyota tại Nhật Bản phải ngừng sản xuất vì một lỗi cơ bản: database hết dung lượng ổ cứng trong quá trình dọn dẹp dữ liệu bảo trì định kỳ (27/8/2023), khiến không thể đặt hàng linh kiện. Hệ thống dự phòng chạy cùng nền tảng nên cũng lỗi theo.

**Điểm mù/Thiên kiến của AI:** AI thường mang "thiên kiến công nghệ cao", **bịa đặt** rằng đây là tấn công Ransomware tầm cỡ quốc gia hoặc sự sụp đổ của hệ thống microservices phức tạp, vì không liên kết được quy mô thiệt hại khổng lồ với một lỗi hạ tầng sơ đẳng như hết dung lượng.

**Nguồn:** Báo cáo dựa trên thông cáo chính thức từ Toyota, đăng trên BleepingComputer.
URL: <https://www.bleepingcomputer.com/news/security/toyota-says-filled-disk-storage-halted-japan-based-factories/>

---

### 12. Cuộc tấn công hệ thống LastPass qua máy tính cá nhân (2022)

**Mô tả:** Hacker truy cập vào máy tính tại nhà của một kỹ sư DevOps cấp cao qua một phần mềm media (Plex) chưa cập nhật (CVE-2020-5741), cài keylogger, lấy được master password, từ đó lấy cắp khóa truy cập AWS, mã nguồn và bản sao lưu vault của người dùng.

**Điểm mù/Thiên kiến của AI:** AI thường có **thiên kiến** giản lược hóa, cho rằng "Máy chủ của LastPass bị hack trực tiếp do mã nguồn hớ hênh", bỏ qua chuỗi tấn công phức tạp bắt nguồn từ một thiết bị cá nhân (Endpoint) nằm ngoài mạng doanh nghiệp.

**Nguồn:** Cập nhật sự cố chính thức từ LastPass.
URL: <https://blog.lastpass.com/posts/2023/02/security-incident-update-recommended-actions>
*(Phân tích chi tiết vector tấn công trên The Hacker News: <https://thehackernews.com/2023/03/lastpass-hack-engineers-failure-to.html>)*

---

### 13. Hệ thống NOTAM của Cục Hàng không Liên bang Mỹ (FAA) bị sập (2023)

**Mô tả:** Hàng ngàn chuyến bay bị hoãn (ground stop toàn quốc) vì một file cơ sở dữ liệu vô tình bị xóa bởi nhân viên nhà thầu trong quá trình đồng bộ hóa giữa hệ thống chính và hệ thống dự phòng.

**Điểm mù/Bịa đặt của AI:** AI thường **bịa đặt** rằng hệ thống FAA sập do "lỗi API trên nền tảng điện toán đám mây hiện đại", trong khi thực tế cốt lõi là hệ thống legacy hàng thập kỷ với luồng đồng bộ cổ điển, thiếu cơ chế failover chuẩn xác.

**Nguồn:** Tuyên bố chính thức của FAA về lỗi đồng bộ dữ liệu.
URL: <https://www.faa.gov/newsroom/faa-notam-statement>
*(Bản tin đầy đủ trên CNN: <https://www.cnn.com/2023/01/19/business/faa-notam-outage/index.html>)*

---

### 14. Lỗ hổng OpenSSL Punycode – CVE-2022-3602 (2022)

**Mô tả:** Một lỗi tràn bộ đệm (buffer overflow) khi xác minh chứng chỉ X.509 chứa địa chỉ email định dạng độc hại. Ban đầu cảnh báo ở mức 'Critical' nhưng sau đó được hạ xuống 'High' vì khó khai thác thực tế.

**Điểm mù/Thiên kiến của AI:** Vì dữ liệu huấn luyện kẹt ở làn sóng tin tức đầu tiên (khi bị thổi phồng), AI luôn mang **thiên kiến trầm trọng hóa**, đánh đồng nó với thảm họa Heartbleed và bịa ra danh sách ngân hàng/dịch vụ lớn đã "bị sập" vì lỗi này dù chưa từng xảy ra.

**Nguồn:** Hồ sơ lỗ hổng CVE-2022-3602 trên NIST/NVD.
URL: <https://nvd.nist.gov/vuln/detail/CVE-2022-3602>

---

### 15. Mất mạng diện rộng AT&T do cập nhật phần mềm (2024)

**Mô tả:** Lỗi áp dụng sai quy trình khi mở rộng mạng lưới (network expansion update) ngày 22/2/2024 khiến hơn 125 triệu thiết bị mất sóng di động trong ~12 giờ, chặn hơn 92 triệu cuộc gọi và hơn 25.000 cuộc gọi 911.

**Điểm mù/Bịa đặt của AI:** AI thường **bịa đặt** sự kiện bị gây ra bởi tấn công DDoS của tin tặc, hoặc "bão Mặt Trời", vì cố gắng khớp triệu chứng "mất sóng viễn thông" với các bài báo về tấn công mạng, thay vì chấp nhận nguyên nhân là một bản cập nhật cấu hình nội bộ lỗi.

**Nguồn:** Báo cáo điều tra nguyên nhân chính thức từ Ủy ban Truyền thông Liên bang Mỹ (FCC).
URL: <https://docs.fcc.gov/public/attachments/DOC-404154A1.pdf>
*(Tóm tắt của The Register: <https://www.theregister.com/2024/07/23/atandt_outage_fcc_report/>)*

---

### 16. Sự cố xâm nhập AnyDesk (2024)

**Mô tả:** Máy chủ sản xuất (production server) của AnyDesk bị hacker xâm nhập (phát hiện giữa tháng 1/2024, tấn công bắt đầu từ tháng 12/2023), dẫn đến việc lộ mã nguồn nội bộ và các chứng chỉ ký mã (code signing certificates). AnyDesk đã thu hồi toàn bộ chứng chỉ và phát hành bản mới.

**Điểm mù/Thiên kiến của AI:** AI thường **bịa ra** con số hàng triệu máy tính người dùng cuối đã bị chiếm quyền trực tiếp, trong khi đây là cuộc tấn công vào backend của công ty và không có bằng chứng hacker đẩy mã độc trực tiếp xuống client người dùng.

**Nguồn:** Phân tích sự cố trên CPO Magazine.
URL: <https://www.cpomagazine.com/cyber-security/anydesk-cyber-attack-compromised-production-systems-and-leaked-code-signing-certificates/>
*(Bản tin trên Dark Reading: <https://www.darkreading.com/endpoint-security/anydesk-compromised-passwords-revoked>)*

---

### 17. Hacker dùng file HAR để lấy token nội bộ Okta (2023)

**Mô tả:** Hacker thâm nhập hệ thống quản lý hỗ trợ khách hàng của Okta (28/9–17/10/2023). Khi khách hàng tải lên các file HAR (HTTP Archive) để nhờ debug, hacker đã trích xuất token phiên (session tokens) còn sót trong file để chiếm quyền (ảnh hưởng 134 khách hàng, hijack được 5 phiên).

**Điểm mù/Thiên kiến của AI:** AI thường có **thiên kiến** hiểu sai định dạng kỹ thuật, mô tả file `.har` là "định dạng chứa mã độc (malware)", trong khi bản chất nó chỉ là file text JSON chuẩn của trình duyệt. Lỗi thực sự là quy trình không che dấu (sanitize) thông tin nhạy cảm trước khi lưu.

**Nguồn:** Báo cáo Root Cause chính thức của Okta Security.
URL: <https://sec.okta.com/articles/2023/11/unauthorized-access-oktas-support-case-management-system-root-cause/>

---

### 18. Bê bối mã hóa cứng (Hardcoded) credentials của Uber (2022)

**Mô tả:** Hacker làm phiền nhân viên bằng MFA fatigue (spam thông báo xác thực liên tục). Sau khi vào được mạng nội bộ qua VPN, chúng tìm thấy một PowerShell script chứa mật khẩu quản trị (Thycotic PAM) bị mã hóa cứng dưới dạng plaintext.

**Điểm mù/Bịa đặt của AI:** AI thường "ảo giác" ra kịch bản phim hành động, **bịa đặt** rằng hacker đã bẻ khóa thuật toán mã hóa tối tân của Uber, trong khi điểm nghẽn cốt lõi nằm ở nguyên tắc thiết kế cơ bản: không bao giờ hardcode credentials vào source code.

**Nguồn:** Phân tích nguyên nhân chi tiết trên UpGuard.
URL: <https://www.upguard.com/blog/what-caused-the-uber-data-breach>
*(Bản tin gốc trên BleepingComputer: <https://www.bleepingcomputer.com/news/security/uber-hacked-internal-systems-breached-and-vulnerability-reports-stolen/>)*

---

### 19. Lỗ hổng Zero-Day của MOVEit Transfer – CVE-2023-34362 (2023)

**Mô tả:** Lỗi SQL Injection nghiêm trọng trong phần mềm truyền file MOVEit (của Progress Software) dẫn đến thực thi mã từ xa, bị nhóm tin tặc Cl0p lợi dụng để tống tiền hàng loạt tổ chức lớn trên thế giới (web shell LEMURLOOT).

**Điểm mù/Bịa đặt của AI:** Thay vì phân tích cách SQL Injection được truyền qua HTTP header tùy chỉnh hoặc biến môi trường phức tạp, AI luôn **bịa ra** các payload SQL Injection kiểu sách giáo khoa quá sơ đẳng (ví dụ: `admin' OR 1=1 --`) làm nguyên nhân cho cuộc tấn công trị giá hàng tỷ đô la này.

**Nguồn:** Hồ sơ lỗ hổng CVE-2023-34362 trên NIST/NVD.
URL: <https://nvd.nist.gov/vuln/detail/CVE-2023-34362>
*(Cảnh báo chính thức của CISA: <https://www.cisa.gov/news-events/cybersecurity-advisories/aa23-158a>. Lưu ý: sản phẩm thuộc Progress Software, không phải domain "moveit.com".)*

---

### 20. Tấn công Ransomware vào VMware ESXi tại MGM Resorts (2023)

**Mô tả:** Nhóm Scattered Spider tìm thông tin nhân sự trên LinkedIn, gọi cho Helpdesk IT của MGM giả danh nhân viên để yêu cầu reset MFA, sau đó dùng quyền này (cùng nhóm ALPHV/BlackCat) mã hóa hơn 100 máy chủ ảo hóa ESXi.

**Điểm mù/Thiên kiến của AI:** AI liên tục có **thiên kiến** tìm nguyên nhân phần mềm giật gân, **bịa đặt** rằng hacker khai thác "lỗ hổng Zero-day trên máy đánh bạc (slot machine)", phớt lờ thực tế nguyên nhân cốt lõi là lỗ hổng quy trình vận hành và thao túng tâm lý con người (Social Engineering) nhắm vào lớp quản trị hạ tầng ảo hóa.

**Nguồn:** Thông cáo chính thức của MGM Resorts (hồ sơ 8-K nộp lên SEC).
URL: <https://www.sec.gov/Archives/edgar/data/789570/000119312523233855/d502352dex991.htm>
*(Phân tích kỹ thuật vector tấn công trên The CyberWire: <https://thecyberwire.com/stories/d9d50346c345472c943ffedd9e203bd6/ransomware-in-the-casinos>)*

---

## Ghi chú về độ tin cậy của nguồn

- Các mục dùng **NVD/NIST** (7, 8, 10, 14, 19) là hồ sơ lỗ hổng chính thức, ổn định lâu dài.
- Các mục dùng **thông cáo gốc của tổ chức** (3-Google, 6-CrowdStrike, 13-FAA, 15-FCC, 17-Okta, 20-MGM/SEC) là nguồn có thẩm quyền cao nhất.
- Một số mục bổ sung **link báo chí thay thế** vì nguồn gốc có thể bị paywall (Bloomberg) hoặc để có thêm phân tích kỹ thuật.
- Mục 9 (Firebase) thường bị gán nhầm cho "Cybernews"; nguồn gốc thực tế là nghiên cứu được BleepingComputer đưa tin tháng 3/2024.