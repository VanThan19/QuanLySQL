use QLBanHangg
-- Bài tập thủ tục CURSOR:
-- 1. Viết thủ tục CURSOR cho ra tên vật tư, đơn giá, số lượng đặt của 1 số đặt hàng, với đầu vào là SoDH đó
create or alter proc bai1 @dh char(5), @cs1 cursor varying output as
set @cs1 = cursor for 
select vt.TenVTu,vt.DonGia,ctdh.SoLuongDat from tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu where SoDH = @dh 
open @cs1 

declare @tenvtu nvarchar(50), @dongia int , @soluongdat int ,@cur cursor 
exec bai1 'DH001',@cur output 
while 1=1 
begin 
fetch next from @cur into @tenvtu, @dongia, @soluongdat 
if @@FETCH_STATUS !=0 break;
else print @tenvtu+ str(@dongia)+str(@soluongdat)
end 
close @cur
deallocate @cur 
drop bai1 
-- 2. Viết thủ tục CURSOR cho ra các tên vật tư, tổng tiền của 1 số đặt hàng,với đầu vào là SoDH đó
create or alter proc bai2 @dh char(5), @cs2 cursor varying output as
set @cs2 = cursor for 
select vt.TenVTu,sum(vt.DonGia*ctdh.SoLuongDat) as tongtien from tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu where SoDH = @dh group by vt.TenVTu
open @cs2 

declare @tenvtu nvarchar(50),@tongtien int,@cur cursor 
exec bai2 'DH001',@cur output 
while 1=1 
begin 
fetch next from @cur into @tenvtu,@tongtien
if @@FETCH_STATUS !=0 break;
else print @tenvtu+ str(@tongtien)
end 
close @cur
deallocate @cur 
--3. Viết thủ tục CURSOR cho ra các tên vật tư, , tổng tiền của 1 nhà cung cấp với đầu vào là họ tên nhà cung cấp đó
create or alter proc bai3 @ten nvarchar(50), @cs3 cursor varying output as 
set @cs3 = cursor for 
select vt.TenVTu,sum(vt.DonGia * ctdh.SoLuongDat) tongtien from tblChiTietDH ctdh join tblDONDH dh on ctdh.SoDH = dh.SoDH join tblVatTu vt 
on ctdh.MaVTu = vt.MaVTu join tblNhaCungCap ncc on dh.MaNCC = ncc.MaNCC where ncc.TenNCC = @ten group by vt.TenVTu
open @cs3

declare @tenvtu nvarchar(50),@tongtien int,@cur cursor
exec bai3 N'Nhà Cung Cấp B',@cur output 
while 1=1 
begin 
fetch next from @cur into @tenvtu,@tongtien
if @@FETCH_STATUS != 0 break;
else 
print @tenvtu + str(@tongtien)
end 
close @cur 
deallocate @cur 

-- 4. Tạo thủ tục cursor: Hiện số lượng nhập hàng của các vật tư có đơn đặt hàng là N
create or alter proc bai4 @dh char(5),@cs4 cursor varying output as 
set @cs4 = cursor for 
select vt.TenVTu,sum(ctn.SoLuongNhap) sln from tblCTPNHAP ctn join tblVatTu vt on ctn.MaVTu = vt.MaVTu join tblPNHAP n on n.SoPN = ctn.SoPN
where n.SoDH = @dh group by vt.MaVTu,vt.TenVTu
open @cs4

declare @tenvtu nvarchar(50),@sln int, @cur cursor 
exec bai4 'DH001', @cur output
while 1=1
begin 
fetch next from @cur into @tenvtu,@sln
if @@FETCH_STATUS != 0 break;
else 
print @tenvtu + str(@sln)
end 
close @cur
deallocate @cur 

-- 5.Viết thủ tục tính tổng số lượng đặt hàng của 1 vật tư trong tháng năm nào đó
create or alter proc bai5 @ngay char(7),@cs5 cursor varying output as 
if not exists (select * from tblCTPXUAT ct join tblVatTu vt on ct.MaVTu = vt.MaVTu join tblPXUAT x on x.SoPX = ct.SoPX where 
convert(char(7),x.NgayXuat,21) = @ngay) return 1
else 
set @cs5 = cursor keyset for 
select vt.TenVTu,Sum(ct.SoLuongXuat) tslx from tblCTPXUAT ct join tblVatTu vt on ct.MaVTu = vt.MaVTu join tblPXUAT x on x.SoPX = ct.SoPX where 
convert(char(7),x.NgayXuat,21) = @ngay group by vt.TenVTu
open @cs5 

declare @tenvtu nvarchar(50),@tslx int ,@cur cursor , @sb int
exec @sb=bai5 '2025-02',@cur output 
if @sb = 1 print N'Không Có Mô Nha'
else 
begin 
while 0=0 
begin 
fetch next from @cur into @tenvtu,@tslx 
if @@FETCH_STATUS !=0 break;
print @tenvtu + str(@tslx)
end 
close @cur 
deallocate @cur 
end 

-- Bài Tập Thủ Tục Hiển Thị 
--6. Xây dựng thủ tục hiện thị dữ liệu cho báo cáo xuất hàng: tên vật tư, số lượng xuất, đơn giá, tổng tiền. Tham số vào soPX, nếu gọi thủ tục mà
-- không truyền tham số thì xem như hiện thị toàn bộ các SoPX có trong bảng tblpxuat.
create or alter proc bai6 @SoPX char(5) = null as 
begin 
select vt.TenVTu,ct.SoLuongXuat,ct.DonGiaXuat,(ct.SoLuongXuat*ct.DonGiaXuat) tongtien 
from tblCTPXUAT ct join tblVatTu vt on ct.MaVTu = vt.MaVTu where @SoPX IS NULL OR ct.SoPX = @SoPX 
end 
go
exec bai6 'PX001'

-- 7. Xây dựng thủ tục hiện thị dữ liệu cho báo cáo gồm Họ tên nhà cung cấp, tên vật tư, số lượng đặt, tổng tiền. Tham số vào tên nhà cung
-- cấp, nếu gọi thủ tục mà không truyền tham số thì xem như hiện thị toàn bộ các nhà cc.
create or alter proc bai7 @tenNcc nvarchar(50) = null as 
begin
select ncc.TenNCC,vt.TenVTu,ctdh.SoLuongDat,(vt.DonGia * ctdh.SoLuongDat) tongtien from tblChiTietDH ctdh join tblDONDH dh on ctdh.SoDH = dh.SoDH join tblVatTu vt 
on ctdh.MaVTu = vt.MaVTu join tblNhaCungCap ncc on dh.MaNCC = ncc.MaNCC where @TenNCC IS NULL OR ncc.TenNCC = @TenNCC
end
go 
exec bai7 N'Nhà Cung Cấp A'