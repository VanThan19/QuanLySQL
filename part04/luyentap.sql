create database QLThucTap 
Use QLThucTap 

create table giangVien (
maGv int primary key ,
hotenGv char(30),
bomon char(50) )

--drop table sv 
create table sv (
maSv int primary key,
hotenSv char(30),
namsinh int ,
quequan char(50) )

create table detai  (
madt char(10) primary key ,
tendt char(30) ,
kinhphi decimal (10,2) )

create table HD (
maSv int primary key , 
madt char(10) foreign key references detai ,
maGv int foreign key references giangVien ,
ketqua decimal (5,2) )

INSERT INTO giangVien VALUES
(1001,'Le Giap','Khoa hoc may tinh'),
(1002, 'Tran At', 'He thong thong tin'),
(1003, 'Bui Binh','Ky thuat may tinh'),
(1004,'Phan Dinh','Mang & Truyen thong'),
(1005,'Nguyen Mau','Phuong phap giang day');

INSERT INTO sv VALUES
(1,'Le Van Xuan',1990,'Nghe An'),
(2,'Tran Nguyen Ha',1990,'Thanh Hoa'),
(3,'Bui Xuan Thu',1992,'Nghe An'),
(4,'Phan Tuan Dong',null, 'Ha Tinh'),
(5,'Le Thanh Xuan',1989,'Ha Noi'),
(6,'Nguyen Thu Ha',1991,'Thanh Hoa'),
(7,'Tran Xuan Tay',null,'Ha Tinh'),
(8,'Hoang Long Nam',1992,'Nam Dinh')

INSERT INTO detai VALUES
('DT01','Semantic Web',100),
('DT02','Document DB',500),
('DT03','Graph DB',100),
('DT04','Cloud Computing',300)
INSERT INTO HD VALUES
(1,'DT01',1003,8),
(2,'DT03',1004,9),
(3,'DT03',1003,10),
(5,'DT04',1004,7),
(6,'DT01',1003,8),
(7,'DT04',1001,10);

--1)Đưa ra thông tin cá nhân của tất cả sinh viên
select count(maSv) [có bao nhiều thằng] from sv 
--2)Cho biết mã số, họ tên và quê quán của các sinh viên ở ‘Nghệ An’
select *from sv where sv.quequan = 'Nghe An'
--3)Cho biết mã số, họ tên và tuổi của tất cả các sinh viên
select maSv, hotenSv, year(getdate()) - namsinh  [Tuổi] from sv
--4)Cho biết họ tên, năm sinh của các sinh viên có mã số là 5, và 7.
select *from sv where maSv IN (5 , 7)
select *from sv where maSv = 5 or maSv = 7 
-- 5)Cho biết họ tên, và quê quán của các sinh viên không ở ‘Nghệ An’ và ‘Hà Nội’
select *from sv where sv.quequan != 'Nghe AN' and sv.quequan != 'Ha noi'
select *from sv where NOT (sv.quequan IN ('Nghe An' , 'Ha Noi'))
-- 6)Đưa ra họ tên, năm sinh và quê quán của các sinh viên ở ‘Thanh Hóa’ và sinh năm 1990
select *from sv where sv.quequan ='Thanh Hoa' and sv.namsinh = 1990
--7)Cho biết thông tin cá nhân của các sinh viên sinh năm 1990 và có quê ở ‘Nghệ An’ hoặc quê ở ‘Thanh Hóa’
select *from sv where sv.namsinh = 1990 and (sv.quequan = 'Nghe an'or sv.quequan = 'thanh hoa')
select *from sv where sv.namsinh = 1990 and quequan in ('Nghe an','thanh hoa')
-- 8. Cho biết thông tin cá nhân của các sinh viên có mã số 1, 3, 5, và 7
select *from sv where sv.maSv in (1,3,5,7)
--9)Đưa ra thông tin gồm tên và kinh phí của các đề tài có kinh phí từ 200 triệu đồng đến 500 triệu đồng và sắp xếp 
--theo thứ tự giảm dần của kinh phí.
select *from detai
select *from detai d where d.kinhphi >= 200 AND d.kinhphi <= 500 order by d.kinhphi DESC  
select *from detai d where d.kinhphi between 200 and 500 
--10)Cho biết thông tin cá nhân về các sinh có họ ‘Tran’
select *from sv 
select *from sv where sv.hotenSv Like 'Tran%' 
--11)Đưa ra họ tên, năm sinh và quê quán của các sinh viên có tên ‘Xuan’
select *from sv where sv.hotenSv Like '%Xuan'
--12)Đưa ra họ tên, năm sinh và quê quán của các sinh viên mà họ và tên chứa từ ‘Xuan’
select *from sv where sv.hotenSv Like '%Xuan%'
-- 13)Cho biết họ tên, quê quán và mã số của các sinh viên chưa có thông tin năm sinh.
select *from sv where sv.namsinh is null 