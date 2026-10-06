const fs = require('fs');

const text = fs.readFileSync('d:/Github/DACN/tmp/main_extracted.txt', 'utf8');
const pages = text.split('\x0c');

const args = process.argv.slice(2);
const startPage = parseInt(args[0] || '1', 10);
const endPage = parseInt(args[1] || String(startPage), 10);

for (let p = startPage; p <= endPage && p <= pages.length; p++) {
  console.log(`\n==================== PAGE ${p} (Length: ${pages[p-1].length}) ====================`);
  console.log(pages[p-1].trim());
}
