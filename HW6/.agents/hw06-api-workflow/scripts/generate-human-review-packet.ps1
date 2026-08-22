param(
    [string]$WorkspaceRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
)

$ErrorActionPreference = 'Stop'

$selectedIncomplete = [ordered]@{
    'API-01' = @('API01-AI-030','API01-AI-013','API01-AI-025','API01-AI-026','API01-AI-040')
    'API-02' = @('API02-AI-008','API02-AI-011','API02-AI-015','API02-AI-019','API02-AI-038','API02-AI-039')
    'API-03' = @('API03-AI-014','API03-AI-040','API03-AI-034','API03-AI-015','API03-AI-032')
}
$selectedValid = [ordered]@{
    'API-01' = @('API01-AI-014','API01-AI-035')
    'API-02' = @('API02-AI-014','API02-AI-026')
    'API-03' = @('API03-AI-035','API03-AI-026')
}
$duplicateDifference = @{
    'API01-AI-036' = 'Raw wording/primary technique differs: API01-AI-015 frames replay after success, while API01-AI-036 frames one-time invalidation. Both use the same post-success state, reuse the same OTP, and expect no second password change.'
    'API02-AI-028' = 'API02-AI-028 says two identical requests are sent rapidly in sequence; API02-AI-015 already covers sequential replay after success, while true concurrency is separately covered by API02-AI-020. No distinct final oracle remains.'
}

$apiDefinitions = @(
    [ordered]@{api='API-01'; raw='test-cases/generated/api-01-reset-password.json'; audited='test-cases/audited/api-01-reset-password.json'; analysis='docs/requirement-analysis/api-01-reset-password.md'},
    [ordered]@{api='API-02'; raw='test-cases/generated/api-02-checkout.json'; audited='test-cases/audited/api-02-checkout.json'; analysis='docs/requirement-analysis/api-02-checkout.md'},
    [ordered]@{api='API-03'; raw='test-cases/generated/api-03-import-products.json'; audited='test-cases/audited/api-03-import-products.json'; analysis='docs/requirement-analysis/api-03-import-products.md'}
)

function Get-SourceStatements([string]$AnalysisPath) {
    $map = @{}
    foreach ($line in Get-Content -LiteralPath $AnalysisPath) {
        if ($line -notmatch '^\| (API\d{2}-(?:REQ|RG|ID)-\d{3}) \|') { continue }
        $parts = @($line.Trim('|').Split('|') | ForEach-Object { $_.Trim() })
        $id = $parts[0]
        if ($id -match '-REQ-') {
            $map[$id] = "[$($parts[2])] $($parts[3])"
        } elseif ($id -match '-RG-') {
            $map[$id] = "[REQUIREMENT_GAP] $($parts[1])"
        } else {
            $map[$id] = "[$($parts[-1])] Authoritative expectation: $($parts[2])"
        }
    }
    return $map
}

$rawById = @{}
$auditById = @{}
$apiById = @{}
$sourceByApi = @{}
foreach ($definition in $apiDefinitions) {
    $rawDocument = Get-Content -LiteralPath (Join-Path $WorkspaceRoot $definition.raw) -Raw | ConvertFrom-Json
    $auditDocument = Get-Content -LiteralPath (Join-Path $WorkspaceRoot $definition.audited) -Raw | ConvertFrom-Json
    foreach ($case in $rawDocument.test_cases) { $rawById[$case.id] = $case; $apiById[$case.id] = $definition.api }
    foreach ($record in $auditDocument.audit_records) { $auditById[$record.test_case_id] = $record }
    $sourceByApi[$definition.api] = Get-SourceStatements (Join-Path $WorkspaceRoot $definition.analysis)
}

$reasonsById = @{}
foreach ($id in $auditById.Keys) {
    $record = $auditById[$id]
    $reasons = [System.Collections.Generic.List[string]]::new()
    if ($record.classification -eq 'INVALID') { $reasons.Add('INVALID') }
    if (@($record.issues) -contains 'SEMANTIC_DUPLICATION') { $reasons.Add('SEMANTIC_DUPLICATE') }
    if (@($record.issues) -contains 'TRACEABILITY_ISSUE') { $reasons.Add('TRACEABILITY_ISSUE') }
    if ($reasons.Count) { $reasonsById[$id] = $reasons }
}
foreach ($api in $selectedIncomplete.Keys) {
    foreach ($id in $selectedIncomplete[$api]) {
        if (-not $reasonsById.ContainsKey($id)) { $reasonsById[$id] = [System.Collections.Generic.List[string]]::new() }
        $reasonsById[$id].Add('REPRESENTATIVE_INCOMPLETE')
    }
}
foreach ($api in $selectedValid.Keys) {
    foreach ($id in $selectedValid[$api]) {
        if (-not $reasonsById.ContainsKey($id)) { $reasonsById[$id] = [System.Collections.Generic.List[string]]::new() }
        $reasonsById[$id].Add('REPRESENTATIVE_VALID')
    }
}

$selectedIds = @($reasonsById.Keys | Sort-Object { $apiById[$_] }, { $_ })
if ($selectedIds.Count -ne 25) { throw "Expected 25 unique packet cases, got $($selectedIds.Count)" }
foreach ($id in $selectedIds) {
    if (-not $rawById.ContainsKey($id) -or -not $auditById.ContainsKey($id)) { throw "Missing raw/audit record for $id" }
}

$packet = [System.Collections.Generic.List[string]]::new()
$packet.Add('# Targeted Human Review Packet — Three-API AI Test Audit')
$packet.Add('')
$packet.Add('- Workflow status: `TARGETED_AI_TEST_AUDIT_HUMAN_REVIEW_REQUIRED`')
$packet.Add('- Audit approval status: `NOT_YET_FINAL_APPROVED`')
$packet.Add('- Current classifications are `AI_AUDIT_PROPOSAL`; this packet does not change or apply them.')
$packet.Add('- Raw generation and structured audit artifacts are read-only sources for this packet.')
$packet.Add('- Student Extension guard: future phase requires at least 5 `STUDENT_ADDED` cases per API (15 total), but none are created here.')
$packet.Add('')
$packet.Add('## Human decision values')
$packet.Add('')
$packet.Add('For every case, keep `HUMAN_DECISION: PENDING` until the student selects exactly one:')
$packet.Add('')
$packet.Add('- `APPROVE_CLASSIFICATION`')
$packet.Add('- `CHANGE_TO_VALID`')
$packet.Add('- `CHANGE_TO_INVALID`')
$packet.Add('- `CHANGE_TO_INCOMPLETE`')
$packet.Add('- `MODIFY_CORRECTION`')
$packet.Add('- `REMOVE_FROM_FINAL_SUITE`')
$packet.Add('- `DEFER_AS_REQUIREMENT_GAP`')

foreach ($definition in $apiDefinitions) {
    $packet.Add('')
    $packet.Add("## $($definition.api)")
    foreach ($id in @($selectedIds | Where-Object { $apiById[$_] -eq $definition.api })) {
        $case = $rawById[$id]
        $audit = $auditById[$id]
        $packet.Add('')
        $packet.Add("### $id")
        $packet.Add('')
        $packet.Add("- **API:** ``$($case.api_id)`` — ``$($case.endpoint)``")
        $packet.Add("- **PRIMARY TECHNIQUE:** ``$($case.primary_technique)``")
        $packet.Add("- **SELECTION REASON:** ``$($reasonsById[$id] -join ', ')``")
        $packet.Add('')
        $packet.Add('#### RAW AI-GENERATED CASE')
        $packet.Add('')
        $packet.Add("- **Title:** $($case.title)")
        $packet.Add("- **Objective:** $($case.objective)")
        $packet.Add("- **Requirement IDs:** ``$($case.requirement_ids -join ', ')``")
        $packet.Add("- **Preconditions:** $($case.preconditions -join '; ')")
        $packet.Add('- **Request / test data:**')
        $packet.Add('')
        $packet.Add('```json')
        $packet.Add(([ordered]@{request=$case.request;test_data=$case.test_data} | ConvertTo-Json -Depth 8))
        $packet.Add('```')
        $packet.Add("- **Expected status:** ``$($case.expected_status)``")
        $packet.Add("- **Expected business result:** $($case.expected_business_result)")
        $packet.Add("- **Expected state:** $($case.expected_state)")
        $packet.Add("- **Oracle basis:** ``$($case.oracle_basis)``")
        $packet.Add("- **Notes:** $($case.notes)")
        $packet.Add('')
        $packet.Add('#### AI AUDIT PROPOSAL')
        $packet.Add('')
        $packet.Add("- **Classification:** ``$($audit.classification)``")
        $packet.Add("- **Classification reason:** $($audit.classification_reason)")
        $packet.Add("- **Traceability assessment:** ``$($audit.requirement_traceability.assessment)``")
        $packet.Add("- **Oracle assessment:** ``$($audit.oracle_review.assessment)``")
        $issueText = if (@($audit.issues).Count) { @($audit.issues) -join ', ' } else { 'NONE' }
        $duplicateText = if ($audit.duplicate_of) { $audit.duplicate_of } else { 'NONE' }
        $correctionText = if ($audit.proposed_correction) { $audit.proposed_correction } else { 'NONE' }
        $packet.Add("- **Issues:** ``$issueText``")
        $packet.Add("- **Duplicate of:** ``$duplicateText``")
        if ($audit.duplicate_of) {
            $packet.Add("- **Difference:** $($duplicateDifference[$id])")
            $packet.Add("- **Why semantic duplicate:** $($audit.classification_reason)")
        }
        $packet.Add("- **Proposed correction:** $correctionText")
        $packet.Add("- **Proposed action:** ``$($audit.proposed_action)``")
        $packet.Add('')
        $packet.Add('#### RELEVANT REQUIREMENT/GAP')
        $packet.Add('')
        $refs = @($audit.requirement_traceability.requirement_ids) + @($audit.requirement_traceability.gap_ids) + @($audit.requirement_traceability.risk_ids) + @($audit.requirement_traceability.observation_ids)
        foreach ($ref in $refs) {
            $statement = if ($sourceByApi[$definition.api].ContainsKey($ref)) { $sourceByApi[$definition.api][$ref] } else { '[SECURITY_TEST_CONSIDERATION] Risk/observation reference; it does not independently define a transport response or business oracle.' }
            $packet.Add("- ``$ref`` — $statement")
        }
        $packet.Add('')
        $packet.Add('#### HUMAN REVIEW')
        $packet.Add('')
        $packet.Add('```text')
        $packet.Add('HUMAN_DECISION:')
        $packet.Add('PENDING')
        $packet.Add('')
        $packet.Add('COMMENT:')
        $packet.Add('')
        $packet.Add('```')
    }
}

$invalidCount = @($selectedIds | Where-Object { $auditById[$_].classification -eq 'INVALID' }).Count
$duplicateCount = @($selectedIds | Where-Object { @($auditById[$_].issues) -contains 'SEMANTIC_DUPLICATION' }).Count
$traceCount = @($selectedIds | Where-Object { @($auditById[$_].issues) -contains 'TRACEABILITY_ISSUE' }).Count
$packet.Add('')
$packet.Add('## Cross-case summary')
$packet.Add('')
$packet.Add('```text')
$packet.Add("TOTAL_CASES_IN_REVIEW_PACKET: $($selectedIds.Count)")
$packet.Add('')
$packet.Add("INVALID_INCLUDED: $invalidCount/3")
$packet.Add("SEMANTIC_DUPLICATES_INCLUDED: $duplicateCount/2")
$packet.Add("TRACEABILITY_ISSUES_INCLUDED: $traceCount/1")
$packet.Add('')
$packet.Add('INCOMPLETE_SAMPLES:')
foreach ($api in $selectedIncomplete.Keys) { $packet.Add("$api`: $($selectedIncomplete[$api].Count)") }
$packet.Add('')
$packet.Add('VALID_SAMPLES:')
foreach ($api in $selectedValid.Keys) { $packet.Add("$api`: $($selectedValid[$api].Count)") }
$packet.Add('```')
$packet.Add('')
$packet.Add('## HUMAN REVIEW QUESTIONS')
$packet.Add('')
$packet.Add('1. Do the three `INVALID` classifications appear justified?')
$packet.Add('2. Are `API01-AI-036` and `API02-AI-028` truly redundant with their identified canonical cases?')
$packet.Add('3. Should observable-only requirement-gap cases remain `INCOMPLETE`, be retained as non-blocking observational tests, or be deferred?')
$packet.Add('4. Can any confirmation, coupon, FR-15/category, or downstream-login case be salvaged by narrowing its oracle without inventing integration?')
$packet.Add('5. Are the six sampled `VALID` cases adequately requirement/security-backed, or has the audit classified any of them too easily?')
$packet.Add('6. Which missing contracts should be resolved before correction: OTP expiry/rate-limit, shipping/empty-cart/idempotency, or import batch/duplicate/category/precision?')

$output = Join-Path $WorkspaceRoot 'docs\test-audit\human-review-packet.md'
$packet | Set-Content -LiteralPath $output -Encoding utf8

'HUMAN_REVIEW_PACKET_CREATED'
"TOTAL=$($selectedIds.Count)"
"INVALID=$invalidCount/3"
"DUPLICATES=$duplicateCount/2"
"TRACEABILITY=$traceCount/1"
foreach ($api in $selectedIncomplete.Keys) { "INCOMPLETE_$api=$($selectedIncomplete[$api].Count)" }
foreach ($api in $selectedValid.Keys) { "VALID_$api=$($selectedValid[$api].Count)" }
