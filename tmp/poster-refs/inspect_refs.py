from pathlib import Path
from concurrent.futures import ThreadPoolExecutor
import subprocess
import json
from pypdf import PdfReader
from PIL import Image, ImageOps, ImageDraw

root = Path(__file__).parent
poppler = r'C:/Users/vinhv/.cache/codex-runtimes/codex-primary-runtime/dependencies/native/poppler/Library/bin/pdftoppm.exe'

def inspect(path):
    index = path.stem
    if path.suffix == '.pdf':
        reader = PdfReader(path)
        text = '\n'.join(page.extract_text() or '' for page in reader.pages)
        subprocess.run([poppler, '-f', '1', '-singlefile', '-scale-to', '1800', '-png', str(path), str(root / (index + '-page'))], check=True, capture_output=True)
        count = len(reader.pages)
        image_path = root / (index + '-page.png')
    else:
        count, text, image_path = 1, '', path
    return {'id': index, 'pages': count, 'text': text, 'image': str(image_path)}

paths = sorted(root.glob('ref-*.pdf')) + sorted(root.glob('ref-*.png'))
paths = [p for p in paths if '-page' not in p.stem]
with ThreadPoolExecutor(max_workers=5) as pool:
    results = sorted(pool.map(inspect, paths), key=lambda r: r['id'])
(root / 'extracted.json').write_text(json.dumps(results, ensure_ascii=False, indent=2), encoding='utf-8')
for start in range(0, len(results), 6):
    sheet = Image.new('RGB', (1800, 1720), '#e9edf3')
    draw = ImageDraw.Draw(sheet)
    for slot, result in enumerate(results[start:start+6]):
        x, y = (slot % 3)*600, (slot // 3)*860
        draw.text((x+12,y+8), result['id'], fill='black')
        im = Image.open(result['image']).convert('RGB')
        im = ImageOps.contain(im, (575, 818))
        sheet.paste(im, (x+(600-im.width)//2,y+32))
    sheet.save(root / f'contact-{start//6}.jpg', quality=92)
print(json.dumps([{'id': r['id'], 'pages':r['pages'], 'excerpt':r['text'][:800]} for r in results], ensure_ascii=False))
