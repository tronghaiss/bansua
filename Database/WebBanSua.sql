CREATE DATABASE WebBanSua;
GO

USE WebBanSua;
GO

-- Bảng người dùng
CREATE TABLE Users (
    UserID CHAR(10) PRIMARY KEY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100) UNIQUE,
    Password NVARCHAR(100),
    Role NVARCHAR(20), -- 'Admin' hoặc 'Customer'
    Phone NVARCHAR(20),
    Address NVARCHAR(200)
);

-- Bảng danh mục sữa
CREATE TABLE Categories (
    CategoryID CHAR(10) PRIMARY KEY,
    CategoryName NVARCHAR(100)
);

-- Bảng thương hiệu
CREATE TABLE Brands (
    BrandID CHAR(10) PRIMARY KEY,
    BrandName NVARCHAR(100),
    Origin NVARCHAR(100)
);

-- Bảng sản phẩm
CREATE TABLE Products (
    ProductID CHAR(10) PRIMARY KEY,
    Name NVARCHAR(200),
    CategoryID CHAR(10),
    BrandID CHAR(10),
    Price DECIMAL(10,2),
    Description NVARCHAR(MAX),
    Stock INT,
    ImageURL NVARCHAR(255),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (BrandID) REFERENCES Brands(BrandID)
);

-- Bảng đơn hàng
CREATE TABLE Orders (
    OrderID CHAR(10) PRIMARY KEY,
    UserID CHAR(10),
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2),
    Status NVARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Bảng chi tiết đơn hàng
CREATE TABLE OrderDetails (
    OrderDetailID CHAR(10) PRIMARY KEY,
    OrderID CHAR(10),
    ProductID CHAR(10),
    Quantity INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
-- Dữ liệu danh mục
INSERT INTO Categories (CategoryID, CategoryName)
VALUES 
('SB001', N'Sữa bột'), 
('SN002', N'Sữa nước'), 
('SC003', N'Sữa chua');

-- Dữ liệu thương hiệu
INSERT INTO Brands (BrandID, BrandName, Origin)
VALUES 
('EF001', N'Enfa', N'Việt Nam'),
('VM001', N'Vinamilk', N'Việt Nam'),
('FR001', N'Friso', N'Việt Nam'),
('BL001', N'Blanca', N'Việt Nam'),
('SN001', N'Snow Brand', N'Việt Nam'),
('AB001', N'Abbott', N'Hoa Kỳ'),
('DL001', N'Dutch Lady', N'Hà Lan'),
('MJ001', N'Meiji', N'Nhật Bản'),
('DM001', N'Danmilko', N'Đan Mạch'),
('BM001', N'Blackmores', N'Úc'),
('AP001', N'Aptamil', N'New Zealand'),
('NC001', N'NeoCare', N'Nhật'),
('LE001', N'Little Etoile', N'Úc');

-- Dữ liệu người dùng
INSERT INTO Users (UserID, FullName, Email, Password, Role, Phone, Address)
VALUES 
('U001', N'Nguyễn Văn A', 'a@example.com', '123456', 'Customer', '0909123456', N'123 Lê Lợi, Q1, TP.HCM'),
('U002', N'Trần Thị B', 'admin@example.com', 'admin123', 'Admin', '0909876543', N'456 Trần Hưng Đạo, Q5, TP.HCM');

-- Dữ liệu sản phẩm
INSERT INTO Products (ProductID, Name, CategoryID, BrandID, Price, Description, Stock, ImageURL)
VALUES 
('E1800', N'Sữa Enfamil A+ NeuroPro C-Sec 800gr Số 1 cho bé từ 0-12 tháng', 'SB001', 'EF001', 809000, N'Sữa Enfamil A+ NeuroPro C 1 dành cho trẻ từ 0 - 12 tháng tuổi bé cần nhiều dưỡng chất quan trọng để đáp ứng nhu cầu về sức khỏe và trí não', 100, '~/Hinh/Products/Enfa1.jpg'),
('E2800', N'Sữa bột Enfagrow A+ Neuropro C-Sec số 2 800g (1 - 3 tuổi)', 'SB001', 'EF001', 769000, N'Sữa Enfagrow A+ NeuroPro 2 C-Sec dành cho trẻ mấy tuổi? Sữa Enfagrow số 2 là dòng sữa công thức cao cấp dành cho bé từ 1-3 tuổi', 100, '~/Hinh/Products/Enfa2.jpg'),
('E3800', N'Sữa Enfagrow A+ NeuroPro 3 C-Sec (800g) cho bé từ 2-6 tuổi', 'SB001', 'EF001', 731000, N'Sữa Enfagrow A+ NeuroPro 3 C-Sec là dòng sữa công thức cao cấp dành cho bé từ 2-6 tuổi. Đây là giai đoạn vàng cho sự phát triển trí não', 100, '~/Hinh/Products/Enfa3.jpg'),
('EF005', N'Sữa Enfamil Enspire số 3 (850g) cho bé từ 2-6 Tuổi', 'SB001', 'EF001', 796000, N'6 năm đầu đời là giai đoạn vàng cho sự phát triển của trẻ, vì vậy có nhiều điều cần lưu ý để đảm bảo bé phát triển toàn diện về thể chất, trí tuệ và tinh thần.', 100, '~/Hinh/Products/Enfa4.jpg'),
('EF205', N'Sữa Bột Enfamil A2 Neuropro 3 – 800g', 'SB001', 'EF001', 675000, N'Sữa bột Enfagrow A2 Neuropro 3 là sản phẩm cao cấp với nguồn dinh dưỡng hoàn chỉnh, với thành phần đạm quý A2 từ New Zealand và bộ đôi vàng DHA & MFGM giúp khỏe bụng sáng trí.', 100, '~/Hinh/Products/Enfa5.jpg'),
('EF203', N'Sữa Bột Enfamil A2 Neuropro 2 – 800g', 'SB001', 'EF001', 752000, N'Sữa bột Enfamil A2 Neuropro 2 là sản phẩm sữa công thức cao cấp với nguồn dinh dưỡng hoàn chỉnh, với thành phần đạm quý A2 từ New Zealand và bộ đôi vàng DHA & MFGM giúp khỏe bụng sáng trí.', 100, '~/Hinh/Products/Enfa6.jpg'),
('EF006', N'SỮA Enfalac A+ Gental Care 400g (0 - 12 tháng)', 'SB001', 'EF001', 360000, N'Enfalac A+ Gentle Care là sản phẩm dinh dưỡng đặc biệt được khuyến khích sử dụng cho bé gặp vấn đề thông thường về tiêu hóa và nuôi ăn.', 100, '~/Hinh/Products/Enfa7.jpg'),
('EF032', N'Sữa Enfa Nutramigen 400g', 'SB001', 'EF001', 610000, N'Với công thức đặc biệt Sữa Enfamil Nutramigen A+ là dinh dưỡng chuyên biệt dành cho các bé 0 - 12 tháng có hiện tượng dị ứng đạm sữa bò.', 100, '~/Hinh/Products/Enfa8.jpg'),
('EF002', N'Sữa Enfamama A+ Chocolate - 830g', 'SB001', 'EF001', 470000, N'Các nghiên cứu khoa học đã chứng minh, não trẻ bắt đầu phát triển khoảng từ tuần thứ 8 và giai đoạn trí não phát triển nhanh nhất trong khoảng giữa thai kỳ tới 18 tháng sau khi sinh.', 100, '~/Hinh/Products/Enfa9.jpg'),
('EF013', N'Sữa bột Enfagrow A+ 3 neuropro 1.7kg', 'SB001', 'EF001', 996000, N'Mẹ luôn muốn nuôi dưỡng con phát triển tốt về trí tuệ và cảm xúc - nền tảng cho sự thành công mai sau của con - thông qua nguồn dinh dưỡng tốt và phương pháp giáo dục thích hợp.', 100, '~/Hinh/Products/Enfa10.jpg'),

('FRI008', N'Sữa Frisolac Gold 1 850g', 'SB001', 'FR001', 550000, N'Sản phẩm Sữa bột Frisolac Gold 1 900g thực phẩm dinh dưỡng cho bé từ 0-6 tháng tuổi, giúp hỗ trợ hệ tiêu hóa ,ngoài ra còn hỗ trợ sự phát triền trí não của bé.', 100, '~/Hinh/Products/Friso1.jpg'),
('FRI002', N'Sữa Frisolac Gold 3 850g', 'SB001', 'FR001', 520000, N'Sữa Friso Gold số 3 vị vani gồm sự kết hợp tối ưu giữa Synbiotics (Probiotics BB-12® & L.casei 431® và Prebiotics GOS & FOS) và các dưỡng chất khác như Kẽm, Nucleotides và Selen giúp hỗ trợ hệ miễn dịch và giúp bảo vệ bé từ bên trong.', 100, '~/Hinh/Products/Friso2.jpg'),
('FRI010', N'Sữa Friso Gold Mum hương Vanilla 850g', 'SB001', 'FR001', 500000, N'Là sản phẩm sữa bột dành cho bà mẹ mang thai và cho con bú, cung cấp các dưỡng chất quan trọng', 100, '~/Hinh/Products/Friso3.jpg'),
('FRI013', N'Sữa Frisolac Gold 2 850g', 'SB001', 'FR001', 550000, N'Priso đã cho ra mắt sản phẩm sữa Frisolac Gold số 2 hộp 900g dành cho bé từ 6-12 tháng nhằm bổ sung DHA, ARA, chất xơ vi chất Prebiotic, Nucleotides, cho bé hệ tiêu hóa khỏe mạnh, phát triển hệ thống miễn dịch, trí thông minh ngay từ khi còn nhỏ.', 100, '~/Hinh/Products/Friso4.jpg'),
('FRI021', N'Sữa Friso Gold 5 900g', 'SB001', 'FR001', 360000, N'Friso Gold 5 Mới được thiết kế đặc biệt để đáp ứng nhu cầu dinh dưỡng của trẻ đang trong giai đoạn phát triển với công thức cải tiến gồm Synbiotics và các dưỡng chất như Kẽm.', 100, '~/Hinh/Products/Friso5.jpg'),
('FRI010C', N'Sữa Friso Gold Mum hương Cam 850g', 'SB001', 'FR001', 500000, N'', 100, '~/Hinh/Products/Friso6.jpg'),

('BLANCA001', N'Sữa Blanca nguyên kem 900gr Nhập Khẩu Trực Tiếp Từ Hà Lan', 'SB001', 'BL001', 490000, N'Sữa Blanca nguyên kem hộp 900g là nguồn cung cấp đầy đủ canxi, vitamin A, và D, các chất dinh dưỡng quan trọng cho sức khỏe xương và răng.', 100, '~/Hinh/Products/Blanca1.jpg'),
('BLANCA002', N'Sữa Blanca tách béo 1000gr Nhập Khẩu Trực Tiếp Từ Hà Lan', 'SB001', 'BL001', 490000, N'Sữa Blanca tách béo 1000gr là sự lựa chọn hoàn hảo cho những người ăn kiêng và quan tâm đến việc giữ vóc dáng.', 100, '~/Hinh/Products/Blanca2.jpg'),

('SNOW001', N'Sữa Snow Brand số 0 Nhật 820g (0 - 12 tháng)', 'SB001', 'SN001', 350000, N'Từ 0 - 12 tháng tuổi là giai đoạn nền tảng dinh dưỡng rất quan trọng của trẻ nhỏ.', 100, '~/Hinh/Products/SnowBrand1.jpg'),
('SNOW002', N'Sữa Snow Baby Nhật số 2 850g (9 - 36 tháng)', 'SB001', 'SN001', 460000, N'Dành cho trẻ từ 9 tháng đến 3 tuổi - giai đoạn vàng để trẻ đạt được sự phát triển và tăng trưởng về thể chất và tinh thần.', 100, '~/Hinh/Products/SnowBrand2.jpg'),
('SNOW003', N'Sữa Snow Baby số 3 900g cho bé 3Y+', 'SB001', 'SN001', 450000, N'Trẻ nhỏ giai đoạn 3 – 6 tuổi bước vào giai đoạn vàng thứ 2 – giai đoạn học đường.', 100, '~/Hinh/Products/SnowBrand3.jpg'),

('MEI002', N'Sữa Meiji số 9 800g', 'SB001', 'MJ001', 360000, N'Sữa bột cho bé Meiji là một trong những thực phẩm dinh dưỡng tốt nhất dành cho trẻ sơ sinh và trẻ nhỏ. Được sản xuất từ những nguyên liệu thiên nhiên, an toàn cho sức khỏe của bé, được rất nhiều bà mẹ Việt tin dùng.', 100, '~/Hinh/Products/Meiji1.jpg'),
('GLI001', N'Sữa Glico Icreo số 0 800g', 'SB001', 'MJ001', 580000, N'Sữa Icreo Glico số 0 là loại sữa cho trẻ sơ sinh khi sữa mẹ không đủ sữa cho bé. Giai đoạn khởi đầu rất quan trọng đối với cơ thể bé, nên mẹ hãy cân nhắc lựa chọn những loại sữa phù hợp nhất cho con.', 100, '~/Hinh/Products/Meiji2.jpg'),
('MEIJITHANH', N'Sữa Meiji số 0 dạng thanh 648g (0 - 1 tuổi)', 'SB001', 'MJ001', 529000, N'Là một thương hiệu nổi tiếng và được rất nhiều các bà mẹ Nhật tin dùng, sữa Meiji số 0 dạng thanh dưới đây sẽ mang tới cho các bé từ 0 đến 1 tuổi một sản phẩm dinh dưỡng công thức có tính mát, kết hợp cùng các dưỡng chất quan trọng, đảm bảo bù đắp sự thiếu hụt dinh dưỡng cho bé trong giai đoạn đầu đời quan trọng này.', 100, '~/Hinh/Products/Meiji3.jpg'),
('GLI002M', N'Sữa Glico Icreo số 1 820g (Chính hãng)', 'SB001', 'MJ001', 530000, N'Sữa Glico Icreo số 1 đến từ Nhật Bản được đặc chế phù hợp cho trẻ từ 9 tháng tới 3 tuổi - giai đoạn bé cần rất nhiều năng lượng và dưỡng chất để hoàn thiện nhận thức, giác quan cũng như phát triển về tầm vóc và thể lực.', 100, '~/Hinh/Products/Meiji4.jpg'),
('MEI001', N'Sữa Meiji số 0 800g', 'SB001', 'MJ001', 485000, N'Trong 1 năm đầu đời, nhất là những tháng đầu tiên sau khi sinh bé sẽ cần rất nhiều dưỡng chất giúp tăng cường hệ miễn dịch, bảo vệ cơ thể khỏi những mầm bệnh.', 100, '~/Hinh/Products/Meiji5.jpg'),
('Mejict02', N'Sữa Meiji Growing up Formula 800g (12-36 tháng)', 'SB001', 'MJ001', 465000, N'Thực phẩm bổ sung sản phẩm dinh dưỡng công thức cho trẻ từ 1 đến 3 tuổi: Meiji 1-3 years old Growing up Formula.', 100, '~/Hinh/Products/Meiji6.jpg'),
('Mejict01', N'Sữa Meiji Infant Formula 800g (0-12 tháng)', 'SB001', 'MJ001', 529000, N'Sữa Meiji Infant Formula 800g (0-12 tháng) là sữa bột công thức được nhập khẩu chính hãng từ Nhật Bản. Sản phẩm dành cho trẻ sơ sinh từ 0 - 12 tháng tuổi.', 100, '~/Hinh/Products/Meiji7.jpg'),

('DANMIK005', N'Sữa Danmilko mature adult 800g', 'SB001', 'DM001', 697000, N'Hãy để DanMilko với nguồn dinh dưỡng hạnh phúc từ Đan Mạch, cùng bạn tận hưởng cuộc sống và giảm thiểu các tác động tiêu cực do lão hoá.', 100, '~/Hinh/Products/Danmilko1.jpg'),
('DANMIK004', N'Sữa Danmilko Miniature 3 dinh dưỡng toàn diện cho bé trên 24 tháng', 'SB001', 'DM001', 620000, N'DanMilko Miniature Số 3 là sản phẩm dinh dưỡng công thức dành cho trẻ từ 24 tháng tuổi trở lên... giúp bé phát triển vượt trội cả về thể chất và trí tuệ.', 100, '~/Hinh/Products/Danmilko2.jpg'),
('DANMIK003', N'Sữa Danmilko Miniature 2 dinh dưỡng toàn diện cho bé 12-24 tháng', 'SB001', 'DM001', 680000, N'DanMilko Miniature Số 2... giúp bé phát triển toàn diện cả về thể chất và trí tuệ.', 100, '~/Hinh/Products/Danmilko3.jpg'),
('DANMIK002', N'Sữa Danmilko Miniature 1 dinh dưỡng toàn diện cho bé 0-12 tháng', 'SB001', 'DM001', 690000, N'Sản phẩm dinh dưỡng công thức dành cho trẻ từ 0-12 tháng tuổi Danmilko Miniature Số 1... bổ sung đầy đủ các dưỡng chất cần thiết cho sự phát triển toàn diện của trẻ.', 100, '~/Hinh/Products/Danmilko4.jpg'),
('DANMIK001', N'Sữa cho mẹ Danmilko Mamature 800g', 'SB001', 'DM001', 495000, N'Sữa bột bổ sung dinh dưỡng cho phụ nữ mang thai và cho con bú Mamature Mama Milk... giúp mẹ bầu khỏe mạnh và thai nhi phát triển toàn diện.', 100, '~/Hinh/Products/Danmilko5.jpg'),

('BALC03', N'Sữa Blackmores Úc Số 3 900g', 'SB001', 'BM001', 528000, N'Sữa Blackmores Toddler số 3 900g là công thức dinh dưỡng dành cho bé trên 12 tháng đến từ Úc. Công thức tối ưu trong Blackmores số 3 mang đến cho bé trong giai đoạn này sự hỗ trợ phát triển về chiều cao, cân nặng, bên cạnh đó là tăng cường hệ miễn dịch và phát triển trí não, nhận thức. Thành phần cân đối, giàu năng lượng, sản phẩm thích hợp để bổ sung cùng bữa ăn hàng ngày của bé, bổ sung cho cơ thể những khoáng chất, vitamin để đạt được sự phát triển toàn diện.', 100, '~/Hinh/Products/Blackmores1.jpg'),
('BALC02', N'Sữa Blackmores Úc Số 2 900g', 'SB001', 'BM001', 545000, N'Sữa Blackmores Follow-on số 2 900g dành cho bé từ 6 đến 12 tháng tuổi giúp bổ sung dinh dưỡng cho bé trong thời kỳ bắt đầu ăn dặm. Blackmores Follow-on tăng cường Canxi và vitamin D hỗ trợ phát triển chiều cao tối ưu, chứa I-ốt nuôi dưỡng chức năng nhận thức của bé trong giai đoạn này.', 100, '~/Hinh/Products/Blackmores2.jpg'),
('BALC01', N'Sữa Blackmores Úc Số 1 900g', 'SB001', 'BM001', 545000, N'Sữa Blackmores Newborn số 1 900g là sản phẩm dinh dưỡng nhập khẩu từ Úc, mang đến công thức cao năng lượng với 20 thành phần và 25 loại dưỡng chất cho bé trong giai đoạn từ 0 - 6 tháng.', 100, '~/Hinh/Products/Blackmores3.jpg'),

('APTAMILMO1', N'Sữa Aptamil NewZealand số 1 800g', 'SB001', 'AP001', 717000, N'Sữa Aptamil New Zealand số 1 900g dành cho bé dưới 12 tháng với công thức Synbiotic độc quyền cùng hàm lượng cao DHA tốt cho sự phát triển của não bộ cùng những dưỡng chất quan trọng.', 100, '~/Hinh/Products/Aptamil1.jpg'),
('APTAMILMO2', N'Sữa Aptamil NewZealand số 2 800g', 'SB001', 'AP001', 649000, N'Sữa Aptamil New Zealand số 2 800g (12-24 tháng) chứa đầy đủ bộ dưỡng chất Synbiotic, 16 Vitamins và khoáng chất giúp trẻ phát triển khỏe mạnh và hỗ trợ hệ miễn dịch.', 100, '~/Hinh/Products/Aptamil2.jpg'),
('APTAMILMO3', N'Sữa Aptakid NewZealand số 3 800g', 'SB001', 'AP001', 620000, N'Dựa trên 40 năm nghiên cứu về dinh dưỡng đầu đời cho trẻ, Aptamil 3 Growing Up Milk Formula MỚI, nhập khẩu từ New Zealand, dành cho bé trên 2 tuổi với công thức đặc biệt cung cấp đầy đủ dưỡng chất.', 100, '~/Hinh/Products/Aptamil3.jpg'),

('SLE01', N'Sữa Công Thức Ngôi Sao Nhỏ Little Étoile Số 1 (0-6 tháng)', 'SB001', 'LE001', 595000, N'Sữa Công thức Ngôi Sao Nhỏ Little Étoile Số 1 (0 - 6 tháng) dành cho bé sơ sinh có hàm lượng dinh dưỡng tối ưu, từ nguyên liệu cao cấp 100% sữa bò Úc nuôi cỏ.', 100, '~/Hinh/Products/LittleEtoile1.jpg'),
('SLE02', N'Sữa Công Thức Ngôi Sao Nhỏ Little Étoile Số 2 (6-12 tháng)', 'SB001', 'LE001', 668000, N'Sữa Công thức Ngôi Sao Nhỏ Little Étoile Số 2 (6 - 12 tháng) với nguyên liệu cao cấp, hàm lượng dinh dưỡng tối ưu cho sự phát triển của bé.', 100, '~/Hinh/Products/LittleEtoile2.jpg'),
('SLE03', N'Sữa Công Thức Ngôi Sao Nhỏ Little Étoile Số 3 (1-3 tuổi)', 'SB001', 'LE001', 668000, N'Sữa Công thức Ngôi Sao Nhỏ Little Étoile Số 3 cho trẻ từ 1 đến 3 tuổi cung cấp nguồn dinh dưỡng hoàn chỉnh.', 100, '~/Hinh/Products/LittleEtoile3.jpg'),
('SLE04', N'Sữa Công Thức Ngôi Sao Nhỏ Little Étoile Số 4 (2-6 tuổi)', 'SB001', 'LE001', 750000, N'Sữa bột Ngôi sao nhỏ Little Étoile số 4 (2-6 tuổi) 800g được làm từ nguyên liệu cao cấp, hàm lượng dinh dưỡng tối ưu vượt trội cho trẻ đang phát triển.', 100, '~/Hinh/Products/LittleEtoile4.jpg'),

('NEO001', N'Sữa bột NeoCare kids gold 900g (0-12 tháng) tặng 2 lọ yến sào khi mua 1 lon', 'SB001', 'NC001', 448000, N'Sữa NeoCare Kids Gold Nguồn bổ sung kháng thể tốt nhất giúp nâng cao và duy trì nền tảng miễn dịch khỏe mạnh đặc biệt cho bé sinh non.', 50, '~/Hinh/Products/NeoCare1.jpg'),
('NEO002', N'Sữa bột NeoCare bio kids 900g (6-36 tháng)', 'SB001', 'NC001', 428000, N'Giai đoạn từ 6 đến 36 tháng tuổi, là giai đoạn mà bé bắt đầu làm quen với ăn dặm và có hiện tượng mọc răng nên thường xuyên quấy khóc, sốt, tiêu chảy, bỏ bú,… Nhu cầu vận động của bé cũng tăng dần, bé yêu nhà bạn sẽ năng hoạt động hơn, khám phá thế giới xung quanh nên nhu cầu dinh dưỡng có rất nhiều sự thay đổi, đòi hỏi sự đáp ứng cao hơn. Do đó Sữa NEOCARE BIOKIS sẽ trợ giúp bé phát triển tốt trong giai đoạn này với sự cải tiến trong công thức để phù hợp với sự phát triển của trẻ trong giai đoạn từ 6 đến 36 tháng', 50, '~/Hinh/Products/NeoCare2.jpg'),
('NEO003', N'Sữa bột NeoCare pedia 900g (1-10 tuổi)', 'SB001', 'NC001', 398000, NULL, 50, '~/Hinh/Products/NeoCare3.jpg'),
('NEO004', N'Sữa bột NeoCare IQ grow 900g (1-18 tuổi)', 'SB001', 'NC001', 398000, N'Trẻ em là những thiên tài tiềm năng... vượt trội cho trẻ từ 1-15 tuổi.', 50, '~/Hinh/Products/NeoCare4.jpg'),
('NEO005', N'Sữa bột NeoCare weight gain 900g (1 tuổi trở lên)', 'SB001', 'NC001', 395000, N'Sữa bột NeoCare weight gain 900g (1 tuổi trở lên) là giòng sữa có #NĂNG_LƯỢNG_CAO giúp bé hấp thu tốt tăng cân, tăng đề kháng, lớn khỏe vượt trội.', 50, '~/Hinh/Products/NeoCare5.jpg'),
('NEO006', N'Sữa bột NeoCare mama plus 900g', 'SB001', 'NC001', 420000, N'NeoCare dành riêng công thức sữa cho mẹ bầu với đủ dưỡng chất trong lon Sữa bột NeoCare mama plus.', 50, '~/Hinh/Products/NeoCare6.jpg'),
('NEO007', N'Sữa bột NeoCare cerna plus 900g', 'SB001', 'NC001', 396000, N'NeoCare Cerna - giải pháp chuyên biệt cho người đái tháo đường, tiền đái tháo đường.', 50, '~/Hinh/Products/NeoCare7.jpg'),
('NEO008', N'Sữa bột NeoCare bone plus 900g', 'SB001', 'NC001', 380000, N'NEOCARE BONE TÁI TẠO SỤN KHỚP – GIÚP KHỚP DẺO DAI, LINH HOẠT!', 50, '~/Hinh/Products/NeoCare8.jpg'),
('NEO009', N'Sữa bột NeoCare sure gold 900g', 'SB001', 'NC001', 420000, N'Giúp phục hồi cơ thể bệnh nhân, tốt cho tim mạch, phục hồi sức khỏe tốt hơn.', 50, '~/Hinh/Products/NeoCare9.jpg'),
('NEO010', N'Sữa bột NeoCare goat''s baby 900g (0 - 12 tháng)', 'SB001', 'NC001', 480000, N'Hỗ trợ tối ưu hệ tiêu hóa: có hàm lượng chất xơ hòa tan FOS.', 50, '~/Hinh/Products/NeoCare10.jpg'),
('NEO011', N'Sữa bột NeoCare goats pedia 900g', 'SB001', 'NC001', 468000, N'Sữa NeoCare Goat''s Pedia là lựa chọn phù hợp cho trẻ biếng ăn, chậm lớn.', 50, '~/Hinh/Products/NeoCare11.jpg');


-- Dữ liệu đơn hàng
INSERT INTO Orders (OrderID, UserID, OrderDate, TotalAmount, Status)
VALUES 
('O001', 'U001', GETDATE(), 234000, N'Đã thanh toán');

-- Dữ liệu chi tiết đơn hàng
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price)
VALUES 
('OD001', 'O001', 'NEO011', 1, 468000),
('OD002', 'O001', 'NEO011', 2, 468000);
