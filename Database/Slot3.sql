-- Chọn database Sell_IceCream
USE Sell_IceCream;
GO

-- Nếu bảng Customer đã tồn tại thì xóa để tránh lỗi
IF OBJECT_ID('Customer', 'U') IS NOT NULL
    DROP TABLE Customer;
GO

-- Tạo bảng Customer
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(15) NOT NULL
);
GO

-- Thêm dữ liệu mẫu
INSERT INTO Customer (CustomerID, Name, Phone) VALUES
(1, N'Nguyễn Văn A', '0901234567'),
(2, N'Trần Thị B', '0912345678'),
(3, N'Lê Văn C', '0987654321'),
(4, N'Phạm Thị D', '0934567890'),
(5, N'Hoàng Văn E', '0945678901');
GO

-- Kiểm tra dữ liệu đã insert chưa
SELECT * FROM Customer;
