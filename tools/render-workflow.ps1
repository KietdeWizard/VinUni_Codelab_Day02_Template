# Rebuild the original code-drawn workflow diagram (Windows / System.Drawing).
Add-Type -AssemblyName System.Drawing
$root = Split-Path -Parent $PSScriptRoot
$bitmap = New-Object System.Drawing.Bitmap 1800,1000
$canvas = [System.Drawing.Graphics]::FromImage($bitmap)
$canvas.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$canvas.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$canvas.Clear([System.Drawing.ColorTranslator]::FromHtml('#F4F7FB'))
$ink = New-Object System.Drawing.SolidBrush ([System.Drawing.ColorTranslator]::FromHtml('#19324A'))
$muted = New-Object System.Drawing.SolidBrush ([System.Drawing.ColorTranslator]::FromHtml('#516579'))
$blue = New-Object System.Drawing.SolidBrush ([System.Drawing.ColorTranslator]::FromHtml('#096F87'))
$red = New-Object System.Drawing.SolidBrush ([System.Drawing.ColorTranslator]::FromHtml('#B54137'))
$titleFont = New-Object System.Drawing.Font 'Segoe UI',32,([System.Drawing.FontStyle]::Bold)
$headFont = New-Object System.Drawing.Font 'Segoe UI',21,([System.Drawing.FontStyle]::Bold)
$bodyFont = New-Object System.Drawing.Font 'Segoe UI',18
$smallFont = New-Object System.Drawing.Font 'Segoe UI',16
$pen = New-Object System.Drawing.Pen ([System.Drawing.ColorTranslator]::FromHtml('#096F87')),3
$pen.CustomEndCap = New-Object System.Drawing.Drawing2D.AdjustableArrowCap 5,5
function Write-Text($text,$font,$brush,$x,$y,$width,$height) {
    $rect = New-Object System.Drawing.RectangleF $x,$y,$width,$height
    $canvas.DrawString($text,$font,$brush,$rect)
}
Write-Text 'VINMEC | Quy trình tiếp nhận yêu cầu hành chính' $titleFont $ink 60 42 1680 80
Write-Text 'CURRENT STATE • Mô hình giả định cho bài lab, chưa được Vinmec xác nhận' $bodyFont $muted 62 123 1680 50
Write-Text 'H1  KHÁCH → CSKH' $headFont $blue 65 211 850 42
Write-Text 'H2  CSKH → BỘ PHẬN NHẬN' $headFont $blue 1220 211 530 42
$steps = @(
    @('01  Tiếp nhận','1 phút','CSKH','Yêu cầu khách','Bản ghi yêu cầu'),
    @('02  Phân nhóm','3 phút','CSKH','Văn bản tự do','Nhóm dự kiến'),
    @('03  Kiểm tra','1 phút','CSKH','Bản ghi yêu cầu','Thông tin đủ/thiếu'),
    @('04  Soạn phiếu','2 phút','CSKH','Thông tin đã kiểm tra','Phiếu nội bộ'),
    @('05  Bàn giao','1 phút','CSKH + bên nhận','Phiếu nội bộ','Yêu cầu được nhận')
)
for ($i = 0; $i -lt 5; $i++) {
    $x = 60 + $i * 342
    $fillColor = if ($i -eq 1 -or $i -eq 3) { '#FDECE8' } else { '#FFFFFF' }
    $fill = New-Object System.Drawing.SolidBrush ([System.Drawing.ColorTranslator]::FromHtml($fillColor))
    $canvas.FillRectangle($fill,$x,280,310,350)
    $s = $steps[$i]
    Write-Text $s[0] $headFont $ink ($x+18) 300 283 50
    Write-Text $s[1] $titleFont $blue ($x+18) 365 280 65
    Write-Text $s[2] $bodyFont $muted ($x+18) 441 285 50
    Write-Text ('Vào: ' + $s[3]) $smallFont $ink ($x+18) 505 279 48
    Write-Text ('Ra: ' + $s[4]) $smallFont $ink ($x+18) 565 279 54
    if ($i -eq 1 -or $i -eq 3) { Write-Text 'BOTTLENECK' $smallFont $red ($x+18) 641 280 38 }
    if ($i -lt 4) { $canvas.DrawLine($pen,($x+312),445,($x+336),445) }
    $fill.Dispose()
}
Write-Text 'Thiếu thông tin: bước 3 → hỏi lại khách → kiểm tra lại (chưa đo thời gian chờ).' $bodyFont $muted 65 717 1650 45
Write-Text 'Sai nhóm: bước 5 → trả về bước 2 → phân nhóm lại (chưa đo tỷ lệ trả lại).' $bodyFont $muted 65 764 1650 45
Write-Text '8 PHÚT / LƯỢT' $titleFont $blue 65 846 610 67
Write-Text '1 + 3 + 1 + 2 + 1 = 8 phút thao tác tuyến chuẩn' $bodyFont $ink 700 842 1030 45
Write-Text 'Bottleneck: 5/8 phút (62,5%). Không gồm thời gian chờ và làm lại.' $smallFont $muted 700 895 1030 60
$bitmap.Save((Join-Path $root '04-workflow-diagram.png'),[System.Drawing.Imaging.ImageFormat]::Png)
$canvas.Dispose()
$bitmap.Dispose()
foreach ($resource in @($ink,$muted,$blue,$red,$titleFont,$headFont,$bodyFont,$smallFont,$pen)) { $resource.Dispose() }
