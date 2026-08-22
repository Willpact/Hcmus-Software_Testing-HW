# Kết quả capture genuine evidence HW06

- CAPTURE_METHOD: `Windows terminal` + native `System.Drawing.Graphics.CopyFromScreen`.
- NEWMAN_RERUN: `NO`.
- SUT_RESTARTED: `NO`.
- PRODUCTION_CODE_MODIFIED: `NO`.
- AI_AUDIT_USED: `NO`.
- SECRET_CHECK: `PASS`.

## Tổng hợp

| Nhóm | Số ảnh | Kết quả |
| --- | ---: | --- |
| Request/response execution | 9 | PASS |
| External/state | 8 | PASS |
| Tổng | 17 | PASS |

Mỗi ảnh mở artifact thật bằng parser read-only, chỉ in field cần thiết và chụp pixel cửa sổ terminal thật. `run-001` và `run-002` đều có 0 Newman assertion failure; các ảnh chỉ ghi `BUSINESS/STATE VERDICT: FAIL` khi artifact xác nhận hành vi/state lỗi, không tuyên bố assertion failure.

## Danh sách ảnh

| DEFECT_ID | Evidence A | Evidence B |
| --- | --- | --- |
| DEF-01 | `screenshots/DEF-01-A-request-response.png` | `screenshots/DEF-01-B-state-evidence.png` |
| DEF-02 | `screenshots/DEF-02-A-request-response.png` | `screenshots/DEF-02-B-state-evidence.png` |
| DEF-03 | `screenshots/DEF-03-A-request-response.png` | Không yêu cầu |
| DEF-04 | `screenshots/DEF-04-A-request-response.png` | `screenshots/DEF-04-B-state-evidence.png` |
| DEF-05 | `screenshots/DEF-05-A-request-response.png` | `screenshots/DEF-05-B-state-evidence.png` |
| DEF-06 | `screenshots/DEF-06-A-request-response.png` | `screenshots/DEF-06-B-state-evidence.png` |
| DEF-07 | `screenshots/DEF-07-A-request-response.png` | `screenshots/DEF-07-B-state-evidence.png` |
| DEF-08 | `screenshots/DEF-08-A-request-response.png` | `screenshots/DEF-08-B-state-evidence.png` |
| DEF-09 | `screenshots/DEF-09-A-request-response.png` | `screenshots/DEF-09-B-state-evidence.png` |

## Kiểm tra trước handoff

- Tất cả 17 PNG tồn tại, mở được, có kích thước `1180 x 500` và không blank.
- Output chụp không có JWT, Bearer credential, Authorization value, Postman-Token, Student ID value, password value/hash, email hay credential riêng tư.
- Với SQLite, parser chỉ gọi `sqlite3 -readonly` với câu lệnh `SELECT`.

NEXT_CHECKPOINT: `HW06_BATCH_EVIDENCE_HUMAN_REVIEW_REQUIRED`.
