# API-01 AI-generated Test Cases — Password Reset

- Status: `TEST_GENERATION_REVIEW_REQUIRED`
- Source: `AI_GENERATED`; lifecycle: `DRAFT`; audit: `NOT_AUDITED`; execution: `NOT_IMPLEMENTED`
- Approved input: `docs/requirement-analysis/api-01-reset-password.md`
- Count: **40**; semantic duplicates removed: **0**
- No HTTP status or response schema was inferred: every case uses `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`.

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
| `PARTIALLY_SPECIFIED` | 6 |
| `OBSERVABLE_ONLY` | 10 |
| `SECURITY_EXPECTATION` | 3 |

## Test cases

### API01-AI-001 — Mật khẩu mạnh hợp lệ

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API01-REQ-002, API01-REQ-005`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Xác nhận lớp dữ liệu hợp lệ với email, OTP và mật khẩu đáp ứng đủ bốn nhóm ký tự.
- Preconditions: Email đã đăng ký và đã yêu cầu OTP; OTP còn hiệu lực và gắn với email
- Request variation: email, resetToken, newPassword đều có mặt
- Test data: newPassword=Abcdef1! dài 8 ký tự
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Yêu cầu reset thỏa các quy tắc được nêu và đủ điều kiện xử lý.
- Expected state: Nếu thành công, mật khẩu được đổi và OTP bị vô hiệu hóa.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-002 — OTP của email khác

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API01-REQ-007`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API01-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra OTP không được dùng cho email không phải email đã yêu cầu.
- Preconditions: Hai email đã đăng ký; OTP được cấp cho email A
- Request variation: email B cùng resetToken của email A
- Test data: emailA và emailB khác nhau
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không chấp nhận reset vì OTP không gắn với email gửi trong yêu cầu.
- Expected state: Không đổi mật khẩu của cả hai tài khoản; OTP A không được coi là đã dùng do reset thành công.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-003 — Email chưa từng yêu cầu OTP

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `STATE_TRANSITION`
- Requirement IDs: `API01-REQ-003, API01-REQ-007`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra reset không thể hoàn tất khi chưa có bước cấp OTP cho email.
- Preconditions: Email đã đăng ký nhưng chưa yêu cầu OTP
- Request variation: email hợp lệ, resetToken tùy ý, mật khẩu mạnh
- Test data: resetToken=123456
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không chấp nhận token chưa từng được cấp cho email.
- Expected state: Mật khẩu hiện tại không đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-004 — Email chưa đăng ký

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API01-REQ-007`
- Gap IDs: `API01-RG-001`; risk/potential-discrepancy IDs: `API01-RISK-ENUMERATION`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Khảo sát xử lý email không tồn tại mà không giả định status hoặc error schema.
- Preconditions: Email không có trong hệ thống
- Request variation: email chưa đăng ký, token sáu chữ số, mật khẩu mạnh
- Test data: email=unknown@example.test
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không có tài khoản nào được đổi mật khẩu; cách biểu diễn phản hồi chưa được quy định.
- Expected state: Kho dữ liệu người dùng không thay đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-005 — Thiếu email

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API01-REQ-002`
- Gap IDs: `API01-RG-001`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Khảo sát requiredness của email đang chưa được API contract nêu rõ.
- Preconditions: Có OTP hợp lệ cho một email khác
- Request variation: bỏ trường email
- Test data: resetToken và newPassword có mặt
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận hành vi; không gán status hoặc schema vì requiredness chưa được quy định.
- Expected state: Không được suy diễn thay đổi mật khẩu nếu không xác định được tài khoản.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-006 — Thiếu resetToken

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API01-REQ-002`
- Gap IDs: `API01-RG-001`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Khảo sát requiredness của resetToken trong body được tài liệu hóa nhưng chưa nêu bắt buộc.
- Preconditions: Email đã đăng ký
- Request variation: bỏ trường resetToken
- Test data: email và newPassword có mặt
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận hành vi xử lý trường thiếu; response contract chưa được quy định.
- Expected state: Không tuyên bố trạng thái hậu kiểm ngoài điều quan sát được.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-007 — Thiếu newPassword

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API01-REQ-002, API01-REQ-005`
- Gap IDs: `API01-RG-001`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Khảo sát requiredness của newPassword mà không bịa validation contract.
- Preconditions: OTP hợp lệ cho email
- Request variation: bỏ trường newPassword
- Test data: email và resetToken có mặt
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận hành vi; không có status/error schema authoritative.
- Expected state: Không khẳng định state ngoài dữ liệu quan sát sau chạy.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-008 — Token không phải sáu chữ số

- Primary technique: `DOMAIN_PARTITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API01-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API01-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra lớp token sai định dạng so với yêu cầu OTP ít nhất sáu chữ số.
- Preconditions: Email đã yêu cầu OTP
- Request variation: resetToken chứa chữ cái, mật khẩu mạnh
- Test data: resetToken=12AB56
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không chấp nhận token không phải OTP sáu chữ số đã cấp.
- Expected state: Mật khẩu không đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-009 — Mật khẩu dài 7 ký tự

- Primary technique: `BOUNDARY`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API01-REQ-005`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra ngay dưới biên tối thiểu tám ký tự.
- Preconditions: OTP hợp lệ
- Request variation: mật khẩu có đủ loại ký tự nhưng dài 7
- Test data: newPassword=Abcd1!x
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không chấp nhận mật khẩu dưới tám ký tự.
- Expected state: Mật khẩu cũ và trạng thái OTP không được chuyển sang trạng thái đã dùng bởi một reset thành công.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-010 — Mật khẩu đúng 8 ký tự

- Primary technique: `BOUNDARY`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API01-REQ-005`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra đúng biên tối thiểu với đủ chữ hoa, thường, số và ký tự đặc biệt.
- Preconditions: OTP hợp lệ
- Request variation: mật khẩu dài đúng 8 và đủ bốn nhóm
- Test data: newPassword=Abcde1!x
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Mật khẩu đáp ứng quy tắc mạnh và đủ điều kiện xử lý.
- Expected state: Nếu reset thành công, mật khẩu đổi và OTP bị vô hiệu hóa.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-011 — OTP năm chữ số

- Primary technique: `BOUNDARY`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API01-REQ-003, API01-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API01-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra ngay dưới biên entropy sáu chữ số.
- Preconditions: Email đã yêu cầu reset
- Request variation: resetToken năm chữ số
- Test data: resetToken=12345
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không chấp nhận token dưới sáu chữ số.
- Expected state: Mật khẩu không đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-012 — OTP đúng sáu chữ số

- Primary technique: `BOUNDARY`
- Secondary techniques: `STATE_TRANSITION`
- Requirement IDs: `API01-REQ-003, API01-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra token tại biên sáu chữ số khi đúng email và còn hiệu lực.
- Preconditions: Có OTP sáu chữ số hợp lệ
- Request variation: resetToken sáu chữ số và mật khẩu mạnh
- Test data: resetToken từ bước forgot-password
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Token đạt độ dài yêu cầu và đủ điều kiện kiểm tra tính hợp lệ.
- Expected state: Nếu thành công, OTP bị vô hiệu hóa.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-013 — Thời điểm sát hạn OTP

- Primary technique: `BOUNDARY`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API01-REQ-009`
- Gap IDs: `API01-RG-003`; risk/potential-discrepancy IDs: `API01-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát hành vi ngay quanh expiry khi thời lượng và quy ước biên chưa được nêu.
- Preconditions: Có cơ chế tạo dữ liệu ở hai phía của thời điểm hết hạn
- Request variation: gửi cùng cấu trúc trước và sau thời điểm biên
- Test data: expiry duration phải lấy từ cấu hình quan sát được
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận phía nào của biên được chấp nhận; không tự đặt thời lượng hoặc status.
- Expected state: So sánh trạng thái mật khẩu và token trước/sau mỗi lần thử.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-014 — Luồng issued đến reset thành công

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API01-REQ-003, API01-REQ-009, API01-REQ-010`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra chuỗi yêu cầu OTP, dùng OTP hợp lệ và hoàn tất reset.
- Preconditions: Email đã đăng ký
- Request variation: forgot-password trước, reset-password sau
- Test data: OTP lấy từ demo response được tài liệu hóa
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Reset hợp lệ đổi mật khẩu đúng một lần.
- Expected state: OTP chuyển từ issued sang invalidated.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-015 — Dùng lại OTP sau thành công

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API01-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API01-RISK-REPLAY`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra replay của token đã bị vô hiệu hóa.
- Preconditions: Một reset bằng OTP đã thành công
- Request variation: gửi lại cùng email, token và mật khẩu mạnh khác
- Test data: cùng resetToken đã dùng
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không chấp nhận OTP đã dùng lại.
- Expected state: Mật khẩu chỉ phản ánh reset thành công đầu tiên.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-016 — OTP đã hết hạn

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API01-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra chuyển trạng thái expired khiến OTP không còn dùng được.
- Preconditions: Có OTP vượt quá thời hạn cấu hình thực tế
- Request variation: email và OTP hết hạn, mật khẩu mạnh
- Test data: token expired
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không chấp nhận OTP đã hết hạn.
- Expected state: Mật khẩu không đổi; token không trở lại valid.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-017 — Yêu cầu OTP lần hai

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API01-REQ-007, API01-REQ-009`
- Gap IDs: `API01-RG-003`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Quan sát token cũ khi cùng email được cấp token mới vì chính sách supersession chưa nêu.
- Preconditions: Cùng email đã nhận token A rồi token B
- Request variation: thử token A sau khi B được cấp
- Test data: hai token của cùng email
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận A còn hiệu lực hay bị thay thế; không biến hành vi thành requirement.
- Expected state: Theo dõi token nào được vô hiệu hóa và mật khẩu có đổi hay không.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-018 — Reset thất bại do mật khẩu yếu

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API01-REQ-005, API01-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra lỗi quy tắc mật khẩu không được tính là reset thành công.
- Preconditions: OTP hợp lệ
- Request variation: đúng email/token nhưng mật khẩu yếu
- Test data: newPassword=abcdefgh
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không hoàn tất reset vì mật khẩu không đạt quy tắc.
- Expected state: Mật khẩu không đổi; OTP không được tuyên bố đã dùng bởi reset thành công.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-019 — Reset thất bại do token sai

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API01-REQ-007`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra token sai không tạo chuyển trạng thái mật khẩu.
- Preconditions: Email đã có OTP hợp lệ
- Request variation: gửi token khác sáu chữ số
- Test data: issued token khác submitted token
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không chấp nhận token không khớp.
- Expected state: Mật khẩu không đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-020 — Đăng nhập sau reset

- Primary technique: `STATE_TRANSITION`
- Secondary techniques: `NONE`
- Requirement IDs: `API01-REQ-005`
- Gap IDs: `API01-RG-004`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát hành vi đăng nhập bằng mật khẩu cũ và mới sau reset vì endpoint không định nghĩa downstream session.
- Preconditions: Một reset đã thành công
- Request variation: thực hiện login riêng bằng mật khẩu cũ rồi mật khẩu mới
- Test data: hai lần đăng nhập hậu kiểm
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận hành vi downstream; không dùng làm oracle trực tiếp của reset-password.
- Expected state: Ghi nhận trạng thái xác thực quan sát được mà không suy diễn session policy.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-021 — Thiếu chữ hoa

- Primary technique: `SECURITY`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API01-REQ-005`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra một lớp mật khẩu không có uppercase.
- Preconditions: OTP hợp lệ
- Request variation: newPassword đủ dài nhưng không có chữ hoa
- Test data: abcdef1!
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không chấp nhận mật khẩu thiếu chữ hoa.
- Expected state: Mật khẩu không đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-022 — Thiếu chữ thường

- Primary technique: `SECURITY`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API01-REQ-005`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra một lớp mật khẩu không có lowercase.
- Preconditions: OTP hợp lệ
- Request variation: newPassword đủ dài nhưng không có chữ thường
- Test data: ABCDEF1!
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không chấp nhận mật khẩu thiếu chữ thường.
- Expected state: Mật khẩu không đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-023 — Thiếu chữ số

- Primary technique: `SECURITY`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API01-REQ-005`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra một lớp mật khẩu không có digit.
- Preconditions: OTP hợp lệ
- Request variation: newPassword đủ dài nhưng không có chữ số
- Test data: Abcdefg!
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không chấp nhận mật khẩu thiếu chữ số.
- Expected state: Mật khẩu không đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-024 — Thiếu ký tự đặc biệt

- Primary technique: `SECURITY`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API01-REQ-005`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra một lớp mật khẩu không có allowed special character.
- Preconditions: OTP hợp lệ
- Request variation: newPassword đủ dài nhưng chỉ chữ và số
- Test data: Abcdefg1
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không chấp nhận mật khẩu thiếu ký tự đặc biệt.
- Expected state: Mật khẩu không đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-025 — Nhiều lần đoán OTP sai

- Primary technique: `SECURITY`
- Secondary techniques: `STATE_TRANSITION`
- Requirement IDs: `API01-REQ-009`
- Gap IDs: `API01-RG-003`; risk/potential-discrepancy IDs: `API01-RISK-BRUTE-FORCE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát kiểm soát brute force hoặc rate limit chưa được đặc tả.
- Preconditions: Email đã có OTP hợp lệ
- Request variation: lặp nhiều token sai có kiểm soát
- Test data: chuỗi OTP sai, không chứa secret thật
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận throttling, lockout hoặc phản hồi; không tự đặt ngưỡng hay status.
- Expected state: Theo dõi token hợp lệ và tài khoản có bị thay đổi trạng thái hay không.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-026 — So sánh phản hồi email tồn tại và không tồn tại

- Primary technique: `SECURITY`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API01-REQ-007`
- Gap IDs: `API01-RG-001`; risk/potential-discrepancy IDs: `API01-RISK-ENUMERATION`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát nguy cơ user enumeration mà không yêu cầu hai response schema cụ thể.
- Preconditions: Chuẩn bị một email đăng ký và một email không tồn tại
- Request variation: gửi token sai giống nhau cho hai email
- Test data: cặp request chỉ khác email
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: So sánh tín hiệu quan sát được; không tuyên bố response phải đồng nhất khi contract chưa nêu.
- Expected state: Không tài khoản nào được đổi mật khẩu.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-027 — Chuỗi injection trong email

- Primary technique: `SECURITY`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API01-REQ-002, API01-REQ-007`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API01-RISK-INJECTION`; implementation-observation IDs: `NONE`
- Oracle basis: `SECURITY_EXPECTATION`
- Objective: Kiểm tra dữ liệu email kiểu injection không phá vỡ ranh giới truy vấn hoặc đổi tài khoản khác.
- Preconditions: Có dữ liệu baseline để hậu kiểm
- Request variation: email chứa SQL metacharacters, token bất kỳ
- Test data: email=' OR 1=1 --
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không được reset tài khoản ngoài tài khoản được xác thực bởi email/token hợp lệ.
- Expected state: Không có thay đổi trái phép trong dữ liệu người dùng.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-028 — Chuỗi injection trong resetToken

- Primary technique: `SECURITY`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API01-REQ-007, API01-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API01-RISK-INJECTION`; implementation-observation IDs: `NONE`
- Oracle basis: `SECURITY_EXPECTATION`
- Objective: Kiểm tra token kiểu injection không bỏ qua binding hoặc lifecycle.
- Preconditions: Có tài khoản baseline
- Request variation: resetToken chứa metacharacters
- Test data: resetToken=' OR '1'='1
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không được vượt qua kiểm tra OTP bằng chuỗi không phải token hợp lệ.
- Expected state: Mật khẩu không đổi.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-029 — Body JSON đúng ba trường tài liệu hóa

- Primary technique: `SCHEMA`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API01-REQ-001, API01-REQ-002`
- Gap IDs: `API01-RG-001`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `PARTIALLY_SPECIFIED`
- Objective: Xác nhận request shape dùng email, resetToken và newPassword theo API specification.
- Preconditions: OTP hợp lệ
- Request variation: JSON object có đúng ba field đã tài liệu hóa
- Test data: không thêm field
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Request phù hợp request schema tài liệu hóa; status và response schema vẫn chưa xác định.
- Expected state: State phụ thuộc business validation và kết quả quan sát.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-030 — Thêm trường confirmation khớp

- Primary technique: `SCHEMA`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API01-REQ-004, API01-REQ-006`
- Gap IDs: `API01-RG-002`; risk/potential-discrepancy IDs: `API01-ID-001`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát representation của confirmation khi FR-03 yêu cầu nhưng endpoint contract không mô tả.
- Preconditions: OTP hợp lệ
- Request variation: thêm confirmation bằng newPassword
- Test data: confirmation=Abcdef1!
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận field được dùng, bỏ qua hay từ chối; không chọn một hành vi làm oracle.
- Expected state: Nếu reset thành công, OTP bị vô hiệu hóa; nếu không, ghi nhận state thực tế.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-031 — Thêm trường confirmation không khớp

- Primary technique: `SCHEMA`
- Secondary techniques: `BUSINESS_RULE`
- Requirement IDs: `API01-REQ-004, API01-REQ-006`
- Gap IDs: `API01-RG-002`; risk/potential-discrepancy IDs: `API01-ID-001`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát gap giữa quy tắc mismatch và body contract hiện tại.
- Preconditions: OTP hợp lệ
- Request variation: confirmation khác newPassword
- Test data: newPassword=Abcdef1!, confirmation=Abcdef2!
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: FR-03 yêu cầu mismatch bị từ chối nhưng representation API chưa rõ; ghi nhận mà không bịa schema/status.
- Expected state: Hậu kiểm mật khẩu và token để ghi nhận tác động thực tế.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-032 — Thêm field không tài liệu hóa

- Primary technique: `SCHEMA`
- Secondary techniques: `NONE`
- Requirement IDs: `API01-REQ-002`
- Gap IDs: `API01-RG-001`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát chính sách additional properties chưa được quy định.
- Preconditions: OTP hợp lệ
- Request variation: JSON có field unexpected
- Test data: unexpected=true
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận accept, ignore hoặc reject; không tự đặt oracle.
- Expected state: Hậu kiểm state theo kết quả thực tế.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-033 — Malformed JSON

- Primary technique: `SCHEMA`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API01-REQ-002`
- Gap IDs: `API01-RG-001`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Quan sát xử lý cú pháp JSON lỗi mà contract không nêu response.
- Preconditions: Không cần OTP hợp lệ
- Request variation: body JSON bị cắt
- Test data: chuỗi JSON thiếu dấu đóng
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận status/body thực tế, không gán expected schema.
- Expected state: Không khẳng định thay đổi state ngoài hậu kiểm.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-034 — Không gửi confirmation

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `SCHEMA`
- Requirement IDs: `API01-REQ-006`
- Gap IDs: `API01-RG-002`; risk/potential-discrepancy IDs: `API01-ID-001`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Đánh dấu trực tiếp khoảng trống representation của quy tắc xác nhận mật khẩu.
- Preconditions: OTP hợp lệ
- Request variation: chỉ ba field theo API spec, không confirmation
- Test data: newPassword mạnh
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận endpoint có thực thi quy tắc confirmation hay không; chưa có oracle representation.
- Expected state: Hậu kiểm mật khẩu và token.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-035 — Mật khẩu không lưu plaintext

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API01-REQ-008`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API01-ID-002`; implementation-observation IDs: `NONE`
- Oracle basis: `SECURITY_EXPECTATION`
- Objective: Kiểm tra hậu điều kiện lưu trữ mật khẩu theo SEC-01 sau reset thành công.
- Preconditions: Có quyền kiểm tra dữ liệu trong môi trường test cô lập; Reset hợp lệ đã thành công
- Request variation: hậu kiểm bản ghi user, không log secret
- Test data: so sánh an toàn với plaintext đã gửi
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Giá trị persisted không được bằng plaintext newPassword.
- Expected state: OTP đã invalidated và thông tin nhạy cảm không bị ghi vào evidence.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-036 — Token vô hiệu hóa sau dùng

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `STATE_TRANSITION`
- Requirement IDs: `API01-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `API01-ID-004`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra trực tiếp quy tắc one-time sau một reset thành công.
- Preconditions: Reset đầu tiên thành công
- Request variation: thử lại đúng token cũ
- Test data: same email and token
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Không chấp nhận lần dùng thứ hai.
- Expected state: Không có lần đổi mật khẩu thứ hai từ token cũ.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-037 — Mật khẩu có khoảng trắng nhưng đủ lớp

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `DOMAIN_PARTITION`
- Requirement IDs: `API01-REQ-005`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra password vẫn dựa trên chính sách explicit khi khoảng trắng không được định nghĩa là special.
- Preconditions: OTP hợp lệ
- Request variation: mật khẩu dài đủ nhưng special duy nhất là space
- Test data: newPassword=Abcdef1 plus space
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận theo danh sách allowed special thực tế từ requirement; space không được tự coi là allowed special.
- Expected state: Mật khẩu chỉ đổi nếu toàn bộ quy tắc authoritative được đáp ứng.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-038 — Email đúng khác biệt hoa thường

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API01-REQ-007`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `NONE`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Khảo sát binding khi casing email chưa được quy định nhưng không bỏ qua token association.
- Preconditions: OTP cấp cho dạng casing đã lưu
- Request variation: gửi cùng token với casing email khác
- Test data: User@Example.test so với user@example.test
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận chuẩn hóa casing; không được gắn token sang tài khoản khác.
- Expected state: Chỉ tài khoản gắn với token có thể thay đổi nếu được chấp nhận.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-039 — Mismatch qua representation thay thế

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `STATE_TRANSITION`
- Requirement IDs: `API01-REQ-006`
- Gap IDs: `API01-RG-002`; risk/potential-discrepancy IDs: `API01-ID-001`; implementation-observation IDs: `NONE`
- Oracle basis: `OBSERVABLE_ONLY`
- Objective: Khảo sát tên field xác nhận phổ biến khác chưa có trong contract.
- Preconditions: OTP hợp lệ
- Request variation: thêm confirmPassword khác newPassword
- Test data: confirmPassword=Different1!
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Ghi nhận field bị bỏ qua hay dùng; không nâng convention thành requirement.
- Expected state: Hậu kiểm mật khẩu và token.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

### API01-AI-040 — OTP có hơn sáu chữ số

- Primary technique: `BUSINESS_RULE`
- Secondary techniques: `SECURITY`
- Requirement IDs: `API01-REQ-003, API01-REQ-009`
- Gap IDs: `NONE`; risk/potential-discrepancy IDs: `API01-ID-003`; implementation-observation IDs: `NONE`
- Oracle basis: `AUTHORITATIVE`
- Objective: Kiểm tra yêu cầu at least six-digit entropy với token do hệ thống phát hành có độ dài lớn hơn.
- Preconditions: Hệ thống test có thể cấp token hơn sáu chữ số
- Request variation: email đúng, issued token dài hơn sáu, mật khẩu mạnh
- Test data: issued token length=7
- Expected status: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`
- Expected business result: Token do hệ thống cấp có entropy không dưới sáu chữ số và đủ điều kiện lifecycle.
- Expected state: Nếu thành công, token dài hơn sáu cũng phải bị vô hiệu hóa sau dùng.
- Workflow fields: source=`AI_GENERATED`; audit=`NOT_AUDITED`; execution=`NOT_IMPLEMENTED`

## Traceability matrix

| Requirement / gap / risk / implementation observation | Generated case IDs |
| --- | --- |
| `API01-ID-001` | `API01-AI-030, API01-AI-031, API01-AI-034, API01-AI-039` |
| `API01-ID-002` | `API01-AI-035` |
| `API01-ID-003` | `API01-AI-002, API01-AI-008, API01-AI-011, API01-AI-013, API01-AI-040` |
| `API01-ID-004` | `API01-AI-036` |
| `API01-REQ-001` | `API01-AI-029` |
| `API01-REQ-002` | `API01-AI-001, API01-AI-005, API01-AI-006, API01-AI-007, API01-AI-027, API01-AI-029, API01-AI-032, API01-AI-033` |
| `API01-REQ-003` | `API01-AI-003, API01-AI-011, API01-AI-012, API01-AI-014, API01-AI-040` |
| `API01-REQ-004` | `API01-AI-030, API01-AI-031` |
| `API01-REQ-005` | `API01-AI-001, API01-AI-007, API01-AI-009, API01-AI-010, API01-AI-018, API01-AI-020, API01-AI-021, API01-AI-022, API01-AI-023, API01-AI-024, API01-AI-037` |
| `API01-REQ-006` | `API01-AI-030, API01-AI-031, API01-AI-034, API01-AI-039` |
| `API01-REQ-007` | `API01-AI-002, API01-AI-003, API01-AI-004, API01-AI-017, API01-AI-019, API01-AI-026, API01-AI-027, API01-AI-028, API01-AI-038` |
| `API01-REQ-008` | `API01-AI-035` |
| `API01-REQ-009` | `API01-AI-008, API01-AI-011, API01-AI-012, API01-AI-013, API01-AI-014, API01-AI-015, API01-AI-016, API01-AI-017, API01-AI-018, API01-AI-025, API01-AI-028, API01-AI-036, API01-AI-040` |
| `API01-REQ-010` | `API01-AI-014` |
| `API01-RG-001` | `API01-AI-004, API01-AI-005, API01-AI-006, API01-AI-007, API01-AI-026, API01-AI-029, API01-AI-032, API01-AI-033` |
| `API01-RG-002` | `API01-AI-030, API01-AI-031, API01-AI-034, API01-AI-039` |
| `API01-RG-003` | `API01-AI-013, API01-AI-017, API01-AI-025` |
| `API01-RG-004` | `API01-AI-020` |
| `API01-RISK-BRUTE-FORCE` | `API01-AI-025` |
| `API01-RISK-ENUMERATION` | `API01-AI-004, API01-AI-026` |
| `API01-RISK-INJECTION` | `API01-AI-027, API01-AI-028` |
| `API01-RISK-REPLAY` | `API01-AI-015` |

## Phase boundary

Raw AI generation only. No case has been audited, student-extended, implemented, executed, or classified as a product defect.
