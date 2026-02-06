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

-- Câu 3: Liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ (0.5 điểm)
select * from tblDONGXE where tblDONGXE.SoChoNgoi > 5
-- Câu 4: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp những dòng xe thuộc hãng xe "Toyota" với mức
--phí có đơn giá là 15.000 VNĐ/km hoặc những dòng xe thuộc hãng xe "KIA" với mức phí có đơn giá là 20.000 VNĐ/km
select * from tblDANGKICUNGCAP d join tblDONGXE x on d.DongXe = x.DongXe join tblMUCPHI m on m.MaMP = d.MaMP
            where (x.HangXe = 'Toyota' and m.DonGia = 15000) or (x.HangXe = 'KIA' and m.DonGia = 20000)
-- Câu 5: Liệt kê thông tin của các dòng xe thuộc hãng xe có tên bắt đầu là ký tự "T" và có độ dài là 6 ký tự 
select * from tblDONGXE x where x.HangXe like 'T%' and Len(hangxe) = 6 
-- Câu 6: Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên nhà cung cấp và giảm dần theo 
--mã số thuế
select * from tblNHACUNGCAP c order by  c.TenNhaCC , c.MaSoThue  DESC 
-- Câu 7: Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung cấp với yêu cầu chỉ đếm cho những nhà 
--cung cấp thực hiện đăng ký cung cấp có ngày bắt đầu cung cấp là "20/11/2015" (0.5 điểm)
select n.TenNhaCC,c.NgayBatDauCungCap ,count(*) [Count] from tblDANGKICUNGCAP c join tblNHACUNGCAP n on c.MaNhaCC = n.MaNhaCC 
        where c.NgayBatDauCungCap = '2015/11/20' group by n.TenNhaCC, c.NgayBatDauCungCap
-- Câu 8: Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe chỉ được liệt kê một lần (0.5 điểm)
select Distinct hangXe from tblDONGXE 
-- Câu 9: Liệt kê MaDKCC, TenLoaiDV, TenNhaCC, DonGia, DongXe, HangXe, NgayBatDauCC, NgayKetThucCC, SoLuongXeDangKy 
--của tất cả các lần đăng ký cung cấp phương tiện (0.5 điểm)
select dk.MaDKCC,dv.TenLoaiDV,cc.TenNhaCC,mp.DonGia,x.DongXe,x.HangXe,dk.NgayBatDauCungCap,dk.NgayKetThucCungCap,dk.SoLuongXeDangKy
from tblDANGKICUNGCAP dk join tblLOAIDICHVU dv on dk.MaLoaiDV = dv.MaLoaiDV join tblNHACUNGCAP cc on dk.MaNhaCC = cc.MaNhaCC
join tblDONGXE x on dk.DongXe = x.DongXe join tblMUCPHI mp on dk.MaMP = mp.MaMP 
-- Câu 10: Liệt kê MaDKCC, MaNhaCC, TenNhaCC, DiaChi, MaSoThue, TenLoaiDV, DonGia, HangXe, NgayBatDauCC, NgayKetThucCC
--của tất cả các lần đăng ký cung cấp phương tiện với yêu cầu những nhà cung cấp nào chưa từng thực hiện đăng ký 
--cung cấp phương tiện thì cũng liệt kê thông tin những nhà cung cấp đó ra (0.5 điểm)
select dk.MaDKCC,dv.TenLoaiDV,cc.TenNhaCC,mp.DonGia,x.DongXe,x.HangXe,dk.NgayBatDauCungCap,dk.NgayKetThucCungCap,dk.SoLuongXeDangKy
from tblNHACUNGCAP cc left join tblDANGKICUNGCAP dk  on dk.MaNhaCC = cc.MaNhaCC left join tblLOAIDICHVU dv on dk.MaLoaiDV = dv.MaLoaiDV 
left join tblDONGXE x on dk.DongXe = x.DongXe left join tblMUCPHI mp on dk.MaMP = mp.MaMP
-- Câu 11: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp phương tiện thuộc dòng xe "Hiace" hoặc từng
--đăng ký cung cấp phương tiện thuộc dòng xe "Cerato" (0.5 điểm)
select * from tblNHACUNGCAP cc join tblDANGKICUNGCAP dk on cc.MaNhaCC = dk.MaNhaCC join tblDONGXE x on x.DongXe = dk.DongXe
where x.DongXe IN ('Hiace','Cerato')
-- Câu 12: Liệt kê thông tin của các nhà cung cấp chưa từng thực hiện đăng ký cung cấp phương tiện lần nào cả (0.5 điểm)
select * from tblNHACUNGCAP cc left join tblDANGKICUNGCAP dk on cc.MaNhaCC = dk.MaNhaCC where dk.MaDKCC is null 
-- Câu 13: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp phương tiện thuộc dòng xe "Hiace" và chưa 
--từng đăng ký cung cấp phương tiện thuộc dòng xe "Cerato" (0.5 điểm)
select * from tblNHACUNGCAP cc left join tblDANGKICUNGCAP dk on cc.MaNhaCC = dk.MaNhaCC join tblDONGXE x on x.DongXe = dk.DongXe
where dk.DongXe = 'Hiace' and cc.MaNhaCC not in ( SELECT MaNhaCC from tblDANGKICUNGCAP WHERE DongXe = 'Cerato')
-- Câu 14: Liệt kê thông tin của những dòng xe chưa được nhà cung cấp nào đăng ký cho thuê vào năm "2015" nhưng đã 
--từng được đăng ký cho thuê vào năm "2016" (0.5 điểm)
select * from tblDANGKICUNGCAP dk join tblDONGXE x on dk.DongXe = x.DongXe where x.DongXe IN 
( Select dk.DongXe from tblDANGKICUNGCAP dk where year(dk.NgayBatDauCungCap) = 2016 ) AND x.DongXe NOT IN 
(select dk1.DongXe from tblDANGKICUNGCAP dk1 where year(dk1.NgayBatDauCungCap) = 2015)
-- Câu 15: Hiển thị thông tin của những dòng xe có số lần được đăng ký cho thuê nhiều nhất tính từ đầu năm 2016 
--đến hết năm 2019 (0.5 điểm)
select x.DongXe,count(*) soLanDangKi from tblDANGKICUNGCAP dk join tblDONGXE x on dk.DongXe = x.DongXe 
where year(dk.NgayBatDauCungCap) between 2016 and 2019 group by x.DongXe
having count(*) IN ( Select MAX(soLanDangKi) from ( select count(*) soLanDangKi from tblDANGKICUNGCAP 
where year(NgayBatDauCungCap) between 2016 and 2019 group by DongXe) as subQuery )
-- Câu 16: Tính tổng số lượng xe đã được đăng ký cho thuê tương ứng với từng dòng xe với yêu cầu chỉ thực hiện 
-- tính đối với những lần đăng ký cho thuê có mức phí với đơn giá là 20.000 VNĐ trên 1 km (0.5 điểm)
select dk.DongXe,mp.DonGia,count(x.DongXe) soLuongXe from tblDANGKICUNGCAP dk join tblDONGXE x on dk.DongXe = x.DongXe 
join tblMUCPHI mp on mp.MaMP = dk.MaMP where mp.DonGia = 20000
group by dk.DongXe,mp.DonGia 
-- Câu 17: Liệt kê MaNCC, SoLuongXeDangKy với yêu cầu chỉ liệt kê những nhà cung cấp có địa chỉ là "Hai Chau" và chỉ 
--mới thực hiện đăng ký cho thuê một lần duy nhất, kết quả được sắp xếp tăng dần theo số lượng xe đăng ký (0.5 điểm)
select cc.MaNhaCC,dk.SoLuongXeDangKy,count(dk.MaDKCC) [ĐỤ MẸ] from tblDANGKICUNGCAP dk join tblNHACUNGCAP cc on dk.MaNhaCC = cc.MaNhaCC 
where cc.DiaChi = 'Hai Chau' group by cc.MaNhaCC, dk.SoLuongXeDangKy having count(dk.MaDKCC) = 1 
-- Câu 18: Cập nhật cột SoLuongXeDangKy trong bảng DANGKYCUNGCAP thành giá trị 20 đối với những dòng xe thuộc hãng 
--"Toyota" và có NgayKetThucCungCap trước ngày 30/12/2016 (0.5 điểm)
UPDATE tblDANGKICUNGCAP 
SET SoLuongXeDangKy = 20 where MaDKCC IN (select dk.MaDKCC
from tblDANGKICUNGCAP dk join tblDONGXE x on dk.DongXe = x.DongXe 
where x.HangXe = 'Toyota' and dk.NgayKetThucCungCap < '2016-12-30')

select * from tblDANGKICUNGCAP dk join tblDONGXE x on dk.DongXe = x.DongXe 
where x.HangXe = 'Toyota' and dk.NgayKetThucCungCap < '2016-12-30'
-- Câu 19: Cập nhật cột MoTa trong bảng MUCPHI thành giá trị "Được sử dụng nhiều" cho những mức phí được sử dụng để 
--đăng ký cung cấp cho thuê phương tiện từ 5 lần trở lên trong năm 2016 (0.5 điểm)
Update tblMUCPHI SET MoTa = N'Được sử dụng nhiều' where maMP IN 
( 
select dk.MaMP from tblMUCPHi mp join tblDANGKICUNGCAP dk on mp.MaMP = dk.MaMP 
where year(dk.NgayBatDauCungCap) = 2016 group by dk.MaMP having count(dk.MaDKCC) >= 2 )

select * from tblMUCPHi mp 
select * from tblDANGKICUNGCAP mp 
-- Câu 20: Xóa những lần đăng ký cung cấp cho thuê phương tiện có ngày bắt đầu cung cấp sau ngày 10/11/2015 và đăng ký
--cho thuê dòng xe "Vios" (0.5 điểm)
DELETE FROM tblDANGKICUNGCAP Where maDKCC IN 
( 
Select dk.MaDKCC from tblDANGKICUNGCAP dk join tblDONGXE x on dk.DongXe = x.DongXe 
Where year(dk.NgayBatDauCungCap) = 2015 and dk.DongXe = 'Vios' )
Select * from tblDANGKICUNGCAP
