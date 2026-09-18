Add-Type -AssemblyName System.Drawing

function Generate-Logo($text, $c1, $c2, $fg, $outFile) {
    $bmp = New-Object System.Drawing.Bitmap(120, 120)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias

    $rect = New-Object System.Drawing.Rectangle(0, 0, 120, 120)
    $col1 = [System.Drawing.ColorTranslator]::FromHtml($c1)
    $col2 = [System.Drawing.ColorTranslator]::FromHtml($c2)
    $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, $col1, $col2, 45)
    $g.FillRectangle($brush, $rect)

    $font = New-Object System.Drawing.Font('Microsoft YaHei', 26, [System.Drawing.FontStyle]::Bold)
    $textBrush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml($fg))

    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Center

    $g.DrawString($text, $font, $textBrush, (New-Object System.Drawing.RectangleF(0, 0, 120, 120)), $sf)
    $bmp.Save($outFile, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $bmp.Dispose()
}

Generate-Logo "边缘" "#0b0f19" "#1e1b4b" "#00f2fe" "images/edgenova_logo.png"
Generate-Logo "云图" "#0f172a" "#1e3a8a" "#38bdf8" "images/yuntu_logo.png"
Generate-Logo "速界" "#1e1b4b" "#311042" "#60a5fa" "images/sujie_logo.png"
Generate-Logo "极连" "#020617" "#0f2027" "#38bdf8" "images/jilianyun_logo.png"
Generate-Logo "可信" "#091e3a" "#2fb8ff" "#ffffff" "images/kexinyun_logo.png"
