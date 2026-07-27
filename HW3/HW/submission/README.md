# HW03 Submission Readiness

## Student information

| Field | Value |
|---|---|
| Student name | TODO |
| Student ID | TODO - confirm whether `23127107` |
| Class / Cohort | TODO |
| Self-assessed grade | TODO after all evidence is complete |
| Final ZIP name | `<StudentID>_HW03_AI_GUIUsability_<Grade>.zip` |

## Current test summary

| Metric | Current value |
|---|---:|
| Screens covered by GUI checklist | 5 primary screens |
| End-to-end flow selected | 1 |
| GUI checklist items designed/executed | 63 / 63 |
| GUI Passed | 20 |
| GUI Failed | 43 |
| Candidate defect groups awaiting student-written issues | 10 |
| Real usability participants completed | 0 / 7 |
| Pilot completed | 0 / 1 |
| Qualifying cross-platform runs | 0 / 3 |
| Agent Skill | Created and structurally valid |
| Agent Skill demo videos | 0 |

## Assessment readiness

| Criterion | Max | Current status | Student self-assessment |
|---|---:|---|---:|
| Task 1 - GUI checklist | 30 | Automated execution complete; human review and GitHub issues missing | TODO |
| Task 2 - usability evaluation | 40 | Prepared only; real sessions missing | TODO |
| Task 3 - cross-platform | 20 | Plan prepared; real runs missing | TODO |
| Agent Skills | 10 | Skill valid; video missing | TODO |
| **Total** | **100** | **Not submission-ready** | **TODO** |

## Required completion checklist

### Identity and scope

- [ ] Confirm full name, Student ID, and class/cohort.
- [ ] Confirm the selected primary screens/flow are not duplicated in the group.

### Task 1

- [x] More than 40 checklist items.
- [x] IA-01 through IA-04 covered.
- [x] All checklist items executed Passed/Failed.
- [x] Failure notes and screenshots captured.
- [ ] Student reviews all AI items.
- [ ] Student accepts/rewords/rejects each `Student-review candidate`.
- [ ] Student writes confirmed bug reports.
- [ ] GitHub Issues created with screenshots and URLs added.

### Task 2

- [ ] Recruit separate pilot P00.
- [ ] Recruit seven eligible real participants P01-P07.
- [ ] Complete private participant register with masked contacts.
- [ ] Conduct pilot and document refinements.
- [ ] Conduct and record seven sessions.
- [ ] Enter ten SUS responses and metrics for every participant.
- [ ] Run `node automation/analyze-usability.cjs`.
- [ ] Synthesize and severity-rank real findings.

### Task 3

- [ ] Run Google Chrome.
- [ ] Run Mozilla Firefox.
- [ ] Run Safari, Android Chrome, or permitted Expo Go.
- [ ] Capture real platform/URL/identity screenshots.
- [ ] Fill the evidence index and observed differences.

### AI and submission

- [ ] Export full Codex conversation with timestamps.
- [ ] Complete AI Audit counts/conclusion.
- [ ] Write 200-300 word AI Critique independently.
- [ ] Complete disclosure and signatures.
- [ ] Record and link Agent Skill demonstration video.
- [ ] Export main report and AI appendix to PDF.
- [ ] Generate Excel checklist and verify formatting.
- [ ] Generate final Git commit log.
- [ ] Run submission validator.
- [ ] Package final ZIP using the required name.

## Validation

```text
python .codex/skills/gui-usability-evaluator/scripts/validate_submission.py submission
```

Warnings about blank real-participant or cross-platform evidence are expected
until those activities are genuinely completed.
