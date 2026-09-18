$bytes = [System.IO.File]::ReadAllBytes("articles/wiki-privacy-protection.html")

for ($i = 0; $i -lt $bytes.Length - 5; $i++) {
    if ($bytes[$i] -eq 32 -and $bytes[$i+1] -eq 45 -and $bytes[$i+2] -eq 32) {
        $slice = $bytes[($i+3)..($i+29)]
        Write-Host "Dash Bytes:" ($slice -join ' ')
        break
    }
}
