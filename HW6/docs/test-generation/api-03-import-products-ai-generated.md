# API-03 AI-generated Test Cases — Import Products

- Status: `TEST_GENERATION_REVIEW_REQUIRED`
- Source: `AI_GENERATED`; lifecycle: `DRAFT`; audit: `NOT_AUDITED`; execution: `NOT_IMPLEMENTED`
- Approved input: `docs/requirement-analysis/api-03-import-products.md`
- Count: **40**; semantic duplicates removed: **0**
- No HTTP status or response schema was inferred: every case uses `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`.
- FR-15 remains supporting context; selected endpoint cases use JSON `products[]`; raw CSV cases: **0**.

## Primary-technique coverage

| Technique | Count |
| --- | ---: |
| `DOMAIN_PARTITION` | 9 |
| `BOUNDARY` | 6 |
| `STATE_TRANSITION` | 7 |
| `SECURITY` | 8 |
| `SCHEMA` | 5 |
| `BUSINESS_RULE` | 5 |

## Oracle basis

| Basis | Count |
| --- | ---: |
| `AUTHORITATIVE` | 19 |
| `PARTIALLY_SPECIFIED` | 7 |
| `OBSERVABLE_ONLY` | 12 |
| `SECURITY_EXPECTATION` | 2 |

## Test cases

### API03-AI-001 — Admin import một product hợp lệ

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-002, API03-REQ-004, API03-REQ-007, API03-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra JSON products array hợp lệ với admin JWT.
- Preconditions: Admin JWT hợp lệ
- Request variation: products có một item name non-empty và price positive
- Test data: one valid product
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Batch hợp lệ đủ điều kiện import.
- Expected state: Toàn bộ một item được commit và report được tạo.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-002 — Admin import nhiều product hợp lệ

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-004, API03-REQ-007, API03-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra feature multi-product và atomic commit cho batch hợp lệ.
- Preconditions: Admin JWT hợp lệ
- Request variation: products có nhiều item hợp lệ
- Test data: three valid products
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Toàn bộ batch hợp lệ được xử lý như một import.
- Expected state: Tất cả item được commit; report phản ánh batch.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-003 — Thiếu products

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API03-REQ-004`
- Gap IDs: `API03-RG-004`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Khảo sát requiredness của products khi spec mô tả field nhưng không nêu error contract.
- Preconditions: Admin JWT hợp lệ
- Request variation: bỏ products
- Test data: empty object
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận validation; không bịa status/schema.
- Expected state: Không khẳng định persistence ngoài hậu kiểm.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-004 — products bằng null

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API03-REQ-004`
- Gap IDs: `API03-RG-004`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Kiểm tra null không phải array theo documented shape.
- Preconditions: Admin JWT hợp lệ
- Request variation: products=null
- Test data: null
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Body không phù hợp JSON-array contract; cách báo lỗi chưa được quy định.
- Expected state: Hậu kiểm không dựa trên response schema tự đặt.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-005 — products là object

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API03-REQ-004`
- Gap IDs: `API03-RG-004`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Kiểm tra sai type object thay vì array.
- Preconditions: Admin JWT hợp lệ
- Request variation: products={}
- Test data: object value
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Body không phù hợp documented array form; status/schema unspecified.
- Expected state: Ghi nhận persistence thực tế.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-006 — products array rỗng

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `BOUNDARY`
- Requirement IDs: `API03-REQ-004, API03-REQ-009`
- Gap IDs: `API03-RG-002`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát empty-batch semantics chưa được quy định.
- Preconditions: Admin JWT hợp lệ
- Request variation: products=[]
- Test data: empty array
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận accept/reject/report; không tự định nghĩa empty import.
- Expected state: Ghi nhận state trước/sau.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-007 — Item thiếu name

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-005, API03-REQ-007`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API03-ID-002`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra name non-empty trực tiếp của FR-16.
- Preconditions: Admin JWT hợp lệ
- Request variation: một item có price nhưng không name
- Test data: missing name
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không chấp nhận row thiếu name hợp lệ.
- Expected state: Nếu cùng batch có item khác, toàn batch rollback.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-008 — Item name rỗng

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-007`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API03-ID-002`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra chuỗi rỗng vi phạm non-empty.
- Preconditions: Admin JWT hợp lệ
- Request variation: name="", price positive
- Test data: empty name
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Row lỗi vì name không non-empty.
- Expected state: Toàn batch rollback.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-009 — Price bằng zero

- Primary technique: `BOUNDARY`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-007`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API03-ID-002`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra đúng biên không dương.
- Preconditions: Admin JWT hợp lệ
- Request variation: price=0, name hợp lệ
- Test data: zero price
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Row lỗi vì price phải positive.
- Expected state: Toàn batch rollback.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-010 — Price âm

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-007`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API03-ID-002`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra lớp price negative.
- Preconditions: Admin JWT hợp lệ
- Request variation: price=-1, name hợp lệ
- Test data: negative price
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Row lỗi vì price không positive.
- Expected state: Toàn batch rollback.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-011 — Price dương nhỏ

- Primary technique: `BOUNDARY`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-007`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra phía hợp lệ ngay trên zero mà không tự định nghĩa precision tối đa.
- Preconditions: Admin JWT hợp lệ
- Request variation: price positive nhỏ có representation hệ thống hỗ trợ
- Test data: price=0.01
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Price lớn hơn zero thỏa quy tắc positivity; numeric precision vẫn cần quan sát.
- Expected state: Nếu mọi row hợp lệ, toàn batch commit.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-012 — Name dài đúng 255

- Primary technique: `BOUNDARY`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API03-REQ-008`
- Gap IDs: `API03-RG-003`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Giữ FR-15 chỉ là supporting và quan sát name length tại mốc 255.
- Preconditions: Admin JWT hợp lệ
- Request variation: name dài 255, price positive
- Test data: supporting boundary only
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận hành vi; không coi 255 là FR-16 oracle.
- Expected state: Ghi nhận commit/rollback thực tế.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-013 — Name dài 256

- Primary technique: `BOUNDARY`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API03-REQ-008`
- Gap IDs: `API03-RG-003`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát phía trên giới hạn FR-15 mà không áp dụng nó trực tiếp cho import.
- Preconditions: Admin JWT hợp lệ
- Request variation: name dài 256, price positive
- Test data: supporting boundary only
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận hành vi; không đánh discrepancy nếu khác FR-15 khi chưa có liên kết authoritative.
- Expected state: Ghi nhận state thực tế.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-014 — Batch kích thước lớn

- Primary technique: `BOUNDARY`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API03-REQ-004`
- Gap IDs: `API03-RG-002`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát capacity khi maximum batch size chưa được quy định.
- Preconditions: Admin JWT hợp lệ; Môi trường test cô lập
- Request variation: products array lớn có kiểm soát
- Test data: size được ghi trong evidence, không gọi là max
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận giới hạn/thời gian/phản hồi; không bịa threshold.
- Expected state: Hậu kiểm số item và atomicity theo kết quả.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-015 — Price có nhiều chữ số thập phân

- Primary technique: `BOUNDARY`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API03-REQ-007`
- Gap IDs: `API03-RG-005`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát precision/rounding chưa được quy định trong FR-16.
- Preconditions: Admin JWT hợp lệ
- Request variation: price positive với nhiều decimal places
- Test data: 1.234567
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận representation và persisted value; chỉ positivity là oracle authoritative.
- Expected state: Nếu batch được chấp nhận, atomic commit vẫn áp dụng.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-016 — Batch valid commit toàn bộ

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API03-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra pre-state sang post-state có toàn bộ rows khi không có lỗi.
- Preconditions: Admin JWT hợp lệ; Snapshot products trước import
- Request variation: nhiều item đều valid
- Test data: valid batch
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không có row error nên batch đủ điều kiện commit.
- Expected state: Post-state có toàn bộ item mới, không phải một phần.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-017 — Row đầu invalid

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-007, API03-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API03-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra rollback khi lỗi nằm ở vị trí đầu.
- Preconditions: Admin JWT hợp lệ; Snapshot trước import
- Request variation: row 1 name empty, rows sau valid
- Test data: invalid first
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Bất kỳ row lỗi làm toàn import thất bại.
- Expected state: Không item nào của batch được persist.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-018 — Row giữa invalid

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-007, API03-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API03-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra không có partial persistence trước row lỗi giữa batch.
- Preconditions: Admin JWT hợp lệ; Snapshot trước import
- Request variation: valid, invalid price zero, valid
- Test data: invalid middle
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Lỗi giữa batch làm rollback toàn bộ.
- Expected state: Không giữ các row valid đứng trước hoặc sau.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-019 — Row cuối invalid

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-007, API03-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API03-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra rollback cả các insert trước row lỗi cuối.
- Preconditions: Admin JWT hợp lệ; Snapshot trước import
- Request variation: các row đầu valid, row cuối name empty
- Test data: invalid last
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Lỗi cuối vẫn làm toàn batch thất bại.
- Expected state: Không item nào của batch được persist.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-020 — Nhiều row invalid

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-007, API03-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API03-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra atomicity và report khi batch có nhiều lỗi.
- Preconditions: Admin JWT hợp lệ; Snapshot trước import
- Request variation: một row empty name, một row negative price
- Test data: multiple invalid
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Batch không được partial commit; report cần counts/reasons.
- Expected state: Products state không đổi bởi batch.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-021 — Retry batch đã sửa

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra sau rollback có thể gửi một batch mới hợp lệ mà không mang partial state cũ.
- Preconditions: Một batch invalid đã rollback
- Request variation: gửi batch mới với tất cả lỗi đã sửa
- Test data: corrected retry
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Batch retry được đánh giá độc lập và nếu hợp lệ có thể commit toàn bộ.
- Expected state: Chỉ dữ liệu từ lần retry hợp lệ xuất hiện.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-022 — Report sau batch lỗi

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API03-REQ-010`
- Gap IDs: `API03-RG-004`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `API03-ID-004`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Kiểm tra report có success/error counts và reasons mà không bịa field names.
- Preconditions: Admin JWT hợp lệ; Batch có lỗi xác định
- Request variation: mixed invalid batch
- Test data: known row errors
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Report thể hiện số thành công/lỗi và lý do ở mức semantic; exact schema unspecified.
- Expected state: Atomic rollback vẫn được hậu kiểm độc lập.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-023 — Thiếu Authorization

- Primary technique: `SECURITY`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API03-REQ-002, API03-REQ-011`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra import không được thực hiện khi thiếu JWT.
- Preconditions: Có snapshot products
- Request variation: không gửi Authorization
- Test data: valid products body
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không cho truy cập sensitive import endpoint.
- Expected state: Products state không đổi bởi import được phép.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-024 — Bearer JWT malformed

- Primary technique: `SECURITY`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API03-REQ-002, API03-REQ-011`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra token không hợp lệ không đủ quyền import.
- Preconditions: Có snapshot products
- Request variation: Bearer malformed
- Test data: token=abc
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không cho import với JWT không hợp lệ.
- Expected state: Products state không đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-025 — JWT hết hạn

- Primary technique: `SECURITY`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API03-REQ-002, API03-REQ-011`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra expired token không thỏa valid JWT.
- Preconditions: Có expired fixture
- Request variation: Bearer expired và valid products
- Test data: expired admin token
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không cho import với token hết hạn.
- Expected state: Products state không đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-026 — JWT user không phải admin

- Primary technique: `SECURITY`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-002, API03-REQ-003`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API03-ID-001`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra role enforcement chứ không chỉ token existence.
- Preconditions: Valid JWT role user; Snapshot products
- Request variation: Bearer user token, valid products
- Test data: role=user
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không cho non-admin import.
- Expected state: Products state không đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-027 — JWT admin hợp lệ

- Primary technique: `SECURITY`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API03-REQ-002, API03-REQ-003`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra positive authorization partition.
- Preconditions: Valid admin JWT
- Request variation: Bearer admin token, valid products
- Test data: role=admin
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Admin đã xác thực đủ điều kiện authorization; business validation vẫn áp dụng.
- Expected state: State phụ thuộc atomic validation của batch.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-028 — Payload tự khai role admin

- Primary technique: `SECURITY`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API03-REQ-003`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API03-RISK-ROLE-TAMPERING`; implementation-observation IDs: `NONE`
- Oracle basis: `SECURITY_EXPECTATION`
- Objective: Kiểm tra field role trong body không thay thế role đã xác minh trong token.
- Preconditions: JWT role user; Snapshot products
- Request variation: body thêm role=admin
- Test data: mass-assignment attempt
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không được nâng quyền từ payload; role phải lấy từ token đã verify.
- Expected state: Products state không đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-029 — Injection trong product name

- Primary technique: `SECURITY`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API03-REQ-007, API03-REQ-011`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API03-RISK-INJECTION`; implementation-observation IDs: `API03-ID-005`
- Oracle basis: `SECURITY_EXPECTATION`
- Objective: Kiểm tra name được xử lý như dữ liệu và vẫn qua non-empty validation.
- Preconditions: Admin JWT hợp lệ; Snapshot dữ liệu liên quan
- Request variation: name chứa SQL metacharacters, price positive
- Test data: "x'); DROP TABLE products;--"
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Input không được thực thi như lệnh hoặc phá dữ liệu ngoài phạm vi; name vẫn là non-empty data.
- Expected state: Nếu batch được chấp nhận, chỉ atomic import side effect được phép.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-030 — Unexpected privileged fields

- Primary technique: `SECURITY`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API03-REQ-005`
- Gap IDs: `API03-RG-003`; risk/potential-discrepancy IDs: `API03-RISK-MASS-ASSIGNMENT`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát mass-assignment handling khi additional properties chưa được quy định.
- Preconditions: Admin JWT hợp lệ
- Request variation: item thêm id và owner_role
- Test data: unexpected fields
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận ignore/reject/persist; không bịa field policy.
- Expected state: Hậu kiểm không có thay đổi trái phép ngoài product import.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-031 — JSON products với đủ field documented

- Primary technique: `SCHEMA`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API03-REQ-001, API03-REQ-004, API03-REQ-005`
- Gap IDs: `API03-RG-004`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Xác nhận endpoint representation là JSON array và item gồm các field tài liệu hóa.
- Preconditions: Admin JWT hợp lệ
- Request variation: products item có name, price, description, imageUrl, category_id
- Test data: documented JSON shape
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Request phù hợp endpoint contract; requiredness và response schema còn chưa đầy đủ.
- Expected state: Nếu row hợp lệ, atomic state rule áp dụng.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-032 — Thiếu optionality-unknown fields

- Primary technique: `SCHEMA`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API03-REQ-005`
- Gap IDs: `API03-RG-003`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát description, imageUrl và category_id vì requiredness import chưa được định nghĩa.
- Preconditions: Admin JWT hợp lệ
- Request variation: item chỉ có name và price
- Test data: minimal item
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận behavior; không áp FR-15 category rule làm direct oracle.
- Expected state: Theo dõi atomic commit/rollback thực tế.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-033 — Sai type description

- Primary technique: `SCHEMA`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API03-REQ-005`
- Gap IDs: `API03-RG-003`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát type validation của documented field chưa có constraint.
- Preconditions: Admin JWT hợp lệ
- Request variation: description là object
- Test data: type mismatch observation
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận xử lý; không bịa error schema.
- Expected state: Hậu kiểm state thực tế.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-034 — category_id không tồn tại

- Primary technique: `SCHEMA`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API03-REQ-005`
- Gap IDs: `API03-RG-003`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát reference semantics chưa được FR-16 quy định.
- Preconditions: Admin JWT hợp lệ
- Request variation: category_id là ID không tồn tại
- Test data: nonexistent category
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận accept/reject/reason; không coi một phía là requirement.
- Expected state: Hậu kiểm atomic behavior theo kết quả.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-035 — Xác nhận boundary JSON của endpoint

- Primary technique: `SCHEMA`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API03-REQ-006`
- Gap IDs: `API03-RG-001`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Bao phủ gap CSV-vs-JSON bằng request JSON products chứ không giả định raw CSV.
- Preconditions: Admin JWT hợp lệ
- Request variation: gửi JSON products array theo API spec
- Test data: no raw CSV request
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Selected endpoint được kiểm tra theo JSON contract; vị trí CSV parsing vẫn unresolved.
- Expected state: State theo atomic import rules.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-036 — Name chỉ whitespace

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API03-REQ-007`
- Gap IDs: `API03-RG-005`; risk/potential-discrepancy IDs: `API03-ID-002`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát nghĩa non-empty đối với whitespace vì chưa được định nghĩa.
- Preconditions: Admin JWT hợp lệ
- Request variation: name gồm spaces, price positive
- Test data: "   "
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận trim/accept/reject; không tự định nghĩa whitespace là empty.
- Expected state: Theo dõi atomic outcome thực tế.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-037 — Price dạng chuỗi số

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API03-REQ-007`
- Gap IDs: `API03-RG-005`; risk/potential-discrepancy IDs: `API03-ID-002`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát numeric representation khi positivity rõ nhưng type coercion chưa nêu.
- Preconditions: Admin JWT hợp lệ
- Request variation: price="10"
- Test data: numeric string
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận coercion/reject; không bịa type contract.
- Expected state: Nếu được coi hợp lệ, atomic commit áp dụng.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-038 — All-or-nothing đối chiếu report

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `STATE_TRANSITION`
- Requirement IDs: `API03-REQ-009, API03-REQ-010`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API03-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Đối chiếu report semantic với persistence để phát hiện partial import.
- Preconditions: Admin JWT hợp lệ; Batch mixed validity; Snapshot trước
- Request variation: một valid và một invalid item
- Test data: mixed batch
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Report phải nêu counts/reasons và batch phải rollback toàn bộ do có lỗi.
- Expected state: Không item mới nào tồn tại dù report có success-row count trung gian.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-039 — Report batch thành công

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API03-REQ-010`
- Gap IDs: `API03-RG-004`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Kiểm tra report có success/error counts và reasons ở mức semantic.
- Preconditions: Admin JWT hợp lệ; Batch tất cả valid
- Request variation: valid batch
- Test data: known input count
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Report phản ánh số row thành công/lỗi và lý do phù hợp; exact keys/types unspecified.
- Expected state: Toàn batch commit.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API03-AI-040 — Duplicate products trong cùng batch

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API03-REQ-004`
- Gap IDs: `API03-RG-002`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát duplicate policy chưa được quy định.
- Preconditions: Admin JWT hợp lệ
- Request variation: hai item trùng name và price
- Test data: duplicate pair
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận duplicate được chấp nhận hay báo lỗi; không tự chọn oracle.
- Expected state: Nếu một duplicate bị coi là error, authoritative atomic rollback áp dụng; nếu không, ghi nhận commit thực tế.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

## Traceability matrix

| Requirement / gap / risk / implementation observation | Generated case IDs |
| --- | --- |
| `API03-ID-001` | `API03-AI-026` |
| `API03-ID-002` | `API03-AI-007, API03-AI-008, API03-AI-009, API03-AI-010, API03-AI-036, API03-AI-037` |
| `API03-ID-003` | `API03-AI-016, API03-AI-017, API03-AI-018, API03-AI-019, API03-AI-020, API03-AI-038` |
| `API03-ID-004` | `API03-AI-022` |
| `API03-ID-005` | `API03-AI-029` |
| `API03-REQ-001` | `API03-AI-031` |
| `API03-REQ-002` | `API03-AI-001, API03-AI-023, API03-AI-024, API03-AI-025, API03-AI-026, API03-AI-027` |
| `API03-REQ-003` | `API03-AI-026, API03-AI-027, API03-AI-028` |
| `API03-REQ-004` | `API03-AI-001, API03-AI-002, API03-AI-003, API03-AI-004, API03-AI-005, API03-AI-006, API03-AI-014, API03-AI-031, API03-AI-040` |
| `API03-REQ-005` | `API03-AI-007, API03-AI-030, API03-AI-031, API03-AI-032, API03-AI-033, API03-AI-034` |
| `API03-REQ-006` | `API03-AI-035` |
| `API03-REQ-007` | `API03-AI-001, API03-AI-002, API03-AI-007, API03-AI-008, API03-AI-009, API03-AI-010, API03-AI-011, API03-AI-015, API03-AI-017, API03-AI-018, API03-AI-019, API03-AI-020, API03-AI-029, API03-AI-036, API03-AI-037` |
| `API03-REQ-008` | `API03-AI-012, API03-AI-013` |
| `API03-REQ-009` | `API03-AI-001, API03-AI-002, API03-AI-006, API03-AI-016, API03-AI-017, API03-AI-018, API03-AI-019, API03-AI-020, API03-AI-021, API03-AI-038` |
| `API03-REQ-010` | `API03-AI-022, API03-AI-038, API03-AI-039` |
| `API03-REQ-011` | `API03-AI-023, API03-AI-024, API03-AI-025, API03-AI-029` |
| `API03-RG-001` | `API03-AI-035` |
| `API03-RG-002` | `API03-AI-006, API03-AI-014, API03-AI-040` |
| `API03-RG-003` | `API03-AI-012, API03-AI-013, API03-AI-030, API03-AI-032, API03-AI-033, API03-AI-034` |
| `API03-RG-004` | `API03-AI-003, API03-AI-004, API03-AI-005, API03-AI-022, API03-AI-031, API03-AI-039` |
| `API03-RG-005` | `API03-AI-015, API03-AI-036, API03-AI-037` |
| `API03-RISK-INJECTION` | `API03-AI-029` |
| `API03-RISK-MASS-ASSIGNMENT` | `API03-AI-030` |
| `API03-RISK-ROLE-TAMPERING` | `API03-AI-028` |

## Phase boundary

Raw AI generation only. No case has been audited, student-extended, implemented, executed, or classified as a product defect.
