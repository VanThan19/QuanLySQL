create database QLSinhVien 
use QLSinhVien 

create table Khoa
(
MaKhoa int primary key ,
TenKhoa nvarchar(50) not null,
)
create table SinhVien
(
MaSV char(5) primary key,
TenSV nvarchar(50) not null,
MaKhoa int foreign key references Khoa(MaKhoa),
NgaySinh date not null 
)
create table MonHoc 
(
MaMH char(5) primary key,
TenMH nvarchar(50) not null,
SoTinChi int not null,
)
create table SinhVien_MonHoc
(
Ma_SV_MH int primary key,
MaSV char(5) foreign key references SinhVien(MaSV),
MaMH char(5) foreign key references MonHoc(MaMH)
)

insert into Khoa values 
(1, N'CNTT'),
(2, N'Kinh tế'),
(3, N'Ngoại ngữ'),
(4, N'Luật'),
(5, N'Y Dược')

insert into SinhVien values
('SV001', N'Nguyễn Văn Thân', 1, '2000-05-15'),
('SV002', N'Trần Thị Bích', 2, '1999-08-20'),
('SV003', N'Lê Đình Văn', 1, '2001-12-10'),
('SV004', N'Hoàng Minh Thắng', 3, '2000-03-25'),
('SV005', N'Hoàng Văn Phụng', 4, '1998-07-07')

insert into MonHoc values
('MH001', N'Lập trình C', 3),
('MH002', N'Kinh tế vĩ mô', 4),
('MH003', N'Tiếng Anh giao tiếp', 2),
('MH004', N'Luật dân sự', 3),
('MH005', N'Giải phẫu cơ thể', 5)

insert into SinhVien_MonHoc values
(1, 'SV001', 'MH001'),
(2, 'SV002', 'MH002'),
(3, 'SV003', 'MH003'),
(4, 'SV004', 'MH004'),
(5, 'SV005', 'MH005')

--1.Viết hàm nhận vào MaSV và trả về tuổi của sinh viên đó dựa trên trường NgaySinh. 
create function f_bai1(@MaSV char(5))
returns int
as
begin
declare @Age int 
select @Age =(Year(GetDate())-YEAR(NgaySinh)) from SinhVien where MaSV=@MaSV
return @Age
end
-- lời gọi hàm 
print dbo.f_bai1('SV001')

--2.Viết hàm nhận vào MaKhoa và trả về số lượng sinh viên thuộc khoa đó. 
create function f_bai2(@MaKhoa int)
returns int
as
begin
declare @Count int
select @Count = count(*) from SinhVien where MaKhoa = @MaKhoa
return @Count
end
-- lời gọi hàm 
print dbo.f_bai2(1)
--3.Viết hàm nhận vào một khoảng thời gian (ngày bắt đầu và ngày kết thúc) và trả về danh sách tất cả sinh viên có ngày sinh nằm trong khoảng thời gian đó, bao gồm MaSV, TenSV, và NgaySinh. 
create function f_bai3(@BatDau date, @KetThuc date)
returns table
as
return
(
select MaSV, TenSV, NgaySinh from SinhVien where NgaySinh BETWEEN @BatDau AND @KetThuc
)
-- lời gọi hàm 
select * from dbo.f_bai3('1975-04-30','2025-04-30')
--4.Viết thủ tục nhận vào MaKhoa và in ra danh sách tên của tất cả sinh viên thuộc khoa đó. Nếu MaKhoa không tồn tại thì in ra thông báo.Nếu không truyền tham số vào thì hiện sinh viên của tất cả các khoa.
create proc proc_bai4  @MaKhoa int = null
as
begin
if @MaKhoa is not null and not exists(select * from Khoa where MaKhoa = @MaKhoa)
begin
print N'Khoa không tồn tại'
return
end
select TenSV from SinhVien where @MaKhoa is null or MaKhoa = @MaKhoa
end
-- lời gọi 
exec proc_bai4 @MaKhoa = 1
--5.Viết một hàm nhận vào MaKhoa và trả về một bảng chứa TenSV và TenMH của tất cả sinh viên thuộc khoa đó. 
--Nếu một sinh viên chưa đăng ký môn học nào, vẫn hiển thị tên sinh viên và cột TenMH để giá trị NULL.(Giả sử có một bảng KetQua liên kết SinhVien và MonHoc). (Gợi ý: Sử dụng Left join)
create function f_bai5(@MaKhoa int)
returns table
as
return
(
select sv.TenSV, mh.TenMH 
from SinhVien sv left join SinhVien_MonHoc svmh on sv.MaSV = svmh.MaSV left join MonHoc mh on svmh.MaMH = mh.MaMH where sv.MaKhoa = @MaKhoa
)
-- lời gọi hàm 
select * from dbo.f_bai5(2)
--6.Viết một thủ tục nhận vào MaKhoa. Thủ tục này sẽ trả về số lượng sinh viên có ngày sinh trong tháng hiện tại thuộc khoa đó.
create proc proc_bai6 @MaKhoa int
as
begin
select count(*) as SoLuongSinhVien from SinhVien where MaKhoa = @MaKhoa AND month(NgaySinh) = month(getdate())
end
-- lời gọi 
exec proc_bai6 @MaKhoa = 1
--7.Viết một thủ tục xóa sinh viên với tham số vào là MaSV. Nếu không có MaSV đó thì in ra thông báo. 
create proc proc_bai7 @MaSV char(5)
as
begin
if not exists(select * from SinhVien where MaSV = @MaSV)
begin
print N'Sinh viên không tồn tại'
return
end
delete from SinhVien_MonHoc where MaSV = @MaSV
delete from SinhVien where MaSV = @MaSV
print N'Xóa thành công'
end
-- lời gọi 
exec proc_bai7 @MaSV ='SV001'
--8.Viết thủ tục cập nhật bảng SinhVien_MonHoc đảm bảo dữ liệu về chính, khóa ngoại.
create proc proc_bai8 @MaSV char(5),@TenSV nvarchar(50),@MaKhoa int,@NgaySinh date
as
begin
if exists(select *from SinhVien where MaSV=@MaSV)
begin
print N'MaSV đã tồn tại'
return
end
else if not exists(select *from Khoa where MaKhoa=@MaKhoa)
begin
print N'Ma Khoa không tồn tại trong bảng Khoa'
return
end
else
insert into SinhVien values(@MaSV,@TenSV,@MaKhoa,@NgaySinh)
end
exec proc_bai8 'SV006',N'Nguyễn Văn Mạnh',4,'2007-03-23'

--9.Viết thủ tục cursor hiện danh sách sinh viên của khoa có tên khoa là tham số vào.
create proc proc_bai9 @TenKhoa nvarchar(50),@cur1 cursor varying output
as
set @cur1=cursor for
select sv.MaSV,sv.TenSV,k.TenKhoa,sv.NgaySinh from SinhVien sv join Khoa k on sv.MaKhoa=k.MaKhoa where k.TenKhoa=@TenKhoa
open @cur1
declare @cur2 cursor
declare @MaSV char(5),@TenSV nvarchar(50),@tennKhoa nvarchar(50),@NgaySinh date
exec proc_bai9 N'CNTT',@cur2 output
while 1=1
begin
fetch next from @cur2 into @MaSV,@TenSV,@tennKhoa,@NgaySinh
if @@FETCH_STATUS!=0 break
print @MaSV+@TenSV+@tennKhoa+convert(char(10),@NgaySinh)
end
close @cur2
deallocate @cur2

--10.Viết thủ tục hiện danh sách sinh viên không đăng ký học 
create proc proc_bai10
as
select * from SinhVien
where MaSV not in(select MaSV from SinhVien_MonHoc)
exec proc_bai10 
--11.Viết thủ tục hiện danh sách sinh viên đăng ký ít hơn 15 tín chỉ.
create proc proc_bai11
as
select sv.MaSV,sv.TenSV,sum(mh.SoTinChi) as TongSoTinChi from SinhVien sv join SinhVien_MonHoc svmh on sv.MaSV=svmh.MaSV
join MonHoc mh on svmh.MaMH=mh.MaMH
group by sv.MaSV,sv.TenSV
having sum(mh.SoTinChi)<15
exec proc_bai11
--12.Viết thủ tục hiện Tên khoa có đông sinh viên nhất
create proc proc_bai12 @TenKhoa nvarchar(50) output
as
select k.TenKhoa,count(*) as DemSv into #bt from SinhVien sv join Khoa k on sv.MaKhoa=k.MaKhoa group by k.TenKhoa
select @TenKhoa=TenKhoa from #bt where DemSv=(select Max(DemSv) from #bt)
drop table #bt
declare @tk nvarchar(50)
exec proc_bai12 @tk output
print @tk
