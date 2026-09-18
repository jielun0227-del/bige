Add-Type -AssemblyName System.Drawing

function Generate-Logo($text, $c1, $c2, $fg, $outFile) {
    $bmp = New-Object System.Drawing.Bitmap(240, 240)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

    $rect = New-Object System.Drawing.Rectangle(0, 0, 240, 240)
    $col1 = [System.Drawing.ColorTranslator]::FromHtml($c1)
    $col2 = [System.Drawing.ColorTranslator]::FromHtml($c2)
    $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, $col1, $col2, 45)

    $g.FillRectangle($brush, $rect)

    $borderPen = New-Object System.Drawing.Pen([System.Drawing.Color]::FromArgb(40, 255, 255, 255), 4)
    $g.DrawRectangle($borderPen, 2, 2, 236, 236)

    $font = New-Object System.Drawing.Font('Microsoft YaHei', 52, [System.Drawing.FontStyle]::Bold)
    $textBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml($fg))

    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Center

    $g.DrawString($text, $font, $textBrush, (New-Object System.Drawing.RectangleF(0, 0, 240, 240)), $sf)

    $bmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $bmp.Dispose()
}

$edge = "$([char]0x8FB9)$([char]0x7F18)"
$yuntu = "$([char]0x4E91)$([char]0x56FE)"
$sujie = "$([char]0x901F)$([char]0x754C)"
$jilian = "$([char]0x6781)$([char]0x8FDE)"
$kexin = "$([char]0x53EF)$([char]0x4FE1)"
$baoyun = "$([char]0x5B9D)$([char]0x4E91)"
$jiuyun = "$([char]0x4E5D)$([char]0x4E91)"
$guangnian = "$([char]0x5149)$([char]0x5E74)"

Generate-Logo $edge "#0b0f19" "#1e1b4b" "#00f2fe" "images/edgenova_logo.png"
Generate-Logo $yuntu "#0f172a" "#1e3a8a" "#38bdf8" "images/yuntu_logo.png"
Generate-Logo $sujie "#1e1b4b" "#311042" "#a855f7" "images/sujie_logo.png"
Generate-Logo $jilian "#020617" "#0f2027" "#38bdf8" "images/jilianyun_logo.png"
Generate-Logo $kexin "#091e3a" "#2fb8ff" "#ffffff" "images/kexinyun_logo.png"
Generate-Logo $baoyun "#1e293b" "#0f766e" "#2dd4bf" "images/baoyun_logo.png"
Generate-Logo $jiuyun "#311042" "#701a75" "#f472b6" "images/jiuyun_logo.png"

Write-Host "All airport logos regenerated successfully."
