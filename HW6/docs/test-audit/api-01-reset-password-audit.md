# API-01 Human-reviewed AI Test Audit

- Status: `MODIFIED_AND_APPROVED`
- Raw generation remains unchanged; classifications below distinguish AI proposal from Human Review Decision and Final Disposition.

## Summary

- `TOTAL`: 40
- `VALID`: 21
- `INVALID`: 3
- `INCOMPLETE`: 16
- `PROPOSED_CORRECTIONS`: 19
- `PROPOSED_REMOVALS`: 3
- `SEMANTIC_DUPLICATES`: 1
- `AUTHORITATIVE_ORACLE_ISSUES`: 16
- `TRACEABILITY_ISSUES`: 1
- `STATE_SETUP_ISSUES`: 1
- `SECURITY_REASONING_ISSUES`: 3
- `CROSS_FEATURE_OVERREACH`: 1
- `UNSUPPORTED_PRECONDITION`: 1
- `IMPLEMENTATION_AS_ORACLE`: 0

## Per-case audit

### API01-AI-001

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-002

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-003

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-004

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Email chưa đăng ký' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION, SECURITY_REASONING_GAP`
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `SALVAGED_TO_EXECUTABLE`
- Proposed/applied correction: Human phải quyết định user-enumeration oracle hoặc chỉ giữ invariant không đổi tài khoản; xác định tín hiệu response nào được so sánh mà không bịa schema/status.

### API01-AI-005

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Thiếu email' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `SALVAGED_TO_EXECUTABLE`
- Proposed/applied correction: Làm rõ email có bắt buộc ở API contract hay sửa case thành security invariant rõ ràng rằng không tài khoản nào được đổi khi thiếu identity.

### API01-AI-006

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Thiếu resetToken' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT`
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `SALVAGED_TO_EXECUTABLE`
- Proposed/applied correction: Đổi expected result thành invariant requirement-backed: không được đổi mật khẩu khi không có issued email-bound OTP; giữ transport response unspecified.

### API01-AI-007

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Thiếu newPassword' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT`
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `SALVAGED_TO_EXECUTABLE`
- Proposed/applied correction: Xác nhận requiredness của newPassword hoặc nêu rõ invariant không hoàn tất password reset khi không có mật khẩu mới.

### API01-AI-008

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-009

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-010

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-011

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-012

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-013

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Thời điểm sát hạn OTP' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION, MISSING_STATE_SETUP`
- Human Review Decision: `APPROVE_CLASSIFICATION`
- Human review status: `HUMAN_REVIEW_DECISION_APPLIED`
- Final disposition: `DEFERRED_REQUIREMENT_GAP`
- Proposed/applied correction: Dùng expired-token fixture được xác định bởi cấu hình/clock của môi trường test và ghi rõ hai mốc quan sát; không tự đặt expiry duration.

### API01-AI-014

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `APPROVE_CLASSIFICATION`
- Human review status: `HUMAN_REVIEW_DECISION_APPLIED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-015

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-016

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-017

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Yêu cầu OTP lần hai' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `DEFERRED_REQUIREMENT_GAP`
- Proposed/applied correction: Cần Human Decision về token supersession; nếu chưa có thì defer khỏi executable final suite thay vì chọn token A hay B làm oracle.

### API01-AI-018

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-019

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-020

- AI audit proposal / final classification: `INVALID`
- Classification reason: Mục tiêu chính là hành vi đăng nhập ở endpoint khác sau reset; API reset-password không có authoritative downstream session/login oracle.
- Traceability assessment: `MISALIGNED_CROSS_ENDPOINT`
- Oracle assessment: `INSUFFICIENT_OR_NOT_APPLICABLE_FOR_SELECTED_FINAL_SUITE`
- Issues: `CROSS_FEATURE_OVERREACH, TRACEABILITY_ISSUE`
- Human Review Decision: `APPROVE_CLASSIFICATION`
- Human review status: `HUMAN_REVIEW_DECISION_APPLIED`
- Final disposition: `REMOVED_FROM_FINAL_EXECUTABLE_SUITE`
- Proposed/applied correction: Chuyển concept sang suite authentication/login riêng sau khi có authoritative post-reset authentication contract; không giữ như case trực tiếp của POST /api/reset-password.

### API01-AI-021

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-022

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-023

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-024

- AI audit proposal / final classification: `VALID`
- Classification reason: Objective, setup, request variation and business/state oracle trace to the approved authoritative analysis without promoting implementation behavior.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-025

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Nhiều lần đoán OTP sai' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION, SECURITY_REASONING_GAP`
- Human Review Decision: `APPROVE_CLASSIFICATION`
- Human review status: `HUMAN_REVIEW_DECISION_APPLIED`
- Final disposition: `DEFERRED_REQUIREMENT_GAP`
- Proposed/applied correction: Xác định policy/threshold rate-limit authoritative hoặc chuyển thành non-blocking security observation với metric cụ thể và không có pass/fail product verdict.

### API01-AI-026

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'So sánh phản hồi email tồn tại và không tồn tại' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT, SECURITY_REASONING_GAP`
- Human Review Decision: `APPROVE_CLASSIFICATION`
- Human review status: `HUMAN_REVIEW_DECISION_APPLIED`
- Final disposition: `DEFERRED_REQUIREMENT_GAP`
- Proposed/applied correction: Xác định risk acceptance cho user enumeration và các tín hiệu cần so sánh; không yêu cầu response giống nhau nếu chưa có security acceptance criterion.

### API01-AI-027

- AI audit proposal / final classification: `VALID`
- Classification reason: Applicable security invariant provides a meaningful pass/fail target even though exact HTTP status and response schema remain unspecified.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-028

- AI audit proposal / final classification: `VALID`
- Classification reason: Applicable security invariant provides a meaningful pass/fail target even though exact HTTP status and response schema remain unspecified.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-029

- AI audit proposal / final classification: `VALID`
- Classification reason: Transport details are unspecified, but the raw case retains a requirement-backed business/state oracle sufficient for execution.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: 

### API01-AI-030

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Thêm trường confirmation khớp' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- Human Review Decision: `APPROVE_CLASSIFICATION`
- Human review status: `HUMAN_REVIEW_DECISION_APPLIED`
- Final disposition: `DEFERRED_REQUIREMENT_GAP`
- Proposed/applied correction: Chỉ thực thi sau khi Human xác nhận tên/vị trí confirmation field; hiện tại giữ như contract-gap candidate.

### API01-AI-031

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Thêm trường confirmation không khớp' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `DEFERRED_REQUIREMENT_GAP`
- Proposed/applied correction: Xác nhận API representation của confirmation trước khi dùng mismatch làm executable request; business rule FR-03 vẫn được giữ.

### API01-AI-032

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Thêm field không tài liệu hóa' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `DEFERRED_REQUIREMENT_GAP`
- Proposed/applied correction: Bổ sung authoritative additional-properties policy hoặc chuyển thành robustness observation không blocking.

### API01-AI-033

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Malformed JSON' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT`
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `DEFERRED_REQUIREMENT_GAP`
- Proposed/applied correction: Bổ sung observable invariant không đổi password/token và cách thu transport evidence; không tự đặt error status/schema.

### API01-AI-034

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Không gửi confirmation' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `DEFERRED_REQUIREMENT_GAP`
- Proposed/applied correction: Giải quyết gap confirmation giữa FR-03 và API specification; defer nếu không có representation được Human approve.

### API01-AI-035

- AI audit proposal / final classification: `VALID`
- Classification reason: Applicable security invariant provides a meaningful pass/fail target even though exact HTTP status and response schema remain unspecified.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `SUFFICIENT_FOR_BUSINESS_OR_SECURITY_PASS_FAIL`
- Issues: ``
- Human Review Decision: `MODIFY_CORRECTION`
- Human review status: `HUMAN_REVIEW_DECISION_APPLIED`
- Final disposition: `INCLUDED_EXECUTABLE`
- Proposed/applied correction: Keep the SEC-01 plaintext-storage oracle and add external persistence verification metadata.
- Automation note: Requires database/external persistence verification in the isolated test environment. Do not represent this as a pure Postman response assertion if Postman cannot directly inspect persistence.

### API01-AI-036

- AI audit proposal / final classification: `INVALID`
- Classification reason: Case lặp cùng state, action và oracle one-time OTP với API01-AI-015: đều replay đúng OTP sau một reset thành công và kỳ vọng không có lần đổi mật khẩu thứ hai.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_OR_NOT_APPLICABLE_FOR_SELECTED_FINAL_SUITE`
- Issues: `SEMANTIC_DUPLICATION`
- Human Review Decision: `APPROVE_CLASSIFICATION`
- Human review status: `HUMAN_REVIEW_DECISION_APPLIED`
- Final disposition: `REMOVED_FROM_FINAL_EXECUTABLE_SUITE`
- Proposed/applied correction: Giữ API01-AI-015 làm case canonical cho OTP replay; bỏ API01-AI-036 khỏi final suite nhưng bảo toàn raw record.

### API01-AI-037

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Mật khẩu có khoảng trắng nhưng đủ lớp' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `DEFERRED_REQUIREMENT_GAP`
- Proposed/applied correction: Cần danh sách allowed special characters authoritative; không suy diễn space hợp lệ hay không hợp lệ.

### API01-AI-038

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Email đúng khác biệt hoa thường' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `DEFERRED_REQUIREMENT_GAP`
- Proposed/applied correction: Cần email-normalization/case-sensitivity rule hoặc biến case thành non-blocking observation.

### API01-AI-039

- AI audit proposal / final classification: `INCOMPLETE`
- Classification reason: Concept/risk 'Mismatch qua representation thay thế' có liên quan, nhưng raw case chưa có authoritative oracle, dependency hoặc validation point đủ để trở thành final executable pass/fail test.
- Traceability assessment: `ALIGNED_WITH_APPROVED_ANALYSIS`
- Oracle assessment: `INSUFFICIENT_FOR_FINAL_PASS_FAIL`
- Issues: `AMBIGUOUS_EXPECTED_RESULT, REQUIREMENT_GAP_ASSUMPTION`
- Human Review Decision: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Human review status: `AGGREGATE_METHOD_APPROVED_NOT_INDIVIDUALLY_REVIEWED`
- Final disposition: `DEFERRED_REQUIREMENT_GAP`
- Proposed/applied correction: Không dùng confirmPassword convention cho tới khi Human/source xác nhận; nếu không có contract thì remove/defer candidate.

### API01-AI-040

- AI audit proposal / final classification: `INVALID`
- Classification reason: API01-REQ-003 establishes a six-digit issued OTP; the raw case requires an unsupported seven-digit issuer state. SEC-07 entropy wording does not establish that FR-03 issues a seven-digit token.
- Traceability assessment: `MISALIGNED_UNSUPPORTED_ISSUER_STATE`
- Oracle assessment: `UNSUPPORTED_PRECONDITION`
- Issues: `UNSUPPORTED_PRECONDITION`
- Human Review Decision: `CHANGE_TO_INVALID`
- Human review status: `HUMAN_REVIEW_DECISION_APPLIED`
- Final disposition: `REMOVED_FROM_FINAL_EXECUTABLE_SUITE`
- Proposed/applied correction: Preserve the raw case for history and exclude it from the final executable suite.
