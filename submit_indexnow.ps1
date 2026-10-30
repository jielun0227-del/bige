$HostName = "bigejichang.vip"
$Key = "6813638fdf244605a591b21d3693136e"
$SitemapPath = Join-Path $PSScriptRoot "sitemap.xml"

Write-Host "Reading URLs from $SitemapPath..." -ForegroundColor Cyan

if (-not (Test-Path $SitemapPath)) {
    Write-Error "Cannot find sitemap: $SitemapPath"
    exit 1
}

[xml]$sitemap = Get-Content -Raw $SitemapPath
$urlList = @($sitemap.urlset.url.loc)

Write-Host "Total URLs loaded: $($urlList.Count)" -ForegroundColor Cyan

$payloadObject = @{
    host = $HostName
    key = $Key
    keyLocation = "https://$HostName/$Key.txt"
    urlList = $urlList
}

$payloadJson = $payloadObject | ConvertTo-Json -Depth 5
$endpoint = "https://api.indexnow.org/IndexNow"

Write-Host "Submitting to IndexNow ($endpoint)..." -ForegroundColor Yellow

try {
    $response = Invoke-WebRequest -Uri $endpoint -Method POST -Body $payloadJson -ContentType "application/json; charset=utf-8" -UseBasicParsing
    Write-Host "Submission successful! HTTP Status: $($response.StatusCode)" -ForegroundColor Green
} catch {
    if ($_.Exception.Response) {
        $statusCode = [int]$_.Exception.Response.StatusCode
        if ($statusCode -eq 200 -or $statusCode -eq 202) {
            Write-Host "Submission received! HTTP Status: $statusCode (Accepted / Processed)" -ForegroundColor Green
        } else {
            Write-Warning "IndexNow returned HTTP Status: $statusCode"
            Write-Error $_
        }
    } else {
        Write-Error $_
    }
}
