# CI/CD cho HW06 API Testing

## Trạng thái hiện tại

`WORKFLOW_READY: YES` — [workflow](../../../.github/workflows/hw06-api-newman.yml) đã dùng Newman `6.2.2`, lấy SUT không sửa đổi từ `ttbhanh/eshop-sut`, và chỉ nhận runtime environment qua GitHub Secret.

`PASS_RUN: NO`, `INTENTIONAL_FAIL_RUN: NO`, `FINAL_STATE_HEALTHY: NO` vì repository hiện không có secret `HW06_RUNTIME_ENV_B64`; không có CI result nào được tạo hay suy diễn trong tài liệu này.

## Guard bí mật

Secret `HW06_RUNTIME_ENV_B64` là base64 của môi trường Postman runtime dùng disposable fixtures. Nó không được commit, in log, upload dưới dạng environment file, hay thêm vào issue. Workflow chỉ upload Newman reports và result metadata khi chúng tồn tại.

## Quy trình Human bắt buộc

1. Tạo GitHub Actions secret `HW06_RUNTIME_ENV_B64` từ **một environment file disposable** đã được kiểm tra không chứa Student ID, JWT, password hoặc credential nộp cùng repository.
2. Push workflow ở trạng thái `normal`, mở **Run workflow**, chọn `normal`, rồi lưu URL/run ID của run xanh vào bảng dưới đây.
3. Trên một commit tạm thời chỉ đổi input workflow sang `intentional-fail` (không đổi SUT/test behavior), chạy manual dispatch `intentional-fail`, lưu URL/run ID FAIL.
4. Revert commit tạm thời, push trạng thái workflow `normal`, và chạy/kiểm tra một PASS cuối. Không để `intentional-fail` là trạng thái cuối của repository.

## Nhật ký genuine CI evidence

| Loại run | Run ID / URL | Trạng thái | Ghi chú |
| --- | --- | --- | --- |
| Healthy PASS | `PENDING_HUMAN_RUN` | `PENDING` | Cần secret runtime và run thật. |
| Intentional FAIL | `PENDING_HUMAN_RUN` | `PENDING` | Chỉ dùng manual dispatch tạm thời theo quy trình trên. |
| Final healthy state | `PENDING_HUMAN_RUN` | `PENDING` | Phải là `normal`; không được suy diễn từ workflow syntax. |

## Kiểm tra cục bộ đã thực hiện

- Workflow được review tĩnh: syntax YAML, `workflow_dispatch`, secret guard, dependency checkout, Newman tooling và artifact paths.
- Không chạy Newman, không khởi động SUT và không gọi GitHub Actions từ máy cục bộ trong overnight run.
