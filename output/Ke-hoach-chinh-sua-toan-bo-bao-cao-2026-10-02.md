# Kế hoạch chỉnh sửa nội dung báo cáo RabbitCV

Ngày rà soát: 02/10/2026.

## 1. Phạm vi và kết luận

Đã rà nội dung LaTeX của các chương hiện có, nội dung phụ lục đang bị comment, tài liệu tham khảo, các hình kiến trúc/lớp/ERD/lược đồ quan hệ và các phần mã nguồn cốt lõi tương ứng trong D:/Github/DA2: cấu hình dự án, định tuyến, model, AI, CV, chat, thông báo, quyền truy cập và kiểm thử.

Đây là kế hoạch chỉnh nội dung, chưa sửa các chương và chưa sửa mã ứng dụng. Không phải kiểm toán toàn bộ bảo mật, kiểm thử tải hay xác nhận hạ tầng production. Không sử dụng bản main.pdf ở thư mục gốc làm nguồn duy nhất vì bản này có thời điểm cập nhật cũ hơn nhiều tệp nguồn.

Kết luận: giữ khung chín chương là hợp lý. Cần sửa sâu Chương 5, 6, 7, 8; tổ chức lại Chương 3 và tinh gọn Chương 4; sửa có chọn lọc Chương 1 và 9. Chương 2 hiện là bản khảo sát TopCV và LinkedIn, chỉ cần hoàn thiện nguồn và một số mô tả chức năng.

### Tình trạng cần xử lý trước

- Tệp Chapter/C2-related-systems.tex thay đổi ngay trong quá trình rà soát: có lúc không tồn tại nhưng cuối lượt đã có lại với nội dung TopCV và LinkedIn, tên chương là Các hệ thống liên quan. Kế hoạch này đã cập nhật theo bản mới nhất đọc được, không khôi phục bản cũ hoặc tự thay nhóm khảo sát.
- Chapter/Appendix.tex đang bị comment toàn bộ; main.tex vẫn input phụ lục. Vì vậy phụ lục được giới thiệu ở Chương 1 nhưng không có nội dung xuất hiện.
- Nhiều tệp/chức năng ở DA2 đang có thay đổi chưa commit. Kết quả kiểm thử hiện tại thuộc working tree, không thể gán nguyên kết quả đó cho commit gần nhất.
- Cần chốt một phiên bản mã nguồn và ngày khảo sát/kiểm thử thống nhất trước khi cập nhật bảng kết quả, ảnh giao diện và kết luận.

## 2. Những sai lệch quan trọng đã xác định

| Vấn đề trong báo cáo | Bằng chứng đối chiếu | Cách xử lý nội dung |
|---|---|---|
| CV-1.9 nói hệ thống lưu kết quả vào lịch sử phỏng vấn | AiInterview.jsx dùng state cho messages/summary; Chương 7 cũng nói lịch sử chỉ trong phiên | Viết lại hậu điều kiện và luồng: hiển thị tổng kết trong phiên, chưa có lưu/khôi phục lịch sử từ cơ sở dữ liệu |
| Sơ đồ kiến trúc ghi Socket.IO cập nhật thông báo tức thì | useNotifications.js lấy số chưa đọc theo chu kỳ 30 giây; server phát newMessage | Sửa hình và văn bản: chat qua Socket.IO, thông báo tuyển dụng qua REST/polling |
| Sơ đồ lớp mô tả nhiều Controller/Service như các lớp hiện thực | Phần lớn route và handler ở server/server.js; service tách riêng gồm AI và cập nhật trạng thái hồ sơ | Nếu giữ như thiết kế logic thì ghi rõ mức trừu tượng; thêm ánh xạ sang module thật, không gọi tên lớp giả định là mã đã hiện thực |
| ERD và relational schema có Post, Category, SavedPost | Danh mục server/models có 9 model, không có 3 model trên; News dùng src/data/newsArticles.js | Vẽ lại theo phạm vi thật hoặc chuyển những thực thể chưa hiện thực sang thiết kế mở rộng |
| Dữ liệu thông báo/tin nhắn trong hình không khớp trường thực tế | Notification dùng recipient; Message dùng senderId; Application dùng candidateId và resumeId | Đồng nhất tên trường, kiểu và quan hệ; bổ sung ChatReadState, HiddenChat, AiUsage theo mức chi tiết phù hợp |
| Chương 5/6 mô tả mở khóa người dùng | Route /api/admin/users/:id/ban chỉ đặt isBanned=true; chưa thấy endpoint mở khóa tương ứng | Bỏ phần đã hoàn thành hoặc ghi là chức năng cần hoàn thiện; không thêm chức năng vào mã trong đợt sửa báo cáo |
| Luồng quên mật khẩu nói gửi email xác thực | Danh mục route hiện tại không có luồng forgot/reset/email tương ứng | Loại khỏi hiện thực hiện tại hoặc đánh dấu ngoài phạm vi |
| Chương 7 nói backend yêu cầu đúng vai trò ứng viên | /api/ai gắn authMiddleware; route AI chưa có kiểm tra employee trực tiếp; frontend có RoleAccessGuard | Phân biệt xác thực API với chặn giao diện; ghi rõ phần kiểm tra vai trò backend còn cần hoàn thiện |
| PDF tải lên bị mô tả phải là A4 | pdfValidation.js kiểm tra tên tệp, data URL/base64, dấu hiệu header và dung lượng, không kiểm tra khổ trang | Tách A4 của CV tạo trên web khỏi kiểm tra tệp PDF upload; không khẳng định kiểm tra toàn bộ cấu trúc PDF hoặc mọi nội dung nguy hiểm |
| 43/43 ca, 13 tệp là số liệu đang trình bày | Lần chạy hiện tại thực tế: 79/79 ca đạt, 20 tệp, Node v24.19.0; khoảng 8,692 giây trong lần chạy này | Cập nhật theo phiên bản chốt và log thật; không lấy thời gian cũ làm kết quả phiên bản mới |
| aiIntegration.test.js được mô tả kiểm tra kết nối AI hoạt động | Test đọc mã nguồn và assert.match cho cấu hình/route | Đổi mô tả thành kiểm tra hợp đồng/cấu hình mã nguồn, không coi là gọi Groq thật |
| a4Layout.test.js được diễn giải như đo trang in thật | Nhiều assertion đọc CSS/JS bằng regex | Tách kiểm tra khai báo kích thước khỏi đo DOM/Print Preview và PDF thực tế |
| OpenAPI test bị mô tả đối chiếu toàn bộ route thực tế | Test chủ yếu kiểm số paths/operations và một số khai báo, không tự so khớp tất cả route server | Viết đúng phạm vi kiểm tra; nếu muốn kết luận bao phủ toàn bộ phải bổ sung kiểm tra tương ứng |
| Kéo thả còn ở hướng phát triển | ResumeLayoutEditor dùng dnd-kit; Resume có useResumeHistory; model có layout/customSections | Đưa kéo thả bố cục theo vùng, mục tùy chỉnh và undo/redo vào phần hiện thực; không đánh đồng với di chuyển tự do mọi phần tử trên trang |
| Bảng xếp hạng bị mô tả là số lượt thực tế | TopPage có overviewStats cố định; tin tức lấy dữ liệu tĩnh | Ghi rõ dữ liệu minh họa; không xem là số liệu người dùng thật hay chức năng phân tích đã nghiệm thu |

Các vấn đề trên không có nghĩa mọi phần mềm đều sai. Vấn đề chính là độ chính xác của lời mô tả và việc gán mức bằng chứng cao hơn những gì đã kiểm tra.

## 3. Kế hoạch theo từng chương

### Chương 1 — Tổng quan đề tài
Mức sửa: vừa; thực hiện sau khi chốt thiết kế và kết quả kiểm thử.

Giữ bối cảnh tạo CV và ba nhóm hỗ trợ AI, bốn nhóm người dùng. Bổ sung phát biểu bài toán ngắn: đầu vào của người dùng, khó khăn cần xử lý và đầu ra hệ thống cần cung cấp. Có mục phạm vi trong/ngoài đề tài để giới hạn rõ AI, PDF, tuyển dụng, lịch sử và triển khai.

Sửa các nhận định như CV cũ làm giảm đáng kể cơ hội nếu không có khảo sát hoặc nguồn; dùng cách viết trung tính. Tách mục tiêu khỏi kết quả đã đạt. Mục tiêu về PDF cần nói rõ các kiểm tra thực tế, không nhận là bộ kiểm định PDF đầy đủ.

Cập nhật cấu trúc báo cáo: tên chương và nền tảng phải khớp khảo sát mới TopCV/LinkedIn; không tiếp tục ghi Canva, Enhancv, ChatGPT như các đối tượng đang được khảo sát trong Chương 2. Mô tả Chương 4, 7, 8 và phụ lục phải khớp những mục thực sự xuất hiện.

Đầu ra: bài toán, mục tiêu có thể đối chiếu, phạm vi và cấu trúc thống nhất.

### Chương 2 — Các hệ thống liên quan
Mức sửa: nhẹ đến vừa; giữ nhóm khảo sát mới TopCV và LinkedIn.

Bản mới có tiêu chí khảo sát, chức năng, ưu điểm, giới hạn, bảng đối chiếu và định hướng RabbitCV. Giữ cấu trúc này. Hiện không có lệnh cite trong phần đang xuất bản dù có nhiều thông tin chi tiết về LinkedIn PDF, Easy Apply/Apply, job alerts, Premium và Recruiter. Cần kiểm chứng các điều kiện được mô tả bằng tài liệu chính thức và đặt trích dẫn cạnh nhận định hoặc bảng tương ứng; không chỉ ghi chung rằng có tham khảo tài liệu.

Sửa định hướng RabbitCV đang ghi nhắn tin và thông báo theo thời gian thực: chat dùng Socket.IO, thông báo tuyển dụng được truy vấn định kỳ. Làm rõ phạm vi AI của đồ án, tránh suy ra ưu thế so với hai nền tảng từ thông tin chưa khảo sát. Không quay lại các kết luận không có chứng cứ như nền tảng khác không có AI/chat hoặc RabbitCV vượt trội về bảo mật.

Có thể bổ sung một vài ảnh có nguồn, ngày truy cập và giải thích chức năng cụ thể, không thêm quá nhiều ảnh quảng bá. Kết thúc bằng yêu cầu rút ra cho RabbitCV, không lặp chi tiết triển khai của Chương 6/7. Đồng nhất tên chương này với mục cấu trúc báo cáo ở Chương 1.

Đầu ra: khảo sát có thể kiểm tra nguồn, bảng đối chiếu trung lập và cơ sở lựa chọn chức năng.

### Chương 3 — Cơ sở lý thuyết
Mức sửa: tổ chức lại.

Hiện chương chỉ có client-server, MERN, RBAC, Socket.IO và không có trích dẫn trong phần đang xuất bản. Nội dung lý thuyết lại chứa chi tiết hiện thực frontend, quota và thông báo.

Đề xuất cấu trúc:
1. Kiến trúc ứng dụng web client-server và giao tiếp yêu cầu–phản hồi.
2. Xác thực và phân quyền: phân biệt danh tính, vai trò và quyền trên tài nguyên.
3. Mô hình dữ liệu tài liệu: nhúng, tham chiếu và bản chụp dữ liệu phục vụ lịch sử.
4. Giao tiếp dựa trên sự kiện, thời gian thực và đồng bộ định kỳ.
5. Mô hình ngôn ngữ lớn: suy luận qua API, ngữ cảnh, prompt, đầu ra có cấu trúc và giới hạn ngữ nghĩa.

MERN nên chỉ giữ một đoạn tổng quan hoặc chuyển sang lựa chọn công nghệ ở Chương 4. Socket.IO cụ thể chuyển sang Chương 4; Chương 3 trình bày nguyên lý giao tiếp. Không bổ sung lịch sử AI, công thức huấn luyện hay thuật toán không dùng trong đồ án.

Đầu ra: mỗi khái niệm có định nghĩa, tác dụng với bài toán, giới hạn và nguồn; không biến thành chương giới thiệu thư viện thứ hai.

### Chương 4 — Giới thiệu các công nghệ đã sử dụng
Mức sửa: tinh gọn và sửa kỹ thuật.

Giữ các mục React, TanStack Query, React Hook Form/Zod, Tailwind, Vite, Node/Express, Socket.IO, MongoDB/Mongoose và PDF. Viết theo cấu trúc: định nghĩa ngắn, tính năng được dùng, lý do chọn trong RabbitCV, giới hạn cần biết. Gộp các ý ưu điểm trùng nhau; không xóa hết phần giải thích mà người dùng đã yêu cầu.

Sửa cụ thể:
- Socket.IO: bỏ mô tả Flash Socket/IFrame/JSONP như công nghệ hiện tại; không đồng nhất Socket.IO với WebSocket thuần.
- Zod: bỏ cách giải thích trước đây chỉ kiểm tra lúc phát triển; phân biệt kiểm tra runtime với kiểu tĩnh. Validation frontend không bảo đảm mọi dữ liệu tới server đều an toàn.
- React/Tailwind/Node: giảm các từ bảo đảm hiệu năng cao, tối đa, luôn chính xác khi chưa đo.
- TanStack Query: giữ fetch/Axios thuộc lớp HTTP, nhưng mô tả đúng RabbitCV dùng chủ yếu cho việc đã lưu và thông báo, không quản lý toàn bộ dữ liệu ở mọi màn hình.
- React Hook Form/Zod hiện dùng ở Login/Register; không viết như mọi form CV/doanh nghiệp đều đã dùng.
- Bổ sung ngắn Tiptap, dnd-kit nếu đưa vào phạm vi phiên bản mới.
- Bổ sung công nghệ AI, JWT/cookie/bcrypt và hạ tầng triển khai ở mức giới thiệu; cách hiện thực chi tiết chuyển sang Chương 6/7.
- react-to-print mở hộp thoại in; không gọi nó là dịch vụ backend trực tiếp tạo và gửi tệp PDF.

Nguồn kỹ thuật đã đối chiếu: [Socket.IO v4](https://socket.io/docs/v4/), [Zod Basic Usage](https://zod.dev/basics). Phiên bản thư viện của đồ án phải lấy từ bản cài/lockfile của phiên bản chốt, không tự đổi thành phiên bản mới nhất của tài liệu.

Đầu ra: công nghệ được chọn có lý do gắn với bài toán, không phải danh sách quảng bá.

### Chương 5 — Phân tích và thiết kế hệ thống
Mức sửa: sâu; ưu tiên cao nhất.

Giữ bốn nhóm tác nhân và các nghiệp vụ chính. Sắp xếp: tác nhân → yêu cầu → quyền → kiến trúc → dữ liệu → luồng tiêu biểu.

1. Yêu cầu chức năng: thêm mã FR; làm rõ CRUD CV, xem trước/in, PDF ứng tuyển, lưu việc, theo dõi hồ sơ, thông báo, trạng thái đọc/ẩn chat và chức năng quản trị có thật.
2. Yêu cầu phi chức năng: bỏ các câu tạo nhiều CV/quản lý nhiều tin khỏi nhóm này vì đó là chức năng. Tách bảo mật/riêng tư, toàn vẹn, đáp ứng giao diện, khả năng bảo trì và hiệu năng. Tiêu chí nghiệm thu phải được chọn trước khi đo; không đặt số giây tùy ý rồi ghi như kết quả đạt.
3. Đặc tả use case: sửa tiền/hậu điều kiện theo nghiệp vụ; không coi đang ở dashboard là điều kiện nghiệp vụ bắt buộc. Phân biệt nhánh không tìm thấy dữ liệu với lỗi hệ thống. Bỏ lỗi bảo trì lặp ở mọi bảng nếu không có cơ chế tương ứng.
4. Tìm việc: guest cũng được dùng, không bắt buộc đăng nhập cho việc đọc/tìm công khai.
5. Xuất CV: mô tả trình duyệt mở hộp thoại in/lưu PDF; không nói server gửi tệp khi luồng thật không làm như vậy.
6. Phỏng vấn: hỏi từng lượt, không khẳng định sinh sẵn toàn bộ danh sách; không lưu lịch sử lâu dài.
7. Ứng tuyển: giải thích Application, jobSnapshot, resumeId, CV PDF isVirtual; không gọi CV đã nộp bất biến khi chưa có resumeSnapshot.
8. Trạng thái: đồng nhất Pending, Reviewing, Interview, Offered, Rejected, Accepted; bổ sung quy tắc Rejected là trạng thái khóa theo applicationStatusService.
9. Kiến trúc: tách sơ đồ thành phần khỏi sơ đồ triển khai. Chỉ ra route/handler thật, AI service, MongoDB, REST, Socket.IO, ticket và relay. Phân biệt local chạy cùng tiến trình với cấu hình tách realtime khi triển khai; xác nhận hạ tầng đang dùng trước khi ghi Render/Railway là nơi vận hành thực tế.
10. Dữ liệu: vẽ lại ERD/lược đồ theo model; savedJobs nhúng trong User, không coi SavedJob là collection hiện thực. Bổ sung dictionary trường quan trọng, index, vòng đời xóa/ẩn và tham chiếu.
11. Sơ đồ lớp: giữ như mô hình thiết kế logic hoặc thay bằng sơ đồ module và model thật. Không phải tạo hàng loạt lớp mới chỉ để khớp hình báo cáo.
12. Rà lại tất cả hình use case/activity/sequence để tên API, trạng thái, quyền và kênh truyền khớp văn bản.

Đầu ra: người đọc truy được mỗi yêu cầu sang mô hình dữ liệu, luồng xử lý và trường hợp kiểm thử.

### Chương 6 — Triển khai hệ thống
Mức sửa: sâu; ưu tiên rất cao.

Hiện chương có 25 ảnh nhưng phần đang xuất bản chủ yếu là mô tả trang và nút. Giữ ảnh tiêu biểu nhưng đổi trọng tâm sang cách giải quyết vấn đề kỹ thuật.

Đề xuất cấu trúc:
1. Tổ chức mã nguồn và môi trường vận hành.
2. Xác thực, phiên đăng nhập và kiểm soát quyền.
3. Trình biên tập CV: dữ liệu, mẫu, Tiptap, mục tùy chỉnh, bố cục kéo thả theo vùng và undo/redo nếu chọn phiên bản mới.
4. Xem trước, tự co nội dung A4, in và hiển thị PDF; nêu giới hạn khi nội dung quá dài.
5. Ứng tuyển bằng CV đã lưu/PDF: các bước kiểm tra, lưu Application, unique index, jobSnapshot và xử lý trùng.
6. Quản lý tin và trạng thái hồ sơ.
7. Chat: REST lưu tin → phát newMessage trực tiếp hoặc qua relay → Socket.IO client; trạng thái đọc/ẩn theo từng người.
8. Thông báo: tạo theo sự kiện nghiệp vụ, truy vấn định kỳ, cache/cập nhật lạc quan.
9. Quản trị và giới hạn thực tế.
10. Cấu hình triển khai, dữ liệu mẫu và phần chưa hoàn thiện.

Mỗi luồng chính có đầu vào, module/API, thao tác dữ liệu, kiểm tra quyền, kết quả và trường hợp lỗi. Không cần chép toàn bộ mã nguồn; dùng đoạn ngắn hoặc bảng ánh xạ khi thực sự hữu ích.

Ghi rõ TopPage/tin tức và một số tỷ lệ hiển thị là dữ liệu minh họa nếu chưa có API/thống kê thật. Bỏ lời khẳng định lịch phỏng vấn có sẵn, trạng thái online hoặc mọi chức năng quản trị đã đầy đủ nếu không có bằng chứng.

Đầu ra: chương hiện thực giải thích được cách làm, không chỉ chứng minh có giao diện.

### Chương 7 — Mô-đun trí tuệ nhân tạo
Mức sửa: sâu; ưu tiên rất cao.

Giữ ba chức năng thực tế. Phần nhà cung cấp, model mặc định và quy trình xử lý đang bị comment cần được viết lại có chọn lọc, không bỏ comment hàng loạt vì một số nội dung cũ đã lỗi thời.

Đề xuất cấu trúc:
1. Mục tiêu và phạm vi AI: trợ lý nội dung/luyện tập, không quyết định tuyển dụng.
2. Kiến trúc tích hợp: frontend → backend → sanitizer → AI service → nhà cung cấp → kiểm tra đầu ra → giao diện.
3. Nhà cung cấp và model: mã hiện tại dùng OpenAI SDK với baseURL của Groq; DEFAULT_MODEL là openai/gpt-oss-120b và có thể bị cấu hình ghi đè. Phân biệt SDK, nhà cung cấp, model và ChatGPT; không gọi toàn bộ tích hợp là ChatGPT.
4. Review: input có cấu trúc, tiêu chí/điểm, output; điểm ATS là nhận xét của mô hình trên dữ liệu gửi vào, không phải phép chạy mọi ATS trên PDF thật.
5. Điền CV: quy tắc từng nhóm, xem lại/lưu, undo/redo. Mã hiện tại có bổ sung kỹ năng mới dù nhóm kỹ năng đã có; quy tắc không ghi đè cũng có ngoại lệ xử lý description đáng ngờ. Không viết tuyệt đối một quy tắc chung cho mọi trường.
6. Phỏng vấn: start/answer/finish, cấu hình, lịch sử gửi lại từng lượt, feedback và summary; nêu giới hạn lưu phiên.
7. Prompt và JSON Schema: một ví dụ đã ẩn danh cho mỗi chức năng hoặc một ví dụ tiêu biểu; phân biệt đúng cấu trúc với đúng sự thật.
8. Quota/rate limit/timeout/retry/usage: ghi giá trị mặc định và khả năng cấu hình; API status kiểm tra trạng thái cấu hình/quota, không phải một phép gọi model để chứng minh provider đang khỏe.
9. Rủi ro: prompt injection, suy diễn, dữ liệu nhạy cảm xuất hiện trong văn bản tự do, phụ thuộc provider và quyền backend.
10. Dẫn sang phần đánh giá AI ở Chương 8.

Đầu ra: người đọc hiểu AI được dùng thế nào, gửi gì, nhận gì, kiểm soát gì và chưa bảo đảm điều gì.

### Chương 8 — Kiểm thử và đánh giá
Mức sửa: sâu; ưu tiên rất cao.

Không tiếp tục dùng số lượng bài kiểm thử như bằng chứng hệ thống đã được nghiệm thu đầy đủ. Tách bốn nhóm: kiểm tra tĩnh/hợp đồng mã nguồn, kiểm thử hàm độc lập, giao diện API mô phỏng và tích hợp với dịch vụ thật.

Đề xuất cấu trúc:
1. Môi trường và phiên bản: OS, Node, trình duyệt, commit/working tree, ngày chạy, dữ liệu thử, lệnh.
2. Phạm vi/phương pháp: đã kiểm tra và chưa kiểm tra.
3. Kết quả tự động: cập nhật danh mục theo log thật; gộp ảnh Playwright chi tiết vào phụ lục, không dành quá nhiều trang cho đăng nhập.
4. Kiểm thử nghiệp vụ cốt lõi: tạo/lưu/xem CV, bố cục, undo/redo, PDF, hai cách ứng tuyển, nộp trùng/tin hết hạn, quyền CV, cập nhật trạng thái, chat và thông báo.
5. Kiểm thử tích hợp: tài khoản giả và database thử riêng; bằng chứng thực sự đi qua frontend/backend/database. Không dùng dữ liệu production và không gọi AI tốn hạn mức khi chưa thống nhất.
6. Đánh giá AI: tập CV/ngữ cảnh ẩn danh hoặc tổng hợp; tiêu chí bám dữ liệu, cụ thể, hữu ích, không bịa sự kiện, đúng schema và độ trễ. Chọn số mẫu khả thi và ghi đúng số mẫu đã làm; chưa chạy thì chỉ ghi kế hoạch.
7. Kiểm tra phi chức năng: mobile/tablet/desktop, CV dài/in, một số trường hợp lỗi kết nối, quyền API; chưa có tải/xâm nhập thì nêu rõ.
8. Ma trận FR/NFR → test → bằng chứng → kết quả.
9. Tổng hợp lỗi phát hiện, mức xử lý và giới hạn còn lại.

Bỏ các kết luận triệt để XSS, bảo mật vững chắc chỉ từ chặn route frontend, vượt bậc tốc độ so với framework khác khi không có benchmark. Thời gian bước assertion Playwright không phải thời gian API/hiệu năng production.

Bằng chứng mới trong lần rà soát: chạy 20 tệp *.test.js bằng node --test --test-reporter=tap, kết quả 79 passed/0 failed/0 skipped. Chưa chạy lại Playwright, lint, build, backend với MongoDB hoặc Groq thật trong lần rà soát này. Không tự đưa những phần chưa chạy vào cột Đạt.

Đầu ra: có bằng chứng tái lập cho nghiệp vụ chính và kết luận đúng phạm vi.

### Chương 9 — Kết luận và hướng phát triển
Mức sửa: vừa; thực hiện sau Chương 8.

Giữ ngắn gọn: kết quả đối chiếu mục tiêu, hạn chế cụ thể, hướng phát triển có ưu tiên. Không khẳng định hoàn thành toàn bộ mục tiêu/ổn định nếu Chương 8 chưa có đủ bằng chứng. Không dùng câu tính bảo mật không cao nếu không có kết quả kiểm toán; thay bằng thiếu kiểm thử bảo mật/kiểm tra quyền/cơ chế còn chưa hoàn thiện cụ thể.

Phân biệt đã có kéo thả bố cục theo vùng với tương lai kéo thả tự do. Phân biệt undo/redo trong phiên với lịch sử phiên bản bền vững. Đưa lịch sử phỏng vấn, snapshot CV, kiểm thử tích hợp, xử lý CV dài và quyền backend vào nhóm ưu tiên trước; đa ngôn ngữ, dark mode, Word, lịch ngoài là mở rộng sau.

Đầu ra: kết luận trung thực, ngắn và bám số liệu.

## 4. Phụ lục, tóm tắt và tài liệu tham khảo

- Phụ lục: quyết định khôi phục bản rút gọn hoặc bỏ phần giới thiệu phụ lục ở Chương 1. Nếu khôi phục, giữ lệnh tái lập, bảng test chi tiết, danh mục API và biến môi trường chỉ có tên/mục đích. Loại các API AI cũ không còn và mọi giá trị bí mật.
- Tóm tắt trong main.tex: viết bài toán → giải pháp → hiện thực → kết quả đã kiểm chứng → giới hạn; giảm các câu khẳng định CV quyết định tuyệt đối cơ hội việc làm.
- Tài liệu tham khảo: bản Chương 2 mới và Chương 3/7 không có cite trong phần đang xuất bản, Chương 4 chỉ có 4 lần cite. main.tex dùng nocite{*}, khiến có nhiều nguồn trong danh mục dù chưa dẫn ở nội dung. Gắn nguồn vào định nghĩa/nhận định thực sự sử dụng, sau đó quyết định bỏ nocite{*}.
- Không tự đặt mọi tài liệu là xuất bản năm 2026 nếu đó chỉ là năm truy cập. Với trang sống, ghi ngày truy cập và metadata thực có.
- Đồng nhất ngày bìa, mốc khảo sát và mốc đánh giá; nếu dữ liệu đánh giá thuộc phiên bản khác phải ghi riêng.
- Rà số chương, tiêu đề, nhãn, tên trạng thái và từ ngữ: mô-đun, rà soát/đánh giá CV, gợi ý hoàn thiện CV, luyện tập phỏng vấn.
- Quy tắc trình bày: đoạn ngắn dùng văn xuôi; chỉ itemize khi liệt kê thực sự; không biến câu mở đầu của mọi mục thành bullet.
- QA hình/PDF thực hiện cuối sau khi nội dung ổn định; không dùng việc thay bố cục để che sai lệch dữ liệu hoặc sơ đồ.

## 5. Thứ tự thực hiện

1. Chốt phiên bản nguồn, đồng bộ cấu trúc theo Chương 2 TopCV/LinkedIn và quyết định phụ lục.
2. Lập bảng chức năng thật/dữ liệu mẫu/chưa hiện thực; sửa sai lệch ở Chương 5, 6, 7, 9.
3. Sửa yêu cầu, kiến trúc, sơ đồ dữ liệu và luồng tiêu biểu ở Chương 5.
4. Viết lại Chương 6 theo luồng hiện thực và Chương 7 theo pipeline AI.
5. Chốt kế hoạch đánh giá, chạy những kiểm thử được cho phép, lưu log và viết Chương 8 theo kết quả thật.
6. Tổ chức lại Chương 3, tinh gọn Chương 4, hoàn thiện Chương 2.
7. Đồng bộ Chương 1, tóm tắt, Chương 9, phụ lục và tài liệu tham khảo.
8. Biên dịch báo cáo, kiểm tra nhãn/trích dẫn, hình/bảng, mục lục và toàn bộ bố cục PDF.

## 6. Tiêu chí hoàn tất

- Không còn chức năng chưa hiện thực bị mô tả như đã hoàn thành.
- Các sơ đồ, model, API và văn bản thống nhất theo phiên bản mã nguồn đã chọn.
- Lý thuyết/công nghệ/thiết kế/hiện thực có vai trò riêng, không lặp cùng một giải thích dài.
- Mọi số liệu kiểm thử có ngày, môi trường, phiên bản và log; kết quả mô phỏng không được gọi là tích hợp thật.
- Ba chức năng AI có input/output, ví dụ, giới hạn và cách kiểm tra; không dùng schema hợp lệ làm bằng chứng nội dung đúng.
- Kết luận chỉ dựa trên phạm vi đã hiện thực và đã kiểm chứng.
- File được input đều tồn tại; phụ lục xuất bản nếu báo cáo giới thiệu nó; PDF cuối được biên dịch và kiểm tra trực quan.

## 7. Một số vị trí nguồn để đối chiếu

- [Cấu trúc báo cáo hiện tại](D:/Github/DACN/Chapter/C1-overview.tex:74)
- [Yêu cầu phi chức năng](D:/Github/DACN/Chapter/C5-system-design.tex:129)
- [Đặc tả phỏng vấn AI](D:/Github/DACN/Chapter/C5-system-design.tex:614)
- [Mô tả lớp và kiến trúc](D:/Github/DACN/Chapter/C5-system-design.tex:1633)
- [Triển khai hiện đang thiên về giao diện](D:/Github/DACN/Chapter/C6-system-implementation.tex:36)
- [Phân quyền AI được mô tả](D:/Github/DACN/Chapter/C7-ai-module.tex:171)
- [Danh mục kiểm thử cũ](D:/Github/DACN/Chapter/C8-testing-evaluation.tex:76)
- [Kết luận và hạn chế](D:/Github/DACN/Chapter/C9-conclusion.tex:22)
- [Application: liên kết và jobSnapshot](D:/Github/DA2/server/models/Application.js:1)
- [Resume: dữ liệu nhúng và layout](D:/Github/DA2/server/models/Resume.js:1)
- [Route AI](D:/Github/DA2/server/routes/aiRoutes.js:1)
- [Nhà cung cấp/model mặc định](D:/Github/DA2/server/services/aiService.js:1)
- [Kiểm tra PDF upload](D:/Github/DA2/server/utils/pdfValidation.js:1)
- [Thông báo định kỳ](D:/Github/DA2/src/hooks/useNotifications.js:1)
- [Kéo thả bố cục](D:/Github/DA2/src/Components/ResumeLayoutEditor.jsx:1)
- [Kiểm tra mã nguồn AI, không phải kết nối thật](D:/Github/DA2/test/aiIntegration.test.js:17)
