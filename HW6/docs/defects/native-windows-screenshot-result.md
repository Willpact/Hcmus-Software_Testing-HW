# HW06 native Windows screenshot result

## Human closure decision

- SCREENSHOT_CAPTURE_METHOD: `MANUAL_BY_STUDENT`
- SCREENSHOT_AUTOMATION: `CLOSED`
- CONTENT_WORKFLOW_BLOCKED_BY_SCREENSHOTS: `NO`
- HISTORICAL_EXPECTED_NEWMAN_SCREENSHOTS: `9`
- CURRENT_TOTAL_SCREENSHOT_COUNT: `NOT_FIXED — see screenshot-capture-plan.md`
- CURRENT_SCREENSHOTS: `0`
- PENDING_HUMAN_CAPTURE: `9`
- FURTHER_BROWSER_RECOVERY_ALLOWED: `NO`

The failed native-browser recovery below is preserved as historical execution evidence. The historical attempt targeted one Newman image per defect; it does not define the current total evidence screenshot count. Human has closed all further automated screenshot attempts; pending manual evidence capture no longer blocks GitHub Issue content preparation.

## Session probe

- INTERACTIVE_WINDOWS_DESKTOP: `YES`
- CURRENT_SESSION_ID: `1`
- EXPLORER_SAME_SESSION: `YES`
- INPUT_DESKTOP_OPENED: `YES`
- WINDOW_STATION_VISIBLE: `YES`
- WINDOWS_SCREENS_DETECTED: `2`
- FIREFOX_EXECUTABLE: `C:\Program Files\Mozilla Firefox\firefox.exe`
- FIREFOX_VISIBLE_WINDOW: `NO`
- FIREFOX_PROCESS_STATE: `24 processes observed in session 1; zero visible top-level windows and zero nonzero MainWindowHandle values`
- CHROME_EXECUTABLE: `NOT_FOUND`
- EDGE_EXECUTABLE: `C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe`
- EDGE_RECOVERY_PROFILE: `test-results/hw06/runtime/native-browser-profile/`
- EDGE_RECOVERY_EXIT_CODE: `21`
- EDGE_VISIBLE_WINDOW: `NO`
- CHROMIUM_EXECUTABLE: `NOT_FOUND`
- BROWSER_SELECTED: `NONE`
- BROWSER_WINDOW_CREATED: `NO`
- BROWSER_AUTOMATION_FRAMEWORK_USED: `NO`
- CAPTURE_METHOD: `UNAVAILABLE`

Browser recovery followed the required order and used direct executable paths only. Firefox was found and started against the real run-001 `file:///` report, but all observed Firefox processes had `MainWindowHandle = 0` and Win32 enumeration found no visible top-level Firefox window. Chrome was not found. Edge was then launched once with a fresh workspace runtime profile at `test-results/hw06/runtime/native-browser-profile/`; the starter process exited with code `21`, no `msedge` process remained, and Win32 enumeration found no visible Edge window. Chromium was not found. Because no usable real browser window existed, no keyboard navigation, `CopyFromScreen`, PNG capture, file-association fallback, or synthetic rendering was performed.

## Results

### DEF-01

- DEFECT_ID: `DEF-01`
- CASE_ID: `API02-AI-002`
- SOURCE_REPORT: `test-results/hw06/run-001/newman.html`
- BROWSER: `NONE — Firefox produced no visible top-level window; Edge recovery exited with code 21`
- WINDOW_TITLE: `NONE`
- CAPTURE_METHOD: `UNAVAILABLE`
- SCREENSHOT_PATH: `docs/defects/screenshots/DEF-01-API02-AI-002-newman.png`
- FILE_SIZE: `0 — file not created`
- DIMENSIONS: `N/A`
- CASE_VISIBLE: `NO`
- SECRET_CHECK: `NOT_APPLICABLE — no pixels captured`
- STATUS: `PENDING_HUMAN_CAPTURE`

### DEF-02

- DEFECT_ID: `DEF-02`
- CASE_ID: `API02-AI-014`
- SOURCE_REPORT: `test-results/hw06/run-001/newman.html`
- BROWSER: `NONE — Firefox produced no visible top-level window; Edge recovery exited with code 21`
- WINDOW_TITLE: `NONE`
- CAPTURE_METHOD: `UNAVAILABLE`
- SCREENSHOT_PATH: `docs/defects/screenshots/DEF-02-API02-AI-014-newman.png`
- FILE_SIZE: `0 — file not created`
- DIMENSIONS: `N/A`
- CASE_VISIBLE: `NO`
- SECRET_CHECK: `NOT_APPLICABLE — no pixels captured`
- STATUS: `PENDING_HUMAN_CAPTURE`

### DEF-03

- DEFECT_ID: `DEF-03`
- CASE_ID: `API02-AI-022`
- SOURCE_REPORT: `test-results/hw06/run-001/newman.html`
- BROWSER: `NONE — Firefox produced no visible top-level window; Edge recovery exited with code 21`
- WINDOW_TITLE: `NONE`
- CAPTURE_METHOD: `UNAVAILABLE`
- SCREENSHOT_PATH: `docs/defects/screenshots/DEF-03-API02-AI-022-newman.png`
- FILE_SIZE: `0 — file not created`
- DIMENSIONS: `N/A`
- CASE_VISIBLE: `NO`
- SECRET_CHECK: `NOT_APPLICABLE — no pixels captured`
- STATUS: `PENDING_HUMAN_CAPTURE`

### DEF-04

- DEFECT_ID: `DEF-04`
- CASE_ID: `API03-AI-009`
- SOURCE_REPORT: `test-results/hw06/run-001/newman.html`
- BROWSER: `NONE — Firefox produced no visible top-level window; Edge recovery exited with code 21`
- WINDOW_TITLE: `NONE`
- CAPTURE_METHOD: `UNAVAILABLE`
- SCREENSHOT_PATH: `docs/defects/screenshots/DEF-04-API03-AI-009-newman.png`
- FILE_SIZE: `0 — file not created`
- DIMENSIONS: `N/A`
- CASE_VISIBLE: `NO`
- SECRET_CHECK: `NOT_APPLICABLE — no pixels captured`
- STATUS: `PENDING_HUMAN_CAPTURE`

### DEF-05

- DEFECT_ID: `DEF-05`
- CASE_ID: `API03-AI-017`
- SOURCE_REPORT: `test-results/hw06/run-001/newman.html`
- BROWSER: `NONE — Firefox produced no visible top-level window; Edge recovery exited with code 21`
- WINDOW_TITLE: `NONE`
- CAPTURE_METHOD: `UNAVAILABLE`
- SCREENSHOT_PATH: `docs/defects/screenshots/DEF-05-API03-AI-017-newman.png`
- FILE_SIZE: `0 — file not created`
- DIMENSIONS: `N/A`
- CASE_VISIBLE: `NO`
- SECRET_CHECK: `NOT_APPLICABLE — no pixels captured`
- STATUS: `PENDING_HUMAN_CAPTURE`

### DEF-06

- DEFECT_ID: `DEF-06`
- CASE_ID: `API03-AI-026`
- SOURCE_REPORT: `test-results/hw06/run-001/newman.html`
- BROWSER: `NONE — Firefox produced no visible top-level window; Edge recovery exited with code 21`
- WINDOW_TITLE: `NONE`
- CAPTURE_METHOD: `UNAVAILABLE`
- SCREENSHOT_PATH: `docs/defects/screenshots/DEF-06-API03-AI-026-newman.png`
- FILE_SIZE: `0 — file not created`
- DIMENSIONS: `N/A`
- CASE_VISIBLE: `NO`
- SECRET_CHECK: `NOT_APPLICABLE — no pixels captured`
- STATUS: `PENDING_HUMAN_CAPTURE`

### DEF-07

- DEFECT_ID: `DEF-07`
- CASE_ID: `API01-AI-007`
- SOURCE_REPORT: `test-results/hw06/run-002/newman.html`
- BROWSER: `NONE — Firefox produced no visible top-level window; Edge recovery exited with code 21`
- WINDOW_TITLE: `NONE`
- CAPTURE_METHOD: `UNAVAILABLE`
- SCREENSHOT_PATH: `docs/defects/screenshots/DEF-07-API01-AI-007-newman.png`
- FILE_SIZE: `0 — file not created`
- DIMENSIONS: `N/A`
- CASE_VISIBLE: `NO`
- SECRET_CHECK: `NOT_APPLICABLE — no pixels captured`
- STATUS: `PENDING_HUMAN_CAPTURE`

### DEF-08

- DEFECT_ID: `DEF-08`
- CASE_ID: `API01-AI-018`
- SOURCE_REPORT: `test-results/hw06/run-002/newman.html`
- BROWSER: `NONE — Firefox produced no visible top-level window; Edge recovery exited with code 21`
- WINDOW_TITLE: `NONE`
- CAPTURE_METHOD: `UNAVAILABLE`
- SCREENSHOT_PATH: `docs/defects/screenshots/DEF-08-API01-AI-018-newman.png`
- FILE_SIZE: `0 — file not created`
- DIMENSIONS: `N/A`
- CASE_VISIBLE: `NO`
- SECRET_CHECK: `NOT_APPLICABLE — no pixels captured`
- STATUS: `PENDING_HUMAN_CAPTURE`

### DEF-09

- DEFECT_ID: `DEF-09`
- CASE_ID: `API01-AI-035`
- SOURCE_REPORT: `test-results/hw06/run-002/newman.html`
- BROWSER: `NONE — Firefox produced no visible top-level window; Edge recovery exited with code 21`
- WINDOW_TITLE: `NONE`
- CAPTURE_METHOD: `UNAVAILABLE`
- SCREENSHOT_PATH: `docs/defects/screenshots/DEF-09-API01-AI-035-newman.png`
- FILE_SIZE: `0 — file not created`
- DIMENSIONS: `N/A`
- CASE_VISIBLE: `NO`
- SECRET_CHECK: `NOT_APPLICABLE — no pixels captured`
- STATUS: `PENDING_HUMAN_CAPTURE`

## Totals

- NATIVE_BROWSER_RECOVERY: `FAILED`
- INSTALLED_BROWSERS_FOUND: `[Firefox, Microsoft Edge]`
- VISIBLE_BROWSER_WINDOW: `NO`
- ROOT_CAUSE: `GUI_BROWSER_LAUNCH_RESTRICTED_BY_AGENT_RUNTIME`
- HISTORICAL_NEWMAN_CAPTURE_TARGET: `9`
- CURRENT_EVIDENCE_CAPTURE_TARGET: `1 NEWMAN + 8 BOTH; image count not fixed`
- CAPTURED: `0`
- PENDING_HUMAN_CAPTURE: `9`
- BLANK_OR_INVALID_CAPTURES: `0`
- SECRET_EXPOSURE_REJECTED: `0`
- EVIDENCE_MATRIX_UPDATED_AFTER_THIS_HISTORICAL_ATTEMPT: `YES — current matrix distinguishes NEWMAN and EXTERNAL evidence`
- DEFECT_REPORTS_UPDATED: `0/9`
- ISSUE_CONTENT_READY: `9/9`
- SCREENSHOT_READY: `0/9`
- READY_FOR_FINAL_GITHUB_SUBMISSION: `0/9`
- NEWMAN_RERUN: `NO`
- PRODUCTION_CODE_MODIFIED: `NO`
- AI_AUDIT_USED: `NO`
