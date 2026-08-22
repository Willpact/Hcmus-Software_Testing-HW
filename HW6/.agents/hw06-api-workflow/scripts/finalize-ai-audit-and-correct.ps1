param(
    [string]$WorkspaceRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
)

$ErrorActionPreference = 'Stop'

function Set-Field($Object, [string]$Name, $Value) {
    if ($Object.PSObject.Properties.Name -contains $Name) { $Object.$Name = $Value }
    else { $Object | Add-Member -NotePropertyName $Name -NotePropertyValue $Value }
}

function Clone-Object($Object) {
    return ($Object | ConvertTo-Json -Depth 20 | ConvertFrom-Json)
}

$targetedIds = @(
    'API01-AI-013','API01-AI-014','API01-AI-020','API01-AI-025','API01-AI-026','API01-AI-030','API01-AI-035','API01-AI-036','API01-AI-040',
    'API02-AI-008','API02-AI-011','API02-AI-014','API02-AI-015','API02-AI-019','API02-AI-026','API02-AI-028','API02-AI-038','API02-AI-039',
    'API03-AI-014','API03-AI-015','API03-AI-026','API03-AI-032','API03-AI-034','API03-AI-035','API03-AI-040'
)
$decisionMap = @{}
foreach ($id in $targetedIds) { $decisionMap[$id] = 'APPROVE_CLASSIFICATION' }
$decisionMap['API01-AI-040'] = 'CHANGE_TO_INVALID'
$decisionMap['API02-AI-038'] = 'DEFER_AS_REQUIREMENT_GAP'
$decisionMap['API03-AI-035'] = 'MODIFY_CORRECTION'
$decisionMap['API01-AI-035'] = 'MODIFY_CORRECTION'

$salvage = @{
    'API01-AI-004' = [ordered]@{
        objective='Verify that an unregistered-email reset attempt cannot mutate any existing account, without using response similarity as an oracle.'
        business='No existing account password may change because no issued OTP is bound to the unregistered email.'
        state='All existing user-password and reset-token state remains unchanged.'
        oracle='SECURITY_EXPECTATION'
        summary='Narrowed user-enumeration observation to the authoritative email/token-binding and no-unauthorized-mutation invariant.'
    }
    'API01-AI-005' = [ordered]@{
        objective='Verify that omitting email cannot authorize a password reset for any account.'
        business='No password reset may complete without an account identity bound to the issued OTP.'
        state='All user passwords remain unchanged; no successful-use token invalidation is asserted.'
        oracle='SECURITY_EXPECTATION'
        summary='Removed the unspecified field-validation response oracle and retained only the email/token authorization invariant.'
    }
    'API01-AI-006' = [ordered]@{
        objective='Verify that omitting resetToken cannot authorize a password reset.'
        business='A reset without the issued email-bound OTP must not change the password.'
        state='The existing password remains unchanged; no successful token use occurs.'
        oracle='AUTHORITATIVE'
        summary='Replaced requiredness observation with the authoritative issued-OTP authorization invariant.'
    }
    'API01-AI-007' = [ordered]@{
        objective='Verify that a reset operation without a new password cannot complete a password change.'
        business='The operation cannot establish the required new password; no successful reset is recognized.'
        state='The existing password remains unchanged and the request is not treated as a successful token use.'
        oracle='PARTIALLY_SPECIFIED'
        summary='Removed transport validation assumptions and asserted only that a reset cannot complete without a new password value.'
    }
    'API02-AI-006' = [ordered]@{
        objective='Verify the cart-derived total invariant when client total_amount is a numeric string.'
        business='Acceptable outcomes are rejection without successful-checkout side effects, or successful checkout using the backend cart-derived total; the client string never becomes authoritative.'
        state='If checkout succeeds the authenticated user cart is cleared; otherwise no success-side-effect claim is made.'
        oracle='PARTIALLY_SPECIFIED'
        summary='Converted unspecified type coercion into a two-outcome invariant that never permits client total authority.'
    }
    'API02-AI-007' = [ordered]@{
        objective='Verify the cart-derived total invariant when total_amount is omitted.'
        business='Acceptable outcomes are rejection without successful-checkout side effects, or successful checkout using the backend cart-derived total.'
        state='If checkout succeeds the authenticated user cart is cleared; otherwise no success-side-effect claim is made.'
        oracle='PARTIALLY_SPECIFIED'
        summary='Removed the requiredness assumption and retained the authoritative server-calculation invariant.'
    }
    'API03-AI-003' = [ordered]@{
        objective='Verify that a request without the documented products array cannot import product rows.'
        business='No product row can be imported because the endpoint request contains no products array.'
        state='The products snapshot remains unchanged.'
        oracle='PARTIALLY_SPECIFIED'
        summary='Removed the transport-response assumption and added a no-import state assertion tied to the documented products array.'
    }
    'API03-AI-004' = [ordered]@{
        objective='Verify that products=null does not produce imported rows because products must use the documented array representation.'
        business='No product is imported from a null value; exact status and response schema remain unspecified.'
        state='The products snapshot remains unchanged.'
        oracle='PARTIALLY_SPECIFIED'
        summary='Added a deterministic no-commit assertion for a non-array null representation.'
    }
    'API03-AI-005' = [ordered]@{
        objective='Verify that products as an object does not produce imported rows because the endpoint documents an array.'
        business='No product is imported from a non-array object; exact status and response schema remain unspecified.'
        state='The products snapshot remains unchanged.'
        oracle='PARTIALLY_SPECIFIED'
        summary='Added a deterministic no-commit assertion for the wrong top-level products type.'
    }
}

$definitions = @(
    [ordered]@{api='API-01'; slug='api-01-reset-password'; raw='test-cases/generated/api-01-reset-password.json'; audit='test-cases/audited/api-01-reset-password.json'; auditMd='docs/test-audit/api-01-reset-password-audit.md'},
    [ordered]@{api='API-02'; slug='api-02-checkout'; raw='test-cases/generated/api-02-checkout.json'; audit='test-cases/audited/api-02-checkout.json'; auditMd='docs/test-audit/api-02-checkout-audit.md'},
    [ordered]@{api='API-03'; slug='api-03-import-products'; raw='test-cases/generated/api-03-import-products.json'; audit='test-cases/audited/api-03-import-products.json'; auditMd='docs/test-audit/api-03-import-products-audit.md'}
)

$correctionDir = Join-Path $WorkspaceRoot 'docs\test-correction'
$correctedDir = Join-Path $WorkspaceRoot 'test-cases\corrected'
New-Item -ItemType Directory -Force -Path $correctionDir,$correctedDir | Out-Null
$allAuditRecords = @()
$apiSummaries = @()

foreach ($definition in $definitions) {
    $rawDocument = Get-Content -LiteralPath (Join-Path $WorkspaceRoot $definition.raw) -Raw | ConvertFrom-Json
    $auditDocument = Get-Content -LiteralPath (Join-Path $WorkspaceRoot $definition.audit) -Raw | ConvertFrom-Json
    $rawById = @{}; foreach ($case in $rawDocument.test_cases) { $rawById[$case.id] = $case }
    $records = @($auditDocument.audit_records)
    foreach ($record in $records) {
        $id = $record.test_case_id
        $decision = if ($decisionMap.ContainsKey($id)) { $decisionMap[$id] } else { 'AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED' }
        Set-Field $record 'human_review_decision' $decision
        Set-Field $record 'human_review_status' $(if ($decisionMap.ContainsKey($id)) { 'HUMAN_REVIEW_DECISION_APPLIED' } else { 'AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED' })
        Set-Field $record 'review_scope' $(if ($decisionMap.ContainsKey($id)) { 'TARGETED_CASE_REVIEW' } else { 'PRESERVED_AI_AUDIT_CLASSIFICATION' })

        if ($id -eq 'API01-AI-040') {
            $record.classification = 'INVALID'
            $record.classification_reason = 'API01-REQ-003 establishes a six-digit issued OTP; the raw case requires an unsupported seven-digit issuer state. SEC-07 entropy wording does not establish that FR-03 issues a seven-digit token.'
            $record.issues = @('UNSUPPORTED_PRECONDITION')
            $record.proposed_correction = 'Preserve the raw case for history and exclude it from the final executable suite.'
            $record.proposed_action = 'REMOVE_FROM_FINAL_EXECUTABLE_SUITE'
            $record.oracle_review.assessment = 'UNSUPPORTED_PRECONDITION'
            $record.requirement_traceability.assessment = 'MISALIGNED_UNSUPPORTED_ISSUER_STATE'
        }
        if ($id -eq 'API02-AI-038') {
            $record.classification_reason = 'FR-09 is supporting/cross-feature context; no authoritative source defines coupon integration with POST /api/checkout.'
            $record.proposed_correction = 'Do not invent a coupon integration oracle; defer until a cross-feature checkout contract is approved.'
            $record.proposed_action = 'DEFERRED_REQUIREMENT_GAP'
            Set-Field $record 'future_scope' 'CROSS_FEATURE_COUPON_CHECKOUT_INTEGRATION'
        }
        if ($id -eq 'API03-AI-035') {
            $record.requirement_traceability.requirement_ids = @('API03-REQ-004','API03-REQ-006')
            $record.requirement_traceability.gap_ids = @('API03-RG-001')
            $record.requirement_traceability.assessment = 'CORRECTED_PRIMARY_API_CONTRACT_WITH_SUPPORTING_CSV_CONTEXT'
            Set-Field $record.requirement_traceability 'primary_requirement' 'API03-REQ-004'
            Set-Field $record.requirement_traceability 'supporting_context' @('API03-REQ-006')
            $record.proposed_correction = 'Traceability corrected: API03-REQ-004 is primary, API03-RG-001 is the related representation gap, and API03-REQ-006 remains supporting context.'
        }
        if ($id -eq 'API01-AI-035') {
            Set-Field $record 'automation_note' 'Requires database/external persistence verification in the isolated test environment. Do not represent this as a pure Postman response assertion if Postman cannot directly inspect persistence.'
            $record.proposed_correction = 'Keep the SEC-01 plaintext-storage oracle and add external persistence verification metadata.'
        }

        $disposition = if ($record.classification -eq 'INVALID') { 'REMOVED_FROM_FINAL_EXECUTABLE_SUITE' } elseif ($record.classification -eq 'VALID') { 'INCLUDED_EXECUTABLE' } elseif ($salvage.ContainsKey($id)) { 'SALVAGED_TO_EXECUTABLE' } else { 'DEFERRED_REQUIREMENT_GAP' }
        if ($id -eq 'API02-AI-038') { $disposition = 'DEFERRED_REQUIREMENT_GAP' }
        Set-Field $record 'final_disposition' $disposition
    }

    $summary = [ordered]@{
        total=40
        valid=@($records | Where-Object classification -eq 'VALID').Count
        invalid=@($records | Where-Object classification -eq 'INVALID').Count
        incomplete=@($records | Where-Object classification -eq 'INCOMPLETE').Count
        proposed_corrections=@($records | Where-Object classification -ne 'VALID').Count
        proposed_removals=@($records | Where-Object classification -eq 'INVALID').Count
        semantic_duplicates=@($records | Where-Object { @($_.issues) -contains 'SEMANTIC_DUPLICATION' }).Count
        authoritative_oracle_issues=@($records | Where-Object { @($_.issues) -contains 'AMBIGUOUS_EXPECTED_RESULT' }).Count
        traceability_issues=@($records | Where-Object { @($_.issues) -contains 'TRACEABILITY_ISSUE' }).Count
        state_setup_issues=@($records | Where-Object { @($_.issues) -contains 'MISSING_STATE_SETUP' }).Count
        security_reasoning_issues=@($records | Where-Object { @($_.issues) -contains 'SECURITY_REASONING_GAP' }).Count
        cross_feature_overreach=@($records | Where-Object { @($_.issues) -contains 'CROSS_FEATURE_OVERREACH' }).Count
        unsupported_precondition=@($records | Where-Object { @($_.issues) -contains 'UNSUPPORTED_PRECONDITION' }).Count
        implementation_as_oracle=@($records | Where-Object { @($_.issues) -contains 'IMPLEMENTATION_AS_ORACLE' }).Count
    }
    $auditDocument.metadata.human_review_status = 'MODIFIED_AND_APPROVED_WITH_TARGETED_CASE_DECISIONS'
    Set-Field $auditDocument.metadata 'targeted_review_completed' $true
    $auditDocument.summary = $summary
    $auditDocument.audit_records = $records
    $auditDocument | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath (Join-Path $WorkspaceRoot $definition.audit) -Encoding utf8

    $executable = @(); $removed = @(); $deferred = @()
    foreach ($record in $records) {
        $rawCase = $rawById[$record.test_case_id]
        if ($record.final_disposition -in @('INCLUDED_EXECUTABLE','SALVAGED_TO_EXECUTABLE')) {
            $case = Clone-Object $rawCase
            $correctionSummary = 'No semantic correction required; Human-approved audit classification retained.'
            if ($record.final_disposition -eq 'SALVAGED_TO_EXECUTABLE') {
                $fix = $salvage[$case.id]
                $case.objective = $fix.objective
                $case.expected_business_result = $fix.business
                $case.expected_state = $fix.state
                $case.oracle_basis = $fix.oracle
                $correctionSummary = $fix.summary
            }
            if ($case.id -eq 'API03-AI-035') {
                $case.requirement_ids = @('API03-REQ-004','API03-REQ-006')
                $case.gap_ids = @('API03-RG-001')
                $correctionSummary = 'Traceability corrected so API03-REQ-004 is primary; API03-RG-001 is the related gap and API03-REQ-006 is supporting context.'
            }
            if ($case.id -eq 'API01-AI-035') {
                $case.notes = "$($case.notes); AUTOMATION_NOTE: $($record.automation_note)"
                $correctionSummary = 'SEC-01 oracle retained; added isolated database/external persistence verification metadata.'
            }
            $case.lifecycle_state = 'HUMAN_APPROVED'
            $case.audit_status = $record.classification
            $case.audit_reason = $record.classification_reason
            $case.correction = if ($record.final_disposition -eq 'SALVAGED_TO_EXECUTABLE' -or $case.id -in @('API03-AI-035','API01-AI-035')) { $correctionSummary } else { $null }
            $case.execution_status = 'REAL_EXECUTION_REQUIRED'
            $wrapper = [ordered]@{
                original_ai_case_id=$case.id; source='AI_GENERATED'; audit_classification=$record.classification
                human_review_status=$record.human_review_status; correction_summary=$correctionSummary
                requirement_ids=@($case.requirement_ids); oracle_basis=$case.oracle_basis
                final_disposition=$record.final_disposition
                automation_note=if ($record.PSObject.Properties.Name -contains 'automation_note') { $record.automation_note } else { $null }
                test_case=$case
            }
            $executable += $wrapper
        } elseif ($record.final_disposition -eq 'REMOVED_FROM_FINAL_EXECUTABLE_SUITE') {
            $removed += [ordered]@{original_ai_case_id=$record.test_case_id;source='AI_GENERATED';audit_classification=$record.classification;human_review_status=$record.human_review_status;final_disposition=$record.final_disposition;reason=$record.classification_reason}
        } else {
            $deferred += [ordered]@{original_ai_case_id=$record.test_case_id;source='AI_GENERATED';audit_classification=$record.classification;human_review_status=$record.human_review_status;final_disposition='DEFERRED_REQUIREMENT_GAP';reason=$record.classification_reason;proposed_correction=$record.proposed_correction}
        }
    }
    $techniqueCoverage = [ordered]@{}
    foreach ($technique in @('DOMAIN_PARTITION','BOUNDARY','STATE_TRANSITION','SECURITY','SCHEMA','BUSINESS_RULE')) { $techniqueCoverage[$technique] = @($executable | Where-Object { $_.test_case.primary_technique -eq $technique }).Count }
    $correctedSummary = [ordered]@{
        raw_ai_generated=40;valid_after_audit=$summary.valid;invalid_removed=$removed.Count
        incomplete_salvaged=@($executable | Where-Object audit_classification -eq 'INCOMPLETE').Count
        incomplete_deferred=$deferred.Count;final_executable_ai_cases=$executable.Count
    }
    $correctedDocument = [ordered]@{
        metadata=[ordered]@{api_id=$definition.api;status='HUMAN_APPROVED_AI_CORRECTION';source='AI_GENERATED';raw_source=$definition.raw;raw_modified=$false;execution_status='REAL_EXECUTION_REQUIRED'}
        summary=$correctedSummary;technique_coverage=$techniqueCoverage;executable_cases=$executable;removed_cases=$removed;deferred_cases=$deferred
    }
    $correctedDocument | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath (Join-Path $correctedDir "$($definition.slug).json") -Encoding utf8

    $auditMd = [System.Collections.Generic.List[string]]::new()
    $auditMd.Add("# $($definition.api) Human-reviewed AI Test Audit")
    $auditMd.Add(''); $auditMd.Add('- Status: `MODIFIED_AND_APPROVED`')
    $auditMd.Add('- Raw generation remains unchanged; classifications below distinguish AI proposal from Human Review Decision and Final Disposition.')
    $auditMd.Add(''); $auditMd.Add('## Summary'); $auditMd.Add('')
    foreach ($item in $summary.GetEnumerator()) { $auditMd.Add("- ``$($item.Key.ToUpperInvariant())``: $($item.Value)") }
    $auditMd.Add(''); $auditMd.Add('## Per-case audit')
    foreach ($record in $records) {
        $auditMd.Add(''); $auditMd.Add("### $($record.test_case_id)"); $auditMd.Add('')
        $auditMd.Add("- AI audit proposal / final classification: ``$($record.classification)``")
        $auditMd.Add("- Classification reason: $($record.classification_reason)")
        $auditMd.Add("- Traceability assessment: ``$($record.requirement_traceability.assessment)``")
        $auditMd.Add("- Oracle assessment: ``$($record.oracle_review.assessment)``")
        $auditMd.Add("- Issues: ``$(@($record.issues) -join ', ')``")
        $auditMd.Add("- Human Review Decision: ``$($record.human_review_decision)``")
        $auditMd.Add("- Human review status: ``$($record.human_review_status)``")
        $auditMd.Add("- Final disposition: ``$($record.final_disposition)``")
        $auditMd.Add("- Proposed/applied correction: $($record.proposed_correction)")
        if ($record.PSObject.Properties.Name -contains 'automation_note') { $auditMd.Add("- Automation note: $($record.automation_note)") }
    }
    $auditMd | Set-Content -LiteralPath (Join-Path $WorkspaceRoot $definition.auditMd) -Encoding utf8

    $correctionMd = [System.Collections.Generic.List[string]]::new()
    $correctionMd.Add("# $($definition.api) Corrected AI-generated Suite")
    $correctionMd.Add(''); $correctionMd.Add('- Source remains `AI_GENERATED`; raw case IDs are stable and raw files are unchanged.')
    $correctionMd.Add('- Status: `HUMAN_APPROVED_AI_CORRECTION`; execution: `REAL_EXECUTION_REQUIRED`.')
    $correctionMd.Add(''); $correctionMd.Add('## Summary'); $correctionMd.Add('')
    foreach ($item in $correctedSummary.GetEnumerator()) { $correctionMd.Add("- ``$($item.Key.ToUpperInvariant())``: $($item.Value)") }
    $correctionMd.Add(''); $correctionMd.Add('## Primary-technique coverage'); $correctionMd.Add('')
    foreach ($item in $techniqueCoverage.GetEnumerator()) { $correctionMd.Add("- ``$($item.Key)``: $($item.Value)") }
    $correctionMd.Add(''); $correctionMd.Add('## Executable AI-generated cases')
    foreach ($wrapper in $executable) {
        $c=$wrapper.test_case; $correctionMd.Add(''); $correctionMd.Add("### $($c.id) — $($c.title)"); $correctionMd.Add('')
        $correctionMd.Add("- Audit classification: ``$($wrapper.audit_classification)``; disposition: ``$($wrapper.final_disposition)``")
        $correctionMd.Add("- Correction summary: $($wrapper.correction_summary)")
        $correctionMd.Add("- Requirements: ``$($wrapper.requirement_ids -join ', ')``; oracle: ``$($wrapper.oracle_basis)``")
        $correctionMd.Add("- Objective: $($c.objective)")
        $correctionMd.Add("- Expected business result: $($c.expected_business_result)")
        $correctionMd.Add("- Expected state: $($c.expected_state)")
        $correctionMd.Add("- Expected status/schema: ``UNSPECIFIED_BY_AUTHORITATIVE_SOURCE``")
        if ($wrapper.automation_note) { $correctionMd.Add("- Automation note: $($wrapper.automation_note)") }
    }
    $correctionMd.Add(''); $correctionMd.Add('## Removed INVALID cases'); foreach($item in $removed){$correctionMd.Add("- ``$($item.original_ai_case_id)`` — $($item.reason)")}
    $correctionMd.Add(''); $correctionMd.Add('## Deferred requirement gaps'); foreach($item in $deferred){$correctionMd.Add("- ``$($item.original_ai_case_id)`` — $($item.reason)")}
    $correctionMd | Set-Content -LiteralPath (Join-Path $correctionDir "$($definition.slug)-corrected.md") -Encoding utf8

    $apiSummaries += [ordered]@{api=$definition.api;audit_summary=$summary;corrected_summary=$correctedSummary;technique_coverage=$techniqueCoverage}
    $allAuditRecords += $records
}

if ($allAuditRecords.Count -ne 120) { throw 'Audit total is not 120' }
$patternRows = @()
foreach ($issue in ($allAuditRecords.issues | ForEach-Object { $_ } | Where-Object { $_ } | Sort-Object -Unique)) {
    $affected=@($allAuditRecords|Where-Object{@($_.issues)-contains$issue})
    $patternRows += [ordered]@{pattern=$issue;count=$affected.Count;affected_apis=@($affected.test_case_id|ForEach-Object{$_.Substring(0,5)-replace'^API(\d{2})$','API-$1'}|Sort-Object -Unique);representative_test_case_ids=@($affected.test_case_id|Select-Object -First 5)}
}
$patternRows=@($patternRows|Sort-Object @{Expression={$_['count']};Descending=$true},@{Expression={$_['pattern']};Descending=$false})
$totalSummary=[ordered]@{audited=120;valid=@($allAuditRecords|Where-Object classification -eq 'VALID').Count;invalid=@($allAuditRecords|Where-Object classification -eq 'INVALID').Count;incomplete=@($allAuditRecords|Where-Object classification -eq 'INCOMPLETE').Count;proposed_corrections=@($allAuditRecords|Where-Object classification -ne 'VALID').Count;proposed_removals=@($allAuditRecords|Where-Object classification -eq 'INVALID').Count;semantic_duplicates=@($allAuditRecords|Where-Object{@($_.issues)-contains 'SEMANTIC_DUPLICATION'}).Count}
$oldCross=Get-Content -LiteralPath (Join-Path $WorkspaceRoot 'test-cases\audited\cross-api-summary.json') -Raw|ConvertFrom-Json
$cross=[ordered]@{metadata=[ordered]@{status='MODIFIED_AND_APPROVED';human_review_status='TARGETED_REVIEW_COMPLETED';student_added_cases=0};total_summary=$totalSummary;api_summaries=$apiSummaries;failure_patterns=$patternRows;future_extension_gaps=@($oldCross.future_extension_gaps)}
$cross|ConvertTo-Json -Depth 12|Set-Content -LiteralPath (Join-Path $WorkspaceRoot 'test-cases\audited\cross-api-summary.json') -Encoding utf8
$crossMd=[System.Collections.Generic.List[string]]::new();$crossMd.Add('# Cross-API Human-reviewed AI Test Audit');$crossMd.Add('');$crossMd.Add('- Status: `MODIFIED_AND_APPROVED`');$crossMd.Add('- Targeted review completed; raw generation unchanged.');$crossMd.Add('');$crossMd.Add('## Final classification');foreach($item in $totalSummary.GetEnumerator()){$crossMd.Add("- ``$($item.Key.ToUpperInvariant())``: $($item.Value)")};$crossMd.Add('');$crossMd.Add('## Failure patterns');$crossMd.Add('');$crossMd.Add('| Pattern | Count | Affected APIs | Representative IDs |');$crossMd.Add('| --- | ---: | --- | --- |');foreach($row in $patternRows){$crossMd.Add("| ``$($row.pattern)`` | $($row.count) | ``$($row.affected_apis -join ', ')`` | ``$($row.representative_test_case_ids -join ', ')`` |")};$crossMd.Add('');$crossMd.Add('No implementation observation was promoted to an authoritative oracle.');$crossMd|Set-Content -LiteralPath (Join-Path $WorkspaceRoot 'docs\test-audit\cross-api-failure-patterns.md') -Encoding utf8

$packetPath=Join-Path $WorkspaceRoot 'docs\test-audit\human-review-packet.md';$packet=Get-Content -LiteralPath $packetPath -Raw;$packet=$packet.Replace('- Workflow status: `TARGETED_AI_TEST_AUDIT_HUMAN_REVIEW_REQUIRED`','- Workflow status: `TARGETED_REVIEW_COMPLETED`').Replace('- Audit approval status: `NOT_YET_FINAL_APPROVED`','- Audit approval status: `MODIFIED_AND_APPROVED`').Replace('- Current classifications are `AI_AUDIT_PROPOSAL`; this packet does not change or apply them.','- AI audit proposals remain visible; Human Review Decisions and final dispositions have been applied to the separate audit/correction artifacts.')
foreach($id in $targetedIds){
    $decision=$decisionMap[$id]
    $comment=switch($id){
        'API01-AI-040'{'Changed to INVALID: unsupported seven-digit issuer precondition; remove from final executable suite.'}
        'API02-AI-038'{'Classification remains INCOMPLETE; deferred as a cross-feature coupon/checkout requirement gap.'}
        'API03-AI-035'{'Classification remains VALID; traceability corrected to API03-REQ-004 primary, API03-RG-001 gap, API03-REQ-006 supporting.'}
        'API01-AI-035'{'Classification remains VALID; external persistence/database verification metadata added.'}
        default{'Classification approved as proposed in the targeted packet.'}
    }
    $heading="### $id"
    $start=$packet.IndexOf($heading,[System.StringComparison]::Ordinal)
    if($start-lt0){throw "Packet heading missing $id"}
    $next=$packet.IndexOf("`r`n### ",$start+$heading.Length,[System.StringComparison]::Ordinal)
    if($next-lt0){$next=$packet.IndexOf("`r`n## Cross-case summary",$start+$heading.Length,[System.StringComparison]::Ordinal)}
    if($next-lt0){throw "Packet section end missing $id"}
    $section=$packet.Substring($start,$next-$start)
    $replacement="HUMAN_DECISION:`r`n$decision`r`n`r`nCOMMENT:`r`n$comment`r`n"
    $updatedSection=[regex]::Replace($section,'HUMAN_DECISION:\r?\nPENDING\r?\n\r?\nCOMMENT:\r?\n',$replacement,1)
    if($updatedSection-eq$section){throw "Could not update packet decision $id"}
    $packet=$packet.Substring(0,$start)+$updatedSection+$packet.Substring($next)
}
$packet|Set-Content -LiteralPath $packetPath -Encoding utf8

'AUDIT_FINALIZATION_AND_CORRECTION_COMPLETE'
foreach($s in $apiSummaries){"$($s.api):VALID=$($s.audit_summary.valid),INVALID=$($s.audit_summary.invalid),INCOMPLETE=$($s.audit_summary.incomplete),SALVAGED=$($s.corrected_summary.incomplete_salvaged),DEFERRED=$($s.corrected_summary.incomplete_deferred),EXECUTABLE=$($s.corrected_summary.final_executable_ai_cases)"}
"TOTAL:VALID=$($totalSummary.valid),INVALID=$($totalSummary.invalid),INCOMPLETE=$($totalSummary.incomplete)"
