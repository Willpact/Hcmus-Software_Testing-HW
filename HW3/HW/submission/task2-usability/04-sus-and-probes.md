# SUS Questionnaire and Probe Questions

## Response scale

Use the same scale for all ten statements:

1. Hoàn toàn không đồng ý
2. Không đồng ý
3. Trung lập
4. Đồng ý
5. Hoàn toàn đồng ý

Do not explain or reinterpret individual statements during administration.

## SUS statements

The Vietnamese wording below must remain identical for P01-P07.

1. Tôi nghĩ rằng tôi muốn sử dụng hệ thống này thường xuyên.
2. Tôi thấy hệ thống phức tạp một cách không cần thiết.
3. Tôi thấy hệ thống dễ sử dụng.
4. Tôi nghĩ rằng tôi cần sự hỗ trợ của người có kiến thức kỹ thuật để sử dụng hệ
   thống này.
5. Tôi thấy các chức năng trong hệ thống được tích hợp hợp lý.
6. Tôi thấy hệ thống có quá nhiều điểm thiếu nhất quán.
7. Tôi nghĩ rằng đa số mọi người sẽ học cách sử dụng hệ thống này rất nhanh.
8. Tôi thấy hệ thống khó sử dụng.
9. Tôi cảm thấy tự tin khi sử dụng hệ thống.
10. Tôi cần học nhiều điều trước khi có thể sử dụng hệ thống này.

## Scoring

- Odd items 1, 3, 5, 7, 9: contribution = response - 1.
- Even items 2, 4, 6, 8, 10: contribution = 5 - response.
- Sum the ten contributions and multiply by 2.5.
- The result ranges from 0 to 100, but it is not a percentage.
- Preserve individual scores and report the mean across seven participants.

Use `automation/analyze-usability.cjs` to calculate the scores, then manually
cross-check at least one odd and one even response.

## Required open-ended probes

Ask every participant:

1. **Clarity:** Phần nào của luồng mua hàng rõ ràng nhất và phần nào khó hiểu
   nhất? Vì sao?
2. **Error recovery:** Khi một thao tác không cho kết quả như mong đợi, bạn nhận
   biết và thử khắc phục như thế nào?
3. **Speed:** Có bước nào khiến bạn cảm thấy chậm hoặc tốn nhiều thao tác hơn cần
   thiết không?
4. **Trust:** Ở thời điểm nào bạn tin hoặc không tin rằng giá, mã giảm giá và đơn
   hàng đã được xử lý đúng?
5. Nếu được thay đổi một điều trong luồng này, bạn sẽ thay đổi điều gì?

Record close paraphrases and short verbatim quotes. Do not invent quotes.

## Source

Brooke, J. (1996). *SUS: A quick and dirty usability scale*.
https://hci-studies.org/methods-and-measures/downloads/SUS_Brooke1996.pdf
