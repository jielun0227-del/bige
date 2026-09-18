$files = Get-ChildItem -Path . -Filter "*.html" -Recurse

$targetBytes = [byte[]](233, 150, 171, 231, 133, 142, 230, 145, 156, 233, 143, 136, 229, 147, 132, 230, 186, 128, 229, 168, 180, 229, 172, 173, 231, 152, 142)
$replacementBytes = [System.Text.Encoding]::UTF8.GetBytes("逼哥机场测评")

function Fix-FileBytes ($file) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $list = New-Object System.Collections.Generic.List[byte]
    
    $modified = $false
    $tLen = $targetBytes.Length
    
    for ($i = 0; $i -lt $bytes.Length; ) {
        $match = $true
        if ($i + $tLen -le $bytes.Length) {
            for ($j = 0; $j -lt $tLen; $j++) {
                if ($bytes[$i + $j] -ne $targetBytes[$j]) {
                    $match = $false
                    break
                }
            }
        } else {
            $match = $false
        }
        
        if ($match) {
            $list.AddRange($replacementBytes)
            $i += $tLen
            $modified = $true
        } else {
            $list.Add($bytes[$i])
            $i++
        }
    }
    
    if ($modified) {
        [System.IO.File]::WriteAllBytes($file.FullName, $list.ToArray())
        Write-Host "Fixed:" $file.FullName
    }
}

foreach ($f in $files) {
    Fix-FileBytes $f
}

Write-Host "Garbled byte fix complete!"
