create database deduc 
use deduc 

create table tblNhaCC 
(
MaNCC char(4) primary key not null,
TenNCC nvarchar(50),
DiaChi nvarchar(50),
DienThoai nvarchar(15)
)
Insert into tblNhaCC values 
('NCC1',N'Nhà Cung Cấp A',N'Nghệ An','012345678'),
('NCC2',N'Nhà Cung Cấp B',N'Hà Nội','012345679'),
('NCC3',N'Nhà Cung Cấp C',N'Huế','012345677'),
('NCC4',N'Nhà Cung Cấp D',N'Nghệ An','012345676'),
('NCC5',N'Nhà Cung Cấp E',N'Thanh Hóa','012345675')
create table tblDonHang 
(
SoDH char(4) primary key not null,
NgayDH date ,
MaNCC char(4) foreign key references tblNhaCC(MaNCC)
)
Insert into tblDonHang values 
('DH01','2025-06-06','NCC1'),
('DH02','2021-07-05','NCC2'),
('DH03','2022-08-04','NCC3'),
('DH04','2023-09-03','NCC4'),
('DH05','2024-02-02','NCC1')
create table tblCTDonHang 
(
SoDH char(4) foreign key references tblDonHang(SoDH),
TenVTu nvarchar(50),
SLDat int,
DonGia int
)
Insert into tblCTDonHang values 
('DH01',N'Xi Măng',10,500),
('DH02',N'Vở',20,500),
('DH02',N'Bút',5,500),
('DH04',N'Điện Thoại',100,500),
('DH03',N'Sắt Thép',80,500)

--1 
create view v1 as 
select ncc.TenNCC,ncc.DiaChi,ncc.DienThoai from tblNhaCC ncc left join tblDonHang dh on ncc.MaNCC = dh.MaNCC 
where dh.MaNCC is null 
select * from v1 
--2 
create or alter proc bt2 @Thang int = null,@Nam int = null, @cur1 cursor varying output as 
begin 
select ct.TenVTu,sum(ct.SLDat) TSLuong into #bt 
from tblCTDonHang ct join tblDonHang dh on ct.SoDH = dh.SoDH where(@Thang is null or month(dh.NgayDH) = @Thang)and (@Nam is null or year(dh.NgayDH) = @Nam)
group by ct.TenVTu

set @cur1 = cursor for 

select ct.TenVTu,sum(ct.SLDat) TS 
from tblCTDonHang ct join tblDonHang dh on ct.SoDH = dh.SoDH
where (@Thang is null or month(dh.NgayDH) = @Thang)and (@Nam is null or year(dh.NgayDH) = @Nam)
group by ct.TenVTu having sum(ct.SLDat) = (select max(TSLuong) from #bt)

end 
open @cur1 

declare @cur2 cursor , @TenVTu nvarchar(50),@TS int 
exec bt2 06,2025 ,@cur2 output 
while 1=1 
begin 
fetch next from @cur2 into @TenVTu,@TS
if @@FETCH_STATUS !=0 break;
print @TenVTu + str(@TS) 
end 
close @cur2
deallocate @cur2 

--3 
create function fbt3 (@SoDH char(4)) 
returns int as 
begin
declare @tongtien int 
select @tongtien=Sum(SLDat*DonGia) from tblCTDonHang where SoDH = @SoDH 
return @tongtien 
end 

print dbo.fbt3 ('DH02')

-- 4 
create trigger tbt4 on tblDonHang 
instead of delete as
if not exists (select * from deleted d join tblDonHang dh on d.SoDH = dh.SoDH)
begin 
raiserror (N'Không tìm thấy đơn hàng để xóa',16,1);
rollback 
return 
end 
else
begin
delete from tblCTDonHang where SoDH in (Select SoDH from deleted)
delete from tblDonHang where SoDH in (Select SoDH from deleted)
end 
delete from tblDonHang where SoDH = 'DH01'
select * from tblCTDonHang 