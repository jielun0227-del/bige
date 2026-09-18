import os
import glob

files = glob.glob('*.html') + glob.glob('articles/*.html')
print(f"Processing {len(files)} files...")

for path in files:
    with open(path, 'rb') as f:
        raw = f.read()

    # Try decoding utf-8, fallback gbk
    try:
        text = raw.decode('utf-8')
    except UnicodeDecodeError:
        text = raw.decode('gbk', errors='ignore')

    # Fix string replacements
    text = text.replace("云端星脉", "逼哥机场测评")
    text = text.replace("閫煎摜鏈哄満娴嬭瘎", "逼哥机场测评")

    prefix = '../' if ('articles/' in path or 'articles\\' in path) else ''
    logo_src = prefix + 'images/bigejichang_logo.png'

    text = text.replace('alt="閫煎摜鏈哄満娴嬭瘎 Logo"', 'alt="逼哥机场测评 Logo"')
    text = text.replace('alt="云端星脉 Logo"', 'alt="逼哥机场测评 Logo"')

    with open(path, 'w', encoding='utf-8') as f:
        f.write(text)

print("Done python encoding fix!")
