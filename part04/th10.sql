use QLBanHangg

-- TH10 

-- 1. Tạo hàm tham số vào là nhàcc, ra là tên các hàng hoá đã cung cấp
create or alter function f_Bai1 (@NhaCC nvarchar(50))
returns table
as 
return (
Select vt.TenVTu from tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC = dh.MaNCC
join tblChiTietDH ct on dh.SoDH = ct.SoDH join tblVatTu vt on vt.MaVTu = ct.MaVTu
Where ncc.TenNCC = @NhaCC 
)
-- lời gọi 
Select * from dbo.f_Bai1 (N'Nhà Cung Cấp C')

-- 2. Tạo hàm hiển thị các tên hàng hoá, số lượng đặt mua, đơn giá của số đặt hàng s.
create or alter function f_Bai2 (@SoDH char(5)) 
returns table 
as
return 
(
Select vt.TenVTu,ct.SoLuongDat,vt.DonGia from tblVatTu vt join tblChiTietDH ct on vt.MaVTu = ct.MaVTu
Where ct.SoDH = @SoDH)
-- lời gọi 
Select * from dbo.f_Bai2 ('DH001')
-- 3. Tạo hàm tham số vào là sopn, ra là mavtu, tenvtu, slnhap, dongia, tổng tiền của Sopn trên.
create or alter function f_Bai3 (@SoPN char(5))
returns table 
as 
return 
(
Select vt.MaVTu,vt.TenVTu,vt.DonGia,Sum(ct.SoLuongNhap*ct.DonGiaNhap) TT  from tblVatTu vt join tblCTPNHAP ct on vt.MaVTu = ct.MaVTu
Where ct.SoPN = @SoPN group by vt.MaVTu,vt.TenVTu,vt.DonGia
)
Select * from dbo.f_Bai3 ('PN001')
-- 4. Tạo hàm tham số vào là sopx, ra là mavtu, tenvtu, slnhap, dongia, tổng tiền của Sopx trên.
create or alter function f_Bai4 (@SoPX char(5))
returns table 
as
return 
(
Select vt.MaVTu,vt.TenVTu,vt.DonGia,Sum(ct.SoLuongXuat*ct.DonGiaXuat) TT  from tblVatTu vt join tblCTPXUAT ct on vt.MaVTu = ct.MaVTu
Where ct.SoPX = @SoPX group by vt.MaVTu,vt.TenVTu,vt.DonGia
)
Select * from dbo.f_Bai4 ('PX002')
-- 5. Tạo hàm tham số vào là nhàcc, ra là mã vật tư, tên vật tư, tổng số lượng nhập, đơn giá, tổng tiền do nhà cung cấp trên đã cung cấp.
create or alter function f_Bai5 (@TenNCC nvarchar(50))
returns table 
as 
return 
(
Select vt.MaVTu,vt.TenVTu,Sum(ctn.SoLuongNhap) SLN ,vt.DonGia,Sum(ctn.DonGiaNhap*ctn.SoLuongNhap) TT from tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC = dh.MaNCC join tblPNHAP n on dh.SoDH = n.SoDH
join tblCTPNHAP ctn on ctn.SoPN = n.SoPN join tblVatTu vt on vt.MaVTu = ctn.MaVTu Where ncc.TenNCC = @TenNCC 
Group by vt.MaVTu,vt.TenVTu,vt.DonGia
)
Select * from dbo.f_Bai5 (N'Nhà Cung Cấp B')
-- 6. Tạo hàm tham số vào là tên vật tư, ra là mã nhà cc, tên nhà cc, tổng số
-- lượng nhập, đơn giá, tổng tiền của vật tư trên
create or alter function f_Bai6 (@TenVTu nvarchar(50))
returns table 
as
return 
(
Select ncc.MaNCC,ncc.TenNCC,Sum(ctn.SoLuongNhap) SLN ,vt.DonGia,Sum(ctn.DonGiaNhap*ctn.SoLuongNhap) TT from tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC = dh.MaNCC join tblPNHAP n on dh.SoDH = n.SoDH
join tblCTPNHAP ctn on ctn.SoPN = n.SoPN join tblVatTu vt on vt.MaVTu = ctn.MaVTu Where vt.TenVTu = @TenVTu 
Group by ncc.MaNCC,ncc.TenNCC,vt.DonGia
)
Select * from dbo.f_Bai6 (N'Sách Giáo Khoa')

--QLCB:
create table tblDonVi
(
MaDV char(5) primary key,
TenDV nvarchar(50),
SoLuongCB int)
create table tblCanBo 
(
MaCB char(5) primary key,
TenCb nvarchar(50),
MaDV char(5) foreign key references tblDonVi(MaDV),
GioiTinh nvarchar(10),
SoNamCongTac int,
DiaChi nvarchar(50),
HeSoLuong decimal(4,2),
HeSoPC decimal(4,2) ,
Luong int
)
insert into tblDonVi values 
('DV001', N'Phòng Kế Toán', 10),
('DV002', N'Phòng Nhân Sự', 15),
('DV003', N'Phòng IT', 20);
insert into tblCanBo values 
('CB001', N'Nguyễn Văn A', 'DV001', N'Nam', 5, N'Hà Nội', 3.50, 0.50, 15000000),
('CB002', N'Trần Thị B', 'DV002', N'Nữ', 8, N'Hồ Chí Minh', 4.00, 0.80, 18000000),
('CB003', N'Lê Văn C', 'DV003', N'Nam', 10, N'Đà Nẵng', 4.50, 1.00, 20000000),
('CB004', N'Phạm Thị D', 'DV001', N'Nữ', 12, N'Hải Phòng', 5.00, 1.20, 22000000),
('CB005', N'Hoàng Văn E', 'DV002', N'Nam', 7, N'Nghệ An', 3.80, 0.60, 16000000);

-- 1. Tạo hàm hiển thị tên cán bộ, địa chỉ của cán bộ có đơn vị công tác A
create or alter function fht_bai1 (@TenDV nvarchar(50)) 
returns table 
as
return
(
select cb.TenCb,cb.DiaChi from tblCanBo cb join tblDonVi dv on cb.MaDV = dv.MaDV where dv.TenDV = @TenDV
)
Select * from dbo.fht_bai1 (N'Phòng Kế Toán')
-- 2. Tạo hàm hiện thị đơn vị có tổng lương nhận >S
create or alter function fht_bai2 (@S int)
returns table
as
return 
(
Select dv.MaDV,dv.TenDV,Sum(cb.Luong) TongLuong from tblCanBo cb join tblDonVi dv on cb.MaDV = dv.MaDV group by dv.MaDV,dv.TenDV
having Sum(cb.Luong) > @S
)
Select * from dbo.fht_bai2 (16000000)
-- 3. Tạo hàm hiển thị tổng lương của cán bộ nữ của từng đơn vị
create or alter function fht_bai3 (@GioiTinh nvarchar(10)) 
returns table
as
return 
(
Select dv.MaDV,dv.TenDV,cb.TenCb,Sum(cb.Luong) TongLuong  from tblCanBo cb join tblDonVi dv on cb.MaDV = dv.MaDV where cb.GioiTinh = @GioiTinh
Group by dv.MaDV,dv.TenDV,cb.TenCb
)
Select * from dbo.fht_bai3 (N'Nữ')

-- 1. QLCB: Tạo hàm tạo table gồm tên đơn vị, tổng lương đơn vị,BHXH=5%, BHYT=1%, tổng lương của đơn vị đó.
create or alter function f_baiqlcb1 ()
returns @bang table (TenDV nvarchar(50),TongLuongDV int,BHXH int ,BHYT int,LuongSauBH int)
as 
begin 
insert into @bang (TenDV, TongLuongDV, BHXH, BHYT, LuongSauBH)
select dv.TenDV,Sum(cb.Luong) as TongLuongDV,Sum(cb.Luong*0.05) as BHXH,Sum(cb.Luong)*0.01 as BHYT, Sum(cb.Luong) - Sum(cb.Luong) * 0.06 AS LuongSauBH
from tblCanBo cb join tblDonVi dv on cb.MaDV = dv.MaDV Group by dv.TenDV
return 
end

Select * from dbo.f_baiqlcb1 ()
-- 2. QLHS: Tạo hàm tạo table gồm tên hs, điểm các môn, tổng điểm, xếp loại cho hs dựa trên tổng điểm.
create table tblHocSinh (
    MaHS char(5) primary key,
    TenHS nvarchar(50)
)
create table tblMonHoc (
    MaMH char(5) primary key,
    TenMH nvarchar(50)
)
create table tblDiem (
    MaHS char(5) foreign key references tblHocSinh(MaHS),
    MaMH char(5) foreign key references tblMonHoc(MaMH),
    Diem float,
)
insert into tblHocSinh values ('HS001', N'Nguyễn Văn A');
insert into tblHocSinh values ('HS002', N'Trần Thị B');
insert into tblMonHoc values ('MH001', N'Toán');
insert into tblMonHoc values ('MH002', N'Văn');
insert into tblDiem values ('HS001', 'MH001', 8.5);
insert into tblDiem values ('HS001', 'MH002', 7.0);
insert into tblDiem  values ('HS002', 'MH001', 9.0);
insert into tblDiem values ('HS002', 'MH002', 8.0);

create or alter function f_qlhs ()
returns @bang2 table (TenHS nvarchar(50),TongDiem float,XepLoai nvarchar(10))
as
begin 
insert into @bang2 (TenHS,TongDiem)
select hs.TenHS,avg(d.Diem) as TongDiem
from tblHocSinh hs join tblDiem d on hs.MaHS = d.MaHS join tblMonHoc mh on mh.MaMH = d.MaMH 
group by hs.TenHS
update @bang2 set XepLoai = case 
when TongDiem >= 8.0 then N'Giỏi'
when TongDiem >=6.5 and TongDiem < 8 then N'Khá'
when TongDiem >= 4.5 and TongDiem < 6.5 then N'Trung Bình'
when TongDiem < 4.5 then N'Yếu '
end 
return 
end
select * from dbo.f_qlhs()

-- 3. QLBH: Tạo hàm tạo table gồm: tên nhà cc, tổng tiền, giảm giá 10% nếu 
-- tổng tiền>A, nếu từ A đến B giảm 5%, ít hơn B giảm =0, Cột tiền phải trả= tổng tiền-giảm.
create or alter function f_qlbh3 (@TienA money , @TienB money) 
returns @bang3 table (TenNCC nvarchar(50),TongTien money,GiamGia money,TienTra money)
as 
begin 
insert into @bang3(TenNCC,TongTien)
select ncc.TenNCC,sum(ct.SoLuongDat*vt.DonGia) as TongTien 
from tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC = dh.MaNCC join tblChiTietDH ct on ct.SoDH = dh.SoDH join tblVatTu vt on vt.MaVTu = ct.MaVTu
group by ncc.TenNCC
update @bang3 set GiamGia = case 
when TongTien > @TienA then TongTien*0.1
when TongTien >@TienB and TongTien <=@TienA then TongTien*0.05
else 0
end 
update @bang3 set TienTra = TongTien - GiamGia
return 
end 
select * from dbo.f_qlbh3(1000,500)