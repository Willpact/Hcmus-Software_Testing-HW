# Ma trận nguồn evidence của 9 Product Defect HW06

Ma trận này phân biệt evidence Newman với evidence lỗi quyết định. Cả `run-001` và `run-002` đều có `0` Newman assertion failure; vì vậy không defect nào trong chín defect được xác nhận bằng assertion failure.

| DEFECT_ID | PRIMARY_CASE | NEWMAN_EVIDENCE | EXTERNAL_EVIDENCE | PRIMARY_FAILURE_EVIDENCE | SCREENSHOT_REQUIREMENT |
| --- | --- | --- | --- | --- | --- |
| DEF-01 | `API02-AI-002` | Request `total_amount = 1`; HTTP `200`, `Checkout successful`; execution context | `run-001/external-verification-results.json` + SQLite `sut-db-003`: order ID `3` total `1` so với cart total `400000` | `EXTERNAL_STATE` — persisted total mismatch | `BOTH` |
| DEF-02 | `API02-AI-014` | Checkout thực sự hoàn tất thành công; execution context | `external-postcheck.newman.json` + `external-verification-results.json`: cart chính còn `2` dòng, cart thứ hai còn `1` dòng | `EXTERNAL_STATE` — cart không đổi sau checkout | `BOTH` |
| DEF-03 | `API02-AI-022` | `Authorization: Basic <valid-JWT>` được chấp nhận; HTTP `200`, `Checkout successful` | Không dùng | `NEWMAN_REQUEST_RESPONSE` — sai authorization scheme vẫn thành công | `NEWMAN` |
| DEF-04 | `API03-AI-009` | `price = 0`; HTTP `200`, `inserted = 1`, `errors = 0` | SQLite `sut-db-003`: product giá `0` persisted; bổ sung trong hậu kiểm Human triage | `BOTH` — chấp nhận và persisted dữ liệu sai | `BOTH` |
| DEF-05 | `API03-AI-017` | Dòng đầu tên rỗng, dòng hai hợp lệ; HTTP `200`, `inserted = 1`, `errors = 1` | SQLite `sut-db-003`: dòng hợp lệ thứ hai persisted; bổ sung trong hậu kiểm Human triage | `BOTH` — partial success và partial persistence | `BOTH` |
| DEF-06 | `API03-AI-026` | JWT non-admin; HTTP `200`, `inserted = 1`, `errors = 0` | SQLite `sut-db-003`: product của request non-admin persisted; bổ sung trong hậu kiểm Human triage | `BOTH` — role bypass và catalog side effect | `BOTH` |
| DEF-07 | `API01-AI-007` | Body có `email`, `resetToken`, thiếu `newPassword`; HTTP `200`, `Password reset successfully` | `external-hook-evidence.json`: database đổi, token bị consume; retry hợp lệ HTTP `400` | `BOTH` — business failure trực tiếp và side effect | `BOTH` |
| DEF-08 | `API01-AI-018` | Password dài `4`, thiếu uppercase/digit/special; HTTP `200`, success body | `external-hook-evidence.json`: `WEAK_PLAINTEXT`, database đổi, token bị consume | `BOTH` — weak password được chấp nhận và persisted | `BOTH` |
| DEF-09 | `API01-AI-035` | Reset thực thi, HTTP `200`; execution context | `external-verification-results.json`: `user_found = true`, `PLAINTEXT_EQUAL = YES`, `password_value_logged = false` | `EXTERNAL_STATE` — read-only SQLite comparison | `BOTH` |

## Screenshot capture hoàn tất

Các ảnh dưới đây là pixel thật của Windows terminal. Terminal chỉ hiển thị các field an toàn được trích trực tiếp từ artifact; không chứa JWT, token, Student ID, password/hash hay credential.

| DEFECT_ID | REQUEST/RESPONSE | EXTERNAL/STATE |
| --- | --- | --- |
| DEF-01 | `docs/defects/screenshots/DEF-01-A-request-response.png` | `docs/defects/screenshots/DEF-01-B-state-evidence.png` |
| DEF-02 | `docs/defects/screenshots/DEF-02-A-request-response.png` | `docs/defects/screenshots/DEF-02-B-state-evidence.png` |
| DEF-03 | `docs/defects/screenshots/DEF-03-A-request-response.png` | Không yêu cầu |
| DEF-04 | `docs/defects/screenshots/DEF-04-A-request-response.png` | `docs/defects/screenshots/DEF-04-B-state-evidence.png` |
| DEF-05 | `docs/defects/screenshots/DEF-05-A-request-response.png` | `docs/defects/screenshots/DEF-05-B-state-evidence.png` |
| DEF-06 | `docs/defects/screenshots/DEF-06-A-request-response.png` | `docs/defects/screenshots/DEF-06-B-state-evidence.png` |
| DEF-07 | `docs/defects/screenshots/DEF-07-A-request-response.png` | `docs/defects/screenshots/DEF-07-B-state-evidence.png` |
| DEF-08 | `docs/defects/screenshots/DEF-08-A-request-response.png` | `docs/defects/screenshots/DEF-08-B-state-evidence.png` |
| DEF-09 | `docs/defects/screenshots/DEF-09-A-request-response.png` | `docs/defects/screenshots/DEF-09-B-state-evidence.png` |

## Đường dẫn evidence

- Newman run-001: `test-results/hw06/run-001/newman.json`, `test-results/hw06/run-001/newman.html`.
- Newman run-002: `test-results/hw06/run-002/newman.json`, `test-results/hw06/run-002/newman.html`.
- Checkout external: `test-results/hw06/run-001/external-verification-results.json`, `test-results/hw06/run-001/external-postcheck.newman.json`.
- Import SQLite: `test-results/hw06/runtime/sut-db-003/database.sqlite`.
- Reset external: `test-results/hw06/run-002/external-hook-evidence.json`, `test-results/hw06/run-002/external-verification-results.json`.
- Final Human verdict run-001: `docs/execution-results/human-failure-triage-packet.md`.
- Final Human verdict run-002: `docs/execution-results/run-002-new-defect-human-review-packet.md`.

`run-001/case-accounting.json` và `run-002/case-accounting.json` là artifact trạng thái lịch sử/preliminary. Không viết lại các file này; final classification lấy từ Human review packet tương ứng. Với DEF-04/05/06, external verification được thêm ở bước hậu kiểm sau thực thi và không thay đổi metadata test case gốc.

## Tổng hợp screenshot

- `NEWMAN_ONLY: 1`
- `BOTH: 8`
- `EXTERNAL_ONLY: 0`
- `SCREENSHOT_STATUS: CAPTURED_GENUINE_WINDOWS_TERMINAL`
- `SCREENSHOT_COUNT: 17` — `9` request/response và `8` external/state.
- `SECRET_CHECK: PASS` — output terminal được parser whitelist trước khi capture.

Hướng dẫn chụp thủ công: `docs/defects/screenshot-capture-plan.md`.
