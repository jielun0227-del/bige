$files = Get-ChildItem -Path . -Filter "*.html"
$files += Get-ChildItem -Path articles -Filter "*.html"

foreach ($file in $files) {
    # 读取 UTF-8 文件
    $rawBytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $utf8 = [System.Text.Encoding]::UTF8
    $content = $utf8.GetString($rawBytes)
    
    $isArticle = $file.FullName.Contains("\articles\")
    $logoSrc = if ($isArticle) { "../images/bigejichang_logo.png" } else { "images/bigejichang_logo.png" }
    
    # 替换品牌名称
    $content = $content.Replace("云端星脉", "逼哥机场测评")
    
    # 替换侧边栏 Logo 图标
    if ($content.Contains('<div class="sidebar-logo-icon">')) {
        $content = [System.Text.RegularExpressions.Regex]::Replace($content, '<div class="sidebar-logo-icon">.*?</div>', "<img src=`"$logoSrc`" alt=`"逼哥机场测评 Logo`" class=`"sidebar-brand-img`">")
    } elseif ($content.Contains('<div class="sidebar-header">') -and -not $content.Contains('sidebar-brand-img')) {
        $content = $content.Replace('<div class="sidebar-brand">', "<img src=`"$logoSrc`" alt=`"逼哥机场测评 Logo`" class=`"sidebar-brand-img`">`n            <div class=`"sidebar-brand`">")
    }
    
    [System.IO.File]::WriteAllText($file.FullName, $content, $utf8)
}

Write-Host "Updated $($files.Count) HTML files with UTF8EncodingNoBOM successfully!"
