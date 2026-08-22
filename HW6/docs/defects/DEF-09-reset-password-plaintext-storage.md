# DEF-09 — Mật khẩu mới được lưu dưới dạng plaintext

- Mã lỗi: `DEF-09`
- Tên kỹ thuật: `RESET_PASSWORD_STORES_PASSWORD_AS_PLAINTEXT`
- API: `POST /api/reset-password`
- Yêu cầu liên quan: `API01-REQ-008`
- Cụm nguyên nhân gốc: `RC-01-N03`
- Test case chính: `API01-AI-035`
- Các test case hỗ trợ: `[]`
- Lần chạy kiểm thử: `run-002`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Xác nhận của sinh viên: `CONFIRMED_PRODUCT_DEFECT`

## Yêu cầu liên quan

`API01-REQ-008` quy định rằng mật khẩu không được lưu dưới dạng plaintext (văn bản thuần). Bất biến bảo mật được sử dụng là: giá trị mật khẩu được lưu sau reset không được trùng với mật khẩu plaintext đã gửi.

## Môi trường kiểm thử

Backend EShop Node/Express chạy cục bộ tại `http://localhost:3000`, người dùng dùng một lần theo test case, cơ sở dữ liệu SQLite ghi được và dành riêng cho lần chạy kiểm thử, Newman `6.2.2` và cơ chế kiểm tra chỉ đọc datastore sau reset.

## Điều kiện tiên quyết

1. Đăng ký một người dùng dùng một lần dành riêng cho test case trong cơ sở dữ liệu runtime cô lập.
2. Cấp OTP mới gắn với email.
3. Hoàn tất một lần reset hợp lệ về các điều kiện còn lại cho người dùng đó.
4. Xác định chính xác dòng dữ liệu sau reset bằng định danh dùng một lần của test case.

## Các bước tái hiện

1. Thực thi `API01-AI-035` bằng người dùng dùng một lần và OTP mới.
2. Xác nhận thao tác reset hoàn tất.
3. Thực hiện phép so sánh SQLite chỉ đọc đã được phê duyệt với field mật khẩu của đúng dòng người dùng sau reset.
4. Chỉ ghi lại kết quả boolean; không in giá trị đã gửi, giá trị đã lưu, password hash, JWT, Student ID hoặc thông tin xác thực.

## Kết quả mong đợi

Biểu diễn mật khẩu được lưu phải khác mật khẩu plaintext đã gửi.

## Kết quả thực tế

Đúng dòng người dùng dành riêng cho test case đã được tìm thấy và phép so sánh an toàn trả về:

```text
PLAINTEXT_EQUAL:
YES
```

Bằng chứng cũng ghi nhận rằng không có giá trị mật khẩu nào được log.

## Phân loại nguồn bằng chứng

- `NEWMAN_REQUEST_EXECUTED: YES` — `API01-AI-035` ghi nhận reset được thực thi và nhận HTTP `200`.
- `NEWMAN_ASSERTION_FAILED: NO` — Newman chỉ là bằng chứng bối cảnh thực thi cho lỗi lưu trữ này.
- `EXTERNAL_VERIFICATION_USED: YES` — phép so sánh SQLite chỉ đọc ghi nhận `user_found = true`, `PLAINTEXT_EQUAL = YES` và `password_value_logged = false`.
- `PRIMARY_FAILURE_EVIDENCE: EXTERNAL_STATE` — kết quả so sánh boolean an toàn là bằng chứng quyết định.

## Mức độ ảnh hưởng

Bất kỳ ai có quyền đọc datastore thông tin xác thực đều có thể trực tiếp lấy mật khẩu reset bị ảnh hưởng thay vì phải đối mặt với cơ chế xác minh mật khẩu một chiều. Lần chạy chứng minh sự trùng khớp plaintext đối với luồng reset được kiểm thử, nhưng không định lượng số tài khoản khác có thể bị ảnh hưởng.

## Mức độ nghiêm trọng đề xuất

**Cao (High)**

Lưu thông tin xác thực dưới dạng plaintext tạo rủi ro nghiêm trọng về tính bí mật và an toàn tài khoản. Mức đề xuất không đưa ra khẳng định Critical không có điều kiện vì bằng chứng chỉ giới hạn ở luồng reset cô lập đã quan sát và không chứng minh một vụ xâm nhập datastore.

## Đường dẫn bằng chứng

- `test-results/hw06/run-002/external-verification-results.json` — bằng chứng SQLite chỉ đọc an toàn cho kết luận `PLAINTEXT_EQUAL: YES`; không ghi giá trị mật khẩu.
- `test-results/hw06/run-002/newman.json` — thao tác reset thành công thật dùng làm bối cảnh cho test case.
- `test-results/hw06/run-002/external-hook-evidence.json` — trạng thái người dùng theo test case, database hash thay đổi và token bị vô hiệu hóa mà không chứa giá trị nhạy cảm.
- `test-results/hw06/run-002/execution-metadata.md` — nguồn gốc tooling và lần chạy cô lập.
- `docs/requirement-analysis/api-01-reset-password.md` — quy định có thẩm quyền cấm lưu mật khẩu plaintext.

## Ảnh minh chứng

- Newman execution context: `docs/defects/screenshots/DEF-09-A-request-response.png`.
- Ảnh SQLite/terminal thật: `docs/defects/screenshots/DEF-09-B-state-evidence.png`; chỉ hiển thị `PLAINTEXT_EQUAL = YES` cùng các boolean an toàn.
