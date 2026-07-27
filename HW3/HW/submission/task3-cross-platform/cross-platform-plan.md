# Task 3 - Cross-Browser / Cross-Platform Plan

## Completion status

**Not yet complete.** Task 1 was executed locally in Microsoft Edge/Chromium,
which does not replace the three qualifying runs required by Task 3.

## Planned qualifying matrix

| Platform ID | Browser / device | Operating system | Execution method | Status |
|---|---|---|---|---|
| CP-01 | Google Chrome desktop | Windows 11 | BrowserStack Live or physical machine | Not executed |
| CP-02 | Mozilla Firefox desktop | Windows 11 or macOS | BrowserStack Live or physical machine | Not executed |
| CP-03 | Android Chrome | Real Android device or BrowserStack real device | BrowserStack Live or physical phone | Not executed |

Acceptable substitution: replace CP-03 with real Safari on macOS/iOS or Expo Go
on a real phone, as permitted by the assignment.

## SUT access

The SUT is local:

- Frontend: `http://localhost:5173`
- Backend: `http://localhost:3000`

BrowserStack Live requires Local Testing for localhost/private applications.
Current official instructions:

- https://www.browserstack.com/docs/live/local-testing
- https://www.browserstack.com/docs/live/local-testing/set-up-local-testing

When BrowserStack rewrites the localhost address on iOS, document the displayed
`bs-local.com` address and retain the BrowserStack platform/device chrome in the
screenshot.

## Identity overlay

Before every screenshot, paste the contents of
`automation/cross-platform-identity-overlay.js` into the remote browser console
after replacing the placeholders. The overlay must contain:

```text
FULL NAME | STUDENT_ID@hcmus.edu.vn
```

Do not type a false browser/OS/device label into the overlay. The screenshot must
show the real BrowserStack/physical browser UI or device identity alongside the
URL.

## Common smoke flow

Run the same sequence on all three platforms:

1. Open Home and confirm product cards render.
2. Search for `iPhone`.
3. Open Product Detail.
4. Enter quantity `1`.
5. Activate Add to Cart once and observe feedback.
6. Open Cart and inspect row, total, layout, and navigation.
7. Continue to Login/Checkout using the test account.
8. Apply `SAVE10` without submitting a second real order if test data is not
   isolated.
9. Capture console/network failures and visible differences.

Do not coach the browser into a different state to hide a platform-specific
failure.

## Screenshot requirements

Each qualifying screenshot must visibly establish:

- student full name and `StudentID@hcmus.edu.vn`;
- browser name;
- OS/device name;
- local SUT URL or BrowserStack Local equivalent;
- relevant SUT state;
- timestamp recorded in the evidence index.

Use original screenshots. Do not crop away the BrowserStack toolbar, device
frame, address bar, or identity overlay.

## Comparison dimensions

| Area | What to compare |
|---|---|
| Layout | clipping, overlap, wrapping, horizontal scrolling |
| Typography | missing glyphs, font substitution, readable size |
| Controls | input type, focus, touch target, disabled styling |
| Navigation | links, history, active state, breadcrumbs |
| State | loading, cart update, coupon feedback, errors |
| Media | image loading, aspect ratio, alt fallback |
| Console/network | browser-specific errors or failed requests |
