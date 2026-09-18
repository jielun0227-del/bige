import os, glob

articles = glob.glob('articles/*.html')
print(f"Fixing {len(articles)} article files...")

for p in articles:
    with open(p, 'r', encoding='utf-8', errors='ignore') as f:
        text = f.read()

    # Clean garbled text and old brand names
    text = text.replace("閫煎摜鏈哄満娴嬭瘎", "逼哥机场测评")
    text = text.replace("云端星脉", "逼哥机场测评")
    text = text.replace("(StarPulse Node Lab)", "")
    text = text.replace("StarPulse Node Lab", "")

    # Remove Node & Proxy Lab paragraph if present
    import re
    text = re.sub(r'\s*<p>\s*Node\s*&\s*Proxy\s*Lab\s*</p>', '', text)
    text = re.sub(r'\s*<p>\s*Node\s*&amp;\s*Proxy\s*Lab\s*</p>', '', text)

    with open(p, 'w', encoding='utf-8') as f:
        f.write(text)

print("Articles update clean finish!")
