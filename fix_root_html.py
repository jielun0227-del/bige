import os, glob

def fix_all_html():
    files = glob.glob('*.html') + glob.glob('articles/*.html')
    print("Found files:", len(files))

    for p in files:
        with open(p, 'r', encoding='utf-8', errors='ignore') as f:
            text = f.read()

        is_art = 'articles/' in p or 'articles\\' in p
        lpath = '../images/bigejichang_logo.png' if is_art else 'images/bigejichang_logo.png'

        text = text.replace("云端星脉", "逼哥机场测评")
        text = text.replace("閫煎摜鏈哄満娴嬭瘎", "逼哥机场测评")
        text = text.replace('alt="閫煎摜鏈哄満娴嬭瘎 Logo"', 'alt="逼哥机场测评 Logo"')
        text = text.replace('alt="云端星脉 Logo"', 'alt="逼哥机场测评 Logo"')

        with open(p, 'w', encoding='utf-8') as f:
            f.write(text)

    print("Success fixing all files!")

if __name__ == '__main__':
    fix_all_html()
