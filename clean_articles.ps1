$files = Get-ChildItem -Path articles -Filter "*.html"

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

foreach ($f in $files) {
    $filePath = $f.FullName
    $bytes = [System.IO.File]::ReadAllBytes($filePath)
    $text = [System.Text.Encoding]::UTF8.GetString($bytes)
    
    $changed = $false
    if ($text.Contains("閫煎摜鏈哄満娴嬭瘎")) {
        $text = $text.Replace("閫煎摜鏈哄満娴嬭瘎", "逼哥机场测评")
        $changed = $true
    }
    if ($text.Contains("云端星脉")) {
        $text = $text.Replace("云端星脉", "逼哥机场测评")
        $changed = $true
    }
    if ($text.Contains("(StarPulse Node Lab)")) {
        $text = $text.Replace("(StarPulse Node Lab)", "")
        $changed = $true
    }
    
    if ($changed) {
        [System.IO.File]::WriteAllText($filePath, $text, $utf8NoBom)
        Write-Host "Updated: $($f.Name)"
    }
}

Write-Host "Articles text cleanup finished!"
