# Morning Human Actions — HW06

Chỉ các việc dưới đây cần Human trực tiếp làm. Screenshot đã capture không cần chụp lại nếu review đạt.

1. **Review 17 genuine screenshots** trong `docs/defects/screenshots/`: readability, mapping DEF/case/source và không lộ dữ liệu nhạy cảm.
2. **Review three-run CI evidence** tại [#32660557339](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660557339), [#32660601543](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660601543) và [#32660658460](https://github.com/Willpact/Hcmus-Software_Testing-HW/actions/runs/32660658460); intentional run phải cho thấy đúng một assertion failure và normal cuối PASS.
3. **Visual-review** workbook `docs/final/HW06-Test-Cases-and-Summary.xlsx`, report Markdown/PDF và checklist/manifest final. Primary-case mapping của sheet `Defects` đã được Human xác nhận và đối chiếu 9/9 với `docs/defects/evidence-matrix.md`.
4. **Kiểm tra 9 GitHub Issue target** tại `DuyITLOR/group05_eshop` (#393–#401), bao gồm title bốn tag và link trực tiếp trong `docs/defects/github-issue-readiness.md`.
5. **Review redaction manifest** `docs/execution-results/redacted-newman/REDACTION-MANIFEST.md`: chỉ bản redacted Newman được đóng gói/stage; raw report lịch sử có JWT/request credential không được đưa vào ZIP. Quyết định rotation/xử lý history theo policy repository nếu cần.
6. **Review working tree, secret scan theo manifest, thực hiện commit/export cuối và nộp bài** sau khi các blocker bắt buộc đã được giải quyết. Agent Skill diagram, demo video và AI Audit đã hoàn tất, không cần tạo lại.
