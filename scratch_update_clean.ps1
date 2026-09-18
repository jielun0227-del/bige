$files = Get-ChildItem -Path . -Filter "*.html"
$files += Get-ChildItem -Path articles -Filter "*.html"

foreach ($file in $files) {
    $rawBytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $utf8 = [System.Text.Encoding]::UTF8
    $content = $utf8.GetString($rawBytes)

    # 移除 UTF-8 BOM 标记（如果存在）
    if ($content.StartsWith([char]0xFEFF)) {
        $content = $content.Substring(1)
    }

    # 修正乱码和替换品牌名称
    $content = $content.Replace([string]"閫煎摜鏈哄満娴嬭瘎", "逼哥机场测评")
    $content = $content.Replace("云端星脉", "逼哥机场测评")
    $content = $content.Replace('alt="閫煎摜鏈哄満娴嬭瘎 Logo"', 'alt="逼哥机场测评 Logo"')

    $isArticle = $file.FullName.Contains("\articles\")
    $logoSrc = if ($isArticle) { "../images/bigejichang_logo.png" } else { "images/bigejichang_logo.png" }

    # 替换 Sidebar Icon
    if ($content.Contains('<div class="sidebar-logo-icon">')) {
        $content = [System.Text.RegularExpressions.Regex]::Replace($content, '<div class="sidebar-logo-icon">.*?</div>', "<img src=`"$logoSrc`" alt=`"逼哥机场测评 Logo`" class=`"sidebar-brand-img`">")
    }

    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
}

Write-Host "Batch update clean finish!"
