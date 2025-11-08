CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    fullname NVARCHAR(100) NOT NULL,
    account NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    role NVARCHAR(20) NOT NULL DEFAULT 'user',
    status NVARCHAR(20) NOT NULL DEFAULT 'inactive',
    avatar NVARCHAR(255)
);
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name NVARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    title_unaccented NVARCHAR(200) NOT NULL,
    slug NVARCHAR(255) NOT NULL UNIQUE,
    author NVARCHAR(100),
    category_id INT,
    quantity INT NOT NULL DEFAULT 1,
    cover_image NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO users (fullname, account, password, role, avatar) VALUES
(N'Nguyen Van A', 'nguyenvana', '123', 'admin', 'ava1.jpg'),
(N'Tran Thi B', 'tranthib', '123', 'user', 'ava2.jpg'),
(N'Le Van C', 'levanc', '123', 'user', 'ava3.jpg'),
(N'Pham Thi D', 'phamthid', '123', 'user', 'ava4.jpg');


INSERT INTO categories (name) VALUES
('Action'), ('English'), ('Romance'), ('Skill'), ('Technology');


-- action
INSERT INTO books (title, title_unaccented, slug, author, category_id, quantity, cover_image, description) VALUES
(N'Tai Ách Giáng Lâm', 'tai ach giang lam', 'tai-ach-giang-lam-ta-tien-hoa-thanh-tinh-hong-chi-vuong', N'Hieu Chu', 1, 8, '/action/taiac.jpg', N'Câu chuyện sinh tồn giữa thảm họa và tiến hóa.'),
(N'Ta Kẻ Sáng Tạo Tà Thần', 'ta ke sang tao ta than', 'ta-ke-sang-tao-ta-than', N'Phuong Hoang', 1, 5, '/action/tathan.jpg', N'Hành trình sáng tạo thế lực hắc ám của nhân vật chính.'),
(N'Bị Đuổi Khỏi Tổ Đội Dũng Sĩ, Tôi Được Nhặt Bởi Mạo Hiểm Giả Hạng S', 'bi duoi khoi to doi dung si toi duoc nhat boi mao hiem gia hang s', 'bi-duoi-khoi-to-doi-dung-si-toi-duoc-nhat-boi-mao-hiem-gia-hang-s', N'Mao Sư Vương', 1, 12, '/action/biduoi.jpg', N'Một người bị bỏ rơi chứng minh giá trị thật của bản thân.'),
(N'Đại Phụng Đả Canh Nhân', 'dai phung da canh nhan', 'dai-phung-da-canh-nhan', N'Mạc Hồng Dương', 1, 10, '/action/daiphung.jpg', N'Cảnh sát xuyên không thành người tu tiên.'),
(N'Đế Vương Tái Xuất', 'de vuong tai xuat', 'de-vuong-tai-xuat', N'Kieu Phong', 1, 7, '/action/devuong.jpg', N'Sự trở lại của vị vua huyền thoại.');

-- English
INSERT INTO books (title, title_unaccented, slug, author, category_id, quantity, cover_image, description) VALUES
(N'Basic IELTS Reading', 'basic ielts reading', 'basic-ielts-reading', N'Cambridge', 2, 15, '/english/ielts_reading.jpg', N'Kỹ năng đọc hiểu trong kỳ thi IELTS.'),
(N'Basic IELTS Speaking', 'basic ielts speaking', 'basic-ielts-speaking', N'Cambridge', 2, 14, '/english/ielts_speaking.jpg', N'Chiến lược và chủ đề luyện nói.'),
(N'Boost Your Vocabulary 1', 'boost your vocabulary 1', 'boost-your-vocabulary-1', N'NXB Tổng hợp', 2, 18, '/english/boost_vocab.jpg', N'Mở rộng vốn từ vựng tiếng Anh.'),
(N'IELTS Writing', 'ielts writing', 'ielts-writing', N'Huy Nguyễn Forum', 2, 11, '/english/ielts_writing.jpg', N'Hướng dẫn chi tiết Task 1 và Task 2.'),
(N'Hackers IELTS Listening', 'hackers ielts listening', 'hackers-ielts-listening', N'David Cho', 2, 9, '/english/hackers_listening.jpg', N'Luyện nghe chuyên sâu cho IELTS.'),
(N'Hackers IELTS Writing', 'hackers ielts writing', 'hackers-ielts-writing', N'Hackers Institute', 2, 10, '/english/hackers_writing.jpg', N'Phân tích và bài mẫu viết IELTS.'),
(N'Hackers IELTS Speaking', 'hackers ielts speaking', 'hackers-ielts-speaking', N'Hackers Institute', 2, 13, '/english/hackers_speaking.jpg', N'Luyện nói lưu loát, tự nhiên.');

-- Romance
INSERT INTO books (title, title_unaccented, slug, author, category_id, quantity, cover_image, description) VALUES
(N'Netoge no Yome ga Ninki Aidoru datta vol.1', 'netoge no yome ga ninki aidoru datta vol 1', 'netoge-no-yome-ga-ninki-aidoru-datta-vol-1', N'Kiseki Himura', 3, 8, '/romance/netoge_1.jpg', N'Câu chuyện tình giữa game thủ và idol.'),
(N'Netoge no Yome ga Ninki Aidoru datta vol.2', 'netoge no yome ga ninki aidoru datta vol 2', 'netoge-no-yome-ga-ninki-aidoru-datta-vol-2', N'Kiseki Himura', 3, 8, '/romance/netoge_2.jpg', N'Tiếp nối hành trình dở khóc dở cười.'),
(N'Rent-a-Girlfriend', 'rent a girlfriend', 'rent-a-girlfriend', N'Reiji Miyajima', 3, 20, '/romance/rent_a_girlfriend.jpg', N'Dịch vụ thuê bạn gái và mối tình phức tạp.'),
(N'Đừng Nhộn Với Đại Sư Huynh', 'dung nhon voi dai su huynh', 'dung-nhon-voi-dai-su-huynh', N'Tác giả E', 3, 15, '/romance/daisuhuynh.jpg', N'Hài hước tu tiên bá đạo.'),
(N'Class de Ichiban Kawaii Gal wo Ezuke Shiteiru Hanashi', 'class de ichiban kawaii gal wo ezuke shiteiru hanashi', 'class-de-ichiban-kawaii-gal-wo-ezuke-shiteiru-hanashi', N'Tác giả F', 3, 9, '/romance/kawaii_gal.jpg', N'Câu chuyện nhẹ nhàng học đường.');

-- Technology
INSERT INTO books (title, title_unaccented, slug, author, category_id, quantity, cover_image, description) VALUES
(N'Design Patterns: Elements of Reusable Object-Oriented Software', 'design patterns elements of reusable object oriented software', 'design-patterns-elements-of-reusable-object-oriented-software', N'Erich Gamma', 5, 8, '/technology/design_patterns.jpg', N'Mẫu thiết kế phần mềm cổ điển.'),
(N'Giải Thuật và Lập Trình', 'giai thuat va lap trinh', 'giai-thuat-va-lap-trinh', N'Lê Minh Hoàng', 5, 10, '/technology/giaithuat.jpg', N'Giải thuật cơ bản.'),
(N'Dive Into Algorithms', 'dive into algorithms', 'dive-into-algorithms', N'Bradford Tuckfield', 5, 7, '/technology/dive_algorithms.jpg', N'Tiếp cận thuật toán thực tế.'),
(N'Data Structures & Algorithms in Java', 'data structures and algorithms in java', 'data-structures-and-algorithms-in-java', N'Loiane Groner', 5, 6, '/technology/dsa_java.jpg', N'Triển khai cấu trúc dữ liệu bằng Java.'),
(N'Learn to Code by Solving Problems', 'learn to code by solving problems', 'learn-to-code-by-solving-problems', N'Daniel Zingaro', 5, 9, '/technology/learn_to_code.jpg', N'Học lập trình qua bài toán.'),
(N'How Computers Really Work', 'how computers really work', 'how-computers-really-work', N'Matthew Justice', 5, 5, '/technology/how_computers_work.jpg', N'Cách máy tính hoạt động.'),
(N'Algorithmic Thinking', 'algorithmic thinking', 'algorithmic-thinking', N'Daniel Zingaro', 5, 8, '/technology/algorithmic_thinking.jpg', N'Tư duy thuật toán.'),
(N'Think Like a Programmer', 'think like a programmer', 'think-like-a-programmer', N'V. Anton Spraul', 5, 11, '/technology/think_like_programmer.jpg', N'Tư duy giải quyết vấn đề.'),
(N'Spring in Action', 'spring in action', 'spring-in-action', N'Craig Walls', 5, 6, '/technology/spring_in_action.jpg', N'Hướng dẫn toàn diện về Spring.'),
(N'Head First Java', 'head first java', 'head-first-java', N'Kathy Sierra & Bert Bates', 5, 13, '/technology/head_first_java.jpg', N'Học Java trực quan.');

-- action
INSERT INTO books (title, title_unaccented, slug, author, category_id, quantity, cover_image, description) VALUES
(N'Lão Tử Tinh Hoa', 'lao tu tinh hoa', 'lao-tu-tinh-hoa', N'Nguyễn Duy Cần', 4, 7, '/skill/laotu_tinhhoa.jpg', N'Tư tưởng sâu sắc của Lão Tử.'),
(N'Một Nghệ Thuật Sống', 'mot nghe thuat song', 'mot-nghe-thuat-song', N'Nguyễn Duy Cần', 4, 10, '/skill/motnghethuatsong.jpg', N'Nghệ thuật sống bình an.'),
(N'Thuật Xử Thế Của Người Xưa', 'thuat xu the cua nguoi xua', 'thuat-xu-the-cua-nguoi-xua', N'Nhiều tác giả', 4, 6, '/skill/thuatxuthe.jpg', N'Bài học đối nhân xử thế.'),
(N'Lão Tử Đạo Đức Kinh Giải Luận', 'lao tu dao duc kinh giai luan', 'lao-tu-dao-duc-kinh-giai-luan', N'Lý Minh Tuấn', 4, 5, '/skill/daoduckinh.jpg', N'Giải nghĩa Đạo Đức Kinh.'),
(N'Óc Sáng Suốt', 'oc sang suot', 'oc-sang-suot', N'Nguyễn Duy Cần', 4, 9, '/skill/ocsangsuot.jpg', N'Tư duy minh mẫn và sáng suốt.'),
(N'Thuật Tư Tưởng', 'thuat tu tuong', 'thuat-tu-tuong', N'Nguyễn Duy Cần', 4, 7, '/skill/thuttuong.jpg', N'Phân tích nghệ thuật tư duy.'),
(N'Tôi Tự Học', 'toi tu hoc', 'toi-tu-hoc', N'Nguyễn Duy Cần', 4, 12, '/skill/toituhoc.jpg', N'Cảm hứng cho người tự học.'),
(N'Harvard Bốn Rưỡi Sáng', 'harvard bon ruoi sang', 'harvard-bon-ruoi-sang', N'Vi Kele', 4, 15, '/skill/harvard.jpg', N'Bài học về kỷ luật và nỗ lực.'),
(N'Atomic Habits', 'atomic habits', 'atomic-habits', N'James Clear', 4, 20, '/skill/atomic_habits.jpg', N'Thói quen tốt, bỏ thói quen xấu.'),
(N'Deep Work', 'deep work', 'deep-work', N'Cal Newport', 4, 11, '/skill/deep_work.jpg', N'Làm việc tập trung sâu.'),
(N'Trí Tuệ Do Thái', 'tri tue do thai', 'tri-tue-do-thai', N'Eran Katz', 4, 14, '/skill/trituedothai.jpg', N'Tư duy và học tập kiểu Do Thái.');

