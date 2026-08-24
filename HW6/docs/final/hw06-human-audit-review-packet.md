# HW06 Human Audit review packet

Bốn quyết định dưới đây đã được Human cung cấp và đã được áp dụng vào `docs/ai-audit/AI_AUDIT_LOG.md`. Packet giữ lại mapping review để truy vết, không thay đổi các Human Decision đã có.

| REVIEW_ID | WHAT_TO_CHECK | RECOMMENDED | REASON | RELATED_ARTIFACT |
| --- | --- | --- | --- | --- |
| A-015 | Preflight recovery chỉ là guard/diagnostic; không đổi SUT, credential hoặc tạo execution result. | `APPROVED` — `VALID` / `ACCEPTED_AS_IS` | Scope được Human xác nhận; không cần correction. | `test-results/hw06/preflight-003/`, `docs/ai-audit/interactions/A-015-*` |
| A-016 | Startup recovery không biến startup diagnostic thành test result và không vượt SUT boundary. | `APPROVED` — `VALID` / `ACCEPTED_AS_IS` | SQLite redirect environment-only được Human chấp nhận. | `docs/ai-audit/interactions/A-016-*`, execution metadata liên quan |
| A-017 | Harness/test-data correction không che Product Defect; execution thật khác validation tĩnh. | `APPROVED` — `VALID` / `ACCEPTED_AS_IS` | Failed smoke được preserve; correction không đổi SUT/oracle. | `test-results/hw06/smoke-001/`, `smoke-002/`, `docs/ai-audit/interactions/A-017-*` |
| A-022 | 9-defect mapping, 38 evidence-case accounting, state oracle và 17 screenshot thật khớp matrix; không rerun/sửa SUT. | `APPROVED` — `VALID` / `ACCEPTED_AS_IS` | Scope lịch sử trước capture/issue được Human chấp nhận; không retroactively mở rộng scope. | `docs/defects/evidence-matrix.md`, `docs/defects/screenshots/`, `docs/ai-audit/interactions/A-022-*` |
