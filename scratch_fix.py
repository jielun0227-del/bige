import os
import glob

files = glob.glob('*.html') + glob.glob('articles/*.html')
print(f"Total HTML files found: {len(files)}")

for p in files:
    with open(p, 'rb') as f:
        data = f.read()

    # If it was saved in GBK/ANSI corrupted bytes or utf-8, let's clean up
    try:
        content = data.decode('utf-8')
    except UnicodeDecodeError:
        content = data.decode('gbk', errors='ignore')

    # Replace Chinese corrupted strings if any
    content = content.replace("閫煎摜鏈哄満娴嬭瘎", "逼哥机场测评")
    content = content.replace("云端星脉", "逼哥机场测评")

    prefix = '../' if ('articles/' in p or 'articles\\' in p) else ''
    logo_src = prefix + 'images/bigejichang_logo.png'

    # Ensure sidebar logo is present and correctly formatted
    if '<div class="sidebar-logo-icon">' in content:
        import re
        content = re.sub(r'<div class="sidebar-logo-icon">.*?</div>', f'<img src="{logo_src}" alt="逼哥机场测评 Logo" class="sidebar-brand-img">', content, flags=re.DOTALL)

    content = content.replace('alt="閫煎摜鏈哄満娴嬭瘎 Logo"', 'alt="逼哥机场测评 Logo"')

    with open(p, 'w', encoding='utf-8') as f:
        f.write(content)

print("Batch clean and update complete!")
