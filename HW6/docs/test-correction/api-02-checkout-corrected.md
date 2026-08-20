# API-02 Corrected AI-generated Suite

- Source remains `AI_GENERATED`; raw case IDs are stable and raw files are unchanged.
- Status: `HUMAN_APPROVED_AI_CORRECTION`; execution: `REAL_EXECUTION_REQUIRED`.

## Summary

- `RAW_AI_GENERATED`: 40
- `VALID_AFTER_AUDIT`: 23
- `INVALID_REMOVED`: 1
- `INCOMPLETE_SALVAGED`: 2
- `INCOMPLETE_DEFERRED`: 14
- `FINAL_EXECUTABLE_AI_CASES`: 25

## Primary-technique coverage

- `DOMAIN_PARTITION`: 7
- `BOUNDARY`: 2
- `STATE_TRANSITION`: 4
- `SECURITY`: 7
- `SCHEMA`: 1
- `BUSINESS_RULE`: 4

## Executable AI-generated cases

### API02-AI-001 — Checkout hợp lệ với cart có hàng

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-002, API02-REQ-005, API02-REQ-006, API02-REQ-007`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra happy path dùng JWT hợp lệ và backend lấy tổng từ cart.
- Expected business result: Checkout đủ điều kiện; tổng có thẩm quyền là tổng backend tính từ cart.
- Expected state: Nếu thành công, cart của user được xóa.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-002 — Client total thấp hơn cart

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-005, API02-REQ-006`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra backend không tin giá trị total_amount bị giảm.
- Expected business result: Kết quả checkout không được dùng 1 làm tổng có thẩm quyền; backend phải tính từ cart.
- Expected state: Nếu thành công, side effect cart tuân API02-REQ-007.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-003 — Client total cao hơn cart

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-005, API02-REQ-006`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra backend không tin giá trị total_amount bị tăng.
- Expected business result: Tổng có thẩm quyền vẫn phải do backend tính từ cart.
- Expected state: Nếu thành công, cart được xóa.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-004 — Client total bằng zero

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-005, API02-REQ-006`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra zero không thay thế tổng cart dương.
- Expected business result: Backend không được nhận zero làm tổng checkout có thẩm quyền.
- Expected state: Nếu thành công, cart được xóa.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-005 — Client total âm

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-005, API02-REQ-006`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra giá trị âm không điều khiển tổng thanh toán.
- Expected business result: Backend phải bỏ quyền quyết định khỏi giá trị client và tính từ cart.
- Expected state: Nếu thành công, cart được xóa.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-006 — Client total dạng chuỗi

- Audit classification: `INCOMPLETE`; disposition: `SALVAGED_TO_EXECUTABLE`
- Correction summary: Converted unspecified type coercion into a two-outcome invariant that never permits client total authority.
- Requirements: `API02-REQ-003, API02-REQ-006`; oracle: `PARTIALLY_SPECIFIED`
- Objective: Verify the cart-derived total invariant when client total_amount is a numeric string.
- Expected business result: Acceptable outcomes are rejection without successful-checkout side effects, or successful checkout using the backend cart-derived total; the client string never becomes authoritative.
- Expected state: If checkout succeeds the authenticated user cart is cleared; otherwise no success-side-effect claim is made.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-007 — Thiếu total_amount

- Audit classification: `INCOMPLETE`; disposition: `SALVAGED_TO_EXECUTABLE`
- Correction summary: Removed the requiredness assumption and retained the authoritative server-calculation invariant.
- Requirements: `API02-REQ-003, API02-REQ-006`; oracle: `PARTIALLY_SPECIFIED`
- Objective: Verify the cart-derived total invariant when total_amount is omitted.
- Expected business result: Acceptable outcomes are rejection without successful-checkout side effects, or successful checkout using the backend cart-derived total.
- Expected state: If checkout succeeds the authenticated user cart is cleared; otherwise no success-side-effect claim is made.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-009 — Cart một dòng hàng

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-005, API02-REQ-006`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra nguồn tổng với cart nhỏ nhất có một dòng theo precondition context.
- Expected business result: Backend tính tổng từ cart hiện tại.
- Expected state: Nếu thành công, cart chuyển sang rỗng.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-010 — Cart nhiều dòng hàng

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-005, API02-REQ-006`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra backend cộng toàn bộ cart thay vì lấy một phần.
- Expected business result: Tổng có thẩm quyền phản ánh cart đầy đủ theo FR-08, không phải client total.
- Expected state: Nếu thành công, toàn bộ cart được xóa.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-014 — Cart populated đến cleared

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-005, API02-REQ-007`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra trực tiếp chuyển trạng thái sau checkout thành công.
- Expected business result: Checkout thành công sử dụng tổng cart.
- Expected state: Cart của authenticated user trở thành rỗng.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-016 — Cart đổi trước thời điểm checkout

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-005, API02-REQ-006`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra tổng được tính từ trạng thái cart hiện tại chứ không từ snapshot client.
- Expected business result: Backend dùng cart hiện tại để tính tổng.
- Expected state: Nếu thành công, cart hiện tại được xóa.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-017 — Hai user có cart khác nhau

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-004, API02-REQ-005`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra checkout của user A không lấy tổng hoặc state cart của user B.
- Expected business result: Tổng phải được tính từ cart gắn với authenticated user A.
- Expected state: Nếu thành công, chỉ cart A được xóa; cart B không bị tác động.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-018 — Auth thất bại trước checkout

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-002, API02-REQ-004`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra thiếu auth không tiến hành checkout.
- Expected business result: Không cho user chưa xác thực checkout.
- Expected state: Cart baseline không bị clear bởi checkout thành công.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-021 — Thiếu Authorization header

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-002, API02-REQ-004, API02-REQ-010`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra sensitive checkout bắt buộc có JWT.
- Expected business result: Không cho checkout khi không có JWT hợp lệ.
- Expected state: Không áp dụng side effect success lên cart.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-022 — Authorization sai scheme

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-002, API02-REQ-010`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra chuỗi auth không theo Bearer không thỏa contract.
- Expected business result: Không coi header này là valid bearer JWT.
- Expected state: Không clear cart do checkout thành công.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-023 — Bearer token malformed

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-002, API02-REQ-010`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra token không phải JWT hợp lệ.
- Expected business result: Không cho checkout với JWT không hợp lệ.
- Expected state: Cart không bị clear bởi checkout thành công.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-024 — Bearer token hết hạn

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-002, API02-REQ-010`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra expired JWT không thỏa yêu cầu valid token.
- Expected business result: Không cho checkout với token hết hạn.
- Expected state: Cart không bị clear bởi checkout thành công.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-025 — Total dạng biểu thức injection

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-005, API02-REQ-006`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra input total không thể chi phối persistence hoặc vượt qua server recalculation.
- Expected business result: Client input không được dùng làm tổng có thẩm quyền; truy vấn phải giữ ranh giới dữ liệu.
- Expected state: Không có thay đổi dữ liệu ngoài checkout được phép.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-026 — Injection trong shipping_address

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-003, API02-REQ-011`; oracle: `SECURITY_EXPECTATION`
- Objective: Kiểm tra địa chỉ được xử lý như dữ liệu, không như câu lệnh.
- Expected business result: Không được thực thi nội dung input như lệnh hoặc phá dữ liệu ngoài phạm vi.
- Expected state: Nếu checkout thành công, cart clear; dữ liệu khác còn nguyên.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-027 — JWT user không khớp cart client tham chiếu

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-002, API02-REQ-004`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra identity từ JWT quyết định cart, không từ payload suy diễn.
- Expected business result: Checkout chỉ được gắn với user đã xác thực; không được tác động cart B.
- Expected state: Cart B không đổi.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-029 — Request đúng header và body documented

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-001, API02-REQ-002, API02-REQ-003`; oracle: `PARTIALLY_SPECIFIED`
- Objective: Xác nhận shape cơ sở gồm Bearer, total_amount, shipping_address.
- Expected business result: Request phù hợp contract đầu vào; response status/schema chưa được quy định.
- Expected state: Nếu thành công, cart clear.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-034 — Backend recompute với client total khớp

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-005, API02-REQ-006`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra việc trùng giá trị không che mất nghĩa vụ đọc cart và tính lại.
- Expected business result: Cần evidence backend-derived total; equality alone không chứng minh client được tin.
- Expected state: Nếu thành công, cart clear.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-035 — Client total có phần thập phân khác

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-005, API02-REQ-006`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra tampering nhỏ không được dùng làm tổng có thẩm quyền.
- Expected business result: Backend dùng total tính từ cart.
- Expected state: Nếu thành công, cart clear.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-036 — Clear đúng cart sau success

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-007`; oracle: `AUTHORITATIVE`
- Objective: Kiểm tra side effect clear nhắm đúng authenticated user's cart.
- Expected business result: Checkout thành công của A không xác lập quy tắc cho B.
- Expected state: Cart A rỗng; cart B giữ nguyên.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

### API02-AI-037 — Cart có quantity nhiều hơn một

- Audit classification: `VALID`; disposition: `INCLUDED_EXECUTABLE`
- Correction summary: No semantic correction required; Human-approved audit classification retained.
- Requirements: `API02-REQ-005, API02-REQ-006, API02-REQ-008`; oracle: `AUTHORITATIVE`
- Objective: Dùng FR-07 chỉ làm precondition để kiểm tra total của FR-08 từ cart hiện tại.
- Expected business result: Backend total phản ánh cart hiện tại theo FR-08; không biến quy tắc merge FR-07 thành checkout oracle.
- Expected state: Nếu thành công, cart được xóa.
- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`

## Removed INVALID cases
- `API02-AI-028` — Case gửi hai request trùng tuần tự gần nhau không tạo equivalence class khác rõ ràng so với replay sau success ở API02-AI-015; concurrency thực sự đã được tách ở API02-AI-020.

## Deferred requirement gaps
- `API02-AI-008` — Concept/risk 'Thiếu shipping_address' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API02-AI-011` — Concept/risk 'Cart rỗng' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API02-AI-012` — Concept/risk 'Địa chỉ chuỗi rỗng' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API02-AI-013` — Concept/risk 'Địa chỉ rất dài' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API02-AI-015` — Concept/risk 'Gửi lại checkout sau thành công' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API02-AI-019` — Concept/risk 'Input body lỗi và cart state' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API02-AI-020` — Concept/risk 'Hai checkout đồng thời' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API02-AI-030` — Concept/risk 'Body null' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API02-AI-031` — Concept/risk 'Body là array' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API02-AI-032` — Concept/risk 'Malformed JSON' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API02-AI-033` — Concept/risk 'Sai Content-Type' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API02-AI-038` — FR-09 is supporting/cross-feature context; no authoritative source defines coupon integration with POST /api/checkout.
- `API02-AI-039` — Concept/risk 'Quan sát initial order status' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- `API02-AI-040` — Concept/risk 'Quan sát order-line persistence' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
