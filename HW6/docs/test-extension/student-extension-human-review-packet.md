# Student Extension Targeted Human Review Packet

## Review Scope

- Review target: exactly 15 `STUDENT_ADDED` cases, exactly 5 per API.
- Comparison baseline: all 40 raw `AI_GENERATED` cases and the corrected executable AI suite for the same API.
- Review type: static design review only; no Student case was rewritten, replaced, generated, approved, merged, or executed.
- Oracle boundary: authoritative requirements/security/state invariants only. Requirement gaps and supporting context are not promoted to pass/fail requirements.
- `AI_RECOMMENDATION` is advisory. Every `HUMAN_DECISION` remains `PENDING`.

## API-01 — `POST /api/reset-password`

### API01-STU-001

CASE_ID: `API01-STU-001`

API: `API-01`

TITLE: Cross-email failure then rightful token use

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API01-REQ-007`, `API01-REQ-009`

WHY_AI_MISSED: `STATEFUL_REASONING_GAP` — AI kiểm tra email-token binding và valid reset riêng, nhưng không thực hiện bước rightful-owner recovery sau cross-email misuse để chứng minh token A chưa bị consume.

CLOSEST_AI_CASES: `API01-AI-002`, `API01-AI-014`, `API01-AI-019`

SEMANTIC_DIFFERENCE: `API01-AI-002` dừng sau cross-email rejection; case này tiếp tục dùng đúng email với cùng OTP và kiểm tra cả non-consumption lẫn invalidation sau successful use. Không raw case nào trong 40 case thực hiện chuỗi hai bước này.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT` — email-token binding và invalidation after use là authoritative; không đặt expiry, rate-limit, JWT hoặc response contract.

EXECUTION_FEASIBILITY: `POSTMAN_WITH_PRECONDITION_SETUP`

AI_RECOMMENDATION: `APPROVE`

AI_REVIEW_REASON: Case tạo stateful security coverage mới, khác raw suite ở recovery transition. Cần hai account và OTP A được cấp trước; kết quả nên được đối chiếu qua chuỗi reset/replay hoặc state setup hỗ trợ, không invent status/schema.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `PASS`
- `SEMANTICALLY_UNIQUE`: `PASS`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `PASS`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `APPROVE`

HUMAN_COMMENT:

### API01-STU-002

CASE_ID: `API01-STU-002`

API: `API-01`

TITLE: Weak-password failure then strong retry with same OTP

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API01-REQ-005`, `API01-REQ-009`

WHY_AI_MISSED: `STATEFUL_REASONING_GAP` — AI có weak-password rejection và valid reset riêng, nhưng không chứng minh recoverability bằng cùng OTP sau business-validation failure.

CLOSEST_AI_CASES: `API01-AI-018`, `API01-AI-014`, `API01-AI-009`, `API01-AI-021`, `API01-AI-022`, `API01-AI-023`, `API01-AI-024`

SEMANTIC_DIFFERENCE: Raw suite kiểm tra weak password partitions và issued-to-success flow, nhưng không nối weak failure với compliant retry bằng cùng token. Case này quan sát failed-reset state mutation thay vì tạo thêm một password partition.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT` — strong-password rule và OTP invalidation after successful use hỗ trợ chuỗi; wording không đặt failed-attempt threshold hoặc expiry duration.

EXECUTION_FEASIBILITY: `POSTMAN_WITH_PRECONDITION_SETUP`

AI_RECOMMENDATION: `APPROVE`

AI_REVIEW_REASON: Điểm mới là transition failure → corrected retry, không phải variation password đơn lẻ. OTP hợp lệ phải được setup và thời gian chạy phải tránh biến expiry chưa đặc tả thành oracle.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `PASS`
- `SEMANTICALLY_UNIQUE`: `PASS`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `PASS`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `APPROVE`

HUMAN_COMMENT:

### API01-STU-003

CASE_ID: `API01-STU-003`

API: `API-01`

TITLE: Wrong-token failure then correct-token recovery

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API01-REQ-007`, `API01-REQ-009`

WHY_AI_MISSED: `SECURITY_REASONING_GAP` — AI kiểm tra wrong-token rejection nhưng không theo dõi bằng rightful use để chứng minh một guess sai không consume token thật.

CLOSEST_AI_CASES: `API01-AI-019`, `API01-AI-014`, `API01-AI-015`

SEMANTIC_DIFFERENCE: Khác `API01-AI-019` ở bước recovery bằng issued token và khác `API01-STU-001` ở threat condition: wrong token cho đúng email thay vì token đúng bị gửi với email khác.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT` — token mismatch không được reset; successful use mới dẫn đến invalidation. Không giả định lockout/rate-limit threshold.

EXECUTION_FEASIBILITY: `POSTMAN_WITH_PRECONDITION_SETUP`

AI_RECOMMENDATION: `APPROVE`

AI_REVIEW_REASON: Case bổ sung sequence security có risk khác email-binding misuse. Cần issued token fixture và follow-up request; không cần đặt expected HTTP status.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `PASS`
- `SEMANTICALLY_UNIQUE`: `PASS`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `PASS`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `APPROVE`

HUMAN_COMMENT:

### API01-STU-004

CASE_ID: `API01-STU-004`

API: `API-01`

TITLE: Independent users' OTP invalidation isolation

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API01-REQ-007`, `API01-REQ-009`

WHY_AI_MISSED: `COVERAGE_BLIND_SPOT` — raw suite không giữ đồng thời hai valid owner-bound OTP để kiểm tra invalidation scope giữa hai user.

CLOSEST_AI_CASES: `API01-AI-002`, `API01-AI-014`, `API01-AI-015`

SEMANTIC_DIFFERENCE: Raw cases cover binding, one valid lifecycle và replay riêng; case này phát hiện lỗi global/cross-user invalidation bằng hai token đang valid độc lập.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT` — binding theo email và invalidation của token đã dùng là authoritative; không mở rộng sang session policy.

EXECUTION_FEASIBILITY: `POSTMAN_WITH_PRECONDITION_SETUP`

AI_RECOMMENDATION: `APPROVE`

AI_REVIEW_REASON: Hai successful lifecycles tạo risk isolation riêng, không phải lặp lại cùng partition. Cần hai user và hai OTP fixtures.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `PASS`
- `SEMANTICALLY_UNIQUE`: `PASS`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `PASS`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `APPROVE`

HUMAN_COMMENT:

### API01-STU-005

CASE_ID: `API01-STU-005`

API: `API-01`

TITLE: Replay on user A does not disturb unused token B

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API01-REQ-007`, `API01-REQ-009`

WHY_AI_MISSED: `SECURITY_REASONING_GAP` — raw replay case chỉ theo dõi user A; raw binding case không kết hợp pending token của user B.

CLOSEST_AI_CASES: `API01-AI-015`, `API01-AI-002`, `API01-AI-014`

SEMANTIC_DIFFERENCE: Case chèn replay của used OTP A giữa hai user lifecycles rồi chứng minh token B vẫn usable. Nó khác `API01-STU-004` vì risk trigger là replay event, không chỉ successful invalidation của A.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT` — used OTP phải bị invalidated và email-token binding tách token B; không dựa vào undocumented response equivalence.

EXECUTION_FEASIBILITY: `POSTMAN_WITH_PRECONDITION_SETUP`

AI_RECOMMENDATION: `APPROVE`

AI_REVIEW_REASON: Case có interaction replay + cross-user lifecycle riêng và rationale cụ thể. Cần hai OTP và sequence ba state transitions.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `PASS`
- `SEMANTICALLY_UNIQUE`: `PASS`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `PASS`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `APPROVE`

HUMAN_COMMENT:

## API-02 — `POST /api/checkout`

### API02-STU-001

CASE_ID: `API02-STU-001`

API: `API-02`

TITLE: Unauthorized tampered checkout then authorized recovery

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API02-REQ-002`, `API02-REQ-004`, `API02-REQ-005`, `API02-REQ-006`, `API02-REQ-007`, `API02-REQ-010`

WHY_AI_MISSED: `STATEFUL_REASONING_GAP` — AI có invalid JWT, low client total và valid checkout riêng nhưng không nối thành một recovery sequence trên cùng cart.

CLOSEST_AI_CASES: `API02-AI-023`, `API02-AI-018`, `API02-AI-002`, `API02-AI-014`

SEMANTIC_DIFFERENCE: Case xác minh unauthorized/tampered attempt không tạo success side effect, sau đó authenticated request vẫn dùng cart-derived total và clear đúng cart.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT` — valid JWT, server-calculated total và clear-on-success đều authoritative. Không đặt empty-cart, idempotency, coupon hoặc failure response schema.

EXECUTION_FEASIBILITY: `POSTMAN_WITH_PRECONDITION_SETUP`

AI_RECOMMENDATION: `APPROVE`

AI_REVIEW_REASON: Combination có state recovery mới so với 40 raw cases. Cần setup cart và invalid/valid JWT fixtures; cart inspection có thể thực hiện bằng supporting setup API nhưng không biến FR-07 thành checkout oracle.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `PASS`
- `SEMANTICALLY_UNIQUE`: `PASS`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `PASS`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `APPROVE`

HUMAN_COMMENT:

### API02-STU-002

CASE_ID: `API02-STU-002`

API: `API-02`

TITLE: Identity spoof combined with victim-cart total

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API02-REQ-004`, `API02-REQ-005`, `API02-REQ-006`, `API02-REQ-007`

WHY_AI_MISSED: `SECURITY_REASONING_GAP` — AI tách payload identity spoof khỏi victim-cart-valued total, nên chưa thử hai attacker-controlled signals trong cùng request.

CLOSEST_AI_CASES: `API02-AI-017`, `API02-AI-027`, `API02-AI-036`

SEMANTIC_DIFFERENCE: `API02-AI-017` đã dùng client total giống cart B nhưng không thêm spoofed user ID; `API02-AI-027` thêm user B nhưng không kết hợp strategic total. Case này giữ JWT A là authority dưới cả hai tín hiệu.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT` — authenticated identity, user/cart isolation, server-derived total và clear đúng cart là authoritative.

EXECUTION_FEASIBILITY: `POSTMAN_WITH_PRECONDITION_SETUP`

AI_RECOMMENDATION: `APPROVE`

AI_REVIEW_REASON: Interaction giữa identity và total trust boundaries là risk riêng, không dựa vào undocumented body field acceptance; unexpected `user_id` chỉ là hostile input, oracle vẫn từ JWT/cart rules.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `PASS`
- `SEMANTICALLY_UNIQUE`: `PASS`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `PASS`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `APPROVE`

HUMAN_COMMENT:

### API02-STU-003

CASE_ID: `API02-STU-003`

API: `API-02`

TITLE: Simultaneous total and address injection payloads

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API02-REQ-005`, `API02-REQ-006`, `API02-REQ-007`, `API02-REQ-011`

WHY_AI_MISSED: `SECURITY_REASONING_GAP` — AI thử injection ở total và address riêng, chưa thử combined persistence path cùng server-total invariant.

CLOSEST_AI_CASES: `API02-AI-025`, `API02-AI-026`, `API02-AI-034`

SEMANTIC_DIFFERENCE: Một request đồng thời stress hai persisted/untrusted values và kiểm tra interaction giữa parameterization, authoritative total và cart side effect; không đặt shipping-address validation oracle.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT` — SEC-05 và FR-08 hỗ trợ parameterization/server total; expected result chỉ yêu cầu input là data và unrelated persistence không bị phá.

EXECUTION_FEASIBILITY: `POSTMAN_PLUS_EXTERNAL_VERIFICATION`

AI_RECOMMENDATION: `APPROVE`

AI_REVIEW_REASON: Combination interaction có khả năng đi qua cùng persistence operation, khác hai single-field raw cases. Cần database snapshot để xác minh unrelated state; không ép thành response-only Postman assertion.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `PASS`
- `SEMANTICALLY_UNIQUE`: `PASS`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `PASS`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `APPROVE`

HUMAN_COMMENT:

### API02-STU-004

CASE_ID: `API02-STU-004`

API: `API-02`

TITLE: Expired JWT then refreshed valid checkout

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API02-REQ-002`, `API02-REQ-004`, `API02-REQ-005`, `API02-REQ-007`, `API02-REQ-010`

WHY_AI_MISSED: Existing explanation says `CROSS_ENDPOINT_DEPENDENCY`, nhưng request chỉ dùng expired/fresh fixtures và không gọi refresh endpoint; explanation đó không chứng minh cross-endpoint dependency.

CLOSEST_AI_CASES: `API02-AI-024`, `API02-AI-014`, `API02-AI-018`, `API02-AI-023`

SEMANTIC_DIFFERENCE: So với raw suite, case thêm failure → valid retry sequence. Tuy nhiên semantic objective/state trùng pattern đã có trong `API02-STU-001`; đổi malformed/invalid JWT thành expired JWT không tạo state/persistence risk mới.

GENUINELY_MISSED: `NO`

ORACLE_REVIEW: `SUFFICIENT` — auth và clear-on-success được backed, nhưng oracle tốt không làm case trở thành unique.

EXECUTION_FEASIBILITY: `POSTMAN_WITH_PRECONDITION_SETUP`

AI_RECOMMENDATION: `REPLACE`

AI_REVIEW_REASON: Không giữ một auth-partition variation chỉ để đủ năm case. Case còn có why/category không defensible vì không có refresh endpoint interaction. Human nên chọn một risk chưa được raw suite và bốn Student cases còn lại bao phủ; replacement chưa được tạo ở phase này.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `FAIL`
- `SEMANTICALLY_UNIQUE`: `FAIL`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `FAIL`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `REPLACE`

HUMAN_COMMENT: `NOT_GENUINELY_MISSED_BY_AI`; preserved as rejected history and excluded from the approved Student Extension count.

### API02-STU-005

CASE_ID: `API02-STU-005`

API: `API-02`

TITLE: Two-user sequential checkout with swapped client totals

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API02-REQ-004`, `API02-REQ-005`, `API02-REQ-006`, `API02-REQ-007`

WHY_AI_MISSED: `COVERAGE_BLIND_SPOT` — AI kiểm tra one-direction isolation, nhưng không checkout cả A rồi B với swapped trust-boundary values qua hai state transitions.

CLOSEST_AI_CASES: `API02-AI-017`, `API02-AI-036`, `API02-AI-014`

SEMANTIC_DIFFERENCE: Raw suite xác minh checkout A không tác động B; case này tiếp tục checkout B và chứng minh isolation còn giữ sau khi A's cart đã đổi state, đồng thời server bỏ qua client totals ở cả hai hướng.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT` — JWT identity, cart-derived total và successful cart clearing đều authoritative; không assert order schema/status.

EXECUTION_FEASIBILITY: `POSTMAN_WITH_PRECONDITION_SETUP`

AI_RECOMMENDATION: `APPROVE`

AI_REVIEW_REASON: Bilateral sequential state tạo risk khác raw one-direction check và khác `API02-STU-002` single-request spoof combination. Cần two-user cart setup.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `PASS`
- `SEMANTICALLY_UNIQUE`: `PASS`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `PASS`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `APPROVE`

HUMAN_COMMENT:

## API-03 — `POST /api/admin/import-products`

### API03-STU-001

CASE_ID: `API03-STU-001`

API: `API-03`

TITLE: Non-admin mixed batch cannot reach persistence

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API03-REQ-002`, `API03-REQ-003`, `API03-REQ-009`

WHY_AI_MISSED: `SECURITY_REASONING_GAP` — AI kiểm tra non-admin valid batch và admin mixed-invalid batch riêng, chưa kiểm tra authorization precedence trước một partial-write-sensitive body.

CLOSEST_AI_CASES: `API03-AI-026`, `API03-AI-018`, `API03-AI-023`

SEMANTIC_DIFFERENCE: Nếu authorization bị bypass hoặc xử lý sai thứ tự, mixed batch có thể phơi bày partial persistence mà raw non-admin valid batch không phân biệt; state oracle vẫn là zero persistence.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT` — admin-only authorization và atomic rollback đều authoritative; không phụ thuộc status/error precedence.

EXECUTION_FEASIBILITY: `POSTMAN_PLUS_EXTERNAL_VERIFICATION`

AI_RECOMMENDATION: `APPROVE`

AI_REVIEW_REASON: Security + atomicity combination tạo failure mode riêng. Cần products snapshot để phân biệt no persistence; không invent error schema hoặc raw CSV request.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `PASS`
- `SEMANTICALLY_UNIQUE`: `PASS`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `PASS`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `APPROVE`

HUMAN_COMMENT:

### API03-STU-002

CASE_ID: `API03-STU-002`

API: `API-03`

TITLE: Role-tampering payload with invalid batch

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API03-REQ-002`, `API03-REQ-003`, `API03-REQ-009`

WHY_AI_MISSED: `SECURITY_REASONING_GAP` — raw suite không kết hợp explicit body role-escalation signal với mixed-validity/rollback-sensitive rows.

CLOSEST_AI_CASES: `API03-AI-028`, `API03-AI-018`, `API03-AI-026`

SEMANTIC_DIFFERENCE: Khác `API03-STU-001` ở attack vector explicit `role=admin` trong body; case kiểm tra token role remains authority ngay cả khi body đồng thời kích hoạt validation path.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT` — role must come from verified token và invalid row triggers rollback; payload role field không được coi là documented contract field.

EXECUTION_FEASIBILITY: `POSTMAN_PLUS_EXTERNAL_VERIFICATION`

AI_RECOMMENDATION: `APPROVE`

AI_REVIEW_REASON: Combination có security signal riêng và oracle từ SEC-03/FR-16. Database snapshot cần để xác minh no partial persistence.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `PASS`
- `SEMANTICALLY_UNIQUE`: `PASS`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `PASS`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `APPROVE`

HUMAN_COMMENT:

### API03-STU-003

CASE_ID: `API03-STU-003`

API: `API-03`

TITLE: Injection-like name plus invalid-price rollback

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API03-REQ-007`, `API03-REQ-009`, `API03-REQ-011`

WHY_AI_MISSED: `SECURITY_REASONING_GAP` — AI kiểm tra parameterized name và invalid-price rollback riêng, chưa đi qua combined security/transaction path.

CLOSEST_AI_CASES: `API03-AI-029`, `API03-AI-018`, `API03-AI-009`

SEMANTIC_DIFFERENCE: Injection-like row là valid theo direct FR-16 name/price rules, nhưng row 2 invalid phải rollback cả batch và không được thực thi name như command. Đây không phải raw single injection hoặc single invalid-position variation.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT` — non-empty name, positive price, atomicity và parameterized database queries đều authoritative; không dùng FR-15-only rules.

EXECUTION_FEASIBILITY: `POSTMAN_PLUS_EXTERNAL_VERIFICATION`

AI_RECOMMENDATION: `APPROVE`

AI_REVIEW_REASON: Security + atomicity interaction có risk riêng và cần persistence snapshot. Không giả định category behavior, price precision hay raw CSV transport.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `PASS`
- `SEMANTICALLY_UNIQUE`: `PASS`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `PASS`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `APPROVE`

HUMAN_COMMENT:

### API03-STU-004

CASE_ID: `API03-STU-004`

API: `API-03`

TITLE: Committed batch survives later invalid import rollback

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API03-REQ-007`, `API03-REQ-009`

WHY_AI_MISSED: `STATEFUL_REASONING_GAP` — AI có invalid → corrected retry và valid commit riêng, nhưng không kiểm tra valid commit → later rollback transaction scope.

CLOSEST_AI_CASES: `API03-AI-016`, `API03-AI-021`, `API03-AI-018`

SEMANTIC_DIFFERENCE: Case đảo thứ tự của retry flow và kiểm tra rollback batch B không undo committed batch A. Risk là transaction leakage across requests, không phải vị trí invalid row đơn thuần.

GENUINELY_MISSED: `YES`

ORACLE_REVIEW: `SUFFICIENT` — valid batch commit và invalid batch all-or-nothing là authoritative; không đặt duplicate/category/CSV behavior.

EXECUTION_FEASIBILITY: `POSTMAN_PLUS_EXTERNAL_VERIFICATION`

AI_RECOMMENDATION: `APPROVE`

AI_REVIEW_REASON: Cross-request transaction scope là addition rõ và why-ai-missed cụ thể. Cần database snapshots sau cả hai imports.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `PASS`
- `SEMANTICALLY_UNIQUE`: `PASS`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `PASS`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `APPROVE`

HUMAN_COMMENT:

### API03-STU-005

CASE_ID: `API03-STU-005`

API: `API-03`

TITLE: Two distinct row errors correlate with report and rollback

SOURCE: `STUDENT_ADDED`

REQUIREMENTS: `API03-REQ-007`, `API03-REQ-009`, `API03-REQ-010`

WHY_AI_MISSED: Existing explanation claims AI did not correlate two distinct FR-16 errors with report semantics and rollback, but `API03-AI-020` already uses empty-name + negative-price rows and requires counts/reasons plus unchanged product state.

CLOSEST_AI_CASES: `API03-AI-020`, `API03-AI-038`, `API03-AI-022`, `API03-AI-018`

SEMANTIC_DIFFERENCE: Adding one valid middle row is already covered by mixed-validity rollback in `API03-AI-018/038`; it does not create a new oracle or position-specific persistence risk beyond the raw suite's first/middle/last invalid and multiple-error coverage.

GENUINELY_MISSED: `NO`

ORACLE_REVIEW: `SUFFICIENT` — report counts/reasons and rollback are authoritative, but the concept is not new.

EXECUTION_FEASIBILITY: `POSTMAN_PLUS_EXTERNAL_VERIFICATION`

AI_RECOMMENDATION: `REPLACE`

AI_REVIEW_REASON: Case is a recombination of already executable raw AI coverage rather than a genuine residual gap. Human should request one replacement with a distinct backed risk; no replacement is generated in this phase.

QUALITY_CHECKS:

- `GENUINELY_MISSED_BY_AI`: `FAIL`
- `SEMANTICALLY_UNIQUE`: `FAIL`
- `REQUIREMENT_OR_SECURITY_BACKED`: `PASS`
- `NO_INVENTED_ORACLE`: `PASS`
- `WHY_AI_MISSED_IS_DEFENSIBLE`: `FAIL`
- `EXECUTION_FEASIBILITY_IDENTIFIED`: `PASS`

HUMAN_DECISION: `REPLACE`

HUMAN_COMMENT: `NOT_GENUINELY_MISSED_BY_AI`; preserved as rejected history and excluded from the approved Student Extension count.

## Summary

```text
API_01:
TOTAL: 5
RECOMMEND_APPROVE: 5
RECOMMEND_MODIFY: 0
RECOMMEND_REPLACE: 0
RECOMMEND_DEFER: 0
REPLACEMENT_REQUIRED: 0

API_02:
TOTAL: 5
RECOMMEND_APPROVE: 4
RECOMMEND_MODIFY: 0
RECOMMEND_REPLACE: 1
RECOMMEND_DEFER: 0
REPLACEMENT_REQUIRED: 1

API_03:
TOTAL: 5
RECOMMEND_APPROVE: 4
RECOMMEND_MODIFY: 0
RECOMMEND_REPLACE: 1
RECOMMEND_DEFER: 0
REPLACEMENT_REQUIRED: 1

TOTAL:
STUDENT_CASES_REVIEWED: 15

GENUINELY_MISSED_YES: 13
GENUINELY_MISSED_NO: 2
GENUINELY_MISSED_UNCERTAIN: 0

EXECUTION_FEASIBILITY:
POSTMAN_DIRECT: 0
POSTMAN_WITH_PRECONDITION_SETUP: 9
POSTMAN_PLUS_EXTERNAL_VERIFICATION: 6
NOT_CURRENTLY_EXECUTABLE: 0
```

## Extension Shortfalls Pending Human Decision

- `API_02_EXTENSION_SHORTFALL: 1 REPLACEMENT_REQUIRED`
- `API_03_EXTENSION_SHORTFALL: 1 REPLACEMENT_REQUIRED`
- No weak case is preserved merely to maintain five acceptable cases/API.
- No replacement or filler was generated. The raw target remains satisfied at 40 AI-generated cases/API; previews `30/30/33` are not treated as blockers.

## Human Review Gate

`STUDENT_EXTENSION_TARGETED_REVIEW_FINALIZED`

Postman/Newman, SUT execution, Excel, GitHub Issues, CI/CD, merge, commit, and push were not started.


## Final Human Decision Summary

- `STUDENT_DECISION: MODIFIED_AND_APPROVED`
- API-01: `5 APPROVED`
- API-02: `4 APPROVED`, `API02-STU-004 REPLACE`
- API-03: `4 APPROVED`, `API03-STU-005 REPLACE`
- Replacement decisions are recorded separately in `docs/test-extension/replacement-human-review-packet.md`.
