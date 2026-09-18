$files = Get-ChildItem -Path . -Filter "*.html" -Recurse

$gbkBytes = [byte[]](233, 150, 171, 231, 133, 142, 230, 145, 156, 233, 143, 136, 229, 147, 132, 230, 186, 128, 229, 168, 180, 229, 172, 173, 231, 152, 142)
$utf8Bytes = [System.Text.Encoding]::UTF8.GetBytes("逼哥机场测评")

function Clean-File ($filePath) {
    $bytes = [System.IO.File]::ReadAllBytes($filePath)
    $list = New-Object System.Collections.Generic.List[byte]
    $modified = $false
    $patternLen = $gbkBytes.Length
    
    for ($i = 0; $i -lt $bytes.Length; ) {
        $matched = $true
        if ($i + $patternLen -le $bytes.Length) {
            for ($j = 0; $j -lt $patternLen; $j++) {
                if ($bytes[$i + $j] -ne $gbkBytes[$j]) {
                    $matched = $false
                    break
                }
            }
        } else {
            $matched = $false
        }
        
        if ($matched) {
            $list.AddRange($utf8Bytes)
            $i += $patternLen
            $modified = $true
        } else {
            $list.Add($bytes[$i])
            $i++
        }
    }
    
    if ($modified) {
        [System.IO.File]::WriteAllBytes($filePath, $list.ToArray())
        Write-Host "Successfully cleaned garbled in: $filePath"
    }
}

foreach ($item in $files) {
    Clean-File $item.FullName
}

Write-Host "All garbled strings cleaned!"
