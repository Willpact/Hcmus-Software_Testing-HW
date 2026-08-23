# Kế hoạch chụp evidence thật cho 9 Product Defect HW06

- `SCREENSHOT_CAPTURE_METHOD: GENUINE_WINDOWS_TERMINAL_NATIVE_CAPTURE`
- `SCREENSHOT_AUTOMATION: CLOSED`
- `SYNTHETIC_OR_COMPOSITE_SCREENSHOT: PROHIBITED`
- `SCREENSHOT_STATUS: CAPTURED_GENUINE_WINDOWS_TERMINAL`
- `NEWMAN_ONLY: 1`
- `BOTH: 8`
- `EXTERNAL_ONLY: 0`
- `FIXED_SCREENSHOT_COUNT: NO`

Hai report Newman đều không có assertion failure: `run-001` có `103` requests, `191` assertions, `0` assertion failed; `run-002` có `179` requests, `116` assertions, `0` assertion failed. Vì vậy không tìm dòng `Failed Tests`, assertion màu đỏ hoặc dựng lại giao diện lỗi không tồn tại.

Ảnh Newman chỉ chứng minh request thật đã được thực thi và hành vi thực tế đã được quan sát: case ID, request title, input quan trọng không nhạy cảm, HTTP status và response body/business result. Khi external verification là bằng chứng quyết định, ảnh Newman chỉ là execution-context evidence.

`BOTH` nghĩa là có hai nhóm evidence độc lập:

- Ảnh A: Newman execution context thật.
- Ảnh B: external/state evidence thật.

Không bắt buộc hai nhóm evidence nằm trong cùng một ảnh. Không ghép ảnh composite giả. Nếu một ảnh thật duy nhất hiển thị an toàn và đầy đủ evidence cần thiết thì có thể dùng một ảnh. Theo cách một ảnh cho mỗi nhóm, matrix có thể cần khoảng `17` ảnh (`1` Newman-only + `8 × 2`), nhưng không tạo ảnh thừa để đạt số lượng.

## Matrix yêu cầu screenshot

| DEFECT_ID | REQUIREMENT | NEWMAN CAPTURE                                                                               | EXTERNAL/STATE CAPTURE                                                                           |
| --------- | ----------- | -------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| DEF-01    | BOTH        | `API02-AI-002`: `total_amount = 1`, HTTP `200`, `Checkout successful`                        | Order ID `3`: persisted total `1` so với cart total tính độc lập `400000`                        |
| DEF-02    | BOTH        | `API02-AI-014`: checkout thành công                                                          | Postcheck: cart chính còn `2` dòng, cart thứ hai còn `1` dòng                                    |
| DEF-03    | NEWMAN      | `API02-AI-022`: Basic scheme đã che JWT, HTTP `200`, `Checkout successful`                   | Không yêu cầu                                                                                    |
| DEF-04    | BOTH        | `API03-AI-009`: `price = 0`, HTTP `200`, `inserted = 1`, `errors = 0`                        | SQLite: product giá `0` persisted                                                                |
| DEF-05    | BOTH        | `API03-AI-017`: dòng đầu tên rỗng, dòng hai hợp lệ; HTTP `200`, `inserted = 1`, `errors = 1` | SQLite: dòng hợp lệ thứ hai persisted từ batch không hợp lệ                                      |
| DEF-06    | BOTH        | `API03-AI-026`: ngữ cảnh non-admin đã che JWT; HTTP `200`, `inserted = 1`, `errors = 0`      | SQLite: product của request non-admin persisted                                                  |
| DEF-07    | BOTH        | `API01-AI-007`: body thiếu `newPassword`; HTTP `200`, `Password reset successfully`          | Database đổi, token bị consume và retry hợp lệ nhận HTTP `400`                                   |
| DEF-08    | BOTH        | `API01-AI-018`: chỉ hiện đặc tính mật khẩu yếu, không hiện giá trị; HTTP `200`, success body | `WEAK_PLAINTEXT`, database đổi và token bị consume; không hiện password                          |
| DEF-09    | BOTH        | `API01-AI-035`: reset thực thi, HTTP `200`; chỉ là execution context                         | Kết quả read-only: `user_found = true`, `PLAINTEXT_EQUAL = YES`, `password_value_logged = false` |

## Nguồn mở để chụp

### Newman

- `test-results/hw06/run-001/newman.html` cho DEF-01 đến DEF-06.
- `test-results/hw06/run-002/newman.html` cho DEF-07 đến DEF-09.

### External/state

- DEF-01: `test-results/hw06/run-001/external-verification-results.json` và `test-results/hw06/runtime/sut-db-003/database.sqlite`.
- DEF-02: `test-results/hw06/run-001/external-postcheck.newman.json` và `test-results/hw06/run-001/external-verification-results.json`.
- DEF-04/05/06: `test-results/hw06/runtime/sut-db-003/database.sqlite`; external verification này được bổ sung trong hậu kiểm Human triage sau thực thi.
- DEF-07/08: `test-results/hw06/run-002/external-hook-evidence.json` và final Human review packet.
- DEF-09: `test-results/hw06/run-002/external-verification-results.json`.

## Quy tắc che dữ liệu

Trước khi chụp, che hoàn toàn JWT/token value, password/plaintext/hash, Student ID value, email hoặc định danh cá nhân, credentials và dữ liệu riêng tư. Với DEF-03 và DEF-06 chỉ giữ lại tên scheme hoặc ngữ cảnh role; không để lộ token. Với DEF-08 và DEF-09 chỉ hiện classification/boolean an toàn, không hiện password hoặc hash.

Capture đã hoàn tất bằng Windows terminal native pixel capture: `17` PNG (`9` request/response, `8` external/state). Đường dẫn đã được ghi vào defect report/GitHub Issue draft chỉ sau khi file tồn tại và được validate; xem `evidence-capture-result.md`.
