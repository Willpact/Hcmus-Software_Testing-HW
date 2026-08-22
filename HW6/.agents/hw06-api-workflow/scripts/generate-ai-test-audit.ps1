param(
    [string]$WorkspaceRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
)

$ErrorActionPreference = 'Stop'

$invalid = @{
    'API01-AI-020' = [ordered]@{
        reason = 'Mục tiêu chính là hành vi đăng nhập ở endpoint khác sau reset; API reset-password không có authoritative downstream session/login oracle.'
        issues = @('CROSS_FEATURE_OVERREACH','TRACEABILITY_ISSUE')
        correction = 'Chuyển concept sang suite authentication/login riêng sau khi có authoritative post-reset authentication contract; không giữ như case trực tiếp của POST /api/reset-password.'
        action = 'MOVE_TO_SEPARATE_SUITE'
        duplicate = $null
    }
    'API01-AI-036' = [ordered]@{
        reason = 'Case lặp cùng state, action và oracle one-time OTP với API01-AI-015: đều replay đúng OTP sau một reset thành công và kỳ vọng không có lần đổi mật khẩu thứ hai.'
        issues = @('SEMANTIC_DUPLICATION')
        correction = 'Giữ API01-AI-015 làm case canonical cho OTP replay; bỏ API01-AI-036 khỏi final suite nhưng bảo toàn raw record.'
        action = 'REMOVE_FROM_FINAL_SUITE'
        duplicate = 'API01-AI-015'
    }
    'API02-AI-028' = [ordered]@{
        reason = 'Case gửi hai request trùng tuần tự gần nhau không tạo equivalence class khác rõ ràng so với replay sau success ở API02-AI-015; concurrency thực sự đã được tách ở API02-AI-020.'
        issues = @('SEMANTIC_DUPLICATION')
        correction = 'Giữ API02-AI-015 cho sequential replay và API02-AI-020 cho concurrent requests; bỏ API02-AI-028 khỏi final suite.'
        action = 'REMOVE_FROM_FINAL_SUITE'
        duplicate = 'API02-AI-015'
    }
}

$incomplete = @{
    'API01-AI-004' = 'Human phải quyết định user-enumeration oracle hoặc chỉ giữ invariant không đổi tài khoản; xác định tín hiệu response nào được so sánh mà không bịa schema/status.'
    'API01-AI-005' = 'Làm rõ email có bắt buộc ở API contract hay sửa case thành security invariant rõ ràng rằng không tài khoản nào được đổi khi thiếu identity.'
    'API01-AI-006' = 'Đổi expected result thành invariant requirement-backed: không được đổi mật khẩu khi không có issued email-bound OTP; giữ transport response unspecified.'
    'API01-AI-007' = 'Xác nhận requiredness của newPassword hoặc nêu rõ invariant không hoàn tất password reset khi không có mật khẩu mới.'
    'API01-AI-013' = 'Dùng expired-token fixture được xác định bởi cấu hình/clock của môi trường test và ghi rõ hai mốc quan sát; không tự đặt expiry duration.'
    'API01-AI-017' = 'Cần Human Decision về token supersession; nếu chưa có thì defer khỏi executable final suite thay vì chọn token A hay B làm oracle.'
    'API01-AI-025' = 'Xác định policy/threshold rate-limit authoritative hoặc chuyển thành non-blocking security observation với metric cụ thể và không có pass/fail product verdict.'
    'API01-AI-026' = 'Xác định risk acceptance cho user enumeration và các tín hiệu cần so sánh; không yêu cầu response giống nhau nếu chưa có security acceptance criterion.'
    'API01-AI-030' = 'Chỉ thực thi sau khi Human xác nhận tên/vị trí confirmation field; hiện tại giữ như contract-gap candidate.'
    'API01-AI-031' = 'Xác nhận API representation của confirmation trước khi dùng mismatch làm executable request; business rule FR-03 vẫn được giữ.'
    'API01-AI-032' = 'Bổ sung authoritative additional-properties policy hoặc chuyển thành robustness observation không blocking.'
    'API01-AI-033' = 'Bổ sung observable invariant không đổi password/token và cách thu transport evidence; không tự đặt error status/schema.'
    'API01-AI-034' = 'Giải quyết gap confirmation giữa FR-03 và API specification; defer nếu không có representation được Human approve.'
    'API01-AI-037' = 'Cần danh sách allowed special characters authoritative; không suy diễn space hợp lệ hay không hợp lệ.'
    'API01-AI-038' = 'Cần email-normalization/case-sensitivity rule hoặc biến case thành non-blocking observation.'
    'API01-AI-039' = 'Không dùng confirmPassword convention cho tới khi Human/source xác nhận; nếu không có contract thì remove/defer candidate.'
    'API01-AI-040' = 'Chỉ giữ khi issuer test có thể phát hành token hơn sáu chữ số theo contract; bổ sung deterministic state setup hoặc defer.'

    'API02-AI-006' = 'Xác nhận type/coercion contract cho total_amount; nếu request được chấp nhận thì assert persisted authoritative total bằng cart-derived total.'
    'API02-AI-007' = 'Làm rõ requiredness của total_amount; nếu field được phép thiếu thì định nghĩa validation point chứng minh backend vẫn đọc cart.'
    'API02-AI-008' = 'Cần authoritative shipping_address requiredness trước khi tạo pass/fail oracle; nếu chưa có thì giữ observation non-blocking.'
    'API02-AI-011' = 'Human phải xác định empty-cart behavior và state oracle; không tự đặt status, order creation hay error schema.'
    'API02-AI-012' = 'Xác định empty-address rule hoặc defer; không tự coi chuỗi rỗng là valid/invalid.'
    'API02-AI-013' = 'Xác định address length limit từ authoritative source hoặc dùng robustness observation không blocking.'
    'API02-AI-015' = 'Cần idempotency/replay policy và deterministic order-state observation trước khi case có final pass/fail result.'
    'API02-AI-019' = 'Xác định failure condition và expected cart effect; chỉ clear-on-success hiện là authoritative.'
    'API02-AI-020' = 'Bổ sung concurrency harness, synchronization point và Human-approved duplicate-order/idempotency oracle.'
    'API02-AI-030' = 'Xác định body requiredness/top-level type policy hoặc thêm invariant no-success-side-effect cho null body.'
    'API02-AI-031' = 'Xác định object-only validation oracle hoặc thêm invariant no checkout success side effect cho array body.'
    'API02-AI-032' = 'Bổ sung observable parser outcome và cart-state invariant; không tự đặt malformed-JSON status/schema.'
    'API02-AI-033' = 'Làm rõ supported Content-Type hoặc giữ non-blocking observation với cart-state evidence.'
    'API02-AI-038' = 'Chỉ giữ trong final checkout suite nếu authoritative source xác nhận coupon integration; nếu không, chuyển sang future cross-feature suite.'
    'API02-AI-039' = 'Cần authoritative initial order-status contract trước khi có pass/fail oracle; implementation value chỉ được ghi observation.'
    'API02-AI-040' = 'Cần authoritative order-line persistence contract; nếu không có thì bỏ khỏi executable final suite và chỉ giữ research note.'

    'API03-AI-003' = 'Xác định products requiredness và no-import state invariant khi field vắng; không tự đặt transport response.'
    'API03-AI-004' = 'Bổ sung explicit no-commit state assertion cho non-array null và giữ status/schema unspecified.'
    'API03-AI-005' = 'Bổ sung explicit no-commit state assertion cho object thay vì array và cách xác minh products state.'
    'API03-AI-006' = 'Human phải quyết định empty-batch semantics và report expectation trước khi final hóa.'
    'API03-AI-012' = 'Chỉ áp dụng boundary 255 nếu Human/source liên kết FR-15 với FR-16; nếu không thì defer khỏi final import suite.'
    'API03-AI-013' = 'Không dùng >255 làm rejection oracle cho tới khi FR-15 applicability được xác nhận.'
    'API03-AI-014' = 'Cần authoritative capacity limit và reproducible large-batch fixture; không gọi một kích thước tự chọn là maximum.'
    'API03-AI-015' = 'Xác định price precision/rounding contract hoặc chuyển thành observation với persisted-value evidence.'
    'API03-AI-030' = 'Xác định allowed/additional item fields và protected-field invariant trước khi dùng mass-assignment pass/fail oracle.'
    'API03-AI-032' = 'Xác định optionality của description, imageUrl, category_id cho import; FR-15 không tự tạo direct oracle.'
    'API03-AI-033' = 'Xác định type constraint cho description hoặc giữ parser robustness observation.'
    'API03-AI-034' = 'Cần FR-16 category-reference rule; không suy diễn nonexistent category phải accept/reject.'
    'API03-AI-036' = 'Xác định trim/whitespace semantics cho non-empty name trước khi có final oracle.'
    'API03-AI-037' = 'Xác định numeric type/coercion rule cho price; positivity một mình chưa quyết định string numeric.'
    'API03-AI-040' = 'Cần duplicate-product policy; nếu duplicate bị định nghĩa là error thì atomic rollback mới trở thành nhánh authoritative.'
}

$requirementGapIds = @(
    'API01-AI-004','API01-AI-005','API01-AI-013','API01-AI-017','API01-AI-025','API01-AI-030','API01-AI-031','API01-AI-032','API01-AI-034','API01-AI-037','API01-AI-038','API01-AI-039',
    'API02-AI-006','API02-AI-007','API02-AI-008','API02-AI-011','API02-AI-012','API02-AI-013','API02-AI-015','API02-AI-019','API02-AI-020','API02-AI-030','API02-AI-031','API02-AI-032','API02-AI-033','API02-AI-038','API02-AI-039','API02-AI-040',
    'API03-AI-003','API03-AI-004','API03-AI-005','API03-AI-006','API03-AI-012','API03-AI-013','API03-AI-014','API03-AI-015','API03-AI-030','API03-AI-032','API03-AI-033','API03-AI-034','API03-AI-036','API03-AI-037','API03-AI-040'
)
$missingStateIds = @('API01-AI-013','API01-AI-040','API02-AI-019','API02-AI-020','API03-AI-014')
$securityGapIds = @('API01-AI-004','API01-AI-025','API01-AI-026','API02-AI-015','API02-AI-020','API03-AI-030')
$crossFeatureIds = @('API02-AI-038','API03-AI-012','API03-AI-013','API03-AI-032','API03-AI-034')

$futureGaps = @(
    [ordered]@{id='FUTURE_EXTENSION_GAP-01'; api='API-01'; summary='Authoritative API representation for password confirmation and mismatch.'},
    [ordered]@{id='FUTURE_EXTENSION_GAP-02'; api='API-01'; summary='Deterministic OTP expiry fixture without inventing an expiry duration.'},
    [ordered]@{id='FUTURE_EXTENSION_GAP-03'; api='API-01'; summary='Human-approved brute-force/rate-limit and user-enumeration acceptance criteria.'},
    [ordered]@{id='FUTURE_EXTENSION_GAP-04'; api='API-02'; summary='Shipping-address requiredness, format, and length contract.'},
    [ordered]@{id='FUTURE_EXTENSION_GAP-05'; api='API-02'; summary='Empty-cart and failure-side-effect contract.'},
    [ordered]@{id='FUTURE_EXTENSION_GAP-06'; api='API-02'; summary='Replay/idempotency/concurrency behavior and observable order cardinality.'},
    [ordered]@{id='FUTURE_EXTENSION_GAP-07'; api='API-02'; summary='Documented coupon-to-checkout integration boundary.'},
    [ordered]@{id='FUTURE_EXTENSION_GAP-08'; api='API-03'; summary='CSV parsing layer to JSON endpoint boundary.'},
    [ordered]@{id='FUTURE_EXTENSION_GAP-09'; api='API-03'; summary='Maximum batch, duplicate-product, and price-precision policy.'},
    [ordered]@{id='FUTURE_EXTENSION_GAP-10'; api='API-03'; summary='Import-specific category and optional-field validation contract.'}
)

$definitions = @(
    [ordered]@{api='API-01'; title='Reset Password'; slug='api-01-reset-password'; raw='test-cases/generated/api-01-reset-password.json'},
    [ordered]@{api='API-02'; title='Checkout'; slug='api-02-checkout'; raw='test-cases/generated/api-02-checkout.json'},
    [ordered]@{api='API-03'; title='Import Products'; slug='api-03-import-products'; raw='test-cases/generated/api-03-import-products.json'}
)

$mdDir = Join-Path $WorkspaceRoot 'docs\test-audit'
$jsonDir = Join-Path $WorkspaceRoot 'test-cases\audited'
New-Item -ItemType Directory -Force -Path $mdDir,$jsonDir | Out-Null
$allRecords = @()
$apiSummaries = @()

foreach ($definition in $definitions) {
    $rawPath = Join-Path $WorkspaceRoot $definition.raw
    $raw = Get-Content -LiteralPath $rawPath -Raw | ConvertFrom-Json
    $cases = @($raw.test_cases)
    if ($cases.Count -ne 40) { throw "$($definition.api) raw count is not 40" }
    $records = @()
    foreach ($case in $cases) {
        $id = $case.id
        if ($invalid.ContainsKey($id) -and $incomplete.ContainsKey($id)) { throw "Conflicting audit map for $id" }
        $issues = [System.Collections.Generic.List[string]]::new()
        if ($invalid.ContainsKey($id)) {
            $decision = $invalid[$id]
            $classification = 'INVALID'
            foreach ($issue in $decision.issues) { $issues.Add($issue) }
            $reason = $decision.reason
            $correction = $decision.correction
            $action = $decision.action
            $duplicateOf = $decision.duplicate
            $oracleAssessment = 'INSUFFICIENT_OR_NOT_APPLICABLE_FOR_SELECTED_FINAL_SUITE'
        } elseif ($incomplete.ContainsKey($id)) {
            $classification = 'INCOMPLETE'
            $issues.Add('AMBIGUOUS_EXPECTED_RESULT')
            if ($requirementGapIds -contains $id) { $issues.Add('REQUIREMENT_GAP_ASSUMPTION') }
            if ($missingStateIds -contains $id) { $issues.Add('MISSING_STATE_SETUP') }
            if ($securityGapIds -contains $id) { $issues.Add('SECURITY_REASONING_GAP') }
            if ($crossFeatureIds -contains $id) { $issues.Add('CROSS_FEATURE_OVERREACH') }
            $reason = "Concept/risk '$($case.title)' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test."
            $correction = $incomplete[$id]
            $action = 'REVISE_BEFORE_FINAL_SUITE'
            $duplicateOf = $null
            $oracleAssessment = 'INSUFFICIENT_FOR_FINAL_PASS_FAIL'
        } else {
            $classification = 'VALID'
            $correction = $null
            $action = 'KEEP_AS_GENERATED'
            $duplicateOf = $null
            if ($case.oracle_basis -eq 'SECURITY_EXPECTATION') {
                $reason = 'Applicable security invariant provides a meaningful pass/fail target even though exact HTTP status and response schema remain unspecified.'
            } elseif ($case.oracle_basis -eq 'PARTIALLY_SPECIFIED') {
                $reason = 'Transport details are unspecified, but the raw case retains a requirement-backed business/state oracle sufficient for execution.'
            } else {
                $reason = 'Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.'
            }
            $oracleAssessment = 'SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL'
        }

        $traceAssessment = if ($id -eq 'API01-AI-020') { 'MISALIGNED_CROSS_ENDPOINT' } elseif ($crossFeatureIds -contains $id) { 'SUPPORTING_ONLY_REQUIRES_HUMAN_LINKAGE' } else { 'ALIGNED_WITH_APPROVED_ANALYSIS' }
        $record = [ordered]@{
            test_case_id = $id
            raw_source = "$($definition.raw)#$id"
            classification = $classification
            classification_reason = $reason
            requirement_traceability = [ordered]@{
                requirement_ids = @($case.requirement_ids)
                gap_ids = @($case.gap_ids)
                risk_ids = @($case.risk_ids)
                observation_ids = @($case.observation_ids)
                assessment = $traceAssessment
            }
            oracle_review = [ordered]@{
                raw_oracle_basis = $case.oracle_basis
                expected_status = $case.expected_status
                expected_schema = $case.expected_schema
                assessment = $oracleAssessment
                notes = if ($classification -eq 'VALID') { 'No unsupported status/schema was added; semantic oracle is sufficient.' } else { 'Do not invent status/schema while resolving the listed issue.' }
            }
            duplicate_of = $duplicateOf
            issues = @($issues)
            proposed_correction = $correction
            proposed_action = $action
            human_review_status = 'PENDING_HUMAN_REVIEW'
        }
        $records += $record
        $allRecords += $record
    }

    if ($records.Count -ne 40 -or @($records | Where-Object { $_.classification -notin @('VALID','INVALID','INCOMPLETE') }).Count) { throw "$($definition.api) classification coverage failed" }
    if (@($records | Where-Object { $_.classification -ne 'VALID' -and [string]::IsNullOrWhiteSpace($_.proposed_correction) }).Count) { throw "$($definition.api) missing proposed correction" }

    $summary = [ordered]@{
        total = 40
        valid = @($records | Where-Object classification -eq 'VALID').Count
        invalid = @($records | Where-Object classification -eq 'INVALID').Count
        incomplete = @($records | Where-Object classification -eq 'INCOMPLETE').Count
        proposed_corrections = @($records | Where-Object classification -ne 'VALID').Count
        proposed_removals = @($records | Where-Object classification -eq 'INVALID').Count
        semantic_duplicates = @($records | Where-Object { $_.issues -contains 'SEMANTIC_DUPLICATION' }).Count
        authoritative_oracle_issues = @($records | Where-Object { $_.issues -contains 'AMBIGUOUS_EXPECTED_RESULT' }).Count
        traceability_issues = @($records | Where-Object { $_.issues -contains 'TRACEABILITY_ISSUE' }).Count
        state_setup_issues = @($records | Where-Object { $_.issues -contains 'MISSING_STATE_SETUP' }).Count
        security_reasoning_issues = @($records | Where-Object { $_.issues -contains 'SECURITY_REASONING_GAP' }).Count
        cross_feature_overreach = @($records | Where-Object { $_.issues -contains 'CROSS_FEATURE_OVERREACH' }).Count
        implementation_as_oracle = @($records | Where-Object { $_.issues -contains 'IMPLEMENTATION_AS_ORACLE' }).Count
    }
    $apiSummaries += [ordered]@{api=$definition.api; summary=$summary}
    $localPatterns = [ordered]@{}
    foreach ($issue in ($records.issues | ForEach-Object { $_ } | Sort-Object -Unique)) { $localPatterns[$issue] = @($records | Where-Object { $_.issues -contains $issue }).Count }
    $document = [ordered]@{
        metadata = [ordered]@{
            api_id=$definition.api; raw_source=$definition.raw; audit_status='AI_TEST_AUDIT_REVIEW_REQUIRED'; human_review_status='PENDING_HUMAN_REVIEW'
            raw_semantics_modified=$false; final_correction_started=$false; student_extension_started=$false; execution_started=$false
        }
        summary = $summary
        issue_counts = $localPatterns
        audit_records = $records
        future_extension_gaps = @($futureGaps | Where-Object api -eq $definition.api)
    }
    $jsonPath = Join-Path $jsonDir "$($definition.slug).json"
    $document | ConvertTo-Json -Depth 12 | Set-Content -LiteralPath $jsonPath -Encoding utf8

    $md = [System.Collections.Generic.List[string]]::new()
    $md.Add("# $($definition.api) AI Test Audit — $($definition.title)")
    $md.Add('')
    $md.Add('- Status: `AI_TEST_AUDIT_REVIEW_REQUIRED`')
    $md.Add('- Human review: `PENDING_HUMAN_REVIEW`')
    $md.Add("- Raw source: ``$($definition.raw)`` (read-only; semantic content unchanged)")
    $md.Add('- This is an AI-assisted audit proposal, not final Human Review and not execution evidence.')
    $md.Add('')
    $md.Add('## Audit summary')
    $md.Add('')
    $md.Add('| Metric | Count |')
    $md.Add('| --- | ---: |')
    foreach ($property in $summary.GetEnumerator()) { $md.Add("| ``$($property.Key.ToUpperInvariant())`` | $($property.Value) |") }
    $md.Add('')
    $md.Add('## Per-case audit')
    foreach ($record in $records) {
        $md.Add('')
        $md.Add("### $($record.test_case_id) — $($record.classification)")
        $md.Add('')
        $md.Add("- Raw source: ``$($record.raw_source)``")
        $md.Add("- Classification reason: $($record.classification_reason)")
        $md.Add("- Requirement traceability: ``$($record.requirement_traceability.assessment)``; refs=``$((@($record.requirement_traceability.requirement_ids)+@($record.requirement_traceability.gap_ids)+@($record.requirement_traceability.risk_ids)+@($record.requirement_traceability.observation_ids)) -join ', ')``")
        $md.Add("- Oracle review: ``$($record.oracle_review.assessment)``; raw basis=``$($record.oracle_review.raw_oracle_basis)``; status/schema remain ``UNSPECIFIED_BY_AUTHORITATIVE_SOURCE``")
        $duplicateText = if ($record.duplicate_of) { $record.duplicate_of } else { 'NONE' }
        $issueText = if ($record.issues.Count) { $record.issues -join ', ' } else { 'NONE' }
        $correctionText = if ($record.proposed_correction) { $record.proposed_correction } else { 'NONE' }
        $md.Add("- Duplicate of: ``$duplicateText``")
        $md.Add("- Issues: ``$issueText``")
        $md.Add("- Proposed correction: $correctionText")
        $md.Add("- Proposed action: ``$($record.proposed_action)``")
        $md.Add("- Human review status: ``$($record.human_review_status)``")
    }
    $md.Add('')
    $md.Add('## Candidate gaps for future Student Extension')
    $md.Add('')
    $md.Add('These are `FUTURE_EXTENSION_GAP` notes only; no `STUDENT_ADDED` case was created.')
    foreach ($gap in @($futureGaps | Where-Object api -eq $definition.api)) { $md.Add("- ``$($gap.id)`` — $($gap.summary)") }
    $md.Add('')
    $md.Add('## Phase boundary')
    $md.Add('')
    $md.Add('No raw case was corrected or removed. No final suite, Student Extension, Excel, Postman, Newman, SUT execution, bug report, or CI/CD work was started.')
    $mdPath = Join-Path $mdDir "$($definition.slug)-audit.md"
    $md | Set-Content -LiteralPath $mdPath -Encoding utf8
}

if ($allRecords.Count -ne 120) { throw "Expected 120 audit records, got $($allRecords.Count)" }
$patternRows = @()
foreach ($issue in ($allRecords.issues | ForEach-Object { $_ } | Sort-Object -Unique)) {
    $affected = @($allRecords | Where-Object { $_.issues -contains $issue })
    $patternRows += [ordered]@{
        pattern=$issue; count=$affected.Count
        affected_apis=@($affected.test_case_id | ForEach-Object { $_.Substring(0,5) -replace '^API(\d{2})$', 'API-$1' } | Sort-Object -Unique)
        representative_test_case_ids=@($affected.test_case_id | Select-Object -First 5)
        why_it_happened = switch ($issue) {
            'AMBIGUOUS_EXPECTED_RESULT' { 'AI preserved an observational/gap-oriented case but did not supply a requirement-backed final pass/fail validation point.' }
            'REQUIREMENT_GAP_ASSUMPTION' { 'A useful input/risk dimension exists while the approved sources intentionally leave behavior or representation unspecified.' }
            'MISSING_STATE_SETUP' { 'The case depends on expiry, concurrency, failure, or capacity state without a deterministic fixture/setup contract.' }
            'SECURITY_REASONING_GAP' { 'The security risk is relevant, but threshold, comparison signal, or acceptance criterion is not authoritative.' }
            'CROSS_FEATURE_OVERREACH' { 'Supporting or downstream feature context was turned into a candidate before endpoint integration/applicability was confirmed.' }
            'SEMANTIC_DUPLICATION' { 'Different wording/technique labels concealed the same effective precondition, action, and oracle.' }
            'TRACEABILITY_ISSUE' { 'The objective belongs to a different endpoint or downstream feature than the requirement trace attached to the raw case.' }
            default { 'Audit review identified this recurring issue.' }
        }
    }
}
$patternRows = @($patternRows | Sort-Object @{Expression={ $_['count'] };Descending=$true}, @{Expression={ $_['pattern'] };Descending=$false})
$totalSummary = [ordered]@{
    audited=120
    valid=@($allRecords | Where-Object classification -eq 'VALID').Count
    invalid=@($allRecords | Where-Object classification -eq 'INVALID').Count
    incomplete=@($allRecords | Where-Object classification -eq 'INCOMPLETE').Count
    proposed_corrections=@($allRecords | Where-Object classification -ne 'VALID').Count
    proposed_removals=@($allRecords | Where-Object classification -eq 'INVALID').Count
    semantic_duplicates=@($allRecords | Where-Object { $_.issues -contains 'SEMANTIC_DUPLICATION' }).Count
}
$crossJson = [ordered]@{
    metadata=[ordered]@{status='AI_TEST_AUDIT_REVIEW_REQUIRED'; human_review_status='PENDING_HUMAN_REVIEW'; student_added_cases=0}
    total_summary=$totalSummary
    api_summaries=$apiSummaries
    failure_patterns=$patternRows
    future_extension_gaps=$futureGaps
}
$crossJson | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath (Join-Path $jsonDir 'cross-api-summary.json') -Encoding utf8

$crossMd = [System.Collections.Generic.List[string]]::new()
$crossMd.Add('# Cross-API AI Failure Pattern Analysis')
$crossMd.Add('')
$crossMd.Add('- Status: `AI_TEST_AUDIT_REVIEW_REQUIRED`')
$crossMd.Add('- Scope: 120 raw AI-generated cases; no raw semantic changes.')
$crossMd.Add('')
$crossMd.Add('## Totals')
$crossMd.Add('')
foreach ($item in $totalSummary.GetEnumerator()) { $crossMd.Add("- ``$($item.Key.ToUpperInvariant())``: $($item.Value)") }
$crossMd.Add('')
$crossMd.Add('## Failure patterns')
$crossMd.Add('')
$crossMd.Add('| Pattern | Count | Affected APIs | Representative IDs | Why it happened |')
$crossMd.Add('| --- | ---: | --- | --- | --- |')
foreach ($row in $patternRows) { $crossMd.Add("| ``$($row.pattern)`` | $($row.count) | ``$($row.affected_apis -join ', ')`` | ``$($row.representative_test_case_ids -join ', ')`` | $($row.why_it_happened) |") }
$crossMd.Add('')
$crossMd.Add('## Candidate gaps for future Student Extension')
$crossMd.Add('')
foreach ($gap in $futureGaps) { $crossMd.Add("- ``$($gap.id)`` / ``$($gap.api)`` — $($gap.summary)") }
$crossMd.Add('')
$crossMd.Add('No item above is a `STUDENT_ADDED` test. Human review is required before correction or extension.')
$crossMd | Set-Content -LiteralPath (Join-Path $mdDir 'cross-api-failure-patterns.md') -Encoding utf8

'AUDIT_GENERATION_COMPLETE'
foreach ($entry in $apiSummaries) { "$($entry.api):VALID=$($entry.summary.valid),INVALID=$($entry.summary.invalid),INCOMPLETE=$($entry.summary.incomplete)" }
"TOTAL:VALID=$($totalSummary.valid),INVALID=$($totalSummary.invalid),INCOMPLETE=$($totalSummary.incomplete)"
