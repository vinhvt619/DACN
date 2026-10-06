const fs = require('fs');

const text = fs.readFileSync('d:/Github/DACN/tmp/main_extracted.txt', 'utf8');
const pages = text.split('\x0c');

for (let p = 31; p <= 50; p++) {
  const page = pages[p - 1];
  const lines = page.split('\n');
  lines.forEach((l) => {
    const t = l.trim();
    if (t.startsWith('Usecase ID') || t.startsWith('Tên use case') || t.startsWith('Lỗi') || t.includes('bảo trì') || t.includes('E1.') || t.includes('E2.') || t.includes('E3.')) {
      console.log(`[P${p}] ${t}`);
    }
  });
}
