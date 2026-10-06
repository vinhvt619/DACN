# Bộ câu hỏi và trả lời phản biện đề tài RabbitCV

Tài liệu này được biên soạn để luyện trả lời miệng. Mỗi câu trả lời tập trung vào ý chính, có thể trình bày trong khoảng 20–40 giây. Khi trả lời trước hội đồng, nên nói kết luận trước, sau đó mới giải thích hoặc minh họa bằng chức năng của hệ thống.

## Thông tin phải thống nhất trước khi bảo vệ

- Hệ thống hiện có **ba chức năng AI chính**: đánh giá nội dung CV, gợi ý điền phần còn thiếu của CV và luyện tập phỏng vấn.
- Nhà cung cấp dịch vụ suy luận là **Groq**; mô hình mặc định là **`openai/gpt-oss-120b`**. Thư viện OpenAI chỉ được dùng như một trình khách tương thích để gửi yêu cầu đến API của Groq.
- Bộ kiểm thử phía máy chủ hiện có **13 tệp, 43 trường hợp và 43 trường hợp đạt**. Một số đoạn trong Chương 7 còn ghi 12 tệp hoặc 41 trường hợp là số liệu cũ cần sửa.
- Playwright có **6 kịch bản đạt**, nhưng các API được mô phỏng bằng `page.route()`. Vì vậy đây là kiểm thử luồng giao diện, chưa phải kiểm thử đầu cuối với máy chủ và MongoDB thật.
- Socket.IO hiện được dùng cho **tin nhắn trò chuyện**. Thông báo được lấy qua REST và TanStack Query, trong đó số thông báo chưa đọc được kiểm tra lại định kỳ khoảng 30 giây.
- Lịch sử luyện phỏng vấn hiện chỉ tồn tại trong trạng thái của giao diện và sẽ mất khi tải lại hoặc đóng trang; hệ thống chưa lưu lịch sử này lâu dài.

---

## 1. Các câu hỏi tổng quan gần như chắc chắn sẽ gặp

### Câu 1. Vì sao bạn chọn đề tài RabbitCV?

Tôi chọn đề tài vì quá trình tạo CV, tìm việc, ứng tuyển và luyện phỏng vấn thường bị phân tán trên nhiều nền tảng. RabbitCV hướng đến việc kết hợp các bước đó trong một hệ thống, đồng thời dùng AI như công cụ hỗ trợ để người dùng chuẩn bị hồ sơ tốt hơn nhưng vẫn giữ quyền quyết định cuối cùng.

### Câu 2. Bài toán chính mà đề tài giải quyết là gì?

Đề tài giải quyết ba khó khăn chính: ứng viên khó xây dựng CV có cấu trúc và trình bày phù hợp; việc quản lý hồ sơ ứng tuyển còn rời rạc; và người dùng thiếu công cụ phản hồi, gợi ý nội dung cũng như luyện phỏng vấn theo vị trí mong muốn.

### Câu 3. Mục tiêu chính của đề tài là gì?

Mục tiêu là xây dựng một ứng dụng web cho phép tạo và quản lý CV theo khổ A4, sử dụng CV đã lưu hoặc CV PDF tải lên để ứng tuyển, theo dõi quá trình tuyển dụng, trao đổi với doanh nghiệp và sử dụng AI để đánh giá CV, gợi ý nội dung còn thiếu và luyện phỏng vấn.

### Câu 4. Đối tượng sử dụng của hệ thống là ai?

Hệ thống có bốn nhóm người dùng: khách chưa đăng nhập, ứng viên, doanh nghiệp và quản trị viên. Mỗi nhóm có chức năng và phạm vi dữ liệu khác nhau; ví dụ ứng viên quản lý CV và ứng tuyển, doanh nghiệp quản lý tin và hồ sơ, còn quản trị viên quản lý dữ liệu toàn hệ thống.

### Câu 5. Điểm nổi bật của RabbitCV là gì?

Điểm nổi bật là tích hợp CV có cấu trúc, CV PDF, tuyển dụng, theo dõi hồ sơ, trò chuyện và ba công cụ AI trong cùng một quy trình. AI không tự động thay người dùng quyết định mà chỉ tạo bản gợi ý để người dùng xem xét và chủ động lưu.

### Câu 6. Điểm mới của đề tài so với các trang tuyển dụng thông thường là gì?

Đề tài không tuyên bố tạo ra mô hình AI mới. Điểm khác biệt nằm ở cách tích hợp dữ liệu CV có cấu trúc với luồng ứng tuyển và trợ lý AI, giúp kết quả gợi ý có ngữ cảnh và có thể đưa trở lại biểu mẫu CV mà không tự ý ghi đè nội dung.

### Câu 7. Phạm vi của đề tài gồm những gì?

Phạm vi gồm quản lý tài khoản theo vai trò, tạo và xuất CV, tải CV PDF, đăng và tìm việc, ứng tuyển, theo dõi trạng thái hồ sơ, trò chuyện, thông báo, quản trị và ba chức năng AI. Đề tài chưa triển khai huấn luyện mô hình riêng, lưu trữ đối tượng quy mô lớn hay đánh giá chất lượng AI bằng bộ dữ liệu chuẩn.

### Câu 8. Đề tài có ý nghĩa thực tiễn gì?

Hệ thống giúp ứng viên giảm số công cụ phải sử dụng trong quá trình chuẩn bị và nộp hồ sơ, giúp doanh nghiệp tiếp nhận hồ sơ có tổ chức hơn, đồng thời cung cấp một môi trường thử nghiệm cách tích hợp AI có kiểm soát vào ứng dụng tuyển dụng.

### Câu 9. Sản phẩm cuối cùng của đề tài là gì?

Sản phẩm là một ứng dụng web toàn ngăn xếp gồm giao diện React, API Node.js/Express, cơ sở dữ liệu MongoDB, kênh trò chuyện Socket.IO và mô-đun AI gọi mô hình ngôn ngữ qua Groq. Sản phẩm kèm theo mã nguồn, báo cáo, sơ đồ thiết kế và bộ kiểm thử.

### Câu 10. Hệ thống đã hoàn thành đến mức nào?

Các luồng chính đã được triển khai và có thể minh họa: tài khoản, CV, tuyển dụng, ứng tuyển, trò chuyện, thông báo, quản trị và ba chức năng AI. Tuy nhiên hệ thống vẫn còn giới hạn về kiểm thử tích hợp thật, lưu trữ PDF, tính nhất quán phân quyền và đánh giá định lượng chất lượng AI.

### Câu 11. Bạn đã thực hiện những phần nào trong đề tài?

Tôi tham gia phân tích yêu cầu, thiết kế dữ liệu và luồng nghiệp vụ, phát triển giao diện và API, tích hợp AI, xây dựng kiểm thử và biên soạn báo cáo. Khi trả lời câu này, tôi sẽ nói rõ phần mình trực tiếp phụ trách nếu đề tài được thực hiện theo nhóm.

### Câu 12. Khó khăn lớn nhất khi thực hiện đề tài là gì?

Khó khăn lớn nhất là giữ dữ liệu nhất quán giữa nhiều luồng liên quan như CV, việc làm, hồ sơ ứng tuyển và trò chuyện, đồng thời phải kiểm soát đầu vào và đầu ra AI. Ngoài ra, phân quyền phải được kiểm tra ở máy chủ chứ không chỉ ẩn nút trên giao diện.

### Câu 13. Bạn giải quyết khó khăn đó như thế nào?

Tôi tách hệ thống thành các mô-đun nghiệp vụ, chuẩn hóa dữ liệu bằng schema, dùng chỉ mục cho các ràng buộc quan trọng, kiểm tra quyền tại API và bao bọc luồng AI bằng bộ làm sạch dữ liệu, giới hạn sử dụng, đầu ra có cấu trúc và bước xác nhận của người dùng.

### Câu 14. Nếu có thêm thời gian, bạn ưu tiên cải tiến gì?

Tôi ưu tiên ba việc: hoàn thiện kiểm tra quyền và quyền sở hữu ở mọi API; chuyển PDF sang kho lưu trữ đối tượng; và bổ sung kiểm thử tích hợp với máy chủ, cơ sở dữ liệu thật cùng bộ đánh giá chất lượng phản hồi AI.

### Câu 15. Vì sao đề tài phù hợp với một đồ án tốt nghiệp?

Đề tài bao quát đầy đủ quá trình xây dựng một hệ thống phần mềm: khảo sát bài toán, phân tích yêu cầu, thiết kế kiến trúc và dữ liệu, triển khai giao diện–máy chủ–thời gian thực–AI, kiểm thử và đánh giá hạn chế. Phạm vi đủ rộng nhưng vẫn có thể chia thành các chức năng có thể kiểm chứng.

---

## 2. Các câu hỏi dễ bắt lỗi từ chính báo cáo

### Câu 16. Báo cáo nói có năm luồng AI, nhưng hệ thống hiện có bao nhiêu?

Phiên bản hiện tại có ba chức năng AI chính: đánh giá CV, gợi ý điền CV và luyện phỏng vấn. Nội dung nói năm luồng là mô tả của kế hoạch hoặc phiên bản cũ và cần được chỉnh lại để thống nhất với mã nguồn hiện tại.

### Câu 17. Vì sao có đoạn ghi 41 kiểm thử, đoạn khác lại ghi 43?

Đó là sai lệch do báo cáo chưa cập nhật đồng bộ sau khi bổ sung kiểm thử. Số liệu đúng của mã nguồn hiện tại là 13 tệp kiểm thử phía máy chủ với 43 trường hợp, tất cả đều đạt tại thời điểm đánh giá.

### Câu 18. Tại sao bảng kiểm thử chỉ liệt kê 12 tệp nhưng phần khác ghi 13 tệp?

Bảng đó đang thiếu một tệp kiểm thử mới được bổ sung sau phiên bản ban đầu. Tôi cần cập nhật lại bảng, tổng số và phần kết luận cùng lúc; khi bảo vệ tôi sử dụng số liệu thực tế đã chạy là 13 tệp và 43 trường hợp.

### Câu 19. Báo cáo nói thông báo dùng Socket.IO có chính xác không?

Không hoàn toàn chính xác. Socket.IO hiện phục vụ tin nhắn trò chuyện, còn thông báo được lấy bằng REST và TanStack Query; số chưa đọc được làm mới định kỳ. Vì vậy câu đúng là hệ thống dùng Socket.IO cho chat và cơ chế truy vấn định kỳ cho thông báo.

### Câu 20. Báo cáo nói kết quả phỏng vấn được lưu vào lịch sử có đúng không?

Ở phiên bản hiện tại, kết quả và lịch sử chỉ được giữ trong trạng thái của phiên giao diện. Khi tải lại trang hoặc đóng phiên, dữ liệu đó mất; vì vậy mô tả “lưu vào lịch sử lâu dài” là chưa đúng và cần sửa thành “hiển thị trong phiên luyện tập hiện tại”.

### Câu 21. Vì sao Chương 4 dùng khái niệm bảng, khóa chính và khóa ngoại trong khi hệ thống dùng MongoDB?

Đó là cách biểu diễn quan hệ ở mức khái niệm để người đọc dễ hiểu, nhưng thuật ngữ chưa thật phù hợp với MongoDB. Cách chính xác hơn là mô tả collection, document, trường `_id`, tham chiếu và embedded document, sau đó giải thích các ràng buộc được thực hiện bằng schema và index.

### Câu 22. Tại sao phần PDF.js và react-to-print lại nằm trong mục phát triển cơ sở dữ liệu?

Đó là lỗi tổ chức nội dung. Hai công nghệ này thuộc nhóm xử lý, hiển thị và xuất tài liệu PDF, không thuộc cơ sở dữ liệu; nên tách thành một mục riêng về tạo, xem và xử lý PDF.

### Câu 23. Vì sao Chương 2 và Chương 3 có nội dung công nghệ bị trùng nhau?

Chương 2 nên tập trung vào cơ sở lý thuyết như client–server, phân quyền, trạng thái máy chủ và giao tiếp thời gian thực. Chương 3 mới giới thiệu công nghệ cụ thể. Phần trùng là do phiên bản báo cáo cũ chưa tách rõ “khái niệm” và “công cụ triển khai”, và cần biên tập lại.

### Câu 24. Hệ thống có thực sự dùng ChatGPT không hay dùng Groq?

Hệ thống không gọi dịch vụ ChatGPT. Nó gọi API của Groq để chạy mô hình `openai/gpt-oss-120b`; tên bắt đầu bằng `openai/` là định danh mô hình và mã nguồn dùng thư viện OpenAI tương thích, không có nghĩa yêu cầu được gửi đến ChatGPT.

### Câu 25. Các chức năng quản trị trong sơ đồ có đều được triển khai không?

Không nên khẳng định tất cả nếu chưa có mã và giao diện tương ứng. Các chức năng đã hiện thực phải được trình bày là kết quả; những mục như giám sát sức khỏe hệ thống, nhật ký chuyên sâu hoặc quy trình xác minh nếu chưa hoàn chỉnh phải được ghi là định hướng, không phải chức năng đã hoàn thành.

### Câu 26. Chức năng quên mật khẩu qua email có hoạt động đúng như báo cáo không?

Cần đối chiếu mã nguồn trước khi khẳng định. Nếu hệ thống chưa có dịch vụ gửi thư và luồng đặt lại mật khẩu hoàn chỉnh thì báo cáo chỉ nên mô tả đây là yêu cầu hoặc hướng phát triển, không trình bày như chức năng đã kiểm chứng.

### Câu 27. Các yêu cầu phi chức năng trong báo cáo có mục nào thực chất là yêu cầu chức năng không?

Có thể có. Ví dụ “hỗ trợ tải CV” là chức năng, còn thời gian phản hồi, bảo mật, khả dụng, khả năng bảo trì và tương thích màn hình mới là phi chức năng. Tôi cần phân loại lại theo việc yêu cầu mô tả hệ thống “làm gì” hay “hoạt động tốt đến mức nào”.

---

## 3. Kiến trúc và công nghệ

### Câu 28. Kiến trúc client–server là gì và được áp dụng thế nào?

Client là giao diện chạy trong trình duyệt, chịu trách nhiệm hiển thị và gửi yêu cầu. Server tiếp nhận API, kiểm tra quyền, xử lý nghiệp vụ và truy cập dữ liệu. RabbitCV dùng React ở client, Node.js/Express ở server và trao đổi chủ yếu bằng JSON qua HTTP.

### Câu 29. Vì sao chọn kiến trúc client–server?

Kiến trúc này tách phần trình bày khỏi xử lý nghiệp vụ và dữ liệu, giúp dễ phát triển, kiểm thử và thay đổi từng phần. Nó cũng cho phép nhiều loại client dùng chung API trong tương lai, chẳng hạn ứng dụng web và ứng dụng di động.

### Câu 30. RabbitCV là monolith hay microservices?

RabbitCV là monolith theo mô-đun: các chức năng nằm trong một ứng dụng máy chủ có thể triển khai chung, nhưng mã được chia theo route, controller, service, model và miền nghiệp vụ. Cách này phù hợp quy mô đồ án và giảm chi phí vận hành so với microservices.

### Câu 31. Vì sao không chọn microservices?

Microservices làm tăng độ phức tạp triển khai, giao tiếp liên dịch vụ, quan sát hệ thống và tính nhất quán dữ liệu. Với quy mô người dùng và nhóm phát triển của đồ án, modular monolith đáp ứng tốt hơn; khi tải tăng có thể tách AI, tệp hoặc thời gian thực thành dịch vụ riêng.

### Câu 32. MERN Stack là gì?

MERN gồm MongoDB, Express, React và Node.js. MongoDB lưu dữ liệu, Express xây dựng API, React phát triển giao diện và Node.js cung cấp môi trường JavaScript phía máy chủ.

### Câu 33. Vì sao chọn MERN Stack?

MERN cho phép dùng JavaScript xuyên suốt, dữ liệu trao đổi tự nhiên dưới dạng JSON và hệ sinh thái thư viện phong phú. MongoDB cũng phù hợp với cấu trúc CV có nhiều mảng và trường lồng nhau, trong khi React hỗ trợ xây dựng giao diện biểu mẫu theo thành phần.

### Câu 34. Hạn chế của MERN Stack trong đề tài này là gì?

MongoDB không tự mang lại ràng buộc quan hệ chặt như cơ sở dữ liệu quan hệ, còn Node.js không phù hợp với tác vụ CPU nặng nếu xử lý trực tiếp trong luồng sự kiện. Hệ thống phải chủ động thiết kế schema, index, kiểm tra nghiệp vụ và tách các tác vụ nặng khi mở rộng.

### Câu 35. React được dùng để làm gì?

React dùng để xây dựng giao diện theo component, quản lý trạng thái tương tác và cập nhật phần cần thiết khi dữ liệu thay đổi. Trong RabbitCV, nó phù hợp với các màn hình có nhiều biểu mẫu và thành phần tái sử dụng như CV, hồ sơ ứng tuyển và bảng điều khiển.

### Câu 36. Luồng dữ liệu một chiều của React có lợi ích gì?

Dữ liệu thường được truyền từ component cha xuống component con qua props, còn sự kiện được gửi ngược lên bằng hàm callback. Luồng này giúp nguồn thay đổi dữ liệu rõ ràng, giảm trạng thái khó theo dõi và làm giao diện dễ kiểm tra hơn.

### Câu 37. “Tạo biểu diễn mới của giao diện” trong React nghĩa là gì?

Khi state hoặc props thay đổi, React tính lại cây phần tử mô tả giao diện mong muốn. Sau đó React so sánh với kết quả trước và chỉ cập nhật các nút DOM thực sự cần thay đổi, chứ không tải lại toàn bộ trang.

### Câu 38. Hook trong React là gì?

Hook là các hàm cho phép component hàm sử dụng trạng thái, vòng đời và các khả năng tái sử dụng logic. Ví dụ `useState` giữ trạng thái cục bộ, `useEffect` xử lý tác động phụ và custom hook đóng gói logic dùng chung.

### Câu 39. Lazy loading được dùng để làm gì?

Lazy loading chia mã theo tuyến hoặc thành phần và chỉ tải phần cần thiết khi người dùng truy cập. Nhờ đó gói JavaScript ban đầu nhỏ hơn, thời gian mở trang đầu nhanh hơn và các màn hình như dashboard không cần tải trước khi chưa được sử dụng.

### Câu 40. Nếu người dùng chỉ vào một đường dẫn thì bình thường trình duyệt có tải tất cả màn hình không?

Nếu ứng dụng được đóng thành một gói lớn, trình duyệt có thể tải mã của nhiều màn hình ngay từ lần đầu dù chưa hiển thị chúng. Lazy loading tạo các gói tách biệt để chỉ tải mã của màn hình khi tuyến tương ứng được truy cập.

### Câu 41. TanStack Query được dùng để làm gì?

TanStack Query quản lý trạng thái dữ liệu lấy từ máy chủ: bộ nhớ đệm, trạng thái tải và lỗi, làm mới dữ liệu, đồng bộ lại và vô hiệu hóa cache sau khi cập nhật. Nó không thay thế giao thức HTTP mà điều phối vòng đời dữ liệu quanh các hàm gọi API.

### Câu 42. TanStack Query khác `fetch` hoặc Axios như thế nào?

`fetch` và Axios là công cụ gửi yêu cầu HTTP và đọc phản hồi. TanStack Query nhận một hàm gọi HTTP rồi quản lý kết quả theo khóa truy vấn, cache, retry, refetch và invalidation; vì vậy hai nhóm này bổ sung cho nhau chứ không phải lựa chọn loại trừ.

### Câu 43. Dự án dùng TanStack Query thì có còn dùng `fetch` không?

Có. TanStack Query vẫn cần một hàm thực hiện yêu cầu mạng; dự án có thể dùng `fetch` bên trong `queryFn` hoặc `mutationFn`. TanStack Query quản lý dữ liệu sau và trong quá trình gọi, còn `fetch` trực tiếp gửi yêu cầu HTTP.

### Câu 44. Tại sao không chỉ dùng `fetch` mà cần TanStack Query?

Chỉ dùng `fetch`, lập trình viên phải tự viết trạng thái tải, lỗi, cache, chống gọi trùng, làm mới và đồng bộ dữ liệu sau cập nhật. TanStack Query chuẩn hóa các việc đó, giúp giảm mã thủ công và hạn chế nhiều màn hình giữ các bản dữ liệu không đồng nhất.

### Câu 45. React Context và TanStack Query khác nhau thế nào?

React Context phù hợp với trạng thái dùng chung do ứng dụng kiểm soát, như phiên đăng nhập, chủ đề hoặc kết nối socket. TanStack Query chuyên quản lý trạng thái máy chủ có tính bất đồng bộ, có cache và cần làm mới; hai công cụ có thể dùng cùng nhau.

### Câu 46. Dự án có dùng Redux không? Vì sao?

Dự án không dùng Redux. Phần lớn trạng thái máy chủ đã được TanStack Query quản lý, còn trạng thái dùng chung đơn giản có thể dùng Context và state cục bộ, nên thêm Redux sẽ làm tăng mã và độ phức tạp mà chưa tạo lợi ích rõ ràng ở quy mô hiện tại.

### Câu 47. Redux có thể thay thế TanStack Query không?

Redux có thể tự xây dựng logic quản lý dữ liệu máy chủ hoặc dùng thêm Redux Toolkit Query, nhưng Redux cơ bản không tự có cache, retry và refetch chuyên biệt như TanStack Query. Việc thay thế là có thể về kỹ thuật nhưng cần thêm nhiều cấu hình và không cần thiết cho dự án này.

---

## 4. Cơ sở dữ liệu

### Câu 48. Vì sao chọn MongoDB thay vì cơ sở dữ liệu quan hệ?

CV có nhiều nhóm dữ liệu lồng nhau và số lượng phần tử thay đổi, như kinh nghiệm, học vấn, kỹ năng và dự án. Mô hình document của MongoDB biểu diễn cấu trúc này tự nhiên, dễ trao đổi dưới dạng JSON và phù hợp với Node.js; đổi lại hệ thống phải chủ động quản lý các quan hệ và ràng buộc.

### Câu 49. MongoDB lưu dữ liệu theo cách nào?

MongoDB tổ chức dữ liệu thành collection và document BSON. Mỗi document có `_id` và có thể chứa object, mảng hoặc document lồng nhau; các document không bắt buộc hoàn toàn giống nhau nhưng ứng dụng dùng Mongoose schema để kiểm soát cấu trúc.

### Câu 50. Mongoose có vai trò gì?

Mongoose là lớp mô hình hóa dữ liệu giữa ứng dụng Node.js và MongoDB. Nó cho phép định nghĩa schema, kiểu dữ liệu, giá trị mặc định, validation, middleware, index và các phương thức truy vấn nhất quán.

### Câu 51. Vì sao kết hợp MongoDB với Mongoose?

MongoDB mang lại mô hình document linh hoạt, còn Mongoose bổ sung kỷ luật ở tầng ứng dụng. Sự kết hợp giúp CV vẫn biểu diễn được dữ liệu lồng nhau nhưng giảm nguy cơ lưu sai kiểu, thiếu trường quan trọng hoặc truy vấn không thống nhất.

### Câu 52. Dữ liệu nào nên nhúng và dữ liệu nào nên tham chiếu?

Dữ liệu chỉ thuộc một CV và thường đọc cùng CV, như học vấn hoặc kỹ năng, phù hợp để nhúng. Các thực thể có vòng đời riêng hoặc được nhiều nơi sử dụng, như người dùng, việc làm và hồ sơ ứng tuyển, nên được tách collection và tham chiếu bằng ID.

### Câu 53. Tại sao không nhúng toàn bộ dữ liệu vào một document?

Nhúng toàn bộ sẽ tạo document lớn, lặp dữ liệu và khó cập nhật khi một thực thể dùng chung thay đổi. MongoDB còn có giới hạn kích thước document, nên chỉ nhúng những dữ liệu có quan hệ sở hữu chặt và kích thước được kiểm soát.

### Câu 54. `isVirtual` trong CV có ý nghĩa gì?

Thuộc tính này phân biệt CV có cấu trúc được tạo trong hệ thống với CV PDF được tải từ thiết bị. Nhờ đó máy chủ và giao diện biết loại dữ liệu nào có thể chỉnh sửa theo trường, loại nào chỉ là tệp dùng để xem hoặc ứng tuyển.

### Câu 55. Tại sao gọi là `isVirtual`, tên này có dễ hiểu không?

Tên này hoạt động về kỹ thuật nhưng chưa diễn đạt rõ mục đích nghiệp vụ. Tên như `resumeType`, `sourceType` hoặc `isUploadedPdf` sẽ dễ hiểu hơn; đây là điểm có thể cải tiến để mã nguồn tự mô tả tốt hơn.

### Câu 56. Vì sao loại dữ liệu PDF khỏi truy vấn danh sách CV?

Danh sách chỉ cần metadata như tên, loại và thời gian cập nhật. Dữ liệu PDF dạng Base64 rất lớn; nếu trả nó cho mọi phần tử thì phản hồi nặng, tốn bộ nhớ và băng thông, vì vậy chỉ lấy PDF khi người dùng mở hoặc sử dụng đúng CV đó.

### Câu 57. Lưu PDF dạng Base64 có ưu điểm gì?

Cách này đơn giản cho nguyên mẫu vì tệp đi cùng document và không cần cấu hình kho tệp riêng. Việc sao lưu và kiểm soát quyền cũng tập trung qua API hiện có.

### Câu 58. Lưu PDF dạng Base64 có nhược điểm gì?

Base64 làm kích thước tăng khoảng một phần ba, khiến truy vấn và sao lưu nặng hơn, đồng thời bị giới hạn bởi kích thước document MongoDB. Khi mở rộng, nên lưu tệp ở object storage hoặc GridFS và chỉ lưu URL cùng metadata trong MongoDB.

### Câu 59. `jobSnapshot` dùng để làm gì?

`jobSnapshot` lưu lại các thông tin cần thiết của công việc tại thời điểm ứng tuyển, như tiêu đề hoặc doanh nghiệp. Nhờ đó lịch sử ứng tuyển vẫn có ngữ cảnh khi tin gốc bị chỉnh sửa hoặc xóa.

### Câu 60. Lưu snapshot có gây trùng dữ liệu không?

Có, nhưng đây là sự dư thừa có chủ đích để bảo toàn lịch sử. Snapshot chỉ nên giữ các trường cần hiển thị và được xem là dữ liệu tại thời điểm xảy ra sự kiện, không phải bản thay thế tin tuyển dụng hiện tại.

### Câu 61. Làm thế nào ngăn một ứng viên ứng tuyển cùng công việc hai lần?

Ứng dụng có thể kiểm tra trước khi tạo, nhưng biện pháp quyết định là unique compound index trên `candidateId` và `jobId`. Chỉ mục này ngăn trùng ngay tại cơ sở dữ liệu, kể cả khi hai yêu cầu đến gần như đồng thời.

### Câu 62. Vì sao kiểm tra bằng mã nguồn thôi là chưa đủ?

Hai yêu cầu song song có thể cùng vượt qua bước “chưa tồn tại” trước khi cả hai cùng ghi dữ liệu, tạo race condition. Unique index khiến một thao tác bị từ chối ở tầng dữ liệu nên ràng buộc vẫn đúng trong tình huống cạnh tranh.

### Câu 63. Hệ thống quản lý tính nhất quán giữa Job và Application thế nào?

Application giữ tham chiếu đến Job để lấy dữ liệu hiện hành và đồng thời giữ snapshot cho lịch sử. Các thao tác thay đổi trạng thái phải đi qua API có kiểm tra vai trò và quyền sở hữu; những cập nhật liên quan nhiều document cần được thiết kế cẩn thận hoặc dùng transaction khi thật sự cần.

### Câu 64. MongoDB có hỗ trợ transaction không?

Có, MongoDB hỗ trợ transaction nhiều document khi chạy trong replica set hoặc môi trường phù hợp. Tuy nhiên không nên lạm dụng; trước hết nên thiết kế document sao cho thao tác quan trọng có thể hoàn thành nguyên tử trong một document.

### Câu 65. Hệ thống dùng index nào ngoài unique index ứng tuyển?

Các trường được lọc hoặc sắp xếp thường xuyên như người sở hữu, trạng thái, thời gian tạo và tham chiếu công việc là ứng viên phù hợp cho index. Cần kiểm tra truy vấn thực tế bằng `explain` vì index cải thiện đọc nhưng làm tăng chi phí ghi và dung lượng.

### Câu 66. Nếu xóa người dùng thì dữ liệu liên quan xử lý thế nào?

Phiên bản hoàn chỉnh cần xác định chính sách rõ: xóa mềm tài khoản, ẩn dữ liệu cá nhân và giữ các bản ghi cần cho lịch sử; hoặc chạy quy trình xóa liên quan có kiểm soát. Không nên xóa dây chuyền tùy tiện vì có thể làm mất ngữ cảnh ứng tuyển và tin nhắn.

### Câu 67. Làm thế nào sao lưu và phục hồi dữ liệu?

Ở môi trường triển khai thực tế nên dùng cơ chế backup định kỳ của MongoDB/nhà cung cấp, mã hóa bản sao lưu và thử phục hồi. Đồ án hiện tập trung ở mức ứng dụng; kế hoạch vận hành đầy đủ cần bổ sung mục tiêu RPO, RTO và quy trình kiểm tra backup.

---

## 5. Xác thực, phân quyền và bảo mật

### Câu 68. Xác thực là gì?

Xác thực là quá trình kiểm tra người dùng có đúng là chủ thể họ khai báo hay không, thường qua email/tên đăng nhập và mật khẩu. Sau khi thành công, hệ thống tạo phiên hoặc token để nhận diện các yêu cầu tiếp theo.

### Câu 69. Phân quyền khác xác thực như thế nào?

Xác thực trả lời “người này là ai”, còn phân quyền trả lời “người này được làm gì trên tài nguyên nào”. Người dùng đăng nhập thành công vẫn có thể bị từ chối nếu vai trò hoặc quyền sở hữu không phù hợp.

### Câu 70. RBAC là gì?

RBAC là cơ chế gán quyền thông qua vai trò. RabbitCV có các vai trò ứng viên, doanh nghiệp và quản trị viên; middleware ở máy chủ đọc vai trò từ phiên đã xác thực để quyết định một API có được phép thực hiện hay không.

### Câu 71. RabbitCV áp dụng RBAC như thế nào?

Sau khi xác thực JWT, máy chủ xác định ID và vai trò người dùng. Mỗi nhóm route giới hạn vai trò phù hợp, sau đó nghiệp vụ tiếp tục kiểm tra quyền sở hữu, ví dụ doanh nghiệp chỉ sửa tin do mình quản lý và ứng viên chỉ sửa CV của mình.

### Câu 72. Chỉ kiểm tra vai trò đã đủ chưa?

Chưa. Hai người cùng vai trò ứng viên không được sửa CV của nhau; vì vậy ngoài RBAC còn cần kiểm soát ở mức tài nguyên, thường gọi là kiểm tra quyền sở hữu hoặc authorization dựa trên thuộc tính.

### Câu 73. Tại sao bảo vệ tuyến ở React không đủ an toàn?

Mã giao diện chạy trên thiết bị người dùng và có thể bị bỏ qua bằng cách gọi API trực tiếp. Route guard chỉ cải thiện trải nghiệm; ranh giới bảo mật thật phải nằm ở máy chủ với xác thực, kiểm tra vai trò và kiểm tra tài nguyên.

### Câu 74. JWT là gì?

JWT là token có chữ ký chứa một số claim như ID, vai trò và thời hạn. Máy chủ xác minh chữ ký để phát hiện token bị sửa; nội dung JWT thường chỉ được mã hóa Base64URL chứ không được giữ bí mật, nên không nên đặt dữ liệu nhạy cảm trong đó.

### Câu 75. Vì sao dùng JWT trong cookie HTTP-only?

Cookie HTTP-only không cho JavaScript phía trình duyệt đọc token, giúp giảm nguy cơ token bị đánh cắp trực tiếp khi có XSS. Tuy nhiên vẫn phải cấu hình `Secure`, `SameSite`, CORS và chiến lược chống CSRF phù hợp.

### Câu 76. JWT lưu trong cookie khác gì localStorage?

Token trong localStorage dễ được truy cập bằng JavaScript nếu xảy ra XSS. Cookie HTTP-only hạn chế rủi ro đó nhưng trình duyệt tự gửi cookie nên phải chú ý CSRF; không có lựa chọn nào tự động an toàn nếu cấu hình thiếu.

### Câu 77. Mật khẩu được bảo vệ như thế nào?

Mật khẩu phải được băm bằng thuật toán chuyên dụng kèm salt trước khi lưu, không mã hóa có thể giải ngược và không ghi vào log. Khi đăng nhập, hệ thống so sánh mật khẩu nhập vào với giá trị băm thay vì giải mã mật khẩu cũ.

### Câu 78. CORS dùng để làm gì?

CORS quy định nguồn trình duyệt nào được phép gọi API và có được gửi thông tin xác thực hay không. Nó là chính sách của trình duyệt, không thay thế xác thực hay phân quyền ở máy chủ.

### Câu 79. Helmet dùng để làm gì?

Helmet thiết lập một số HTTP header bảo mật giúp giảm các rủi ro phổ biến như nhúng trang trái phép hoặc suy đoán loại nội dung. Đây là lớp gia cố cấu hình, không thay thế việc xử lý XSS, injection và kiểm soát quyền.

### Câu 80. Cookie parser dùng để làm gì?

Cookie parser đọc header cookie và chuyển thành cấu trúc dễ truy cập trong request. Nhờ đó middleware xác thực có thể lấy JWT từ cookie; bản thân nó không xác minh token và không tạo thêm bảo mật.

### Câu 81. Giới hạn tốc độ có tác dụng gì?

Rate limiting giới hạn số yêu cầu theo IP, người dùng hoặc tuyến trong một khoảng thời gian. Nó giảm brute force, spam và lạm dụng API, đặc biệt ở đăng nhập và AI, nhưng không thay thế giám sát và chống tấn công phân tán.

### Câu 82. Chuỗi middleware trong Express dùng để làm gì?

Mỗi middleware xử lý một trách nhiệm theo thứ tự, chẳng hạn đọc cookie, xác thực JWT, kiểm tra vai trò, validate dữ liệu rồi mới chạy controller. Cách này giúp tái sử dụng chính sách và ngăn nghiệp vụ chạy khi yêu cầu chưa hợp lệ.

### Câu 83. Zod hỗ trợ bảo mật như thế nào?

Zod kiểm tra kiểu, cấu trúc, độ dài và giá trị cho phép trước khi dữ liệu đi sâu vào ứng dụng. Nó giảm đầu vào sai và bất ngờ, nhưng không tự làm sạch HTML, chống mọi loại injection hay kiểm tra quyền; các lớp đó vẫn phải xử lý riêng.

### Câu 84. Hệ thống chống người dùng sửa ID để truy cập dữ liệu người khác thế nào?

Máy chủ không tin ID từ client là đủ. Sau khi xác thực, truy vấn phải gắn thêm điều kiện người sở hữu hoặc kiểm tra mối quan hệ với tài nguyên; nếu không phù hợp thì trả về lỗi 403 hoặc 404 tùy chính sách.

### Câu 85. Dữ liệu PDF tải lên được kiểm tra thế nào?

Hệ thống cần kiểm tra kích thước, MIME type, chữ ký tệp và chỉ xử lý theo mục đích hiển thị/tải về. Các kiểm tra này giảm rủi ro nhưng không tương đương quét mã độc hoặc sandbox; môi trường thực tế nên bổ sung kho cách ly và malware scanning.

### Câu 86. Hệ thống có chống CSRF không?

Cookie JWT khiến CSRF là vấn đề cần xem xét. Cấu hình `SameSite`, giới hạn CORS và kiểm tra nguồn giúp giảm rủi ro; với thao tác nhạy cảm nên bổ sung CSRF token hoặc cơ chế xác minh tương đương và không dùng phương thức GET để thay đổi dữ liệu.

### Câu 87. Điểm yếu bảo mật còn lại của hệ thống là gì?

Điểm cần ưu tiên là bảo đảm mọi API đều kiểm tra quyền nhất quán, tăng kiểm thử truy cập chéo vai trò, hoàn thiện bảo vệ tệp tải lên và quản lý bí mật triển khai. Báo cáo cũng thừa nhận chưa có kiểm thử xâm nhập và kiểm thử bảo mật chuyên sâu.

---

## 6. Trí tuệ nhân tạo

### Câu 88. AI trong RabbitCV giải quyết những chức năng nào?

AI hỗ trợ ba chức năng: đánh giá nội dung CV có cấu trúc, đề xuất nội dung cho các phần còn thiếu và mô phỏng phỏng vấn theo vị trí, cấp độ cùng loại câu hỏi. Kết quả có tính tham khảo và người dùng là người quyết định có áp dụng hay không.

### Câu 89. Hệ thống có tự huấn luyện mô hình AI không?

Không. Hệ thống sử dụng mô hình ngôn ngữ đã được huấn luyện sẵn thông qua API của Groq. Phần đóng góp của đồ án là thiết kế đầu vào, kiểm soát dữ liệu, yêu cầu đầu ra có cấu trúc và tích hợp kết quả vào nghiệp vụ.

### Câu 90. Groq là gì trong hệ thống?

Groq là nhà cung cấp hạ tầng/API suy luận mô hình. Máy chủ RabbitCV gửi yêu cầu đến endpoint tương thích OpenAI của Groq và nhận phản hồi của mô hình; Groq không phải tên của chức năng AI trong ứng dụng.

### Câu 91. `openai/gpt-oss-120b` là gì?

Đó là định danh mô hình mặc định được cấu hình trên Groq. Tiền tố `openai/` chỉ nguồn hoặc namespace của mô hình; nó không đồng nghĩa với việc ứng dụng gọi sản phẩm ChatGPT.

### Câu 92. Tại sao mã nguồn dùng thư viện OpenAI nhưng lại gọi Groq?

Groq cung cấp API tương thích với giao diện OpenAI. Vì vậy có thể dùng OpenAI SDK làm trình khách nhưng thay `baseURL` và API key để yêu cầu được gửi đến Groq; thư viện và nhà cung cấp dịch vụ là hai khái niệm khác nhau.

### Câu 93. Tại sao chọn mô hình này?

Mô hình có khả năng xử lý và sinh văn bản đủ cho đánh giá CV và phỏng vấn, đồng thời có thể truy cập qua API tương thích. Việc lựa chọn còn dựa trên khả năng tích hợp, tốc độ và giới hạn sử dụng; đề tài chưa thực hiện benchmark đầy đủ giữa nhiều mô hình nên không khẳng định đây là mô hình tốt nhất.

### Câu 94. Dữ liệu nào được gửi đến AI khi đánh giá CV?

Máy chủ xây dựng phiên bản CV đã được làm sạch và giới hạn. Các thông tin nhận dạng trực tiếp như họ tên, email, số điện thoại và địa chỉ không cần thiết được loại bỏ hoặc chỉ chuyển thành cờ mức độ đầy đủ, còn nội dung nghề nghiệp cần đánh giá mới được gửi.

### Câu 95. Vì sao phải loại thông tin cá nhân trước khi gửi AI?

Nguyên tắc là tối thiểu hóa dữ liệu: chỉ gửi thông tin cần cho mục đích đánh giá. Điều này giảm rủi ro lộ dữ liệu, hạn chế việc mô hình dựa vào đặc điểm nhận dạng không liên quan và giúp luồng xử lý minh bạch hơn.

### Câu 96. Sanitizer trong mô-đun AI làm gì?

Sanitizer loại hoặc trung hòa HTML, script, style và chuỗi có dấu hiệu thực thi; đồng thời giới hạn độ dài văn bản, số phần tử trong danh sách và dữ liệu nhạy cảm. Mục tiêu là giảm dữ liệu dư thừa, prompt injection và phản hồi vượt kiểm soát.

### Câu 97. Sanitizer có ngăn được hoàn toàn prompt injection không?

Không. Sanitizer chỉ giảm bề mặt tấn công. Hệ thống còn phải tách rõ chỉ dẫn hệ thống và dữ liệu người dùng, dùng schema đầu ra, không cho mô hình trực tiếp thực hiện hành động đặc quyền và luôn xác minh kết quả ở máy chủ.

### Câu 98. JSON Schema được dùng để làm gì?

JSON Schema yêu cầu mô hình trả về đúng cấu trúc và kiểu dữ liệu mà ứng dụng mong đợi, ví dụ điểm số, danh sách ưu điểm và đề xuất. Nó giúp parser ổn định hơn nhưng không bảo đảm nội dung bên trong đúng về mặt chuyên môn.

### Câu 99. Nếu mô hình trả sai cấu trúc thì hệ thống xử lý ra sao?

Máy chủ phải coi phản hồi AI là dữ liệu không tin cậy: parse có kiểm soát, validate lại, đặt giá trị mặc định hoặc báo lỗi chuẩn hóa. Không nên truyền nguyên phản hồi lỗi xuống giao diện hoặc tự động ghi vào cơ sở dữ liệu.

### Câu 100. Hệ thống giảm hiện tượng AI bịa thông tin như thế nào?

Hệ thống giới hạn ngữ cảnh vào dữ liệu do người dùng cung cấp, yêu cầu kết quả theo schema, làm sạch và giới hạn giá trị, đồng thời chỉ hiển thị dưới dạng gợi ý. Người dùng phải xem lại và chủ động lưu; cách này giảm tác hại nhưng không thể loại bỏ hoàn toàn hallucination.

### Câu 101. Tại sao không cho AI tự lưu nội dung vào CV?

AI có thể hiểu sai hoặc tạo thông tin không có thật. Giữ kết quả trong biểu mẫu như bản nháp và yêu cầu người dùng xác nhận giúp duy trì quyền kiểm soát, tránh CV bị thay đổi âm thầm và phù hợp nguyên tắc con người quyết định cuối cùng.

### Câu 102. Chức năng tự động điền CV hoạt động thế nào?

Máy chủ nhận CV có cấu trúc đã làm sạch, xác định các phần thiếu và yêu cầu mô hình đề xuất nội dung phù hợp với dữ liệu hiện có. Giao diện chỉ điền phần còn thiếu hoặc đưa ra gợi ý, không ghi đè dữ liệu đã nhập và chưa lưu cho đến khi người dùng xác nhận.

### Câu 103. AI có thể tạo ra kinh nghiệm hoặc kỹ năng không có thật không?

Có rủi ro đó nếu prompt hoặc dữ liệu không đủ rõ. Vì vậy hệ thống nên yêu cầu mô hình không bịa thành tích, dùng placeholder hoặc câu hỏi gợi mở khi thiếu căn cứ, và luôn yêu cầu người dùng xác nhận tính chính xác trước khi lưu.

### Câu 104. Chức năng đánh giá CV dựa trên tiêu chí nào?

Phản hồi tập trung vào độ rõ ràng, đầy đủ, cụ thể, tính thuyết phục, cách diễn đạt và khả năng thể hiện bằng chứng hoặc kết quả. Đây là đánh giá hỗ trợ của mô hình, chưa phải thang đo tuyển dụng đã được kiểm định khoa học.

### Câu 105. Điểm đánh giá CV có đáng tin tuyệt đối không?

Không. Điểm là tín hiệu tham khảo phụ thuộc vào mô hình, prompt và dữ liệu đầu vào; đề tài chưa hiệu chuẩn điểm bằng chuyên gia tuyển dụng hoặc bộ dữ liệu chuẩn. Vì vậy không nên dùng điểm để tự động loại ứng viên.

### Câu 106. AI có đánh giá CV PDF tải lên không?

Hiện tại AI đánh giá CV có cấu trúc do hệ thống quản lý, không trực tiếp phân tích nội dung CV PDF tải lên. Muốn hỗ trợ PDF cần thêm bước trích xuất văn bản, nhận dạng cấu trúc và kiểm tra chất lượng trước khi gửi AI.

### Câu 107. Vì sao chưa xử lý AI trực tiếp trên CV PDF?

PDF có bố cục phức tạp, nhiều cột, hình ảnh hoặc font nhúng nên trích xuất văn bản không luôn chính xác. Đưa dữ liệu lỗi vào AI có thể tạo đánh giá sai; phạm vi hiện tại ưu tiên CV có cấu trúc để kiểm soát đầu vào tốt hơn.

### Câu 108. Luyện phỏng vấn nhận những tham số nào?

Người dùng chọn vị trí mục tiêu, cấp độ, loại phỏng vấn và số câu hỏi. Hệ thống hỗ trợ các cấp độ intern, junior, middle, senior; loại câu hỏi tổng hợp, chung, hành vi hoặc kỹ thuật; số lượng 5, 8 hoặc 12 câu.

### Câu 109. Luồng luyện phỏng vấn diễn ra thế nào?

Máy chủ tạo câu hỏi theo cấu hình, người dùng trả lời từng câu, mô hình trả về điểm và nhận xét gồm điểm mạnh cùng phần cần cải thiện. Khi kết thúc, hệ thống tổng hợp điểm, ưu điểm, hạn chế và khuyến nghị cho phiên đó.

### Câu 110. Vì sao giới hạn số câu hỏi ở 5, 8 hoặc 12?

Giới hạn giúp thời lượng phiên hợp lý, kiểm soát số lần gọi API và tránh ngữ cảnh hội thoại tăng quá lớn. Ba mức cũng cho phép người dùng chọn luyện nhanh, tiêu chuẩn hoặc dài hơn.

### Câu 111. Vì sao lịch sử hội thoại bị giới hạn khoảng 26 tin nhắn?

Giới hạn ngăn prompt tăng vô hạn, giảm chi phí, độ trễ và nguy cơ vượt cửa sổ ngữ cảnh. Con số này đủ để chứa luồng hỏi–đáp của tối đa 12 câu cùng một số thông tin điều khiển.

### Câu 112. Kết quả phỏng vấn được lưu ở đâu?

Hiện kết quả được giữ trong state của giao diện trong phiên đang mở. Nó chưa được ghi thành lịch sử lâu dài trong cơ sở dữ liệu, vì vậy tải lại trang sẽ mất dữ liệu; đây là một hạn chế đã xác định.

### Câu 113. Tại sao chưa lưu lịch sử phỏng vấn?

Phiên bản hiện tại ưu tiên hoàn thiện luồng tương tác và phản hồi AI. Lưu lâu dài đòi hỏi thiết kế collection, chính sách riêng tư, xóa dữ liệu và giao diện quản lý lịch sử; đây là phần mở rộng hợp lý cho phiên bản sau.

### Câu 114. Làm sao AI nhớ được các câu trả lời trước?

Ứng dụng gửi một phần lịch sử hội thoại của phiên hiện tại trong mỗi yêu cầu, thay vì giả định mô hình tự nhớ. Lịch sử được cắt theo giới hạn để giữ ngữ cảnh cần thiết mà không làm prompt quá lớn.

### Câu 115. Hệ thống giới hạn sử dụng AI như thế nào?

Mặc định mỗi người dùng có hạn mức theo ngày, hiện được cấu hình khoảng 100 yêu cầu, kết hợp rate limit ngắn hạn và timeout. Mục tiêu là kiểm soát chi phí, chống spam và tránh một người dùng chiếm toàn bộ tài nguyên.

### Câu 116. Nếu người dùng vượt hạn mức AI thì sao?

Máy chủ từ chối yêu cầu với mã lỗi và thông báo rõ thời điểm hoặc điều kiện có thể dùng lại. Giao diện cần giữ nguyên nội dung người dùng đang nhập để họ không mất dữ liệu.

### Câu 117. Nếu Groq hoặc mô hình không phản hồi thì sao?

Yêu cầu có timeout và lỗi được chuẩn hóa để giao diện thông báo chức năng AI tạm thời không khả dụng. Các chức năng cốt lõi khác vẫn nên hoạt động; hiện hệ thống chưa có cơ chế chuyển sang nhà cung cấp dự phòng.

### Câu 118. Tại sao AI chỉ dành cho ứng viên?

Ba chức năng hiện tại trực tiếp phục vụ việc xây dựng CV và luyện phỏng vấn nên gắn với vai trò ứng viên. Việc giới hạn vai trò cũng giảm bề mặt lạm dụng; nếu sau này bổ sung AI cho doanh nghiệp thì cần định nghĩa mục đích, dữ liệu và quyền riêng biệt.

### Câu 119. AI có được phép truy cập toàn bộ cơ sở dữ liệu không?

Không. Mô hình chỉ nhận payload đã được máy chủ chọn lọc cho từng yêu cầu. Nó không có thông tin kết nối cơ sở dữ liệu, không tự chạy truy vấn và không được cấp quyền thực hiện hành động trong hệ thống.

---

## 7. CV và xử lý PDF

### Câu 120. Hệ thống có những loại CV nào?

Hệ thống phân biệt CV có cấu trúc được tạo và chỉnh sửa trong ứng dụng với CV PDF do người dùng tải từ thiết bị lên. Cả hai có thể được quản lý và chọn khi ứng tuyển, nhưng chỉ CV có cấu trúc mới dùng trực tiếp cho các chức năng AI hiện tại.

### Câu 121. CV có cấu trúc là gì?

Đây là CV được lưu thành các trường dữ liệu như giới thiệu, kinh nghiệm, học vấn, kỹ năng và dự án thay vì chỉ lưu hình ảnh của một trang. Cấu trúc này giúp chỉnh sửa từng phần, đổi mẫu, kiểm tra dữ liệu và gửi nội dung cần thiết cho AI.

### Câu 122. Vì sao vẫn cho phép tải CV PDF lên?

Nhiều người đã có CV được tạo từ công cụ khác. Cho phép tải PDF giúp họ ứng tuyển ngay mà không phải nhập lại toàn bộ, đồng thời hệ thống vẫn cung cấp lựa chọn tạo CV có cấu trúc khi muốn dùng các khả năng chỉnh sửa và AI.

### Câu 123. Người dùng ứng tuyển bằng CV nào?

Người dùng có thể chọn một CV đã lưu trong hệ thống, bao gồm CV có cấu trúc hoặc CV PDF đã tải lên. Hệ thống lưu tham chiếu tới CV được chọn trong hồ sơ ứng tuyển để doanh nghiệp xem đúng tài liệu người dùng đã dùng.

### Câu 124. `react-to-print` có thật sự tạo tệp PDF không?

`react-to-print` tạo vùng in từ component React và mở hộp thoại in của trình duyệt. Việc chọn “Save as PDF” do trình duyệt hoặc hệ điều hành thực hiện, nên đây là xuất PDF phía người dùng chứ không phải máy chủ tự sinh tệp PDF nhị phân.

### Câu 125. Vì sao chọn `react-to-print`?

Nó tái sử dụng trực tiếp giao diện CV đã hiển thị, giúp bản xem trước và bản in tương đối nhất quán, đồng thời giảm nhu cầu xây dựng một bộ tạo PDF riêng trên máy chủ. Hạn chế là kết quả có thể phụ thuộc trình duyệt và thiết lập in.

### Câu 126. Làm thế nào giữ bố cục CV theo khổ A4?

Giao diện CV dùng kích thước và CSS in tương ứng A4, kiểm soát lề, màu, ngắt trang và phần tử không cần in. Nội dung dài vẫn cần quy tắc tránh tràn và kiểm thử với nhiều dữ liệu vì HTML không tự đảm bảo mọi bố cục luôn vừa trang.

### Câu 127. PDF.js được dùng để làm gì?

PDF.js giúp trình duyệt đọc và hiển thị nội dung PDF mà không phụ thuộc hoàn toàn vào trình xem PDF bên ngoài. Trong hệ thống, nó phù hợp cho việc xem trước CV PDF đã tải lên.

### Câu 128. Vì sao không dùng PDF.js để chỉnh sửa CV PDF?

PDF.js chủ yếu phục vụ phân tích và hiển thị PDF, không cung cấp mô hình chỉnh sửa nội dung cấp cao như một trình soạn thảo CV. Việc sửa trực tiếp PDF phức tạp vì văn bản thường được lưu theo tọa độ, font và đối tượng vẽ.

### Câu 129. Giới hạn kích thước CV PDF là bao nhiêu và vì sao?

Theo phạm vi hệ thống, tệp sau giải mã được giới hạn khoảng 5 MB. Giới hạn này giúp kiểm soát bộ nhớ, băng thông và kích thước document khi còn lưu Base64; ở hệ thống thực tế, giới hạn nên cấu hình và kết hợp kho tệp chuyên dụng.

### Câu 130. Làm thế nào xác định tệp tải lên thật sự là PDF?

Không nên chỉ tin phần mở rộng hoặc MIME type do trình duyệt gửi. Máy chủ cần kiểm tra chữ ký đầu tệp, kích thước và khả năng phân tích hợp lệ; nếu yêu cầu bảo mật cao thì thêm quét mã độc và xử lý trong môi trường cách ly.

### Câu 131. Vì sao hình trong báo cáo bị vỡ khi dùng PNG?

PNG là ảnh raster có số điểm ảnh cố định; khi sơ đồ lớn bị thu hoặc phóng, chữ và đường nét sẽ mờ. Nên xuất sơ đồ dưới dạng vector PDF hoặc SVG được chuyển đúng cách, cắt vùng trắng và chèn với kích thước phù hợp thay vì phóng một ảnh độ phân giải thấp.

### Câu 132. Vì sao LaTeX báo không hỗ trợ `.svg`?

Trình biên dịch và gói `graphicx` thường không đọc SVG trực tiếp. Có thể chuyển SVG sang PDF vector rồi chèn bằng `\includegraphics`, hoặc dùng gói `svg` với công cụ chuyển đổi được cấu hình; cách PDF thường ổn định hơn cho báo cáo.

### Câu 133. Làm sao chỉ xoay hình mà không xoay cả trang LaTeX?

Dùng tùy chọn `angle=90` và `origin=c` trong `\includegraphics` hoặc bọc ảnh bằng `\rotatebox`, không dùng môi trường `landscape`. Cần đổi giới hạn từ `\linewidth` sang chiều cao hoặc chiều rộng thích hợp để ảnh sau xoay vẫn nằm trong trang.

### Câu 134. Nếu PDF CV có nhiều trang thì hệ thống xử lý thế nào?

Hệ thống giữ nguyên tệp PDF nhiều trang để xem và tải về; khi hiển thị, trình xem phải hỗ trợ chuyển trang. Nếu sau này trích xuất nội dung cho AI, cần xử lý từng trang, giới hạn tổng dung lượng và hợp nhất văn bản theo đúng thứ tự.

---

## 8. Kiểm thử và đánh giá

### Câu 135. Hệ thống sử dụng những loại kiểm thử nào?

Hệ thống có kiểm thử phía máy chủ bằng Node Test Runner với dữ liệu hoặc thành phần được cô lập, và kiểm thử giao diện bằng Playwright. Ngoài ra mã nguồn đã được kiểm tra lint và build, nhưng chưa có bộ kiểm thử tải, bảo mật và tích hợp đầy đủ với môi trường thật.

### Câu 136. Kết quả kiểm thử chính xác hiện tại là gì?

Phía máy chủ có 13 tệp với 43 trường hợp, tất cả đạt tại thời điểm đánh giá. Phía giao diện có 6 kịch bản Playwright đạt; cần nói rõ API trong các kịch bản này được mô phỏng.

### Câu 137. Node Test Runner là gì?

Đây là bộ chạy kiểm thử tích hợp trong Node.js, hỗ trợ khai báo test, assertion kết hợp và báo cáo kết quả mà không nhất thiết cần Jest. Dự án dùng nó để kiểm tra các đơn vị hoặc luồng phía máy chủ trong môi trường cô lập.

### Câu 138. Playwright là gì?

Playwright là công cụ tự động hóa trình duyệt dùng để kiểm thử hành vi giao diện như mở trang, nhập biểu mẫu, nhấn nút và kiểm tra điều hướng. Nó có thể chạy trên nhiều engine trình duyệt, dù bộ kiểm thử hiện tại chủ yếu được xác nhận trên Chromium.

### Câu 139. Sáu kịch bản Playwright kiểm tra gì?

Các kịch bản tập trung vào trang chào, kiểm tra biểu mẫu đăng nhập trống, điều hướng sau đăng nhập theo vai trò và ngăn ứng viên truy cập tuyến quản trị. Chúng xác minh hành vi giao diện và route guard trong các tình huống chính.

### Câu 140. Vì sao lại mô phỏng API trong Playwright?

Mô phỏng API giúp kiểm thử giao diện ổn định, nhanh và không phụ thuộc máy chủ hoặc dữ liệu bên ngoài. Đổi lại nó không phát hiện lỗi hợp đồng API, xác thực thật hay truy vấn MongoDB, nên cần bổ sung một nhóm end-to-end chạy trên hệ thống thật.

### Câu 141. Kiểm thử Playwright hiện tại có phải end-to-end hoàn chỉnh không?

Không. Nó đi qua giao diện và trình duyệt nhưng điểm cuối mạng được mô phỏng, nên chỉ là kiểm thử luồng UI ở mức tích hợp. End-to-end hoàn chỉnh phải chạy giao diện, server và cơ sở dữ liệu thật trong môi trường kiểm thử.

### Câu 142. Tại sao 43 kiểm thử đạt vẫn chưa chứng minh hệ thống không có lỗi?

Kiểm thử chỉ xác nhận các trường hợp đã được viết. Các nhánh chưa bao phủ, lỗi cạnh tranh, tải cao, trình duyệt khác, cấu hình triển khai và hành vi dịch vụ bên ngoài vẫn có thể gây lỗi; vì vậy “đạt” không đồng nghĩa “không còn lỗi”.

### Câu 143. Hệ thống đã kiểm thử với MongoDB thật chưa?

Bộ kiểm thử được mô tả chủ yếu dùng dữ liệu hoặc thành phần cô lập, chưa chứng minh toàn bộ luồng chạy với MongoDB thật. Đây là khoảng trống cần bổ sung bằng cơ sở dữ liệu kiểm thử riêng, seed dữ liệu và dọn sạch sau mỗi lần chạy.

### Câu 144. Những chức năng nào cần ưu tiên kiểm thử tích hợp?

Ưu tiên đăng nhập bằng cookie, kiểm tra vai trò và quyền sở hữu, tạo hồ sơ ứng tuyển chống trùng, chuyển trạng thái ứng tuyển, lưu tin nhắn, tải PDF và ba API AI. Đây là các luồng đi qua nhiều lớp và có rủi ro dữ liệu hoặc bảo mật cao.

### Câu 145. Cần kiểm thử phân quyền như thế nào?

Với mỗi API nhạy cảm, cần kiểm tra: chưa đăng nhập, sai vai trò, đúng vai trò nhưng không sở hữu tài nguyên và đúng vai trò có quyền. Cũng phải thử sửa ID trong URL hoặc payload để phát hiện truy cập chéo người dùng.

### Câu 146. Cần kiểm thử chức năng AI như thế nào?

Tách hai lớp: kiểm thử xác định cho sanitizer, schema, quota, timeout và xử lý lỗi bằng phản hồi mô phỏng; sau đó đánh giá chất lượng bằng bộ CV/câu trả lời chuẩn và tiêu chí do chuyên gia chấm. Không nên chỉ kiểm tra API trả về mã 200.

### Câu 147. Chất lượng phản hồi AI đã được đánh giá định lượng chưa?

Chưa có benchmark độc lập hoặc đối chiếu chuyên gia được báo cáo. Kết quả hiện chứng minh luồng tích hợp hoạt động, không chứng minh nhận xét AI chính xác ở mức tuyển dụng; đây là hạn chế cần trình bày thẳng.

### Câu 148. Hệ thống đã kiểm thử tải chưa?

Chưa có kiểm thử tải chính thức. Cần đo thời gian phản hồi, thông lượng, lỗi khi nhiều người cùng truy cập, số kết nối Socket.IO và tác động của truy vấn PDF lớn để xác định nút thắt thật.

### Câu 149. Hệ thống đã kiểm thử bảo mật chưa?

Mới có các biện pháp và một số kiểm tra chức năng liên quan, chưa có pentest hoặc bộ kiểm thử bảo mật chuyên sâu. Nên bổ sung kiểm tra OWASP, quét phụ thuộc, kiểm thử upload, CSRF, XSS, NoSQL injection và truy cập sai quyền.

### Câu 150. Làm thế nào kiểm thử unique index chống ứng tuyển trùng?

Tạo hai yêu cầu ứng tuyển cùng cặp ứng viên–công việc, tốt nhất gửi gần đồng thời. Kết quả mong đợi là chỉ một document được tạo và yêu cầu còn lại nhận lỗi trùng được chuyển thành thông báo nghiệp vụ phù hợp.

### Câu 151. Làm thế nào kiểm thử `jobSnapshot`?

Tạo việc làm, ứng tuyển, sau đó sửa hoặc xóa việc làm gốc. Kiểm tra lịch sử ứng tuyển vẫn hiển thị tiêu đề và thông tin đã chụp tại thời điểm nộp, trong khi tham chiếu hiện hành có thể thay đổi hoặc không còn.

### Câu 152. Làm thế nào kiểm thử chat thời gian thực?

Mở hai phiên người dùng khác nhau, gửi tin nhắn, xác minh dữ liệu được lưu và bên nhận nhận sự kiện đúng phòng. Sau đó ngắt mạng, kết nối lại và kiểm tra lịch sử REST khôi phục được tin đã bỏ lỡ mà không tạo bản trùng.

### Câu 153. Lint và build thành công chứng minh điều gì?

Lint cho thấy mã tuân thủ các quy tắc tĩnh đã cấu hình; build cho thấy dự án có thể được đóng gói trong cấu hình hiện tại. Chúng hữu ích nhưng không thay thế kiểm thử hành vi, bảo mật hoặc kiểm thử trong môi trường triển khai thật.

### Câu 154. Tiêu chí nào dùng để kết luận đề tài đạt mục tiêu?

Cần đối chiếu từng mục tiêu với chức năng đã chạy, dữ liệu được lưu đúng, quyền được kiểm soát và kiểm thử tương ứng. Đồng thời phải nêu rõ phần chỉ mới chứng minh kỹ thuật, như AI, và phần chưa đạt đầy đủ, như kiểm thử tích hợp và khả năng mở rộng.

---

## 9. Câu hỏi tình huống khi demo

### Câu 155. Nếu máy chủ ngừng hoạt động khi người dùng đang nhập CV thì sao?

Phần state chưa gửi có thể còn trên giao diện nhưng sẽ mất nếu trang bị đóng hoặc tải lại, trừ khi có cơ chế lưu nháp cục bộ. Hệ thống nên giữ biểu mẫu, báo lỗi rõ và cho phép thử lưu lại; tương lai có thể thêm autosave có debounce và phiên bản dữ liệu.

### Câu 156. Nếu MongoDB ngừng hoạt động thì sao?

Các thao tác cần đọc hoặc ghi dữ liệu sẽ thất bại và API phải trả lỗi được chuẩn hóa, không để ứng dụng treo hoặc lộ chi tiết kết nối. Hệ thống hiện không có chế độ ngoại tuyến; môi trường thực tế cần giám sát, replica và cơ chế phục hồi.

### Câu 157. Nếu Groq ngừng hoạt động thì toàn hệ thống có dùng được không?

Có, các chức năng không phụ thuộc AI vẫn nên hoạt động bình thường. Các API AI trả thông báo tạm thời không khả dụng sau timeout; hiện chưa có nhà cung cấp dự phòng nên chỉ phần AI bị gián đoạn.

### Câu 158. Nếu Socket.IO mất kết nối thì tin nhắn có mất không?

Tin nhắn nên được lưu vào cơ sở dữ liệu trước hoặc cùng luồng xử lý rồi mới phát sự kiện. Người dùng có thể không nhận ngay khi mất kết nối, nhưng sau khi kết nối lại, giao diện lấy lịch sử qua API để khôi phục; cần xử lý chống gửi trùng.

### Câu 159. Nếu hai doanh nghiệp cùng cập nhật một hồ sơ thì sao?

Trong nghiệp vụ đúng, chỉ doanh nghiệp sở hữu tin liên quan mới được cập nhật hồ sơ đó. Nếu có hai phiên hợp lệ của cùng doanh nghiệp, cập nhật cuối có thể ghi đè; có thể cải tiến bằng trường phiên bản, thời gian cập nhật và optimistic concurrency.

### Câu 160. Nếu ứng viên nhấn nút ứng tuyển hai lần liên tiếp thì sao?

Giao diện nên vô hiệu hóa nút trong khi gửi, nhưng lớp bảo vệ quyết định là unique index trên ứng viên và công việc. Nếu yêu cầu thứ hai đến máy chủ, lỗi trùng được chuyển thành thông báo “đã ứng tuyển” thay vì tạo thêm hồ sơ.

### Câu 161. Nếu người dùng tải tệp `.exe` đổi tên thành `.pdf` thì sao?

Máy chủ không được tin tên tệp; phải kiểm tra MIME type, chữ ký PDF và khả năng phân tích. Tệp không hợp lệ bị từ chối; với môi trường thực tế nên thêm quét mã độc và không phục vụ tệp theo cách cho phép thực thi.

### Câu 162. Nếu AI trả về điểm lớn hơn 100 hoặc dữ liệu thiếu thì sao?

Máy chủ validate và chuẩn hóa phản hồi, giới hạn điểm trong miền cho phép, lọc danh sách và dùng giá trị mặc định hoặc trả lỗi khi cấu trúc không đạt. Không hiển thị nguyên dữ liệu chưa kiểm tra cho người dùng.

### Câu 163. Nếu AI gợi ý thông tin sai và người dùng lưu thì trách nhiệm thuộc về ai?

Hệ thống phải cảnh báo kết quả chỉ mang tính gợi ý, thiết kế bước xác nhận rõ và không tự ghi đè. Người dùng chịu trách nhiệm xác nhận thông tin cá nhân, nhưng nhà phát triển vẫn có trách nhiệm giảm rủi ro bằng thiết kế minh bạch, logging phù hợp và cơ chế phản hồi.

### Câu 164. Nếu tải lại trang khi đang luyện phỏng vấn thì sao?

Phiên hiện tại bị mất vì lịch sử chỉ nằm trong state của giao diện. Đây là hạn chế đã biết; giải pháp là lưu phiên phỏng vấn và từng lượt trả lời vào cơ sở dữ liệu hoặc session storage tùy yêu cầu riêng tư và khả năng khôi phục.

### Câu 165. Nếu có hàng nghìn người dùng đồng thời, điểm nghẽn nào xuất hiện trước?

Khả năng cao là lưu PDF Base64 trong MongoDB, số kết nối thời gian thực, polling thông báo và hạn mức dịch vụ AI. Cần đo tải trước khi kết luận, sau đó tách object storage, dùng cache/queue, mở rộng socket có adapter và tối ưu truy vấn/index.

### Câu 166. Nếu doanh nghiệp xóa việc làm sau khi đã có ứng viên thì sao?

Không nên làm mất toàn bộ lịch sử. Application giữ `jobSnapshot` để vẫn hiển thị ngữ cảnh; hệ thống có thể dùng xóa mềm hoặc trạng thái đóng thay vì xóa vật lý, tùy chính sách nghiệp vụ.

### Câu 167. Nếu một ứng viên cố truy cập trang quản trị bằng URL thì sao?

Giao diện sẽ chặn hoặc điều hướng, nhưng quan trọng hơn là mọi API quản trị phải xác minh JWT và vai trò admin. Ngay cả khi người dùng bỏ qua giao diện, máy chủ vẫn trả 403 và không tiết lộ dữ liệu.

### Câu 168. Nếu phải triển khai sản phẩm thật ngay ngày mai, bạn cần làm gì trước?

Tôi chưa đưa ngay vào sản xuất. Trước hết cần rà soát toàn bộ quyền truy cập, quản lý secret và cookie, chuyển tệp sang kho chuyên dụng, thiết lập backup–monitoring–logging, chạy kiểm thử tích hợp/bảo mật/tải, bổ sung chính sách riêng tư và chuẩn bị cơ chế xử lý sự cố.

---

## 10. Câu hỏi bổ sung về các công nghệ được sử dụng

### Câu 169. React Hook Form dùng để làm gì?

React Hook Form quản lý giá trị, lỗi và trạng thái gửi của biểu mẫu với ít lần render không cần thiết. Nó đặc biệt hữu ích cho biểu mẫu CV có nhiều trường, vì có thể đăng ký trường, kiểm tra lỗi theo từng mục và chỉ gửi khi dữ liệu hợp lệ.

### Câu 170. Zod là gì?

Zod là thư viện khai báo schema và kiểm tra dữ liệu cho JavaScript/TypeScript. Lập trình viên mô tả kiểu, độ dài và điều kiện của dữ liệu, sau đó Zod trả về dữ liệu hợp lệ hoặc danh sách lỗi có cấu trúc.

### Câu 171. Vì sao kết hợp React Hook Form với Zod?

React Hook Form quản lý vòng đời biểu mẫu, còn Zod chịu trách nhiệm định nghĩa quy tắc dữ liệu. Resolver kết nối hai thư viện để cùng một schema tạo lỗi theo trường trước khi gửi, giúp tách logic kiểm tra khỏi phần hiển thị và giảm quy tắc bị viết rải rác.

### Câu 172. Ưu điểm nổi bật của Zod là gì?

Zod có cú pháp khai báo rõ, hỗ trợ object và dữ liệu lồng nhau, suy luận kiểu TypeScript, biến đổi dữ liệu và thông báo lỗi theo đường dẫn. Hệ sinh thái có thể tích hợp với React Hook Form, API và nhiều công cụ tạo tài liệu hoặc schema khác.

### Câu 173. Kiểm tra bằng Zod ở client có thay thế validation ở server không?

Không. Validation ở client giúp phản hồi nhanh và cải thiện trải nghiệm nhưng có thể bị bỏ qua. Máy chủ vẫn phải kiểm tra lại mọi dữ liệu trước khi xử lý hoặc lưu vì client là nguồn không tin cậy.

### Câu 174. Tailwind CSS là gì?

Tailwind CSS là framework CSS theo hướng utility-first, cung cấp các lớp nhỏ cho bố cục, khoảng cách, màu sắc và responsive. Nó giúp xây giao diện nhanh và giữ hệ thống thiết kế nhất quán mà không cần viết nhiều tệp CSS riêng.

### Câu 175. Ưu và nhược điểm của Tailwind CSS là gì?

Ưu điểm là tốc độ phát triển, tính nhất quán, responsive thuận tiện và loại bỏ CSS không dùng khi build. Nhược điểm là danh sách class trong JSX có thể dài; dự án cần component hóa và quy ước lớp để tránh giao diện khó đọc hoặc sao chép lặp lại.

### Câu 176. Vite dùng để làm gì?

Vite là công cụ phát triển và đóng gói ứng dụng frontend. Trong lúc phát triển, nó cung cấp máy chủ nhanh và hot module replacement; khi build, nó tối ưu và chia gói tài nguyên để triển khai.

### Câu 177. Vì sao chọn Vite?

Vite có thời gian khởi động và cập nhật trong phát triển nhanh, cấu hình React gọn và hệ sinh thái plugin phù hợp. Nó chỉ là công cụ build, không quyết định kiến trúc dữ liệu hoặc bảo mật của ứng dụng.

### Câu 178. Chia gói mã là gì?

Chia gói mã là tách JavaScript thành nhiều tệp nhỏ thay vì một bundle duy nhất. Trình duyệt chỉ tải phần cần ở thời điểm hiện tại, ví dụ mã của dashboard được tải khi người dùng mở dashboard, nhờ đó giảm dung lượng khởi đầu.

### Câu 179. Cập nhật lạc quan là gì?

Cập nhật lạc quan là tạm cập nhật giao diện trước khi máy chủ xác nhận, dựa trên giả định yêu cầu sẽ thành công. Nếu thất bại, ứng dụng khôi phục dữ liệu cũ và báo lỗi; cách này tạo cảm giác nhanh nhưng chỉ nên dùng khi có cơ chế rollback rõ ràng.

### Câu 180. Tên tiếng Anh của cập nhật lạc quan là gì?

Tên tiếng Anh là **optimistic update** hoặc **optimistic UI update**. Trong TanStack Query, nó thường được thực hiện khi mutation bắt đầu, lưu snapshot cache cũ và rollback trong `onError`.

### Câu 181. Socket.IO là gì?

Socket.IO là thư viện giao tiếp hai chiều dựa trên sự kiện giữa client và server. Nó hỗ trợ kết nối lại, heartbeat, phát sự kiện đến một hoặc nhiều client và các cơ chế dự phòng truyền tải, phù hợp với trò chuyện thời gian thực.

### Câu 182. “Phòng” trong Socket.IO là gì?

Phòng là một nhóm logic các socket trên máy chủ. Khi người dùng tham gia phòng theo ID người dùng hoặc cuộc trò chuyện, máy chủ có thể phát sự kiện đúng nhóm thay vì gửi cho tất cả kết nối; phòng không phải phòng chat được lưu tự động trong cơ sở dữ liệu.

### Câu 183. Socket.IO có tự lưu tin nhắn không?

Không. Socket.IO chỉ vận chuyển sự kiện. Ứng dụng phải tự kiểm tra quyền, lưu tin nhắn vào MongoDB và cung cấp API lấy lịch sử; nếu chỉ phát sự kiện, tin nhắn sẽ mất với người dùng đang ngoại tuyến.

### Câu 184. TanStack Query có quản lý Socket.IO không?

Không trực tiếp. Socket.IO quản lý kết nối và sự kiện thời gian thực; TanStack Query quản lý dữ liệu máy chủ qua cache. Khi nhận sự kiện socket, ứng dụng có thể cập nhật hoặc vô hiệu hóa cache TanStack Query để giao diện đồng bộ.

### Câu 185. Thông báo và tin nhắn của RabbitCV khác nhau về cơ chế cập nhật thế nào?

Tin nhắn sử dụng Socket.IO để nhận sự kiện gần như tức thời và dùng API cho lịch sử. Thông báo hiện dùng REST cùng TanStack Query, trong đó số chưa đọc được kiểm tra định kỳ khoảng 30 giây; vì vậy không nên nói cả hai đều thời gian thực bằng Socket.IO.

### Câu 186. `node-cron` là gì?

`node-cron` là thư viện lập lịch tác vụ trong tiến trình Node.js theo biểu thức thời gian, ví dụ chạy mỗi giờ hoặc mỗi ngày. Nó không tự kích hoạt khi có một thông báo; nếu dự án dùng nó thì tác vụ chạy theo lịch đã cấu hình, và khi nhiều server cùng chạy cần tránh tác vụ bị thực hiện lặp.

### Câu 187. `virtualResume_id` trong sơ đồ tuần tự nghĩa là gì?

Đó là ID của bản ghi CV được hệ thống tạo hoặc quản lý để dùng ở bước tạo hồ sơ ứng tuyển. Tên “virtualResume” cần được giải thích là CV nội bộ/có cấu trúc hoặc đổi tên cho thống nhất với mô hình hiện tại, vì nếu không người đọc dễ nhầm với CV PDF.

### Câu 188. “Mã giao diện” nghĩa là gì?

Mã giao diện là phần mã chạy ở phía người dùng để hiển thị và xử lý tương tác, trong dự án chủ yếu là component React, JSX, CSS/Tailwind, route và logic state. Nó không bao gồm quy tắc bảo mật quyết định ở server dù có thể ẩn hoặc hiện chức năng theo vai trò.

---

## 11. Cách sử dụng bộ câu hỏi

Không nên học thuộc từng chữ. Với mỗi câu, hãy nhớ theo cấu trúc ba bước: **kết luận trực tiếp – cách áp dụng trong RabbitCV – hạn chế hoặc hướng cải tiến**. Khi thầy hỏi sâu, chỉ mở rộng đúng phần được hỏi và dùng màn hình, API hoặc cấu trúc dữ liệu của hệ thống làm minh chứng.

Mười hai câu cần luyện trước gồm: lý do chọn đề tài; điểm nổi bật; kiến trúc; MongoDB; phân quyền; quy trình ứng tuyển; ba chức năng AI; Groq và mô hình; bảo vệ dữ liệu gửi AI; số liệu kiểm thử; hạn chế của kiểm thử; và ba hướng phát triển ưu tiên. Các câu này đều đã có câu trả lời trong các mục tương ứng ở trên.

