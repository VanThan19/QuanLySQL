create database Bai2
go
use bai2
go
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

-- Đề 1 :
-- Câu 6: Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên nhà cung cấp và giảm dần
-- theo mã số thuế (0.5 điểm)
select * from tblNHACUNGCAP c order by  c.TenNhaCC , c.MaSoThue  DESC 
-- Câu 7: Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung cấp với yêu cầu chỉ đếm cho 
-- những nhà cung cấp thực hiện đăng ký cung cấp có ngày bắt đầu cung cấp là "20/11/2015" (0.5 điểm)
select n.TenNhaCC,c.NgayBatDauCungCap ,count(*) [Count] from tblDANGKICUNGCAP c join tblNHACUNGCAP n on c.MaNhaCC = n.MaNhaCC 
        where c.NgayBatDauCungCap = '2015/11/20' group by n.TenNhaCC, c.NgayBatDauCungCap
-- Câu 8: Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe chỉ được liệt kê một lần (0.5 điểm)
select Distinct hangXe from tblDONGXE 
-- Câu 9: Liệt kê MaDKCC, TenLoaiDV, TenNhaCC, DonGia, DongXe, HangXe, NgayBatDauCC, NgayKetThucCC, SoLuongXeDangKy 
--của tất cả các lần đăng ký cung cấp phương tiện (0.5 điểm)
select dk.MaDKCC,dv.TenLoaiDV,cc.TenNhaCC,mp.DonGia,x.DongXe,x.HangXe,dk.NgayBatDauCungCap,dk.NgayKetThucCungCap,dk.SoLuongXeDangKy
from tblDANGKICUNGCAP dk join tblLOAIDICHVU dv on dk.MaLoaiDV = dv.MaLoaiDV join tblNHACUNGCAP cc on dk.MaNhaCC = cc.MaNhaCC
join tblDONGXE x on dk.DongXe = x.DongXe join tblMUCPHI mp on dk.MaMP = mp.MaMP 

CREATE DATABASE TH4; 
go
use TH4
go
CREATE TABLE tblMUAPHUCVU 
( 
    MaMuaPhucVu CHAR(4) PRIMARY KEY, 
    TenMua VARCHAR(20), 
    MoTa VARCHAR(255) 
); 
go
CREATE TABLE tblKHACHHANG 
( 
    MaKhachHang CHAR(5) PRIMARY KEY, 
    TenKhachHang VARCHAR(15), 
    Email VARCHAR(25), 
    SoDT CHAR(10), 
    DiaChiGiaoHang VARCHAR(30) 
); 
go
CREATE TABLE tblDANHMUC_DICHVU 
( 
    MaDichVu CHAR(4) PRIMARY KEY, 
    TenDichVu VARCHAR(15) 
); 
go
CREATE TABLE tblMON_AN_UONG 
( 
    MaMonAn_Uong CHAR(5) PRIMARY KEY, 
    MaMuaPhucVu CHAR(4) FOREIGN KEY REFERENCES tblMUAPHUCVU (MaMuaPhucVu), 
    MaDichVu CHAR(4) FOREIGN KEY REFERENCES tblDANHMUC_DICHVU (MaDichVu), 
    TenMonAn_Uong VARCHAR(20), 
    ChiTietMonAn_Uong VARCHAR(20), 
    DonVi VARCHAR(10), 
    DonGia MONEY, 
    TrangThaiHang CHAR(8) 
); 
go
CREATE TABLE tblDONHANG 
( 
    MaDonHang CHAR(6) PRIMARY KEY, 
    MaKhachHang CHAR(5) FOREIGN KEY REFERENCES tblKHACHHANG(MaKhachHang), 
	ThoiGianNhanHang DATETIME, 
    PhuongThucThanhToan VARCHAR(12), 
    TrangThaiGiaoHang VARCHAR(9) 
); 
go
CREATE TABLE tblCHITIET_DONHANG 
( 
    MaDonHang CHAR(6), 
    MaMonAn_Uong CHAR(5), 
    SoLuong INT, 
    PRIMARY KEY(MaDonHang, MaMonAn_Uong), 
	FOREIGN KEY (MaDonHang) REFERENCES tblDONHANG(MaDonHang),
	FOREIGN KEY (MaMonAn_Uong) REFERENCES tblMON_AN_UONG(MaMonAn_Uong)
); 
go
-- Nhập dữ liệu 
INSERT INTO tblKHACHHANG 
VALUES 
    ('KH001', 'Le Thi A', 'alethi@gmail.com', '0905111111', '80 Pham Phu Thai'), 
    ('KH002', 'Nguyen Van B', 'bnguyenvan@gmail.com', '0905111112', '100 Phan Tu'), 
    ('KH003', 'Le Thi B', 'blethi@gmail.com', '0905111113', '23 An Thuong 18'), 
    ('KH004', 'Nguyen Van C', 'cnguyenvan@gmail.com', '0905111114', '67 Ngo The Thai'), 
    ('KH005', 'Le Thi D', 'dlethi@gmail.com', '0905111115', '100 Chau Thi Vinh Tre'); 
go
INSERT INTO tblMUAPHUCVU 
VALUES 
    ('PV01', 'Word cup', ''), 
    ('PV02', 'Ngay le 2-9/30-4/1-5', ''), 
    ('PV03', 'Ngay Tet', ''), 
    ('PV04', 'Ngay thuong', ''); 
go
INSERT INTO tblDANHMUC_DICHVU 
VALUES 
    ('DV01', 'Thuc an nhanh'), 
    ('DV02', 'Thuc an no'), 
    ('DV03', 'Do uong'); 
go
INSERT INTO tblMON_AN_UONG 
VALUES 
    ('M0001', 'PV01', 'DV01', 'goi mi cay', 'mi, ot, muc', 'dia', 100000, 'con hang'), 
    ('M0002', 'PV01', 'DV02', 'com chien trung', 'com, trung, hanh', 'dia', 50000, 'con hang'), 
    ('M0003', 'PV02', 'DV01', 'tom chien su', 'tom, bot', 'dia', 150000, 'con hang'), 
    ('M0004', 'PV02', 'DV03', 'yaout pho mai', 'sua, pho mai', 'ly', 20000, 'con hang'), 
    ('M0005', 'PV03', 'DV03', 'co dam', 'coc, duong, nuoc', 'ly', 15000, 'con hang'); 
go
INSERT INTO tblDONHANG 
VALUES 
    ('DH0001', 'KH001', '2017-11-20 8:33', 'tien mat', 'da giao'), 
    ('DH0002', 'KH001', '2017-8-4 11:15', 'chuyen khoan', 'da giao'), 
    ('DH0003', 'KH002', '2016-7-10 12:00', 'tien mat', 'da giao'), 
    ('DH0004', 'KH003', '2017-5-5 11:45', 'chuyen khoan', 'da giao'), 
    ('DH0005', 'KH004', '2017-11-3 17:00', 'tien mat', 'da giao'); 
go
INSERT INTO tblCHITIET_DONHANG 
VALUES 
    ('DH0001', 'M0001', 5), 
    ('DH0001', 'M0002', 10), 
    ('DH0002', 'M0001', 3), 
    ('DH0002', 'M0002', 8), 
    ('DH0002', 'M0003', 7), 
    ('DH0002', 'M0004', 1); 

-- Đề 2 :
-- Câu 5: Liệt kê thông tin MaKhachHang, số lượng đơn hàng mà khách hàng đã đặt tương ứng. Kết quả được sắp
-- xếp tăng dần theo số lượng đơn hàng tương ứng và giảm dần theo MaKhachHang. (1 điểm)
SELECT dh.MaKhachHang, COUNT(dh.MaDonHang) AS SoLuongDonHang
FROM tblDONHANG dh GROUP BY dh.MaKhachHang
ORDER BY SoLuongDonHang ASC, dh.MaKhachHang DESC

CREATE DATABASE LAYLOIHOI;
go
use LAYLOIHOI
go
CREATE TABLE tblPHONG
(
    MaPhong CHAR(5) PRIMARY KEY,
    LoaiPhong VARCHAR(10),
    SoKhoachToiDa INT,
    GiaPhong MONEY,
    MoTa VARCHAR(256)
)
go

CREATE TABLE tblKHACH_HANG
(
    MaKH CHAR(6) PRIMARY KEY,
    TenKH VARCHAR(15),
    DiaChi VARCHAR(15),
    SoDT CHAR(10)
)

go
CREATE TABLE tblDICH_VU_DI_KEM
(
    MaDV CHAR(5) PRIMARY KEY,
    TenDV VARCHAR(15),
    DonViTinh CHAR(3),
    DonGia MONEY
)

go
CREATE TABLE tblDAT_PHONG
(
    MaDatPhong CHAR(6) PRIMARY KEY,
    MaPhong CHAR(5) FOREIGN KEY REFERENCES tblPHONG(MaPhong),
    MaKH CHAR(6) FOREIGN KEY REFERENCES tblKHACH_HANG(MaKH),
    NgayDat DATE,
    GioBatDau TIME,
    GioKetThuc TIME,
    TienDatCoc MONEY,
    GhiChu VARCHAR(256),
    TrangThaiDat CHAR(6)
)
go

CREATE TABLE tblCHI_TIET_SU_SUNG_DICH_VU
(
    MaDatPhong CHAR(6),
    MaDV CHAR(5),
    SoLuong INT
        PRIMARY KEY(MaDatPhong, MaDV),
    FOREIGN KEY(MaDatPhong) REFERENCES tblDAT_PHONG(MaDatPhong),
    FOREIGN KEY(MaDV) REFERENCES tblDICH_VU_DI_KEM(MaDV)
)
go


INSERT INTO tblPHONG
VALUES
    ('P0001', 'LOAI 1', 20, 60000, ''),
    ('P0002', 'LOAI 1', 25, 80000, ''),
    ('P0003', 'LOAI 2', 15, 50000, ''),
    ('P0004', 'LOAI 3', 20, 50000, '')

go
INSERT INTO tblKHACH_HANG
VALUES
    ('KH0001', 'Nguyen Van A', 'Hoa xuan', '1111111111'),
    ('KH0002', 'Nguyen Van B', 'Hoa hai', '1111111112'),
    ('KH0003', 'Phan Van A', 'Cam le', '1111111113'),
    ('KH0004', 'Phan Van B', 'Hoa xuan', '1111111114')

go
INSERT INTO tblDICH_VU_DI_KEM
VALUES
    ('DV001', 'Beer', 'lon', 10000),
    ('DV002', 'Nuoc ngot', 'lon', 10000),
    ('DV003', 'Trai cay', 'dia', 10000),
    ('DV004', 'Khan uot', 'cai', 10000)

go
INSERT INTO tblDAT_PHONG
VALUES
    ('DP0001', 'P0001', 'KH0002', '2018-03-26', '11:00', '13:30', 100000, '', 'Da dat'),
    ('DP0002', 'P0002', 'KH0003', '2018-03-27', '17:15', '19:15', 50000, '', 'Da huy'),
    ('DP0003', 'P0003', 'KH0002', '2018-03-26', '20:30', '22:15', 100000, '', 'Da dat'),
    ('DP0004', 'P0004', 'KH0001', '2018-04-01', '19:30', '21:15', 200000, '', 'Da dat')

go
INSERT tblCHI_TIET_SU_SUNG_DICH_VU
VALUES
    ('DP0001', 'DV001', 20),
    ('DP0001', 'DV003', 3),
    ('DP0001', 'DV002', 10),
    ('DP0002', 'DV002', 10),
    ('DP0002', 'DV003', 1),
    ('DP0003', 'DV003', 2),
    ('DP0003', 'DV004', 10)

-- Đề 3 :
-- Câu 8: Hiển thị MaDatPhong, MaPhong, LoaiPhong, GiaPhong, TenKH, NgayDat, TongTienHat, TongTienSuDungDichVu,
-- TongTienThanhToan tương ứng với từng mã đặt phòng có trong bảng DAT_PHONG. Những đơn đặt phòng nào không
--sử dụng dịch vụ đi kèm thì cũng liệt kê thông tin của đơn đặt phòng đó ra. (1 điểm)

--TongTienHat = GiaPhong * (GioKetThuc – GioBatDau) 
--TongTienSuDungDichVu = SoLuong * DonGia
--TongTienThanhToan = TongTienHat + sum (TongTienSuDungDichVu)
Select dp.MaDatPhong,p.MaPhong,p.LoaiPhong,p.GiaPhong,kh.TenKH,dp.NgayDat,
(p.GiaPhong * DATEDIFF(HOUR, dp.GioBatDau, dp.GioKetThuc)) AS TongTienHat,
 COALESCE(SUM(ctdv.SoLuong * dv.DonGia), 0) AS TongTienSuDungDichVu,
    ((p.GiaPhong * DATEDIFF(HOUR, dp.GioBatDau, dp.GioKetThuc)) + COALESCE(SUM(ctdv.SoLuong * dv.DonGia), 0)) AS TongTienThanhToan

from tblDAT_PHONG dp join tblPHONG p on dp.MaPhong = p.MaPhong 
join tblKHACH_HANG kh on kh.MaKH = dp.MaKH 
left join tblCHI_TIET_SU_SUNG_DICH_VU ctdv on ctdv.MaDatPhong = dp.MaDatPhong
left join tblDICH_VU_DI_KEM dv on dv.MaDV = ctdv.MaDV
group by dp.MaDatPhong, 
    p.MaPhong, 
    p.LoaiPhong, 
    p.GiaPhong, 
    kh.TenKH, 
    dp.NgayDat, 
    dp.GioBatDau, 
    dp.GioKetThuc

create database vatnuoi05
go
use vatnuoi05
go
create table tblloaivatnuoi(
       MaLoaiVN char(5),
       TenLoaiVN char(10),
       MoTa nvarchar(250),
       primary key (MaLoaiVN)
)
go
create table tblChuSoHuu (
       MaChuSH char(5),
       TenChuSh nvarchar(20),
       DiaChi nvarchar(20),
       SoDT char(11),
       primary key (MaChuSH)
)
go
create table tblVatNuoi
(
       MaVn char(5) primary key,
       MaChuSH char(5) ,
       MaLoaiVN char(5),
	   TenLoaiVN nvarchar(20),
       GioiTinh char(3),
       foreign key (MaChuSH) references tblChuSoHuu (MaChuSH),
       foreign key (MaLoaiVN) references tblloaivatnuoi (MaLoaiVN)
)
go
create table tblVacXin (
       MaVX char(5),
       TenVx nvarchar(10),
       PhongBenh nvarchar(20),
       DieuKienTiem nvarchar(20),
       LieuTrinh int,
       LieuLuong float,
       primary key (MaVX)

)
go
create table tblCosoTiem(
       MaCS char(5),
       TenCS nvarchar(5),
       primary key (MaCS)
)
go
create table tblSoTheoDoi_TiemVX(
       MaSoTD char(6),
       MaVN char(5),
       MaVX char(5),
       MaCS char(5),
       NgayTiem date,
       MuiTiem int,
       CanNang float,
       BenhLy nvarchar(20),
       NgayHenlansau date,
       primary key (MaSoTD ),
       foreign key (MaVN) references tblVatNuoi (MaVN),
       foreign key (MaVX) references  tblVacXin (MaVX),
       foreign key (MaCS) references tblCosoTiem(MaCS)

)
go
insert into tblloaivatnuoi values
('LVN01' ,'CHO', 'DONG VAT AN THIT'),
('LVN02' ,'MEO', 'DONG VAT THUAN CHUNG'),
('LVN03' ,'CHUOT', 'DONG VAT NHO'),
('LVN04' ,'CHIM', 'DONG VAT CO CANH'),
('LVN05' ,'SOC', 'DONG VAT NHO')
go
insert into tblChuSoHuu values
('SH001' ,'CHU SO HUU 1', 'HOA HAI','0905111111'),
('SH002' ,'CHU SO HUU 2', 'HOA LONG','0905111112'),
('SH003' ,'CHU SO HUU 3', 'HOA CAT','0905111113'),
('SH004' ,'CHU SO HUU 4', 'HOA PHUONG','0905111114'),
('SH005' ,'CHU SO HUU 5', 'HOA HA','0905111115'),
('SH006' ,'CHU SO HUU 6', 'HOA XUAN','0905111116'),
('SH007' ,'CHU SO HUU 7', 'THANH KHE','0905111117'),
('SH008' ,'CHU SO HUU 8', 'HOA XUAN','0905111118'),
('SH009' ,'CHU SO HUU 9', 'CAM LE','0905111119'),
('SH010' ,'CHU SO HUU 10', 'HOA HAI','0905111120')
go
insert into tblVatNuoi values
('VN001' ,'SH001' ,'LVN01',N'Gà','DUC'),
('VN002' ,'SH001' ,'LVN01',N'Ngan','CAI'),
('VN003' ,'SH003' ,'LVN01',N'Bò','DUC'),
('VN004' ,'SH004' ,'LVN01',N'Chó','CAI'),
('VN005' ,'SH004' ,'LVN02',N'Bồ câu','DUC'),
('VN006' ,'SH004' ,'LVN02',N'Vịt','CAI'),
('VN007' ,'SH008' ,'LVN02',N'Ngỗng','CAI'),
('VN008' ,'SH006' ,'LVN02',N'Trâu','DUC')
go
insert into tblVacXin values
('VX001', 'VACXIN 1', 'CAU TRUNG','DUOI 1',3,1),
('VX002', 'VACXIN 2','THUONG HAN','TU 1 DEN 2',2,3),
('VX003', 'VACXIN 3', 'DICH TA','DUOI 1',3,1.5),
('VX004', 'VACXIN 4', 'TU HUYET','DUOI 1',1,2),
('VX005', 'VACXIN 5', 'LO MOM','DUOI 1',3,1),
('VX006', 'VACXIN 6', 'PHE QUAN','DUOI 1',3,1),
('VX007', 'VACXIN 7', 'CAT XON','DUOI 1',4,1.5),
('VX008', 'VACXIN 8', 'TIEU CHAY','DUOI 1',3,1),
('VX009', 'VACXIN 9', 'HO HAP','DUOI 1',3,1),
('VX010', 'VACXIN 10', 'CARE','DUOI 1',3,3),
('VX011', 'VACXIN 11', 'UONG VAN','TU 1 DEN 2',5,1.5),
('VX012', 'VACXIN 12', 'TAI XANH','DUOI 1',3,2.5)
go
insert into tblCosoTiem VALUES
('CS001','THUY1'),
('CS002','THUY2'),
('CS003','THUY3'),
('CS004','THUY4'),
('CS005','THUY5')
go
insert into tblSoTheoDoi_TiemVX values
('TC0001','VN001','VX007','CS001','11/20/2016',1,10,'DUONG RUOT','11/20/2017'),
('TC0002','VN001','VX006','CS001','10/20/2016',1,10,'DUONG RUOT','01/23/2017'),
('TC0003','VN005','VX010','CS002','08/20/2016',1,10,'DUONG RUOT','11/03/2017'),
('TC0004','VN005','VX011','CS003','09/20/2016',1,10,'DUONG RUOT','11/20/2017'),
('TC0005','VN005','VX011','CS004','07/20/2016',1,10,'DUONG RUOT','11/20/2017'),
('TC0006','VN007','VX001','CS005','06/20/2016',1,10,'DUONG RUOT','11/20/2017'),
('TC0007','VN007','VX002','CS003','05/20/2016',1,10,'DUONG RUOT','11/20/2017'),
('TC0008','VN008','VX003','CS003','04/20/2016',2,10,'DAI','11/20/2017'),
('TC0009','VN008','VX002','CS001','11/20/2015',1,10,'DAI','11/20/2017'),
('TC0010','VN008','VX001','CS001','11/20/2014',1,10.5,'DAI','11/20/2015'),
('TC0011','VN003','VX008','CS002','11/20/2013',1,13.5,'DA DAY','11/20/2017'),
('TC0012','VN003','VX008','CS005','10/20/2011',2,10,'DA DAY','11/20/2015'),
('TC0013','VN001','VX006','CS005','11/20/2016',2,9.5,'DUONG RUOT','11/20/2017'),
('TC0014','VN001','VX007','CS001','11/09/2016',2,7.5,'DUONG RUOT','11/20/2017'),
('TC0015','VN003','VX007','CS001','11/06/2016',1,10,'BINH THUONG','11/20/2017')


-- Đề 4 :
-- Câu 5: Liệt kê MaVN và số lần tiêm vắc xin tương ứng với vật nuôi đó. Chỉ liệt kê những vật nuôi có số 
-- lần tiêm vacxin lớn hơn 2 lần. Kết quả được hiển thị tăng dần theo số lần tiêm vắc xin và giảm dần theo
-- MaVN. (1 điểm)
Select vn.MaVn,vn.TenLoaiVN,count(vn.MaVn) as soLanTiemVacXin  
from tblVatNuoi vn join tblSoTheoDoi_TiemVX s on s.MaVN = vn.MaVn 
group by vn.MaVn,vn.TenLoaiVN having count(vn.MaVn) > 2 order by soLanTiemVacXin,vn.MaVn DESC 