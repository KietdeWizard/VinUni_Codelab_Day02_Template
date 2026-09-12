# Lab 02 — Worksheet: AI Product Scoping (Vin Smart Future)

---

## 🏛️ 1. Bối cảnh thực tế: Vin Smart Future (Vingroup)

**Vingroup** — Tập đoàn tư nhân lớn nhất Việt Nam — vừa sáp nhập toàn bộ các phòng ban công nghệ thuộc các công ty thành viên thành một đơn vị công nghệ thống nhất mang tên **Vin Smart Future**. 

Nhiệm vụ của **Vin Smart Future** là xây dựng các giải pháp AI, số hóa, và tự động hóa cốt lõi để nâng cao hiệu suất vận hành và trải nghiệm khách hàng xuyên suốt các công ty thành viên:
* 🚗 **VinFast:** Hệ thống xe điện thông minh (EV), trợ lý AI ảo trong xe, dự đoán bảo trì pin, và quản lý chuỗi cung ứng sản xuất.
* 🚕 **Xanh SM (GSM):** Vận hành đội xe taxi/xe máy điện thông minh, điều vận thông minh (Smart Dispatching), tối ưu hóa lộ trình di chuyển.
* 🏢 **Vinhomes:** Quản lý đô thị thông minh (Smart Cities), trợ lý cư dân thông minh, tối ưu hóa mức tiêu thụ năng lượng.
* 🏥 **Vinmec:** Y tế thông minh, chẩn đoán hình ảnh bằng AI, tối ưu hóa quản lý hồ sơ bệnh án.
* 🎢 **Vinpearl / VinWonders:** Trải nghiệm du lịch số hóa, quản lý phòng và luồng khách thông minh tại các khu vui chơi.

Trong buổi Lab hôm nay, nhóm của bạn sẽ đóng vai trò là **AI Product Engineer** tại **Vin Smart Future**, tiến hành tìm kiếm, scoping, phân tích độ khả thi, thiết lập ranh giới vận hành, và xây dựng một **bản mẫu kỹ thuật (prompt prototype)** cho một bài toán cụ thể thuộc một trong những mảng kinh doanh trên.

---

## 📊 2. Cơ cấu tính điểm bài lab

### 👥 Điểm nhóm (60 điểm)

| Gate | Điểm | Deliverable | Tiêu chí chấm |
|---|---:|---|---|
| **G1. Workflow Mapping** | 20 | Problem Deep-Dive | Vẽ chi tiết quy trình hiện tại: các bước, handoff, thời gian, bottleneck |
| **G2. Problem Statement** | 20 | Problem Deep-Dive | Problem Statement 6-field bám sát thực tế, metric có số và ranh giới rõ ràng |
| **G3. AI Fit & Future Flow** | 10 | Problem Deep-Dive | So sánh Rule vs LLM vs Agent, future flow có bước AI, ranh giới và Fallback |
| **G4. Decision Quality** | 10 | Problem Deep-Dive | Quyết định Go/Not Yet/No-Go trung thực và có chứng cứ rõ ràng |

### 👤 Điểm cá nhân (40 điểm)

| Gate | Điểm | Deliverable | Tiêu chí chấm |
|---|---:|---|---|
| **I1. Scan & Cards** | 15 | Quick Cards | Liệt kê 5 problems sử dụng 3 lenses, hoàn thiện 3 quick cards chất lượng |
| **I2. Prototyping** | 10 | 02-lab/ | Chạy thử nghiệm programmatic prompt prototype thành công |
| **I3. AI Log & Reflection** | 15 | 03-ai-log.md | Phản ánh trung thực về việc dùng AI làm thought-partner (giúp gì, sai gì, sửa gì) |

---

# 🚀 Phase 0 — worked Example: Xanh SM Intelligent Dispatcher (15 min)

*Giảng viên walk-through ví dụ thực tế từ Vin Smart Future để bạn hiểu rõ cách scoping một bài toán AI.*
Đọc chi tiết worked example tại file [02-deliverable-example.md](02-deliverable-example.md).

---

# 🔍 Phase 1 — SCAN (Cá nhân, 20 min)

Hãy sử dụng **4 Lenses** dưới đây để quét qua hoạt động vận hành của các công ty thành viên Vingroup. Ghi lại **ít nhất 5 bài toán/bottleneck** thực tế.

### 4 Lenses tìm bài toán AI cho Vingroup:
1. **Lặp lại (Repetitive):** Tác vụ lặp đi lặp lại nhiều lần hằng ngày. (Ví dụ: So khớp hóa đơn sạc điện tại VinFast, route lại chuyến taxi tại Xanh SM).
2. **Tốn thời gian (Time-consuming):** Tác vụ ngốn thời gian xử lý thủ công của nhân viên. (Ví dụ: Soạn thảo phản hồi đánh giá 1-star của cư dân Vinhomes).
3. **AI có thể tốt hơn (AI-upgrade):** Dịch vụ khách hàng hiện tại còn chậm hoặc phản hồi rập khuôn. (Ví dụ: Chatbot CSKH Vinpearl hỗ trợ đặt vé vui chơi).
4. **Pain từ người khác (Stakeholder Pain):** Bottleneck khiến khách hàng hoặc nhân viên thực địa phàn nàn. (Ví dụ: Tài xế Xanh SM phàn nàn về việc hệ thống gợi ý điểm đón khách không chính xác).

> [!TIP]
> **🤖 AI Prompts — Partner brainstorm:**
> Hãy sử dụng prompt sau để brainstorm các bài toán thực tế nếu bạn chưa có ý tưởng:
> *"Tôi là AI Engineer tại Vin Smart Future (Vingroup). Tôi đang tìm kiếm các pain point vận hành cụ thể có thể tối ưu bằng AI cho mảng [Chọn một: VinFast / Xanh SM / Vinhomes / Vinmec]. Hãy gợi ý cho tôi 5 quy trình nghiệp vụ thủ công, tốn nhiều thời gian và gây rò rỉ hiệu suất kèm con số thống kê ước tính về tổn thất."*

### 📝 List bài toán của tôi:
| # | Subsidiary (VinFast/Xanh SM...) | Lens | Mô tả ngắn bài toán |
|---|----------------------------------|------|---------------------|
| 1 | Vinmec| Tốn thời gian| Bác sĩ mất 20–30 phút/bệnh nhân để viết tóm tắt hồ sơ xuất viện từ bệnh án điện tử + xét nghiệm + ghi chú.|
| 2 | Vinhomes| Lặp lại| Phân loại thủ công hàng trăm phản ánh cư dân/ngày trên App Resident (mất nước, hỏng đèn, ồn ào) về đúng ban quản lý tòa.|
| 3 | VinFast| Lặp lại| So khớp hóa đơn sạc điện của hàng nghìn trụ sạc đối tác với dữ liệu hệ thống tài chính mỗi tuần.|
| 4 | Vinpearl| Pain từ người khác| Quét review Booking/Agoda/Google Maps để phát hiện phàn nàn khẩn cấp (phòng bẩn, thái độ nhân viên) gửi Manager muộn.|
| 5 | Xanh SM| AI có thể tốt hơn| Tài xế mô tả sự cố bằng tiếng Việt tự nhiên ("xe kêu cụp cụp ở bánh trước"), tổng đài phải phân loại thủ công sang mã lỗi kỹ thuật.|
| 6 | VinUni| Tốn thời gian| Giảng viên chấm bài lab code thủ công, phản hồi chung chung, sinh viên không hiểu lỗi sai ở đâu.|

---

# 🃏 Phase 2 — QUICK-ASSESS (Cá nhân, 30 min)

Chọn **top 3 bài toán** từ danh sách trên và hoàn thiện **3 Quick Problem Cards** dưới đây (10 phút/card).

```
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #___                                     │
│                                                             │
│ Bài toán (1 câu): ________________________________________  │
│ Công ty thành viên: [ ] VinFast  [ ] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác (Ghi rõ)________  │
│                                                             │
│ Ai đang đau (Actor)? ______________________________________ │
│                                                             │
│ Workflow thủ công hiện tại (3-5 bước):                      │
│   1. ___ ──> 2. ___ ──> 3. ___ ──> 4. ___                   │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? ___ (⏱ ___ phút/lượt)      │
│ AI có thể nhảy vào hỗ trợ ở bước nào? _____________________ │
│                                                             │
│ Đo thành công bằng gì (Metric có số)? ______________________ │
│   VD: "Giảm thời gian soạn phản hồi từ 10 min ──> under 2 min"│
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [ ] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```

> [!TIP]
> **🤖 AI Prompts — Stress-Test thẻ bài toán:**
> Hãy dán nội dung thẻ bài toán của bạn vào LLM để nhận phản biện:
> *"Đây là một thẻ bài toán vận hành tôi đề xuất cho Vin Smart Future: [Dán nội dung]. Hãy đóng vai trò là một CFO và Trưởng phòng Vận hành cực kỳ khắt khe, chỉ ra cho tôi 3 điểm yếu về logic, metric, và giải thích vì sao rule-based code thông thường có thể giải quyết bài toán này tốt hơn là dùng AI."*

┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #1                                       │
│                                                             │
│ Bài toán: Bác sĩ Vinmec viết tóm tắt hồ sơ xuất viện thủ    │
│ công từ nhiều nguồn dữ liệu rời rạc, mất 20-30 phút/ca.     │
│ Công ty thành viên: [x] Vinmec                              │
│                                                             │
│ Ai đang đau? Bác sĩ điều trị (quá tải), bệnh nhân (chờ lâu)│
│                                                             │
│ Workflow thủ công hiện tại (5 bước):                        │
│   1. Mở bệnh án điện tử (EMR) tra cứu thông tin            │
│   → 2. Mở kết quả xét nghiệm/X-quang/CT ở hệ thống khác    │
│   → 3. Tổng hợp ghi chú điều trị + đơn thuốc               │
│   → 4. Viết tóm tắt bằng ngôn ngữ y khoa                   │
│   → 5. Dịch/diễn giải sang ngôn ngữ bệnh nhân hiểu được    │
│                                                             │
│ Bước nào tốn nhất? Bước 3-4-5 (⏱ 20-30 phút/lượt)          │
│ AI nhảy vào hỗ trợ ở bước nào? Bước 3-4-5                   │
│ (Trích xuất EMR → draft tóm tắt → đơn giản hóa ngôn ngữ)   │
│                                                             │
│ Metric: Giảm 25 phút → dưới 5 phút draft/ca (80% giảm).     │
│         Tỉ lệ bác sĩ chấp nhận chỉnh sửa <20%.             │
│                                                             │
│ Quick Architecture: [x] LLM Feature (có HITL bác sĩ duyệt) │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #2                                       │
│                                                             │
│ Bài toán: Phân loại và route tự động hàng trăm phản ánh     │
│ của cư dân trên App Vinhomes Resident về đúng ban QL tòa.   │
│ Công ty thành viên: [x] Vinhomes                            │
│                                                             │
│ Ai đang đau? Cư dân (chờ phản hồi lâu), CSKH (quá tải)      │
│                                                             │
│ Workflow thủ công hiện tại (4 bước):                        │
│   1. Cư dân gửi phản ánh dạng văn bản tự do qua App        │
│   → 2. CSKH đọc từng ticket, gán nhãn thủ công              │
│      (mất nước/hỏng đèn/ồn ào/...)                         │
│   → 3. CSKH route đến ban QL tòa nhà tương ứng             │
│   → 4. Ban QL xử lý & phản hồi lại cư dân                  │
│                                                             │
│ Bước nào tốn nhất? Bước 2-3 (⏱ 8-10 phút/ticket) 🔴         │
│ AI nhảy vào hỗ trợ ở bước nào? Bước 2 (auto-classify +      │
│ route) — dùng LLM phân loại + bảng mapping tòa → ban QL.    │
│                                                             │
│ Metric: Giảm thời gian phân loại từ 10 phút → under 30 giây │
│         (≥95% ticket auto-route đúng ban QL).               │
│         Giảm SLA phản hồi lần đầu từ 12h → under 2h.       │
│                                                             │
│ Quick Architecture: [ ] No AI  [x] Rule + LLM classifier    │
│   (Rule cho từ khóa rõ ràng, LLM cho ticket mơ hồ)         │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #3                                       │
│                                                             │
│ Bài toán: Quét review từ Booking/Agoda/Google Maps để phát  │
│ hiện phàn nàn khẩn cấp (phòng bẩn, thái độ NV) gửi Manager. │
│ Công ty thành viên: [x] Vinpearl                            │
│                                                             │
│ Ai đang đau? Manager khách sạn (bị động), khách mới         │
│ (đọc review xấu trước khi đặt phòng → mất booking).         │
│                                                             │
│ Workflow thủ công hiện tại (4 bước):                        │
│   1. Nhân viên Marketing vào từng platform copy review     │
│   → 2. Đọc và note các review negative                     │
│   → 3. Gửi email tổng hợp cho Manager hàng tuần            │
│   → 4. Manager xử lý (thường đã quá muộn)                  │
│                                                             │
│ Bước nào tốn nhất? Bước 1-2 (⏱ 3-4 giờ/tuần/khách sạn) 🔴   │
│ AI nhảy vào hỗ trợ ở bước nào? Bước 1-3                     │
│ (Scrape → phân loại sentiment/urgency → alert real-time)    │
│                                                             │
│ Metric: Từ phát hiện review xấu sau 7 ngày → dưới 2 giờ.    │
│         Giảm 3 giờ/tuần nhân viên Marketing.                │
│         Tỉ lệ review 1-2★ được phản hồi trong 24h ≥90%.     │
│                                                             │
│ Quick Architecture: [x] LLM Feature (classification +       │
│ draft phản hồi cho Manager duyệt)                           │
└─────────────────────────────────────────────────────────────┘

---

# 🏗️ Phase 3 — DEEP-DIVE (Nhóm, 85 min)

## 3.1. Current-State Workflow Mapping (25 min)
**Vẽ quy trình hiện tại lên bảng/giấy A3.** Sử dụng các ký hiệu:
* 🔴 **Bottleneck:** Bước gây tắc nghẽn, tốn thời gian, hoặc sai sót nhiều nhất.
* 🔄 **Handoff:** Điểm chuyển giao thông tin giữa người và hệ thống, hoặc giữa các bộ phận.
* Ghi rõ thời gian vận hành trung bình: **Tổng cộng = ____ phút/lượt**.

[B1: Bác sĩ mở EMR] ──> [B2: 🔄 Tra cứu XN ở hệ thống LIS]
   ⏱ 3'                       ⏱ 5' 🔴
        │
        ▼
[B3: 🔄 Đọc ghi chú điều dưỡng] ──> [B4: Viết tóm tắt y khoa]
   ⏱ 5' 🔴                              ⏱ 10' 🔴
                                              │
                                              ▼
                                    [B5: Diễn giải cho bệnh nhân]
                                       ⏱ 5'
Tổng: ~28 phút/ca. Bottleneck: B4 (viết tay tóm tắt).

## 3.2. Problem Statement (6-field) & Metrics (15 min)
Điền đầy đủ 6 trường thông tin của bài toán:

| Field | Nội dung chi tiết |
|---|---|
| **1. Actor / Operator** | Bác sĩ điều trị tại Khoa Nội – Vinmec Times City. |
| **2. Current Workflow** | Bác sĩ mở EMR, tra cứu kết quả XN từ LIS/PACS, đọc ghi chú điều dưỡng, viết tóm tắt xuất viện bằng Word, rồi in và giải thích cho bệnh nhân. 5 bước, ~28 phút/ca. |
| **3. Bottleneck** | Bước 4 (viết tóm tắt, 10 phút): phải tổng hợp dữ liệu từ 3 hệ thống rời rạc, viết bằng ngôn ngữ y khoa chuẩn, đồng thời phải dễ hiểu cho bệnh nhân. |
| **4. Business Impact** | Mỗi bác sĩ làm ~15 ca/ngày → ~2.5 giờ/ngày chỉ để viết tóm tắt. Toàn viện 100 bác sĩ → ~250 giờ/ngày lãng phí ≈ 31 FTE. Nguy cơ chậm xuất viện, giảm NPS. |
| **5. Success Metric** | 1. Thời gian draft tóm tắt: 28 phút → < 5 phút (giảm ≥ 80%).
2. Tỉ lệ bác sĩ chấp nhận draft với chỉnh sửa nhỏ: ≥ 80%.
3. Không có sai sót lâm sàng nào do draft (0 sự cố). |
| **6. Operational Boundary** | ✅ Được: đọc EMR/LIS/PACS, draft tóm tắt, đề xuất cách diễn giải.
❌ CẤM: tự động ký/phát hành, tự chẩn đoán mới, tự kê đơn, đưa ra tiên lượng sống/chết.
🟢 Bắt buộc: bác sĩ review + ký trước khi in cho bệnh nhân. |

## 3.3. Future-State Flow & AI Fit (25 min)
* **Xác định mức AI Fit (AI-Fit Matrix):** Giải pháp thuộc nhóm nào? [ ] Rule / State-Machine [ ] LLM Feature [ ] Agentic Loop.
* **Vẽ Future-State Flow:** Đánh dấu rõ:
  * 🔵 **AI Step:** Tác vụ LLM xử lý.
  * 🟢 **Human Step (HITL):** Bước con người phê duyệt/review (Human-in-the-loop).
  * ↩️ **Fallback:** Kế hoạch dự phòng khi LLM trả về kết quả lỗi hoặc không tự tin.

AI Fit: LLM Feature + HITL (không cần Agent vì quy trình tuyến tính, rủi ro cao nếu tự trị).
Future flow:
[B1: 🔵 AI đọc EMR/LIS/PACS] ──> [B2: 🔵 LLM draft tóm tắt]
                                        │
                                        ▼
                              [B3: 🟢 Bác sĩ review & ký]
                                        │
                                        ▼
                              ↩️ Fallback: Nếu AI draft lỗi/hallucination
                                 → bác sĩ viết tay như cũ (giữ quy trình cũ).
---

# 💻 Phase 4 — TECHNICAL PROMPT PROTOTYPE (Nhóm, 30 min)

Để đảm bảo kỹ sư của Vin Smart Future luôn giữ vững năng lực lập trình, nhóm của bạn sẽ tiến hành **lập trình bản mẫu prompt** trực tiếp trên **Gemini 2.5 Flash** bằng Python để stress-test hệ thống.

### Hướng dẫn thực hiện:
1. Mở file [starter-code/prompt_prototype.py](starter-code/prompt_prototype.py) bằng VS Code/Cursor.
2. Hoàn thiện các nội dung sau:
   * **System Prompt:** Viết chỉ thị cực kỳ nghiêm ngặt quy định vai trò, nhiệm vụ, định dạng output và **Operational Boundary (Ranh giới cấm)** của mô hình.
   * **Structured Output:** Định nghĩa định dạng JSON output rõ ràng.
   * **Adversarial Test Cases:** Viết ít nhất 3 prompts "tấn công" (Adversarial inputs) cố tình dụ AI vượt ranh giới hoặc đưa ra câu trả lời không được phép để kiểm tra xem ranh giới của bạn có thực sự vững chắc.
3. Chạy file python:
   ```bash
   python3 prompt_prototype.py
   ```
4. Kiểm tra xem các ranh giới an toàn có bị LLM phá vỡ hay không và ghi lại kết quả vào worksheet.

---

# 🏁 Phase 5 — EVALUATE (Nhóm, 20 min)

### AI Readiness Checklist:
1. [ ] Chúng tôi có sẵn dữ liệu mẫu/logs sạch để test?
2. [ ] Rủi ro khi AI sai có nằm trong tầm kiểm soát (qua HITL hoặc Fallback)?
3. [ ] Stakeholders sẵn sàng thay đổi quy trình làm việc cũ?

### Quyết định cuối cùng của Ban Giám Đốc Vin Smart Future:
[ ] **GO (Bắt đầu xây dựng Prototype):** Bắt đầu phát triển với scope hẹp.
[ ] **NOT YET (Cần tích lũy thêm dữ liệu/xác lập baseline):** Trì hoãn để chuẩn bị thêm.
[ ] **NO-GO (Không khả thi / Rule-based tốt hơn):** Hủy bỏ dự án AI này.

**Justification (Lý giải quyết định dựa trên bằng chứng kỹ thuật và chi phí):**
> *Viết lý giải chi tiết tại đây*

---

# 📝 Phase 6 — REFLECTION (Cá nhân)
*Ghi nhận phản ánh của cá nhân bạn về việc phối hợp với AI trong buổi học hôm nay vào file `03-ai-log.md`.*
Awsome