create database ontap4 
use ontap4 

create table tblNhaCungCap
(
MaNCC char(4) primary key not null,
TenNCC nvarchar(50),
DiaChi nvarchar(50)
)
insert into tblNhaCungCap values 
('NCC1',N'Nhà Cung Cấp A',N'Nghi Yên'),
('NCC2',N'Nhà Cung Cấp B',N'Nghi Quang'),
('NCC3',N'Nhà Cung Cấp C',N'Nghi Thiết'),
('NCC4',N'Nhà Cung Cấp D',N'Nghi Long'),
('NCC5',N'Nhà Cung Cấp E',N'Nghi Tiến')
create table tblMucPhi 
(
MaMP char(4) primary key not null,
DonGia int ,
MoTa nvarchar(50)
)
Insert into tblMucPhi values
('MP01',500,'MoTa1'),
('MP02',400,'MoTa2'),
('MP03',300,'MoTa3'),
('MP04',200,'MoTa4'),
('MP05',100,'MoTa5')
create table tblDangKyCungCap 
(
MaDKCC char(4) primary key not null,
MaNCC char(4) foreign key references tblNhaCungCap(MaNCC),
MaMP char(4) foreign key references tblMucPhi(MaMP),
NgayBatDauCungCap date ,
NgayKetThucCungCap date,
SoLuongXeDangKy int 
)
Insert into tblDangKyCungCap values 
('DK01','NCC1','MP01','2025-04-19','2025-05-19',10),
('DK02','NCC2','MP02','2024-08-10','2025-08-10',50),
('DK03','NCC3','MP03','2023-07-15','2025-07-15',20),
('DK04','NCC4','MP04','2022-06-14','2025-06-14',30),
('DK05','NCC1','MP01','2021-05-11','2025-05-11',20)

--1.Sử dụng biến kiểu dữ liệu CURSOR in danh sách gồm TenNhaCC, MaMP,  DonGia, SoLuongXeDangKy  của những TenNhaCC có địa chỉ là A
declare csBai1 cursor for 
select ncc.TenNCC,mp.MaMP,mp.DonGia,dk.SoLuongXeDangKy
from tblNhaCungCap ncc join tblDangKyCungCap dk on ncc.MaNCC = dk.MaNCC join tblMucPhi mp on mp.MaMP = dk.MaMP
where ncc.DiaChi = N'Nghi Yên'
open csBai1 
while 1=1 
begin 
declare @TenNCC nvarchar(50),@MaMP char(4),@DonGia int,@SoLuongXeDangKy int 
fetch next from csBai1 into @TenNCC,@MaMP,@DonGia,@SoLuongXeDangKy 
if @@FETCH_STATUS !=0 break
print @TenNCC + @MaMP + str(@DonGia) + str(@SoLuongXeDangKy)
end 
close csBai1 
deallocate csBai1 
--2.Viết thủ tục nhận vào là D, kết quả in ra là danh sách các thông tin TenNhaCC, MaMP,  DonGia, SoLuongXeDangKy của những nhà cung cấp có DonGia >= D
create or alter proc prBai2 @DonGia int as 
select ncc.TenNCC,mp.MaMP,mp.DonGia,dk.SoLuongXeDangKy
from tblNhaCungCap ncc join tblDangKyCungCap dk on ncc.MaNCC = dk.MaNCC join tblMucPhi mp on mp.MaMP = dk.MaMP
where mp.DonGia > @DonGia 
exec prBai2 450 
--3.Viết hàm tạo bảng gồm các thông tin MaNhaCC, TenNhaCC, MaMP,  DonGia, NgayBatDauCungCap, NgayKetThucCungCap, SoLuongXeDangKy
-- với  SoLuongXeDangKy >=A với A là tham số đầu vào.
create or alter function bt3 (@SoLuongDangKyXe int)
returns table as
return 
(
select ncc.TenNCC,mp.MaMP,mp.DonGia,dk.SoLuongXeDangKy
from tblNhaCungCap ncc join tblDangKyCungCap dk on ncc.MaNCC = dk.MaNCC join tblMucPhi mp on mp.MaMP = dk.MaMP
where dk.SoLuongXeDangKy >= @SoLuongDangKyXe
)
select * from dbo.bt3 (30)
--4.Tạo thủ tục cho xem DiaChi của nhà cung cấp là A, với tham số đầu vào là A đó. Nếu A không tồn tại, cho dòng thông báo
create or alter proc bt4 @NCC nvarchar(50) as 
if not exists (Select * from tblNhaCungCap where TenNCC = @NCC)
begin
print(N'Nhà Cung Cấp này không tồn tại')
return 
end 
else
begin 
Select DiaChi from tblNhaCungCap where TenNCC = @NCC
end 

exec bt4 N'Nhà Cung Cấp A'
--5.Viết thủ tục tạo MAMP tự động….
create or alter proc bt5 @MaMP char(4) output  as 
declare @ma char(4),@so int 
select @ma =max(MaMP) from tblMucPhi
set @so = convert(int ,right(@ma,2))+1 
set @ma = '00' + convert (char(4),@so)
set @MaMP = 'VT' + right(trim(@ma),2)

declare @MaMP char(4)
exec bt5 @MaMP output 
print @MaMP
--6.Viết thủ tục xóa TenNhaCC  có trong bảng tblSV và các bảng liên quan với TenNhaCC là tham số đầu vào của thủ tục
create or alter proc bt6 @TenNCC nvarchar(50) as 
declare @MaNCC char(4)
Select @MaNCC = ncc.MaNCC from tblNhaCungCap ncc join tblDangKyCungCap dk on ncc.MaNCC = dk.MaNCC where ncc.TenNCC = @TenNCC
if not exists (Select * from tblNhaCungCap where TenNCC = @TenNCC)
begin 
print N'Không tìm thấy nhà cung cấp này'
return
end 
else 
begin
delete from tblDangKyCungCap where MaNCc = @MaNCC 
delete from tblNhaCungCap where TenNCC = @TenNCC
end 

exec bt6 N'Nhà Cung Cấp A'

--7.Tạo thủ tục cập nhật dữ liệu cho bảng tblDangKyCungCap với yêu cầu kiểm tra tính hợp lệ: không trùng khóa chính và kiểm tra dữ liệu khóa ngoại.
create or alter proc bt7 @MaDKCC char(4),@MaNCC char(4),@MaMP char(4),@NgayBatDauCungCap date,@NgayKetThucCungCap date,@SoLuongXeDangKy int as 
if exists (Select * from tblDangKyCungCap where MaDKCC = @MaDKCC)
print N'Lỗi trùng khóa chính'
else if not exists (Select * from tblNhaCungCap ncc  where  ncc.MaNCC = @MaNCC)
print N'Lỗi khóa ngoại'
else if not exists (Select * from tblMucPhi mp where mp.MaMP = @MaMP)
print N'Lỗi khóa ngoại'
else 
Insert into tblDangKyCungCap values (@MaDKCC,@MaNCC,@MaMP,@NgayBatDauCungCap,@NgayKetThucCungCap,@SoLuongXeDangKy)

exec bt7 'DK05','NCC2','MP01','2021-05-11','2025-05-11',20
--8.Viết thủ tục đầu vào là TenNhaCC ra là MaMP, DonGia, NgayBatDauCungCap, NgayKetThucCungCap, SoLuongXeDangKy, nếu gọi mà không truyền tham số thì hiện thị tất cả nội dung các nhà cung cấp này. 
create or alter proc bt8 @TenNCC nvarchar(50) = null as 
if @TenNCC is null 
select ncc.TenNCC,mp.MaMP,mp.DonGia,dk.NgayBatDauCungCap,dk.NgayKetThucCungCap,dk.SoLuongXeDangKy
from tblNhaCungCap ncc join tblDangKyCungCap dk on ncc.MaNCC = dk.MaNCC join tblMucPhi mp on mp.MaMP = dk.MaMP 
else 
select ncc.TenNCC,mp.MaMP,mp.DonGia,dk.NgayBatDauCungCap,dk.NgayKetThucCungCap,dk.SoLuongXeDangKy
from tblNhaCungCap ncc join tblDangKyCungCap dk on ncc.MaNCC = dk.MaNCC join tblMucPhi mp on mp.MaMP = dk.MaMP where ncc.TenNCC = @TenNCC
exec bt8 N'Nhà Cung Cấp B'
--9.Tạo thủ tục CURSOR với đầu vào là Mã nhà cung cấp, ra Tên nhà cung cấp, NgayBatDauCungCap, NgayKetThucCungCap, SoLuongXeDangKy của Mã nhà cung cấp này.
create or alter proc bt9 @MaNCC char(4), @cs1 cursor varying output as 
set @cs1 = cursor for 
select ncc.TenNCC,mp.MaMP,mp.DonGia,dk.NgayBatDauCungCap,dk.NgayKetThucCungCap,dk.SoLuongXeDangKy
from tblNhaCungCap ncc join tblDangKyCungCap dk on ncc.MaNCC = dk.MaNCC join tblMucPhi mp on mp.MaMP = dk.MaMP where ncc.MaNCC = @MaNCC
open @cs1 
declare @cs2 cursor , @TenNCC nvarchar(50),@MaMP char(4),@DonGia int,@NgayBatDauCungCap date,@NgayKetThucCungCap date,@SoLuongXeDangKy int 
exec bt9 'NCC2',@cs2 output
while 1=1 
begin 
fetch next from @cs2 into @TenNCC,@MaMP,@DonGia,@NgayBatDauCungCap,@NgayKetThucCungCap,@SoLuongXeDangKy 
if @@FETCH_STATUS !=0 break
print @TenNCC + @MaMP + str(@DonGia) + cast(@NgayBatDauCungCap as nvarchar(20)) + cast(@NgayKetThucCungCap as nvarchar(20)) + str(@SoLuongXeDangKy)
end 
close @cs2
deallocate @cs2 
--10.Viết hàm cho xem DonGia của MaMP là A, với tham số đầu vào là A đó
create or alter function bt10 (@MaMP char(4))
returns int as 
begin 
declare @dg int 
select @dg = DonGia from tblMucPhi
return @dg 
end 
print dbo.bt10 ('MP02')
--11.Viết hàm tạo bảng Inline Table tạo bảng gồm TenNhaCC, MaMP,  DonGia,NgayBatDauCungCap, NgayKetThucCungCap, SoLuongXeDangKy của Mã nhà cung cấp A với A tham số đầu vào

--12.Viết hàm tạo MAMP tự động….
create or alter function bt12 () 
returns char(4) as 
begin
declare @MaMP char(4)
select @MaMP=max(MaMP) from tblMucPhi
declare @so int 
set @so = convert(int,right(@MaMP,2)) + 1 
set @MaMP = '00' + convert(char(4),@so)
return 'VT' + right(trim(@MaMP),2)
end 
print dbo.bt12 ()
--13.Viết thủ tục CURSOR tìm TenNhaCC có SoLuongXeDangKy >A (với A là tham số đầu vào), để xóa tất cả các bản ghi có tên TenNhaCC đó trong bảng tblNhaCungCap và các bảng liên quan
create or alter proc bt13 @SoLuongXeDangKy int , @cs1 cursor varying output as 
set @cs1 = cursor for  
select ncc.MaNCC,ncc.TenNCC from tblNhaCungCap ncc join tblDangKyCungCap dk on ncc.MaNCC = dk.MaNCC where dk.SoLuongXeDangKy > @SoLuongXeDangKy
open @cs1 
declare @cs2 cursor ,@MaNCC char(4), @TenNCC nvarchar(50)
exec bt13 30 , @cs2 output 
while 1=1 
begin
fetch next from @cs2 into @MaNCC,@TenNCC
if @@FETCH_STATUS !=0 break;
else 
begin
delete from tblDangKyCungCap  where MaNCC = @MaNCC
delete from tblNhaCungCap where TenNCC = @TenNCC
end
end 
close @cs2 
deallocate @cs2 

--Câu 16: Viết trigger để khi xóa một bản ghi trong bảng tblNhaCungCap thì phải xóa luôn MaNhaCC đó có trong bảng tblDangKyCungCap.
create or alter trigger bt16 on tblNhaCungCap 
instead of delete as 
if not exists (select * from tblNhaCungCap ncc join deleted d on ncc.MaNCC = d.MaNCC)
begin
raiserror(N'Không tồn tại NCC này',16,1)
rollback 
return 
end 
else 
begin
delete from tblDangKyCungCap where MaNCC in (Select MaNCC from deleted)
delete from tblNhaCungCap where MaNCC in (Select MaNCC from deleted)
end 
delete from tblNhaCungCap where MaNCC = 'NCC3'
select * from tblNhaCungCap
--Câu 17:  Viết trigger để khi thêm một bản ghi mới vào bảng tblMucPhi thì thỏa các yêu cầu sau:
--- MaMP phải bắt đầu bằng 2 ký tự ‘MP’.
--- 0 < DonGia <1000 
create trigger bt17 on tblMucPhi 
instead of insert as 
if exists (select * from inserted where left(MaMP,2) != 'MP')
begin
raiserror (N'Lỗi',16,1)
rollback 
return 
end 
else if exists (select * from inserted where DonGia > 1000 or DonGia < 0 )
begin
raiserror (N'Lỗi',16,1)
rollback 
return 
end 
else 
insert into tblMucPhi select * from inserted 
Insert into tblMucPhi values ('MP07',500,'MoTa7')
--Câu 18: Viết trigger để khi sửa một bản ghi trong bảng tblDangKyCungCap thì thỏa các yêu cầu sau:
---  Không cho phép sửa cột MaDKCC.
--- NgayBatDauCungCap < NgayKetThucCungCap 

--Câu 19: Viết trigger để khi xóa một bản ghi trong bảng tblMucPhi thỏa mãn: nếu MaMP đó đã có trong bảng tblDangKyCungCap thì không được xóa. 
--Câu 20: Viết Trigger khi thêm dữ liệu vào bảng tblDangKyCungCap phải thỏa mãn:
---MaDKCC không được trùng
---MaNhaCC phải có trong bảng tblNhaCungCap
---MaMP phải có trong bảng tblMucPhi
---NgayBatDauCungCap phải >= Ngày hiện tại
create trigger bt20 on tblDangKyCungCap 
instead of insert as 
if exists (Select * from tblDangKyCungCap ncc join inserted i on ncc.MaDKCC = i.MaDKCC )
begin
raiserror (N'Lỗi khóa chính',16,1)
rollback 
return 
end
else if not exists (Select * from tblNhaCungCap ncc join inserted i on ncc.MaNCC = i.MaNCC)
begin
raiserror (N'Lỗi khóa ngoại',16,1)
rollback 
return 
end
else if not exists (Select * from tblMucPhi ncc join inserted i on ncc.MaMp = i.MaMp)
begin
raiserror (N'Lỗi khóa ngoại',16,1)
rollback 
return 
end
else if exists (Select * from inserted where NgayBatDauCungCap <= getdate())
begin
raiserror (N'Lỗi ngày',16,1)
rollback 
return 
end
else 
insert into tblDangKyCungCap select * from inserted 
Insert into tblDangKyCungCap values 
('DK05','NCC5','MP04','2025-07-19','2026-05-19',10)

select ncc.MaNCC,ncc.TenNCC,mp.MaMP,mp.DonGia,dk.NgayBatDauCungCap,dk.NgayKetThucCungCap,dk.SoLuongXeDangKy
from tblNhaCungCap ncc join tblDangKyCungCap dk on ncc.MaNCC = dk.MaNCC join tblMucPhi mp on mp.MaMP = dk.MaMP
select * from tblNhaCungCap 
select * from tblMucPhi
select * from tblDangKyCungCap