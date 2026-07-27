# HW03 GUI and Usability Method

## GUI checklist contract

Use at least 41 meaningful, non-repetitive rows and cover:

- IA-01: general UI standards
- IA-02: forms
- IA-03: navigation
- IA-04: feedback and state

Recommended columns:

```text
ID | Screen | Aspect | Checklist item | Expected result | Source
| Why AI missed it | Status | Notes | Evidence | Bug/Issue
```

Keep `Source=AI draft` until a human actually reviews the item. For each
student-added item, preserve a concrete explanation of why the AI missed it.

## Runtime evidence

- Execute every row.
- Record Passed or Failed.
- Add a reason for every failure.
- Store screenshots only for failures when the assignment asks for that scope.
- Capture route, browser, viewport, timestamp, and raw observations.
- A screenshot may support several rows if each row links to it and the relevant
  state is visible.

## Moderated usability study

- Use one goal-oriented end-to-end scenario.
- Recruit seven real participants outside the class.
- Run a separate pilot before the main sessions.
- Use a neutral think-aloud protocol.
- Record screen and structured observations.
- Collect SUS or UEQ-S after the task, then ask probes covering clarity, error
  recovery, speed, and trust.

### SUS scoring

- Odd items: response minus 1.
- Even items: 5 minus response.
- Sum contributions and multiply by 2.5.
- Report individual values and the seven-participant mean.
- Do not calculate when any response is blank or outside 1-5.

## Analysis

For each finding, retain:

- affected participant codes;
- observable behavior;
- timestamp/recording reference;
- count of distinct affected participants;
- task effect;
- severity;
- design issue versus isolated defect;
- recommendation.

Do not infer participant sentiment from SUS alone.

## Cross-platform completion

Require at least three qualifying real runs. The screenshot must identify the
browser/OS/device, show the SUT localhost URL when required, and contain the
student identity overlay. Expo Go can count as one platform when the assignment
allows it. Headless viewport screenshots are useful preliminary evidence but do
not prove a physical browser/platform run.

## Academic-integrity boundary

Never fabricate:

- participant names or contacts;
- consent;
- observation notes or quotes;
- SUS/UEQ-S responses;
- recordings;
- cross-platform/device screenshots;
- student review decisions;
- student-authored bug narratives.

Mark missing human evidence as incomplete and provide a precise handoff.

## Submission contents

Check for:

- main report in Markdown and PDF;
- GUI checklist Excel workbook and test summary;
- failure evidence and GitHub issue links;
- usability plan, pilot, seven sessions, instrument responses, analysis, and
  participant register;
- three-platform screenshots;
- AI audit, disclosure, critique, and prompt log;
- Git commit log;
- README self-assessment and totals;
- skill and demo video links.
