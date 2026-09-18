$domain = "https://bigejichang.vip"
$rootPath = Get-Location

$htmlFiles = Get-ChildItem -Path . -Filter "*.html" -Recurse

$sitemapXml = @"
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
"@

foreach ($item in $htmlFiles) {
    $fullName = $item.FullName
    $relPath = $fullName.Substring($rootPath.Path.Length).TrimStart('\', '/').Replace('\', '/')
    
    if ($relPath.StartsWith("scratch") -or $relPath.StartsWith("temp")) {
        continue
    }
    
    $priority = "0.8"
    $changefreq = "weekly"
    
    if ($relPath -eq "index.html") {
        $priority = "1.0"
        $changefreq = "daily"
        $fullUrl = "$domain/"
    } elseif ($relPath -eq "rankings.html") {
        $priority = "0.9"
        $changefreq = "daily"
        $fullUrl = "$domain/rankings.html"
    } else {
        $fullUrl = "$domain/$relPath"
    }
    
    $lastmod = $item.LastWriteTime.ToString("yyyy-MM-dd")
    
    $sitemapXml += @"

  <url>
    <loc>$fullUrl</loc>
    <lastmod>$lastmod</lastmod>
    <changefreq>$changefreq</changefreq>
    <priority>$priority</priority>
  </url>
"@
}

$sitemapXml += @"

</urlset>
"@

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText("$($rootPath.Path)\sitemap.xml", $sitemapXml, $utf8NoBom)

$robotsTxt = @"
User-agent: *
Allow: /

Sitemap: https://bigejichang.vip/sitemap.xml
"@

[System.IO.File]::WriteAllText("$($rootPath.Path)\robots.txt", $robotsTxt, $utf8NoBom)

Write-Host "Successfully generated sitemap.xml and robots.txt!"
