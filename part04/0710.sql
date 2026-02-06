Create database HDThucTap
Use HDThucTap


Create Table TblGiangVien 
(
maGv int primary key ,
hoTen nvarchar(30),
boMon nvarchar (30)
)

Create Table TblSinhVien
(
maSv int primary key ,
hoTen nvarchar(30),
namSinh int ,
queQuan nvarchar(30)
)

Create Table TblDeTai
(
maDt char(10) primary key,
tenDt char(30),
kinhPhi decimal (10,2)
)

Create Table TblHuongDan 
(
maSV1 int foreign key References TblSinhVien(maSv),
maDt1 char(10) foreign key References TblDeTai(maDt),
maGv1 int foreign key References TblGiangVien(maGv),
ketQua decimal (5,2)
)

-- Bảng Giảng Viên 
Insert into TblGiangVien values (1001,N'Lê Giáp',N'Hệ Thống Thông Tin')
Insert into TblGiangVien values (1002,N'Trần Ất',N'Khoa Học Máy Tính')
Insert into TblGiangVien values (1003,N'Bùi Bình',N'Mạng Và Truyền Thông')
Insert into TblGiangVien values (1004,N'Phan Đinh',N'Kỹ Thuật Phần Mềm')
Insert into TblGiangVien values (1005,N'Nguyễn Mẫu',N'Hệ Thống Thông Tin')

-- Bảng Sinh Viên 
Insert into TblSinhVien values (1,N'Lê Văn Xuân',1990,N'Nghệ An')
Insert into TblSinhVien values (2,N'Trần Nguyên Hạ',1990,N'Thanh Hóa')
Insert into TblSinhVien values (3,N'Bùi Xuân Thu',1992,N'Nghệ An')
Insert into TblSinhVien values (4,N'Phan Tuấn Đông',null,N'Hà Tĩnh')
Insert into TblSinhVien values (5,N'Lê Thanh Xuân',1989,N'Hà Nội')
Insert into TblSinhVien values (6,N'Nguyễn Thu Hạ',1991,N'Thanh Hóa')
Insert into TblSinhVien values (7,N'Trần Xuân Tây',null,N'Hà Tĩnh')
Insert into TblSinhVien values (8,N'Hoàng Long Nam',1992,N'Nam Định')

-- Bảng Đề Tài 
Insert into TblDeTai values ('DT01','Semantic web',100)
Insert into TblDeTai values ('DT02','Cloud computing',500)
Insert into TblDeTai values ('DT03','Machine learning',100)
Insert into TblDeTai values ('DT04','Data mining',300)

-- Bảng Hướng Dẫn 
Insert into TblHuongDan values (1,'DT01',1001,7.5)
Insert into TblHuongDan values (2,'DT02',1002,6.5)
Insert into TblHuongDan values (3,'DT03',1003,8.5)
Insert into TblHuongDan values (4,'DT04',1004,7.5)
Insert into TblHuongDan values (5,'DT02',1003,4.5)
Insert into TblHuongDan values (6,'DT03',1001,5.5)
Insert into TblHuongDan values (7,'DT01',1004,3.5)

Select *from TblSinhVien t join TblHuongDan h on t.maSv = h.maSV1