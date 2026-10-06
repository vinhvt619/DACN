# XÂY DỰNG TRANG WEB HỖ TRỢ VIẾT CV CÓ TÍCH HỢP AI

SVTH: Nguyễn Thành Vinh - MSSV: 2053592

GVHD: ThS. Mai Đức Trung

## 1. Giới thiệu đề tài

CV là tài liệu giới thiệu năng lực của ứng viên với nhà tuyển dụng. Tuy nhiên, sinh viên và người mới tham gia thị trường lao động thường gặp khó khăn trong việc tổ chức nội dung CV và chuẩn bị phỏng vấn. Từ nhu cầu đó, đề tài xây dựng RabbitCV, một nền tảng hỗ trợ tạo và quản lý CV, tìm kiếm việc làm và ứng tuyển. Hệ thống tích hợp AI để rà soát, gợi ý hoàn thiện nội dung CV và hỗ trợ luyện tập phỏng vấn.

## 2. Đặc tả yêu cầu

### Yêu cầu

- Xây dựng công cụ tạo, chỉnh sửa, lựa chọn mẫu và xuất CV theo bố cục A4.
- Hỗ trợ tìm kiếm việc làm, ứng tuyển bằng CV đã lưu hoặc PDF tải lên và theo dõi trạng thái hồ sơ.
- Cung cấp chức năng đăng tin, tiếp nhận và quản lý hồ sơ dành cho doanh nghiệp.
- Tích hợp AI hỗ trợ rà soát CV, gợi ý nội dung và luyện tập phỏng vấn; hỗ trợ nhắn tin và thông báo thời gian thực.
- Tổ chức xác thực, phân quyền và các chức năng quản trị tài khoản, xác minh doanh nghiệp, kiểm duyệt tin tuyển dụng.

### Thách thức

- Duy trì nội dung CV và thông tin công việc tại thời điểm ứng tuyển, ngăn chặn nộp hồ sơ trùng lặp.
- Kiểm soát quyền truy cập dữ liệu, xử lý phản hồi AI và đồng bộ thông tin giữa các thành phần hệ thống.

## 3. Phương pháp nghiên cứu

- Khảo sát TopCV và LinkedIn, xác định nhu cầu và phạm vi đề tài.
- Phân tích chức năng, tác nhân và các quy tắc nghiệp vụ.
- Thiết kế giao diện, lược đồ nghiệp vụ, mô hình dữ liệu và kiến trúc hệ thống.
- Hiện thực ứng dụng bằng MERN Stack, tích hợp Socket.IO và dịch vụ AI.
- Kiểm thử logic và luồng giao diện bằng Node Test Runner, Playwright; tổng hợp kết quả và xác định hạn chế.

## 4. Kiến trúc hệ thống

Hệ thống được xây dựng theo mô hình client-server, kết hợp kiến trúc phân tầng để tách biệt giao diện, xử lý yêu cầu, nghiệp vụ và truy cập dữ liệu.

- **Frontend - React:** cung cấp giao diện biên tập CV, tìm việc, ứng tuyển và quản lý tuyển dụng.
- **Backend - Express/Node.js:** tiếp nhận yêu cầu và xử lý nghiệp vụ; tổ chức thành các tầng Routes/Controllers, Services và Models.
- **MongoDB/Mongoose:** lưu trữ và truy xuất dữ liệu người dùng, CV, công việc, hồ sơ ứng tuyển, tin nhắn và thông báo.
- **Socket.IO:** hỗ trợ trao đổi tin nhắn và cập nhật thông báo theo thời gian thực.
- **Groq API:** cung cấp truy cập mô hình openai/gpt-oss-120b cho ba chức năng AI; yêu cầu đi qua backend và phản hồi được kiểm tra trước khi hiển thị.

## 5. Kết quả thực hiện

- Hiện thực trình biên tập CV có mẫu trình bày, hỗ trợ sắp xếp bố cục, xem trước A4 và xuất PDF.
- Xây dựng quy trình tìm việc, ứng tuyển và quản lý hồ sơ; lưu bản chụp CV và thông tin công việc tại thời điểm nộp.
- Tích hợp ba chức năng AI: rà soát CV, gợi ý hoàn thiện nội dung và luyện tập phỏng vấn.
- Hoàn thiện chức năng quản trị, phân quyền, nhắn tin và thông báo; thực hiện kiểm thử logic và giao diện trong phạm vi đã xác định.

## 6. Kết luận

### Kết quả đạt được

Đồ án đã xây dựng RabbitCV, liên kết quá trình chuẩn bị CV, ứng tuyển và quản lý tuyển dụng trên một nền tảng web. Việc tích hợp AI cung cấp công cụ hỗ trợ người dùng, trong khi người dùng vẫn kiểm tra và quyết định nội dung áp dụng. Hệ thống còn hạn chế về chuyển đổi CV PDF thành dữ liệu có thể chỉnh sửa và phạm vi đánh giá chất lượng AI.

### Hướng phát triển

- Trích xuất thông tin từ CV PDF vào trình biên tập.
- Bổ sung ngắt trang A4 thông minh và mở rộng khả năng tùy biến bố cục.
- Phát triển chức năng gợi ý việc làm và đặt lịch phỏng vấn đồng bộ Google Calendar.
- Hoàn thiện bảo mật và khả năng mở rộng hệ thống.

---

Ghi chú ngoài nội dung poster: Cách tổ chức đoạn văn và các nhóm Yêu cầu/Thách thức, Kết quả đạt được/Hướng phát triển tham khảo poster Work Flow Wise và EduConnect trong thư mục Drive người dùng cung cấp. Nội dung về RabbitCV dựa trên báo cáo hiện tại, không sao chép kết quả hay số liệu của poster mẫu. Bản v3 này chỉ cập nhật nội dung chữ; ảnh minh họa v2 chưa được thay chữ.
