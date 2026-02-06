use testDB 

create table SinhVien 
(
Id int primary key ,
Name nvarchar(50),
Adr nvarchar(50)
)
create table demo 
(
Id int primary key ,
Name nvarchar(50),
Adr nvarchar(50)
)
select * from SinhVien 