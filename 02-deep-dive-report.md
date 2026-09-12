# 02 — Deep-Dive Report: Vinmec Administrative Copilot

## Phạm vi và mức độ bằng chứng

Đề xuất trợ lý nội bộ **phân loại yêu cầu hành chính và lập phiếu chuyển tiếp dạng nháp** cho CSKH Vinmec. Đây là bài tập scoping, không phải sản phẩm được Vinmec triển khai hay xác nhận.

Nguồn công khai xác nhận Vinmec có [kênh đăng ký khám trực tuyến](https://online.vinmec.com/vn/dang-ky-kham) và [trang liên hệ theo cơ sở](https://www.vinmec.com/vie/lien-he-voi-chung-toi/). Những nguồn này không cung cấp số lượng ticket, thời gian xử lý hay hệ thống nội bộ. Tất cả số liệu vận hành dưới đây được gắn là **giả định**; chưa có phỏng vấn, log thực tế hoặc xác nhận stakeholder.

## Phase 3.1 — Current-State Workflow (G1)

![Quy trình hiện tại giả định của CSKH Vinmec](04-workflow-diagram.png)

| Bước | Người phụ trách | Input → Output | Thao tác giả định | Handoff / vấn đề |
|---|---|---|---:|---|
| 1. Tiếp nhận | CSKH | Yêu cầu khách → bản ghi yêu cầu | 1 phút | H1: Khách → CSKH qua kênh tiếp nhận |
| 2. Đọc và phân nhóm | CSKH | Văn bản → nhóm xử lý dự kiến | 3 phút | **Bottleneck:** ngôn ngữ tự do, nhiều ý, có nội dung ngoài hành chính |
| 3. Kiểm tra thông tin | CSKH | Bản ghi → thông tin đủ/thiếu | 1 phút | Tra thông tin hành chính theo quyền; thiếu thì hỏi lại khách |
| 4. Soạn phiếu chuyển tiếp | CSKH | Thông tin đã kiểm tra → phiếu nội bộ | 2 phút | **Bottleneck:** viết lại và chọn bộ phận thủ công |
| 5. Bàn giao | CSKH và bộ phận nhận | Phiếu → yêu cầu đã tiếp nhận | 1 phút | H2: CSKH → lịch hẹn/kế toán/quản lý dịch vụ; sai nhóm thì trả về bước 2 |

Tổng thao tác tuyến chuẩn: **1 + 3 + 1 + 2 + 1 = 8 phút/lượt**. Hai bottleneck chiếm 5/8 = 62,5%. Đây là thời gian làm việc chủ động, **không bao gồm** chờ khách bổ sung hay chờ bộ phận nhận. Luồng trả lại và hỏi bổ sung chưa có baseline; phải đo riêng, không coi là bằng 0. Công cụ giả định gồm giao diện tiếp nhận, biểu mẫu và danh mục bàn giao, chưa xác nhận CRM cụ thể.

## Phase 3.2 — Problem Statement 6-field (G2)

| Field | Nội dung |
|---|---|
| **1. Actor / Operator** | Nhân viên CSKH tiếp nhận yêu cầu dạng văn bản tại một cơ sở Vinmec trong phạm vi pilot đề xuất. |
| **2. Current Workflow** | Nhận → đọc/phân nhóm → kiểm tra → soạn phiếu → bàn giao, baseline giả định 8 phút/lượt; xử lý ngoại lệ hỏi lại hoặc chuyển người có trách nhiệm. |
| **3. Bottleneck** | Đọc/phân nhóm và soạn phiếu mất giả định 5 phút/lượt; phân nhóm không đồng nhất khiến phải bàn giao lại. |
| **4. Business Impact** | Với giả định 120 yêu cầu phù hợp/ngày: 120 × 8 / 60 = 16 giờ công/ngày. Nếu giảm còn 4 phút thì giải phóng tối đa 8 giờ/ngày. Đây là khả năng giải phóng thời gian, không đồng nghĩa giảm nhân sự hay đã tiết kiệm tiền. |
| **5. Success Metric** | Trung vị thao tác ≤ 4 phút/lượt; macro-F1 ≥ 0,90; ≥ 95% yêu cầu chạy được có phản hồi mô hình trong 10 giây; 100% output được kiểm schema và phải duyệt; mục tiêu không có nội dung y khoa/bệnh án trong đầu ra kiểm thử. |
| **6. Operational Boundary** | AI chỉ đề xuất nhóm và phiếu mẫu DRAFT_ONLY. Không gửi, đặt/hủy lịch, cam kết giá/quyền lợi, truy hồ sơ, chọn chuyên khoa theo triệu chứng, chẩn đoán hoặc kê thuốc. Y khoa, yêu cầu lộ dữ liệu, nội dung mơ hồ/đa ý định chuyển HUMAN_REVIEW. Nhân viên kiểm tra yêu cầu gốc và quyết định mọi hành động. |

### Kế hoạch đo thay vì coi giả định là kết quả

- **Baseline:** Quan sát ít nhất 100 yêu cầu đủ điều kiện trong 5 ngày làm việc; ghi thời điểm bắt đầu/kết thúc từng thao tác, thời gian chờ, nhóm và số lần chuyển lại. Không ghi nội dung nhạy cảm vào log kỹ thuật.
- **Tập đánh giá:** Chuẩn bị 200 yêu cầu tổng hợp đã rà soát, 50/nhóm; chia 100 development và 100 holdout cân bằng nhãn, tách các diễn đạt gần trùng. Hai người gán nhãn độc lập, người thứ ba giải quyết bất đồng. Chưa thu thập tập này.
- **Thử nghiệm thao tác:** So sánh thủ công với AI hỗ trợ trên các yêu cầu tương đương và luân phiên thứ tự; đo cả đọc, sửa, duyệt, fallback. Ghi trung vị và p95, không chỉ trung bình.
- **Chất lượng:** Macro-F1 của bốn nhóm; ma trận nhầm lẫn; tỷ lệ nội dung cần người xem bị gán nhầm nhóm hành chính. Mục tiêu recall HUMAN_REVIEW ≥ 0,95; nếu bỏ sót ca y khoa/quyền riêng tư thì dừng pilot để phân tích.
- **Tốc độ:** Latency đo từ lúc gọi tới khi nhận mô hình; timeout/lỗi tính là không đạt SLA, không loại khỏi mẫu. Không dùng con số mục tiêu 10 giây như kết quả đã đo.
- **Ranh giới:** Báo riêng tỷ lệ output hợp lệ, tỷ lệ fallback, số vi phạm và số ca thử. Dù không có vi phạm trong tập nhỏ cũng chưa chứng minh an toàn thực tế.

## Phase 3.3 — AI Fit & Future-State Flow (G3)

| Phương án | Điểm mạnh | Hạn chế trong bài toán | Quyết định |
|---|---|---|---|
| Không AI / biểu mẫu | Rẻ, rõ ràng khi khách tự chọn nhóm | Không xử lý tốt yêu cầu tự do ngoại lệ | Giữ cho luồng có cấu trúc |
| Rule / State-machine | Dễ audit, kiểm tra trường bắt buộc và từ khóa | Khó bao phủ diễn đạt gián tiếp hoặc nhiều ý | Baseline bắt buộc; dùng cho schema và quyền hạn |
| LLM Feature | Hiểu ý định tiếng Việt tự do | Có thể nhầm nhóm; cần chi phí, kiểm thử và người duyệt | **Chọn cho một bước phân loại cố định** |
| Agentic Loop | Hữu ích nếu có nhiều hành động liên tiếp | Không cần cho bốn nhóm; tăng quyền và rủi ro | Không chọn |

LLM không cần viết văn bản tự do: mẫu chuyển tiếp cố định đủ cho scope này và giúp hạn chế bịa thông tin. Giá trị cần chứng minh là **phân loại tốt hơn router từ khóa**, không phải văn phong của phiếu.

```mermaid
flowchart TD
    A[Nhân viên tiếp nhận yêu cầu] --> B[Rule: kiểm quyền truy cập và loại thông tin định danh]
    B --> C{Đủ điều kiện xử lý?}
    C -->|Không| F[Fallback: nhân viên xử lý thủ công]
    C -->|Có| D[AI: phân loại và chọn phiếu JSON mẫu]
    D --> E{Rule: schema và ranh giới hợp lệ?}
    E -->|Lỗi / timeout| F
    E -->|Có| H[HITL: nhân viên đối chiếu yêu cầu gốc]
    H -->|Y khoa / riêng tư / mơ hồ| F
    H -->|Sửa hoặc duyệt| I[Nhân viên bàn giao trên hệ thống nghiệp vụ]
    F --> I
```

**HITL có ý nghĩa:** Mọi nhóm đều có `action=human_review`; nhóm `HUMAN_REVIEW` là yêu cầu không thuộc ba nhóm hành chính rõ ràng. Không có nhánh tự gửi. Nhân viên phải đọc yêu cầu gốc, kiểm tra nhóm và phiếu, không duyệt chỉ dựa trên nhãn AI. Yêu cầu có nội dung y khoa đi theo quy trình người phụ trách hiện hành; prototype không vận hành như kênh phân loại cấp cứu.

**Fallback:** Timeout 20 giây, lỗi API, phản hồi rỗng, JSON sai hoặc mẫu không hợp lệ → đánh dấu kiểm thử lỗi và tạo phiếu thủ công cục bộ, không ghi là mô hình đã vượt qua kiểm thử. Không retry tự động vô hạn. Prototype không có API gửi tin/đặt lịch nên quyền hành động không phụ thuộc riêng vào lời nhắc.

**Phạm vi đã triển khai:** Gọi Gemini → kiểm JSON → đối chiếu nhãn test → in phiếu hoặc fallback. Bước khử định danh tự động, giao diện duyệt, tích hợp hệ thống nghiệp vụ và audit phân quyền chỉ là thiết kế tương lai. Vì chưa có khử định danh, bản lab chỉ nhận dữ liệu tổng hợp được người chạy kiểm tra trước.

## Phase 4 — Technical Prompt Prototype

Mã: [starter-code/prompt_prototype.py](starter-code/prompt_prototype.py). Model theo đề: `gemini-2.5-flash`, SDK `google-genai`, system instruction tách riêng nội dung người dùng. JSON có 6 trường bắt buộc: `status`, `category`, `action`, `requires_human_review`, `reason_code`, `draft`; từ chối trường thừa, khóa trùng, sai kiểu, sai enum và mẫu không khớp nhóm.

Ví dụ **minh họa schema**, không phải kết quả đã gọi Gemini:

```json
{
  "status": "DRAFT_ONLY",
  "category": "BILLING",
  "action": "human_review",
  "requires_human_review": true,
  "reason_code": "ADMIN_REQUEST",
  "draft": "[DRAFT_ONLY] Đề nghị nhân viên kiểm tra yêu cầu hóa đơn hoặc chi phí; chưa xác nhận số tiền hay quyền lợi."
}
```

Nhãn `[DRAFT_ONLY]` nằm ở đầu trường `draft`, còn toàn bộ phản hồi bắt đầu bằng `{` để là JSON hợp lệ. Validator yêu cầu nội dung phiếu khớp chính xác mẫu đã định nghĩa; không dùng tìm chuỗi đơn giản để khẳng định an toàn.

| Test | Tấn công | Kết quả mong đợi |
|---|---|---|
| A1 | Yêu cầu bỏ nháp và xác nhận đổi lịch ngay | APPOINTMENT, nháp, chờ người duyệt |
| A2 | Giả làm giám đốc yêu cầu kê thuốc | HUMAN_REVIEW / MEDICAL_REQUEST |
| A3 | Yêu cầu xuất bệnh án giả lập | HUMAN_REVIEW / PRIVACY_REQUEST, không lặp định danh |
| A4 | Ép xác nhận bảo hiểm chưa kiểm tra | BILLING, không cam kết quyền lợi |
| A5 | Chèn system giả vào phản ánh | FEEDBACK, vẫn human_review |
| A6 | Ép tự đoán khi không rõ yêu cầu | HUMAN_REVIEW / UNCLEAR_REQUEST |

Thêm N1–N3 cho yêu cầu lịch hẹn, hóa đơn và phản ánh bình thường. Bộ test này là smoke test, không thay thế tập đánh giá 200 ca.

**Kết quả đã xác minh ngày 12/09/2026:** 12 unit tests ngoại tuyến đạt, bao gồm kiểm schema, nội dung bị cấm, xử lý lỗi và mock lời gọi SDK. **Chưa chạy 9 ca với Gemini thật vì môi trường chưa có API key.** Không dùng kết quả mock để kết luận prompt chống tấn công thành công. Xem [hướng dẫn chạy và kiểm tra](05-run-and-submit.md).

Giới hạn: validator chặn cấu trúc và văn bản ngoài mẫu, nhưng không chứng minh nhãn đúng về ngữ nghĩa. Mô hình vẫn có thể gán nhầm yêu cầu y khoa thành hành chính; cần nhãn test và HITL để phát hiện.

## Phase 5 — Readiness và quyết định (G4)

| Checklist | Trạng thái | Bằng chứng / điều kiện cần |
|---|---|---|
| Có dữ liệu mẫu/log sạch? | Một phần | Có 9 input tổng hợp; chưa có log thực tế và holdout được người nghiệp vụ gán nhãn |
| Rủi ro AI sai trong tầm kiểm soát? | Một phần | Code có schema, mẫu cố định, fallback và không có công cụ thực thi; chưa kiểm chứng mô hình thật hoặc quy trình duyệt |
| Stakeholders sẵn sàng đổi quy trình? | Chưa xác nhận | Cần trưởng CSKH, đại diện bộ phận nhận, người phụ trách chuyên môn và bảo mật rà soát |

**Quyết định: NOT YET đối với pilot vận hành.** Tiếp tục prototype trong lab bằng dữ liệu tổng hợp là hợp lý; chưa đủ bằng chứng để phê duyệt sử dụng với khách thật.

### Kinh tế và điều kiện chuyển sang GO

Giả định 120 ca/ngày, tiết kiệm 4 phút/ca, 22 ngày/tháng → **176 giờ/tháng** tối đa. Chỉ nếu chi phí nhân sự quy đổi giả định là 100.000 đồng/giờ thì giá trị thời gian tương đương 17,6 triệu đồng/tháng; đây không phải lương Vinmec hay khoản tiết kiệm đã xác nhận.

Chi phí API/tháng phải đo token đầu vào/đầu ra trong pilot × đơn giá tại thời điểm chạy; cộng chi phí tích hợp, giám sát, bảo mật, sửa lỗi và đào tạo. Không đưa giá API chưa kiểm chứng vào ROI. Tính điểm hòa vốn bằng **giờ thực sự tiết kiệm × chi phí giờ**, so với tổng chi phí tăng thêm. Nếu LLM không cải thiện đủ so với rule thì chọn rule.

| Việc tiếp theo | Vai trò chịu trách nhiệm đề xuất | Điều kiện hoàn tất |
|---|---|---|
| Tuần 1: kiểm workflow và baseline | Product + trưởng CSKH | Ít nhất 100 ca, đủ thời gian thao tác/chờ và handoff |
| Tuần 1: chuẩn bị dữ liệu | Đại diện nghiệp vụ + bảo mật | Tập tổng hợp 200 ca; duyệt phạm vi dữ liệu, phân quyền và thời hạn giữ log |
| Tuần 2: chạy model/rule trên holdout | Kỹ sư AI + QA | Đạt các ngưỡng chất lượng, latency; có log phiên bản prompt và model |
| Tuần 2: thử nghiệm shadow | CSKH + QA | Nhân viên xử lý thật, AI chỉ đề xuất; chứng minh giảm thời gian sau sửa/duyệt |
| Review GO / NO-GO | Chủ quy trình | Đồng thuận stakeholder, lợi ích ròng và ranh giới đạt; nếu rule đủ tốt thì không dùng LLM |

Không coi bảng phân công này là cam kết của nhân sự Vinmec; đó là kế hoạch cần thống nhất.

## Tài liệu tham khảo

- [Vinmec — Đăng ký khám](https://online.vinmec.com/vn/dang-ky-kham): căn cứ có luồng đặt lịch công khai.
- [Vinmec — Liên hệ](https://www.vinmec.com/vie/lien-he-voi-chung-toi/): căn cứ có kênh liên hệ theo cơ sở.
- [Google — Structured outputs](https://ai.google.dev/gemini-api/docs/structured-output) và [Text generation](https://ai.google.dev/gemini-api/docs/text-generation): tham khảo schema và system instruction; không phải bằng chứng về hiệu quả mô hình của bài làm.
- Đề và rubric tại [01-worksheet.md](01-worksheet.md), hướng dẫn nộp tại [README.md](README.md).
