# 01 — Problem Scan: Vinmec Administrative Copilot

> Bài tập AI Product Scoping — Vin Smart Future. Đề tài được chọn theo yêu cầu người học: **Vinmec**. Các pain point, thời gian và sản lượng dưới đây là giả thuyết thiết kế, chưa phải kết quả khảo sát nội bộ Vinmec.

## Phase 1 — SCAN bằng 4 lenses

| # | Công ty | Lens | Bài toán / bottleneck cần kiểm chứng |
|---|---|---|---|
| 1 | Vinmec | Lặp lại | CSKH đọc yêu cầu đặt/đổi lịch, hóa đơn và phản ánh để phân nhóm, rồi soạn phiếu chuyển tiếp thủ công. |
| 2 | Vinmec | Tốn thời gian | Nhân viên đọc nhiều lượt trao đổi để tổng hợp phản ánh trải nghiệm dịch vụ, dễ bỏ sót vấn đề khách đã nêu. |
| 3 | Vinmec | Pain từ người khác | Khách phải hỏi lại giấy tờ hành chính cần chuẩn bị do thông tin nằm ở nhiều hướng dẫn; nhân viên tra cứu và trả lời lặp lại. |
| 4 | Vinmec | AI-upgrade | Phản ánh dịch vụ viết tự do, có viết tắt hoặc nhiều ý, khó tổng hợp thành nhóm chủ đề cho quản lý. |
| 5 | Vinmec | Lặp lại | Kiểm tra trường bắt buộc trong biểu mẫu đề nghị xuất hóa đơn trước khi chuyển kế toán. |
| 6 | Vinhomes | Pain từ người khác | Cư dân mô tả sự cố không thống nhất, nhân viên phải xác định nhóm xử lý và hỏi lại thông tin. |
| 7 | VinFast | Tốn thời gian | CSKH đọc lịch sử ticket dài để lập phiếu bàn giao cho bộ phận kỹ thuật. |

Hai bài toán ngoài Vinmec giúp mở rộng bước quét theo đề; ba thẻ và đề tài cuối cùng đều thuộc Vinmec. Không suy diễn rằng Vinmec chưa có hệ thống số: trang [đăng ký khám chính thức](https://online.vinmec.com/vn/dang-ky-kham) đã có luồng đặt lịch. Cơ hội đề xuất nằm ở yêu cầu văn bản ngoại lệ cần người xử lý, không thay thế luồng đặt lịch hiện có.

## Phase 2 — QUICK-ASSESS

### Quick Problem Card #1 — Phân loại yêu cầu hành chính và lập phiếu nháp

- **Công ty:** Vinmec.
- **Actor:** Nhân viên CSKH tiếp nhận; bộ phận lịch hẹn, kế toán hoặc quản lý dịch vụ nhận bàn giao.
- **Bài toán:** Giảm thời gian đọc, phân nhóm và lập phiếu chuyển tiếp cho yêu cầu hành chính dạng văn bản.
- **Workflow hiện tại:** (1) Nhận yêu cầu → (2) Đọc, phân nhóm → (3) Kiểm tra thông tin hành chính → (4) Soạn phiếu → (5) Chuyển bộ phận phụ trách.
- **Bottleneck:** Bước 2 và 4, giả định 3 + 2 = **5 phút/lượt**; tổng thao tác 8 phút/lượt.
- **AI hỗ trợ:** Hiểu ý định trong văn bản; đề xuất APPOINTMENT / BILLING / FEEDBACK / HUMAN_REVIEW và chọn phiếu nháp theo mẫu.
- **Metric:** Mục tiêu trung vị thao tác ≤ 4 phút thay cho baseline giả định 8 phút; macro-F1 phân nhóm ≥ 0,90 trên tập gán nhãn giữ riêng; 100% phiếu cần nhân viên duyệt.
- **Quick Architecture:** **LLM Feature + Rule + HITL**. Không Agent.
- **Ranh giới:** Không chẩn đoán, xác nhận lịch, cam kết giá hoặc gửi tin. Nội dung y khoa/quyền riêng tư/mơ hồ chuyển người phụ trách.

### Quick Problem Card #2 — Tổng hợp phản ánh trải nghiệm dịch vụ

- **Công ty:** Vinmec; tương ứng SCAN #2.
- **Actor:** Nhân viên CSKH và quản lý chất lượng dịch vụ.
- **Bài toán:** Lập bản tóm tắt trung thực từ chuỗi trao đổi dài về trải nghiệm tiếp đón.
- **Workflow hiện tại:** (1) Nhận phản ánh → (2) Mở lịch sử → (3) Đọc các lượt → (4) Viết tóm tắt → (5) Quản lý rà soát.
- **Bottleneck:** Đọc và viết lại mất giả định **8 phút/phản ánh**, tổng 12 phút.
- **AI hỗ trợ:** Tóm tắt sự kiện có dẫn về lượt trao đổi gốc; không suy đoán lỗi hoặc quy trách nhiệm.
- **Metric:** Mục tiêu tổng thao tác 12 → ≤ 6 phút; ≥ 95% sự kiện quan trọng được giữ; không có sự kiện bịa trên 100 ca kiểm thử có người kiểm tra.
- **Quick Architecture:** **LLM Feature + HITL**.
- **Ranh giới:** Không trả lời khiếu nại tự động; không trộn thông tin của các khách; người duyệt kiểm tra từng sự kiện.

### Quick Problem Card #3 — Hỗ trợ tra cứu giấy tờ hành chính trước khám

- **Công ty:** Vinmec; tương ứng SCAN #3.
- **Actor:** Nhân viên CSKH và khách có nhu cầu chuẩn bị giấy tờ.
- **Bài toán:** Giảm thời gian tìm hướng dẫn hành chính đúng cơ sở và phiên bản.
- **Workflow hiện tại:** (1) Nhận câu hỏi → (2) Xác định cơ sở/dịch vụ → (3) Tra hướng dẫn → (4) Soạn trả lời → (5) Kiểm tra và gửi.
- **Bottleneck:** Tra cứu và soạn mất giả định **5 phút/lượt**, tổng 7 phút.
- **AI hỗ trợ:** Có thể tìm đoạn hướng dẫn đã duyệt và tạo nháp có nguồn; thử tìm kiếm thông thường trước.
- **Metric:** Mục tiêu 7 → ≤ 3 phút; ≥ 95% câu trả lời đúng tài liệu còn hiệu lực trên 100 câu; 100% nháp có nguồn hoặc chuyển người xử lý.
- **Quick Architecture:** **Rule/search trước**, chỉ bổ sung LLM có truy xuất nếu cách diễn đạt tự do gây lỗi đáng kể.
- **Ranh giới:** Không tạo hướng dẫn dùng thuốc, nhịn ăn hoặc chuẩn bị chuyên môn; tài liệu thiếu/hết hiệu lực phải hỏi người phụ trách.

## Chọn đề tài và phản biện

Chọn **Card #1** cho deep-dive: đầu ra hẹp, bộ nhãn nhỏ, có thể demo bằng dữ liệu tổng hợp và đo được thời gian duyệt. Card #2 cần đánh giá chất lượng tóm tắt khó hơn và dễ lộ dữ liệu trong văn bản tự do. Card #3 phụ thuộc kho hướng dẫn chính thức, trong khi search/rule có thể đủ tốt. SCAN #5 nên dùng kiểm tra trường bắt buộc bằng code, chưa có lý do dùng LLM.

**Phản biện chi phí:** Nếu form có sẵn nhóm yêu cầu thì router theo lựa chọn có thể giải quyết phần lớn lưu lượng. Chỉ cân nhắc LLM cho yêu cầu tự do/ngoại lệ, và phải so sánh với baseline từ khóa. Thời gian tiết kiệm phải tính cả sửa lỗi và duyệt, không chỉ thời gian sinh câu trả lời.
