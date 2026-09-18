import os

files_to_update = [
    r'c:\Users\Lenovo\Desktop\逼哥机场\index.html',
    r'c:\Users\Lenovo\Desktop\逼哥机场\rankings.html',
    r'c:\Users\Lenovo\Desktop\逼哥机场\tutorials.html',
    r'c:\Users\Lenovo\Desktop\逼哥机场\vpn-proxy.html',
    r'c:\Users\Lenovo\Desktop\逼哥机场\wiki.html',
    r'c:\Users\Lenovo\Desktop\逼哥机场\about.html'
]

articles_dir = r'c:\Users\Lenovo\Desktop\逼哥机场\articles'
if os.path.exists(articles_dir):
    for f in os.listdir(articles_dir):
        if f.endswith('.html'):
            files_to_update.append(os.path.join(articles_dir, f))

for path in files_to_update:
    if not os.path.exists(path):
        continue
    with open(path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Determine relative prefix for logo path
    rel_prefix = '../' if 'articles' in path else ''
    logo_src = rel_prefix + 'images/bigejichang_logo.png'

    # Update brand name
    content = content.replace('云端星脉', '逼哥机场测评')

    # Update sidebar header icon/img
    if '<div class="sidebar-logo-icon">✨</div>' in content:
        content = content.replace(
            '<div class="sidebar-logo-icon">✨</div>',
            f'<img src="{logo_src}" alt="逼哥机场测评 Logo" class="sidebar-brand-img">'
        )
    elif '<div class="sidebar-logo-icon">' in content:
        # replace any icon div
        import re
        content = re.sub(
            r'<div class="sidebar-logo-icon">.*?</div>',
            f'<img src="{logo_src}" alt="逼哥机场测评 Logo" class="sidebar-brand-img">',
            content,
            flags=re.DOTALL
        )
    else:
        # If no icon tag exists, check if header already has brand img
        if 'sidebar-brand-img' not in content and '<div class="sidebar-header">' in content:
            content = content.replace(
                '<div class="sidebar-header">\n            <div class="sidebar-brand">',
                f'<div class="sidebar-header">\n            <img src="{logo_src}" alt="逼哥机场测评 Logo" class="sidebar-brand-img">\n            <div class="sidebar-brand">'
            ).replace(
                '<div class="sidebar-header">\r\n            <div class="sidebar-brand">',
                f'<div class="sidebar-header">\r\n            <img src="{logo_src}" alt="逼哥机场测评 Logo" class="sidebar-brand-img">\r\n            <div class="sidebar-brand">'
            )

    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

print('Update completed successfully for', len(files_to_update), 'files.')
