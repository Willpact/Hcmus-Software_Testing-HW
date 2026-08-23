# [HW06][DEF-XX] <Tiêu đề lỗi ngắn gọn>

## Mã lỗi

DEF-XX

## Cụm nguyên nhân gốc

RC-...

## API / Endpoint

`METHOD /api/...`

## Yêu cầu liên quan

- `<Requirement ID>`: <Nội dung yêu cầu có thẩm quyền đã được sinh viên phê duyệt>

## Môi trường kiểm thử

- Hệ thống: EShop chạy cục bộ
- Base URL: `http://localhost:3000`
- Newman: `6.2.2`
- `X-Student-Id`: Có trong request, giá trị đã được ẩn
- Lần chạy kiểm thử: `run-00X`

Chỉ thêm dòng `Cơ sở dữ liệu: SQLite cục bộ dành riêng cho kiểm thử` khi việc xác minh datastore là một phần của bằng chứng lỗi.

## Điều kiện tiên quyết

1. <Role đã xác thực, fixture hoặc trạng thái ban đầu bắt buộc>
2. <Test data cô lập bắt buộc>
3. <Trạng thái request/header bắt buộc>

## Các bước tái hiện

1. <Thao tác xác định, truy vết được về test case chính>
2. <Thao tác gửi request>
3. <Quan sát response hoặc trạng thái>
4. <Xác minh bên ngoài nếu cần>

## Kết quả mong đợi

<Bất biến nghiệp vụ hoặc trạng thái có thẩm quyền. Không tự tạo HTTP status, response body hoặc schema nếu nguồn không quy định.>

## Kết quả thực tế

<Hành vi quan sát được từ lần chạy Newman thật đã xác định và bằng chứng bên ngoài đã được phê duyệt.>

## Mức độ ảnh hưởng

<Ảnh hưởng thực tế nằm trong phạm vi bằng chứng quan sát được.>

## Mức độ nghiêm trọng

**Nghiêm trọng (Critical) | Cao (High) | Trung bình (Medium) | Thấp (Low)**

Lý do: <Giải thích ngắn gọn, có giới hạn theo bằng chứng.>

## Test case chính

`CASE-ID`

## Các test case hỗ trợ

- `CASE-ID`

Dùng `- Không có.` khi cụm nguyên nhân gốc đã xác nhận không có test case hỗ trợ.

## Bằng chứng thực thi

- Newman JSON: `test-results/hw06/run-00X/newman.json`
- Newman HTML: `test-results/hw06/run-00X/newman.html`
- Xác minh bên ngoài: `<đường dẫn tương đối có thật trong repository>`

Lược bỏ dòng xác minh bên ngoài khi không cần artifact riêng. Không tự tạo đường dẫn bằng chứng.

## Ảnh minh chứng

`PENDING_HUMAN_CAPTURE`

## Xác nhận của sinh viên

`CONFIRMED_PRODUCT_DEFECT`

