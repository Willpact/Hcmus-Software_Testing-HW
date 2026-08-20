# API-03 Corrected AI-generated Suite

- Source remains `AI_GENERATED`; raw case IDs are stable and raw files are unchanged.
- Status: `HUMAN_APPROVED_AI_CORRECTION`; execution: `REAL_EXECUTION_REQUIRED`.

## Summary

- `RAW_AI_GENERATED`: 40
- `VALID_AFTER_AUDIT`: 25
- `INVALID_REMOVED`: 0
- `INCOMPLETE_SALVAGED`: 3
- `INCOMPLETE_DEFERRED`: 12
- `FINAL_EXECUTABLE_AI_CASES`: 28

## Primary-technique coverage

- `DOMAIN_PARTITION`: 8
- `BOUNDARY`: 2
- `STATE_TRANSITION`: 7
- `SECURITY`: 7
- `SCHEMA`: 2
- `BUSINESS_RULE`: 2

## Executable AI-generated cases

### API03-AI-001 — Admin import một product hợp lệ

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-002, API03-REQ-004, API03-REQ-007, API03-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra JSON products array hợp lệ với admin JWT.
- Expected business result: Batch hợp lệ đủ điều kiện import.
- Expected state: Toàn bộ một item được commit và report được tạo.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-002 — Admin import nhiều product hợp lệ

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-004, API03-REQ-007, API03-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra feature multi-product và atomic commit cho batch hợp lệ.
- Expected business result: Toàn bộ batch hợp lệ được xử lý như một import.
- Expected state: Tất cả item được commit; report phản ánh batch.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-003 — Thiếu products

- Audit classification: `INCOMPLETE`; disposition: `SALVAGED_TO_EXECUTABLE`
- Correction summary: Removed the transport-response assumption and added a no-import state assertion tied to the documented products array.
- Requirements: `API03-REQ-004`; oracle: `PARTIALLY_SPECIFIED`
- Objective: Verify that a request without the documented products array cannot import product rows.
- Expected business result: No product row can be imported because the endpoint request contains no products array.
- Expected state: The products snapshot remains unchanged.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-004 — products bằng null

- Audit classification: `INCOMPLETE`; disposition: `SALVAGED_TO_EXECUTABLE`
- Correction summary: Added a deterministic no-commit assertion for a non-array null representation.
- Requirements: `API03-REQ-004`; oracle: `PARTIALLY_SPECIFIED`
- Objective: Verify that products=null does not produce imported rows because products must use the documented array representation.
- Expected business result: No product is imported from a null value; exact status and response schema remain unspecified.
- Expected state: The products snapshot remains unchanged.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-005 — products là object

- Audit classification: `INCOMPLETE`; disposition: `SALVAGED_TO_EXECUTABLE`
- Correction summary: Added a deterministic no-commit assertion for the wrong top-level products type.
- Requirements: `API03-REQ-004`; oracle: `PARTIALLY_SPECIFIED`
- Objective: Verify that products as an object does not produce imported rows because the endpoint documents an array.
- Expected business result: No product is imported from a non-array object; exact status and response schema remain unspecified.
- Expected state: The products snapshot remains unchanged.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-007 — Item thiếu name

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-005, API03-REQ-007`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra name non-empty trực tiếp của FR-16.
- Expected business result: Không chấp nhận row thiếu name hợp lệ.
- Expected state: Nếu cùng batch có item khác, toàn batch rollback.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-008 — Item name rỗng

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-007`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra chuỗi rỗng vi phạm non-empty.
- Expected business result: Row lỗi vì name không non-empty.
- Expected state: Toàn batch rollback.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-009 — Price bằng zero

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-007`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra đúng biên không dương.
- Expected business result: Row lỗi vì price phải positive.
- Expected state: Toàn batch rollback.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-010 — Price âm

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-007`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra lớp price negative.
- Expected business result: Row lỗi vì price không positive.
- Expected state: Toàn batch rollback.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-011 — Price dương nhỏ

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-007`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra phía hợp lệ ngay trên zero mà không tự định nghĩa precision tối đa.
- Expected business result: Price lớn hơn zero thỏa quy tắc positivity; numeric precision vẫn cần quan sát.
- Expected state: Nếu mọi row hợp lệ, toàn batch commit.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-016 — Batch valid commit toàn bộ

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra pre-state sang post-state có toàn bộ rows khi không có lỗi.
- Expected business result: Không có row error nên batch đủ điều kiện commit.
- Expected state: Post-state có toàn bộ item mới, không phải một phần.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-017 — Row đầu invalid

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-007, API03-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra rollback khi lỗi nằm ở vị trí đầu.
- Expected business result: Bất kỳ row lỗi làm toàn import thất bại.
- Expected state: Không item nào của batch được persist.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-018 — Row giữa invalid

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-007, API03-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra không có partial persistence trước row lỗi giữa batch.
- Expected business result: Lỗi giữa batch làm rollback toàn bộ.
- Expected state: Không giữ các row valid đứng trước hoặc sau.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-019 — Row cuối invalid

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-007, API03-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra rollback cả các insert trước row lỗi cuối.
- Expected business result: Lỗi cuối vẫn làm toàn batch thất bại.
- Expected state: Không item nào của batch được persist.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-020 — Nhiều row invalid

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-007, API03-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra atomicity và report khi batch có nhiều lỗi.
- Expected business result: Batch không được partial commit; report cần counts/reasons.
- Expected state: Products state không đổi bởi batch.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-021 — Retry batch đã sửa

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-009`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra sau rollback có thể gửi một batch mới hợp lệ mà không mang partial state cũ.
- Expected business result: Batch retry được đánh giá độc lập và nếu hợp lệ có thể commit toàn bộ.
- Expected state: Chỉ dữ liệu từ lần retry hợp lệ xuất hiện.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-022 — Report sau batch lỗi

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-010`; oracle: `PARTIALLY_SPECIFIED`
- Objective: Kiểm tra report có success/error counts và reasons mà không bịa field names.
- Expected business result: Report thể hiện số thành công/lỗi và lý do ở mức semantic; exact schema unspecified.
- Expected state: Atomic rollback vẫn được hậu kiểm độc lập.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-023 — Thiếu Authorization

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-002, API03-REQ-011`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra import không được thực hiện khi thiếu JWT.
- Expected business result: Không cho truy cập sensitive import endpoint.
- Expected state: Products state không đổi bởi import được phép.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-024 — Bearer JWT malformed

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-002, API03-REQ-011`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra token không hợp lệ không đủ quyền import.
- Expected business result: Không cho import với JWT không hợp lệ.
- Expected state: Products state không đổi.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-025 — JWT hết hạn

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-002, API03-REQ-011`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra expired token không thỏa valid JWT.
- Expected business result: Không cho import với token hết hạn.
- Expected state: Products state không đổi.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-026 — JWT user không phải admin

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-002, API03-REQ-003`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra role enforcement chứ không chỉ token existence.
- Expected business result: Không cho non-admin import.
- Expected state: Products state không đổi.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-027 — JWT admin hợp lệ

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-002, API03-REQ-003`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra positive authorization partition.
- Expected business result: Admin đã xác thực đủ điều kiện authorization; business validation vẫn áp dụng.
- Expected state: State phụ thuộc atomic validation của batch.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-028 — Payload tự khai role admin

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-003`; oracle: `SECURITY_EXPECTATION`
- Objective: Kiểm tra field role trong body không thay thế role đã xác minh trong token.
- Expected business result: Không được nâng quyền từ payload; role phải lấy từ token đã verify.
- Expected state: Products state không đổi.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-029 — Injection trong product name

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-007, API03-REQ-011`; oracle: `SECURITY_EXPECTATION`
- Objective: Kiểm tra name được xử lý như dữ liệu và vẫn qua non-empty validation.
- Expected business result: Input không được thực thi như lệnh hoặc phá dữ liệu ngoài phạm vi; name vẫn là non-empty data.
- Expected state: Nếu batch được chấp nhận, chỉ atomic import side effect được phép.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-031 — JSON products với đủ field documented

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-001, API03-REQ-004, API03-REQ-005`; oracle: `PARTIALLY_SPECIFIED`
- Objective: Xác nhận endpoint representation là JSON array và item gồm các field tài liệu hóa.
- Expected business result: Request phù hợp endpoint contract; requiredness và response schema còn chưa đầy đủ.
- Expected state: Nếu row hợp lệ, atomic state rule áp dụng.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-035 — Xác nhận boundary JSON của endpoint

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: Traceability corrected so API03-REQ-004 is primary; API03-RG-001 is the related gap and API03-REQ-006 is supporting context.
- Requirements: `API03-REQ-004, API03-REQ-006`; oracle: `PARTIALLY_SPECIFIED`
- Objective: Bao phủ gap CSV-vs-JSON bằng request JSON products chứ không giả định raw CSV.
- Expected business result: Selected endpoint được kiểm tra theo JSON contract; vị trí CSV parsing vẫn unresolved.
- Expected state: State theo atomic import rules.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-038 — All-or-nothing đối chiếu report

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-009, API03-REQ-010`; oracle: `AUTHORITATIVE`
- Objective: Đối chiếu report semantic với persistence để phát hiện partial import.
- Expected business result: Report phải nêu counts/reasons và batch phải rollback toàn bộ do có lỗi.
- Expected state: Không item mới nào tồn tại dù report có success-row count trung gian.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API03-AI-039 — Report batch thành công

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API03-REQ-010`; oracle: `PARTIALLY_SPECIFIED`
- Objective: Kiểm tra report có success/error counts và reasons ở mức semantic.
- Expected business result: Report phản ánh số row thành công/lỗi và lý do phù hợp; exact keys/types unspecified.
- Expected state: Toàn batch commit.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

## Removed INVALID cases

## Deferred requirement gaps
- `API03-AI-006` — Concept/risk 'products array rỗng' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API03-AI-012` — Concept/risk 'Name dài đúng 255' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API03-AI-013` — Concept/risk 'Name dài 256' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API03-AI-014` — Concept/risk 'Batch kích thước lớn' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API03-AI-015` — Concept/risk 'Price có nhiều chữ số thập phân' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API03-AI-030` — Concept/risk 'Unexpected privileged fields' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API03-AI-032` — Concept/risk 'Thiếu optionality-unknown fields' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API03-AI-033` — Concept/risk 'Sai type description' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API03-AI-034` — Concept/risk 'category_id không tồn tại' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API03-AI-036` — Concept/risk 'Name chỉ whitespace' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API03-AI-037` — Concept/risk 'Price dạng chuỗi số' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API03-AI-040` — Concept/risk 'Duplicate products trong cùng batch' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
