# CI/CD cho HW06 API Testing

## Trạng thái đã xác minh

Workflow `HW06 API Newman` đã có ba GitHub Actions run genuine theo đúng chuỗi `normal` → `intentional-fail` → `normal`. Ngày 2026-08-24, metadata run và safe artifact của từng run được kiểm tra trực tiếp bằng GitHub CLI. Artifact chỉ gồm `runner-result.json`, `orchestration-result.json` và `targeted-scope-guard.json`; không cần tải hoặc công bố raw Newman JSON/HTML có thể chứa request body hay runtime token.

| Loại run | Run ID / URL | Mode | Request | Assertion | Assertion failure | Kết quả đã xác minh |
| --- | --- | --- | ---: | ---: | ---: | --- |
| Healthy PASS | [#32660557339](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660557339) | `normal` | 179 | 116 | 0 | GitHub conclusion `success`; orchestration `PASS`. |
| Intentional FAIL | [#32660601543](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660601543) | `intentional-fail` | 180 | 117 | **1** | GitHub conclusion `failure`; runner và orchestration cùng `INTENTIONAL_FAILURE_VERIFIED`. |
| Final healthy PASS | [#32660658460](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660658460) | `normal` | 179 | 116 | 0 | GitHub conclusion `success`; orchestration `PASS`. |

Trong intentional run, `orchestration-result.json` ghi `smoke_exit_code: 0` và `run002_exit_code: 1`; `targeted-scope-guard.json` ghi `expected_ci_assertion_failures: 1`. Vì vậy failure đúng là một Newman assertion failure có kiểm soát, không phải lỗi hạ tầng hay lỗi cấu hình. Final normal run PASS xác nhận pipeline đã trở lại healthy.

Các configuration-error run cũ, bao gồm [#32630260002](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32630260002), chỉ là lỗi workflow trước repair và **không được tính** là intentional failed run hay evidence testcase.

## Repair cho clean runner

- Workflow dùng `HW06_CI_ARTIFACT_ROOT=test-results/hw06/ci-runtime`, nên không đọc/ghi `run-002` lịch sử.
- `postman/scripts/hw06-runtime-layout.js` resolve artifact root, runtime environment và SUT root bằng path cross-platform, có default local tương thích.
- `postman/scripts/sqlite-path-redirect.cjs` là source-controlled. SUT process chỉ dùng redirect khi orchestration truyền source DB và destination DB explicit qua environment variables.
- Orchestration copy source `database.sqlite` vào một isolated DB mới cho **mỗi** smoke/targeted phase; không phụ thuộc `test-results/hw06/run-002/sqlite-path-redirect.cjs`, runtime DB cũ, smoke artifact cũ hay Windows-only path.
- `.gitignore` loại `ci-runtime/` và local simulation outputs vì chúng có runtime environment/output không thuộc delivery surface.
- Workflow chỉ upload metadata an toàn nêu trên. Raw Newman JSON/HTML có thể chứa request body/runtime token nên không upload.

## Clean local simulation (genuine local execution)

Runtime environment được tạo mới bằng `postman/scripts/prepare-runtime-environment.py`; metadata xác nhận guard Student ID/credential mà không in giá trị. Hai simulation dùng directory mới, tách khỏi `run-001`/`run-002` lịch sử:

| Mode | Prepare | SUT ready | Smoke Newman | Targeted Newman | Orchestration |
| --- | --- | --- | --- | --- | --- |
| `normal` | PASS (37 stable IDs) | PASS | exit 0 | 179 request, 0 assertion failure | PASS / exit 0 |
| `intentional-fail` | PASS | PASS | exit 0 | 180 request, exactly 1 assertion failure | `INTENTIONAL_FAILURE_VERIFIED` / exit 1 |

Local simulation là validation reproducibility; ba run ở bảng đầu mới là genuine GitHub Actions evidence.

## Controlled intentional-fail design

`run_mode=intentional-fail` tạo đúng một CI-only request/testcase tên `[CI-INTENTIONAL-FAIL-001] Controlled Newman assertion failure`. Assertion cố ý `expect(true).to.equal(false)` chỉ được thêm vào collection generated trong mode này. Nó không có stable HW06 case ID, không sửa SUT/test oracle, không được đưa vào defect accounting và normal mode vẫn có 0 assertion failure.

## Traceability và bảo mật evidence

- Safe artifact GitHub Actions: `hw06-ci-32660557339`, `hw06-ci-32660601543`, `hw06-ci-32660658460`.
- Trường đối chiếu: `ci_run_mode`, `requests_executed`, `assertions`, `assertion_failures`, `status`, smoke/targeted exit code và guard assertion failure kỳ vọng.
- `HW06_RUNTIME_ENV_B64` đã được restore cho workflow nhưng giá trị không được log hoặc đưa vào artifact/tài liệu.

