$files = Get-ChildItem -Path . -Filter "*.html"
$files += Get-ChildItem -Path articles -Filter "*.html"

$gbk = [System.Text.Encoding]::GetEncoding("GBK")
$utf8 = New-Object System.Text.UTF8Encoding($false)

foreach ($file in $files) {
    $rawBytes = [System.IO.File]::ReadAllBytes($file.FullName)
    
    # Check if the raw bytes decode as GBK
    $content = $gbk.GetString($rawBytes)
    
    # Fix replacements in text
    $content = $content.Replace("云端星脉", "逼哥机场测评")
    $content = $content.Replace("閫煎摜鏈哄満娴嬭瘎", "逼哥机场测评")
    $content = $content.Replace("ƶ", "逼哥机场测评")
    
    $isArticle = $file.FullName.Contains("\articles\")
    $logoSrc = if ($isArticle) { "../images/bigejichang_logo.png" } else { "images/bigejichang_logo.png" }

    if ($content.Contains('<div class="sidebar-logo-icon">')) {
        $content = [System.Text.RegularExpressions.Regex]::Replace($content, '<div class="sidebar-logo-icon">.*?</div>', "<img src=`"$logoSrc`" alt=`"逼哥机场测评 Logo`" class=`"sidebar-brand-img`">")
    }

    [System.IO.File]::WriteAllText($file.FullName, $content, $utf8)
}

Write-Host "Re-encoded all files to UTF8!"
