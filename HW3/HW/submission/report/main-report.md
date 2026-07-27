# HW03 - GUI and Usability Testing

> Working report. It is not submission-ready until the student identity, human
> review, GitHub issues, pilot, seven real sessions, cross-platform screenshots,
> AI Critique, signatures, and video links are complete.

## Student information

| Field | Value |
|---|---|
| Student name | TODO |
| Student ID | TODO - existing workspace artifacts suggest `23127107`; confirm before use |
| Class / Cohort | TODO |
| Assignment | HW03-AI - GUI and Usability Testing |
| Date | 2026-07-28 |
| SUT | EShop |

## 1. Scope and objectives

### GUI scope

The executed GUI checklist covers the connected web purchase screens:

```text
Home/Search -> Product Detail -> Cart -> Login -> Checkout
```

The scope was selected to exercise all four interface aspects:

- IA-01: general UI standards
- IA-02: forms
- IA-03: navigation
- IA-04: feedback/state

The student must confirm that the primary screen selection is not duplicated by
another member of the class group.

### Usability flow

The prepared moderated scenario is:

```text
First-time account creation -> find iPhone 15 Pro Max -> add one item
-> use SAVE10 -> complete Checkout
```

The study is designed for one separate pilot and seven real participants outside
HW03. No participant data or results have been fabricated.

## 2. AI-first and human-review method

Codex produced a 48-item initial checklist from the assignment and SUT
requirements. Twelve additional items were prepared as `Student-review
candidate`, covering dark mode, RTL, reflow, target size, assistive-technology
feedback, search injection, network/not-found states, and cross-screen state.

The 12 candidates are not represented as student-authored. Before submission,
the student must:

1. review and accept, reject, or rewrite every candidate;
2. change accepted items to `Student-added`;
3. keep or correct the “Why AI missed it” explanation;
4. document at least one rejected or corrected AI suggestion.

During automation review, two AI mistakes were already found and corrected:

- a `hover:underline` CSS class was initially misread as an active-navigation
  indicator;
- a 44x44 target heuristic was replaced with the applicable WCAG 2.2 minimum
  check and a separate 320 CSS-pixel reflow check.

These corrections demonstrate why raw AI output cannot be submitted without
review.

## 3. Task 1 - GUI checklist execution

### Execution environment

| Item | Value |
|---|---|
| Date/time | 2026-07-28 (Asia/Ho_Chi_Minh); raw UTC timestamp is in JSON |
| Browser | Microsoft Edge / Chromium 150.0.4078.99 |
| Desktop viewport | 1440x900 |
| Mobile viewport | 320x568 |
| Frontend | `http://127.0.0.1:5173` |
| Isolated test backend | `http://127.0.0.1:3001` |
| Execution tool | Playwright |

The test backend used port 3001 to avoid interfering with a different local
service already listening on port 3000. Browser requests to the SUT's hard-coded
port 3000 were redirected only inside Playwright test contexts.

### Results

| Aspect | Total | Passed | Failed |
|---|---:|---:|---:|
| IA-01 | 16 | 7 | 9 |
| IA-02 | 20 | 5 | 15 |
| IA-03 | 14 | 7 | 7 |
| IA-04 | 10 | 1 | 9 |
| **Total** | **60** | **20** | **40** |

The full checklist, notes, and evidence links are in:

- `task1-gui-checklist/gui-checklist.md`
- `task1-gui-checklist/gui-checklist-results.json`
- `task1-gui-checklist/evidence/`

### Important observed failures

The observations below are raw test facts, not final student-authored bug
descriptions:

- Login is headed “Đăng Ký”, uses English labels, and renders both email and
  password as visible text fields.
- Required markers and programmatic label associations are missing.
- Quantity does not declare `min=1` or `step=1`; zero, negative, fractional, and
  blank values create invalid cart states.
- The first Product Detail add-to-cart activation is ignored.
- Adding the same Home product twice creates duplicate rows instead of increasing
  quantity.
- Cart state is lost after reload and remains after a simulated successful
  Checkout.
- Home search feedback creates an HTML element from supplied markup.
- Cart has no breadcrumb or item-count badge; unknown routes render blank
  content.
- Home provides no visible loading or friendly network-error state.
- Product image content collapses on the tested mobile viewport.

The student must manually reproduce confirmed defects and write the GitHub issue
narratives in `task1-gui-checklist/student-bug-issue-index.md`.

## 4. Task 2 - Usability evaluation

### Prepared artifacts

- study objectives and research questions;
- participant profile and recruitment conditions;
- realistic goal-oriented scenario;
- moderator/consent script and neutral prompts;
- SUS questionnaire and scoring rules;
- clarity, error recovery, speed, and trust probes;
- separate P00 pilot log;
- observation forms for P01-P07;
- private participant-data boundary;
- strict SUS/session analysis script.

### Current evidence status

| Requirement | Status |
|---|---|
| Pilot | Not conducted |
| Seven real participants | Not recruited/recorded in supplied workspace |
| Seven recordings | Missing |
| SUS responses | Blank |
| Observation notes | Blank |
| Severity-ranked findings | Awaiting real data |

`automation/analyze-usability.cjs` refuses to calculate while any required
response or metric is blank. This prevents incomplete templates from being
mistaken for evidence.

## 5. Task 3 - Cross-browser / cross-platform

The qualifying three-platform execution is not complete. Edge/Chromium evidence
from Task 1 is only preliminary.

The prepared matrix is:

1. Google Chrome on Windows 11.
2. Mozilla Firefox on Windows or macOS.
3. Android Chrome on a real/cloud device.

Safari or Expo Go can replace the third platform when executed according to the
assignment. Each real screenshot must show the platform/device, local URL or
tunnel equivalent, and:

```text
FULL NAME | StudentID@hcmus.edu.vn
```

See `task3-cross-platform/cross-platform-plan.md`.

## 6. Agent Skill

The repo-local explicit skill is stored at:

```text
.codex/skills/gui-usability-evaluator/
```

It provides:

- the GUI/usability workflow;
- evidence and anti-fabrication boundaries;
- SUS analysis rules;
- submission completeness checks;
- `validate_submission.py`.

The skill passed structural validation. An end-to-end YouTube demonstration is
still required for Agent Skill credit.

## 7. Limitations and remaining human work

This report intentionally does not claim:

- genuine participant recruitment or consent;
- usability results, quotations, timings, or scores;
- three qualifying platform runs;
- student review of the checklist;
- student-written GitHub issue descriptions;
- a student-authored 200-300 word AI Critique;
- signatures or demo videos.

Those items require the student's direct work and cannot be replaced by AI.

## 8. References

1. HW03-AI - GUI and Usability Testing assignment, 2026.
2. EShop System Requirements Specification, version 2.0, 2026-05-14.
3. Brooke, J. (1996). *SUS: A quick and dirty usability scale*.
   https://hci-studies.org/methods-and-measures/downloads/SUS_Brooke1996.pdf
4. W3C. *Web Content Accessibility Guidelines (WCAG) 2.2*.
   https://www.w3.org/TR/WCAG22/
5. W3C. *ARIA19: Using ARIA role=alert or Live Regions to Identify Errors*.
   https://www.w3.org/WAI/WCAG22/Techniques/aria/ARIA19
6. BrowserStack. *Test in local environments with Live*.
   https://www.browserstack.com/docs/live/local-testing

## Mandatory disclosure

> The GUI checklist, automation scripts, usability study templates, analysis
> harness, report structure, and Agent Skill were initially generated by OpenAI
> Codex. I reviewed and modified **TODO: identify exact sections**, added **TODO:
> student-added edge cases**, and wrote the final bug reports and AI Critique
> entirely by myself. The detailed AI Audit Report is attached as Appendix A. I
> confirm I did not use AI to generate any artifact listed in the prohibited
> category.

The student must replace every TODO and sign the disclosure before submission.
