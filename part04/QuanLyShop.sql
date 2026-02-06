create database QuanLyShop
use QuanLyShop 


create table Users 
(
Id int primary key identity (1,1) ,
FullName nvarchar(100) not null,
Email nvarchar(100) unique not null,
Password nvarchar(100) not null, 
NgayTao datetime NOT NULL DEFAULT GETDATE()
)
Insert into Users(FullName,Email,Password) values (N'Nguyễn Văn Thân','Admin2005@gmail.com','123')
select * from Users 
create table Categories
(
    Id int primary key identity (1,1),
    Name nvarchar(100) not null
)
Insert into Categories (Name) values (N'Hải Sản'),(N'Thịt'),(N'Nước Uống'),(N'Hoa Quả')
