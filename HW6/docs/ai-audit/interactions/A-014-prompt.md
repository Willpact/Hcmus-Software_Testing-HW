Current HW06 execution recovery is blocked only by local Newman tooling.

Current state:

```text
HW06_EXECUTION_RECOVERY:
BLOCKED

PREVIOUS_PREFLIGHTS:
preflight-001 — PRESERVED
preflight-002 — PRESERVED

STUDENT_ID:
CONFIGURED: YES

CREDENTIALS:
NORMAL_USER: READY
SECOND_USER: READY
ADMIN: READY
RESET_USER: READY

SUT:
PREPARED_NOT_STARTED

START_COMMAND:
node server.js

BASE_URL:
http://localhost:3000

DATABASE:
SQLite
../eshop-sut/backend/database.sqlite

NEWMAN:
UNAVAILABLE

HTML_REPORTER:
UNAVAILABLE

REAL_REQUESTS_EXECUTED:
NO

AUDIT_ENTRY:
A-013 — AUDIT_ENTRY_VERIFIED
```

Use:

```text
postman-api-runner
hw06-api-workflow
log-ai-audit
```

This is a tooling-recovery continuation.

Do not redo requirement analysis, test generation, audit, Student Extension, or Postman generation.

Main objectives:

```text
1. Finalize the current Human tooling-recovery decision
2. Correct blocked-preflight bookkeeping if necessary
3. Resolve Newman entirely inside writable HW6 if possible
4. Resolve a genuine Newman HTML reporter if possible
5. If tooling becomes available, start SUT
6. Run smoke
7. Correct harness-only issues if necessary
8. Run the real 93-case suite
9. Perform legitimate external verification
10. Preserve actual Newman evidence
11. Produce preliminary failure triage
12. Audit the interaction
13. STOP for Human Failure Triage
```

If Newman cannot be installed because external package access is genuinely unavailable, produce a minimal external-install handoff and STOP.

Do not keep retrying the same failing install strategy.

---

# 1. Finalize A-013 Human Decision

Record:

```text
STUDENT_DECISION:
NEWMAN_TOOLING_BLOCK_ACCEPTED

PREVIOUS_PREFLIGHT:
VALID_BLOCKED_PREFLIGHT

ACTION:
ATTEMPT_WRITABLE_LOCAL_TOOLING_RECOVERY

POLICY:
Use an HW6-local npm cache, installation prefix, temp directory,
and node_modules so no write outside HW6 is required.

If external network/package access remains unavailable,
stop with exact Human commands instead of repeated retries.
```

Finalize A-013 or corresponding interaction according to `log-ai-audit`.

Verify it.

Keep:

```text
docs/ai-audit/
```

unstaged.

---

# 2. Correct execution bookkeeping

No SUT request has been executed yet.

Therefore do NOT represent the current state as 93 independent runtime environment defects.

The accurate preflight state is:

```text
FINAL_EXECUTABLE_TESTCASES:
93

EXECUTION_STATE:
BLOCKED_BEFORE_EXECUTION

TESTCASES_EXECUTED:
0

TESTCASES_BLOCKED_BY_PREFLIGHT:
93

ROOT_BLOCKER_COUNT:
1 tooling category
```

The root blocker is currently:

```text
LOCAL_NEWMAN_TOOLING_UNAVAILABLE
```

If existing execution reports currently count:

```text
ENVIRONMENT_DEFECT: 93
```

revise the preflight-only reports to distinguish:

```text
PRE_EXECUTION_BLOCKED:
93

RUNTIME_ENVIRONMENT_DEFECT:
0
```

Do not erase `preflight-001` or `preflight-002`.

Preserve their raw evidence.

This correction is reporting semantics only and must not rewrite historical evidence.

---

# 3. Inspect current npm environment

Record:

```text
node --version
npm --version
npm config get cache
npm config get prefix
```

Inspect whether these exist:

```text
node_modules/.bin/newman
node_modules/newman
package.json
package-lock.json
npm-shrinkwrap.json
```

inside HW6 or a writable relevant project scope.

Also inspect npm cache metadata for any already-cached Newman package.

Do not assume cache absence solely because the previous `--offline` attempt failed.

---

# 4. Create an isolated writable tooling area

Create within HW6:

```text
.tools/
.tools/newman/
.tools/npm-cache/
.tools/npm-prefix/
.tools/tmp/
```

or equivalent repository-local ignored paths.

Ensure these tooling/cache directories are excluded from normal submission/commit where appropriate.

Do not place them under repository `.git`.

Do not change Windows/system-level permissions.

---

# 5. Set writable npm environment only for this operation

Use process-local environment variables or command-specific configuration such as:

```text
npm_config_cache=<HW6>/.tools/npm-cache
npm_config_prefix=<HW6>/.tools/npm-prefix
TEMP=<HW6>/.tools/tmp
TMP=<HW6>/.tools/tmp
```

Do not modify global npm configuration unnecessarily.

Record the effective writable paths.

---

# 6. Tool resolution strategy

Try the following strategies in order.

Stop as soon as one succeeds.

## Strategy A — existing local dependency

If Newman already exists locally:

use it directly.

Expected:

```text
NEWMAN_SOURCE:
EXISTING_LOCAL_DEPENDENCY
```

---

## Strategy B — existing cached package

If a usable cached Newman package is present:

install/use it with the isolated HW6 cache.

Do not access protected global directories.

Expected:

```text
NEWMAN_SOURCE:
LOCAL_NPM_CACHE
```

---

## Strategy C — local online npm install with writable cache

If registry access is available, install Newman into an isolated HW6 tooling directory.

Prefer a command equivalent to:

```bash
npm install \
  --prefix .tools/newman \
  --cache .tools/npm-cache \
  --no-audit \
  --no-fund \
  newman
```

Use correct Windows/Git-Bash path quoting for the current shell.

Do not modify the SUT's production dependency graph unnecessarily.

Prefer isolated tooling over adding Newman to the production backend `package.json`.

After installation verify with the actual local binary, e.g. equivalent to:

```text
.tools/newman/node_modules/.bin/newman --version
```

Use the platform-appropriate `.cmd` path on Windows if necessary.

---

# 7. HTML reporter recovery

After Newman works, resolve a genuine HTML reporter.

First check whether any compatible HTML reporter already exists locally.

If not and registry access is available, install into the same isolated tooling area.

Preferred reporter:

```text
newman-reporter-htmlextra
```

or an already-established repository-compatible Newman HTML reporter.

Example isolated installation:

```bash
npm install \
  --prefix .tools/newman \
  --cache .tools/npm-cache \
  --no-audit \
  --no-fund \
  newman-reporter-htmlextra
```

Do not fabricate an HTML report if installation fails.

---

# 8. Diagnose installation failures precisely

If an install fails, record:

```text
EXIT_CODE
ERROR_CODE
ERROR_MESSAGE
CACHE_PATH
PREFIX_PATH
TEMP_PATH
REGISTRY_REACHABLE:
YES | NO | UNKNOWN
```

Distinguish:

```text
FILESYSTEM_PERMISSION
NETWORK_UNAVAILABLE
REGISTRY_DENIED
PACKAGE_NOT_CACHED
DEPENDENCY_RESOLUTION
OTHER
```

Do not call every npm failure `EACCES` generically.

---

# 9. Retry limit

Do not repeatedly run the same installation command.

Maximum:

```text
1 attempt per materially distinct recovery strategy
```

Once local-cache and writable-registry strategies have both genuinely failed, stop tooling retries.

---

# 10. External tooling handoff if sandbox still blocks Newman

If Newman still cannot be obtained:

create:

```text
docs/runtime/newman-tooling-install-manifest.md
```

containing exact commands for Human to run from:

```text
D:\Workspace\HCMUS\Software Testing\Homework\Hcmus-Software_Testing-HW\HW6
```

Prefer Git Bash-compatible commands and also include PowerShell equivalents if path behavior differs.

The manifest must install tooling locally in HW6, not globally.

Recommended target:

```text
.tools/newman/
```

Include commands equivalent to:

```bash
mkdir -p .tools/npm-cache .tools/newman .tools/tmp

npm install \
  --prefix .tools/newman \
  --cache .tools/npm-cache \
  --no-audit \
  --no-fund \
  newman \
  newman-reporter-htmlextra
```

Then verify with an appropriate Windows command equivalent to:

```text
.tools/newman/node_modules/.bin/newman.cmd --version
```

Also provide the exact command Agent should use after Human installation.

Do not require a global Newman install.

---

# 11. If Human tooling handoff is required

Return:

```text
NEWMAN_TOOLING_RECOVERY:
BLOCKED_FOR_EXTERNAL_INSTALL

ONLY_BLOCKER:
SANDBOX_PACKAGE_INSTALL_RESTRICTION

INSTALL_MANIFEST:
docs/runtime/newman-tooling-install-manifest.md

READY_AFTER_INSTALL:
STUDENT_ID: YES
CREDENTIALS: YES
SUT_STARTUP: READY
POSTMAN_COLLECTION: READY
FINAL_CASES: 93
```

Audit the interaction and STOP.

Do not start SUT if Newman remains unavailable solely to leave an idle background process.

Do not execute any assignment API request.

---

# 12. Continue automatically if Newman becomes available

If Newman is successfully resolved, do NOT stop for another tooling checkpoint.

Continue directly through:

```text
SUT START
↓
SMOKE
↓
HARNESS TRIAGE if required
↓
FULL NEWMAN RUN
↓
EXTERNAL VERIFICATION
↓
PRELIMINARY FAILURE TRIAGE
↓
HUMAN REVIEW CHECKPOINT
```

---

# 13. Record tool versions

Require:

```text
NEWMAN_AVAILABLE:
YES

NEWMAN_VERSION:
<actual version>

HTML_REPORTER:
<actual reporter/version>
```

If Newman works but HTML reporter does not:

full execution may still proceed with real JSON/JUnit evidence only if doing so is useful,
but final status must explicitly report:

```text
HTML_REPORT_PENDING_TOOLING:
YES
```

Do not synthesize HTML.

Prefer resolving both before full execution.

---

# 14. Start the prepared SUT

Only after required tooling is ready.

Use the documented SUT startup procedure:

```text
node server.js
```

from the correct backend directory.

Record:

```text
SUT_WORKDIR
SUT_START_COMMAND
SUT_PID
SUT_STDOUT
SUT_STDERR
```

Wait for:

```text
http://localhost:3000
```

to become ready.

Verify that port 3000 belongs to the intended EShop SUT.

---

# 15. Do not modify production code

If startup produces an application error:

diagnose it.

Do not patch production behavior without Human approval.

Configuration/harness-only correction is allowed.

---

# 16. Runtime preflight-003

Create:

```text
preflight-003
```

only after Newman/tooling is available.

Verify:

```text
studentId configured
runtime environment exists
normal user strategy ready
second user strategy ready
admin ready
reset user strategy ready
Newman ready
HTML reporter ready or explicitly limited
SUT ready
SQLite local test DB confirmed
103/103 SUT requests resolve non-empty X-Student-Id
```

Do not reveal the Student ID value unnecessarily.

---

# 17. Smoke execution

Run:

```text
smoke-001
```

or the next unused smoke ID.

Must exercise actual SUT requests.

Cover:

```text
API-01:
valid reset setup + reset flow

API-02:
login + cart setup + one checkout flow

API-03:
admin login + one import flow
```

Preserve genuine output.

---

# 18. Smoke failure triage

Classify smoke issues as:

```text
HARNESS_DEFECT
TEST_DATA_DEFECT
ENVIRONMENT_DEFECT
PRODUCT_DEFECT_CANDIDATE
```

Harness-only fixes may be applied.

Every harness fix must be documented.

Never weaken a legitimate oracle.

---

# 19. Full execution

Only after harness smoke is usable.

Execute:

```text
93 testcase identities
```

against:

```text
http://localhost:3000
```

using the approved runtime environment.

Preserve all helpers and testcase mappings.

---

# 20. Required Newman evidence

Create a real run directory:

```text
test-results/hw06/run-001/
```

or next valid ID.

Preserve:

```text
newman.json
newman.html
stdout.log
stderr.log
execution-metadata.md
```

If the selected reporter generates a different filename, preserve and report its actual path.

Do not fabricate any artifact.

---

# 21. Newman command must be reproducible

Record the exact command.

It must use the local Newman executable explicitly if tooling is isolated.

For example conceptually:

```text
<local-newman> run <collection>
-e <runtime-env>
-r cli,json,htmlextra
--reporter-json-export <path>
--reporter-htmlextra-export <path>
```

Use actual reporter syntax supported by installed versions.

Do not copy example flags without verifying them.

---

# 22. Test data handling

Use the approved data/setup architecture.

Do not accidentally run all three API data files as a Cartesian product over the full collection.

If data-driven execution is folder/API scoped, preserve that scoping.

Verify final Newman testcase identities remain exactly:

```text
93
```

not multiplied unexpectedly.

---

# 23. All testcases accounted for

Report:

```text
API-01: 30
API-02: 30
API-03: 33
TOTAL: 93
```

Each one:

```text
PASS
FAIL
POSTMAN_PASS_EXTERNAL_PENDING
BLOCKED
NOT_RUN
```

---

# 24. External verification

Current plan:

```text
26 cases
```

Perform real external verification only through legitimate local test access.

SQLite read-only verification is allowed where appropriate.

Do not mutate DB directly to make test outcomes pass.

---

# 25. External verification outcomes

Use:

```text
PASS
FAIL
PENDING
BLOCKED
```

Do not transform:

```text
POSTMAN success + external pending
```

into final PASS.

---

# 26. Preliminary failure classification

Use:

```text
PRODUCT_DEFECT_CANDIDATE
TEST_DEFECT
TEST_DATA_DEFECT
ENVIRONMENT_DEFECT
SPEC_AMBIGUITY
EXTERNAL_VERIFICATION_PENDING
NEEDS_HUMAN_REVIEW
```

Final:

```text
PRODUCT_DEFECT
```

is forbidden in this phase.

---

# 27. Correct preflight vs runtime terminology

If Newman/tooling blocks execution:

```text
PRE_EXECUTION_BLOCKED
```

Do not call 93 cases actual runtime environment defects.

If Newman run begins and a runtime infrastructure issue blocks cases, then `ENVIRONMENT_DEFECT` may be appropriate.

Keep these concepts separate.

---

# 28. Failure candidate packet

If meaningful runtime candidates exist, create:

```text
docs/execution-results/failure-triage-packet.md
```

Include real evidence only.

No GitHub Issues yet.

---

# 29. Production code policy

Do not modify:

```text
server.js
database.js
database schema
business logic
```

to satisfy tests.

Testing only.

---

# 30. Git permission policy

The `.git` permission issue remains separate.

Do not retry Git write operations repeatedly.

Do not let it block Newman/SUT execution.

Keep:

```text
GIT_CHECKPOINT_STATUS:
PENDING_EXTERNAL_GIT_PERMISSION
```

unless an actual external Human commit has since occurred.

---

# 31. No CI/CD yet

Do not start CI/CD.

---

# 32. No final Excel yet

Do not create the final Excel workbook.

---

# 33. Audit current interaction

Whether tooling succeeds or remains externally blocked, use:

```text
log-ai-audit
```

Record:

```text
exact prompt
exact substantive output
human tooling-recovery decision
local npm paths
install strategies attempted
install failure reasons
Newman version if available
HTML reporter version if available
SUT startup if performed
preflight/smoke/run IDs
runtime outcomes
artifact paths
```

Do not log secrets.

Verify entry.

Audit files remain unstaged.

---

# 34. Self-review when execution proceeds

Verify:

```text
[ ] preflight-001 preserved
[ ] preflight-002 preserved
[ ] previous 93 ENVIRONMENT_DEFECT wording corrected to pre-execution blocked where applicable

[ ] Newman uses writable local installation
[ ] no global/system permission weakening
[ ] Newman version verified
[ ] HTML reporter genuine

[ ] SUT started only after tooling readiness
[ ] preflight-003 completed
[ ] runtime X-Student-Id coverage verified

[ ] smoke actually executed
[ ] harness fixes documented

[ ] full run genuine
[ ] 93 testcase identities accounted for
[ ] no accidental data-file multiplication

[ ] Newman JSON genuine
[ ] Newman HTML genuine
[ ] stdout/stderr genuine

[ ] 26 external cases accounted for
[ ] external pending cases not falsely PASS

[ ] no final PRODUCT_DEFECT
[ ] no product code modifications
[ ] no GitHub Issues
[ ] no CI/CD
[ ] no final Excel

[ ] audit entry verified
[ ] audit files unstaged
```

---

# 35. Final output — tooling resolved and execution performed

Return:

```text
NEWMAN_TOOLING_RECOVERY_AND_EXECUTION:
PASS | PARTIAL | FAIL

TOOLING:

NEWMAN_SOURCE:
EXISTING_LOCAL_DEPENDENCY |
LOCAL_NPM_CACHE |
LOCAL_REGISTRY_INSTALL

NEWMAN_VERSION:
...

HTML_REPORTER:
...

NPM_CACHE:
...

INSTALL_PREFIX:
...

PREFLIGHT_CORRECTION:

PREVIOUS_PRE_EXECUTION_BLOCKED:
93

PREVIOUS_RUNTIME_ENVIRONMENT_DEFECTS:
0

RECOVERY_PREFLIGHT:
preflight-003

SUT:
STATUS:
START_COMMAND:
BASE_URL:

SMOKE:
RUN_ID:
STATUS:
HARNESS_CORRECTIONS:

FULL_EXECUTION:
RUN | NOT_RUN

RUN_ID:

FINAL_EXECUTABLE_TESTCASES:
93

RESULTS:

API_01:
TOTAL: 30
PASS:
FAIL:
POSTMAN_PASS_EXTERNAL_PENDING:
BLOCKED:
NOT_RUN:

API_02:
TOTAL: 30
PASS:
FAIL:
POSTMAN_PASS_EXTERNAL_PENDING:
BLOCKED:
NOT_RUN:

API_03:
TOTAL: 33
PASS:
FAIL:
POSTMAN_PASS_EXTERNAL_PENDING:
BLOCKED:
NOT_RUN:

TOTAL:
TOTAL: 93
PASS:
FAIL:
POSTMAN_PASS_EXTERNAL_PENDING:
BLOCKED:
NOT_RUN:

EXTERNAL_VERIFICATION:
PLANNED: 26
COMPLETED:
PASSED:
FAILED:
PENDING:
BLOCKED:

PRELIMINARY_CLASSIFICATION:

PRODUCT_DEFECT_CANDIDATE:
TEST_DEFECT:
TEST_DATA_DEFECT:
ENVIRONMENT_DEFECT:
SPEC_AMBIGUITY:
EXTERNAL_VERIFICATION_PENDING:
NEEDS_HUMAN_REVIEW:

PRODUCT_DEFECT_FINAL:
0

EVIDENCE:

NEWMAN_JSON:
...

NEWMAN_HTML:
...

STDOUT:
...

STDERR:
...

FAILURE_TRIAGE_PACKET:
...

REAL_REQUESTS_EXECUTED:
YES

X_STUDENT_ID_RUNTIME_COVERAGE:
<n>/<n>

PRODUCTION_CODE_MODIFIED:
NO

GITHUB_ISSUES_CREATED:
0

CI_CD_STARTED:
NO

FINAL_EXCEL_CREATED:
NO

GIT_CHECKPOINT_STATUS:
PENDING_EXTERNAL_GIT_PERMISSION

AUDIT_ENTRY:
<id> — AUDIT_ENTRY_VERIFIED

AUDIT_FILES_STAGED:
NO

BLOCKERS:
<none or list>

NEXT_CHECKPOINT:
HW06_EXECUTION_FAILURE_TRIAGE_REQUIRED
```

---

# 36. Final output — sandbox cannot install tooling

If all legitimate local-install strategies fail, return only:

```text
NEWMAN_TOOLING_RECOVERY:
BLOCKED_FOR_EXTERNAL_INSTALL

STUDENT_ID:
READY

CREDENTIALS:
READY

SUT:
PREPARED

POSTMAN_SUITE:
READY

FINAL_EXECUTABLE_TESTCASES:
93

ROOT_BLOCKER:
SANDBOX_PACKAGE_INSTALL_RESTRICTION

INSTALL_MANIFEST:
docs/runtime/newman-tooling-install-manifest.md

LOCAL_INSTALL_TARGET:
.tools/newman/

REAL_REQUESTS_EXECUTED:
NO

PRE_EXECUTION_BLOCKED:
93

RUNTIME_ENVIRONMENT_DEFECTS:
0

AUDIT_ENTRY:
<id> — AUDIT_ENTRY_VERIFIED

NEXT_CHECKPOINT:
NEWMAN_EXTERNAL_INSTALL_REQUIRED
```

Then STOP.

Do not retry installation again until Human confirms tooling was installed externally.
