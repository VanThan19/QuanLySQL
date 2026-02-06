create database QLNV1
use QLNV1

create table tblPhongBan 
(
MaPB char(5) primary key not null,
TenPhong nvarchar(50) not null,
SoDienThoai varchar(15) not null
)

create table tblNhanVien 
(
MaNV char(5) primary key not null,
HoTen nvarchar(50) not null,
NgaySinh date not null,
GioiTinh int not null ,
MaPB char(5) foreign key references tblPhongBan(MaPB)
)

create table tblKhenThuong
(
MaNV char(5) foreign key references tblNhanVien(MaNV),
TenKhenThuong nvarchar(100) not null,
NgayKhenThuong date not null
)

insert into tblPhongBan values 
('PB001', N'Phòng Kế toán', '0123456789'),
('PB002', N'Phòng Nhân sự', '0987654321'),
('PB003', N'Phòng IT', '0369854721'),
('PB004', N'Phòng Marketing', '0271593846'),
('PB005', N'Phòng Kinh doanh', '0584736192')

insert into tblNhanVien values 
('NV001', N'Nguyễn Văn A', '2000-05-20', 1, 'PB001'),
('NV002', N'Trần Thị B', '2005-08-15', 0, 'PB002'),
('NV003', N'Lê Hoàng C', '2004-12-10', 1, 'PB003'),
('NV004', N'Phạm Minh D', '1999-07-25', 1, 'PB004'),
('NV005', N'Bùi Thị E', '2001-03-30', 0, 'PB005'),
('NV006', N'Nguyễn Văn K', '2000-05-05', 1, 'PB001')
insert into tblKhenThuong values
('NV001', N'Nhân viên xuất sắc', '2025-01-15'),
('NV002', N'Cống hiến lâu dài', '2025-02-10'),
('NV003', N'Ý tưởng sáng tạo', '2025-03-05'),
('NV004', N'Thành tích xuất sắc', '2025-04-20'),
('NV005', N'Đóng góp tích cực', '2025-05-01')

--1.Viết thủ tục lưu trữ (stored procedure) để tự động tạo mã nhân viên (MaNV) cho bảng tblNhanVien. Mã nhân viên được tạo theo quy tắc: ghép tiền
-- tố "NV" với số thứ tự tăng dần (ví dụ: NV001, NV002,...). Giả sử mã nhân viên lớn nhất hiện tại là NV008, thủ tục sẽ tạo ra NV009.
create proc vd1 @MaNV char(5) output 
as
declare @ma char(5)
select @ma = max(MaNV) from tblNhanVien
declare @so int 
set @so = convert(int , right(@ma,2))+1
set @ma = '00' + convert(char(5),@so)
set @MaNV = 'NV' + right(trim(@ma),2)

declare @MaNV char(5)
exec vd1 @MaNV output
print @MaNV 
--2.Sử dụng con trỏ (CURSOR) để in ra danh sách gồm họ tên nhân viên và tên hình thức khen thưởng của tất cả nhân viên.
declare vd2 cursor for 
select nv.HoTen, kt.TenKhenThuong from tblNhanVien nv left join tblKhenThuong kt on nv.MaNV = kt.MaNV
open vd2 
while 1=1 
begin 
declare @HoTen nvarchar(50), @TenKhenThuong nvarchar(100)
fetch next from vd2 into @HoTen,@TenKhenThuong
if @@FETCH_STATUS !=0 break;
print @HoTen + @TenKhenThuong
end 
close vd2
deallocate vd2 
--3.Viết hàm số (function) trả về số lượng nhân viên trong một phòng ban cụ thể (truyền vào MaPB).
create function vd3 (@MaPB char(5))
returns int 
as
begin 
declare @SoLuongNV int 
select @SoLuongNV = count(*) from tblNhanVien where MaPB = @MaPB 
return @SoLuongNV 
end

print dbo.vd3 ('PB001')
--4.Viết trigger để đảm bảo tính toàn vẹn dữ liệu khi thêm hoặc cập nhật bản ghi trong bảng tblNhanVien:
--MaPB phải tồn tại trong bảng tblPhongBan.
--GioiTinh chỉ được nhận giá trị 0 hoặc 1.
--NgaySinh không được là một ngày trong tương lai.
create trigger vd4 
on tblNhanVien 
instead of insert as
if not exists (Select * from tblPhongBan pb join inserted i on pb.MaPB = i.MaPB)
print N'Mã phòng ban không tồn tại'
else if exists (Select * from inserted where GioiTinh not in (0,1))
print N'Giới tính chỉ nhận giá trị 0 hoặc 1';
else if exists (Select * from inserted where NgaySinh > GetDate())
print N'Ngày sinh không thể là ngày trong tương lai'
else if not exists (select * from deleted)
begin 
insert into tblNhanVien select * from inserted 
end 
else 
begin
update tblNhanVien set HoTen = i.HoTen, NgaySinh = i.NgaySinh, GioiTinh = i.GioiTinh, MaPB = i.MaPB
from tblNhanVien nv join inserted i on nv.MaNV = i.MaNV
end
--
insert into tblNhanVien values ('NV007', N'Nguyễn Văn A', '2000-05-20', 1, 'PB006') -- Lỗi MaPB không tồn tại
insert into tblNhanVien values ('NV008', N'Nguyễn Văn A', '2000-05-20', 9, 'PB001') -- Lỗi Giới tính 0,1 
insert into tblNhanVien values ('NV009', N'Nguyễn Văn A', '2025-05-29', 1, 'PB001') -- Lỗi ngày sinh 
insert into tblNhanVien values ('NV010', N'Nguyễn Văn T', '2000-05-09', 1, 'PB001') -- Okeee

