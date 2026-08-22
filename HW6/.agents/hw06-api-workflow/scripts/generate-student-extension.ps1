param(
    [string]$WorkspaceRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path
)

$ErrorActionPreference = 'Stop'

function Parse-List([string]$Value) { if ([string]::IsNullOrWhiteSpace($Value) -or $Value -eq '-') { return @() }; return @($Value.Split(',') | ForEach-Object { $_.Trim() } | Where-Object { $_ }) }
function Parse-Rows([string]$Text) {
    $rows = @()
    foreach ($line in ($Text -split "`r?`n")) {
        if ([string]::IsNullOrWhiteSpace($line)) { continue }
        $c = $line.Split('|')
        if ($c.Count -ne 17) { throw "Expected 17 columns: $line" }
        $rows += [ordered]@{
            number=$c[0]; primary=$c[1]; secondary=(Parse-List $c[2]); refs=(Parse-List $c[3]); oracle=$c[4]
            title=$c[5]; objective=$c[6]; pre=@($c[7] -split ';;' | ForEach-Object { $_.Trim() } | Where-Object { $_ }); request=$c[8]; data=$c[9]; business=$c[10]; state=$c[11]
            category=$c[12]; why=$c[13]; closest=(Parse-List $c[14]); difference=$c[15]; risk=(Parse-List $c[16])
        }
    }
    return $rows
}

$api01=@'
001|STATE_TRANSITION|SECURITY,BUSINESS_RULE|API01-REQ-007,API01-REQ-009|AUTHORITATIVE|Cross-email failure then rightful token use|Verify that a cross-email misuse attempt neither changes an account nor consumes the rightful owner's issued OTP.|Users A and B are registered;;OTP A is issued for email A|Step 1 sends email B with OTP A and a strong password; step 2 sends email A with the same OTP A|Two-step sequence using disposable users and OTP A|Step 1 must not reset either account; step 2 may complete the authoritative owner-bound reset.|After step 1 OTP A remains available for rightful use; after step 2 only A changes and OTP A is invalidated.|STATEFUL_REASONING_GAP|The AI tested cross-email binding and valid reset separately but did not execute the recovery sequence proving a failed foreign use does not consume the owner's token.|API01-AI-002,API01-AI-014,API01-AI-019|Adds a second authoritative owner-use step after the cross-email failure and verifies token state across both requests.|API01-RISK-CROSS-USER-SEQUENCE
002|STATE_TRANSITION|BUSINESS_RULE|API01-REQ-005,API01-REQ-009|AUTHORITATIVE|Weak-password failure then strong retry with same OTP|Verify that a password-policy failure is not treated as successful OTP use and a corrected strong password can use the same issued OTP.|A valid email-bound OTP is issued|Step 1 uses a weak password; step 2 retries the same OTP with a strong password|Weak password missing required classes, followed by a compliant password|The weak attempt must not complete reset; the strong retry may complete reset with the same still-valid OTP.|Password remains old after step 1; after step 2 it changes and the OTP is invalidated.|STATEFUL_REASONING_GAP|The AI stated that a weak-password failure should not consume the token but did not prove recoverability with a follow-up compliant retry.|API01-AI-018,API01-AI-014|Adds an explicit retry transition with the same OTP, making token preservation after business validation failure observable.|API01-RISK-FAILED-VALIDATION-RECOVERY
003|STATE_TRANSITION|SECURITY|API01-REQ-007,API01-REQ-009|AUTHORITATIVE|Wrong-token failure then correct-token recovery|Verify that submitting a different six-digit token does not invalidate the actually issued token for the email.|A valid OTP is issued for email A|Step 1 submits a different six-digit token; step 2 submits the issued token with a strong password|wrongToken differs from issuedToken while both are six digits|The wrong-token request must not reset the password; the issued token remains eligible for its rightful request.|After step 1 password and issued-token state remain unchanged; after step 2 password changes and issued token is invalidated.|SECURITY_REASONING_GAP|The AI covered wrong-token rejection but did not execute the follow-up correct use needed to verify that an attacker guess cannot consume the real token.|API01-AI-019,API01-AI-014|Adds a recovery step using the real token and validates non-consumption after a wrong guess.|API01-RISK-TOKEN-GUESS-STATE
004|STATE_TRANSITION|SECURITY|API01-REQ-007,API01-REQ-009|AUTHORITATIVE|Independent users' OTP invalidation isolation|Verify that successful use of OTP A invalidates only OTP A and does not invalidate independently issued OTP B.|Users A and B each have a valid issued OTP|Reset A successfully, then reset B using OTP B|Two independent email-token-password fixtures|Each user can reset only with their own token; success for A must not revoke B's independent token.|A password changes and OTP A invalidates first; B remains unchanged/valid until its own successful reset, then OTP B invalidates.|COVERAGE_BLIND_SPOT|The AI checked cross-email misuse and replay but did not cover isolation of two independently valid token lifecycles.|API01-AI-002,API01-AI-015,API01-AI-014|Uses two simultaneously valid owner-bound tokens and verifies invalidation is scoped to the token used.|API01-RISK-CROSS-USER-LIFECYCLE
005|STATE_TRANSITION|SECURITY|API01-REQ-007,API01-REQ-009|AUTHORITATIVE|Replay on user A does not disturb unused token B|Verify that replaying A's already-used OTP is rejected without consuming or altering B's unused OTP.|A and B have valid OTPs;;A has completed a successful reset and OTP A is invalidated|Replay OTP A, then use still-unused OTP B for B|Used OTP A and unused OTP B|A replay must not create a second reset; B's independent legitimate reset must remain possible.|A remains at its first reset state; B changes only on its own request and OTP B then invalidates.|SECURITY_REASONING_GAP|The AI covered replay for one user but did not combine replay handling with isolation of another user's pending reset state.|API01-AI-015,API01-AI-002|Adds a second user's pending token and proves a replay event cannot cause cross-user lifecycle mutation.|API01-RISK-REPLAY-ISOLATION
'@

$api02=@'
001|STATE_TRANSITION|SECURITY,BUSINESS_RULE|API02-REQ-002,API02-REQ-004,API02-REQ-005,API02-REQ-006,API02-REQ-007,API02-REQ-010|AUTHORITATIVE|Unauthorized tampered checkout then authorized recovery|Verify an invalid-JWT checkout with a manipulated total causes no success side effects and does not prevent a later valid checkout of the same cart.|User A has a populated cart;;Prepare invalid and valid JWT fixtures|Step 1 uses invalid JWT and low total; step 2 uses valid JWT against the unchanged cart|cart total=known positive; first client total=1; second body remains untrusted|Step 1 cannot be an authenticated checkout; step 2 uses the backend cart-derived total.|Cart remains populated after step 1 and is cleared only after step 2 succeeds.|STATEFUL_REASONING_GAP|The AI tested authentication failures and valid checkout separately but did not prove cart recoverability across an unauthorized tampered attempt.|API02-AI-002,API02-AI-023,API02-AI-014|Adds a two-request recovery sequence and verifies the same cart survives unauthorized total manipulation before valid checkout.|API02-RISK-AUTH-RECOVERY
002|SECURITY|BUSINESS_RULE,STATE_TRANSITION|API02-REQ-004,API02-REQ-005,API02-REQ-006,API02-REQ-007|AUTHORITATIVE|Identity spoof combined with victim-cart total|Verify JWT A remains the identity authority when payload claims user B and client total equals B's different cart total.|Users A and B have different populated carts;;JWT A is valid|JWT A with unexpected user_id=B and total_amount equal to cart B|cartA total differs from cartB total|Checkout must use authenticated user A and derive total from cart A, not payload identity or cart B's client-matched value.|On success only cart A clears; cart B remains unchanged.|SECURITY_REASONING_GAP|The AI covered user-id spoofing and cross-user total isolation in separate cases but did not combine both attacker-controlled signals.|API02-AI-017,API02-AI-027|Combines spoofed identity and a strategically chosen victim-cart total so both identity and total trust boundaries are tested together.|API02-RISK-COMBINED-IDENTITY-TOTAL
003|SECURITY|BUSINESS_RULE,STATE_TRANSITION|API02-REQ-005,API02-REQ-006,API02-REQ-007,API02-REQ-011|SECURITY_EXPECTATION|Simultaneous total and address injection payloads|Verify total and shipping-address metacharacters remain data while the authoritative total still comes from cart and no unintended database action occurs.|Authenticated user has a populated cart;;Isolated database state can be inspected|total_amount contains expression-like text and shipping_address contains SQL metacharacters in one request|Combined payload plus before/after database snapshot|No input string may execute as a command or become the authoritative total; any successful checkout uses the cart-derived total.|Unrelated database state remains intact; if checkout succeeds the authenticated cart clears.|SECURITY_REASONING_GAP|The AI tested total injection and address injection independently, missing their combined parser/persistence path with the total business invariant.|API02-AI-025,API02-AI-026,API02-AI-034|Exercises both hostile fields in one request and jointly checks parameterized persistence, server total and cart side effect.|API02-RISK-COMBINED-INJECTION
004|STATE_TRANSITION|SECURITY,BUSINESS_RULE|API02-REQ-002,API02-REQ-004,API02-REQ-005,API02-REQ-007,API02-REQ-010|AUTHORITATIVE|Expired JWT then refreshed valid checkout|Verify an expired-token attempt does not consume cart state and a later valid JWT can checkout that same cart.|User has populated cart;;Expired and fresh valid JWT fixtures represent the same user|Step 1 checkout with expired JWT; step 2 checkout with fresh valid JWT|Same documented body for both requests|Expired JWT cannot authorize checkout; fresh JWT checkout uses cart-derived business behavior.|Cart remains populated after expired-token attempt and clears only after the valid checkout succeeds.|CROSS_ENDPOINT_DEPENDENCY|The AI covered expired JWT rejection but did not model authentication refresh/recovery while preserving checkout state.|API02-AI-024,API02-AI-014|Adds a fresh-token retry for the same cart and verifies authorization failure does not destroy later valid business state.|API02-RISK-TOKEN-REFRESH-STATE
005|STATE_TRANSITION|SECURITY,BUSINESS_RULE|API02-REQ-004,API02-REQ-005,API02-REQ-006,API02-REQ-007|AUTHORITATIVE|Two-user sequential checkout with swapped client totals|Verify two users checking out sequentially each use their own cart total even when each client submits the other's total.|Users A and B have different populated carts;;Both JWTs valid|Checkout A with client total equal cart B, then checkout B with client total equal cart A's old total|cartA and cartB totals are distinct and deliberately swapped in bodies|Each checkout must derive total from the authenticated user's current cart, never the swapped client value.|After A succeeds only cart A clears; after B succeeds cart B clears; each order remains user-scoped.|COVERAGE_BLIND_SPOT|The AI tested one-direction cross-user isolation but did not verify bilateral sequential state transitions with swapped trust-boundary values.|API02-AI-017,API02-AI-036|Adds a second authenticated checkout and verifies user/cart isolation in both directions across changing cart states.|API02-RISK-BILATERAL-CART-ISOLATION
'@

$api03=@'
001|SECURITY|STATE_TRANSITION,BUSINESS_RULE|API03-REQ-002,API03-REQ-003,API03-REQ-009|AUTHORITATIVE|Non-admin mixed batch cannot reach persistence|Verify authorization rejects a non-admin before a mixed-validity batch can create any partial product state.|Valid JWT with role=user;;Products snapshot exists|Non-admin JWT with one valid and one invalid product|Valid row plus empty-name row|Non-admin is not authorized to import regardless of row composition.|No row from the batch is persisted.|SECURITY_REASONING_GAP|The AI tested non-admin authorization and mixed-batch atomicity separately, but not precedence of authorization over a batch that could expose partial processing.|API03-AI-026,API03-AI-018|Combines role enforcement with mixed validity and verifies the unauthorized request never reaches persistence side effects.|API03-RISK-AUTH-BEFORE-BATCH
002|SECURITY|STATE_TRANSITION,BUSINESS_RULE|API03-REQ-002,API03-REQ-003,API03-REQ-009|AUTHORITATIVE|Role-tampering payload with invalid batch|Verify body role=admin cannot elevate a user JWT even when the batch itself contains validation errors.|Valid JWT role=user;;Products snapshot exists|JWT user, body role=admin, products contain valid and zero-price rows|Role-tampering field plus mixed-validity products|Role must come from the verified token; payload role and row errors cannot authorize import.|No product is persisted and no partial validation-side effect is allowed.|SECURITY_REASONING_GAP|The AI tested role tampering only with a valid products body and did not combine authorization bypass input with atomicity-sensitive invalid rows.|API03-AI-028,API03-AI-018|Adds mixed validity to the role-escalation attempt and checks authorization/persistence ordering.|API03-RISK-ROLE-BATCH-COMBINATION
003|SECURITY|STATE_TRANSITION,BUSINESS_RULE|API03-REQ-007,API03-REQ-009,API03-REQ-011|SECURITY_EXPECTATION|Injection-like name plus invalid-price rollback|Verify an injection-like non-empty name remains data, while a separate invalid price causes the entire admin batch to roll back.|Admin JWT valid;;Products/database snapshot exists|Row 1 has injection-like non-empty name and positive price; row 2 has valid name and price=0|Two-row mixed batch|The injection-like name must not execute as a command; price=0 is invalid and triggers all-or-nothing rollback.|Neither row is persisted and unrelated database state remains intact.|SECURITY_REASONING_GAP|The AI covered injection input and invalid-row rollback separately, missing their combined transaction/security path.|API03-AI-029,API03-AI-018|Combines parameterized-input resilience with a direct FR-16 validation error and atomic rollback.|API03-RISK-INJECTION-ROLLBACK
004|STATE_TRANSITION|BUSINESS_RULE|API03-REQ-007,API03-REQ-009|AUTHORITATIVE|Committed batch survives later invalid import rollback|Verify atomic rollback is scoped to the current import and does not undo products committed by an earlier valid import.|Admin JWT valid;;Snapshot before both imports|Import valid batch A, then import batch B containing an invalid row|Distinct product identifiers for A and B|Batch A commits fully; batch B fails atomically because of its invalid row.|Products from A remain; no product from B is persisted.|STATEFUL_REASONING_GAP|The AI tested rollback then corrected retry, but not the opposite sequence where a later rollback must preserve an earlier committed transaction.|API03-AI-016,API03-AI-021|Reverses the sequence and checks transaction scope across two imports, not merely within one batch.|API03-RISK-TRANSACTION-SCOPE
005|BUSINESS_RULE|STATE_TRANSITION,SCHEMA|API03-REQ-007,API03-REQ-009,API03-REQ-010|AUTHORITATIVE|Two distinct row errors correlate with report and rollback|Verify a batch with two different invalid rows reports both semantic reasons/counts while committing none of the valid middle row.|Admin JWT valid;;Products snapshot exists|Empty-name row, valid middle row, negative-price row|Three rows with two distinct FR-16 violations|Report semantics reflect two errors and their reasons; any row error requires entire-batch rollback. Exact JSON keys remain unspecified.|No row from the batch is persisted.|COVERAGE_BLIND_SPOT|The AI had multiple-invalid and report cases but did not explicitly correlate two distinct FR-16 violations with report semantics and the valid middle row's rollback.|API03-AI-020,API03-AI-038|Adds a report-to-input correlation assertion for two different invalid reasons while preserving exact-schema agnosticism.|API03-RISK-MULTI-ERROR-REPORT
'@

$definitions = @(
    [ordered]@{ api='API-01'; prefix='API01'; feature='FR-03'; endpoint='POST /api/reset-password'; slug='api-01-reset-password'; rows=(Parse-Rows $api01) },
    [ordered]@{ api='API-02'; prefix='API02'; feature='FR-08'; endpoint='POST /api/checkout'; slug='api-02-checkout'; rows=(Parse-Rows $api02) },
    [ordered]@{ api='API-03'; prefix='API03'; feature='FR-16'; endpoint='POST /api/admin/import-products'; slug='api-03-import-products'; rows=(Parse-Rows $api03) }
)
$jsonDir = Join-Path $WorkspaceRoot 'test-cases\student-added'
$mdDir = Join-Path $WorkspaceRoot 'docs\test-extension'
New-Item -ItemType Directory -Force -Path @($jsonDir,$mdDir) | Out-Null
$previewRows = @()

foreach ($d in $definitions) {
    $rawPath = Join-Path $WorkspaceRoot "test-cases/generated/$($d.slug).json"
    $correctedPath = Join-Path $WorkspaceRoot "test-cases/corrected/$($d.slug).json"
    $raw = Get-Content -LiteralPath $rawPath -Raw | ConvertFrom-Json
    $corrected = Get-Content -LiteralPath $correctedPath -Raw | ConvertFrom-Json
    $rawIds = @($raw.test_cases.id)
    $wrappers = @()
    foreach ($row in $d.rows) {
        foreach ($closest in $row.closest) {
            if ($rawIds -notcontains $closest) { throw "Unknown closest AI case $closest" }
        }
        $id = "$($d.prefix)-STU-$($row.number)"
        $techniques = @($row.primary) + @($row.secondary)
        $auth = if ($d.api -eq 'API-01') { 'NO_JWT_REQUIREMENT_SPECIFIED; use issued email-bound OTP fixtures' } elseif ($d.api -eq 'API-02') { 'Bearer fixtures specified by the sequence' } else { 'Bearer admin/user fixtures specified by the sequence' }
        $case = [ordered]@{
            id=$id; api_id=$d.api; feature_id=$d.feature; endpoint=$d.endpoint; source='STUDENT_ADDED'; lifecycle_state='STUDENT_EXTENSION_CANDIDATE'
            requirement_ids=@($row.refs); technique=$techniques; primary_technique=$row.primary; secondary_techniques=@($row.secondary); oracle_basis=$row.oracle
            gap_ids=@(); risk_ids=@($row.risk); observation_ids=@(); title=$row.title; objective=$row.objective; preconditions=@($row.pre)
            request=[ordered]@{method='POST';path=$d.endpoint.Substring(5);auth_profile=$auth;content_type='application/json';sequence_or_body_variation=$row.request}
            test_data=[ordered]@{description=$row.data;secret_policy='Use disposable isolated fixtures; no real secrets.'}
            expected_status='UNSPECIFIED_BY_AUTHORITATIVE_SOURCE'; expected_schema='UNSPECIFIED_BY_AUTHORITATIVE_SOURCE'; expected_business_result=$row.business; expected_state=$row.state
            audit_status='PENDING_HUMAN_REVIEW'; audit_reason=$null; correction=$null; why_ai_missed=$row.why; execution_status='NOT_IMPLEMENTED'; failure_classification=$null; bug_id=$null
            notes='STUDENT_EXTENSION_CANDIDATE; NOT_HUMAN_APPROVED; NOT_EXECUTED'
        }
        $wrappers += [ordered]@{test_case=$case;closest_ai_cases=@($row.closest);difference_from_ai_generated_suite=$row.difference;why_ai_missed_category=$row.category;why_ai_missed=$row.why;human_review_status='PENDING_HUMAN_REVIEW'}
    }
    if ($wrappers.Count -lt 5) { throw "$($d.api) has fewer than 5 extensions" }
    $fingerprints = @{}
    foreach ($wrapper in $wrappers) {
        $case = $wrapper.test_case
        $fingerprint = (($case.objective+'|'+$case.request.sequence_or_body_variation+'|'+$case.expected_business_result+'|'+$case.expected_state).ToLowerInvariant() -replace '\s+',' ').Trim()
        if ($fingerprints.ContainsKey($fingerprint)) { throw "Duplicate extensions $($fingerprints[$fingerprint]) and $($case.id)" }
        $fingerprints[$fingerprint] = $case.id
        foreach ($rawCase in $raw.test_cases) {
            $rawFingerprint = (($rawCase.objective+'|'+$rawCase.request.body_variation+'|'+$rawCase.expected_business_result+'|'+$rawCase.expected_state).ToLowerInvariant() -replace '\s+',' ').Trim()
            if ($fingerprint -eq $rawFingerprint) { throw "Extension $($case.id) exact semantic fingerprint matches $($rawCase.id)" }
        }
    }
    $deferred = $corrected.summary.incomplete_deferred
    $aiExecutable = $corrected.summary.final_executable_ai_cases
    $preview = $aiExecutable + $wrappers.Count
    $document = [ordered]@{metadata=[ordered]@{api_id=$d.api;status='STUDENT_EXTENSION_REVIEW_REQUIRED';human_review_status='PENDING_HUMAN_REVIEW';minimum_required=5;student_added_count=$wrappers.Count;corrected_executable_ai_cases=$aiExecutable;deferred_requirement_gaps=$deferred;total_executable_preview=$preview;meets_35_case_preview=($preview -ge 35);postman_started=$false};student_cases=$wrappers}
    $document | ConvertTo-Json -Depth 20 | Set-Content -LiteralPath (Join-Path $jsonDir "$($d.slug).json") -Encoding utf8

    $md = [System.Collections.Generic.List[string]]::new()
    $md.Add("# $($d.api) Student Extension Candidates"); $md.Add('')
    $md.Add('- Source: `STUDENT_ADDED`; Human Review: `PENDING_HUMAN_REVIEW`; execution: `NOT_IMPLEMENTED`.')
    $md.Add("- Corrected executable AI cases: **$aiExecutable**; Student-added candidates: **$($wrappers.Count)**; deferred gaps: **$deferred**; executable preview: **$preview**; meets 35: **$($preview -ge 35)**.")
    $md.Add('- These candidates are not committed and are not yet part of a final/Postman suite.')
    foreach ($wrapper in $wrappers) {
        $case=$wrapper.test_case; $md.Add(''); $md.Add("## $($case.id) — $($case.title)"); $md.Add('')
        $md.Add("- Source: ``$($case.source)``; primary: ``$($case.primary_technique)``; secondary: ``$($case.secondary_techniques -join ', ')``")
        $md.Add("- Requirements: ``$($case.requirement_ids -join ', ')``; oracle: ``$($case.oracle_basis)``")
        $md.Add("- Objective: $($case.objective)"); $md.Add("- Preconditions: $($case.preconditions -join '; ')")
        $md.Add("- Request/sequence: $($case.request.sequence_or_body_variation)"); $md.Add("- Test data: $($case.test_data.description)")
        $md.Add('- Expected status/schema: `UNSPECIFIED_BY_AUTHORITATIVE_SOURCE`')
        $md.Add("- Expected business result: $($case.expected_business_result)"); $md.Add("- Expected state: $($case.expected_state)")
        $md.Add("- Closest AI cases: ``$($wrapper.closest_ai_cases -join ', ')``")
        $md.Add("- Difference: $($wrapper.difference_from_ai_generated_suite)")
        $md.Add("- Why AI missed category: ``$($wrapper.why_ai_missed_category)``"); $md.Add("- Why AI missed: $($wrapper.why_ai_missed)")
        $md.Add('- HUMAN_REVIEW_STATUS: `PENDING_HUMAN_REVIEW`')
    }
    $md | Set-Content -LiteralPath (Join-Path $mdDir "$($d.slug)-student-extension.md") -Encoding utf8
    $previewRows += [ordered]@{api=$d.api;final_executable_ai_cases=$aiExecutable;student_added=$wrappers.Count;deferred_requirement_gaps=$deferred;total_executable_preview=$preview;meets_35=($preview -ge 35)}
}

$previewMd = [System.Collections.Generic.List[string]]::new()
$previewMd.Add('# Final Suite Preview Before Student Extension Human Review'); $previewMd.Add('')
$previewMd.Add('| API | Final executable AI cases | Student added | Deferred gaps | Total executable preview | >=35 |')
$previewMd.Add('| --- | ---: | ---: | ---: | ---: | --- |')
foreach ($row in $previewRows) { $previewMd.Add("| ``$($row.api)`` | $($row.final_executable_ai_cases) | $($row.student_added) | $($row.deferred_requirement_gaps) | $($row.total_executable_preview) | ``$($row.meets_35)`` |") }
$previewMd.Add(''); $previewMd.Add('No filler was generated. Every API remains below 35 executable preview cases and requires Human Review before any further coverage decision.')
$previewMd.Add('No Excel, Postman, Newman, SUT execution, or final merge was started.')
$previewMd | Set-Content -LiteralPath (Join-Path $mdDir 'final-suite-preview.md') -Encoding utf8

'STUDENT_EXTENSION_CREATED'
foreach ($row in $previewRows) { "$($row.api):STUDENT_ADDED=$($row.student_added),PREVIEW=$($row.total_executable_preview),MEETS_35=$($row.meets_35)" }
