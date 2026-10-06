# Nhận xét và kế hoạch chỉnh sửa báo cáo RabbitCV

## 1. Đánh giá tổng quan

Bản báo cáo hiện có 100 trang PDF, được tổ chức thành tám chương. Mạch trình bày từ tổng quan, cơ sở lý thuyết, công nghệ, phân tích thiết kế, triển khai, AI, kiểm thử đến kết luận nhìn chung hợp lý. Báo cáo đã thống nhất được ba chức năng AI, 13 tệp/43 ca kiểm thử phía máy chủ, sáu kịch bản Playwright và cơ chế thông báo qua REST thay vì Socket.IO.

Điểm yếu lớn nhất hiện nay không phải thiếu nội dung mà là độ chính xác và tính nhất quán. Một số sơ đồ vẫn phản ánh thiết kế cũ hoặc kiến trúc mong muốn thay vì mã nguồn thực tế. Chương công nghệ dài nhưng thiếu phần công nghệ AI đang hoạt động; chương triển khai chủ yếu mô tả ảnh giao diện; yêu cầu phi chức năng chưa đo lường được; phần tài liệu tham khảo dùng `\nocite{*}` nên 21 nguồn xuất hiện dù nội dung chỉ có bốn lệnh trích dẫn đang hoạt động.

## 2. Những nội dung đang làm tốt

- Chương 1 xác định đúng trọng tâm: tạo CV, ứng tuyển và ba chức năng AI hỗ trợ.
- Phạm vi Socket.IO và thông báo đã được phân biệt tương đối rõ.
- Chương 4 có hệ thống use case, activity diagram và sequence diagram khá đầy đủ.
- Chương 5 có ảnh minh họa cho ứng viên, doanh nghiệp và quản trị viên.
- Chương 6 trình bày đúng nguyên tắc giảm dữ liệu, đầu ra JSON Schema và người dùng quyết định cuối cùng.
- Chương 7 đã thống nhất 13 tệp, 43/43 ca phía máy chủ và sáu kịch bản Playwright.
- Header, footer, đánh số chương, danh sách hình và danh sách bảng nhìn chung nhất quán.

## 3. Các vấn đề phải sửa trước khi nộp

### P0. Sơ đồ không khớp mã nguồn

1. Biểu đồ lớp mô tả các lớp `AuthController`, `ResumeController`, `JobService`, `ChatService`, `RealtimeGateway`... nhưng phần lớn các lớp này không tồn tại trong mã nguồn hiện tại. Backend thực tế vẫn tập trung nhiều route trong `server/server.js`; chỉ nhóm AI và một số utility/service được tách riêng.
2. ERD và lược đồ quan hệ còn `Post`, `Category`, `SavedPost`, trong khi mã nguồn hiện tại không có các model này.
3. Hai sơ đồ dữ liệu thiếu `AiUsage`, `ChatReadState` và `HiddenChat`; `savedJobs` thực tế được nhúng trong `User`, không phải collection độc lập.
4. Biểu đồ lớp ở trang PDF 61 quá rộng, sau khi xoay trở thành một dải hẹp và chữ rất khó đọc.

**Cách xử lý:** vẽ lại sơ đồ theo mã nguồn thật. Nếu chưa kịp tái cấu trúc backend, không được giữ mô tả kiến trúc phân tầng như thể các controller/service đã tồn tại. Biểu đồ lớp nên thể hiện các module thực tế hoặc đổi thành sơ đồ thành phần. ERD và lược đồ dữ liệu phải sử dụng chín model hiện tại: User, Resume, Job, Application, Message, Notification, AiUsage, ChatReadState và HiddenChat.

### P0. Tuyên bố phân quyền chưa đúng hoàn toàn

Chương 6 hiện nói backend chỉ cho vai trò ứng viên sử dụng AI. Mã nguồn chỉ gắn `authMiddleware` tại `/api/ai`; `RoleAccessGuard` là lớp bảo vệ phía giao diện và không thay thế kiểm tra vai trò ở máy chủ. Vì vậy có hai lựa chọn:

- ưu tiên sửa backend để kiểm tra vai trò ứng viên tại toàn bộ API AI, sau đó giữ mô tả trong báo cáo; hoặc
- nếu không sửa mã nguồn, đổi báo cáo thành “API AI yêu cầu đăng nhập; giao diện hiện giới hạn cho ứng viên” và ghi thiếu kiểm tra vai trò backend là hạn chế.

Các tuyên bố tổng quát như “mọi thao tác đặc quyền đều được kiểm tra ở backend” cũng phải được rà theo từng API, đặc biệt AI, chat, CV và quản trị.

### P0. Thiết kế Application chưa bảo toàn phiên bản CV

`Application` lưu `resumeId` và `jobSnapshot`, nhưng không lưu `resumeSnapshot`. CV có cấu trúc vẫn có thể được chỉnh sửa hoặc xóa sau khi ứng tuyển, nên doanh nghiệp có thể không xem đúng phiên bản CV tại thời điểm nộp. Báo cáo cần mô tả chính xác:

- `jobSnapshot` chỉ bảo toàn ngữ cảnh công việc;
- PDF tải trực tiếp được sao chép thành Resume ảo nên gần với một bản nộp riêng;
- CV có cấu trúc hiện vẫn là tham chiếu động và chưa có cơ chế phiên bản bất biến.

### P0. Cấu trúc báo cáo và phụ lục không thống nhất

Chương 1 nói báo cáo có một phần phụ lục, nhưng toàn bộ `Appendix.tex` đang bị comment nên PDF không có phụ lục. Cần chọn một trong hai:

- kích hoạt và cập nhật phụ lục; hoặc
- xóa mọi câu giới thiệu phụ lục khỏi Chương 1.

## 4. Các vấn đề quan trọng tiếp theo

### P1. Tách rõ Chương 2 và Chương 3

Chương 2 mang tên “Cơ sở lý thuyết” nhưng vẫn trình bày trực tiếp MERN Stack và Socket.IO, trong khi Chương 3 tiếp tục giới thiệu các công nghệ này. Nên tổ chức lại:

- Chương 2: khái niệm client-server, ứng dụng trang đơn, trạng thái máy chủ, RBAC kết hợp quyền sở hữu, cơ sở dữ liệu tài liệu và nhúng/tham chiếu, giao tiếp thời gian thực, mô hình ngôn ngữ và đầu ra có cấu trúc, nguyên tắc con người kiểm soát AI.
- Chương 3: React, TanStack Query, React Hook Form và Zod, Tailwind CSS, Vite, Node.js và Express, Socket.IO, MongoDB và Mongoose, Groq/OpenAI SDK/JSON Schema, react-to-print, PDF.js, công cụ kiểm thử và triển khai.

Phần công nghệ AI hiện có trong tệp Chương 3 nhưng đang bị comment; cần viết lại theo ba chức năng hiện tại rồi kích hoạt, không khôi phục các câu cũ nói năm workflow.

### P1. Yêu cầu phi chức năng chưa đạt chuẩn

Danh sách hiện tại trộn lẫn yêu cầu chức năng, khả năng mở rộng và nhận xét thiết kế. Các câu như “ứng viên có thể tạo nhiều CV” hoặc “doanh nghiệp quản lý nhiều tin” là yêu cầu chức năng. “Dữ liệu thuận tiện bảo trì” không có tiêu chí kiểm chứng.

Nên viết lại thành các nhóm có mã và cách đo:

- bảo mật và quyền truy cập;
- hiệu năng và kích thước dữ liệu;
- tính toàn vẹn;
- khả dụng và phục hồi lỗi;
- tương thích giao diện;
- khả năng bảo trì;
- riêng tư và kiểm soát AI;
- khả năng kiểm thử và tái lập.

Mỗi yêu cầu cần có tiêu chí kiểm chứng, ví dụ giới hạn PDF 5 MB, unique index chống ứng tuyển trùng, thời gian timeout AI, phạm vi màn hình responsive hoặc điều kiện API phải trả 401/403.

### P1. Chương 5 đang thiên về danh mục ảnh giao diện

Chương triển khai nên bổ sung cách hệ thống hoạt động, không chỉ mô tả những gì xuất hiện trên màn hình. Cần thêm các mục:

1. Xác thực JWT và chuỗi middleware.
2. Lưu và cập nhật Resume có cấu trúc.
3. Xuất A4 bằng react-to-print và hiển thị PDF bằng PDF.js.
4. Hai luồng ứng tuyển: CV đã lưu và PDF tải trực tiếp.
5. Unique index và `jobSnapshot`.
6. Chat theo nguyên tắc lưu trước - phát sau; trạng thái đọc và ẩn theo người dùng.
7. Thông báo REST với TanStack Query polling 30 giây.
8. Tác vụ kiểm tra tin hết hạn và giới hạn của môi trường triển khai.

Ảnh giao diện chỉ nên là bằng chứng minh họa cho các luồng trên.

### P1. Chương 6 thiếu kiến trúc tích hợp AI

Cần bổ sung:

- Groq là nhà cung cấp API; `openai/gpt-oss-120b` là mô hình mặc định; OpenAI SDK chỉ là thư viện client tương thích.
- Sơ đồ luồng: giao diện → API có xác thực → sanitizer → quota/rate limit → schema → Groq → validate/normalize → giao diện.
- Hạn mức mặc định, timeout, AiUsage và chính sách không lưu toàn bộ prompt/CV.
- Phân biệt schema đúng cấu trúc với nội dung đúng ngữ nghĩa.
- Hạn chế: chưa benchmark chất lượng bằng chuyên gia, phỏng vấn chưa lưu lịch sử lâu dài, PDF upload chưa được AI đọc trực tiếp.

### P1. Tài liệu tham khảo chưa được sử dụng đúng

Hiện `main.tex` dùng `\nocite{*}`, khiến toàn bộ 21 nguồn xuất hiện dù chỉ có bốn trích dẫn đang hoạt động. Cần:

1. Xóa `\nocite{*}` khi các trích dẫn đã đầy đủ.
2. Trích dẫn nguồn ngay sau các định nghĩa hoặc khẳng định kỹ thuật ở Chương 2, 3, 6 và 7.
3. Ưu tiên tài liệu chính thức: React, TanStack Query, Node.js, Express, MongoDB, Mongoose, Socket.IO, PDF.js, Groq, JSON Schema, JWT RFC, OWASP và NIST AI RMF.
4. Không dùng tài liệu tham khảo chỉ để làm dài danh mục.

## 5. Vấn đề trình bày

### P2. Hình vẽ

- Trang PDF 31: use case tổng quát nhỏ và khó đọc.
- Trang PDF 61: biểu đồ lớp gần như không thể đọc ở kích thước in; nên chia theo tầng/module hoặc dùng trang ngang.
- Trang PDF 62: ERD đã lớn hơn nhưng vẫn chứa thực thể cũ và chữ nhỏ.
- Trang PDF 64: lược đồ quan hệ tương đối rõ nhưng nội dung hình mâu thuẫn với phần giải thích bên dưới.
- Một số activity/sequence diagram từ trang 47 đến 59 có chữ nhỏ; nên kiểm tra ở tỷ lệ in 100%, không chỉ nhìn bản phóng to trên màn hình.
- Nên dùng PDF/vector cho sơ đồ, cắt vùng trắng và không đặt cả `width` lẫn `height` quá sát chiều cao trang vì caption cần không gian.

### P2. Phân bổ nội dung

Chương 4 dài khoảng 37 trang và nhiều bảng đặc tả use case tạo trang thưa. Nên giữ use case quan trọng trong chương chính, chuyển bảng đặc tả chi tiết sang phụ lục. Phần trống ở cuối một số trang có thể giảm bằng cách hạn chế `[H]`, dùng `[htbp]` phù hợp và nhóm hình với phần giải thích liên quan.

### P2. Thuật ngữ và hành văn

Cần thống nhất các cặp thuật ngữ:

- ứng viên thay cho việc xen kẽ `employee`, candidate và người lao động;
- doanh nghiệp thay cho company khi viết văn xuôi;
- đánh giá CV hoặc rà soát CV thay cho việc thay đổi giữa review, chấm và phân tích;
- hồ sơ ứng tuyển cho `Application`, tin tuyển dụng cho `Job`;
- “client-server”, “front-end”, “back-end” theo một quy ước duy nhất.

Rút gọn các câu quảng bá như “độ trễ cực thấp”, “tối ưu vượt bậc”, “hoạt động ổn định” nếu chưa có số liệu đo. Sửa các lỗi câu ở Chương 8 như “thân thiện hơn. thêm...” và bổ sung dấu chấm cuối dòng.

## 6. Kế hoạch chỉnh sửa theo chương

### Giai đoạn 1 - Chốt nguồn sự thật

1. Gắn phiên bản mã nguồn DA2 dùng để bảo vệ.
2. Xuất danh sách route, model, công nghệ, test và chức năng thật.
3. Lập ma trận “tuyên bố trong báo cáo - bằng chứng mã nguồn - trạng thái đúng/sai/cần sửa”.
4. Không chỉnh văn phong trước khi hoàn thành bước đối chiếu này.

### Giai đoạn 2 - Sửa các mâu thuẫn nghiêm trọng

1. Chọn xử lý phân quyền AI bằng sửa mã hoặc sửa tuyên bố.
2. Sửa mô tả kiến trúc backend đúng với `server.js` và các module thật.
3. Vẽ lại biểu đồ lớp/thành phần, ERD và lược đồ dữ liệu.
4. Mô tả rõ trạng thái phiên bản CV trong Application.
5. Kích hoạt phụ lục hoặc xóa phần giới thiệu phụ lục.

### Giai đoạn 3 - Chỉnh Chương 2 và Chương 3

1. Giữ Chương 2 ở mức khái niệm và nguyên lý.
2. Chuyển mô tả công nghệ cụ thể sang Chương 3.
3. Bổ sung mục công nghệ AI, kiểm thử và triển khai đang thiếu.
4. Loại nội dung trùng và các đoạn công nghệ quá dài không liên hệ với RabbitCV.

### Giai đoạn 4 - Chỉnh Chương 4, 5 và 6

1. Viết lại yêu cầu phi chức năng có mã và tiêu chí đo.
2. Giảm số bảng use case trong chương chính; chuyển chi tiết sang phụ lục.
3. Bổ sung phần triển khai các luồng quan trọng ở Chương 5.
4. Hoàn thiện kiến trúc, nhà cung cấp, ba workflow và giới hạn ở Chương 6.

### Giai đoạn 5 - Chỉnh Chương 7 và Chương 8

1. Giữ số liệu 13 tệp/43 ca và sáu kịch bản Playwright nhất quán.
2. Nói rõ Playwright dùng API mô phỏng nên chưa phải end-to-end đầy đủ.
3. Bổ sung ma trận yêu cầu - kiểm thử - kết quả.
4. Viết lại Chương 8 theo ba phần ngắn: kết quả có bằng chứng, hạn chế kỹ thuật cụ thể và ba đến năm hướng phát triển ưu tiên.
5. Bỏ kết luận “hoàn thành toàn bộ mục tiêu” nếu vẫn còn mục tiêu chưa được kiểm chứng.

### Giai đoạn 6 - Trích dẫn, ngôn ngữ và kiểm tra cuối

1. Gắn trích dẫn vào từng nội dung lý thuyết/công nghệ và xóa `\nocite{*}`.
2. Chuẩn hóa thuật ngữ, viết hoa, dấu câu và tên hình/bảng.
3. Biên dịch sạch từ đầu; kiểm tra reference, citation, overfull/underfull box.
4. Xem trực quan toàn bộ PDF ở tỷ lệ in 100%.
5. Chạy lại lint, test và build; cập nhật số liệu nếu kết quả thay đổi.

## 7. Thứ tự ưu tiên nếu thời gian ngắn

Nếu chỉ còn ít thời gian, sửa theo thứ tự:

1. Sơ đồ lớp, ERD và lược đồ dữ liệu.
2. Tuyên bố phân quyền AI và kiến trúc backend.
3. Phụ lục, `\nocite{*}` và trích dẫn.
4. Yêu cầu phi chức năng.
5. Chương 6 và Chương 8.
6. Độ rõ của hình vẽ và chuẩn hóa thuật ngữ.

## 8. Tiêu chí hoàn thành

Báo cáo được xem là sẵn sàng khi:

- mọi model, route, chức năng và sơ đồ đều đối chiếu được với phiên bản mã nguồn đã chốt;
- không còn khẳng định một lớp bảo mật phía giao diện là biện pháp bảo vệ backend;
- không còn thực thể hoặc lớp không tồn tại trong sơ đồ;
- các yêu cầu phi chức năng đều có thể kiểm chứng;
- mọi nguồn trong danh mục đều được trích dẫn thực sự và mọi khẳng định bên ngoài đều có nguồn;
- hình vẽ đọc được khi in A4 ở 100%; caption không chạm footer;
- số liệu kiểm thử thống nhất ở Chương 1, 7 và 8;
- Chương 8 không tuyên bố vượt quá bằng chứng đã trình bày;
- PDF được biên dịch sạch và đã kiểm tra toàn bộ trang sau lần sửa cuối.
