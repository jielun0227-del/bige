$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Recurse

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

foreach ($item in $htmlFiles) {
    $filePath = $item.FullName
    $bytes = [System.IO.File]::ReadAllBytes($filePath)
    $text = [System.Text.Encoding]::UTF8.GetString($bytes)
    
    $changed = $false
    
    if ($text.Contains("云端星脉")) {
        $text = $text.Replace("云端星脉", "逼哥机场测评")
        $changed = $true
    }

    if ($changed) {
        [System.IO.File]::WriteAllText($filePath, $text, $utf8NoBom)
        Write-Host "Updated: $filePath"
    }
}

Write-Host "Done replacement!"
