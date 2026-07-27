# Task 2 - Moderated Usability Evaluation Plan

## Study identity

- SUT: EShop web frontend
- Primary flow: first-time account creation -> find a target product -> add it
  to Cart -> sign in -> apply `SAVE10` -> complete Checkout
- Method: small-sample moderated usability evaluation
- Planned main sessions: 7, one participant per session
- Pilot: 1 additional person who is not counted in the 7 main sessions
- Instrument: System Usability Scale (SUS) plus open-ended probes
- Moderation language: Vietnamese
- Status: **Prepared; real recruitment and sessions are still required**

## Objectives

1. Identify where first-time shoppers hesitate, make errors, or lose confidence
   during the selected purchase flow.
2. Measure whether participants can complete the flow without moderator help.
3. Evaluate whether navigation, state feedback, error recovery, speed, and trust
   are adequate for non-technical users.
4. Separate isolated implementation defects from recurring design problems.
5. Produce evidence-backed findings ranked by impact on task completion.

## Research questions

1. Can a new user discover the correct path without step-by-step instructions?
2. Do labels and feedback make the current system state understandable?
3. Can users recover after an ineffective click or a form/input error?
4. Which points consume the most time or require moderator assistance?
5. Do users trust the price, coupon result, and Checkout confirmation?

## Target participant profile

- Aged 18 or older.
- Has previously shopped online at least once.
- Is not currently enrolled in HW03.
- Preferably is not an IT student, software tester, or EShop contributor.
- Can use a desktop browser in Vietnamese.
- Has verifiable contact information. Only a masked contact is included in the
  submission; the middle four phone digits must be hidden.

Do not send participant names, phone numbers, Zalo IDs, recordings, or other
personal information to an AI tool.

## Recruitment and sample

- Recruit 8 people: P00 for the pilot and P01-P07 for the main sessions.
- Keep the private identity/contact mapping under `private/`.
- Assign each person a study code before the session.
- The TA may call two main participants. Verify that contact details remain
  current until grading is complete.

## Environment

- Backend: local EShop API
- Frontend: local EShop web UI
- Device: laptop/desktop with keyboard and mouse
- Browser: record actual name and version in each observation file
- Screen recording: required whenever technically available
- Audio: record only after explicit consent
- Account: use a unique synthetic test email for each session; do not ask the
  participant to expose a personal password

## Measures

| Measure | Definition |
|---|---|
| Task success | 1 only when the participant reaches the success state without the moderator taking control |
| Time on task | Seconds from scenario hand-off until success or termination |
| Errors | Observable action that moves away from the goal or produces an error state |
| Assists | Direct moderator hints or interventions |
| Critical incidents | Events that block progress, corrupt state, or seriously reduce trust |
| SUS | Ten post-session responses scored from 0 to 100 |
| Qualitative evidence | Think-aloud quotes, hesitations, recovery behavior, and probe answers |

## Success criteria

- At least 6 of 7 participants complete the task.
- Median time on task is at most 6 minutes.
- At least 5 of 7 participants complete without moderator assistance.
- Mean SUS is reported as an observed score, not converted into a fabricated
  grade or percentile.
- Every high-severity finding is supported by at least two participants or by a
  reproducible blocker.

These are study targets, not predicted results.

## Severity scale

| Severity | Operational definition |
|---|---|
| S1 - Blocker | Prevents task completion or causes unrecoverable/unsafe state |
| S2 - Major | Causes failure, repeated attempts, substantial delay, or moderator assistance |
| S3 - Moderate | Causes visible hesitation or an avoidable detour but the user recovers |
| S4 - Minor | Cosmetic or wording concern with little effect on completion |

## Pilot procedure

1. Run P00 using the same moderator guide and draft scenario.
2. Record unclear phrases, setup failures, timing problems, and accidental hints.
3. Refine only the scenario wording, instruments, or setup.
4. Do not tune the product or coach the seven main participants differently.
5. Document every change in `05-pilot-log.md`.

## Main-session procedure

1. Confirm eligibility and consent.
2. Start screen recording; start audio only when consented.
3. Read the neutral opening script verbatim.
4. Hand over the scenario and start the timer.
5. Observe without leading. Ask neutral prompts such as “Bạn đang nghĩ gì?”.
6. Intervene only when completely stuck; log the assist.
7. Stop timing at success or the predefined termination point.
8. Administer SUS before discussing the interface.
9. Ask the probe questions.
10. Save evidence under the participant code and complete the observation file.

## Analysis procedure

1. Validate that P01-P07 all have complete session metrics and ten SUS responses.
2. Run `node automation/analyze-usability.cjs`.
3. Review the computed output against the raw forms.
4. Code observations into themes without changing participant meaning.
5. Count affected participants for each theme.
6. Distinguish usability/design findings from reproducible software defects.
7. Assign severity using the operational definitions above.
8. Have the student write all final bug narratives, as required by the course AI
   agreement.

## References

- Brooke, J. (1996). *SUS: A quick and dirty usability scale*.
  https://hci-studies.org/methods-and-measures/downloads/SUS_Brooke1996.pdf
- W3C. *Web Content Accessibility Guidelines (WCAG) 2.2*.
  https://www.w3.org/TR/WCAG22/
