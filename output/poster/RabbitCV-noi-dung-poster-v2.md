# Nội dung poster RabbitCV

## Thông tin đầu poster

TRƯỜNG ĐẠI HỌC BÁCH KHOA – ĐHQG-HCM

KHOA KHOA HỌC VÀ KỸ THUẬT MÁY TÍNH

ĐỒ ÁN TỐT NGHIỆP

**XÂY DỰNG TRANG WEB HỖ TRỢ VIẾT CV CÓ TÍCH HỢP AI**

SVTH: Nguyễn Thành Vinh – MSSV: 2053592

GVHD: ThS. Mai Đức Trung

## 01. Giới thiệu đề tài

Ứng viên cần hỗ trợ chuẩn bị CV và luyện phỏng vấn; doanh nghiệp cần quản lý tin tuyển dụng và hồ sơ. RabbitCV kết nối tạo CV, ứng tuyển và trao đổi tuyển dụng, đồng thời tích hợp AI hỗ trợ nội dung CV và luyện tập phỏng vấn.

Hình minh họa: **Chuẩn bị CV → Ứng tuyển → Trao đổi tuyển dụng.**

## 02. Đặc tả yêu cầu

### Chức năng

- Khách: xem và tìm kiếm việc làm.
- Ứng viên: quản lý CV, ứng tuyển và sử dụng AI.
- Doanh nghiệp: đăng tin, quản lý hồ sơ và nhắn tin.
- Quản trị viên: duyệt tài khoản, xác minh doanh nghiệp và kiểm duyệt tin.

### Phi chức năng và thách thức

- Phân quyền theo vai trò và quyền sở hữu dữ liệu.
- Lưu bản chụp CV và thông tin công việc khi ứng tuyển.
- Kiểm soát dữ liệu gửi AI và cấu trúc phản hồi.
- Phân tầng rõ ràng, thuận tiện bảo trì và mở rộng.

## 03. Phương pháp nghiên cứu

**Khảo sát → Phân tích → Thiết kế → Hiện thực → Kiểm thử**

- Khảo sát: tìm hiểu TopCV và LinkedIn.
- Phân tích: xác định yêu cầu và quy tắc nghiệp vụ.
- Thiết kế: xây dựng lược đồ, mô hình dữ liệu và giao diện.
- Hiện thực: phát triển MERN, realtime và tích hợp AI.
- Kiểm thử: sử dụng Node Test Runner và Playwright.

## 04. Kiến trúc hệ thống

**Client–server kết hợp kiến trúc phân tầng.**

- React: giao diện người dùng.
- Express/Node.js: API và xử lý nghiệp vụ.
- Mongoose/MongoDB: truy cập và lưu trữ dữ liệu.
- Socket.IO: chat và thông báo theo thời gian thực.
- Groq API: cung cấp truy cập mô hình openai/gpt-oss-120b.

Backend phân chia thành Routes/Controllers → Services → Mongoose Models. Groq API là dịch vụ AI bên ngoài, không thuộc tầng cơ sở dữ liệu; giao diện không gọi trực tiếp nhà cung cấp AI.

**Quy trình AI:** Yêu cầu → Backend → Groq API → Kiểm tra JSON → Giao diện.

Người dùng kiểm tra gợi ý và quyết định lưu CV.

## 05. Kết quả thực hiện

- Tạo, chỉnh sửa và xem trước CV A4; hỗ trợ xuất PDF.
- Ứng tuyển bằng CV đã lưu hoặc PDF tải lên, lưu bản chụp hồ sơ đã nộp.
- Rà soát CV, gợi ý bổ sung và luyện tập phỏng vấn với AI.
- Quản lý tuyển dụng, phân quyền, chat và thông báo.

**Theo báo cáo:** 43/43 ca kiểm thử logic và 26/26 ca kiểm thử giao diện đạt trong lần chạy được ghi nhận.

Chú thích: Kiểm thử giao diện dùng API và sự kiện mô phỏng; kết quả chưa đại diện cho kiểm thử tích hợp toàn hệ thống hoặc đánh giá chất lượng AI. Cập nhật số liệu nếu báo cáo cuối cùng thay đổi.

### Ảnh kết quả

- `D:/Github/DACN/img/CV_Edit.png` — Biên tập và xem trước CV.
- `D:/Github/DACN/img/AIInterviewChat.png` — Luyện tập phỏng vấn với AI.

Nên thay bằng ảnh giao diện mới nhất và che thông tin cá nhân trước khi in. Điểm AI trong ảnh không phải số liệu đo chất lượng mô hình.

## 06. Kết luận

**Đạt được:** Liên kết quản lý CV, ứng tuyển và hỗ trợ AI trên một nền tảng.

**Giới hạn:** AI mang tính tham khảo; chưa chuyển PDF thành CV có thể chỉnh sửa.

**Hướng phát triển:** Trích xuất PDF, lưu lịch sử luyện phỏng vấn và đồng bộ lịch hẹn.

## Dựng lại trên Canva

- Khổ gợi ý: A0 dọc; xác nhận kích thước theo yêu cầu của khoa trước khi in.
- Bốn mục đầu là các dải ngang đọc từ trên xuống.
- Mục 2 chia hai cột nội bộ; mục 3 dùng quy trình năm bước nằm ngang.
- Mục 4: sơ đồ kiến trúc bên trái, mô tả thành phần và luồng AI bên phải.
- Hàng cuối: Kết quả khoảng hai phần ba chiều rộng; Kết luận khoảng một phần ba.
- Tông trắng–tím, thân bài màu đen; hạn chế trang trí không mang thông tin.
- Chỉ thêm QR khi có đường dẫn demo hoặc báo cáo chính xác.
- Ảnh AI là minh họa bố cục, không phải bản in A0 hoặc thiết kế Canva có thể chỉnh sửa.

## Mẫu tham khảo chính

- Work Flow Wise: https://drive.google.com/file/d/1TRurt8NcGkkpCRS6kAxONUmStc0FmBka/view
- EduConnect: https://drive.google.com/file/d/1wbf_wbN-2dHifP17HJ0lE3KpQLxlylNh/view
- Socialpedia: https://drive.google.com/file/d/1m2USJJkGIvrPcWygHelmS-vrvJiPTeVD/view

Chỉ tham khảo tổ chức thông tin và bố cục, không lấy số liệu hoặc kết quả của các poster mẫu cho RabbitCV.

## Công cụ và prompt ảnh

Ảnh minh họa được tạo và chỉnh sửa bằng công cụ tạo ảnh tích hợp, không sử dụng CLI/API fallback.

Brief thiết kế: poster học thuật A0 dọc, nền trắng–tím; tham khảo bố cục Work Flow Wise và EduConnect; giữ đúng sáu mục, bốn dải ngang phía trên, kết quả và kết luận cạnh nhau phía dưới; kiến trúc client–server phân tầng, Groq là dịch vụ bên ngoài; chèn ảnh giao diện RabbitCV; không thêm số liệu hoặc QR giả.

Prompt chỉnh sửa cuối cùng: Edit this Vietnamese RabbitCV graduation poster. Change ONLY the last stage label of section "03 PHƯƠNG PHÁP NGHIÊN CỨU": the image currently says "Kiểm thức". Replace that label with the exact correct Vietnamese text "Kiểm thử". Spell exact letters K i ể m space t h ử. Preserve the "Node Test, Playwright" sublabel. Preserve EVERYTHING ELSE pixel-faithfully: all section sizes, six headings, entire poster layout, academic header and BK logo, title, exact author Nguyễn Thành Vinh, exact MSSV 2053592, GVHD ThS. Mai Đức Trung, all text, arrows, diagrams, screenshots, colours, typography, dimensions and margins. Do not redesign, do not add anything, do not change any other label. Flat full-page poster, no crop.
