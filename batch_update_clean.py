import os
import glob

def run():
    files = glob.glob('*.html') + glob.glob('articles/*.html')
    print("Files found:", len(files))

    for p in files:
        with open(p, 'rb') as f:
            data = f.read()

        text = data.decode('utf-8', errors='ignore')

        is_art = 'articles' in p
        logo_path = '../images/bigejichang_logo.png' if is_art else 'images/bigejichang_logo.png'

        text = text.replace("云端星脉", "逼哥机场测评")
        text = text.replace("閫煎摜鏈哄満娴嬭瘎", "逼哥机场测评")
        text = text.replace('alt="閫煎摜鏈哄満娴嬭瘎 Logo"', 'alt="逼哥机场测评 Logo"')
        text = text.replace('alt="云端星脉 Logo"', 'alt="逼哥机场测评 Logo"')

        with open(p, 'w', encoding='utf-8') as f:
            f.write(text)

    print("Finished updating all HTML files!")

if __name__ == '__main__':
    run()
