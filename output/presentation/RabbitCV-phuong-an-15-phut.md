# RabbitCV: phương án bảo vệ 15 phút

Phân bổ: 9 phút nói, 1 phút dự phòng và chuyển phần, 5 phút demo. Các mốc dưới đây chưa sử dụng phút dự phòng. Trang 16 là màn hình hỏi đáp sau bài trình bày.

## Phần chính

| Trang mới | Trang cũ | Nội dung | Thời lượng | Mốc dự kiến |
|---|---|---|---|---|
| 1 | 1 | Bìa, giới thiệu | 15 giây | 00:00–00:15 |
| 2 | 3 | Lý do chọn đề tài | 30 giây | 00:15–00:45 |
| 3 | 4 | Mục tiêu | 30 giây | 00:45–01:15 |
| 4 | 11 | Các nhóm chức năng | 45 giây | 01:15–02:00 |
| 5 | 12 | Yêu cầu phi chức năng | 30 giây | 02:00–02:30 |
| 6 | 24 | Kiến trúc hệ thống | 60 giây | 02:30–03:30 |
| 7 | 13 | Use Case tổng quát | 30 giây | 03:30–04:00 |
| 8 | 25 | Thiết kế dữ liệu | 45 giây | 04:00–04:45 |
| 9 | 19 | Ứng tuyển bằng CV đã lưu | 50 giây | 04:45–05:35 |
| 10 | 26 | Tích hợp mô hình AI | 45 giây | 05:35–06:20 |
| 11 | 27 | Ba chức năng AI | 60 giây | 06:20–07:20 |
| 12 | 36 | Kết quả và phạm vi kiểm thử | 45 giây | 07:20–08:05 |
| 13 | 29 | Demo RabbitCV | 5 phút | 08:05–13:05 |
| 14 | 32 | Kết quả và hướng phát triển | 45 giây | 13:05–13:50 |
| 15 | 33 | Cảm ơn | 10 giây | 13:50–14:00 |
| 16 | 34 | Hỏi đáp | Theo hội đồng | Sau bài trình bày |

## Trọng tâm khi nói

- Chức năng: nói mỗi nhóm người dùng một câu. Khách là người chưa đăng nhập; ứng viên, doanh nghiệp và quản trị viên là các vai trò tài khoản.
- Phi chức năng: tập trung bảo mật và quyền truy cập, toàn vẹn dữ liệu, bảo trì và tính dễ sử dụng.
- Kiến trúc: React ở frontend; Express/Node.js tổ chức theo tầng; MongoDB Atlas lưu dữ liệu; Socket.IO phục vụ realtime; Groq cung cấp dịch vụ AI bên ngoài.
- Use Case: chỉ tác nhân và nhóm nghiệp vụ chính, không đọc từng chức năng.
- ERD: giải thích quan hệ giữa tài khoản, CV, tin tuyển dụng và hồ sơ ứng tuyển, không đọc toàn bộ thuộc tính.
- Sequence: kiểm tra tin và hồ sơ trùng, lưu hồ sơ cùng bản chụp CV, trả kết quả. Bản chụp giữ nội dung đã nộp khi ứng viên sửa CV gốc.
- AI: phân biệt mô hình gpt-oss-120b và dịch vụ Groq. Backend yêu cầu phản hồi JSON theo schema. Người dùng xem lại gợi ý trước khi lưu. Điểm AI mang tính tham khảo.
- Kiểm thử: báo cáo ghi nhận 43/43 ca logic và 26/26 ca giao diện. Kiểm thử giao diện dùng Chromium với API và sự kiện realtime mô phỏng. Kết quả này chưa chứng minh toàn bộ hệ thống hoặc chất lượng AI đã được kiểm chứng đầy đủ.
- Hướng phát triển: chuyển PDF thành CV chỉnh sửa được; nâng cấp kéo thả tự do và ngắt trang; đặt lịch phỏng vấn.

## Khung demo 5 phút

Nếu demo trực tiếp, có thể tập theo lịch dưới đây. Đây là kế hoạch diễn tập, không phải xác nhận nội dung của video Loom đang nhúng.

| Thời gian demo | Nội dung |
|---|---|
| 00:00–01:10 | Mở CV đã chuẩn bị, sửa một mục, đổi mẫu hoặc sắp xếp bố cục, lưu |
| 01:10–02:15 | Rà soát hoặc nhận gợi ý AI, giải thích việc xem lại trước khi lưu |
| 02:15–03:20 | Tìm việc, ứng tuyển bằng CV đã lưu, xem trạng thái hồ sơ |
| 03:20–04:20 | Mở tài khoản doanh nghiệp đã chuẩn bị, xem hồ sơ và cập nhật trạng thái |
| 04:20–05:00 | Hiển thị thông báo hoặc tin nhắn realtime, kết thúc demo |

Chuẩn bị sẵn dữ liệu và phiên đăng nhập. Nếu dùng video, kiểm tra thời lượng, quyền xem và khả năng phát trên máy trình chiếu. Dừng demo trong giới hạn 5 phút.

## Phụ lục

Trang mới 17 là trang phân cách phụ lục. Những trang cũ không thuộc phần chính được giữ phía sau theo thứ tự tương đối ban đầu: 2, 5, 6, 7, 8, 9, 10, 14, 15, 16, 17, 18, 20, 21, 22, 23, 28, 30, 31, 35, 37, 38, 39.

Chỉ mở phụ lục khi cần minh họa câu trả lời. Tập nói có bấm giờ để kiểm chứng phân bổ thời gian.
