# Hướng dẫn chạy và đối chiếu bài nộp

## Các phần đã hoàn thiện

| Yêu cầu | File |
|---|---|
| SCAN ≥ 5 bài toán, đủ 4 lenses, 3 Quick Cards | [01-problem-scan.md](01-problem-scan.md) |
| Current workflow, problem statement 6-field, AI Fit, future flow, Evaluate | [02-deep-dive-report.md](02-deep-dive-report.md) |
| AI Log & Reflection trung thực | [03-ai-log.md](03-ai-log.md) |
| Sơ đồ hiện tại có thời gian, handoff, bottleneck | [04-workflow-diagram.png](04-workflow-diagram.png) |
| System prompt, Gemini SDK, structured output, ≥ 3 adversarial prompts | [starter-code/prompt_prototype.py](starter-code/prompt_prototype.py) |
| Kiểm thử code ngoại tuyến | [starter-code/test_prompt_prototype.py](starter-code/test_prompt_prototype.py) |

Worksheet và bài ví dụ được giữ làm tài liệu đề; các câu trả lời nằm trong những file nộp riêng theo README.

## Chạy trên PowerShell

Từ thư mục gốc dự án, dùng Python của môi trường ảo:

```powershell
.venv\Scripts\python.exe -m pip install -r requirements.txt
.venv\Scripts\python.exe starter-code\prompt_prototype.py --offline
```

Kết quả đã chạy: **12 tests, OK**. Các test dùng mock cho SDK, không gửi dữ liệu và không đánh giá độ chính xác Gemini.

Để chạy mô hình thật, nhập key **tại máy của bạn**, không dán vào file hoặc chat. Lệnh dưới đây hỏi key bằng ô nhập ẩn và chỉ đặt trong phiên PowerShell hiện tại:

```powershell
$geminiSecret = Read-Host 'Gemini API key' -AsSecureString
$env:GEMINI_API_KEY = [System.Net.NetworkCredential]::new('', $geminiSecret).Password
.venv\Scripts\python.exe starter-code\prompt_prototype.py
Remove-Item Env:GEMINI_API_KEY
```

Script cũng chấp nhận `GOOGLE_API_KEY`. Model theo đề là `gemini-2.5-flash`. Chỉ chạy các input tổng hợp đi kèm; prototype chưa có bộ khử định danh cho dữ liệu bệnh nhân thật.

- Exit code `0`: tất cả kiểm tra của chế độ đang chạy đạt.
- Exit code `1`: có kiểm tra lỗi; ở chế độ live, fallback không được tính là mô hình đạt.
- Exit code `2`: thiếu API key khi chạy live.

Chế độ mặc định gọi Gemini thật. Không tự chuyển sang mock khi thiếu key. Sau khi chạy thật, ghi kết quả A1–A6 và N1–N3, ngày chạy, model và lỗi nếu có vào AI log. Hiện tại các kết quả live vẫn là **chưa chạy**.

## Bộ chấm gốc và giới hạn tương thích

```powershell
.venv\Scripts\python.exe autograder\autograder.py --section-a
.venv\Scripts\python.exe autograder\autograder.py --section-b
```

Autograder gốc kiểm từ khóa `draft_only`, `5%`, `dispatch_mobile_charger` cho bài xe điện. Prompt Vinmec chỉ có từ khóa đầu tiên vì hai từ khóa sau không thuộc nghiệp vụ này. Không chỉnh bộ chấm hoặc thêm ranh giới xe điện vô nghĩa vào prompt Vinmec. Vì vậy kiểm tra `--check-code-1` của bộ chấm gốc không đạt với đề tài đã chọn; cần giảng viên đánh giá operational boundary phù hợp Vinmec.

**Kết quả bộ chấm đã chạy ngày 12/09/2026: 7,50/10, exit code 1.** Phần A đủ 4 file (5/5); phần B đạt SDK và adversarial test declarations (2/2), prompt được 0,5/1 do khác từ khóa nghiệp vụ; hai điểm chạy live/assertion chưa đạt vì thiếu key. Đây là điểm kiểm tra tự động của template, không phải điểm nội dung cuối cùng do giảng viên chấm.

Khi thiếu API key, các kiểm tra chạy script/live của bộ chấm cũng không đạt. Khi chạy đủ 9 ca thật, tổng thời gian có thể vượt timeout 30 giây của autograder vốn dành cho ví dụ ngắn; kết quả chạy trực tiếp là bằng chứng cần lưu. Kiểm tra tồn tại file không tự xác nhận điểm nội dung theo rubric.

## Tái tạo sơ đồ và nộp bài

Sơ đồ PNG được vẽ bằng code, có thể tái tạo trên Windows:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File tools\render-workflow.ps1
```

Đang làm việc trên nhánh cá nhân `vinh-02587`. Chưa commit/push/merge hoặc gửi form. Theo README, code `.py` nộp trên nhánh cá nhân; nhóm chỉ chọn lọc tài liệu và hình để đưa vào `main`. Người học kiểm tra nội dung phản ánh, bổ sung thông tin cá nhân theo yêu cầu lớp; trưởng nhóm tổng hợp và nộp form sau thảo luận nhóm.
