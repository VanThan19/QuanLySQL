create database facebook 
use facebook 

create table users 
(
MaID int primary key identity(1,1),
Acc nvarchar(50) not null, 
Pass nvarchar(50) not null,
sdt char(10)
)
select * from users 
insert into users values ('Than1905','123','1234567890')
create table category 
(
Id int primary key identity,
CategoryName nvarchar(50),
GhiChu nvarchar(250)
)
insert into category(categoryName,GhiChu) values (N'Hải Sản',N'Hải Sản Tươi Sống'),(N'Thịt',N'Thịt Tươi'),(N'Hoa Quả',N'Hoa Quả Sạch')
CREATE TABLE foods (
    Id int primary key identity ,
	Name nvarchar(100),
    GhiChu nvarchar(150),
    Gia nvarchar(50) NOT NULL,
    IdCate int foreign key references category(id)
);

Insert into foods(Name,GhiChu,Gia,IdCate) Values (N'Tôm Hùm',N'Đắt Lắm Nha','5000$',1),(N'Cá Mú',N'Ngon Lắm Nha','500$',1),
(N'Mực Nháy',N'Ngon Tuyệt','900$',1),(N'Gà',N'Đắt Lắm Nha','5000$',2),(N'Ổi',N'Nhà Trồng','2$',3)

select * from foods f join category c on f.IdCate = c.Id