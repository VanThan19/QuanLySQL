use QLBanHangg


--1.Tạo thủ tục thêm dữ liệu vào bảng tblDonDH thỏa mãn các yêu cầu:
--SoDH không được trùng
--MaNhaCC phải có trong bảng tblNhaCC
--NgayDH không quá ngày hiện tại
create proc themdulieu @SoDH char(5),@MaNCC char(5),@NgayDH date
as
if exists (Select * from tblDONDH where SoDH = @SoDH)
print 'Ma bi trung'
else if not exists (Select * from tblNhaCungCap where MaNCC = @MaNCC)
print 'Ma NCC khong ton tai'
else if @NgayDH > GETDATE()
print 'NgayDh khong duoc lon hon ngay hien tai'
else 
begin
Insert into tblDONDH values (@SoDH,@MaNCC,@NgayDH)
print 'Da them thanh cong'
end
exec themdulieu 'DH010','NCC01','2025-05-05'
--2.Tạo thủ tục Sửa dữ liệu trong bảng tblCTDonDH với tham số vào là SoDH, MaVTu, SLDat để sửa SLDat của MaVTu và SoDH tương ứng.
create proc suadulieu @SoDh char(5), @MaVTu char(5),@SlDat int
as
if not exists (Select * from tblChiTietDH where SoDH = @SoDh and MaVTu = @MaVTu)
print 'Khong ton tai don dat hang va vat tu nay'
else 
begin
update tblChiTietDH set SoLuongDat = @SlDat where SoDH = @SoDh and MaVTu = @MaVTu
print 'Sua don hang thanh cong'
end 
exec suadulieu 'DH001','VT003',100 
--3.Tạo thủ tục Xóa dữ liệu bảng tblDonDH với tham số vào là SoDH, yêu cầu:
--SoDH phải có trong bảng tblDonDH.
--Nếu SoDH có trong bảng tblCTDonDH thì xóa dữ liệu trong bảng tblCTDonDH ứng với SoDH đó
create proc xoadulieu1 @SoDH char(5)
as
if not exists (select * from tblDONDH where SoDh = @SoDH)
print 'SoDh khong co trong bang tblDonDH'
else if exists (select * from tblDONDH where SoDh = @SoDH)
delete from tblDONDH where SoDH = @SoDH
else 
begin 
delete from tblDONDH where SoDH = @SoDH
print 'xoa thanh cong' 
end 
exec xoadulieu1 'Dh009'
--4.Tạo hàm với tham số vào là MaVtu, trả về tổng số lượng nhập của vật tư đó.
create function fun_cau4 (@MaVTu char(5))
returns int 
as
begin 
declare @tongluongnhap int 
select @tongluongnhap = sum(SoLuongNhap) from tblCTPNHAP where MaVTu = @MaVTu
return @tongluongnhap
end
print dbo.fun_cau4 ('VT002')
--5.Tạo hàm với tham số vào là MaVtu, trả về tổng số lượng xuất của vật tư đó.
create function fun_cau5 (@MaVTu char(5))
returns int 
as
begin 
declare @tongluongxuat int 
select @tongluongxuat = sum(SoLuongXuat) from tblCTPXUAT where MaVTu = @MaVTu
return @tongluongxuat
end
print dbo.fun_cau4 ('VT002')
--6.Tạo hàm trả về danh sách gồm tên vật tư, tổng số lượng nhập, tổng số lượng xuất, số lượng tồn = Tổng số lượng nhập – Tổng số lượng xuất.
create or alter function fun_ds1 ()
returns @bang1 table (TenVTu nvarchar(50),TSLNhap int ,TSLXuat int,SLTon int)
as
begin 
insert into @bang1 (TenVTu,TSLNhap,TSLXuat,SLTon)
select vt.TenVTu,sum(ctn.SoLuongNhap),sum(ctx.SoLuongXuat),(sum(ctn.SoLuongNhap)-sum(ctx.SoLuongXuat))
from tblVatTu vt left join tblCTPNHAP ctn on ctn.MaVTu = vt.MaVTu left  join tblCTPXUAT ctx on ctx.MaVTu = vt.MaVTu
group by vt.TenVTu
return
end
select * from dbo.fun_ds1()
