$bytes = [System.IO.File]::ReadAllBytes("articles/wiki-privacy-protection.html")
$str = [System.Text.Encoding]::UTF8.GetString($bytes)
$idx = $str.IndexOf("<title>")
$subStr = $str.Substring($idx + 7, 35)
$subBytes = [System.Text.Encoding]::UTF8.GetBytes($subStr)
Write-Host "SubStr:" $subStr
Write-Host "Bytes:" ($subBytes -join ', ')
