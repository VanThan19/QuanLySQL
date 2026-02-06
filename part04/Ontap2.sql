create database de2 
use de2 

create table tblSV
(
MaSV char(4) primary key not null,
TenSV nvarchar(50) not null,
QueQuan nvarchar(50) not null,
NamSinh int,
DiemRL int 
)
Insert into tblSV values 
('SV01',N'Nguyễn Văn A',N'Nghệ An',2005,8),
('SV02',N'Nguyễn Văn B',N'Hà Nội',2001,8),
('SV03',N'Nguyễn Văn C',N'Lào Cai',2002,7),
('SV04',N'Nguyễn Văn D',N'Hà Tĩnh',2003,10),
('SV05',N'Nguyễn Văn F',N'Thanh Hóa',2000,9)
create table tblDeTai 
(
MaDT char(4) primary key not null,
TenDT nvarchar(50) not null,
KinhPhi int
)
Insert into tblDeTai values 
('DT01',N'Lập trình web',100),
('DT02',N'Lập trình c++',200),
('DT03',N'Lập trình c#',400),
('DT04',N'Lập trình c',50),
('DT05',N'Lập trình java',500)
create table tblDiem
(
MaSV char(4) foreign key references tblSV(MaSV),
MaDT char(4) foreign key references tblDeTai(MaDT),
Diem int
)
Insert into tblDiem values 
('SV01','DT01',8),
('SV01','DT05',9),
('SV02','DT04',7),
('SV03','DT03',7),
('SV04','DT02',8)

--1. Viết hàm tạo bảng gồm các thông tin MaSV, TenSV, QueQuan, DiemRL
--thực hiện câu lệnh cập nhật: DiemRL = DiemRL+10
create function fbai1 ()
returns table as
return 
(
Select MaSV,TenSV,QueQuan,DiemRL = DiemRL + 10 from tblSV
)

select * from dbo.fbai1()
--2. Sử dụng biến kiểu dữ liệu CURSOR in danh sách gồm MaSV, TenSV,
--QueQuan, TenDT của những sinh viên sinh trước 1980
declare csb2 cursor for 
select sv.MaSV,sv.TenSV,sv.QueQuan,dt.TenDT from tblSV sv join tblDiem d on sv.MaSV = d.MaSV join tblDeTai dt on d.MaDT = dt.MaDT
where sv.NamSinh < 2005  
open csb2 
while 1=1 
begin
declare @MaSV char(4),@TenSV nvarchar(50),@QueQuan nvarchar(50),@TenDT nvarchar(50)
fetch next from csb2 into @MaSV,@TenSV,@QueQuan,@TenDT
if @@FETCH_STATUS !=0 break
print @MaSV+@TenSV+@QueQuan+@TenDT 
end
close csb2
deallocate csb2 
--3. Viết thủ tục nhận vào là D, kết quả in ra là danh sách các thông tin MaSV,
--TenSV, QueQuan, NamSinh, TenDT, Diem của những sinh viên có Diem>=D
create proc tb3 @D int as 
Select sv.TenSV,sv.QueQuan,sv.NamSinh,dt.TenDT,d.Diem
from tblSV sv join tblDiem d on sv.MaSV = d.MaSV join tblDeTai dt on d.MaDT = dt.MaDT where d.Diem >= @D
exec tb3 7 
--4. Tạo thủ tục cho xem Diem của Tên sinh viên là A, với tham số đầu vào là A 
--đó. Nếu A không tồn tại, cho dòng thông báo
create or alter  proc ttb4 @TenSV nvarchar(50),@Diem int output as 
if not exists (Select * from tblSV sv join tblDiem d on sv.MaSV = d.MaSV join tblDeTai dt on d.MaDT = dt.MaDT where TenSV = @TenSV)
begin
print N'Sinh Viên này không tồn tại'
return 
end 
else 
select @diem = d.Diem from tblSV sv join tblDiem d on sv.MaSV = d.MaSV join tblDeTai dt on d.MaDT = dt.MaDT where TenSV = @TenSV
declare @Diem int 
exec ttb4 N'Nguyễn Văn C',@Diem output 
print @Diem 
--5. Viết thủ tục tạo MASV tự động….
create proc ttb5 @MaSV char(4) output as 
declare @ma char(4)
select @ma = max(MaSV) from tblSV
declare @so int 
set @so = convert(int,right(@ma,2))+1
set @ma = '00' + convert(char(4),@so)
set @MaSV = 'VT' + right(trim(@ma),2)

declare @MaSV char(4)
exec ttb5 @MaSV output 
print @MaSV 
--6. Viết thủ tục xóa TenSV có trong bảng tblSV và các bảng liên quan với 
--TenSV là tham số đầu vào của thủ tục
create or alter proc ttb6 @TenSV nvarchar(50) as 
declare @MaSV char(4)
select @MaSV = MaSV from tblSV  where TenSV = @TenSV 
if not exists (select * from tblSV where TenSV = @TenSV)
begin
print N'Tên sinh viên không tồn tại'
return 
end 
else 
begin
delete from tblSV where TenSV = @TenSV 
delete from tblDiem where MaSV = @MaSV 
end 
exec ttb6 N'Nguyễn Văn A'

--7. Viết thủ tục CURSOR tìm TenDT có KinhPhi >A (với A là tham số đầu
--vào), để xóa tất cả các bản ghi có tên TenDT đó trong bảng tblDETAI và các
--bảng liên quan
create or alter proc ttb7 @KinhPhi int , @cs1 cursor varying output as 
set @cs1 = cursor for 
select MaDT,TenDT from tblDeTai where KinhPhi > @KinhPhi 
open @cs1 

declare @cur1 cursor ,@MaDT char(4), @TenDT nvarchar(50)
exec ttb7 100,@cur1 output 
while 1=1 
begin 
fetch next from @cur1 into @MaDT,@TenDT 
if @@FETCH_STATUS !=0 break
else 
begin 
delete from tblDiem where MaDT = @MaDT 
delete from tblDeTai where TenDT = @TenDT 

print N'Đã Xóa Thành Công'
end
end 
close @cur1
deallocate @cur1 
--8. Tạo thủ tục cập nhật dữ liệu cho bảng tblDiem với yêu cầu kiểm tra tính hợp
--lệ: không trùng khóa chính và kiểm tra dữ liệu khóa ngoại.
create or alter proc ttb8 @MaSV char(4),@MaDT char(4),@Diem int as 
if not exists (Select * from tblSV where MaSV = @MaSV)
begin 
print N'Lỗi khóa ngoại'
end 
else if not exists (Select * from tblDeTai where MaDT = @MaDT)
begin
print N'Lỗi khóa ngoại'
return 
end
else 
begin
Insert into tblDiem values (@MaSV,@MaDT,@Diem)
print N'Thêm thành công'
end 

exec ttb8 'SV03','DT02',9
select * from tblSV
--9. Viết thủ tục hiện thị dữ liệu với đầu vào là Mã sinh viên, ra là Tên sinh viên,
--MaSV, TenSV, QueQuan, TenDT, Diem của Mã sinh viên này, nếu gọi mà 
--không truyền tham số thì hiện thị tất cả nội dung các đơn hàng.
create or alter proc ttb9 @MaSV char(4) = null as 
begin
if @MaSV is null 
select sv.MaSV,sv.TenSV,sv.QueQuan,dt.TenDT,d.Diem from tblSV sv left join tblDiem d on sv.MaSV = d.MaSV left join tblDeTai dt on d.MaDT = dt.MaDT
else 
select sv.MaSV,sv.TenSV,sv.QueQuan,dt.TenDT,d.Diem from tblSV sv left join tblDiem d on sv.MaSV = d.MaSV left join tblDeTai dt on d.MaDT = dt.MaDT
where sv.MaSV = @MaSV 
end 

exec ttb9 'Sv02'
--10.Tạo thủ tục CURSOR với đầu vào là Mã sinh viên, ra Tên sinh viên, MaSV, 
--TenSV, QueQuan, TenDT, Diem của Mã sinh viên này.
create or alter proc ttb10 @MaSV char(4) , @cs1 cursor varying output as 
set @cs1 = cursor for 
select sv.TenSV,sv.QueQuan,dt.TenDT,d.Diem from tblSV sv left join tblDiem d on sv.MaSV = d.MaSV join tblDeTai dt on d.MaDT = dt.MaDT
where sv.MaSV = @MaSV
open @cs1 

declare @cur1 cursor , @TenSV nvarchar(50),@QueQuan nvarchar(50), @TenDT nvarchar(50), @Diem int 
exec ttb10 'SV03' , @cur1 output 
while 1=1 
begin
fetch next from @cur1 into @TenSV,@QueQuan,@TenDT,@Diem 
if @@FETCH_STATUS !=0 break;
print @TenSV + @QueQuan + @TenDT + str(@Diem)
end 
close @cur1
deallocate @cur1 
--11.Viết hàm cho xem KinhPhi của MaDT là A, với tham số đầu vào là A đó
create or alter function fb11 (@MaDT char(4)) 
returns int as
begin 
declare @KinhPhi int 
select @KinhPhi = KinhPhi from tblDeTai where MaDT = @MaDT
return @KinhPhi
end 

print dbo.fb11 ('Dt04')
--12.Viết hàm tạo bảng Inline Table tạo bảng gồm Tên sinh viên, MaSV, TenSV, 
--QueQuan, TenDT, Diem của Mã sinh viên A với A tham số đầu vào
create or alter function fb12 (@MaSV char(4))
returns table as
return 
(
select sv.TenSV,sv.QueQuan,dt.TenDT,d.Diem from tblSV sv join tblDiem d on sv.MaSV = d.MaSV join tblDeTai dt on d.MaDT = dt.MaDT
where sv.MaSV = @MaSV
)

select * from dbo.fb12 ('SV02')
--13.Viết hàm tạo MADT tự động….
create or alter function f13 ()
returns char(4)
as 
begin 
declare @ma char(4)
select @ma = max(MaDT) from tblDeTai
declare @so int
set @so = convert(int,right(@ma,2))+1
set @ma = '00' + convert (char(4),@so)
return 'DT' + right(trim(@ma),2) 
end 

print dbo.f13 ()
--Câu 16: Viết trigger để khi xóa một bản ghi trong bảng tblSV thì phải xóa luôn
--MaSV đó có trong bảng tblDIEM
create trigger tb16 on tblSV 
instead of delete as 
if not exists (select * from tblSV sv join deleted d on sv.MaSV = d.MaSV)
begin 
RAISERROR(N'Không tìm thấy sinh viên',16,1)
rollback
return
end
else 
begin
delete from tblDiem where MaSV in (Select MaSV from deleted)
delete from tblSv where MaSV in (Select MaSV from deleted)
print N'Xóa Thành Công'
end
delete from tblSV where maSv = 'SV02'
--Câu 17: Viết trigger để khi thêm một bản ghi mới vào bảng tblSV thì thỏa các
--yêu cầu sau:
--- MaSV phải bắt đầu bằng 2 ký tự ‘SV’.
--- 0 <= DiemRL <=10 
create trigger tb17 on tblSV 
instead of insert as 
if exists (select * from inserted where left(MaSV,2) != 'SV')
begin 
raiserror(N'MaSV phải bắt đầu bằng 2 ký tự SV',16,1)
rollback 
return 
end 
else if exists (Select * from inserted where DiemRL > 10 or DiemRL < 0)
begin
raiserror (N'Điểm không thỏa mãn 0 <= DiemRL <=10 ',16,1)
rollback 
return
end 
else insert into tblSV select * from inserted 

insert into tblSV values ('SV07',N'Tên Sinh Viên H',N'Nghi Lộc',2000,1)
--Câu 18: Viết trigger để khi sửa một bản ghi trong bảng tblDETAI thì thỏa các
--yêu cầu sau:
--- Không cho phép sửa cột MaDT.
--- 20  KinhPhi  50 
create trigger tb18 on tblDeTai 
instead of update as 
if(update(MaDT)) 
begin
raiserror(N'Không cho phép sửa cột MaDT',16,1)
rollback
return
end
else if exists(select * from inserted where KinhPhi > 50 or KinhPhi < 20)
begin
raiserror(N'Kinh phí phải < 50 và > 20',16,1)
rollback 
return
end
else 
begin
update tblDeTai set MaDT = i.MaDT,TenDT = i.TenDT,KinhPhi = i.KinhPhi from tblDeTai dt join inserted i on dt.MaDT = i.MaDT
print N'Cập nhật thành công'
end

update tblDeTai set TenDT = N'DeTai 4',KinhPhi = 30 where MaDT = 'DT04'
select * from tblDeTai
--Câu 19: Viết trigger để khi xóa một bản ghi trong bảng tblSV thõa mãn: nếu
--MaSV đó đã có trong bảng tblDIEM thì không được xóa.
create trigger tb19 on tblSV
instead of delete as 
if exists (Select * from deleted d join tblDiem diem  on diem.MaSV = d.MaSV)
begin 
raiserror(N'Không được xóa MaSv đó đã có trong bảng tblDiem',16,1)
rollback
return
end
else 
begin
delete from tblSV where MaSv in (select MaSv from deleted)
print N'Xóa thành công'
end

delete from tblSV where MaSV = 'SV07'
