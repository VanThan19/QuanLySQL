create database de1 
use de1 

create table tblDMSanPham 
(
MaDM char(4) primary key not null,
TenDanhMuc nvarchar(30) not null,
MoTa nvarchar(50) 
)
Insert into tblDMSanPham values
('DM01',N'Danh Mục A',N'abc'),
('DM02',N'Danh Mục B',N'cde'),
('DM03',N'Danh Mục C',N'qedsds'),
('DM04',N'Danh Mục D',N'dfdfdf'),
('DM05',N'Danh Mục E',N'dfdfd')
create table tblSanPham 
(
MaSP char(4) primary key not null,
MaDM char(4) foreign key references tblDMSanPham(MaDM),
TenSP nvarchar(50) not null,
GiaTien money 
)
Insert into tblSanPham values 
('SP01','DM01',N'Sản Phẩm A',200),
('SP02','DM02',N'Sản Phẩm B',100),
('SP03','DM05',N'Sản Phẩm C',500),
('SP04','DM03',N'Sản Phẩm D',50),
('SP05','DM01',N'Sản Phẩm E',1000)
create table tblDonHang 
(
MaDH char(4) primary key not null,
MaSP char(4) foreign key references tblSanPham(MaSP),
SoLuong int 
)
Insert into tblDonHang values 
('DH01','SP01',5),
('DH02','SP01',15),
('DH03','SP02',50),
('DH04','SP04',10),
('DH05','SP03',100)

--1. Tạo kết nối, nhập dữ liệu vào bảng (bảng 3 có ít nhất 5 bản ghi)
--2. Dùng biến con trỏ CURSOR hiện thị cho xem Tên sản phẩm, Tên danh mục, số lượng, Thành 
--tiền của Mã đơn hàng A.
declare csBai2 cursor for 
select sp.TenSP,dm.TenDanhMuc,dh.SoLuong,sum(dh.SoLuong*sp.GiaTien) as ThanhTien
from tblDMSanPham dm join tblSanPham sp on dm.MaDM = sp.MaDM join tblDonHang dh on dh.MaSP = sp.MaSP where dh.MaDH = 'DH01'
group by sp.TenSP,dm.TenDanhMuc,dh.SoLuong
open csBai2 
while 1=1 
begin 
declare @TenSP nvarchar(50), @TenDanhMuc nvarchar(50), @SoLuong int, @ThanhTien int 
fetch next from csBai2 into @TenSP,@TenDanhMuc,@SoLuong,@ThanhTien
if @@FETCH_STATUS != 0 break;
print @TenSP + @TenDanhMuc + str(@SoLuong) + str(@ThanhTien)
end 
close csBai2 
deallocate csBai2 
--3. Tạo thủ tục cho xem Tổng tiền của MaDH là A, với tham số đầu vào là A đó. Nếu A không tồn 
--tại, cho dòng thông báo
create proc procBai3 @MaDH char(4) , @TongTien int output 
as
begin
if not exists (Select * from tblDonHang where MaDH = @MaDH)
print N'Đơn Hàng Không Tồn Tại'
else 
select @TongTien = sum(sp.GiaTien*dh.SoLuong)
from tblDMSanPham dm join tblSanPham sp on dm.MaDM = sp.MaDM join tblDonHang dh on dh.MaSP = sp.MaSP
Where dh.MaDH = @MaDH
end 
declare @tt int 
exec procBai3 'DH06', @tt output 
print @tt
--4. Tạo thủ tục hiện TenSP có tổng tiền thu về lớn nhất 
create proc procBai4 as 
begin 
select sp.TenSP, sum(sp.GiaTien*dh.SoLuong) TongTien into #bt from tblDMSanPham dm join tblSanPham sp on dm.MaDM = sp.MaDM join tblDonHang dh on dh.MaSP = sp.MaSP
group by sp.TenSP
Select sp.TenSP, sum(sp.GiaTien*dh.SoLuong) TongTienLonNhat from tblDMSanPham dm join tblSanPham sp on dm.MaDM = sp.MaDM join tblDonHang dh on dh.MaSP = sp.MaSP
group by sp.TenSP
having sum(sp.GiaTien*dh.SoLuong) =( select Max(TongTien) from #bt )
drop table #bt 
end 
exec procBai4 
--5. Viết thủ tục tạo MADH tự động….
create proc SinhMaTuDong @MaDH char(4) output 
as 
declare @ma char(4)
select @ma = max(MaDH) from tblDonHang
declare @so int 
set @so = convert(int,right(@ma,2))+1 
set @ma = '00' + convert(char(4),@so)
set @MaDH = 'DH' + right(trim(@ma),2)

declare @MaDH char(4)
exec SinhMaTuDong @MaDH output 
print @MaDH 
--6. Tạo thủ tục đầu vào là Tên Danh mục, ra là Tên sản phẩm, Giá tiền, tổng số lượng, Tổng tiền 
--của các mặt hàng thuộc danh mục này.
create proc proctBai6 @TenDM nvarchar(50), @TenSP nvarchar(50) output ,@GiaTien money output, @TongSoLuong int output, @TongTien int output
as 
select @TenSP = sp.TenSP,@GiaTien = sp.GiaTien, @TongSoLuong = sum(dh.SoLuong),@TongTien = sum(sp.GiaTien*dh.SoLuong)
from tblDMSanPham dm join tblSanPham sp on dm.MaDM = sp.MaDM join tblDonHang dh on dh.MaSP = sp.MaSP
where dm.TenDanhMuc = @TenDM group by sp.TenSP,sp.GiaTien

declare @TenSP nvarchar(50) ,@GiaTien money , @TongSoLuong int , @TongTien int 
exec proctBai6 N'Danh Mục A',@TenSP output ,@GiaTien output, @TongSoLuong output, @TongTien output
print @TenSP + str(@GiaTien) + str(@TongSoLuong) + str(@TongTien)

CREATE PROCEDURE proctBai61 
    @TenDM NVARCHAR(50)
AS
BEGIN
    SELECT 
        sp.TenSP,
        sp.GiaTien,
        SUM(dh.SoLuong) AS TongSoLuong,
        SUM(sp.GiaTien * dh.SoLuong) AS TongTien
    FROM 
        tblDMSanPham dm
        JOIN tblSanPham sp ON dm.MaDM = sp.MaDM
        JOIN tblDonHang dh ON dh.MaSP = sp.MaSP
    WHERE 
        dm.TenDanhMuc = @TenDM
    GROUP BY 
        sp.TenSP, sp.GiaTien;
END
GO

-- Gọi thử
EXEC proctBai61 N'Danh Mục B';
--7. Viết thủ tục xóa TenSP có trong bảng tblSANPHAM và các bảng liên quan với TenSP là tham số 
--đầu vào của thủ tục
create proc XoaTenSP1 @TenSP nvarchar(50) as 
begin 
declare @MaSP char(4)
SELECT @MaSP = MaSP FROM tblSanPham WHERE TenSP = @TenSP
if not exists (select * from tblSanPham where TenSP = @TenSP)
print N'Tên Sản Phẩm không tồn tại'
else
begin
delete from tblDonHang where MaSP = @MaSP
delete from tblSanPham where TenSP = @TenSP
print N'Xóa tên sản phẩm thành công'
end 
end 
exec XoaTenSP1 N'Sản Phẩm A'
--8. Viết thủ tục CURSOR tìm TenSP có đơn giá >A (với A là tham số đầu vào), để xóa tất cả các bản ghi có
--tên TenSP đó trong bảng tblSANPHAM và các bảng liên quan
create or alter proc Bi @dg int , @cs12 cursor varying output 
as
set @cs12 = cursor for 
select TenSP, MaSP from tblSanPham where GiaTien > @dg
open @cs12 
declare @cur12 cursor ,@TenSP nvarchar(50),@MaSP char(4)
exec Bi 100 , @cur12 output 
while 1=1 
begin
fetch next from @cur12 into @TenSP,@MaSP 
if @@FETCH_STATUS != 0 break
else 
begin 
delete from tblDonHang where MaSP = @MaSP
delete from tblSanPham where TenSP = @TenSP
print N'Đã Xóa Thành Công'
end 
end 
close @cur12
deallocate @cur12
--9. Tạo thủ tục CURSOR với đầu vào là Mã đơn hàng, ra Tên sản phẩm, Tên danh mục,số lượng, 
--Thành tiền của Mã đơn hàng đó.
create or alter proc bai10 @MaDH char(4), @TenSP nvarchar(50) output,@TenDM nvarchar(50) output ,@SoLuong int output,@ThanhTien int output, @Cs2 cursor varying output 
as 
set @Cs2 = cursor for 
select sp.TenSP,dm.TenDanhMuc,dh.SoLuong,sum(sp.GiaTien*dh.SoLuong) ThanhTien 
from tblDMSanPham dm join tblSanPham sp on dm.MaDM = sp.MaDM join tblDonHang dh on dh.MaSP = sp.MaSP
where dh.MaDH = @MaDH group by sp.TenSP,dm.TenDanhMuc,dh.SoLuong
open @Cs2 
declare @cur2 cursor 
declare @TenSP nvarchar(50),@TenDM nvarchar(50)  
declare @SoLuong int ,@ThanhTien int 
exec bai10 'DH03',@TenSP output,@TenDM output ,@SoLuong output,@ThanhTien output, @cur2 output 
while 1=1
begin
fetch next from @cur2 into @TenSP , @TenDM, @SoLuong,@ThanhTien
if @@FETCH_STATUS != 0 break
print @TenSP + @TenDM + str(@SoLuong) + str(@ThanhTien)
end
close @cur2
deallocate @cur2 
--10. Tạo thủ tục cập nhật dữ liệu cho bảng tblDONHANG với yêu cầu kiểm tra tính hợp lệ: không 
--trùng khóa chính và kiểm tra dữ liệu khóa ngoại.
-- k trùng khóa chính là insert ,còn update thì khóa chính đã tồn tại rồi 
create or alter proc bai10 @MaDH char(4),@MaSP char(4),@SoLuong int 
as 
if exists (Select * from tblDonHang where MaDH = @MaDH)
begin
print N'Lỗi trùng khóa chính'
return 
end 
else if not exists (Select * from tblSanPham where MaSP = @MaSP)
begin
print N'Lỗi khóa ngoại'
return
end 
else 
begin
Insert into tblDonHang values (@MaDH,@MaSP,@SoLuong)
print N'Đã Thêm Thành Công'
end

exec bai10 'DH06','SP02',100
select * from tblDonHang

--11. Viết thủ tục hiện thị dữ liệu với đầu vào là Mã đơn hàng, ra là Tên sản phẩm, Tên danh mục,số 
--lượng, Thành tiền của Mã đơn hàng này, nếu gọi mà không truyền tham số thì hiện thị tất cả nội
--dung các đơn hàng. 
create proc baitap11 @MaDH char(4) = null as
begin 
if @MaDH is null 
begin
select sp.TenSP,dm.TenDanhMuc,dh.SoLuong,sum(dh.SoLuong*sp.GiaTien) ThanhTien 
from tblDMSanPham dm join tblSanPham sp on dm.MaDM = sp.MaDM join tblDonHang dh on dh.MaSP = sp.MaSP
group by sp.TenSP,dm.TenDanhMuc,dh.SoLuong
end
else 
begin 
select sp.TenSP,dm.TenDanhMuc,dh.SoLuong,sum(dh.SoLuong*sp.GiaTien) ThanhTien 
from tblDMSanPham dm join tblSanPham sp on dm.MaDM = sp.MaDM join tblDonHang dh on dh.MaSP = sp.MaSP
where dh.MaDH = @MaDH group by sp.TenSP,dm.TenDanhMuc,dh.SoLuong
end
end

exec baitap11 'DH03' -- truyền tham số 
exec baitap11 
--12. Viết hàm cho xem Tổng tiền của MaDH là A, với tham số đầu vào là A đó
create function bai12 (@MaDH char(4))
returns int 
as
begin
declare @TongTien int 
select @TongTien = sum(dh.SoLuong*sp.GiaTien)
from tblDMSanPham dm join tblSanPham sp on dm.MaDM = sp.MaDM join tblDonHang dh on dh.MaSP = sp.MaSP where dh.MaDH = @MaDH
return @TongTien 
end 

print dbo.bai12 ('DH01')
--13. Viết hàm tạo bảng Inline Table tạo bảng gồm Tên sản phẩm, Tên danh mục,số lượng, Thành 
--tiền của Mã đơn hàng A
create or alter function bai13 (@MaDH char(4)) 
returns table 
as
return 
select sp.TenSP,dm.TenDanhMuc,dh.SoLuong,sum(dh.SoLuong*sp.GiaTien) ThanhTien 
from tblDMSanPham dm join tblSanPham sp on dm.MaDM = sp.MaDM join tblDonHang dh on dh.MaSP = sp.MaSP
where dh.MaDH = @MaDH 
group by sp.TenSP,dm.TenDanhMuc,dh.SoLuong 

select * from dbo.bai13 ('Dh04')
--14. Viết hàm tạo MADH tự động….
create function bt14 ()
returns char(4)
as
begin 
declare @ma char(4)
select @ma = max(MaDH) from tblDonHang
declare @so int 
set @so = convert(int,right(@ma,2))+1
set @ma = '00' + convert(char(4),@so)
return 'DH' + RIGHT(trim(@ma),2)
end 

select dbo.bt14() as MaMoi
--15. Viết hàm tạo bảng Multi Statement tạo bảng gồm Tên sản phẩm, Tên danh mục,số lượng, 
--Thành tiền của Mã đơn hàng A
create function bt15 (@MaDH char(4))
returns @bang table (TenSP nvarchar(50),TenDM nvarchar(50),SoLuong int, ThanhTien money)
as
begin 
insert into @bang (TenSP,TenDM,SoLuong,ThanhTien)
select sp.TenSP,dm.TenDanhMuc,dh.SoLuong,sum(dh.SoLuong*sp.GiaTien) ThanhTien 
from tblDMSanPham dm join tblSanPham sp on dm.MaDM = sp.MaDM join tblDonHang dh on dh.MaSP = sp.MaSP
where dh.MaDH = @MaDH 
group by sp.TenSP,dm.TenDanhMuc,dh.SoLuong 
return 
end 

select * from dbo.bt15 ('DH01')
--16. Xây dựng trigger trong tbldondh để kiểm tra khi người dùng thêm mới mẫu tin.
--− Khóa ngoại: mas phải tồn tại trong tblsanpham.
--− Miền giá trị: SoLuong phải >=A và <=B.
create or alter trigger bt16 on tblDonHang 
instead of insert as 
if not exists (select * from tblSanPham sp join inserted i on sp.MaSP = i.MaSP)
print N'Lỗi khóa ngoại không tồn tại'
else if exists (select * from tblDonHang dh join inserted i on dh.MaDH = i.MaDH)
print N'Lỗi trùng khóa chính'
else if not exists (select * from inserted where SoLuong between 50 and 500)
print N'SoLuong phải >=50 và <= 500'
else insert into tblDonHang select * from inserted 

insert into tblDonHang values ('DH08','SP02',300)
select * from tblDonHang
--Câu 16: Viết trigger để khi xóa một bản ghi trong bảng tblDMSANPHAM thì phải xóa
--luôn MaDM đó có trong bảng tblSANPHAM.
create trigger bt16v2 on tblDMSanPham 
instead of delete as 
if not exists (Select * from tblDMSanPham dm join deleted d on dm.MaDM = d.MaDM)
begin
print N'Không tìm thấy danh mục để xóa'
rollback 
return 
end 
else 
begin 
delete from tblDMSanPham where MaDM in (select MaDM from deleted)
delete from tblSanPham where MaDM in (select MaDM from deleted)
print N'Đã Xóa'
end 
delete from tblDMSanPham where MaDM = 'DM01'
select * from tblSanPham
--Câu 17: Viết trigger để khi thêm một bản ghi mới vào bảng tblSANPHAM thì thỏa các
--yêu cầu sau:
--- MaSP phải bắt đầu bằng 2 ký tự ‘SP’.
--- 0 < GiaTien <100 
create trigger bt17 on tblSanPham 
instead of insert as
if exists (select * from inserted where left(MaSP,2) != 'SP')
begin 
print N'MaSP phải bắt đầu bằng 2 ký tự SP'
rollback 
return 
end 
else if not exists (Select * from inserted where GiaTien between 0 and 100)
begin 
RAISERROR(N'Giá tiền phải lớn hơn 0 và nhỏ hơn 100.', 16, 1)
rollback 
return
end 
else insert into tblSanPham select * from inserted 

Insert into tblSanPham values ('SP09','DM03',N'Sản phẩm G', 60)

--RAISERROR ('Nội dung lỗi', Mức độ, Trạng thái)
--'Nội dung lỗi': Thông báo lỗi hiển thị ra.

--Mức độ (severity level):

--< 10: Thông báo (không phải lỗi thật sự)

--11 – 16: Lỗi do người dùng gây ra (ví dụ dữ liệu sai, khóa ngoại sai)

--Trạng thái (state): Giá trị từ 0–255 (dùng để phân biệt vị trí trong mã, bạn có thể đặt là 1)


--Câu 18: Viết trigger để khi sửa một bản ghi trong bảng tblDONHANG thì thỏa các yêu
--cầu sau:
--- Không cho phép sửa cột MaDH.
--- 20 < SoLuong < 50 
create trigger bt18 on tblDonHang 
instead of update as
if update(MaDH)
begin
print N'Không được sửa cột SoDH'
rollback transaction
return
end
else if exists (Select * from inserted where SoLuong < 20 or SoLuong > 50)
begin 
raiserror (N'Số lượng phải nằm trong đoạn 20..50',16,1)
rollback
return
end
else 
begin
update tblDonHang set MaSP = i.MaSP ,SoLuong = i.SoLuong From tblDonHang dh join inserted i on dh.MaDH = i.MaDH
print N'Cập nhật thành công'
end 

-- Câu này đúng:
UPDATE tblDonHang SET SoLuong = 40 WHERE MaDH = 'DH01'

select * from tblDonHang
--Câu 19: Viết trigger để khi xóa một bản ghi trong bảng tblSANPHAM thõa mãn: nếu
--MaSP đó đã có trong bảng tblDONHANG thì không được xóa. 
create trigger bt19 on tblSanPham
instead of delete 
as 
if exists (select * from deleted d join tblDonHang dh on d.MaSP = dh.MaSP)
begin
raiserror (N'Không được xóa MaSP đã có trong bảng tblDonHang',16,1)
rollback 
return 
end
else 
begin 
delete from tblSanPham where MaSP in (Select MaSP from deleted)
print N'Đã Xóa '
end 

delete from tblSanPham where MaSP = 'SP08'
select * from tblDonHang
select * from tblSanPham
--Câu 20:- Hãy thêm cột tổng tiền kiểu money cho bảng tblDONHANG. 
--Sau đó viết trigger để sửa một bản ghi trong bảng tblDONHANG thì thỏa các yêu cầu
--sau:
--- Không được sửa cột MaSP.
--- Nếu sửa cột SoLuong thì phải sửa thêm cột TongTien = SoLuong * GiaTien.
--(GiaTien trong bảng tblSANPHAM)
ALTER TABLE tblDonHang ADD TongTien MONEY;
CREATE OR ALTER TRIGGER trg_Update_DonHang
ON tblDonHang
INSTEAD OF UPDATE
AS
BEGIN
    -- 1. Không cho phép sửa MaSP
    IF UPDATE(MaSP)
    BEGIN
        RAISERROR(N'Không được sửa cột MaSP', 16, 1)
        ROLLBACK TRANSACTION
        RETURN
    END

    -- 2. Xử lý UPDATE: tính lại TongTien nếu có sửa SoLuong
    UPDATE dh
    SET 
        dh.SoLuong = i.SoLuong,
        dh.TongTien = i.SoLuong * sp.GiaTien
    FROM tblDonHang dh
    JOIN inserted i ON dh.MaDH = i.MaDH
    JOIN tblSanPham sp ON i.MaSP = sp.MaSP
END
UPDATE tblDonHang SET SoLuong = 10 WHERE MaDH = 'DH01'