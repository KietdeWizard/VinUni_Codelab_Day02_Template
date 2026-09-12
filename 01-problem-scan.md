# 01 - Problem Scan

## Phase 1 - SCAN

| # | Subsidiary | Lens | Mô tả ngắn bài toán |
|---|---|---|---|
| 1 | VinFast | Time-consuming | Nhân viên CSKH mất nhiều thời gian đọc và phân loại các ticket phản ánh của khách hàng. |
| 2 | VinFast | Repetitive | Nhân viên phải tóm tắt thủ công nội dung ticket trước khi chuyển cho bộ phận kỹ thuật. |
| 3 | VinFast | Stakeholder Pain | Ticket có thể được chuyển chưa đúng bộ phận, khiến khách hàng phải chờ thêm thời gian xử lý. |
| 4 | Xanh SM | Repetitive | Nhân viên vận hành phải xử lý nhiều yêu cầu hỗ trợ tương tự từ tài xế. |
| 5 | Vinhomes | AI-upgrade | Các phản ánh bằng ngôn ngữ tự nhiên của cư dân cần được phân loại để chuyển đến đúng bộ phận xử lý. |

## Quick Problem Card #1

**Bài toán:** Tự động phân loại ticket chăm sóc khách hàng VinFast.

**Công ty thành viên:** VinFast

**Actor:** Nhân viên chăm sóc khách hàng.

**Workflow hiện tại:**

1. Khách hàng gửi ticket.
2. Nhân viên CSKH đọc nội dung.
3. Nhân viên xác định loại vấn đề.
4. Ticket được chuyển tới bộ phận phù hợp.

**Bottleneck:** Nhân viên phải đọc và xác định loại vấn đề thủ công. Giả định mất khoảng 3 phút/ticket.

**AI có thể hỗ trợ:** AI đọc nội dung ticket và đề xuất category phù hợp.

**Success Metric:** Mục tiêu giảm thời gian phân loại từ khoảng 3 phút xuống dưới 30 giây/ticket, đồng thời hướng tới độ chính xác phân loại >= 90%.

**Quick Architecture:** LLM Feature
## Quick Problem Card #2

**Bài toán:** Tự động tóm tắt nội dung ticket khách hàng VinFast.

**Công ty thành viên:** VinFast

**Actor:** Nhân viên CSKH và nhân viên kỹ thuật.

**Workflow hiện tại:**

1. Khách hàng gửi nội dung phản ánh.
2. Nhân viên đọc toàn bộ nội dung.
3. Nhân viên xác định các thông tin quan trọng.
4. Nhân viên viết lại nội dung tóm tắt.
5. Chuyển thông tin cho bộ phận kỹ thuật.

**Bottleneck:** Với ticket dài, nhân viên phải đọc và tóm tắt thủ công.

**AI có thể hỗ trợ:** LLM tạo bản tóm tắt ngắn, giữ lại vấn đề chính của khách hàng.

**Success Metric:** Mục tiêu tạo bản tóm tắt trong dưới 10 giây và giảm thời gian thao tác thủ công của nhân viên.

**Quick Architecture:** LLM Feature
## Quick Problem Card #3

**Bài toán:** Hỗ trợ xác định mức độ ưu tiên của ticket VinFast.

**Công ty thành viên:** VinFast

**Actor:** Nhân viên CSKH.

**Workflow hiện tại:**

1. Nhận ticket.
2. Đọc nội dung.
3. Đánh giá mức độ nghiêm trọng.
4. Gán priority.
5. Chuyển ticket sang hàng đợi xử lý.

**Bottleneck:** Việc đánh giá priority thủ công có thể không đồng nhất giữa các nhân viên.

**AI có thể hỗ trợ:** Phân tích nội dung và đề xuất LOW / MEDIUM / HIGH.

**Success Metric:** Mục tiêu >= 90% ticket được AI đề xuất priority phù hợp trên tập dữ liệu kiểm thử; các trường hợp không chắc chắn được chuyển cho con người review.

**Quick Architecture:** LLM Feature + Human-in-the-loop