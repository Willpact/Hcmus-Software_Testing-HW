---
name: gui-usability-evaluator
description: Design, execute, and audit requirement-based GUI checklists and moderated usability evaluations. Use when working on HW03-style interface testing, mapping checks to IA categories, collecting reproducible browser evidence, preparing SUS sessions, analysing real participant data, or verifying a GUI/usability submission without fabricating people, observations, screenshots, or cross-platform runs.
---

# GUI and Usability Evaluator

Build auditable GUI and usability artifacts while preserving a strict boundary
between generated preparation, executed evidence, and real human-session data.

## Workflow

1. Read the assignment and SUT requirements before generating checks.
2. Record the selected screens and end-to-end flow. Check that teammates have
   not selected the same primary scope.
3. Generate an initial GUI checklist mapped to the required interface aspects.
4. Mark generated items as AI draft. Ask the student to review, correct, and add
   SUT-specific items; never label an AI-authored item as student-authored.
5. Execute every checklist item against the current SUT. Use only Passed or
   Failed when the assignment requires binary status.
6. Store failure notes and real screenshots. Never generate, edit, or simulate
   evidence screenshots.
7. Prepare the moderated study, pilot, SUS form, probes, consent script, and
   observation forms.
8. Stop before qualitative or quantitative usability conclusions if any of the
   seven real sessions is missing. Never invent participants, quotes, timings,
   scores, or contact details.
9. Analyse complete real data, group recurring pain points, distinguish design
   issues from isolated defects, and rank severity.
10. Prepare cross-platform execution instructions, but mark the task incomplete
    until three qualifying real platform runs and identity overlays exist.
11. Audit the submission with `scripts/validate_submission.py`.

## Evidence rules

- Separate observed runtime facts from source-code inference.
- Link every Failed checklist row to failure evidence.
- Keep participant identities and raw recordings out of AI prompts and public
  Git history.
- Treat SUS scores as 0-100 scale values, not percentages.
- Require one pilot plus seven main sessions unless the assignment explicitly
  allows the pilot participant to be counted.
- Do not draft a final bug narrative when the course requires it to be written
  by the student. Provide raw facts and an empty issue template instead.
- Do not claim Edge/Chromium emulation as Safari, Android Chrome, or a physical
  device run.

## Required reference

Read `references/hw03-method.md` when producing HW03 deliverables, deciding
completion status, scoring SUS, or checking the ZIP contents.

## Validation

Run:

```text
python scripts/validate_submission.py <submission-directory>
```

Treat validation as structural only. It cannot prove that participants,
recordings, screenshots, student review, or GitHub issues are genuine.
