# HW06 Excel testcase export handoff

## Trạng thái

`SUPERSEDED`: User đã cho phép dùng `openpyxl`; workbook thật hiện có tại [HW06-Test-Cases-and-Summary.xlsx](HW06-Test-Cases-and-Summary.xlsx). File handoff này chỉ giữ source/cấu trúc để Human truy xuất, không phải placeholder thay Excel.

## Source canonical để Human export

- `test-cases/final/cross-api-final-summary.json`
- `test-cases/final/` — testcase đã Human Audit
- `test-cases/student-added/` — 15 testcase do sinh viên bổ sung
- `docs/test-suite/final-executable-suite.md` — summary và traceability

## Workbook đề xuất (không đổi classification lịch sử)

1. `Summary`: API, raw AI candidates, AI hợp lệ sau audit, Student-added, executable, deferred và invalid.
2. `API-01`, `API-02`, `API-03`: một dòng trên stable testcase ID, các cột `case_id`, `source`, `review_status`, `technique`, `requirement_ids`, `setup_requirements`, `execution_mode`, `external_verification`, `final_disposition`.
3. Không thêm “Passed/Failed” từ static manifest; nếu cần execution outcome, liên kết đúng run/case từ `docs/execution-results/cross-api-execution-summary.md` và giữ distinction Newman assertion với business/state oracle.

## Human action

Human visual-review workbook, filter/freeze header, công thức summary và safe-data boundary trước nộp. Không thay đổi historical testcase classification khi chỉnh presentation.
