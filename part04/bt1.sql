Create DataBase DeThi01 
Use DeThi01 

Create Table nhaCungCap
(
maNhaCungCap char(6) primary key ,
Name nvarchar(30) ,
diaChi nvarchar(30),
soDT char(8) ,
maSoThue int 
)

Create Table loaiDichVu 
(
maLoaiDV char(4) primary key ,
tenLoaiDV nvarchar(50) ,
)

Create Table mucPhi 
(
maMP char(4) primary key,
donGia decimal (10,3),
moTa nvarchar(50) ,
)

Create Table dongXe 
(
dongXe varchar(20) primary key ,
hangXe varchar(20),
soChoNgoi int 
)

Create Table dangKyCungCap
(
maDKCC char(5) primary key,
maNhaCC char(6) foreign key references nhaCungCap(maNhaCungCap),
maLoaiDV char(4) foreign key references loaiDichVu(maLoaiDV),
dongXe varchar(20) foreign key references dongXe(dongXe),
maMP char(4) foreign key references mucPhi(maMP),
ngayBatDauCungCap datetime ,
ngayKetThucCungCap datetime ,
soLuongXeDangKy int
)
--drop table dangKyCungCap
-- Nhà cung cấp 
Insert into nhaCungCap (maNhaCungCap,Name,diaChi,soDT,maSoThue) values 
('NCC001',N'CTY TNHH TOÀN PHAP',N'HAI CHAU','0511XX88',568941),
('NCC002',N'CTY CỔ PHẦN ĐÔNG DU',N'LIEN CHIEU','0511XX89',456789),
('NCC003',N'ÔNG NGUYỄN VĂN A',N'HOA THUAN','0511XX90',321456),
('NCC004',N'CTY CỔ PHẦN TOÀN CẦU XANH',N'HAI CHAU','0511XX45',513364),
('NCC005',N'CTY TNHH AMA',N'THANH KHE','0511XX91',321457),
('NCC006',N'BÀ TRẦN THỊ BÍCH VÂN',N'LIEN CHIEU','0511XX91',321455),
('NCC007',N'CTY TNHH PHAN THÀNH',N'THANH KHE','0511XX92',321459),
('NCC008',N'ÔNG PHAN ĐÌNH NAM',N'HOA THUAN','0511XX93',321458),
('NCC009',N'TẬP ĐOÀN ĐÔNG NAM Á',N'LIEN CHIEU','0511XX94',321488),
('NCC010',N'CTY CỔ PHẦN RẠNG ĐÔNG',N'LIEN CHIEU','0511XX95',321477)

-- Loại Dịch Vụ
INSERT INTO loaiDichVu (maLoaiDV,tenLoaiDV) values 
('DV01',N'DỊCH VỤ XE TAXI'),
('DV02',N'DỊCH VỤ XE BUÝT CÔNG CỘNG THEO TUYẾN CỐ ĐỊNH'),
('DV03',N'DỊCH VỤ XE CHO THUÊ THEO HỢP ĐỒNG')

-- MỤC PHI 
INSERT INTO mucPhi (maMP,donGia,moTa) values
('MP01',10.000,N'ÁP DỤNG TỪ 1/2015'),
('MP02',15.000,N'ÁP DỤNG TỪ 2/2015'),
('MP03',20.000,N'ÁP DỤNG TỪ 1/2010'),
('MP04',25.000,N'ÁP DỤNG TỪ 2/2011')

-- DÒNG XE 
INSERT INTO dongXe (dongXe,hangXe,soChoNgoi) values 
('HIACE','TOYOTA',16),
('VIOS','TOYOTA',5),
('ESCAPE','FORD',5),
('CERATO','KIA',7),
('FORTE','KIA',5),
('STAREX','HUYNDAI',7),
('GRAND-I10','HUYNDAI',7)

-- ĐĂNG KÝ CUNG CẤP 
INSERT INTO dangKyCungCap values ('DK001','NCC001','DV01','HIACE','MP01','2015-11-20','2016-11-20',4),
('DK002','NCC002','DV02','hiace','MP02','2015-11-20','2016-11-20',3),
('DK003','NCC003','DV03','ESCAPE','MP03','2015-11-20','2016-12-20',5),
('DK004','NCC004','DV02','CERATO','MP04','2016-11-20','2017-11-20',7),
('DK005','NCC005','DV03','FORTE','MP02','2015-12-20','2015-11-20',1),
('DK006','NCC006','DV01','HIACE','MP01','2016-09-20','2017-11-20',10),
('DK007','NCC007','DV02','GRAND-I10','MP01','2015-11-20','2016-11-20',7),
('DK008','NCC008','DV01','HIACE','MP01','2015-11-20','2017-11-20',4),
('DK009','NCC004','DV03','FORTE','MP03','2015-12-20','2016-11-20',6),
('DK010','NCC001','DV03','HIACE','MP04','2015-06-20','2017-11-20',4),
('DK011','NCC002','DV02','GRAND-I10','MP01','2015-11-20','2016-11-20',4),
('DK012','NCC008','DV01','CERATO','MP02','2015-11-20','2016-11-20',5),
('DK013','NCC007','DV03','VIOS','MP01','2015-11-20','2016-11-20',4),
('DK014','NCC005','DV01','ESCAPE','MP03','2015-11-20','2017-11-20',4)

INSERT INTO dangKyCungCap values ('DK015','NCC005','DV01','Starex','MP03','2015-11-20','2017-11-20',4)

select *from nhaCungCap
select *from dangKyCungCap
select *from loaiDichVu
select *from dongXe
select *from mucPhi
select *from dangKyCungCap

--Câu 3: Liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ (0.5 điểm)
select *from dongXe 
where sochongoi >5
--Câu 4: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp những dòng xe thuộc hãng xe "Toyota" với mức phí 
--có đơn giá là 15.000 VNĐ/km hoặc những dòng xe thuộc hãng xe "KIA" với mức phí có đơn giá là 20.000 VNĐ/km (0.5 điểm)
select *from nhaCungCap a join dangKyCungCap b on a.maNhaCungCap= b.maNhaCC join dongXe c on b.dongXe= c.dongXe 
join mucphi d on b.maMP= d.maMP
where (c.hangXe = 'toyota' and  d.donGia = 15.000) OR (c.hangXe='Kia' and d.donGia = 20.000)
--Câu 5: Liệt kê thông tin của các dòng xe thuộc hãng xe có tên bắt đầu là ký tự "T" và có độ dài là 5 ký tự (0.5 điểm)
select *from dongXe
where dongxe.hangXe like 'T_____'
--Câu 6: Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên nhà cung cấp và giảm dần theo mã số thuế (0.5 điểm)
select *from nhaCungCap order by name , maSoThue desc  
--Câu 7: Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung cấp với yêu cầu chỉ đếm cho những nhà cung cấp 
--thực hiện đăng ký cung cấp có ngày bắt đầu cung cấp là "20/11/2015" (0.5 điểm)
select n.name,count(*)  [Số Lần Đăng Ký] from dangKyCungCap c join nhaCungCap n on c.maNhaCC = n.maNhaCungCap
where c.ngayBatDauCungCap = '2015-11-20' group by  n.Name
--Câu 8: Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe chỉ được liệt kê một lần (0.5 điểm)
select  hangXe, count(distinct hangXe) ditme from dongXe group by hangXe
-- Câu 9: Liệt kê MaDKCC, TenLoaiDV, TenNhaCC, DonGia, DongXe, HangXe, NgayBatDauCC, NgayKetThucCC, SoLuongXeDangKy 
--của tất cả các lần đăng ký cung cấp phương tiện (0.5 điểm)
select d.MaDKCC, l.TenLoaiDV, c.Name, p.DonGia, x.DongXe, x.HangXe, d.NgayBatDauCungCap, d.NgayKetThucCungCap, d.SoLuongXeDangKy
from dangKyCungCap d join nhaCungCap c on d.maNhaCC = c.maNhaCungCap join loaiDichVu l on l.maLoaiDV = d.maLoaiDV join mucPhi p
on p.maMP = d.maMP join dongXe x on x.dongXe = d.dongXe
--Câu 10: Liệt kê MaDKCC, MaNhaCC, TenNhaCC, DiaChi, MaSoThue, TenLoaiDV, DonGia, HangXe, NgayBatDauCC, NgayKetThucCC của 
--tất cả các lần đăng ký cung cấp phương tiện với yêu cầu những nhà cung cấp nào chưa từng thực hiện đăng ký cung cấp 
--phương tiện thì cũng liệt kê thông tin những nhà cung cấp đó ra (0.5 điểm)
select *from nhaCungCap
select *from dangKyCungCap
select *from loaiDichVu
select *from dongXe
select *from mucPhi
select *from dangKyCungCap
select d.MaDKCC,c.maNhaCungCap, l.TenLoaiDV, c.Name, p.DonGia, x.DongXe, x.HangXe, d.NgayBatDauCungCap, d.NgayKetThucCungCap, d.SoLuongXeDangKy
from dangKyCungCap d full join nhaCungCap c on d.maNhaCC = c.maNhaCungCap full join loaiDichVu l on l.maLoaiDV = d.maLoaiDV full join mucPhi p
on p.maMP = d.maMP full join dongXe x on x.dongXe = d.dongXe where d.maNhaCC is null 