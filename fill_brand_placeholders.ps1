$files = Get-ChildItem -Path . -Filter "*.html" -Recurse

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)

foreach ($f in $files) {
    $bytes = [System.IO.File]::ReadAllBytes($f.FullName)
    $text = [System.Text.Encoding]::UTF8.GetString($bytes)
    
    # 替换各种可能空留或残留的品牌名称位置
    $text = $text.Replace('<div class="sidebar-brand"><h1></h1></div>', '<div class="sidebar-brand"><h1>逼哥机场测评</h1></div>')
    $text = $text.Replace('<div class="sidebar-brand">`n                <h1></h1>', '<div class="sidebar-brand">`n                <h1>逼哥机场测评</h1>')
    $text = $text.Replace('<div class="sidebar-brand">`r`n                <h1></h1>', '<div class="sidebar-brand">`r`n                <h1>逼哥机场测评</h1>')
    
    $text = $text.Replace('alt=" Logo"', 'alt="逼哥机场测评 Logo"')
    $text = $text.Replace('<title> - ', '<title>逼哥机场测评 - ')
    $text = $text.Replace('<title>2026年高质量加速机场推荐榜 - </title>', '<title>2026年高质量加速机场推荐榜 - 逼哥机场测评</title>')
    $text = $text.Replace('<title>小白新手教程 - 客户端配置指南 | </title>', '<title>小白新手教程 - 客户端配置指南 | 逼哥机场测评</title>')
    $text = $text.Replace('<title>科学上网 - 全平台出海指南与核心实战教程 | </title>', '<title>科学上网 - 全平台出海指南与核心实战教程 | 逼哥机场测评</title>')
    $text = $text.Replace('<title>科普百科全书 - 节点与协议知识库 | </title>', '<title>科普百科全书 - 节点与协议知识库 | 逼哥机场测评</title>')
    $text = $text.Replace('<title>关于我们 -  Node & Proxy Lab</title>', '<title>关于我们 - 逼哥机场测评</title>')
    
    $text = $text.Replace('© 2026 閫煎摜鏈哄満娴嬭瘎 Lab', '© 2026 逼哥机场测评')
    $text = $text.Replace('© 2026 云端星脉 Lab', '© 2026 逼哥机场测评')
    
    $text = $text.Replace('<h1>✨ 认识</h1>', '<h1>✨ 认识逼哥机场测评</h1>')
    $text = $text.Replace('<p class="about-intro-p">`n                    建立于', '<p class="about-intro-p">`n                    逼哥机场测评建立于')
    $text = $text.Replace('<p class="about-intro-p">`r`n                    建立于', '<p class="about-intro-p">`r`n                    逼哥机场测评建立于')
    
    # 避免描述和文章内有缺失
    $text = $text.Replace('content="：专注全网', 'content="逼哥机场测评：专注全网')
    $text = $text.Replace('content=" 2026年最新', 'content="逼哥机场测评 2026年最新')
    $text = $text.Replace('科学上网专题：涵盖', '逼哥机场测评科学上网专题：涵盖')
    
    [System.IO.File]::WriteAllText($f.FullName, $text, $utf8NoBom)
}

Write-Host "Replaced empty brand slots with '逼哥机场测评' successfully!"
