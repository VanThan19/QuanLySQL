use QLBanHangg 

--1.Viết thủ tục hiện họ tên nhà cung cấp, Điện thoại của nhà cung cấp đã có đơn đặt hàng trong tháng 02-2025
create proc bai_1
as
select ncc.TenNCC,ncc.sdt from tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC=dh.MaNCC
where convert(char(7),dh.NgayDH,121)='2025-02'
go
exec bai_1

--2.Viết thủ tục hiện danh sách các nhà cung cấp, số đặt hàng, tên vật tư chưa nhập hàng đủ so với đơn đặt hàng
create proc bai_2
as
select ncc.TenNCC,dh.SoDH,vt.TenVTu from tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC=dh.MaNCC
join tblChiTietDH ct on dh.SoDH=ct.SoDH
join tblVatTu vt on ct.MaVTu=vt.MaVTu
join tblCTPNHAP ctn on vt.MaVTu=ctn.MaVTu
where ct.SoLuongDat>ctn.SoLuongNhap
go
exec bai_2
--3.Viết thủ tục hiện danh sách các nhà cung cấp mà công ty chưa bao giờ đặt hàng
create proc bai_3
as
select ncc.MaNCC,ncc.TenNCC from tblNhaCungCap ncc left join tblDONDH dh on ncc.MaNCC=dh.MaNCC
where dh.MaNCC is null
go
exec bai_3
--4.Viết thủ tục thống kê vật tư X có bao nhiêu số phiếu xuất (X là tham số vào)
create proc bai_4 @MaVTu char(5)
as select @MaVTu [Mã Vật Tư],count(SoPX)[Số Phiếu Xuất] from tblCTPXUAT 
where MaVTu=@MaVTu
go
exec bai_4 'VT001'

--5.Viết thủ tục thêm 1 bản ghi vào bảng tblPNhap sao cho đảm bảo các yêu cầu về ràng buộc dữ liệu:
--SoPN không được trùng
--SoDH phải có trong bảng tblDonDH
--NgayNhap < = Ngày hiện tại
create proc bai_5 @SoPN char(5),@SoDH char(5),@NgayNhap date
as
if exists(select *from tblPNHAP where SoPN=@SoPN)
print N'Lỗi!!!Số PN bị trùng, không thể thêm được'
else if not exists(select *from tblDONDH where SoDH=@SoDH)
print N'Lỗi!!!Số DH không hợp lệ vì không có trong bảng tblDonDH'
else if @NgayNhap>GETDATE()
print N'Lỗi!!!Ngày nhập lớn hơn ngày hiện tại'
else
  begin 
     insert into tblPNHAP values(@SoPN,@SoDH,@NgayNhap)
	 print N'Thêm PN thành công'
   end
go
exec bai_5 'PN010','DH001','2025-01-01'
select * from tblPNHAP

--6.Viết thủ tục thêm 1 bản ghi vào bảng tblCTPNhap sao cho đảm bảo các yêu cầu về ràng buộc dữ liệu:
---SoPN phải có trong bảng tblPNhap
---Mã vật tư phải có trong bảng tblVatTu
---SLNhap > 0 và SLNhap <= SLDat của đơn đặt hàng trong bảng tblCTDonDH 
create proc bai_6 @SoPN char(5),@MaVTu char(5),@SoLuongNhap int,@DonGia decimal(18,2)
as
declare @SoLuongDat int
select @SoLuongDat=SoLuongDat from tblChiTietDH where MaVTu=@MaVTu
if  not exists(select *from tblPNHAP where SoPN=@SoPN)
print N'Lỗi!!!Số PN không ở trong bảng tblPNhap'
else if not exists(select *from tblVATTU where MaVTu=@MaVTu)
print N'Lỗi!!!Mã vật tư không ở trong bảng tblVatTu'
else if @SoLuongNhap<=0
print N'Lỗi!!!Số lượng nhập phải lớn hơn 0'
else if @SoLuongNhap>@SoLuongDat
print N'Lỗi!!!Số lượng nhập lớn hơn số lượng đặt'
else
   begin
      insert into tblCTPNHAP values(@SoPN,@MaVTu,@SoLuongNhap,@DonGia)
	  print N'Thêm thành công dữ liệu'
   end
go 
exec bai_6 'PN001','VT002',10,500.00
select * from tblCTPNHAP
