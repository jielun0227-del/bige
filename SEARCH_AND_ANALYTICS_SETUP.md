# 搜索与统计接入清单

文件侧 SEO 修复已经完成，但统计和站长验证必须使用站点所有者账户生成的专属值，不能写入示例 token。

## Cloudflare Web Analytics

推荐在 Cloudflare 控制台中为 `bigejichang.vip` 启用 Web Analytics / Browser Insights。启用后检查实时访问，再用隐私窗口访问一次首页验证事件是否出现。

如果控制台要求插入 beacon，请复制 Cloudflare 提供的完整脚本和 token，再统一加入所有 HTML 页面的 `</body>` 前；不要使用网上示例 token。

## Google Search Console

1. 添加“网域”资源 `bigejichang.vip`。
2. 优先使用 DNS TXT 验证。
3. 提交 sitemap：`https://bigejichang.vip/sitemap.xml`。
4. 检查首页、排行榜和核心测评页的“网址检查”结果。

## Bing Webmaster Tools

添加域名并使用 DNS 或从 Search Console 导入，随后提交同一份 sitemap。

## 百度搜索资源平台

添加 HTTPS 站点并选择 HTML 标签或文件验证。平台生成验证码后，才可把对应验证标签放入首页 `<head>`。

## 尚需提供的账户值

- Cloudflare Web Analytics token（仅当控制台要求手工 beacon）
- Google HTML meta 验证码（如不采用 DNS）
- Bing HTML meta 验证码（如不采用 DNS/导入）
- 百度 HTML meta 验证码（如选择标签验证）
