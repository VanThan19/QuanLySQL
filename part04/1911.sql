Create database TH06
USE TH06

create table tblNHACUNGCAP
(
	MaNhaCC char(6),
	TenNhaCC nvarchar(30),
	DiaChi nvarchar(30),
	SoDT bigint,
	MaSoThue bigint,
	primary key(MaNhaCC)
);
go
create table tblLOAIDICHVU
(
	MaLoaiDV char(4),
	TenLoaiDV nvarchar(100),
	primary key(MaLoaiDV)
);
go
create table tblDONGXE
(
	DongXe char(20),
	HangXe char(20),
	SoChoNgoi int,
	primary key(DongXe)
);
go
create table tblMUCPHI
(
	MaMP char(4),
	DonGia money,
	MoTa nvarchar(50),
	primary key(MaMP)
);

go
create table tblDANGKICUNGCAP
(
	MaDKCC char(5),
	MaNhaCC char(6),
	MaLoaiDV char(4),
	DongXe char(20),
	MaMP char(4),
	NgayBatDauCungCap date,
	NgayKetThucCungCap date,
	SoLuongXeDangKy int,
	primary key(MaDKCC),
	foreign key(MaNhaCC) references tblNHACUNGCAP (MaNhaCC),
	foreign key(MaLoaiDV) references tblLOAIDICHVU (MaLoaiDV),
	foreign key(MaMP) references tblMUCPHI (MaMP),
	foreign key(DongXe) references tblDONGXE (DongXe),
);
go
insert into tblNHACUNGCAP values
('NCC001',N'Cty TNHH Toàn Pháp','Hai Chau',05113999888,568941),
('NCC002',N'Cty Cổ Phần Đông Du','Lien Chieu',05113999889,456789),
('NCC003',N'Ông Nguyễn Văn A','Hoa Thuan',05113999890,321456),
('NCC004',N'Cty Cổ Phần Toàn Cầu Xanh','Hai Chau',05113658945,513364),
('NCC005',N'Cty TNHH AMA','Thanh Khe',0511375466,546546),
('NCC006',N'Bà Trần Thị Bích Vân','Lien Chieu',05113587469,524545),
('NCC007',N'Cty TNHH Phan Thành','Thanh Khe',05113997456,113021),
('NCC008',N'Ông Đình Phan Nam','Hoa Thuan',051135322456,121230),
('NCC009',N'Tập Đoàn ĐÔng Nam Á','Lien Chau',05113987121,533654),
('NCC010',N'Cty Cổ Phần Rạng Đông','Lien Chau',05113569654,187864)
go
insert into tblLOAIDICHVU values
('DV01',N'Dịch vụ xe taxi'),
('DV02',N'Dịch vụ xe buýt công cộng tuyến cố định'),
('DV03',N'Dịch vụ xe cho thuê xe theo hợp đồng')
go
insert into tblMUCPHI values 
('MP01',10000,N'Áp dụng từ 1/2015'),
('MP02',15000,N'Áp dụng từ 2/2015'),
('MP03',20000,N'Áp dụng từ 1/2010'),
('MP04',25000,N'Áp dụng từ 2/2011')
go
insert into tblDONGXE values 
('Hiace','Toyota',18),
('Vios','Toyota',5),
('Escape','Ford',5),
('Cerato','KIA',7),
('Forte','KIA',5),
('Starex','Huyndai',7),
('Grand-i10','Huyndai',7)
go
insert into tblDANGKICUNGCAP values 
('DK001','NCC001','DV01','Hiace','MP01','2015/11/20','2016/11/20',4),
('DK002','NCC002','DV02','Vios','MP02','2015/11/20','2017/11/20',3),
('DK003','NCC003','DV03','Escape','MP03','2017/11/20','2018/11/20',5),
('DK004','NCC005','DV01','Cerato','MP04','2015/11/20','2019/11/20',7),
('DK005','NCC002','DV02','Forte','MP03','2019/11/20','2020/11/20',1),
('DK006','NCC004','DV03','Starex','MP04','2016/11/10','2021/11/20',2),
('DK007','NCC005','DV01','Cerato','MP03','2015/11/30','2016/01/25',8),
('DK008','NCC006','DV01','Vios','MP02','2016/02/28','2016/06/15',9),
('DK009','NCC005','DV03','Grand-i10','MP02','2015/02/27','2017/04/30',10),
('DK010','NCC006','DV01','Forte','MP02','2015/11/22','2015/02/22',4),
('DK011','NCC007','DV01','Forte','MP01','2016/12/25','2017/11/22',5),
('DK012','NCC007','DV03','Cerato','MP01','2015/11/26','2016/11/20',6),
('DK013','NCC003','DV02','Cerato','MP01','2015/11/20','2017/11/20',8),
('DK014','NCC008','DV02','Cerato','MP01','2017/11/20','2018/11/20',1),
('DK015','NCC003','DV01','Hiace','MP02','2015/11/20','2019/11/20',6),
('DK016','NCC001','DV03','Grand-i10','MP02','2019/11/20','2020/11/20',8),
('DK017','NCC002','DV03','Cerato','MP03','2016/11/10','2021/11/20',4),
('DK018','NCC008','DV03','Escape','MP04','2015/11/30','2016/01/25',2),
('DK019','NCC003','DV03','Escape','MP03','2016/02/28','2016/08/15',8),
('DK020','NCC002','DV03','Cerato','MP04','2015/04/27','2017/04/30',7),
('DK021','NCC006','DV01','Forte','MP02','2015/11/25','2016/02/22',9),
('DK022','NCC002','DV02','Cerato','MP04','2016/12/25','2017/02/20',6),
('DK023','NCC002','DV01','Forte','MP03','2015/04/27','2017/04/30',5),
('DK024','NCC003','DV03','Forte','MP04','2015/11/21','2016/02/20',8),
('DK025','NCC003','DV03','Hiace','MP02','2016/12/26','2017/02/26',1)
-- Câu 3: Liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ
Select * from TblDongXe where TblDongXe.SoChoNgoi > 5 
-- Câu 4: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp những dòng xe thuộc hãng xe "Toyota" với mức phí có đơn
-- giá là 15.000 VNĐ/km hoặc những dòng xe thuộc hãng xe "KIA" với mức phí có đơn giá là 20.000 VNĐ/km
SELECT DISTINCT NCC.* FROM tblNHACUNGCAP NCC
JOIN tblDANGKICUNGCAP DK ON NCC.MaNhaCC = DK.MaNhaCC
JOIN tblDONGXE DX ON DK.DongXe = DX.DongXe
JOIN tblMUCPHI MP ON DK.MaMP = MP.MaMP
WHERE (DX.HangXe = 'Toyota' AND MP.DonGia = 15000)
   OR (DX.HangXe = 'KIA' AND MP.DonGia = 20000);
-- Câu 5: Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên nhà cung cấp và giảm dần theo mã số thuế
SELECT *FROM tblNHACUNGCAP ORDER BY TenNhaCC ASC, MaSoThue DESC;
-- Câu 6: Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung cấp với yêu cầu chỉ đếm cho những nhà cung cấp thực 
-- hiện đăng ký cung cấp có ngày bắt đầu cung cấp là "20/11/2015"
SELECT NCC.MaNhaCC, NCC.TenNhaCC, COUNT(DK.MaDKCC) AS SoLanDangKy
FROM tblNHACUNGCAP NCC
JOIN tblDANGKICUNGCAP DK ON NCC.MaNhaCC = DK.MaNhaCC
WHERE DK.NgayBatDauCungCap = '2015-11-20'
GROUP BY NCC.MaNhaCC, NCC.TenNhaCC;
-- Câu 7: Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe chỉ được liệt kê một lần
SELECT DISTINCT HangXe FROM tblDONGXE;
-- Câu 8: Liệt kê MaDKCC, MaNhaCC, TenNhaCC, DiaChi, MaSoThue, TenLoaiDV, DonGia, HangXe, NgayBatDauCC, NgayKetThucCC của tất cả 
-- các lần đăng ký cung cấp phương tiện với yêu cầu những nhà cung cấp nào chưa từng thực hiện đăng ký cung cấp phương tiện thì 
-- cũng liệt kê thông tin những nhà cung cấp đó ra
SELECT DK.MaDKCC, NCC.MaNhaCC, NCC.TenNhaCC, NCC.DiaChi, NCC.MaSoThue,
       DV.TenLoaiDV, MP.DonGia, DX.HangXe, DK.NgayBatDauCungCap, DK.NgayKetThucCungCap
FROM tblNHACUNGCAP NCC
LEFT JOIN tblDANGKICUNGCAP DK ON NCC.MaNhaCC = DK.MaNhaCC
LEFT JOIN tblLOAIDICHVU DV ON DK.MaLoaiDV = DV.MaLoaiDV
LEFT JOIN tblMUCPHI MP ON DK.MaMP = MP.MaMP
LEFT JOIN tblDONGXE DX ON DK.DongXe = DX.DongXe;
-- Câu 9: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp phương tiện thuộc dòng xe "Hiace" hoặc từng đăng ký cung cấp
-- phương tiện thuộc dòng xe "Cerato"
SELECT DISTINCT NCC.* FROM tblNHACUNGCAP NCC JOIN tblDANGKICUNGCAP DK ON NCC.MaNhaCC = DK.MaNhaCC 
WHERE DK.DongXe IN ('Hiace', 'Cerato');
-- Câu 10: Liệt kê thông tin của các nhà cung cấp chưa từng thực hiện đăng ký cung cấp phương tiện lần nào cả
SELECT NCC.* FROM tblNHACUNGCAP NCC LEFT JOIN tblDANGKICUNGCAP DK ON NCC.MaNhaCC = DK.MaNhaCC WHERE DK.MaDKCC IS NULL;

--Ðề 2:
create database giaohang;
use giaohang;
create table loaimathang (
   maloaimathang char(10) primary key,
   tenloaimathang nvarchar(50)
);
create table khoangthoigian (
   makhoangthoigian char(10) primary key,
   mota nvarchar(100)
);
create table khuvuc (
   makhuvuc char(10) primary key,
   tenkhuvuc nvarchar(50)
);
create table khachhang (
   makhachhang char(10) primary key,
   makhuvuc char(10) foreign key references khuvuc(makhuvuc),
   tenkhachhang nvarchar(60),
   tencuahang nvarchar(60),
   sodtkhachhang varchar(15),
   diachiemail nvarchar(200),
   diachinhanhang nvarchar(200)
);
create table dichvu (
   madichvu char(10) primary key,
   tendichvu nvarchar(100)
);
create table thanhviengiaohang (
   mathanhviengiaohang char(10) primary key,
   tenthahnhviengiaohang nvarchar(100),
   ngaysinh date,
   gioitinh nvarchar(10),
   sodtthanhvien varchar(15),
   diachithanhvien nvarchar(255)
);
create table dangky_giaohang (
   mathanhviengiaohang char(10),
   makhoangthoigiandkgiaohang char(10),
   primary key (mathanhviengiaohang, makhoangthoigiandkgiaohang),
   foreign key (mathanhviengiaohang) references thanhviengiaohang(mathanhviengiaohang),
   foreign key (makhoangthoigiandkgiaohang) references khoangthoigian(makhoangthoigian)
);
create table donhang_giaohang (
   madonhanggiaohang char(10) primary key,
   makhachhang char(10) foreign key references khachhang(makhachhang),
   mathanhviengiaohang char(10) foreign key references thanhviengiaohang(mathanhviengiaohang),
   madichvu char(10) foreign key references dichvu(madichvu),
   makhuvucgiaohang char(10) foreign key references khuvuc(makhuvuc),
   tennguoinhan nvarchar(50),
   diachigiaohang nvarchar(50),
   sodtnguoinhan char(15),
   makhoangthoigiangiaohang char(10) foreign key references khoangthoigian(makhoangthoigian),
   ngaygiaohang date,
   phuongthucthanhtoan nvarchar(50),
   trangthaipheduyet nvarchar(50),
   trangthaigiaohang nvarchar(50)
);
create table chitiet_donhang ( 
   madonhanggiaohang char(10),
   tensanphamduocgiao nvarchar(100),
   soluong int,
   trongluong float,
   maloaimathang char(10) foreign key references loaimathang(maloaimathang),
   tienthuho float,
   primary key (madonhanggiaohang, tensanphamduocgiao),
   foreign key (madonhanggiaohang) references donhang_giaohang(madonhanggiaohang)
);

insert into loaimathang values
('MH001', 'Quan ao'),
('MH002', 'My pham'),
('MH003', 'Do gia dung'),
('MH004', 'Do dien tu');
insert into khuvuc values
('KV001', 'Son Tra'),
('KV002', 'Lien Chieu'),
('KV003', 'Ngu Hanh Son'),
('KV004', 'Hai Chau');
insert into khoangthoigian values
('TG001', '7h - 9h AM'),
('TG002', '9h - 11h AM'),
('TG003', '1h - 3h PM'),
('TG004', '3h - 5h PM'),
('TG005', '7h - 9:30h PM');
insert into dichvu values
('DV001', 'Giao hang nguoi nhan tra tien phi'),
('DV002', 'Giao hang nguoi gui tra tien phi'),
('DV003', 'Giao hang cong ich (khong tinh phi)');
insert into thanhviengiaohang values
('TV001', 'Nguyen Van A', '1995-11-20', 'Nam', '0905111111', '23 Ong Ich Khiem'),
('TV002', 'Nguyen Van B', '1992-11-26', 'Nu', '0905111112', '234 Ton Duc Thang'),
('TV003', 'Nguyen Van C', '1990-11-30', 'Nu', '0905111113', '45 Hoang Dieu'),
('TV004', 'Nguyen Van D', '1995-07-08', 'Nam', '0905111114', '23/33 Ngu Hanh Son'),
('TV005', 'Nguyen Van E', '1991-02-04', 'Nam','0905111115', '56 Dinh Thi Dieu');
insert into dangky_giaohang values
('TV001', 'TG004'),
('TV002', 'TG005'),
('TV003', 'TG001'),
('TV003', 'TG002'),
('TV003', 'TG003');
insert into khachhang values
('KH001', 'KV001', 'Le Thi A', 'Cua hang 1', '0987456852', 'alethi@gmail.com', '80 Pham Phu Thai'),
('KH002', 'KV001', 'Nguyen Van B', 'Cua hang 2', '0987456853', 'bvannv@gmail.com', '100 Phan Tu'),
('KH003', 'KV002', 'Le Thi C', 'Cua hang 5', '0987456854', 'choangthi@gmail.com', '23 An Thuong'),
('KH004', 'KV002', 'Nguyen Van D', 'Cua hang 4', '0987456855', 'dtranba@gmail.com', '67 Ngo The Thai'),
('KH005', 'KV001', 'Le Thi E', 'Cua hang 5', '0987456856', 'ecaoith@gmail.com', '100 Chau Thi Vinh');

insert into donhang_giaohang values
('DH001', 'KH001', 'TV001', 'DV001', 'KV001', 'Pham Van A', '30 Hoang Van Thu', '0974214521', 'TG004', '2016-10-10', 'Tien mat', 'Da phe duyet', 'Da giao hang'),
('DH002', 'KH002', 'TV002', 'DV002', 'KV002', 'Le Dinh Ly', '234 An Duong Vuong', '0974214522', 'TG005', '2016-12-23', 'Tien mat','Da phe duyet', 'Chua giao hang'),
('DH003', 'KH003', 'TV003', 'DV001', 'KV003', 'Nguyen Van C', '23 Le Dinh Duong', '0974214523', 'TG001', '2017-04-08', 'Chuyen khoan','Da phe duyet', 'Da giao hang'),
('DH004', 'KH004', 'TV003', 'DV002', 'KV003', 'Nguyen Van D', '23/33 Ngu Hanh Son', '0974214524', 'TG002', '2015-11-01', 'Chuyen khoan','Da phe duyet', 'Da giao hang'),
('DH005', 'KH005', 'TV005', 'DV003', 'KV003', 'Pham Van E', '78 Hoang Dieu', '0974214525', 'TG003', '2017-04-04', 'Chuyen khoan','Chua phe duyet', NULL);
insert into chitiet_donhang values
('DH001', 'Ao len', 2, 0.5, 'MH001', 200000),
('DH001', 'Quan ao', 1, 0.25, 'MH001', 350000),
('DH002', 'Ao thun', 2, 0.25, 'MH001', 1000000),
('DH002', 'Ao khoac', 4, 0.25, 'MH001', 2000000),
('DH003', 'Sua duong the', 3, 0.25, 'MH002', 780000),
('DH003', 'Kem tay da chet', 2, 0.5, 'MH002', 150000),
('DH003', 'Kem duong ban dem', 4, 0.25, 'MH002', 900000);
--1)
delete from chitiet_donhang
where madonhanggiaohang in (select madonhanggiaohang from donhang_giaohang
where makhachhang = (select makhachhang from khachhang where tenkhachhang = 'Le Thi A')
)
delete from donhang_giaohang
where makhachhang = (select makhachhang from khachhang where tenkhachhang = 'Le Thi A')
delete from khachhang
where tenkhachhang = 'Le Thi A';
--2)
update khachhang
set makhuvuc=(select makhuvuc from khuvuc where tenkhuvuc='ngu hanh son')
where makhuvuc=(select makhuvuc from khuvuc where tenkhuvuc='son tra')
--3)
select *from thanhviengiaohang
where tenthahnhviengiaohang like 'Tr%' and len(tenthahnhviengiaohang)>=25
--4)
select *from donhang_giaohang
where year(ngaygiaohang)='2017' and makhuvucgiaohang=(select makhuvuc from khuvuc where tenkhuvuc='hai chau')
--5)
select a.madonhanggiaohang, a.mathanhviengiaohang, b.tenthahnhviengiaohang, a.ngaygiaohang, a.phuongthucthanhtoan
from donhang_giaohang a
JOIN thanhviengiaohang b on a.mathanhviengiaohang = b.mathanhviengiaohang
where a.trangthaigiaohang = 'Da giao hang'
order by a.ngaygiaohang asc, a.phuongthucthanhtoan desc;
--6)
select *
from thanhviengiaohang
where gioitinh = 'Nam' and mathanhviengiaohang not in (select distinct mathanhviengiaohang from donhang_giaohang);
--7)
select distinct tenkhachhang from khachhang
select tenkhachhang from khachhang
group by tenkhachhang
--8)
select a.makhachhang, a.tenkhachhang, b.diachigiaohang, b.madonhanggiaohang, b.phuongthucthanhtoan, b.trangthaigiaohang
from khachhang a
left join donhang_giaohang b on a.makhachhang = b.makhachhang;
--9)
select a.*
from thanhviengiaohang a
join donhang_giaohang b on a.mathanhviengiaohang = b.mathanhviengiaohang
where a.gioitinh= 'Nu'and b.makhuvucgiaohang = (select makhuvuc from khuvuc where tenkhuvuc = 'Hai Chau')
group by a.mathanhviengiaohang, a.tenthahnhviengiaohang, a.ngaysinh, a.gioitinh, a.sodtthanhvien, a.diachithanhvien
having count(distinct makhachhang) >= 10;
--10)
select distinct a.*
from khachhang a
join donhang_giaohang b on a.makhachhang = b.makhachhang
where b.makhuvucgiaohang = (select makhuvuc from khuvuc where tenkhuvuc = 'Lien Chieu')
and b.mathanhviengiaohang not in (select mathanhviengiaohang FROM thanhviengiaohang WHERE gioitinh = 'Nam');