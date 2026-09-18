$files = Get-ChildItem -Path . -Filter "*.html" -Recurse

$oldBytes = [byte[]](233, 150, 171, 231, 133, 142, 230, 145, 156, 233, 143, 136, 229, 147, 132, 230, 186, 128, 229, 168, 180, 229, 172, 173, 231, 152, 142)
$newBytes = [System.Text.Encoding]::UTF8.GetBytes("逼哥机场测评")

function Replace-Bytes ($byteArray, $oldPattern, $newPattern) {
    [System.Collections.Generic.List[byte]]$result = New-Object System.Collections.Generic.List[byte]
    for ($i = 0; $i -lt $byteArray.Length; ) {
        $match = $true
        if ($i + $oldPattern.Length -le $byteArray.Length) {
            for ($j = 0; $j -lt $oldPattern.Length; $j++) {
                if ($byteArray[$i + $j] -ne $oldPattern[$j]) {
                    $match = $false
                    break
                }
            }
        } else {
            $match = $false
        }

        if ($match) {
            $result.AddRange($newPattern)
            $i += $oldPattern.Length
        } else {
            $result.Add($byteArray[$i])
            $i++
        }
    }
    return $result.ToArray()
}

$count = 0
foreach ($f in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $replaced = Replace-Bytes $bytes $oldBytes $newBytes
    
    # Simple byte array equality comparison in PowerShell
    $isDifferent = $false
    if ($bytes.Length -ne $replaced.Length) {
        $isDifferent = $true
    } else {
        for ($k = 0; $k -lt $bytes.Length; $k++) {
            if ($bytes[$k] -ne $replaced[$k]) {
                $isDifferent = $true
                break
            }
        }
    }
    
    if ($isDifferent) {
        [System.IO.File]::WriteAllBytes($f.FullName, $replaced)
        $count++
    }
}

Write-Host "Replaced garbled bytes in $count files successfully!"
