use QLBanHangg

--1. Viết hàm tham số vào là mã hàng hoá trả về đơn giá của hàng hoá này.
create function f_Bai1 (@mahanghoa char(5))
returns int 
as 
begin 
declare @dg int 
select @dg = DonGia from tblVatTu where MaVTu = @mahanghoa 
return @dg
end 
-- lời gọi
print dbo.f_Bai1('VT001')
--2. Viết hàm tham số vào là tên hàng hoá trả về đơn giá của hàng hoá này.
create or alter function f_Bai2 (@tenhanghoa nvarchar(50))
returns int 
as 
begin 
declare @dg int 
select @dg = DonGia from tblVatTu where TenVTu = @tenhanghoa
return @dg
end 
-- lời gọi
print dbo.f_Bai2(N'Sách Giáo Khoa')

--3. Viết hàm tham số vào là nhà cung cấp trả về tổng tiền phải trả cho nhà cc này.
create or alter function f_Bai3 (@nhacungcap nvarchar(50))
returns int 
as 
begin
declare @tongtien int 
select @tongtien = Sum(SoLuongDat*DonGia) from tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC = dh.MaNCC join tblChiTietDH ct on dh.SoDH = ct.SoDH 
join tblVatTu vt on vt.MaVTu= ct.MaVTu Where ncc.TenNCC = @nhacungcap
return @tongtien 
end 
print dbo.f_Bai3(N'Nhà Cung Cấp A')
--4. Viết hàm tham số vào là tên nhà cung cấp và tên hàng hoá trả về tổng tiền phải trả cho nhà cc này với tên hàng hoá trên.
create or alter function f_Bai4 (@tenNcc nvarchar(50),@tenHangHoa nvarchar(50))
returns int 
as
begin 
declare @tongtien int 
select @tongtien = Sum(SoLuongDat*DonGia) from tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC = dh.MaNCC join tblChiTietDH ct on dh.SoDH = ct.SoDH 
join tblVatTu vt on vt.MaVTu= ct.MaVTu Where ncc.TenNCC = @tenNcc and vt.TenVTu = @tenHangHoa
return @tongtien 
end
print dbo.f_Bai4(N'Nhà Cung Cấp C',N'Sách Giáo Khoa')

--5. Viết hàm tham số vào số đặt hàng trong tbldondh trả về tổng tiền của số đặt hàng này.
create or alter function f_Bai5 (@SoDh char(5))
returns int 
as
begin 
declare @tongtien int 
select @tongtien = sum(SoLuongDat * DonGia) from tblChiTietDH ct join tblVatTu vt on ct.MaVTu = vt.MaVTu
where SoDH = @sodh 
return @tongtien
end
print dbo.f_Bai5('DH001')
--6. Viết hàm tham số vào là tên vật tư trả về tổng số lượng nhập hàng của vật tư này.
create or alter function f_Bai6 (@tenVT nvarchar(50)) 
returns int 
as
begin 
declare @tong int
select @tong = sum(SoLuongNhap) from tblVatTu vt join tblCTPNHAP ctn on vt.MaVTu = ctn.MaVTu where vt.TenVTu = @tenVT
return @tong 
end
print dbo.f_Bai6(N'Sách Giáo Khoa')
--7. Viết hàm tham số vào là tên vật tư trả về tổng số lượng xuất hàng của vật tư này.
create or alter function f_Bai7 (@tenVT nvarchar(50)) 
returns int 
as
begin 
declare @tong int
select @tong = sum(SoLuongXuat) from tblVatTu vt join tblCTPXUAT ct on vt.MaVTu = ct.MaVTu where vt.TenVTu = @tenVT
return @tong 
end
print dbo.f_Bai7(N'Sách Giáo Khoa')
--8. Viết hàm tham số vào là số phiếu xuất trả về tổng tiền của nó
create or alter function f_Bai8 (@SoPX char(5)) 
returns int 
as 
begin
declare @tong int 
select @tong = sum(SoLuongXuat*DonGiaXuat) from tblCTPXUAT ct join tblVatTu vt on ct.MaVTu = vt.MaVTu where SoPX = @SoPX
return @tong
end
print dbo.f_Bai8('PX001')
-- 9. Tạo hàm tham số vào là nhàcc, ra là tên các hàng hoá đã cung cấp
create or alter function f_Bai9 (@NhaCC nvarchar(50))
returns Table 
as
return (
select distinct vt.TenVTu  from tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC = dh.MaNCC join tblChiTietDH ct on dh.SoDH = ct.SoDH 
join tblVatTu vt on vt.MaVTu= ct.MaVTu where ncc.TenNCC = @NhaCC 
)
-- lời gọi 
Select * from dbo.f_Bai9(N'Nhà Cung Cấp C')
--10. Tạo hàm hiển thị các tên hàng hoá, số lượng đặt mua, đơn giá của số đặt hàng s.
create or alter function f_Bai10 (@s_dh char(5))
returns Table 
as 
return 
( select vt.TenVTu,ct.SoLuongDat,vt.DonGia from tblChiTietDH ct join tblVatTu vt on ct.MaVTu = vt.MaVTu where SoDH = @s_dh)
--11. Tạo hàm tham số vào là sopn, ra là mavtu, tenvtu, slnhap, dongia, tổng tiền của Sopn trên.
--12. Tạo hàm tham số vào là sopx, ra là mavtu, tenvtu, slnhap, dongia, tổng tiền của Sopx trên.
--13. Tạo hàm tham số vào là nhàcc, ra là mã vật tư, tên vật tư, tổng số lượng nhập, đơn giá, tổng tiền do nhà cung cấp trên đã cung cấp.
--14. Tạo hàm tham số vào là tên vật tư, ra là mã nhà cc, tên nhà cc, tổng số lượng nhập, đơn giá, tổng tiền của vật tư trên.