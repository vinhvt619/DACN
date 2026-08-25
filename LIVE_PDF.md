# Soạn LaTeX và xem PDF cập nhật tự động

Dự án đã được cấu hình cho **Visual Studio Code + LaTeX Workshop + MiKTeX**.

Sau lần cài đặt đầu tiên, hãy **đóng hoàn toàn mọi cửa sổ VS Code rồi mở lại một lần** để VS Code nhận đường dẫn của MiKTeX và Perl.

## Cách dùng

1. Mở cả thư mục dự án này bằng VS Code.
2. Mở `main.tex`.
3. Nhấn `Ctrl+Alt+V` để mở PDF trong một tab của VS Code.
4. Kéo tab PDF sang bên phải để vừa soạn mã vừa xem kết quả.
5. Tiếp tục sửa bất kỳ file `.tex` nào. VS Code tự lưu sau khoảng 0,6 giây, LaTeX Workshop tự build, và PDF tự làm mới.

PDF được sinh tại `build/main.pdf`; các file tạm cũng nằm trong `build/` để không làm bẩn thư mục mã nguồn.

## Đồng bộ vị trí giữa mã và PDF

- Từ mã sang PDF: đặt con trỏ tại đoạn đang sửa rồi nhấn `Ctrl+Alt+J`.
- Từ PDF về mã: nhấp đúp vào vị trí tương ứng trong PDF.

## Lệnh hữu ích

- Build thủ công: `Ctrl+Shift+B`.
- Nếu PDF không cập nhật: mở Command Palette (`Ctrl+Shift+P`) và chạy `LaTeX Workshop: Build LaTeX project`.
- Xóa toàn bộ file build: chạy task `LaTeX: clean build files`.
- Xem lỗi: mở panel **Output**, rồi chọn **LaTeX Compiler** hoặc **LaTeX Workshop**.

Lần build đầu có thể lâu hơn vì MiKTeX phải tự tải các package mà template sử dụng. Những lần sau sẽ nhanh hơn.
