$bytes = [System.IO.File]::ReadAllBytes("articles/wiki-proxy-architecture.html")

for ($i = 0; $i -lt $bytes.Length - 10; $i++) {
    if ($bytes[$i] -eq 32 -and $bytes[$i+1] -eq 45 -and $bytes[$i+2] -eq 32) {
        $slice = $bytes[($i+3)..($i+29)]
        Write-Host "Bytes:" ($slice -join ' ')
        break
    }
}
