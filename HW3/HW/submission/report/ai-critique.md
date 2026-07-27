# AI Critique - Student Writing Required

> This file is deliberately not a finished 200-300 word critique. The critique
> evaluates the student's own collaboration with AI and must be written in the
> student's voice. Do not submit these notes as the final paragraph.

## Evidence available for your critique

Use concrete examples:

1. **False positive:** the generated automation initially counted
   `hover:underline` as proof that the current Cart navigation item was active.
   Human/runtime review showed that hover styling is not an active state. The
   check was corrected to require `aria-current="page"` or an explicit active
   class.
2. **Unsupported heuristic:** the first target-size check used 44x44 pixels
   without tying it to the intended conformance level. After consulting WCAG
   2.2, the automation used the 24x24 minimum test and handled reflow separately
   at 320 CSS pixels.
3. **Incomplete evidence:** AI could prepare participant forms and scoring code,
   but it could not supply genuine participants, consent, observations,
   recordings, or cross-platform screenshots.
4. **SUT-specific behavior:** generic checklist generation alone would not prove
   the unusual first-click add-to-cart defect; actual execution was required.

## Questions your 200-300 words must answer

- Where was the AI wrong, biased, or incomplete?
- Why did it miss or misclassify the issue?
- How did you detect and correct the problem?
- What principle will you retain when collaborating with AI?

## Suggested structure

- 50-70 words: what AI contributed.
- 80-110 words: one or two concrete failures and their causes.
- 50-70 words: how you verified/corrected the output.
- 30-50 words: lesson for future AI collaboration.

## Final student paragraph

TODO - write 200-300 words here, then record the word count:

**Word count:** TODO
