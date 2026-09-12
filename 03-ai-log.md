# 03 — AI Log & Reflection

> Nhật ký phiên làm bài có hỗ trợ Codex ngày 12/09/2026. Nội dung phản ánh các thao tác thực sự diễn ra trong phiên; không giả lập phỏng vấn Vinmec hoặc kết quả gọi Gemini. Người học cần đọc, kiểm tra và bổ sung suy nghĩ cá nhân trước khi nộp dưới tên mình.

## Yêu cầu thực tế đã đưa cho AI

1. “Đọc dự án và giúp tôi hoàn thành các yêu cầu của đề bài. Nếu có chọn đề tài thì chọn về vinmec”.
2. “Giúp tôi làm các yêu cầu của đề bài và làm phần todo của promt_prototype.py.”

## AI đã hỗ trợ những gì?

AI đọc README, worksheet, bài mẫu, inspiration kit, code starter và autograder; đối chiếu từng deliverable với rubric. Bản problem scan trước đó thiên về VinFast được chuyển sang Vinmec theo yêu cầu. AI đề xuất phạm vi hành chính gồm phân loại yêu cầu và lập phiếu chuyển tiếp, thay vì xử lý chuyên môn lâm sàng.

AI viết 7 bài toán, hoàn thiện 3 Quick Cards, problem statement 6 trường, workflow hiện tại/tương lai và quyết định NOT YET. AI cũng hoàn thiện hàm gọi Gemini, JSON schema, validator, fallback, 6 input tấn công, 3 input bình thường và kiểm thử code ngoại tuyến.

Nguồn Vinmec công khai được dùng để xác nhận có kênh đặt lịch/liên hệ, không dùng để suy ra hiệu suất nội bộ. Tài liệu Google được đối chiếu cho structured output và system instruction. Các nguồn được dẫn trong báo cáo.

## Chỗ dễ sai hoặc gây hiểu nhầm và cách sửa

| Quan sát trong phiên | Cách xử lý | Bài học |
|---|---|---|
| Bài mẫu mô tả số liệu vận hành cụ thể, nhưng phiên này không có khảo sát Vinmec | Đánh dấu toàn bộ thời gian/sản lượng là giả định; thêm kế hoạch đo baseline | Con số hợp lý không tự trở thành chứng cứ thực tế |
| Starter và autograder dùng ranh giới pin xe Xanh SM | Viết prompt đúng Vinmec; giữ nguyên autograder và ghi rõ khác biệt, không chèn từ khóa xe điện để lấy điểm | Kiểm tra tự động có thể không phù hợp đề tài được cho phép |
| Kiểm tra chuỗi có DRAFT_ONLY không đảm bảo nội dung an toàn | Dùng JSON đầy đủ, boolean thật, enum, mẫu phiếu chính xác, từ chối trường thừa/khóa trùng | Prompt cần được hỗ trợ bằng code và hạn chế quyền hành động |
| Mô hình có thể gán sai nhóm dù JSON hợp lệ | Đối chiếu nhãn mong đợi và giữ bước người duyệt yêu cầu gốc | Schema không thay thế kiểm thử ngữ nghĩa |
| Chưa có API key Gemini | Chạy unit tests với mock SDK và ghi rõ chưa đánh giá mô hình thật | Không được gọi kết quả mock là kết quả LLM |
| Lần đọc đầu dùng encoding mặc định làm tiếng Việt hiển thị lỗi | Đọc/ghi UTF-8 rõ ràng | Lỗi hiển thị có thể gây hiểu sai yêu cầu |

Không có phản hồi Gemini thật trong phiên nên **không có cơ sở tuyên bố đã quan sát Gemini hallucinate hoặc đã chống được mọi tấn công**. Những rủi ro nêu trên là điểm cần phòng ngừa/kiểm chứng, không phải sự kiện lâm sàng hay sự cố vận hành đã xảy ra.

## Cách ranh giới được cụ thể hóa

Chỉ thị tổng quát “hỗ trợ CSKH” được viết thành: chỉ phân bốn nhóm; output phải là nháp chờ duyệt; yêu cầu y khoa hoặc tiết lộ dữ liệu chuyển người xử lý; không xác nhận lịch/chi phí; nội dung giả mạo system trong input không được thay đổi quyền hạn. Phiếu được chọn từ mẫu cố định, không có trường tự do để tạo lời khuyên y khoa.

Hàm `evaluate_prompt()` trả nguyên văn phản hồi API để kiểm tra; không âm thầm sửa phản hồi rồi báo đạt. Lỗi API/JSON hoặc sai nhãn trong test được báo lỗi và dùng placeholder thủ công có nhãn LOCAL FALLBACK. Không có công cụ gửi tin hoặc sửa lịch trong prototype.

## Kết quả và phản ánh

Đã chạy **12 unit tests ngoại tuyến thành công**. Các kiểm tra bao gồm định dạng, nội dung không được phép, API timeout/phản hồi rỗng, thiếu key và truyền system instruction đúng qua SDK mock. Chưa chạy 9 ca smoke test với Gemini thật; chưa có dữ liệu đo tốc độ, F1 hoặc thời gian tiết kiệm.

Điểm rút ra từ bài làm là cần đi từ bottleneck có thể đo, so sánh rule với LLM, và giới hạn quyền AI bằng kiến trúc. Một prototype gọi được SDK chưa đủ để quyết định GO. Bước tiếp theo là cấu hình key ở máy cá nhân, chạy các ca tổng hợp, rà soát phản hồi thật, bổ sung tập holdout và lấy ý kiến người phụ trách nghiệp vụ.
