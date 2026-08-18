$ErrorActionPreference = 'Stop'
$collection = [ordered]@{ info=@{name='TEST-ONLY smoke collection'; schema='https://schema.getpostman.com/json/collection/v2.1.0/collection.json'}; item=@([ordered]@{name='SMOKE-PM-001';request=@{method='GET';header=@(@{key='X-Student-Id';value='{{studentId}}'},@{key='Authorization';value='Bearer {{token}}'});url='{{baseUrl}}/synthetic'};event=@(@{listen='test';script=@{exec=@("pm.test('status', function () { pm.response.to.have.status(200); });","pm.test('schema', function () { pm.expect(pm.response.json()).to.have.property('id'); });")}})}) }
$headers = $collection.item[0].request.header
$studentHeader = $headers | Where-Object { $_.key -eq 'X-Student-Id' }
if (@($studentHeader).Count -ne 1 -or $studentHeader.value -ne '{{studentId}}') { throw 'Student header variable mechanism invalid.' }
if (($collection.item[0].event[0].script.exec -join "`n") -notmatch 'pm\.test') { throw 'Post-response test script missing.' }
$syntheticExecutionFixture = @{ executed=$false; classification='REAL_EXECUTION_REQUIRED'; source='TEST-ONLY fixture' }
if ($syntheticExecutionFixture.executed -or $syntheticExecutionFixture.classification -ne 'REAL_EXECUTION_REQUIRED') { throw 'Execution fixture boundary invalid.' }
Write-Output 'PASS: synthetic collection has variable-based X-Student-Id, Bearer variable, and post-response scripts; synthetic fixture parsing returns REAL_EXECUTION_REQUIRED. Newman/SUT was not run.'
