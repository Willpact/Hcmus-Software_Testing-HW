# HW06 GitHub Issue readiness

## Kết quả kiểm tra trước khi tạo online

- GitHub authentication: `VALID` — tài khoản active có scope `repo` và `workflow`.
- Repository target: `https://github.com/Willpact/Hcmus-Software_Testing-HW` — `UNAMBIGUOUS`.
- Confirmed root defects: `9/9`; mỗi `DEF-01` đến `DEF-09` có một draft riêng, không tách theo testcase.
- Genuine screenshot evidence: `17` PNG đã tồn tại và được validate (`9` request/response, `8` external/state); xem `evidence-matrix.md`.
- Issue online: `PENDING_REPOSITORY_PUSH` — ảnh và draft đang ở working tree local, nên chưa có URL repository ổn định cho reviewer online.

| DEFECT_ID | DEFECT_REPORT | ISSUE_DRAFT | SCREENSHOT_READY | ONLINE_CREATION_STATUS |
| --- | --- | --- | --- | --- |
| DEF-01 | READY | `docs/defects/github-issues/DEF-01-github-issue.md` | YES | PENDING_REPOSITORY_PUSH |
| DEF-02 | READY | `docs/defects/github-issues/DEF-02-github-issue.md` | YES | PENDING_REPOSITORY_PUSH |
| DEF-03 | READY | `docs/defects/github-issues/DEF-03-github-issue.md` | YES | PENDING_REPOSITORY_PUSH |
| DEF-04 | READY | `docs/defects/github-issues/DEF-04-github-issue.md` | YES | PENDING_REPOSITORY_PUSH |
| DEF-05 | READY | `docs/defects/github-issues/DEF-05-github-issue.md` | YES | PENDING_REPOSITORY_PUSH |
| DEF-06 | READY | `docs/defects/github-issues/DEF-06-github-issue.md` | YES | PENDING_REPOSITORY_PUSH |
| DEF-07 | READY | `docs/defects/github-issues/DEF-07-github-issue.md` | YES | PENDING_REPOSITORY_PUSH |
| DEF-08 | READY | `docs/defects/github-issues/DEF-08-github-issue.md` | YES | PENDING_REPOSITORY_PUSH |
| DEF-09 | READY | `docs/defects/github-issues/DEF-09-github-issue.md` | YES | PENDING_REPOSITORY_PUSH |

## Điều kiện tạo issue

Sau khi commit/push explicit các draft và `docs/defects/screenshots/`, chạy một lần cho mỗi file draft bằng `gh issue create --title ... --body-file ...`; sau đó ghi `DEFECT_ID`, `ISSUE_NUMBER`, `ISSUE_URL`, `CREATION_STATUS` vào index này. Không close issue và không tạo issue theo testcase.
