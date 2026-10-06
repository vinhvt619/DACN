const fs = require('fs');

const text = fs.readFileSync('d:/Github/DACN/tmp/main_extracted.txt', 'utf8');
const pages = text.split('\x0c');

console.log('Total pages:', pages.length);

pages.slice(0, 25).forEach((page, index) => {
  const lines = page.trim().split('\n').map(l => l.trim()).filter(l => l.length > 0);
  if (lines.length === 0) {
    console.log(`Page ${index + 1}: [BLANK PAGE]`);
    return;
  }
  const headings = lines.filter(l => 
    l.startsWith('Chương') || 
    l.startsWith('MỤC LỤC') || 
    l.startsWith('DANH SÁCH') ||
    l.startsWith('Lời') ||
    l.startsWith('Tóm tắt') ||
    /^\d+\.\d+/.test(l)
  );
  console.log(`Page ${index + 1}: lines=${lines.length} | first="${lines[0].substring(0, 60)}" | headings=${headings.join('; ')}`);
});
