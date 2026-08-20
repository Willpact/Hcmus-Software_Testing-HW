# API-02 AI-generated Test Cases — Checkout

- Status: `TEST_GENERATION_REVIEW_REQUIRED`
- Source: `AI_GENERATED`; lifecycle: `DRAFT`; audit: `NOT_AUDITED`; execution: `NOT_IMPLEMENTED`
- Approved input: `docs/requirement-analysis/api-02-checkout.md`
- Count: **40**; semantic duplicates removed: **0**
- No HTTP status or response schema was inferred: every case uses `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`.
- FR-07 and FR-09 remain supporting context; order-line persistence is observation only.

## Primary-technique coverage

| Technique | Count |
| --- | ---: |
| `DOMAIN_PARTITION` | 8 |
| `BOUNDARY` | 5 |
| `STATE_TRANSITION` | 7 |
| `SECURITY` | 8 |
| `SCHEMA` | 5 |
| `BUSINESS_RULE` | 7 |

## Oracle basis

| Basis | Count |
| --- | ---: |
| `AUTHORITATIVE` | 21 |
| `PARTIALLY_SPECIFIED` | 5 |
| `OBSERVABLE_ONLY` | 13 |
| `SECURITY_EXPECTATION` | 1 |

## Test cases

### API02-AI-001 — Checkout hợp lệ với cart có hàng

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API02-REQ-002, API02-REQ-005, API02-REQ-006, API02-REQ-007`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra happy path dùng JWT hợp lệ và backend lấy tổng từ cart.
- Preconditions: User đã đăng nhập; Cart của user có hàng
- Request variation: Bearer hợp lệ, body có total_amount và shipping_address
- Test data: client total bằng tổng cart để tránh nhiễu
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Checkout đủ điều kiện; tổng có thẩm quyền là tổng backend tính từ cart.
- Expected state: Nếu thành công, cart của user được xóa.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-002 — Client total thấp hơn cart

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API02-REQ-005, API02-REQ-006`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-ID-001`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra backend không tin giá trị total_amount bị giảm.
- Preconditions: JWT hợp lệ; Cart có tổng đã biết
- Request variation: total_amount nhỏ hơn tổng cart
- Test data: cart=100, client=1
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Kết quả checkout không được dùng 1 làm tổng có thẩm quyền; backend phải tính từ cart.
- Expected state: Nếu thành công, side effect cart tuân API02-REQ-007.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-003 — Client total cao hơn cart

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API02-REQ-005, API02-REQ-006`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-ID-001`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra backend không tin giá trị total_amount bị tăng.
- Preconditions: JWT hợp lệ; Cart có tổng đã biết
- Request variation: total_amount lớn hơn tổng cart
- Test data: cart=100, client=9999
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Tổng có thẩm quyền vẫn phải do backend tính từ cart.
- Expected state: Nếu thành công, cart được xóa.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-004 — Client total bằng zero

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API02-REQ-005, API02-REQ-006`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-ID-001`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra zero không thay thế tổng cart dương.
- Preconditions: JWT hợp lệ; Cart có tổng dương
- Request variation: total_amount=0
- Test data: cart total dương
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Backend không được nhận zero làm tổng checkout có thẩm quyền.
- Expected state: Nếu thành công, cart được xóa.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-005 — Client total âm

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API02-REQ-005, API02-REQ-006`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-ID-001`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra giá trị âm không điều khiển tổng thanh toán.
- Preconditions: JWT hợp lệ; Cart có tổng dương
- Request variation: total_amount=-1
- Test data: negative client total
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Backend phải bỏ quyền quyết định khỏi giá trị client và tính từ cart.
- Expected state: Nếu thành công, cart được xóa.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-006 — Client total dạng chuỗi

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API02-REQ-003, API02-REQ-006`
- Gap IDs: `API02-RG-001`; risk/potential-discrepancy IDs: `API02-ID-001`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Khảo sát type handling nhưng giữ oracle cốt lõi là không tin client total.
- Preconditions: JWT hợp lệ; Cart có tổng đã biết
- Request variation: total_amount là chuỗi số
- Test data: string value "100"
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận validation type; bất kể representation, client total không phải nguồn có thẩm quyền.
- Expected state: State chỉ được khẳng định theo kết quả quan sát và quy tắc clear-on-success.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-007 — Thiếu total_amount

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API02-REQ-003, API02-REQ-006`
- Gap IDs: `API02-RG-001`; risk/potential-discrepancy IDs: `API02-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Khảo sát field documented nhưng requiredness chưa nêu, đồng thời kiểm tra route có đọc cart.
- Preconditions: JWT hợp lệ; Cart có tổng đã biết
- Request variation: bỏ total_amount
- Test data: shipping_address có mặt
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận requiredness; nếu checkout xử lý, tổng vẫn phải lấy từ cart.
- Expected state: Nếu thành công, cart được xóa.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-008 — Thiếu shipping_address

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API02-REQ-003`
- Gap IDs: `API02-RG-002`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát requiredness địa chỉ chưa được authoritative source quy định.
- Preconditions: JWT hợp lệ; Cart có hàng
- Request variation: bỏ shipping_address
- Test data: total_amount có mặt
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận hành vi mà không gán status hay validation result.
- Expected state: Theo dõi state thực tế; không bịa order schema.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-009 — Cart một dòng hàng

- Primary technique: `BOUNDARY`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API02-REQ-005, API02-REQ-006`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra nguồn tổng với cart nhỏ nhất có một dòng theo precondition context.
- Preconditions: JWT hợp lệ; Cart có đúng một dòng
- Request variation: body hợp lệ
- Test data: one cart line
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Backend tính tổng từ cart hiện tại.
- Expected state: Nếu thành công, cart chuyển sang rỗng.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-010 — Cart nhiều dòng hàng

- Primary technique: `BOUNDARY`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API02-REQ-005, API02-REQ-006`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra backend cộng toàn bộ cart thay vì lấy một phần.
- Preconditions: JWT hợp lệ; Cart có nhiều dòng
- Request variation: client total cố tình bằng riêng dòng đầu
- Test data: multi-line cart
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Tổng có thẩm quyền phản ánh cart đầy đủ theo FR-08, không phải client total.
- Expected state: Nếu thành công, toàn bộ cart được xóa.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-011 — Cart rỗng

- Primary technique: `BOUNDARY`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API02-REQ-005, API02-REQ-006`
- Gap IDs: `API02-RG-003`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Khảo sát hành vi tại biên không có item vì empty-cart contract chưa nêu.
- Preconditions: JWT hợp lệ; Cart của user rỗng
- Request variation: body documented
- Test data: empty cart
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận accept/reject và response; không bịa expected outcome.
- Expected state: Ghi nhận cart/order state quan sát được, không dùng order-line persistence làm oracle.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-012 — Địa chỉ chuỗi rỗng

- Primary technique: `BOUNDARY`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API02-REQ-003`
- Gap IDs: `API02-RG-002`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát biên empty shipping address chưa có validation rule.
- Preconditions: JWT hợp lệ; Cart có hàng
- Request variation: shipping_address=""
- Test data: empty string
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận hành vi; không gán status hoặc error schema.
- Expected state: Nếu hệ thống báo success, chỉ áp dụng oracle clear cart; các state khác là observation.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-013 — Địa chỉ rất dài

- Primary technique: `BOUNDARY`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API02-REQ-003`
- Gap IDs: `API02-RG-002`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát length handling khi không có giới hạn authoritative.
- Preconditions: JWT hợp lệ; Cart có hàng
- Request variation: shipping_address là chuỗi dài có kiểm soát
- Test data: length lấy từ test data, không gọi là max
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận giới hạn thực tế mà không nâng thành requirement.
- Expected state: Theo dõi state hậu kiểm theo kết quả thực tế.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-014 — Cart populated đến cleared

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API02-REQ-005, API02-REQ-007`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-ID-002`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra trực tiếp chuyển trạng thái sau checkout thành công.
- Preconditions: JWT hợp lệ; Cart có hàng và snapshot trước chạy
- Request variation: body hợp lệ
- Test data: cart snapshot before
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Checkout thành công sử dụng tổng cart.
- Expected state: Cart của authenticated user trở thành rỗng.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-015 — Gửi lại checkout sau thành công

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API02-REQ-007`
- Gap IDs: `API02-RG-005`; risk/potential-discrepancy IDs: `API02-RISK-REPLAY`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát idempotency/replay chưa được đặc tả.
- Preconditions: Checkout đầu đã thành công và cart đã clear
- Request variation: gửi lại cùng body và JWT
- Test data: identical replay
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận phản hồi lần hai; không tự quy định có hay không tạo order mới.
- Expected state: Ghi nhận cart và order state nhưng không dùng order-line persistence làm oracle.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-016 — Cart đổi trước thời điểm checkout

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API02-REQ-005, API02-REQ-006`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra tổng được tính từ trạng thái cart hiện tại chứ không từ snapshot client.
- Preconditions: JWT hợp lệ; Client đã xem cart rồi cart thay đổi
- Request variation: gửi total_amount cũ
- Test data: old client total, new cart state
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Backend dùng cart hiện tại để tính tổng.
- Expected state: Nếu thành công, cart hiện tại được xóa.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-017 — Hai user có cart khác nhau

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API02-REQ-004, API02-REQ-005`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-RISK-CROSS-USER`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra checkout của user A không lấy tổng hoặc state cart của user B.
- Preconditions: JWT A và B hợp lệ; Mỗi user có cart khác nhau
- Request variation: checkout bằng JWT A
- Test data: client total giống cart B để phát hiện nhầm
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Tổng phải được tính từ cart gắn với authenticated user A.
- Expected state: Nếu thành công, chỉ cart A được xóa; cart B không bị tác động.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-018 — Auth thất bại trước checkout

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API02-REQ-002, API02-REQ-004`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra thiếu auth không tiến hành checkout.
- Preconditions: Cart baseline tồn tại
- Request variation: không gửi Authorization
- Test data: body hợp lệ
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không cho user chưa xác thực checkout.
- Expected state: Cart baseline không bị clear bởi checkout thành công.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-019 — Input body lỗi và cart state

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API02-REQ-007`
- Gap IDs: `API02-RG-003`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Quan sát effect-on-failure vì requirement chỉ quy định clear khi thành công.
- Preconditions: JWT hợp lệ; Cart có hàng
- Request variation: malformed business input
- Test data: shipping_address thiếu
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận kết quả; không suy diễn failure semantics.
- Expected state: Hậu kiểm cart; chỉ kết luận clear bắt buộc nếu request được xác nhận thành công.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-020 — Hai checkout đồng thời

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API02-REQ-005, API02-REQ-006`
- Gap IDs: `API02-RG-005`; risk/potential-discrepancy IDs: `API02-RISK-RACE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát race-like behavior và số lần side effect khi idempotency chưa nêu.
- Preconditions: JWT hợp lệ; Cart có hàng
- Request variation: hai request đồng thời với cùng snapshot
- Test data: parallel requests
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận kết quả từng request; tổng mỗi checkout được xử lý không được tin client input.
- Expected state: Ghi nhận cart/order state thực tế; không tự đặt cardinality order.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-021 — Thiếu Authorization header

- Primary technique: `SECURITY`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API02-REQ-002, API02-REQ-004, API02-REQ-010`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra sensitive checkout bắt buộc có JWT.
- Preconditions: Cart test tồn tại
- Request variation: không Authorization
- Test data: documented body
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không cho checkout khi không có JWT hợp lệ.
- Expected state: Không áp dụng side effect success lên cart.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-022 — Authorization sai scheme

- Primary technique: `SECURITY`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API02-REQ-002, API02-REQ-010`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra chuỗi auth không theo Bearer không thỏa contract.
- Preconditions: Cart test tồn tại
- Request variation: Authorization dùng Basic
- Test data: Basic placeholder
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không coi header này là valid bearer JWT.
- Expected state: Không clear cart do checkout thành công.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-023 — Bearer token malformed

- Primary technique: `SECURITY`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API02-REQ-002, API02-REQ-010`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra token không phải JWT hợp lệ.
- Preconditions: Cart test tồn tại
- Request variation: Authorization Bearer malformed
- Test data: token=abc
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không cho checkout với JWT không hợp lệ.
- Expected state: Cart không bị clear bởi checkout thành công.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-024 — Bearer token hết hạn

- Primary technique: `SECURITY`
- Secondary techniques: `STATE_TRANSITION`
- Requirement IDs: `API02-REQ-002, API02-REQ-010`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra expired JWT không thỏa yêu cầu valid token.
- Preconditions: Có JWT expired trong môi trường test
- Request variation: Authorization Bearer expired
- Test data: expired token fixture
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không cho checkout với token hết hạn.
- Expected state: Cart không bị clear bởi checkout thành công.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-025 — Total dạng biểu thức injection

- Primary technique: `SECURITY`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API02-REQ-005, API02-REQ-006`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-ID-001`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra input total không thể chi phối persistence hoặc vượt qua server recalculation.
- Preconditions: JWT hợp lệ; Cart có tổng biết trước
- Request variation: total_amount là chuỗi SQL-like
- Test data: "0 OR 1=1"
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Client input không được dùng làm tổng có thẩm quyền; truy vấn phải giữ ranh giới dữ liệu.
- Expected state: Không có thay đổi dữ liệu ngoài checkout được phép.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-026 — Injection trong shipping_address

- Primary technique: `SECURITY`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API02-REQ-003, API02-REQ-011`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-RISK-INJECTION`; implementation-observation IDs: `API02-ID-004`
- Oracle basis: `SECURITY_EXPECTATION`
- Objective: Kiểm tra địa chỉ được xử lý như dữ liệu, không như câu lệnh.
- Preconditions: JWT hợp lệ; Cart có hàng
- Request variation: shipping_address chứa metacharacters
- Test data: "x'); DROP TABLE orders;--"
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không được thực thi nội dung input như lệnh hoặc phá dữ liệu ngoài phạm vi.
- Expected state: Nếu checkout thành công, cart clear; dữ liệu khác còn nguyên.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-027 — JWT user không khớp cart client tham chiếu

- Primary technique: `SECURITY`
- Secondary techniques: `STATE_TRANSITION`
- Requirement IDs: `API02-REQ-002, API02-REQ-004`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-RISK-CROSS-USER`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra identity từ JWT quyết định cart, không từ payload suy diễn.
- Preconditions: User A và B có cart
- Request variation: JWT A, payload thêm user_id B
- Test data: unexpected user_id field
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Checkout chỉ được gắn với user đã xác thực; không được tác động cart B.
- Expected state: Cart B không đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-028 — JWT hợp lệ gửi request trùng nhanh

- Primary technique: `SECURITY`
- Secondary techniques: `STATE_TRANSITION`
- Requirement IDs: `API02-REQ-004, API02-REQ-006`
- Gap IDs: `API02-RG-005`; risk/potential-discrepancy IDs: `API02-RISK-REPLAY`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát duplicate submission khi contract idempotency chưa tồn tại.
- Preconditions: JWT hợp lệ; Cart có hàng
- Request variation: hai request tuần tự rất gần nhau
- Test data: same body, no idempotency key
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận kết quả; không bịa chính sách deduplicate.
- Expected state: Ghi nhận cart/order state thực tế và tách khỏi order-line oracle.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-029 — Request đúng header và body documented

- Primary technique: `SCHEMA`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API02-REQ-001, API02-REQ-002, API02-REQ-003`
- Gap IDs: `API02-RG-001`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Xác nhận shape cơ sở gồm Bearer, total_amount, shipping_address.
- Preconditions: JWT hợp lệ; Cart có hàng
- Request variation: JSON đúng hai field
- Test data: documented shape
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Request phù hợp contract đầu vào; response status/schema chưa được quy định.
- Expected state: Nếu thành công, cart clear.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-030 — Body null

- Primary technique: `SCHEMA`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API02-REQ-003`
- Gap IDs: `API02-RG-001`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát parser/validation với JSON null khi requiredness chưa nêu.
- Preconditions: JWT hợp lệ; Cart có hàng
- Request variation: body=null
- Test data: null JSON
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận response thực tế, không bịa schema/status.
- Expected state: Hậu kiểm cart theo kết quả.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-031 — Body là array

- Primary technique: `SCHEMA`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API02-REQ-003`
- Gap IDs: `API02-RG-001`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát sai top-level type so với documented JSON object.
- Preconditions: JWT hợp lệ; Cart có hàng
- Request variation: body=[]
- Test data: empty array
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận xử lý top-level array mà không tự định nghĩa error contract.
- Expected state: Hậu kiểm cart theo kết quả.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-032 — Malformed JSON

- Primary technique: `SCHEMA`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API02-REQ-003, API02-REQ-004`
- Gap IDs: `API02-RG-001`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát syntax-error handling với JWT hợp lệ.
- Preconditions: JWT hợp lệ; Cart có hàng
- Request variation: JSON bị cắt
- Test data: invalid syntax
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận status/body thực tế; không gán expected schema.
- Expected state: Không suy diễn state nếu chưa hậu kiểm.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-033 — Sai Content-Type

- Primary technique: `SCHEMA`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API02-REQ-003, API02-REQ-004`
- Gap IDs: `API02-RG-001`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát request JSON gửi với content type khác khi failure contract không nêu.
- Preconditions: JWT hợp lệ; Cart có hàng
- Request variation: text/plain chứa JSON text
- Test data: Content-Type=text/plain
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận parsing/validation thực tế.
- Expected state: Hậu kiểm cart; clear chỉ là oracle khi checkout thành công.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-034 — Backend recompute với client total khớp

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API02-REQ-005, API02-REQ-006`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-ID-001, API02-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra việc trùng giá trị không che mất nghĩa vụ đọc cart và tính lại.
- Preconditions: JWT hợp lệ; Cart có tổng biết trước
- Request variation: client total tình cờ bằng cart total
- Test data: equal values
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Cần evidence backend-derived total; equality alone không chứng minh client được tin.
- Expected state: Nếu thành công, cart clear.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-035 — Client total có phần thập phân khác

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API02-REQ-005, API02-REQ-006`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-ID-001`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra tampering nhỏ không được dùng làm tổng có thẩm quyền.
- Preconditions: JWT hợp lệ; Cart total biết trước
- Request variation: client total lệch một phần nhỏ
- Test data: cart=100, client=99.99
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Backend dùng total tính từ cart.
- Expected state: Nếu thành công, cart clear.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-036 — Clear đúng cart sau success

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `STATE_TRANSITION`
- Requirement IDs: `API02-REQ-007`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API02-ID-002`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra side effect clear nhắm đúng authenticated user's cart.
- Preconditions: User A và B đều có cart; Checkout A thành công
- Request variation: hậu kiểm cả hai cart
- Test data: two-user state
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Checkout thành công của A không xác lập quy tắc cho B.
- Expected state: Cart A rỗng; cart B giữ nguyên.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-037 — Cart có quantity nhiều hơn một

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API02-REQ-005, API02-REQ-006, API02-REQ-008`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Dùng FR-07 chỉ làm precondition để kiểm tra total của FR-08 từ cart hiện tại.
- Preconditions: JWT hợp lệ; Cart có một product quantity lớn hơn một
- Request variation: client total chỉ tính quantity một
- Test data: supporting cart setup
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Backend total phản ánh cart hiện tại theo FR-08; không biến quy tắc merge FR-07 thành checkout oracle.
- Expected state: Nếu thành công, cart được xóa.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-038 — Cart có coupon context

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API02-REQ-005, API02-REQ-006, API02-REQ-009`
- Gap IDs: `API02-RG-004`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Giữ FR-09 ở supporting context và quan sát liệu checkout có integration hay không.
- Preconditions: JWT hợp lệ; Cart test có trạng thái coupon được thiết lập qua feature riêng
- Request variation: checkout body không có contract coupon
- Test data: coupon context only
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận total và phản hồi; không dùng FR-09 làm direct checkout oracle.
- Expected state: Nếu checkout được xác nhận thành công, cart clear theo FR-08.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-039 — Quan sát initial order status

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API02-REQ-003`
- Gap IDs: `API02-RG-003`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Ghi nhận trạng thái order tạo ra mà không biến implementation value thành requirement.
- Preconditions: Checkout hợp lệ có thể thành công; Có quyền đọc state test
- Request variation: body documented
- Test data: post-checkout observation
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không có authoritative initial status oracle.
- Expected state: Ghi nhận giá trị thực tế; không đánh defect vì khác một giá trị tự giả định.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API02-AI-040 — Quan sát order-line persistence

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `STATE_TRANSITION`
- Requirement IDs: `API02-REQ-007`
- Gap IDs: `API02-RG-003`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Bao phủ gap nhưng tuyệt đối không coi thiếu order lines là requirement discrepancy.
- Preconditions: Checkout hợp lệ có thể thành công; Có phép kiểm tra dữ liệu test
- Request variation: body documented
- Test data: post-checkout persistence observation
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận có/không order lines; không dùng làm pass/fail oracle của FR-08.
- Expected state: Cart clear vẫn là authoritative side effect nếu checkout thành công.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

## Traceability matrix

| Requirement / gap / risk / implementation observation | Generated case IDs |
| --- | --- |
| `API02-ID-001` | `API02-AI-002, API02-AI-003, API02-AI-004, API02-AI-005, API02-AI-006, API02-AI-025, API02-AI-034, API02-AI-035` |
| `API02-ID-002` | `API02-AI-014, API02-AI-036` |
| `API02-ID-003` | `API02-AI-007, API02-AI-009, API02-AI-010, API02-AI-016, API02-AI-034` |
| `API02-ID-004` | `API02-AI-026` |
| `API02-REQ-001` | `API02-AI-029` |
| `API02-REQ-002` | `API02-AI-001, API02-AI-018, API02-AI-021, API02-AI-022, API02-AI-023, API02-AI-024, API02-AI-027, API02-AI-029` |
| `API02-REQ-003` | `API02-AI-006, API02-AI-007, API02-AI-008, API02-AI-012, API02-AI-013, API02-AI-026, API02-AI-029, API02-AI-030, API02-AI-031, API02-AI-032, API02-AI-033, API02-AI-039` |
| `API02-REQ-004` | `API02-AI-017, API02-AI-018, API02-AI-021, API02-AI-027, API02-AI-028, API02-AI-032, API02-AI-033` |
| `API02-REQ-005` | `API02-AI-001, API02-AI-002, API02-AI-003, API02-AI-004, API02-AI-005, API02-AI-009, API02-AI-010, API02-AI-011, API02-AI-014, API02-AI-016, API02-AI-017, API02-AI-020, API02-AI-025, API02-AI-034, API02-AI-035, API02-AI-037, API02-AI-038` |
| `API02-REQ-006` | `API02-AI-001, API02-AI-002, API02-AI-003, API02-AI-004, API02-AI-005, API02-AI-006, API02-AI-007, API02-AI-009, API02-AI-010, API02-AI-011, API02-AI-016, API02-AI-020, API02-AI-025, API02-AI-028, API02-AI-034, API02-AI-035, API02-AI-037, API02-AI-038` |
| `API02-REQ-007` | `API02-AI-001, API02-AI-014, API02-AI-015, API02-AI-019, API02-AI-036, API02-AI-040` |
| `API02-REQ-008` | `API02-AI-037` |
| `API02-REQ-009` | `API02-AI-038` |
| `API02-REQ-010` | `API02-AI-021, API02-AI-022, API02-AI-023, API02-AI-024` |
| `API02-REQ-011` | `API02-AI-026` |
| `API02-RG-001` | `API02-AI-006, API02-AI-007, API02-AI-029, API02-AI-030, API02-AI-031, API02-AI-032, API02-AI-033` |
| `API02-RG-002` | `API02-AI-008, API02-AI-012, API02-AI-013` |
| `API02-RG-003` | `API02-AI-011, API02-AI-019, API02-AI-039, API02-AI-040` |
| `API02-RG-004` | `API02-AI-038` |
| `API02-RG-005` | `API02-AI-015, API02-AI-020, API02-AI-028` |
| `API02-RISK-CROSS-USER` | `API02-AI-017, API02-AI-027` |
| `API02-RISK-INJECTION` | `API02-AI-026` |
| `API02-RISK-RACE` | `API02-AI-020` |
| `API02-RISK-REPLAY` | `API02-AI-015, API02-AI-028` |

## Phase boundary

Raw AI generation only. No case has been audited, student-extended, implemented, executed, or classified as a product defect.
