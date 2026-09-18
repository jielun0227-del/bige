$files = Get-ChildItem -Path . -Filter "*.html" -Recurse

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

foreach ($f in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $text = [System.Text.Encoding]::UTF8.GetString($bytes)
    
    $text = $text.Replace("云端星脉", "逼哥机场测评")
    $text = $text.Replace("閫煎摜鏈哄満娴嬭瘎", "逼哥机场测评")
    $text = $text.Replace('alt="閫煎摜鏈哄満娴嬭瘎 Logo"', 'alt="逼哥机场测评 Logo"')
    $text = $text.Replace('alt="云端星脉 Logo"', 'alt="逼哥机场测评 Logo"')
    
    [System.IO.File]::WriteAllText($f.FullName, $text, $utf8NoBom)
}

Write-Host "All files updated smoothly!"
