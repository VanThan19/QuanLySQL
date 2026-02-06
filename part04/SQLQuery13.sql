create database SinhVien
use SinhVien 
CREATE TABLE SinhVien (
    id INT PRIMARY KEY,
    hoTen NVARCHAR(100) NOT NULL,
    queQuan NVARCHAR(100) NOT NULL
);
Create table Detai
(
MaDT int primary key,
TenDeTai nvarchar(50),
Diem int,
MaSV int foreign key references SinhVien(id)
)
INSERT INTO SinhVien VALUES
(1,N'Nguyễn Văn A', N'Hà Nội'),
(2,N'Trần Thị B', N'TP. Hồ Chí Minh')
Insert into SinhVien Values 
(3,N'Hoàng Minh Thắng',N'Lào Cai'),
(4,N'Nguyễn Trọng Mạnh',N'Yên Bái'),
(5,N'Nguyễn Trọng Nhì',N'Yên Bái')
INSERT INTO Detai VALUES
(101, N'Hệ thống quản lý', 85, 1),
(102, N'Nhận diện khuôn mặt', 90, 2),
(103, N'Ứng dụng chatbot', 88, 3),
(104, N'Đồ án trí tuệ nhân tạo', 92, 4),
(105, N'Quản lý bán hàng', 80, 5);
select * from SinhVien
Select * from DeTai Where MaSV=1 
