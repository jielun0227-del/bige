$files = Get-ChildItem -Path . -Filter "*.html" -Recurse

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

foreach ($f in $files) {
    $rawBytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $text = [System.Text.Encoding]::UTF8.GetString($rawBytes)
    
    # 1. 移除 图一: <p>Node & Proxy Lab</p> 及其周边空隙
    $text = [System.Text.RegularExpressions.Regex]::Replace($text, '\s*<p>\s*Node\s*&\s*Proxy\s*Lab\s*</p>', '')
    $text = [System.Text.RegularExpressions.Regex]::Replace($text, '\s*<p>\s*Node\s*&amp;\s*Proxy\s*Lab\s*</p>', '')
    
    # 2. 修正图中显示的乱码及品牌英文保留项
    $text = $text.Replace("閫煎摜鏈哄満娴嬭瘎", "逼哥机场测评")
    $text = $text.Replace("云端星脉", "逼哥机场测评")
    $text = $text.Replace("(StarPulse Node Lab)", "")
    $text = $text.Replace("StarPulse Node Lab", "")
    $text = $text.Replace("StarPulse", "逼哥机场")
    
    [System.IO.File]::WriteAllText($f.FullName, $text, $utf8NoBom)
}

Write-Host "Removed Node & Proxy Lab and fixed garbled texts successfully!"
