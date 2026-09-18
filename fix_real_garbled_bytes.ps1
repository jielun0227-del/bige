$files = Get-ChildItem -Path . -Filter "*.html" -Recurse

$oldBytes = [byte[]](233, 128, 188, 229, 147, 165, 230, 156, 186, 229, 156, 186, 230, 181, 139, 232, 175, 132)
$newBytes = [System.Text.Encoding]::UTF8.GetBytes("逼哥机场测评")

function Fix-GarbledBytes ($file) {
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    $list = New-Object System.Collections.Generic.List[byte]
    
    $modified = $false
    $tLen = $oldBytes.Length
    
    for ($i = 0; $i -lt $bytes.Length; ) {
        $match = $true
        if ($i + $tLen -le $bytes.Length) {
            for ($j = 0; $j -lt $tLen; $j++) {
                if ($bytes[$i + $j] -ne $oldBytes[$j]) {
                    $match = $false
                    break
                }
            }
        } else {
            $match = $false
        }
        
        if ($match) {
            $list.AddRange($newBytes)
            $i += $tLen
            $modified = $true
        } else {
            $list.Add($bytes[$i])
            $i++
        }
    }
    
    if ($modified) {
        [System.IO.File]::WriteAllBytes($file.FullName, $list.ToArray())
        Write-Host "Fixed garbled in:" $file.Name
    }
}

foreach ($f in $files) {
    Fix-GarbledBytes $f
}

Write-Host "Garbled byte fix finished!"
