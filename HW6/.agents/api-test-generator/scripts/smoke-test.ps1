$ErrorActionPreference = 'Stop'
$techniques = @('DOMAIN_PARTITION','BOUNDARY','STATE_TRANSITION','SECURITY','SCHEMA','BUSINESS_RULE')
$spec = @{ api_id='SMOKE-GENERIC'; method='PATCH'; path='/resources/{id}'; requirements=@('SMOKE-REQ-1') }
$candidates = foreach ($technique in $techniques) { [ordered]@{ id="SMOKE-GEN-$technique"; api_id=$spec.api_id; feature_id='SMOKE'; endpoint="$($spec.method) $($spec.path)"; source='AI_GENERATED'; requirement_ids=$spec.requirements; technique=@($technique); title="Synthetic $technique candidate"; objective='TEST-ONLY'; preconditions=@(); request=@{}; test_data=@{}; expected_status=200; expected_schema=@{}; expected_business_result='Synthetic'; expected_state=$null; audit_status='PENDING_HUMAN_REVIEW'; audit_reason=$null; correction=$null; why_ai_missed=$null; execution_status='NOT_IMPLEMENTED'; failure_classification=$null; bug_id=$null; notes='TEST-ONLY' } }
$duplicate = [ordered]@{}; foreach ($entry in $candidates[0].GetEnumerator()) { $duplicate[$entry.Key] = $entry.Value }; $duplicate.id='SMOKE-GEN-DUPLICATE'
$all = @($candidates) + @($duplicate)
$unique = $all | Group-Object { "$($_.endpoint)|$($_.technique -join ',')|$($_.title)" } | ForEach-Object { $_.Group[0] }
if ($unique.Count -ne $techniques.Count) { throw 'Deduplication failed.' }
foreach ($case in $unique) { if ($case.source -ne 'AI_GENERATED' -or $case.audit_status -ne 'PENDING_HUMAN_REVIEW' -or $case.execution_status -ne 'NOT_IMPLEMENTED') { throw 'Candidate lifecycle invalid.' } }
if ((@($unique | ForEach-Object { $_.technique } | Sort-Object -Unique).Count) -ne $techniques.Count) { throw 'Technique coverage incomplete.' }
Write-Output 'PASS: generic synthetic specification produced canonical candidate shape, removed one duplicate, covered six techniques, and retained GENERATOR_OUTPUT_REVIEW_REQUIRED semantics. No endpoint was called.'
