$files = Get-ChildItem -Path . -Filter "*.html" -Recurse

$oldBytes = [byte[]](228, 186, 145, 231, 171, 175, 230, 152, 159, 232, 132, 137)
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
    if ($bytes.Length -ne $replaced.Length -or ($bytes -ne $replaced)) {
        [System.IO.File]::WriteAllBytes($f.FullName, $replaced)
        $count++
    }
}

Write-Host "Replaced byte pattern in $count files successfully!"
