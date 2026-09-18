import os
import glob
import re

html_files = glob.glob('*.html') + glob.glob('articles/*.html')
print(f"Total HTML files to process: {len(html_files)}")

for path in html_files:
    # Read as bytes
    with open(path, 'rb') as f:
        data = f.read()

    # Try utf-8 first, fallback gbk
    try:
        content = data.decode('utf-8')
    except UnicodeDecodeError:
        content = data.decode('gbk', errors='ignore')

    is_article = 'articles/' in path or 'articles\\' in path
    logo_path = '../images/bigejichang_logo.png' if is_article else 'images/bigejichang_logo.png'

    # Replace brand names
    content = content.replace("云端星脉", "逼哥机场测评")
    content = content.replace("閫煎摜鏈哄満娴嬭瘎", "逼哥机场测评")
    content = re.sub(r'alt="[^"]*Logo"', 'alt="逼哥机场测评 Logo"', content)

    # Ensure logo image tag in sidebar-header
    if 'sidebar-brand-img' not in content:
        content = content.replace(
            '<div class="sidebar-header">',
            f'<div class="sidebar-header">\n            <img src="{logo_path}" alt="逼哥机场测评 Logo" class="sidebar-brand-img">'
        )

    # Write back clean UTF-8
    with open(path, 'w', encoding='utf-8') as f:
        f.write(content)

print("Batch clean and replace complete!")
