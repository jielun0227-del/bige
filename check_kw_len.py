import os, glob

files = glob.glob('articles/kw-*.html')
for f in sorted(files):
    with open(f, 'r', encoding='utf-8') as file:
        content = file.read()
        print(f"{f}: {len(content)} characters")
