use QLBanHangg

-- Ví dụ 1: Xây dựng thủ tục tính tổng trị giá của một sodh
create proc vidu1 @SoDH char(5), @TongTien int output 
as 
begin
if exists (Select * from tblChiTietDH Where SoDH = @SoDH)
Select @TongTien = Sum( ctdh.SoLuongDat * vt.DonGia) from tblVatTu vt join tblChiTietDH ctdh on vt.MaVTu = ctdh.MaVTu
Where ctdh.SoDH = @SoDH group by SoDH 
else print N'Không Có Đơn Hàng' + @SoDH 
end 
go
declare @Tong_Tien int 
exec vidu1 'DH001', @Tong_Tien output
print N'Tổng Tiền '+ str(@Tong_Tien) 
drop proc vidu1 

-- Ví dụ 2: Xây dựng thủ tục tính tổng số lượng nhập, Tổng số lượng xuất của 1 vật tư trong tháng năm nào đó
create proc vidu2 @TenVTu nvarchar(255),@Ngay char(7),@TongXuat int output ,@TongNhap int output
as
begin 
Select vt.TenVTu,Sum(ctx.SoLuongXuat) as TongTienXuat into #tongxuat from tblCTPXUAT ctx join tblVatTu vt on ctx.MaVTu = vt.MaVTu 
join tblPXUAT x on x.SoPX = ctx.SoPX Where convert(char(7), NgayXuat,21)=@Ngay and vt.tenvtu=@TenVTu
Group by vt.tenvtu
select @TongXuat=TongTienXuat from #tongxuat 
Drop table #tongxuat
Select vt.TenVTu,Sum(ctn.SoLuongNhap) as TongTienNhap into #tongNhap from tblCTPNHAP ctn join tblVatTu vt on ctn.MaVTu = vt.MaVTu 
join tblPNHAP n on ctn.SoPN = n.SoPN
Where  convert(char(7), NgayNhap,21)=@Ngay and vt.tenvtu=@TenVTu Group by vt.tenvtu
Select @TongNhap = TongTienNhap from #tongNhap
drop table #tongNhap
end 
go
declare @Tong_Xuat int ,@Tong_Nhap int 
exec vidu2 N'Sách Giáo Khoa', N'2025-01',@TongXuat output,@TongNhap output 
PRINT N'Tổng Xuất : ' +str(@TongXuat);
PRINT N'Tổng Nhập : ' +str(@TongNhap);
drop proc vidu2 

-- Ví dụ 3: Xây dựng thủ tục trả về danh sách các tên vật tư có số lượng đặt hàng nhiều nhất trong năm tháng nào đó.
create proc vidu33 @ngay char(7) 
as 
begin 
select vt.TenVTu,Sum(ctdh.SoLuongDat) as Tongsld into #tong from tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu join tblDONDH dh on ctdh.SoDH = dh.SoDH
where convert(char(7),NgayDH,21) = @Ngay Group by vt.TenVTu order by Sum(ctdh.SoLuongDat) DESC 
select vt.TenVTu,Sum(ctdh.SoLuongDat) as Tongsldf from tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu join tblDONDH dh on ctdh.SoDH = dh.SoDH
where convert(char(7),NgayDH,21) = @Ngay Group by vt.TenVTu having Sum(ctdh.SoLuongDat) = (select max(tongsld) from #tong)
drop table #tong 
end 
go
exec vidu33 '2025-02'
drop proc vidu33
-- Ví dụ 5: Hiện vật tư nào có số lượng đặt hàng lớn nhất
create proc vidu5 @ten nvarchar(255) output 
as 
begin
select vt.TenVTu,Sum(ctdh.SoLuongDat) as Tongsld into #tong from tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu
join tblDONDH dh on dh.SoDH = ctdh.SoDH group by vt.TenVTu
select @ten = TenVTu from #tong where Tongsld = (Select max(Tongsld) from #tong)
drop table #tong
end 
go 
declare @ten nvarchar(255)
exec vidu5 @ten output 
print @ten 
drop proc vidu5 

-- Ví dụ 4: Tạo thủ tục cho biết tiền phải trả cho nhà cung cấp A.Input: tên nhà cung cấp
create proc vidu4 @Ten nvarchar(50), @TongTien int output 
as 
begin 
if not exists (Select * from tblNhaCungCap where TenNCC = @Ten) return 1
else if not exists (Select * from tblChiTietDH ctdh join tblDONDH dh on ctdh.SoDH = dh.SoDH join tblNhaCungCap ncc on dh.MaNCC= ncc.MaNCC
join tblVatTu vt on ctdh.MaVTu = vt.MaVTu group by ncc.TenNCC having ncc.TenNCC = @Ten ) return 2
else select @TongTien = Sum(ctdh.SoLuongDat*vt.DonGia)  from tblChiTietDH ctdh join tblDONDH dh on ctdh.SoDH = dh.SoDH join tblNhaCungCap ncc on dh.MaNCC= ncc.MaNCC
join tblVatTu vt on ctdh.MaVTu = vt.MaVTu group by ncc.TenNCC having ncc.TenNCC = @Ten return 
end 
declare @tt int,@rt int 
exec @rt = vidu4 N'Nhà Cung Cấp A',@tt output 
if @rt=1 print N'Không Có Nhà CC Này'
else if @rt=2 print N'Nhà CC này chưa có gì'
else print N'Tổng Tiền : '+cast (@tt as char(10))
drop proc vidu4 

-- 1. Viết thủ tục với đầu vào là số phiếu nhập, ra là tổng tiền của số phiếu nhập này, yêu cầu: nếu không tồn tại số phiếu nhập thì hiện dòng
-- thông báo
create proc cau1 @SoPN char(5), @TongTien int output as
begin 
if exists (Select * from tblCTPNHAP where SoPN = @SoPN)
Select @TongTien = Sum(ctpn.SoLuongNhap * ctpn.DonGiaNhap) 
from tblCTPNHAP ctpn join tblVatTu vt on ctpn.MaVTu = vt.MaVTu where ctpn.SoPN = @SoPN group by SoPN
else print N'Không có phiếu nhập hàng này '+@SoPN 
end 
go
declare @tt int 
exec cau1 'PN001' , @tt output 
print @tt 
drop proc cau1 

-- 1.2. Tạo thủ tục tính tổng tiền của 1 phiếu nhập hàng
create proc bai1_2 @SoPN char(5), @TongTien int output 
as 
begin 
if exists (Select * from tblCTPNHAP where SoPN=@SoPN)
Select @TongTien= Sum(ctn.DonGiaNhap*ctn.SoLuongNhap) from tblVatTu vt join tblCTPNHAP ctn on vt.MaVTu = ctn.MaVTu
Where ctn.SoPN=@SoPN group by SoPN 
else print N'Không Có Phiếu Nhập Hàng '+ @SoPN 
end 
go
declare @TongTien int 
exec bai1_2 'PN003',@TongTien output 
print @TongTien
drop proc bai1_2 
-- 1.3. Tạo thủ tục tính tổng tiền của 1 phiếu xuất hàng.
create proc bai1_3 @SoPX char(5), @TongTien int output 
as 
begin 
if exists (Select * from tblCTPXUAT where SoPX=@SoPX)
Select @TongTien= Sum(ctx.DonGiaXuat*ctx.SoLuongXuat) from tblVatTu vt join tblCTPXUAT ctx on vt.MaVTu = ctx.MaVTu
Where ctx.SoPX=@SoPX group by SoPX 
else print N'Không Có Phiếu Xuất Hàng '+ @SoPX 
end 
go
declare @TongTien int 
exec bai1_3 'PX001',@TongTien output 
print @TongTien
drop proc bai1_3 

-- 1. Viết thủ tục cập nhật dữ liệu cho bảng tblCTDonDH, với yêu cầu kiểm tra khóa chính, khóa ngoại, miền giá trị: 10 <= SLDat <=500 
create proc capnhatdulieu @SoDH char(5), @MaVTu char(5), @SoLuongDat int 
as
begin 
if not exists (SELECT * FROM tblChiTietDH WHERE SoDH = @SoDH AND MaVTu = @MaVTu)
begin
print N'Lỗi: Không tìm thấy dữ liệu để cập nhật!' 
return 
end
if not exists (Select * from tblDONDH where SoDH = @SoDH)
begin
print N'Mã Đơn Hàng này không tồn tại!' 
return 
end
if not exists (Select * from tblVatTu where MaVTu = @MaVTu)
begin
print N'Mã Vật Tư này không tồn tại!' 
return 
end
if @SoLuongDat < 10 or @SoLuongDat > 500 
begin
Print N'Số lượng đặt phải trong khoảng 10 đến 500!'
return 
end 
UPDATE tblChiTietDH set SoLuongDat = @SoLuongDat where SoDH = @SoDH AND MaVTu = @MaVTu
print N'Cập nhật thành công!'
end 
go 
Exec capnhatdulieu 'DH001' , 'VT003' , 100
drop proc capnhatdulieu
-- 2. Viết thủ tục cập nhật dữ liệu cho bảng tblPNhap, với yêu cầu kiểm tra khóa chính, khóa ngoại, miền giá trị: NgayNhap phải sau NgayDH ở
--bảng tblDonDH của SoDH này.
create proc capnhatdulieu @SoPN char(5), @SoDH char(5), @NgayNhap date  
as
begin 
if not exists (SELECT * FROM tblPNHAP WHERE SoPN = @SoPN and SoDH = @SoDH )
begin
print N'Lỗi: Không tìm thấy dữ liệu để cập nhật!' 
return 
end
if not exists (Select * from tblDONDH where SoDH = @SoDH)
begin
print N'Mã Đơn Hàng này không tồn tại!' 
return 
end
Declare @NgayDH date
select @NgayDH = NgayDH from tblDONDH where SoDH = @SoDH
if @NgayNhap <= @NgayDH
begin
print N'Lỗi: Ngày nhập phải sau ngày đặt hàng (' + CAST(@NgayDH AS NVARCHAR) + N')!'
return
end
UPDATE tblPNHAP set NgayNhap = @NgayNhap where SoPN = @SoPN AND SoDH = @SoDH
print N'Cập nhật thành công!'
end 
Exec capnhatdulieu 'PN001' , 'DH001' , '2025-04-03'
drop proc capnhatdulieu
-- 3. Viết thủ tục cập nhật dữ liệu cho bảng tblCTPNhap, với yêu cầu kiểm tra khóa chính, khóa ngoại, miền giá trị: 
--SLNhap phải <= SLDat - tổng số lượng đã nhập của các phiếu nhập có cùng số đặt hàng này
create proc capnhatdulieu @SoPN char(5), @MaVTu char(5), @SoLuongNhap int,@DonGiaNhap int 
as
begin 
if not exists (SELECT * FROM tblCTPNHAP WHERE SoPN = @SoPN and MaVTu = @MaVTu )
begin
print N'Lỗi: Không tìm thấy dữ liệu để cập nhật!' 
return 
end
if not exists (Select * from tblPNHAP where SoPN = @SoPN)
begin
print N'Số PN không tồn tại!' 
return 
end
if not exists (SELECT * FROM tblVatTu where MaVTu = @MaVTu)
begin
print N'Lỗi: Mã Vật Tư không tồn tại!'
return 
end
declare @SoDH char(5);
select @SoDH = SoDH from tblPNHAP where SoPN = @SoPN
declare @SLDat int
select @SLDat = SoLuongDat from tblChiTietDH where SoDH = @SoDH AND MaVTu = @MaVTu
declare @TongSLNhap int
select @TongSLNhap =  Sum(@SoLuongNhap) from tblCTPNhap where SoPN IN (select SoPN from tblPNHAP where SoDH = @SoDH) and MaVTu = @MaVTu

if @SoLuongNhap <= 0
begin
print N'Lỗi: Số lượng nhập phải lớn hơn 0!';
return 
end
if @SoLuongNhap > (@SLDat - @TongSLNhap)
begin
print N'Lỗi: Số lượng nhập vượt quá số lượng đặt còn lại!';
print N'Số lượng đặt: ' + CAST(@SLDat AS NVARCHAR) + N' | Đã nhập: ' + CAST(@TongSLNhap as nvarchar) + 
N' | Còn lại: ' + CAST((@SLDat - @TongSLNhap) as nvarchar)
return
end

if @DonGiaNhap <= 0
begin
print N'Lỗi: Đơn giá nhập phải lớn hơn 0!';
return
end
UPDATE tblCTPNhap SET SoLuongNhap = @SoLuongNhap, DonGiaNhap = @DonGiaNhap where SoPN = @SoPN AND MaVTu = @MaVTu;
print N'Cập nhật thành công!'
end
go
Exec capnhatdulieu 'PN001','VT001' ,500000 ,50000
drop proc capnhatdulieu

-- Ví dụ 7: Xây dựng thủ tục hiện thị dữ liệu cho báo cáo đơn đặt hàng.Tham số vào soDH, nếu gọi thủ tục mà không truyền tham số thì xem như
-- hiện thị toàn bộ các Sodh có trong bảng tblDondh.

create proc vidu7 @sSohd char(5) = NULL
as
begin
if @sSohd is Null
select dh.sodh, vt.TenVTu, ct.SoLuongDat, ncc.TenNCC
from tbldondh dh join tblChiTietDH ct on dh.sodh = ct.sodh join tblNhaCungCap ncc on dh.MaNCC=ncc.MaNCC join tblvattu vt on ct.mavtu = vt.mavtu
order by dh.sodh, vt.tenvtu
else
select dh.sodh, vt.TenVTu, ct.SoLuongDat, ncc.TenNCC
from tbldondh dh join tblChiTietDH ct on dh.sodh = ct.sodh join tblNhaCungCap ncc on dh.MaNCC=ncc.MaNCC join tblvattu vt on ct.mavtu = vt.mavtu
Where dh.sodh = @sSohd
order by vt.tenvtu
end 
go
EXEC vidu7 'DH001'
drop proc vidu7 

-- 1. Xây dựng thủ tục hiện thị dữ liệu cho báo cáo xuất hàng: tên vật tư, số lượng xuất, đơn giá, tổng tiền.
-- Tham số vào soPX, nếu gọi thủ tục mà không truyền tham số thì xem như hiện thị toàn bộ các SoPX có trong bảng tblpxuat.
create proc bai1 @SoPX char(5)=null 
as
begin
if @SoPX is null
select ctpx.SoPX,vt.TenVTu,ctpx.SoLuongXuat,vt.DonGia,(ctpx.SoLuongXuat*vt.DonGia) [Tổng tiền]
from tblCTPXUAT ctpx join tblVATTU vt on ctpx.MaVTu=vt.MaVTu
else
select ctpx.SoPX,vt.TenVTu,ctpx.SoLuongXuat,vt.DonGia,(ctpx.SoLuongXuat*vt.DonGia) [Tổng tiền] 
from tblCTPXUAT ctpx join tblVATTU vt on ctpx.MaVTu=vt.MaVTu
where ctpx.SoPX=@SoPX
end
go
exec bai1 'PX001'
drop proc bai1 
-- 2. Xây dựng thủ tục hiện thị dữ liệu cho báo cáo gồm Họ tên nhà cung cấp, tên vật tư, số lượng đặt, tổng tiền. Tham số vào tên nhà cung
-- cấp, nếu gọi thủ tục mà không truyền tham số thì xem như hiện thị toàn bộ các nhà cc.
create proc bai2 @TenNCC nvarchar(30)=null
as
begin
if @TenNCC is null
select ncc.TenNCC,vt.TenVTu,ct.SoLuongDat,(ct.SoLuongDat*vt.DonGia) [Tổng tiền] 
from tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC=dh.MaNCC
join tblChiTietDH ct on dh.SoDH=ct.SoDH
join tblVATTU vt on ct.MaVTu=vt.MaVTu
else
select ncc.TenNCC,vt.TenVTu,ct.SoLuongDat,(ct.SoLuongDat*vt.DonGia) [Tổng tiền] 
from tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC=dh.MaNCC
join tblChiTietDH ct on dh.SoDH=ct.SoDH
join tblVATTU vt on ct.MaVTu=vt.MaVTu
where ncc.TenNCC=@TenNCC
end
go
exec bai2 N'Nhà Cung Cấp A'