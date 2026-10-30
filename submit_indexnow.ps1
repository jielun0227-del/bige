# IndexNow 批量推送脚本
param(
    [string]$HostName = "bigejichang.vip",
    [string]$Key = "6813638fdf244605a591b21d3693136e",
    [string]$SitemapPath = "sitemap.xml"
)

Write-Host "正在从 $SitemapPath 读取 URL 列表..." -ForegroundColor Cyan

if (-not (Test-Path $SitemapPath)) {
    Write-Error "找不到 sitemap 文件: $SitemapPath"
    exit 1
}

[xml]$sitemap = Get-Content $SitemapPath
$urlList = @($sitemap.urlset.url.loc)

Write-Host "共读取到 $($urlList.Count) 个 URL。" -ForegroundColor Cyan

$payload = @{
    host = $HostName
    key = $Key
    keyLocation = "https://$HostName/$Key.txt"
    urlList = $urlList
} | ConvertTo-Json -Depth 5

$endpoint = "https://api.indexnow.org/IndexNow"

Write-Host "正在向 IndexNow ($endpoint) 提交..." -ForegroundColor Yellow

try {
    $response = Invoke-RestMethod -Uri $endpoint -Method Post -Body $payload -ContentType "application/json; charset=utf-8"
    Write-Host "提交成功！" -ForegroundColor Green
} catch {
    $statusCode = $_.Exception.Response.StatusCode.value__
    if ($statusCode -eq 200 -or $statusCode -eq 202) {
        Write-Host "提交成功！HTTP 状态码: $statusCode (已接收并排队处理)" -ForegroundColor Green
    } else {
        Write-Warning "提交返回状态码: $statusCode"
        Write-Error "详情: $_"
    }
}
