param(
    [string]$WorkspaceRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
)

$ErrorActionPreference = 'Stop'
$techniques = @('DOMAIN_PARTITION', 'BOUNDARY', 'STATE_TRANSITION', 'SECURITY', 'SCHEMA', 'BUSINESS_RULE')

function Parse-List([string]$Value) {
    if ([string]::IsNullOrWhiteSpace($Value) -or $Value -eq '-') { return @() }
    return @($Value.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ })
}

function Parse-Cases([string]$Text) {
    $rows = @()
    foreach ($line in ($Text -split "`r?`n")) {
        if ([string]::IsNullOrWhiteSpace($line) -or $line.TrimStart().StartsWith('#')) { continue }
        $c = $line.Split('|')
        if ($c.Count -ne 14) { throw "Blueprint row must have 14 columns: $line" }
        $rows += [ordered]@{
            number = $c[0].Trim(); primary = $c[1].Trim(); secondary = Parse-List $c[2]
            refs = Parse-List $c[3]; oracle = $c[4].Trim(); gaps = Parse-List $c[5]
            risks = Parse-List $c[6]; title = $c[7].Trim(); objective = $c[8].Trim()
            preconditions = @($c[9].Split(';;') | ForEach-Object { $_.Trim() } | Where-Object { $_ })
            body = $c[10].Trim(); data = $c[11].Trim(); business = $c[12].Trim(); state = $c[13].Trim()
        }
    }
    return $rows
}

$api01 = @'
001|DOMAIN_PARTITION|BUSINESS_RULE|API01-REQ-002,API01-REQ-005|AUTHORITATIVE|-|-|Mật khẩu mạnh hợp lệ|Xác nhận lớp dữ liệu hợp lệ với email, OTP và mật khẩu đáp ứng đủ bốn nhóm ký tự.|Email đã đăng ký và đã yêu cầu OTP;;OTP còn hiệu lực và gắn với email|email, resetToken, newPassword đều có mặt|newPassword=Abcdef1! dài 8 ký tự|Yêu cầu reset thỏa các quy tắc được nêu và đủ điều kiện xử lý.|Nếu thành công, mật khẩu được đổi và OTP bị vô hiệu hóa.
002|DOMAIN_PARTITION|SECURITY|API01-REQ-007|AUTHORITATIVE|-|API01-ID-003|OTP của email khác|Kiểm tra OTP không được dùng cho email không phải email đã yêu cầu.|Hai email đã đăng ký;;OTP được cấp cho email A|email B cùng resetToken của email A|emailA và emailB khác nhau|Không chấp nhận reset vì OTP không gắn với email gửi trong yêu cầu.|Không đổi mật khẩu của cả hai tài khoản; OTP A không được coi là đã dùng do reset thành công.
003|DOMAIN_PARTITION|STATE_TRANSITION|API01-REQ-003,API01-REQ-007|AUTHORITATIVE|-|-|Email chưa từng yêu cầu OTP|Kiểm tra reset không thể hoàn tất khi chưa có bước cấp OTP cho email.|Email đã đăng ký nhưng chưa yêu cầu OTP|email hợp lệ, resetToken tùy ý, mật khẩu mạnh|resetToken=123456|Không chấp nhận token chưa từng được cấp cho email.|Mật khẩu hiện tại không đổi.
004|DOMAIN_PARTITION|SECURITY|API01-REQ-007|PARTIALLY_SPECIFIED|API01-RG-001|API01-RISK-ENUMERATION|Email chưa đăng ký|Khảo sát xử lý email không tồn tại mà không giả định status hoặc error schema.|Email không có trong hệ thống|email chưa đăng ký, token sáu chữ số, mật khẩu mạnh|email=unknown@example.test|Không có tài khoản nào được đổi mật khẩu; cách biểu diễn phản hồi chưa được quy định.|Kho dữ liệu người dùng không thay đổi.
005|DOMAIN_PARTITION|SCHEMA|API01-REQ-002|PARTIALLY_SPECIFIED|API01-RG-001|-|Thiếu email|Khảo sát requiredness của email đang chưa được API contract nêu rõ.|Có OTP hợp lệ cho một email khác|bỏ trường email|resetToken và newPassword có mặt|Ghi nhận hành vi; không gán status hoặc schema vì requiredness chưa được quy định.|Không được suy diễn thay đổi mật khẩu nếu không xác định được tài khoản.
006|DOMAIN_PARTITION|SCHEMA|API01-REQ-002|PARTIALLY_SPECIFIED|API01-RG-001|-|Thiếu resetToken|Khảo sát requiredness của resetToken trong body được tài liệu hóa nhưng chưa nêu bắt buộc.|Email đã đăng ký|bỏ trường resetToken|email và newPassword có mặt|Ghi nhận hành vi xử lý trường thiếu; response contract chưa được quy định.|Không tuyên bố trạng thái hậu kiểm ngoài điều quan sát được.
007|DOMAIN_PARTITION|SCHEMA|API01-REQ-002,API01-REQ-005|PARTIALLY_SPECIFIED|API01-RG-001|-|Thiếu newPassword|Khảo sát requiredness của newPassword mà không bịa validation contract.|OTP hợp lệ cho email|bỏ trường newPassword|email và resetToken có mặt|Ghi nhận hành vi; không có status/error schema authoritative.|Không khẳng định state ngoài dữ liệu quan sát sau chạy.
008|DOMAIN_PARTITION|SECURITY|API01-REQ-009|AUTHORITATIVE|-|API01-ID-003|Token không phải sáu chữ số|Kiểm tra lớp token sai định dạng so với yêu cầu OTP ít nhất sáu chữ số.|Email đã yêu cầu OTP|resetToken chứa chữ cái, mật khẩu mạnh|resetToken=12AB56|Không chấp nhận token không phải OTP sáu chữ số đã cấp.|Mật khẩu không đổi.
009|BOUNDARY|BUSINESS_RULE|API01-REQ-005|AUTHORITATIVE|-|-|Mật khẩu dài 7 ký tự|Kiểm tra ngay dưới biên tối thiểu tám ký tự.|OTP hợp lệ|mật khẩu có đủ loại ký tự nhưng dài 7|newPassword=Abcd1!x|Không chấp nhận mật khẩu dưới tám ký tự.|Mật khẩu cũ và trạng thái OTP không được chuyển sang trạng thái đã dùng bởi một reset thành công.
010|BOUNDARY|BUSINESS_RULE|API01-REQ-005|AUTHORITATIVE|-|-|Mật khẩu đúng 8 ký tự|Kiểm tra đúng biên tối thiểu với đủ chữ hoa, thường, số và ký tự đặc biệt.|OTP hợp lệ|mật khẩu dài đúng 8 và đủ bốn nhóm|newPassword=Abcde1!x|Mật khẩu đáp ứng quy tắc mạnh và đủ điều kiện xử lý.|Nếu reset thành công, mật khẩu đổi và OTP bị vô hiệu hóa.
011|BOUNDARY|SECURITY|API01-REQ-003,API01-REQ-009|AUTHORITATIVE|-|API01-ID-003|OTP năm chữ số|Kiểm tra ngay dưới biên entropy sáu chữ số.|Email đã yêu cầu reset|resetToken năm chữ số|resetToken=12345|Không chấp nhận token dưới sáu chữ số.|Mật khẩu không đổi.
012|BOUNDARY|STATE_TRANSITION|API01-REQ-003,API01-REQ-009|AUTHORITATIVE|-|-|OTP đúng sáu chữ số|Kiểm tra token tại biên sáu chữ số khi đúng email và còn hiệu lực.|Có OTP sáu chữ số hợp lệ|resetToken sáu chữ số và mật khẩu mạnh|resetToken từ bước forgot-password|Token đạt độ dài yêu cầu và đủ điều kiện kiểm tra tính hợp lệ.|Nếu thành công, OTP bị vô hiệu hóa.
013|BOUNDARY|SECURITY|API01-REQ-009|OBSERVABLE_ONLY|API01-RG-003|API01-ID-003|Thời điểm sát hạn OTP|Quan sát hành vi ngay quanh expiry khi thời lượng và quy ước biên chưa được nêu.|Có cơ chế tạo dữ liệu ở hai phía của thời điểm hết hạn|gửi cùng cấu trúc trước và sau thời điểm biên|expiry duration phải lấy từ cấu hình quan sát được|Ghi nhận phía nào của biên được chấp nhận; không tự đặt thời lượng hoặc status.|So sánh trạng thái mật khẩu và token trước/sau mỗi lần thử.
014|STATE_TRANSITION|BUSINESS_RULE|API01-REQ-003,API01-REQ-009,API01-REQ-010|AUTHORITATIVE|-|-|Luồng issued đến reset thành công|Kiểm tra chuỗi yêu cầu OTP, dùng OTP hợp lệ và hoàn tất reset.|Email đã đăng ký|forgot-password trước, reset-password sau|OTP lấy từ demo response được tài liệu hóa|Reset hợp lệ đổi mật khẩu đúng một lần.|OTP chuyển từ issued sang invalidated.
015|STATE_TRANSITION|SECURITY|API01-REQ-009|AUTHORITATIVE|-|API01-RISK-REPLAY|Dùng lại OTP sau thành công|Kiểm tra replay của token đã bị vô hiệu hóa.|Một reset bằng OTP đã thành công|gửi lại cùng email, token và mật khẩu mạnh khác|cùng resetToken đã dùng|Không chấp nhận OTP đã dùng lại.|Mật khẩu chỉ phản ánh reset thành công đầu tiên.
016|STATE_TRANSITION|SECURITY|API01-REQ-009|AUTHORITATIVE|-|-|OTP đã hết hạn|Kiểm tra chuyển trạng thái expired khiến OTP không còn dùng được.|Có OTP vượt quá thời hạn cấu hình thực tế|email và OTP hết hạn, mật khẩu mạnh|token expired|Không chấp nhận OTP đã hết hạn.|Mật khẩu không đổi; token không trở lại valid.
017|STATE_TRANSITION|SECURITY|API01-REQ-007,API01-REQ-009|PARTIALLY_SPECIFIED|API01-RG-003|-|Yêu cầu OTP lần hai|Quan sát token cũ khi cùng email được cấp token mới vì chính sách supersession chưa nêu.|Cùng email đã nhận token A rồi token B|thử token A sau khi B được cấp|hai token của cùng email|Ghi nhận A còn hiệu lực hay bị thay thế; không biến hành vi thành requirement.|Theo dõi token nào được vô hiệu hóa và mật khẩu có đổi hay không.
018|STATE_TRANSITION|BUSINESS_RULE|API01-REQ-005,API01-REQ-009|AUTHORITATIVE|-|-|Reset thất bại do mật khẩu yếu|Kiểm tra lỗi quy tắc mật khẩu không được tính là reset thành công.|OTP hợp lệ|đúng email/token nhưng mật khẩu yếu|newPassword=abcdefgh|Không hoàn tất reset vì mật khẩu không đạt quy tắc.|Mật khẩu không đổi; OTP không được tuyên bố đã dùng bởi reset thành công.
019|STATE_TRANSITION|SECURITY|API01-REQ-007|AUTHORITATIVE|-|-|Reset thất bại do token sai|Kiểm tra token sai không tạo chuyển trạng thái mật khẩu.|Email đã có OTP hợp lệ|gửi token khác sáu chữ số|issued token khác submitted token|Không chấp nhận token không khớp.|Mật khẩu không đổi.
020|STATE_TRANSITION|-|API01-REQ-005|OBSERVABLE_ONLY|API01-RG-004|-|Đăng nhập sau reset|Quan sát hành vi đăng nhập bằng mật khẩu cũ và mới sau reset vì endpoint không định nghĩa downstream session.|Một reset đã thành công|thực hiện login riêng bằng mật khẩu cũ rồi mật khẩu mới|hai lần đăng nhập hậu kiểm|Ghi nhận hành vi downstream; không dùng làm oracle trực tiếp của reset-password.|Ghi nhận trạng thái xác thực quan sát được mà không suy diễn session policy.
021|SECURITY|BUSINESS_RULE|API01-REQ-005|AUTHORITATIVE|-|-|Thiếu chữ hoa|Kiểm tra một lớp mật khẩu không có uppercase.|OTP hợp lệ|newPassword đủ dài nhưng không có chữ hoa|abcdef1!|Không chấp nhận mật khẩu thiếu chữ hoa.|Mật khẩu không đổi.
022|SECURITY|BUSINESS_RULE|API01-REQ-005|AUTHORITATIVE|-|-|Thiếu chữ thường|Kiểm tra một lớp mật khẩu không có lowercase.|OTP hợp lệ|newPassword đủ dài nhưng không có chữ thường|ABCDEF1!|Không chấp nhận mật khẩu thiếu chữ thường.|Mật khẩu không đổi.
023|SECURITY|BUSINESS_RULE|API01-REQ-005|AUTHORITATIVE|-|-|Thiếu chữ số|Kiểm tra một lớp mật khẩu không có digit.|OTP hợp lệ|newPassword đủ dài nhưng không có chữ số|Abcdefg!|Không chấp nhận mật khẩu thiếu chữ số.|Mật khẩu không đổi.
024|SECURITY|BUSINESS_RULE|API01-REQ-005|AUTHORITATIVE|-|-|Thiếu ký tự đặc biệt|Kiểm tra một lớp mật khẩu không có allowed special character.|OTP hợp lệ|newPassword đủ dài nhưng chỉ chữ và số|Abcdefg1|Không chấp nhận mật khẩu thiếu ký tự đặc biệt.|Mật khẩu không đổi.
025|SECURITY|STATE_TRANSITION|API01-REQ-009|OBSERVABLE_ONLY|API01-RG-003|API01-RISK-BRUTE-FORCE|Nhiều lần đoán OTP sai|Quan sát kiểm soát brute force hoặc rate limit chưa được đặc tả.|Email đã có OTP hợp lệ|lặp nhiều token sai có kiểm soát|chuỗi OTP sai, không chứa secret thật|Ghi nhận throttling, lockout hoặc phản hồi; không tự đặt ngưỡng hay status.|Theo dõi token hợp lệ và tài khoản có bị thay đổi trạng thái hay không.
026|SECURITY|DOMAIN_PARTITION|API01-REQ-007|OBSERVABLE_ONLY|API01-RG-001|API01-RISK-ENUMERATION|So sánh phản hồi email tồn tại và không tồn tại|Quan sát nguy cơ user enumeration mà không yêu cầu hai response schema cụ thể.|Chuẩn bị một email đăng ký và một email không tồn tại|gửi token sai giống nhau cho hai email|cặp request chỉ khác email|So sánh tín hiệu quan sát được; không tuyên bố response phải đồng nhất khi contract chưa nêu.|Không tài khoản nào được đổi mật khẩu.
027|SECURITY|SCHEMA|API01-REQ-002,API01-REQ-007|SECURITY_EXPECTATION|-|API01-RISK-INJECTION|Chuỗi injection trong email|Kiểm tra dữ liệu email kiểu injection không phá vỡ ranh giới truy vấn hoặc đổi tài khoản khác.|Có dữ liệu baseline để hậu kiểm|email chứa SQL metacharacters, token bất kỳ|email=' OR 1=1 --|Không được reset tài khoản ngoài tài khoản được xác thực bởi email/token hợp lệ.|Không có thay đổi trái phép trong dữ liệu người dùng.
028|SECURITY|SCHEMA|API01-REQ-007,API01-REQ-009|SECURITY_EXPECTATION|-|API01-RISK-INJECTION|Chuỗi injection trong resetToken|Kiểm tra token kiểu injection không bỏ qua binding hoặc lifecycle.|Có tài khoản baseline|resetToken chứa metacharacters|resetToken=' OR '1'='1|Không được vượt qua kiểm tra OTP bằng chuỗi không phải token hợp lệ.|Mật khẩu không đổi.
029|SCHEMA|DOMAIN_PARTITION|API01-REQ-001,API01-REQ-002|PARTIALLY_SPECIFIED|API01-RG-001|-|Body JSON đúng ba trường tài liệu hóa|Xác nhận request shape dùng email, resetToken và newPassword theo API specification.|OTP hợp lệ|JSON object có đúng ba field đã tài liệu hóa|không thêm field|Request phù hợp request schema tài liệu hóa; status và response schema vẫn chưa xác định.|State phụ thuộc business validation và kết quả quan sát.
030|SCHEMA|BUSINESS_RULE|API01-REQ-004,API01-REQ-006|OBSERVABLE_ONLY|API01-RG-002|API01-ID-001|Thêm trường confirmation khớp|Khảo sát representation của confirmation khi FR-03 yêu cầu nhưng endpoint contract không mô tả.|OTP hợp lệ|thêm confirmation bằng newPassword|confirmation=Abcdef1!|Ghi nhận field được dùng, bỏ qua hay từ chối; không chọn một hành vi làm oracle.|Nếu reset thành công, OTP bị vô hiệu hóa; nếu không, ghi nhận state thực tế.
031|SCHEMA|BUSINESS_RULE|API01-REQ-004,API01-REQ-006|OBSERVABLE_ONLY|API01-RG-002|API01-ID-001|Thêm trường confirmation không khớp|Khảo sát gap giữa quy tắc mismatch và body contract hiện tại.|OTP hợp lệ|confirmation khác newPassword|newPassword=Abcdef1!, confirmation=Abcdef2!|FR-03 yêu cầu mismatch bị từ chối nhưng representation API chưa rõ; ghi nhận mà không bịa schema/status.|Hậu kiểm mật khẩu và token để ghi nhận tác động thực tế.
032|SCHEMA|-|API01-REQ-002|OBSERVABLE_ONLY|API01-RG-001|-|Thêm field không tài liệu hóa|Quan sát chính sách additional properties chưa được quy định.|OTP hợp lệ|JSON có field unexpected|unexpected=true|Ghi nhận accept, ignore hoặc reject; không tự đặt oracle.|Hậu kiểm state theo kết quả thực tế.
033|SCHEMA|SECURITY|API01-REQ-002|OBSERVABLE_ONLY|API01-RG-001|-|Malformed JSON|Quan sát xử lý cú pháp JSON lỗi mà contract không nêu response.|Không cần OTP hợp lệ|body JSON bị cắt|chuỗi JSON thiếu dấu đóng|Ghi nhận status/body thực tế, không gán expected schema.|Không khẳng định thay đổi state ngoài hậu kiểm.
034|BUSINESS_RULE|SCHEMA|API01-REQ-006|OBSERVABLE_ONLY|API01-RG-002|API01-ID-001|Không gửi confirmation|Đánh dấu trực tiếp khoảng trống representation của quy tắc xác nhận mật khẩu.|OTP hợp lệ|chỉ ba field theo API spec, không confirmation|newPassword mạnh|Ghi nhận endpoint có thực thi quy tắc confirmation hay không; chưa có oracle representation.|Hậu kiểm mật khẩu và token.
035|BUSINESS_RULE|SECURITY|API01-REQ-008|SECURITY_EXPECTATION|-|API01-ID-002|Mật khẩu không lưu plaintext|Kiểm tra hậu điều kiện lưu trữ mật khẩu theo SEC-01 sau reset thành công.|Có quyền kiểm tra dữ liệu trong môi trường test cô lập;;Reset hợp lệ đã thành công|hậu kiểm bản ghi user, không log secret|so sánh an toàn với plaintext đã gửi|Giá trị persisted không được bằng plaintext newPassword.|OTP đã invalidated và thông tin nhạy cảm không bị ghi vào evidence.
036|BUSINESS_RULE|STATE_TRANSITION|API01-REQ-009|AUTHORITATIVE|-|-|Token vô hiệu hóa sau dùng|Kiểm tra trực tiếp quy tắc one-time sau một reset thành công.|Reset đầu tiên thành công|thử lại đúng token cũ|same email and token|Không chấp nhận lần dùng thứ hai.|Không có lần đổi mật khẩu thứ hai từ token cũ.
037|BUSINESS_RULE|DOMAIN_PARTITION|API01-REQ-005|AUTHORITATIVE|-|-|Mật khẩu có khoảng trắng nhưng đủ lớp|Kiểm tra password vẫn dựa trên chính sách explicit khi khoảng trắng không được định nghĩa là special.|OTP hợp lệ|mật khẩu dài đủ nhưng special duy nhất là space|newPassword=Abcdef1 plus space|Ghi nhận theo danh sách allowed special thực tế từ requirement; space không được tự coi là allowed special.|Mật khẩu chỉ đổi nếu toàn bộ quy tắc authoritative được đáp ứng.
038|BUSINESS_RULE|SECURITY|API01-REQ-007|AUTHORITATIVE|-|-|Email đúng khác biệt hoa thường|Khảo sát binding khi casing email chưa được quy định nhưng không bỏ qua token association.|OTP cấp cho dạng casing đã lưu|gửi cùng token với casing email khác|User@Example.test so với user@example.test|Ghi nhận chuẩn hóa casing; không được gắn token sang tài khoản khác.|Chỉ tài khoản gắn với token có thể thay đổi nếu được chấp nhận.
039|BUSINESS_RULE|STATE_TRANSITION|API01-REQ-006|OBSERVABLE_ONLY|API01-RG-002|API01-ID-001|Mismatch qua representation thay thế|Khảo sát tên field xác nhận phổ biến khác chưa có trong contract.|OTP hợp lệ|thêm confirmPassword khác newPassword|confirmPassword=Different1!|Ghi nhận field bị bỏ qua hay dùng; không nâng convention thành requirement.|Hậu kiểm mật khẩu và token.
040|BUSINESS_RULE|SECURITY|API01-REQ-003,API01-REQ-009|AUTHORITATIVE|-|API01-ID-003|OTP có hơn sáu chữ số|Kiểm tra yêu cầu at least six-digit entropy với token do hệ thống phát hành có độ dài lớn hơn.|Hệ thống test có thể cấp token hơn sáu chữ số|email đúng, issued token dài hơn sáu, mật khẩu mạnh|issued token length=7|Token do hệ thống cấp có entropy không dưới sáu chữ số và đủ điều kiện lifecycle.|Nếu thành công, token dài hơn sáu cũng phải bị vô hiệu hóa sau dùng.
'@

$api02 = @'
001|DOMAIN_PARTITION|BUSINESS_RULE|API02-REQ-002,API02-REQ-005,API02-REQ-006,API02-REQ-007|AUTHORITATIVE|-|-|Checkout hợp lệ với cart có hàng|Kiểm tra happy path dùng JWT hợp lệ và backend lấy tổng từ cart.|User đã đăng nhập;;Cart của user có hàng|Bearer hợp lệ, body có total_amount và shipping_address|client total bằng tổng cart để tránh nhiễu|Checkout đủ điều kiện; tổng có thẩm quyền là tổng backend tính từ cart.|Nếu thành công, cart của user được xóa.
002|DOMAIN_PARTITION|SECURITY|API02-REQ-005,API02-REQ-006|AUTHORITATIVE|-|API02-ID-001|Client total thấp hơn cart|Kiểm tra backend không tin giá trị total_amount bị giảm.|JWT hợp lệ;;Cart có tổng đã biết|total_amount nhỏ hơn tổng cart|cart=100, client=1|Kết quả checkout không được dùng 1 làm tổng có thẩm quyền; backend phải tính từ cart.|Nếu thành công, side effect cart tuân API02-REQ-007.
003|DOMAIN_PARTITION|SECURITY|API02-REQ-005,API02-REQ-006|AUTHORITATIVE|-|API02-ID-001|Client total cao hơn cart|Kiểm tra backend không tin giá trị total_amount bị tăng.|JWT hợp lệ;;Cart có tổng đã biết|total_amount lớn hơn tổng cart|cart=100, client=9999|Tổng có thẩm quyền vẫn phải do backend tính từ cart.|Nếu thành công, cart được xóa.
004|DOMAIN_PARTITION|SECURITY|API02-REQ-005,API02-REQ-006|AUTHORITATIVE|-|API02-ID-001|Client total bằng zero|Kiểm tra zero không thay thế tổng cart dương.|JWT hợp lệ;;Cart có tổng dương|total_amount=0|cart total dương|Backend không được nhận zero làm tổng checkout có thẩm quyền.|Nếu thành công, cart được xóa.
005|DOMAIN_PARTITION|SECURITY|API02-REQ-005,API02-REQ-006|AUTHORITATIVE|-|API02-ID-001|Client total âm|Kiểm tra giá trị âm không điều khiển tổng thanh toán.|JWT hợp lệ;;Cart có tổng dương|total_amount=-1|negative client total|Backend phải bỏ quyền quyết định khỏi giá trị client và tính từ cart.|Nếu thành công, cart được xóa.
006|DOMAIN_PARTITION|SCHEMA|API02-REQ-003,API02-REQ-006|PARTIALLY_SPECIFIED|API02-RG-001|API02-ID-001|Client total dạng chuỗi|Khảo sát type handling nhưng giữ oracle cốt lõi là không tin client total.|JWT hợp lệ;;Cart có tổng đã biết|total_amount là chuỗi số|string value "100"|Ghi nhận validation type; bất kể representation, client total không phải nguồn có thẩm quyền.|State chỉ được khẳng định theo kết quả quan sát và quy tắc clear-on-success.
007|DOMAIN_PARTITION|SCHEMA|API02-REQ-003,API02-REQ-006|PARTIALLY_SPECIFIED|API02-RG-001|API02-ID-003|Thiếu total_amount|Khảo sát field documented nhưng requiredness chưa nêu, đồng thời kiểm tra route có đọc cart.|JWT hợp lệ;;Cart có tổng đã biết|bỏ total_amount|shipping_address có mặt|Ghi nhận requiredness; nếu checkout xử lý, tổng vẫn phải lấy từ cart.|Nếu thành công, cart được xóa.
008|DOMAIN_PARTITION|SCHEMA|API02-REQ-003|OBSERVABLE_ONLY|API02-RG-002|-|Thiếu shipping_address|Khảo sát requiredness địa chỉ chưa được authoritative source quy định.|JWT hợp lệ;;Cart có hàng|bỏ shipping_address|total_amount có mặt|Ghi nhận hành vi mà không gán status hay validation result.|Theo dõi state thực tế; không bịa order schema.
009|BOUNDARY|BUSINESS_RULE|API02-REQ-005,API02-REQ-006|AUTHORITATIVE|-|API02-ID-003|Cart một dòng hàng|Kiểm tra nguồn tổng với cart nhỏ nhất có một dòng theo precondition context.|JWT hợp lệ;;Cart có đúng một dòng|body hợp lệ|one cart line|Backend tính tổng từ cart hiện tại.|Nếu thành công, cart chuyển sang rỗng.
010|BOUNDARY|BUSINESS_RULE|API02-REQ-005,API02-REQ-006|AUTHORITATIVE|-|API02-ID-003|Cart nhiều dòng hàng|Kiểm tra backend cộng toàn bộ cart thay vì lấy một phần.|JWT hợp lệ;;Cart có nhiều dòng|client total cố tình bằng riêng dòng đầu|multi-line cart|Tổng có thẩm quyền phản ánh cart đầy đủ theo FR-08, không phải client total.|Nếu thành công, toàn bộ cart được xóa.
011|BOUNDARY|DOMAIN_PARTITION|API02-REQ-005,API02-REQ-006|PARTIALLY_SPECIFIED|API02-RG-003|-|Cart rỗng|Khảo sát hành vi tại biên không có item vì empty-cart contract chưa nêu.|JWT hợp lệ;;Cart của user rỗng|body documented|empty cart|Ghi nhận accept/reject và response; không bịa expected outcome.|Ghi nhận cart/order state quan sát được, không dùng order-line persistence làm oracle.
012|BOUNDARY|SCHEMA|API02-REQ-003|OBSERVABLE_ONLY|API02-RG-002|-|Địa chỉ chuỗi rỗng|Khảo sát biên empty shipping address chưa có validation rule.|JWT hợp lệ;;Cart có hàng|shipping_address=""|empty string|Ghi nhận hành vi; không gán status hoặc error schema.|Nếu hệ thống báo success, chỉ áp dụng oracle clear cart; các state khác là observation.
013|BOUNDARY|SCHEMA|API02-REQ-003|OBSERVABLE_ONLY|API02-RG-002|-|Địa chỉ rất dài|Khảo sát length handling khi không có giới hạn authoritative.|JWT hợp lệ;;Cart có hàng|shipping_address là chuỗi dài có kiểm soát|length lấy từ test data, không gọi là max|Ghi nhận giới hạn thực tế mà không nâng thành requirement.|Theo dõi state hậu kiểm theo kết quả thực tế.
014|STATE_TRANSITION|BUSINESS_RULE|API02-REQ-005,API02-REQ-007|AUTHORITATIVE|-|API02-ID-002|Cart populated đến cleared|Kiểm tra trực tiếp chuyển trạng thái sau checkout thành công.|JWT hợp lệ;;Cart có hàng và snapshot trước chạy|body hợp lệ|cart snapshot before|Checkout thành công sử dụng tổng cart.|Cart của authenticated user trở thành rỗng.
015|STATE_TRANSITION|SECURITY|API02-REQ-007|OBSERVABLE_ONLY|API02-RG-005|API02-RISK-REPLAY|Gửi lại checkout sau thành công|Quan sát idempotency/replay chưa được đặc tả.|Checkout đầu đã thành công và cart đã clear|gửi lại cùng body và JWT|identical replay|Ghi nhận phản hồi lần hai; không tự quy định có hay không tạo order mới.|Ghi nhận cart và order state nhưng không dùng order-line persistence làm oracle.
016|STATE_TRANSITION|BUSINESS_RULE|API02-REQ-005,API02-REQ-006|AUTHORITATIVE|-|API02-ID-003|Cart đổi trước thời điểm checkout|Kiểm tra tổng được tính từ trạng thái cart hiện tại chứ không từ snapshot client.|JWT hợp lệ;;Client đã xem cart rồi cart thay đổi|gửi total_amount cũ|old client total, new cart state|Backend dùng cart hiện tại để tính tổng.|Nếu thành công, cart hiện tại được xóa.
017|STATE_TRANSITION|SECURITY|API02-REQ-004,API02-REQ-005|AUTHORITATIVE|-|API02-RISK-CROSS-USER|Hai user có cart khác nhau|Kiểm tra checkout của user A không lấy tổng hoặc state cart của user B.|JWT A và B hợp lệ;;Mỗi user có cart khác nhau|checkout bằng JWT A|client total giống cart B để phát hiện nhầm|Tổng phải được tính từ cart gắn với authenticated user A.|Nếu thành công, chỉ cart A được xóa; cart B không bị tác động.
018|STATE_TRANSITION|SECURITY|API02-REQ-002,API02-REQ-004|AUTHORITATIVE|-|-|Auth thất bại trước checkout|Kiểm tra thiếu auth không tiến hành checkout.|Cart baseline tồn tại|không gửi Authorization|body hợp lệ|Không cho user chưa xác thực checkout.|Cart baseline không bị clear bởi checkout thành công.
019|STATE_TRANSITION|DOMAIN_PARTITION|API02-REQ-007|PARTIALLY_SPECIFIED|API02-RG-003|-|Input body lỗi và cart state|Quan sát effect-on-failure vì requirement chỉ quy định clear khi thành công.|JWT hợp lệ;;Cart có hàng|malformed business input|shipping_address thiếu|Ghi nhận kết quả; không suy diễn failure semantics.|Hậu kiểm cart; chỉ kết luận clear bắt buộc nếu request được xác nhận thành công.
020|STATE_TRANSITION|SECURITY|API02-REQ-005,API02-REQ-006|OBSERVABLE_ONLY|API02-RG-005|API02-RISK-RACE|Hai checkout đồng thời|Quan sát race-like behavior và số lần side effect khi idempotency chưa nêu.|JWT hợp lệ;;Cart có hàng|hai request đồng thời với cùng snapshot|parallel requests|Ghi nhận kết quả từng request; tổng mỗi checkout được xử lý không được tin client input.|Ghi nhận cart/order state thực tế; không tự đặt cardinality order.
021|SECURITY|SCHEMA|API02-REQ-002,API02-REQ-004,API02-REQ-010|AUTHORITATIVE|-|-|Thiếu Authorization header|Kiểm tra sensitive checkout bắt buộc có JWT.|Cart test tồn tại|không Authorization|documented body|Không cho checkout khi không có JWT hợp lệ.|Không áp dụng side effect success lên cart.
022|SECURITY|SCHEMA|API02-REQ-002,API02-REQ-010|AUTHORITATIVE|-|-|Authorization sai scheme|Kiểm tra chuỗi auth không theo Bearer không thỏa contract.|Cart test tồn tại|Authorization dùng Basic|Basic placeholder|Không coi header này là valid bearer JWT.|Không clear cart do checkout thành công.
023|SECURITY|SCHEMA|API02-REQ-002,API02-REQ-010|AUTHORITATIVE|-|-|Bearer token malformed|Kiểm tra token không phải JWT hợp lệ.|Cart test tồn tại|Authorization Bearer malformed|token=abc|Không cho checkout với JWT không hợp lệ.|Cart không bị clear bởi checkout thành công.
024|SECURITY|STATE_TRANSITION|API02-REQ-002,API02-REQ-010|AUTHORITATIVE|-|-|Bearer token hết hạn|Kiểm tra expired JWT không thỏa yêu cầu valid token.|Có JWT expired trong môi trường test|Authorization Bearer expired|expired token fixture|Không cho checkout với token hết hạn.|Cart không bị clear bởi checkout thành công.
025|SECURITY|BUSINESS_RULE|API02-REQ-005,API02-REQ-006|AUTHORITATIVE|-|API02-ID-001|Total dạng biểu thức injection|Kiểm tra input total không thể chi phối persistence hoặc vượt qua server recalculation.|JWT hợp lệ;;Cart có tổng biết trước|total_amount là chuỗi SQL-like|"0 OR 1=1"|Client input không được dùng làm tổng có thẩm quyền; truy vấn phải giữ ranh giới dữ liệu.|Không có thay đổi dữ liệu ngoài checkout được phép.
026|SECURITY|SCHEMA|API02-REQ-003,API02-REQ-011|SECURITY_EXPECTATION|-|API02-RISK-INJECTION|Injection trong shipping_address|Kiểm tra địa chỉ được xử lý như dữ liệu, không như câu lệnh.|JWT hợp lệ;;Cart có hàng|shipping_address chứa metacharacters|"x'); DROP TABLE orders;--"|Không được thực thi nội dung input như lệnh hoặc phá dữ liệu ngoài phạm vi.|Nếu checkout thành công, cart clear; dữ liệu khác còn nguyên.
027|SECURITY|STATE_TRANSITION|API02-REQ-002,API02-REQ-004|AUTHORITATIVE|-|API02-RISK-CROSS-USER|JWT user không khớp cart client tham chiếu|Kiểm tra identity từ JWT quyết định cart, không từ payload suy diễn.|User A và B có cart|JWT A, payload thêm user_id B|unexpected user_id field|Checkout chỉ được gắn với user đã xác thực; không được tác động cart B.|Cart B không đổi.
028|SECURITY|STATE_TRANSITION|API02-REQ-004,API02-REQ-006|OBSERVABLE_ONLY|API02-RG-005|API02-RISK-REPLAY|JWT hợp lệ gửi request trùng nhanh|Quan sát duplicate submission khi contract idempotency chưa tồn tại.|JWT hợp lệ;;Cart có hàng|hai request tuần tự rất gần nhau|same body, no idempotency key|Ghi nhận kết quả; không bịa chính sách deduplicate.|Ghi nhận cart/order state thực tế và tách khỏi order-line oracle.
029|SCHEMA|DOMAIN_PARTITION|API02-REQ-001,API02-REQ-002,API02-REQ-003|PARTIALLY_SPECIFIED|API02-RG-001|-|Request đúng header và body documented|Xác nhận shape cơ sở gồm Bearer, total_amount, shipping_address.|JWT hợp lệ;;Cart có hàng|JSON đúng hai field|documented shape|Request phù hợp contract đầu vào; response status/schema chưa được quy định.|Nếu thành công, cart clear.
030|SCHEMA|DOMAIN_PARTITION|API02-REQ-003|OBSERVABLE_ONLY|API02-RG-001|-|Body null|Quan sát parser/validation với JSON null khi requiredness chưa nêu.|JWT hợp lệ;;Cart có hàng|body=null|null JSON|Ghi nhận response thực tế, không bịa schema/status.|Hậu kiểm cart theo kết quả.
031|SCHEMA|DOMAIN_PARTITION|API02-REQ-003|OBSERVABLE_ONLY|API02-RG-001|-|Body là array|Quan sát sai top-level type so với documented JSON object.|JWT hợp lệ;;Cart có hàng|body=[]|empty array|Ghi nhận xử lý top-level array mà không tự định nghĩa error contract.|Hậu kiểm cart theo kết quả.
032|SCHEMA|SECURITY|API02-REQ-003,API02-REQ-004|OBSERVABLE_ONLY|API02-RG-001|-|Malformed JSON|Quan sát syntax-error handling với JWT hợp lệ.|JWT hợp lệ;;Cart có hàng|JSON bị cắt|invalid syntax|Ghi nhận status/body thực tế; không gán expected schema.|Không suy diễn state nếu chưa hậu kiểm.
033|SCHEMA|SECURITY|API02-REQ-003,API02-REQ-004|OBSERVABLE_ONLY|API02-RG-001|-|Sai Content-Type|Quan sát request JSON gửi với content type khác khi failure contract không nêu.|JWT hợp lệ;;Cart có hàng|text/plain chứa JSON text|Content-Type=text/plain|Ghi nhận parsing/validation thực tế.|Hậu kiểm cart; clear chỉ là oracle khi checkout thành công.
034|BUSINESS_RULE|SECURITY|API02-REQ-005,API02-REQ-006|AUTHORITATIVE|-|API02-ID-001,API02-ID-003|Backend recompute với client total khớp|Kiểm tra việc trùng giá trị không che mất nghĩa vụ đọc cart và tính lại.|JWT hợp lệ;;Cart có tổng biết trước|client total tình cờ bằng cart total|equal values|Cần evidence backend-derived total; equality alone không chứng minh client được tin.|Nếu thành công, cart clear.
035|BUSINESS_RULE|SECURITY|API02-REQ-005,API02-REQ-006|AUTHORITATIVE|-|API02-ID-001|Client total có phần thập phân khác|Kiểm tra tampering nhỏ không được dùng làm tổng có thẩm quyền.|JWT hợp lệ;;Cart total biết trước|client total lệch một phần nhỏ|cart=100, client=99.99|Backend dùng total tính từ cart.|Nếu thành công, cart clear.
036|BUSINESS_RULE|STATE_TRANSITION|API02-REQ-007|AUTHORITATIVE|-|API02-ID-002|Clear đúng cart sau success|Kiểm tra side effect clear nhắm đúng authenticated user's cart.|User A và B đều có cart;;Checkout A thành công|hậu kiểm cả hai cart|two-user state|Checkout thành công của A không xác lập quy tắc cho B.|Cart A rỗng; cart B giữ nguyên.
037|BUSINESS_RULE|DOMAIN_PARTITION|API02-REQ-005,API02-REQ-006,API02-REQ-008|AUTHORITATIVE|-|-|Cart có quantity nhiều hơn một|Dùng FR-07 chỉ làm precondition để kiểm tra total của FR-08 từ cart hiện tại.|JWT hợp lệ;;Cart có một product quantity lớn hơn một|client total chỉ tính quantity một|supporting cart setup|Backend total phản ánh cart hiện tại theo FR-08; không biến quy tắc merge FR-07 thành checkout oracle.|Nếu thành công, cart được xóa.
038|BUSINESS_RULE|DOMAIN_PARTITION|API02-REQ-005,API02-REQ-006,API02-REQ-009|OBSERVABLE_ONLY|API02-RG-004|-|Cart có coupon context|Giữ FR-09 ở supporting context và quan sát liệu checkout có integration hay không.|JWT hợp lệ;;Cart test có trạng thái coupon được thiết lập qua feature riêng|checkout body không có contract coupon|coupon context only|Ghi nhận total và phản hồi; không dùng FR-09 làm direct checkout oracle.|Nếu checkout được xác nhận thành công, cart clear theo FR-08.
039|BUSINESS_RULE|SCHEMA|API02-REQ-003|OBSERVABLE_ONLY|API02-RG-003|-|Quan sát initial order status|Ghi nhận trạng thái order tạo ra mà không biến implementation value thành requirement.|Checkout hợp lệ có thể thành công;;Có quyền đọc state test|body documented|post-checkout observation|Không có authoritative initial status oracle.|Ghi nhận giá trị thực tế; không đánh defect vì khác một giá trị tự giả định.
040|BUSINESS_RULE|STATE_TRANSITION|API02-REQ-007|OBSERVABLE_ONLY|API02-RG-003|-|Quan sát order-line persistence|Bao phủ gap nhưng tuyệt đối không coi thiếu order lines là requirement discrepancy.|Checkout hợp lệ có thể thành công;;Có phép kiểm tra dữ liệu test|body documented|post-checkout persistence observation|Ghi nhận có/không order lines; không dùng làm pass/fail oracle của FR-08.|Cart clear vẫn là authoritative side effect nếu checkout thành công.
'@

$api03 = @'
001|DOMAIN_PARTITION|BUSINESS_RULE|API03-REQ-002,API03-REQ-004,API03-REQ-007,API03-REQ-009|AUTHORITATIVE|-|-|Admin import một product hợp lệ|Kiểm tra JSON products array hợp lệ với admin JWT.|Admin JWT hợp lệ|products có một item name non-empty và price positive|one valid product|Batch hợp lệ đủ điều kiện import.|Toàn bộ một item được commit và report được tạo.
002|DOMAIN_PARTITION|BUSINESS_RULE|API03-REQ-004,API03-REQ-007,API03-REQ-009|AUTHORITATIVE|-|-|Admin import nhiều product hợp lệ|Kiểm tra feature multi-product và atomic commit cho batch hợp lệ.|Admin JWT hợp lệ|products có nhiều item hợp lệ|three valid products|Toàn bộ batch hợp lệ được xử lý như một import.|Tất cả item được commit; report phản ánh batch.
003|DOMAIN_PARTITION|SCHEMA|API03-REQ-004|PARTIALLY_SPECIFIED|API03-RG-004|-|Thiếu products|Khảo sát requiredness của products khi spec mô tả field nhưng không nêu error contract.|Admin JWT hợp lệ|bỏ products|empty object|Ghi nhận validation; không bịa status/schema.|Không khẳng định persistence ngoài hậu kiểm.
004|DOMAIN_PARTITION|SCHEMA|API03-REQ-004|PARTIALLY_SPECIFIED|API03-RG-004|-|products bằng null|Kiểm tra null không phải array theo documented shape.|Admin JWT hợp lệ|products=null|null|Body không phù hợp JSON-array contract; cách báo lỗi chưa được quy định.|Hậu kiểm không dựa trên response schema tự đặt.
005|DOMAIN_PARTITION|SCHEMA|API03-REQ-004|PARTIALLY_SPECIFIED|API03-RG-004|-|products là object|Kiểm tra sai type object thay vì array.|Admin JWT hợp lệ|products={}|object value|Body không phù hợp documented array form; status/schema unspecified.|Ghi nhận persistence thực tế.
006|DOMAIN_PARTITION|BOUNDARY|API03-REQ-004,API03-REQ-009|OBSERVABLE_ONLY|API03-RG-002|-|products array rỗng|Khảo sát empty-batch semantics chưa được quy định.|Admin JWT hợp lệ|products=[]|empty array|Ghi nhận accept/reject/report; không tự định nghĩa empty import.|Ghi nhận state trước/sau.
007|DOMAIN_PARTITION|BUSINESS_RULE|API03-REQ-005,API03-REQ-007|AUTHORITATIVE|-|API03-ID-002|Item thiếu name|Kiểm tra name non-empty trực tiếp của FR-16.|Admin JWT hợp lệ|một item có price nhưng không name|missing name|Không chấp nhận row thiếu name hợp lệ.|Nếu cùng batch có item khác, toàn batch rollback.
008|DOMAIN_PARTITION|BUSINESS_RULE|API03-REQ-007|AUTHORITATIVE|-|API03-ID-002|Item name rỗng|Kiểm tra chuỗi rỗng vi phạm non-empty.|Admin JWT hợp lệ|name="", price positive|empty name|Row lỗi vì name không non-empty.|Toàn batch rollback.
009|BOUNDARY|BUSINESS_RULE|API03-REQ-007|AUTHORITATIVE|-|API03-ID-002|Price bằng zero|Kiểm tra đúng biên không dương.|Admin JWT hợp lệ|price=0, name hợp lệ|zero price|Row lỗi vì price phải positive.|Toàn batch rollback.
010|DOMAIN_PARTITION|BUSINESS_RULE|API03-REQ-007|AUTHORITATIVE|-|API03-ID-002|Price âm|Kiểm tra lớp price negative.|Admin JWT hợp lệ|price=-1, name hợp lệ|negative price|Row lỗi vì price không positive.|Toàn batch rollback.
011|BOUNDARY|BUSINESS_RULE|API03-REQ-007|AUTHORITATIVE|-|-|Price dương nhỏ|Kiểm tra phía hợp lệ ngay trên zero mà không tự định nghĩa precision tối đa.|Admin JWT hợp lệ|price positive nhỏ có representation hệ thống hỗ trợ|price=0.01|Price lớn hơn zero thỏa quy tắc positivity; numeric precision vẫn cần quan sát.|Nếu mọi row hợp lệ, toàn batch commit.
012|BOUNDARY|DOMAIN_PARTITION|API03-REQ-008|OBSERVABLE_ONLY|API03-RG-003|-|Name dài đúng 255|Giữ FR-15 chỉ là supporting và quan sát name length tại mốc 255.|Admin JWT hợp lệ|name dài 255, price positive|supporting boundary only|Ghi nhận hành vi; không coi 255 là FR-16 oracle.|Ghi nhận commit/rollback thực tế.
013|BOUNDARY|DOMAIN_PARTITION|API03-REQ-008|OBSERVABLE_ONLY|API03-RG-003|-|Name dài 256|Quan sát phía trên giới hạn FR-15 mà không áp dụng nó trực tiếp cho import.|Admin JWT hợp lệ|name dài 256, price positive|supporting boundary only|Ghi nhận hành vi; không đánh discrepancy nếu khác FR-15 khi chưa có liên kết authoritative.|Ghi nhận state thực tế.
014|BOUNDARY|DOMAIN_PARTITION|API03-REQ-004|OBSERVABLE_ONLY|API03-RG-002|-|Batch kích thước lớn|Khảo sát capacity khi maximum batch size chưa được quy định.|Admin JWT hợp lệ;;Môi trường test cô lập|products array lớn có kiểm soát|size được ghi trong evidence, không gọi là max|Ghi nhận giới hạn/thời gian/phản hồi; không bịa threshold.|Hậu kiểm số item và atomicity theo kết quả.
015|BOUNDARY|DOMAIN_PARTITION|API03-REQ-007|OBSERVABLE_ONLY|API03-RG-005|-|Price có nhiều chữ số thập phân|Khảo sát precision/rounding chưa được quy định trong FR-16.|Admin JWT hợp lệ|price positive với nhiều decimal places|1.234567|Ghi nhận representation và persisted value; chỉ positivity là oracle authoritative.|Nếu batch được chấp nhận, atomic commit vẫn áp dụng.
016|STATE_TRANSITION|BUSINESS_RULE|API03-REQ-009|AUTHORITATIVE|-|API03-ID-003|Batch valid commit toàn bộ|Kiểm tra pre-state sang post-state có toàn bộ rows khi không có lỗi.|Admin JWT hợp lệ;;Snapshot products trước import|nhiều item đều valid|valid batch|Không có row error nên batch đủ điều kiện commit.|Post-state có toàn bộ item mới, không phải một phần.
017|STATE_TRANSITION|BUSINESS_RULE|API03-REQ-007,API03-REQ-009|AUTHORITATIVE|-|API03-ID-003|Row đầu invalid|Kiểm tra rollback khi lỗi nằm ở vị trí đầu.|Admin JWT hợp lệ;;Snapshot trước import|row 1 name empty, rows sau valid|invalid first|Bất kỳ row lỗi làm toàn import thất bại.|Không item nào của batch được persist.
018|STATE_TRANSITION|BUSINESS_RULE|API03-REQ-007,API03-REQ-009|AUTHORITATIVE|-|API03-ID-003|Row giữa invalid|Kiểm tra không có partial persistence trước row lỗi giữa batch.|Admin JWT hợp lệ;;Snapshot trước import|valid, invalid price zero, valid|invalid middle|Lỗi giữa batch làm rollback toàn bộ.|Không giữ các row valid đứng trước hoặc sau.
019|STATE_TRANSITION|BUSINESS_RULE|API03-REQ-007,API03-REQ-009|AUTHORITATIVE|-|API03-ID-003|Row cuối invalid|Kiểm tra rollback cả các insert trước row lỗi cuối.|Admin JWT hợp lệ;;Snapshot trước import|các row đầu valid, row cuối name empty|invalid last|Lỗi cuối vẫn làm toàn batch thất bại.|Không item nào của batch được persist.
020|STATE_TRANSITION|BUSINESS_RULE|API03-REQ-007,API03-REQ-009|AUTHORITATIVE|-|API03-ID-003|Nhiều row invalid|Kiểm tra atomicity và report khi batch có nhiều lỗi.|Admin JWT hợp lệ;;Snapshot trước import|một row empty name, một row negative price|multiple invalid|Batch không được partial commit; report cần counts/reasons.|Products state không đổi bởi batch.
021|STATE_TRANSITION|BUSINESS_RULE|API03-REQ-009|AUTHORITATIVE|-|-|Retry batch đã sửa|Kiểm tra sau rollback có thể gửi một batch mới hợp lệ mà không mang partial state cũ.|Một batch invalid đã rollback|gửi batch mới với tất cả lỗi đã sửa|corrected retry|Batch retry được đánh giá độc lập và nếu hợp lệ có thể commit toàn bộ.|Chỉ dữ liệu từ lần retry hợp lệ xuất hiện.
022|STATE_TRANSITION|SCHEMA|API03-REQ-010|PARTIALLY_SPECIFIED|API03-RG-004|-|Report sau batch lỗi|Kiểm tra report có success/error counts và reasons mà không bịa field names.|Admin JWT hợp lệ;;Batch có lỗi xác định|mixed invalid batch|known row errors|Report thể hiện số thành công/lỗi và lý do ở mức semantic; exact schema unspecified.|Atomic rollback vẫn được hậu kiểm độc lập.
023|SECURITY|SCHEMA|API03-REQ-002,API03-REQ-011|AUTHORITATIVE|-|-|Thiếu Authorization|Kiểm tra import không được thực hiện khi thiếu JWT.|Có snapshot products|không gửi Authorization|valid products body|Không cho truy cập sensitive import endpoint.|Products state không đổi bởi import được phép.
024|SECURITY|SCHEMA|API03-REQ-002,API03-REQ-011|AUTHORITATIVE|-|-|Bearer JWT malformed|Kiểm tra token không hợp lệ không đủ quyền import.|Có snapshot products|Bearer malformed|token=abc|Không cho import với JWT không hợp lệ.|Products state không đổi.
025|SECURITY|SCHEMA|API03-REQ-002,API03-REQ-011|AUTHORITATIVE|-|-|JWT hết hạn|Kiểm tra expired token không thỏa valid JWT.|Có expired fixture|Bearer expired và valid products|expired admin token|Không cho import với token hết hạn.|Products state không đổi.
026|SECURITY|BUSINESS_RULE|API03-REQ-002,API03-REQ-003|AUTHORITATIVE|-|API03-ID-001|JWT user không phải admin|Kiểm tra role enforcement chứ không chỉ token existence.|Valid JWT role user;;Snapshot products|Bearer user token, valid products|role=user|Không cho non-admin import.|Products state không đổi.
027|SECURITY|BUSINESS_RULE|API03-REQ-002,API03-REQ-003|AUTHORITATIVE|-|-|JWT admin hợp lệ|Kiểm tra positive authorization partition.|Valid admin JWT|Bearer admin token, valid products|role=admin|Admin đã xác thực đủ điều kiện authorization; business validation vẫn áp dụng.|State phụ thuộc atomic validation của batch.
028|SECURITY|SCHEMA|API03-REQ-003|SECURITY_EXPECTATION|-|API03-RISK-ROLE-TAMPERING|Payload tự khai role admin|Kiểm tra field role trong body không thay thế role đã xác minh trong token.|JWT role user;;Snapshot products|body thêm role=admin|mass-assignment attempt|Không được nâng quyền từ payload; role phải lấy từ token đã verify.|Products state không đổi.
029|SECURITY|SCHEMA|API03-REQ-007,API03-REQ-011|SECURITY_EXPECTATION|-|API03-RISK-INJECTION|Injection trong product name|Kiểm tra name được xử lý như dữ liệu và vẫn qua non-empty validation.|Admin JWT hợp lệ;;Snapshot dữ liệu liên quan|name chứa SQL metacharacters, price positive|"x'); DROP TABLE products;--"|Input không được thực thi như lệnh hoặc phá dữ liệu ngoài phạm vi; name vẫn là non-empty data.|Nếu batch được chấp nhận, chỉ atomic import side effect được phép.
030|SECURITY|SCHEMA|API03-REQ-005|OBSERVABLE_ONLY|API03-RG-003|API03-RISK-MASS-ASSIGNMENT|Unexpected privileged fields|Quan sát mass-assignment handling khi additional properties chưa được quy định.|Admin JWT hợp lệ|item thêm id và owner_role|unexpected fields|Ghi nhận ignore/reject/persist; không bịa field policy.|Hậu kiểm không có thay đổi trái phép ngoài product import.
031|SCHEMA|DOMAIN_PARTITION|API03-REQ-001,API03-REQ-004,API03-REQ-005|PARTIALLY_SPECIFIED|API03-RG-004|-|JSON products với đủ field documented|Xác nhận endpoint representation là JSON array và item gồm các field tài liệu hóa.|Admin JWT hợp lệ|products item có name, price, description, imageUrl, category_id|documented JSON shape|Request phù hợp endpoint contract; requiredness và response schema còn chưa đầy đủ.|Nếu row hợp lệ, atomic state rule áp dụng.
032|SCHEMA|DOMAIN_PARTITION|API03-REQ-005|OBSERVABLE_ONLY|API03-RG-003|-|Thiếu optionality-unknown fields|Khảo sát description, imageUrl và category_id vì requiredness import chưa được định nghĩa.|Admin JWT hợp lệ|item chỉ có name và price|minimal item|Ghi nhận behavior; không áp FR-15 category rule làm direct oracle.|Theo dõi atomic commit/rollback thực tế.
033|SCHEMA|DOMAIN_PARTITION|API03-REQ-005|OBSERVABLE_ONLY|API03-RG-003|-|Sai type description|Khảo sát type validation của documented field chưa có constraint.|Admin JWT hợp lệ|description là object|type mismatch observation|Ghi nhận xử lý; không bịa error schema.|Hậu kiểm state thực tế.
034|SCHEMA|DOMAIN_PARTITION|API03-REQ-005|OBSERVABLE_ONLY|API03-RG-003|-|category_id không tồn tại|Khảo sát reference semantics chưa được FR-16 quy định.|Admin JWT hợp lệ|category_id là ID không tồn tại|nonexistent category|Ghi nhận accept/reject/reason; không coi một phía là requirement.|Hậu kiểm atomic behavior theo kết quả.
035|SCHEMA|DOMAIN_PARTITION|API03-REQ-006|PARTIALLY_SPECIFIED|API03-RG-001|-|Xác nhận boundary JSON của endpoint|Bao phủ gap CSV-vs-JSON bằng request JSON products chứ không giả định raw CSV.|Admin JWT hợp lệ|gửi JSON products array theo API spec|no raw CSV request|Selected endpoint được kiểm tra theo JSON contract; vị trí CSV parsing vẫn unresolved.|State theo atomic import rules.
036|BUSINESS_RULE|DOMAIN_PARTITION|API03-REQ-007|OBSERVABLE_ONLY|API03-RG-005|API03-ID-002|Name chỉ whitespace|Khảo sát nghĩa non-empty đối với whitespace vì chưa được định nghĩa.|Admin JWT hợp lệ|name gồm spaces, price positive|"   "|Ghi nhận trim/accept/reject; không tự định nghĩa whitespace là empty.|Theo dõi atomic outcome thực tế.
037|BUSINESS_RULE|DOMAIN_PARTITION|API03-REQ-007|OBSERVABLE_ONLY|API03-RG-005|API03-ID-002|Price dạng chuỗi số|Khảo sát numeric representation khi positivity rõ nhưng type coercion chưa nêu.|Admin JWT hợp lệ|price="10"|numeric string|Ghi nhận coercion/reject; không bịa type contract.|Nếu được coi hợp lệ, atomic commit áp dụng.
038|BUSINESS_RULE|STATE_TRANSITION|API03-REQ-009,API03-REQ-010|AUTHORITATIVE|-|API03-ID-003|All-or-nothing đối chiếu report|Đối chiếu report semantic với persistence để phát hiện partial import.|Admin JWT hợp lệ;;Batch mixed validity;;Snapshot trước|một valid và một invalid item|mixed batch|Report phải nêu counts/reasons và batch phải rollback toàn bộ do có lỗi.|Không item mới nào tồn tại dù report có success-row count trung gian.
039|BUSINESS_RULE|SCHEMA|API03-REQ-010|PARTIALLY_SPECIFIED|API03-RG-004|-|Report batch thành công|Kiểm tra report có success/error counts và reasons ở mức semantic.|Admin JWT hợp lệ;;Batch tất cả valid|valid batch|known input count|Report phản ánh số row thành công/lỗi và lý do phù hợp; exact keys/types unspecified.|Toàn batch commit.
040|BUSINESS_RULE|DOMAIN_PARTITION|API03-REQ-004|OBSERVABLE_ONLY|API03-RG-002|-|Duplicate products trong cùng batch|Khảo sát duplicate policy chưa được quy định.|Admin JWT hợp lệ|hai item trùng name và price|duplicate pair|Ghi nhận duplicate được chấp nhận hay báo lỗi; không tự chọn oracle.|Nếu một duplicate bị coi là error, authoritative atomic rollback áp dụng; nếu không, ghi nhận commit thực tế.
'@

$definitions = @(
    [ordered]@{ ApiId='API-01'; Prefix='API01'; Feature='FR-03'; Endpoint='POST /api/reset-password'; Slug='api-01-reset-password'; Title='Password Reset'; Rows=(Parse-Cases $api01) },
    [ordered]@{ ApiId='API-02'; Prefix='API02'; Feature='FR-08'; Endpoint='POST /api/checkout'; Slug='api-02-checkout'; Title='Checkout'; Rows=(Parse-Cases $api02) },
    [ordered]@{ ApiId='API-03'; Prefix='API03'; Feature='FR-16'; Endpoint='POST /api/admin/import-products'; Slug='api-03-import-products'; Title='Import Products'; Rows=(Parse-Cases $api03) }
)

$observationMap = @{
    'API01-AI-036' = @('API01-ID-004')
    'API02-AI-026' = @('API02-ID-004')
    'API03-AI-022' = @('API03-ID-004')
    'API03-AI-029' = @('API03-ID-005')
}

$jsonDir = Join-Path $WorkspaceRoot 'test-cases\generated'
$mdDir = Join-Path $WorkspaceRoot 'docs\test-generation'
New-Item -ItemType Directory -Force -Path $jsonDir, $mdDir | Out-Null

foreach ($d in $definitions) {
    if ($d.Rows.Count -lt 38 -or $d.Rows.Count -gt 42) { throw "$($d.ApiId) count $($d.Rows.Count) is outside 38-42" }
    $cases = @()
    foreach ($row in $d.Rows) {
        if ($techniques -notcontains $row.primary) { throw "Invalid primary technique $($row.primary)" }
        if ($row.secondary -contains $row.primary) { throw "Primary repeated as secondary in $($row.number)" }
        $allTechniques = @($row.primary) + @($row.secondary)
        $authProfile = if ($d.ApiId -eq 'API-01') { 'NO_JWT_REQUIREMENT_SPECIFIED; use issued email-bound OTP state where required' } elseif ($row.title -match 'Thiếu Authorization') { 'Authorization omitted' } elseif ($row.title -match 'non-admin|user không phải admin|Payload tự khai') { 'Bearer test JWT with role=user' } elseif ($row.title -match 'malformed|sai scheme') { 'Invalid authorization fixture described by case' } else { 'Bearer test JWT matching the stated precondition' }
        $caseId = "$($d.Prefix)-AI-$($row.number)"
        $observationIds = [System.Collections.Generic.List[string]]::new()
        if ($observationMap.ContainsKey($caseId)) {
            foreach ($observationId in $observationMap[$caseId]) { $observationIds.Add($observationId) }
        }
        $case = [ordered]@{
            id = $caseId
            api_id = $d.ApiId
            feature_id = $d.Feature
            endpoint = $d.Endpoint
            source = 'AI_GENERATED'
            lifecycle_state = 'DRAFT'
            requirement_ids = @($row.refs)
            technique = $allTechniques
            primary_technique = $row.primary
            secondary_techniques = @($row.secondary)
            oracle_basis = $row.oracle
            gap_ids = @($row.gaps)
            risk_ids = @($row.risks)
            observation_ids = $observationIds
            title = $row.title
            objective = $row.objective
            preconditions = @($row.preconditions)
            request = [ordered]@{ method='POST'; path=$d.Endpoint.Substring(5); auth_profile=$authProfile; content_type='application/json unless the case explicitly varies it'; body_variation=$row.body }
            test_data = [ordered]@{ description=$row.data; secret_policy='Use disposable fixtures or environment variables; do not store real secrets.' }
            expected_status = 'UNSPECIFIED_BY_AUTHORITATIVE_SOURCE'
            expected_schema = 'UNSPECIFIED_BY_AUTHORITATIVE_SOURCE'
            expected_business_result = $row.business
            expected_state = $row.state
            audit_status = 'NOT_AUDITED'
            audit_reason = $null
            correction = $null
            why_ai_missed = $null
            execution_status = 'NOT_IMPLEMENTED'
            failure_classification = $null
            bug_id = $null
            notes = 'RAW_AI_GENERATION; AI_TEST_AUDIT_NOT_STARTED; NOT_EXECUTED'
        }
        $cases += $case
    }

    $fingerprints = @{}
    foreach ($case in $cases) {
        $fp = (($case.primary_technique + '|' + $case.objective + '|' + $case.request.body_variation + '|' + $case.test_data.description + '|' + $case.expected_business_result).ToLowerInvariant() -replace '\s+', ' ').Trim()
        if ($fingerprints.ContainsKey($fp)) { throw "Semantic duplicate: $($fingerprints[$fp]) and $($case.id)" }
        $fingerprints[$fp] = $case.id
    }

    $trace = [ordered]@{}
    foreach ($case in $cases) {
        foreach ($key in @($case.requirement_ids) + @($case.gap_ids) + @($case.risk_ids) + @($case.observation_ids)) {
            if (-not $trace.Contains($key)) { $trace[$key] = @() }
            $trace[$key] += $case.id
        }
    }
    $techniqueCounts = [ordered]@{}
    foreach ($t in $techniques) { $techniqueCounts[$t] = @($cases | Where-Object primary_technique -eq $t).Count }
    $oracleCounts = [ordered]@{}
    foreach ($o in @('AUTHORITATIVE','PARTIALLY_SPECIFIED','OBSERVABLE_ONLY','SECURITY_EXPECTATION')) { $oracleCounts[$o] = @($cases | Where-Object oracle_basis -eq $o).Count }

    $document = [ordered]@{
        metadata = [ordered]@{
            api_id=$d.ApiId; feature_id=$d.Feature; endpoint=$d.Endpoint; generation_status='TEST_GENERATION_REVIEW_REQUIRED'
            source='AI_GENERATED'; lifecycle_state='DRAFT'; audit_status='NOT_AUDITED'; execution_status='NOT_IMPLEMENTED'
            authoritative_analysis="docs/requirement-analysis/$($d.Slug).md"; generated_count=$cases.Count
            semantic_duplicates_removed=0; expected_status_policy='UNSPECIFIED_BY_AUTHORITATIVE_SOURCE'; expected_schema_policy='UNSPECIFIED_BY_AUTHORITATIVE_SOURCE'
            raw_csv_request_cases=0; generated_at='2026-08-20'
        }
        technique_counts = $techniqueCounts
        oracle_counts = $oracleCounts
        test_cases = $cases
        traceability = $trace
    }
    $jsonPath = Join-Path $jsonDir "$($d.Slug).json"
    $document | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $jsonPath -Encoding utf8

    $md = [System.Collections.Generic.List[string]]::new()
    $md.Add("# $($d.ApiId) AI-generated Test Cases — $($d.Title)")
    $md.Add('')
    $md.Add("- Status: ``TEST_GENERATION_REVIEW_REQUIRED``")
    $md.Add("- Source: ``AI_GENERATED``; lifecycle: ``DRAFT``; audit: ``NOT_AUDITED``; execution: ``NOT_IMPLEMENTED``")
    $md.Add("- Approved input: ``docs/requirement-analysis/$($d.Slug).md``")
    $md.Add("- Count: **$($cases.Count)**; semantic duplicates removed: **0**")
    $md.Add('- No HTTP status or response schema was inferred: every case uses `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`.')
    if ($d.ApiId -eq 'API-02') { $md.Add('- FR-07 and FR-09 remain supporting context; order-line persistence is observation only.') }
    if ($d.ApiId -eq 'API-03') { $md.Add('- FR-15 remains supporting context; selected endpoint cases use JSON `products[]`; raw CSV cases: **0**.') }
    $md.Add('')
    $md.Add('## Primary-technique coverage')
    $md.Add('')
    $md.Add('| Technique | Count |')
    $md.Add('| --- | ---: |')
    foreach ($t in $techniques) { $md.Add("| ``$t`` | $($techniqueCounts[$t]) |") }
    $md.Add('')
    $md.Add('## Oracle basis')
    $md.Add('')
    $md.Add('| Basis | Count |')
    $md.Add('| --- | ---: |')
    foreach ($o in $oracleCounts.Keys) { $md.Add("| ``$o`` | $($oracleCounts[$o]) |") }
    $md.Add('')
    $md.Add('## Test cases')
    foreach ($case in $cases) {
        $md.Add('')
        $md.Add("### $($case.id) — $($case.title)")
        $md.Add('')
        $md.Add("- Primary technique: ``$($case.primary_technique)``")
        $secondaryText = if ($case.secondary_techniques.Count) { $case.secondary_techniques -join ', ' } else { 'NONE' }
        $md.Add("- Secondary techniques: ``$secondaryText``")
        $md.Add("- Requirement IDs: ``$($case.requirement_ids -join ', ')``")
        $gapText = if ($case.gap_ids.Count) { $case.gap_ids -join ', ' } else { 'NONE' }
        $riskText = if ($case.risk_ids.Count) { $case.risk_ids -join ', ' } else { 'NONE' }
        $observationText = if ($case.observation_ids.Count) { $case.observation_ids -join ', ' } else { 'NONE' }
        $md.Add("- Gap IDs: ``$gapText``; risk/potential-discrepancy IDs: ``$riskText``; implementation-observation IDs: ``$observationText``")
        $md.Add("- Oracle basis: ``$($case.oracle_basis)``")
        $md.Add("- Objective: $($case.objective)")
        $md.Add("- Preconditions: $($case.preconditions -join '; ')")
        $md.Add("- Request variation: $($case.request.body_variation)")
        $md.Add("- Test data: $($case.test_data.description)")
        $md.Add("- Expected status: ``$($case.expected_status)``")
        $md.Add("- Expected schema: ``$($case.expected_schema)``")
        $md.Add("- Expected business result: $($case.expected_business_result)")
        $md.Add("- Expected state: $($case.expected_state)")
        $md.Add("- Workflow fields: source=``$($case.source)``; audit=``$($case.audit_status)``; execution=``$($case.execution_status)``")
    }
    $md.Add('')
    $md.Add('## Traceability matrix')
    $md.Add('')
    $md.Add('| Requirement / gap / risk / implementation observation | Generated case IDs |')
    $md.Add('| --- | --- |')
    foreach ($key in ($trace.Keys | Sort-Object)) { $md.Add("| ``$key`` | ``$($trace[$key] -join ', ')`` |") }
    $md.Add('')
    $md.Add('## Phase boundary')
    $md.Add('')
    $md.Add('Raw AI generation only. No case has been audited, student-extended, implemented, executed, or classified as a product defect.')
    $mdPath = Join-Path $mdDir "$($d.Slug)-ai-generated.md"
    $md | Set-Content -LiteralPath $mdPath -Encoding utf8
}

'GENERATION_COMPLETE'
$definitions | ForEach-Object { "$($_.ApiId)=$($_.Rows.Count)" }
