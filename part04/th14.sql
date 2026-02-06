create database QLUH 
use QLUH 

create table tblDonVi 
(
MaDVUH char(5) primary key not null,
HoTenNguoiDaiDien nvarchar(50) not null,
DiaChi nvarchar(50) not null,
DienThoai nvarchar(15) not null
)

create table tblDotUngHo 
(
MaDotUngHo char(5) primary key not null,
MaDVUH char(5) foreign key references tblDonVi(MaDVUH),
NgayUngHo date not null
)

create table tblChiTietUngHo 
(
MaDotUngHo char(5) foreign key references tblDotUngHo(MaDotUngHo),
HinhThucUH nvarchar(50) not null,
SoLuongUngHo int
)

insert into tblDonVi values 
('DV001', N'Nguyễn Văn A', N'Hà Nội', '0987654321'),
('DV002', N'Trần Thị B', N'Hồ Chí Minh', '0976543210'),
('DV003', N'Lê Văn C', N'Nghệ An', '0965432109'),
('DV004', N'Phạm Thị D', N'Hải Phòng', '0954321098'),
('DV005', N'Hồ Văn E', N'Cần Thơ', '0943210987');

insert into tblDotUngHo values
('DUH01', 'DV001', '2025-05-01'),
('DUH02', 'DV002', '2025-05-05'),
('DUH03', 'DV003', '2025-05-10'),
('DUH04', 'DV004', '2025-05-15'),
('DUH05', 'DV005', '2025-05-20');

insert into tblChiTietUngHo values
('DUH01', N'Tiền mặt', 5000000),
('DUH02', N'Thực phẩm', 100),
('DUH03', N'Quần áo', 50),
('DUH04', N'Dụng cụ học tập', 200),
('DUH05', N'Thuốc men', 30);

-- 1.Dùng biến con trỏ CURSOR hiện thị cho xem HoTenNguoiDaiDien, DiaChi, DienThoai, NgayUngHo, SoLuongUngHo của hình thức ủng hộ (HinhThucUH)là A
declare bt1 cursor for
select dv.HoTenNguoiDaiDien,dv.DiaChi,dv.DienThoai,duh.NgayUngHo,ct.SoLuongUngHo
from tblDonVi dv join tblDotUngHo duh on dv.MaDVUH = duh.MaDVUH join tblChiTietUngHo ct on ct.MaDotUngHo = duh.MaDotUngHo
where ct.HinhThucUH = N'Tiền mặt'
open bt1 

while 1=1
begin
declare @HoTenNguoiDaiDien nvarchar(50),@DiaChi nvarchar(50),@DienThoai nvarchar(15),@NgayUngHo date,@SoLuongUngHo int 
fetch next from bt1 into @HoTenNguoiDaiDien,@DiaChi,@DienThoai,@NgayUngHo,@SoLuongUngHo
if @@FETCH_STATUS !=0 break;
print @HoTenNguoiDaiDien + @DiaChi +@DienThoai+  CAST(@NgayUngHo AS NVARCHAR)+ CAST(@SoLuongUngHo AS NVARCHAR)
end
close bt1
deallocate bt1

-- 2.Viết thủ tục đầu vào là hình thức ủng hộ (HinhThucUH), kết quả in ra là danh sách các thông tin HoTenNguoiDaiDien, DiaChi, DienThoai,
-- NgayUngHo, SoLuongUngHo của HinhThucUH đó.
create proc bt2 @HinhThucUH nvarchar(50) as
select dv.HoTenNguoiDaiDien,dv.DiaChi,dv.DienThoai,duh.NgayUngHo,ct.SoLuongUngHo
from tblDonVi dv join tblDotUngHo duh on dv.MaDVUH = duh.MaDVUH join tblChiTietUngHo ct on ct.MaDotUngHo = duh.MaDotUngHo
where ct.HinhThucUH = @HinhThucUH
exec bt2 N'Tiền Mặt'

-- 3.Viết hàm tạo bảng gồm các thông tin HoTenNguoiDaiDien, DiaChi, DienThoai, NgayUngHo, SoLuongUngHo với  tham số đầu vào là HinhThucUH.
create function bt3 (@HinhThucUH nvarchar(50))
returns table 
as
return 
(
select dv.HoTenNguoiDaiDien,dv.DiaChi,dv.DienThoai,duh.NgayUngHo,ct.SoLuongUngHo
from tblDonVi dv join tblDotUngHo duh on dv.MaDVUH = duh.MaDVUH join tblChiTietUngHo ct on ct.MaDotUngHo = duh.MaDotUngHo
where ct.HinhThucUH = @HinhThucUH
)
-- lời gọi 
select * from dbo.bt3 (N'Tiền mặt')
-- 4.Tạo thủ tục cho xem tổng SoLuongUngHo của HoTenNguoiDaiDien là A, với tham số đầu vào là A đó. Nếu A không tồn tại, cho dòng thông báo
create proc bt4 @HoTenNguoiDaiDien nvarchar(50) as
begin 
if not exists (Select * from tblDonVi where HoTenNguoiDaiDien = @HoTenNguoiDaiDien)
print N'Họ tên người đại diện không tồn tại!!!'
else 
select dv.MaDVUH , sum(ct.SoLuongUngHo) [Tổng số lượng ủng hộ]
from tblDonVi dv join tblDotUngHo duh on dv.MaDVUH = duh.MaDVUH join tblChiTietUngHo ct on ct.MaDotUngHo = duh.MaDotUngHo
where dv.HoTenNguoiDaiDien = @HoTenNguoiDaiDien group by dv.MaDVUH
end 
-- lời gọi
exec bt4 N'Nguyễn Văn A'
-- 5.Viết thủ tục tạo MaDVUH trong bảng tblDonViUngHo tự động….
create proc bt5 @MaDVUH char(5) output 
as
declare @ma char(5)
select @ma = max(MaDVUH) from tblDonVi
declare @so int 
set @so = convert(int , right(@ma,3)) + 1
set @ma = '000' + convert(char(5),@so)
set @MaDVUH = 'DV' + right(trim(@ma),3)
-- lời gọi
declare @MaDV char(5)
exec bt5 @MaDV output 
print @MaDV
-- 6.Viết thủ tục xóa MaDotUngHo là A có trong bảng tblDotUngHo và bảng tblChiTietUngHo là tham số đầu vào là A đó
create proc bt6 @MaDotUngHo char(5) as
begin 
delete from tblChiTietUngHo where MaDotUngHo = @MaDotUngHo
delete from tblDotUngHo where MaDotUngHo = @MaDotUngHo
end 
exec bt6 'DUH05'

-- 7.Tạo thủ tục cập nhật dữ liệu cho tblChiTietUngHo với yêu cầu kiểm tra tính hợp lệ: không trùng khóa chính và kiểm tra dữ liệu khóa ngoại.
create or alter proc bt7 @MaDotUH char(5),@HinhThucUH nvarchar(50),@SoLuongUH int as
begin 
if not exists (select * from tblDotUngHo where MaDotUngHo = @MaDotUH)
print N'Lỗi mã đợt ủng hộ không tồn tại!!'
else 
begin 
Insert into tblChiTietUngHo values (@MaDotUH,@HinhThucUH,@SoLuongUH)
print N'Đã cập nhật dữ liệu cho bảng tblChiTietUngHo thành công.'
end 
end 
-- lời gọi
exec bt7 'DUH04',N'Mì tôm',500
-- 8.Xây dựng thủ tục hiện thị dữ liệu cho báo cáo với tham số vào HinhThucUH, ra là HoTenNguoiDaiDien, DiaChi, DienThoai, NgayUngHo, SoLuongUngHo.
-- Nếu gọi thủ tục mà không truyền tham số thì xem như hiện thị toàn bộ các thông tin trên của toàn bộ HinhThucUH có trong bảng.
create proc bt8 @HinhThucUH nvarchar(50) = null as
begin 
if @HinhThucUH is null 
begin 
select dv.HoTenNguoiDaiDien,dv.DiaChi,dv.DienThoai,duh.NgayUngHo,ct.SoLuongUngHo
from tblDonVi dv join tblDotUngHo duh on dv.MaDVUH = duh.MaDVUH join tblChiTietUngHo ct on ct.MaDotUngHo = duh.MaDotUngHo
end
else 
begin 
select dv.HoTenNguoiDaiDien,dv.DiaChi,dv.DienThoai,duh.NgayUngHo,ct.SoLuongUngHo
from tblDonVi dv join tblDotUngHo duh on dv.MaDVUH = duh.MaDVUH join tblChiTietUngHo ct on ct.MaDotUngHo = duh.MaDotUngHo
where ct.HinhThucUH = @HinhThucUH
end
end
-- lời gọi
exec bt8 N'Tiền mặt'
exec bt8
-- 9.Viết thủ tục kiểu CURSOR cho xem HoTenNguoiDaiDien, NgayUngHo, SoLuongUngHo của tất cả các đơn vị ủng hộ.
create proc bt9 @cs1 cursor varying output as
set @cs1 = cursor for 
select dv.HoTenNguoiDaiDien, duh.NgayUngHo, ct.SoLuongUngHo
from tblDonVi dv join tblDotUngHo duh on dv.MaDVUH = duh.MaDVUH join tblChiTietUngHo ct on ct.MaDotUngHo = duh.MaDotUngHo
open @cs1 
declare @cursor1 cursor 
exec bt9 @cursor1 output 
declare @HoTenNguoiDaiDien nvarchar(50), @NgayUngHo date, @SoLuongUngHo int 
while 1=1 
begin 
fetch next from @cursor1 into @HoTenNguoiDaiDien,@NgayUngHo,@SoLuongUngHo
if @@FETCH_STATUS !=0 break;
else 
print @HoTenNguoiDaiDien + CAST(@NgayUngHo AS NVARCHAR)+ CAST(@SoLuongUngHo AS NVARCHAR)
end 
close @cursor1 
deallocate @cursor1 

-- 10.Viết hàm cho xem HoTenNguoiDaiDien của MaDVUH là A, với tham số đầu vào là A đó
create function bt10 (@MaDVUH char(5))
returns nvarchar(50)
as
begin 
declare @HoTenNguoiDaiDien nvarchar(50)
Select @HoTenNguoiDaiDien = HoTenNguoiDaiDien from tblDonVi where MaDVUH = @MaDVUH
return @HoTenNguoiDaiDien 
end
-- lời gọi 
print dbo.bt10 ('DV001')

-- 11.Viết hàm với tham số vào hình thức ủng hộ (HinhThucUH),  ra là HoTenNguoiDaiDien, DiaChi, DienThoai, NgayUngHo, SoLuongUngHo.
create function bt11 (@HinhThucUH nvarchar(50))
returns table 
as
return 
(
select dv.HoTenNguoiDaiDien, duh.NgayUngHo, ct.SoLuongUngHo
from tblDonVi dv join tblDotUngHo duh on dv.MaDVUH = duh.MaDVUH join tblChiTietUngHo ct on ct.MaDotUngHo = duh.MaDotUngHo
where ct.HinhThucUH = @HinhThucUH
)
select * from dbo.bt11(N'Tiền mặt')
-- 12.Viết hàm tạo MaDVUH trong bảng tblDonViUngHo tự động ….
create function bt12 ()
returns char(5)
as
begin
declare @ma char(5)
select @ma = max(MaDVUH) from tblDonVi
declare @so int 
set @so = convert(int ,right(@ma,3))+1
set @ma = '000' + convert(char(5),@so)
return 'DV' + RIGHT(trim(@ma),3)
end 
-- lời gọi
select dbo.bt12() as MaMoi

-- 13.Viết thủ tục CURSOR tìm MaDotUngHo có HoTenNguoiDaiDien là A (với A là tham số đầu vào), để xóa tất cả các bản ghi có tên MaDotUngHo đó 
-- trong bảng tblDotUngHo và bảng tblChiTietUngHo.
create proc bt13 @HoTenNguoiDaiDien nvarchar(50),@cs2 cursor varying output 
as
set @cs2 = cursor for 
select duh.MaDotUngHo
from tblDonVi dv join tblDotUngHo duh on dv.MaDVUH = duh.MaDVUH where dv.HoTenNguoiDaiDien = @HoTenNguoiDaiDien
open @cs2 

declare @cur2 cursor
exec bt13 N'Nguyễn Văn A',@cur2 output
declare @MaDotUngHo char(5)
while 1=1 
begin 
fetch next from @cur2 into @MaDotUngHo 
if @@FETCH_STATUS != 0 break
else 
begin
delete from tblChiTietUngHo where MaDotUngHo = @MaDotUngHo
delete from tblDotUngHo where MaDotUngHo = @MaDotUngHo
fetch next from @cur2 into @MaDotUngHo
end
end
close @cur2
deallocate @cur2
