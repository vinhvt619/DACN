# Thiết lập dự án trên Antigravity

## Yêu cầu một lần

1. Cài **MiKTeX** (hoặc TeX Live) và cho phép thêm thư mục `bin` vào `PATH`.
2. Trong Antigravity, cài extension **LaTeX Workshop** (`james-yu.latex-workshop`) theo gợi ý của workspace.
3. Đóng hoàn toàn Antigravity rồi mở lại thư mục dự án để editor nhận `PATH` mới.

Kiểm tra trong terminal:

```powershell
pdflatex --version
bibtex --version
```

## Soạn và xem PDF

- Mở `main.tex`.
- Lưu file để LaTeX Workshop tự build.
- Nhấn `Ctrl+Alt+V` để mở PDF trong editor.
- Build thủ công bằng `Ctrl+Shift+B`, hoặc chạy:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/build-latex.ps1
```

PDF được tạo tại `build/main.pdf`. Để xóa output, chạy task **LaTeX: clean build files**.

## Antigravity Agent

Workspace có rule tại `.agent/rules/latex-project.md` và workflow `/build-thesis` tại `.agent/workflows/build-thesis.md`. Rule giúp agent giữ nguyên UTF-8 tiếng Việt, dùng đúng file gốc và luôn kiểm tra bản build sau khi sửa nội dung.
