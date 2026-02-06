create database Grocery 
use Grocery 

create table Users
(
	UserID    int primary key  IDENTITY(1,1),
	FullName  nvarchar(35)   Not null,
	UserName  nvarchar(20)	Not null, 
	Password  nvarchar(30)	Not null,
	Phone	  nvarchar(11)	Not null,
	Email	  nvarchar(30),
	Status	  int	        Not null,
	Description	nvarchar(250)
);
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName NVARCHAR(50) NOT NULL,
    CustomerGender NVARCHAR(10) NOT NULL,
    CustomerPhone NVARCHAR(15),
    CustomerAddress NVARCHAR(100)
)
create table Categories
(
	CategoryID     int primary key IDENTITY(1,1),
	CategoryName   nvarchar(50)	  Not null,
	Description	   nvarchar(250)
);
create table Item 
(
ItemID int primary key IDENTITY(1,1),
ItemName nvarchar(50) not null,
ItemQuantity int not null,
ItemPrice int not null,
ItemCategoryID int Not null FOREIGN KEY REFERENCES Categories (CategoryID)
)

CREATE TABLE Bill (
    BillID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    BillDate DATETIME NOT NULL DEFAULT GETDATE(),
    TotalAmount INT NOT NULL,
    Status INT NOT NULL, -- 0: Đang xử lý, 1: Đã thanh toán, 2: Hủy
    Notes NVARCHAR(250)
);

CREATE TABLE BillDetails (
    BillDetailID INT PRIMARY KEY IDENTITY(1,1),
    BillID INT FOREIGN KEY REFERENCES Bill(BillID),
    ItemID INT FOREIGN KEY REFERENCES Item(ItemID),
    Quantity INT NOT NULL,
    Price INT NOT NULL, -- Đơn giá tại thời điểm bán
    Total INT 
);

INSERT INTO Users (FullName, UserName, Password, Phone, Email, Status, Description)
VALUES 
(N'Nguyễn Văn Thân', 'admin1', 'admin123', '0911222333', 'admin1@grocery.vn', 1, N'Admin hệ thống'),
(N'Lê Đình Văn', 'user1', 'user123', '0933444555', 'user1@grocery.vn', 1, N'Nhân viên bán hàng'),
(N'Lê Thanh Nga', 'user2', 'user123', '0933444533', 'user2@grocery.vn', 1, N'Nhân viên bán hàng');

INSERT INTO Employees (EmpName, EmpPhone, EmpAddress, EmpPass)
VALUES 
(N'Nguyễn Văn C', '0909123456', N'Hà Nội', '123456'),
(N'Trần Thị D', '0912345678', N'Hồ Chí Minh', '654321');

INSERT INTO Customers (CustomerName, CustomerGender, CustomerPhone, CustomerAddress)
VALUES
(N'Phạm Văn E', N'Nam', '0987654321', N'Hà Nội'),
(N'Lê Thị F', N'Nữ', '0977888999', N'Đà Nẵng');

INSERT INTO Categories (CategoryName, Description)
VALUES 
(N'Hải sản', N'Thực phẩm tươi sống từ biển'),
(N'Rau củ', N'Sản phẩm từ nông trại'),
(N'Nước giải khát', N'Nước uống các loại');

-- Giả sử ID danh mục: 1 - Hải sản, 2 - Rau củ, 3 - Nước giải khát
INSERT INTO Item (ItemName, ItemQuantity, ItemPrice, ItemCategoryID)
VALUES 
(N'Tôm Sú', 50, 50000, 1),
(N'Cá Hồi', 30, 70000, 1),
(N'Rau Muống', 100, 10000, 2),
(N'Bia Tiger', 200, 15000, 3);

-- Giả sử EmployeeID = 1, khách tên là "t"
INSERT INTO Bills (ClientName, EmployeeID, TotalAmount)
VALUES (N't', 1, 200000);  -- Tổng tạm thời (sẽ cập nhật lại sau)

-- Giả sử BillID = 1, ItemID dựa trên các mục bên trên
INSERT INTO BillDetails (BillID, ItemID, Quantity, Price)
VALUES 
(1, 1, 2, 50000),   -- Tôm Sú
(1, 2, 1, 70000);   -- Cá Hồi