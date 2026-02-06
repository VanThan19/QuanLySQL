--1. Thiết kế ERD và DDL (SQL Server) để lưu trữ thông tin về các seminar, buổi giảng phụ đạo của các thầy cô bên bộ 
--môn SE. Mỗi giảng viên có thể tổ chức nhiều seminar/buổi phụ đạo khác nhau và mỗi seminar/buổi phụ đạo chỉ do một 
--giảng viên phụ trách 
--Thông tin lưu trữ bao gồm: mã số giảng viên, tên giảng viên, email, phone, bộ môn (SE, CF, ITS,
--Incubator), ngày giờ seminar/phụ đạo, loại hình tổ chức (seminar, phụ đạo, workshop), chủ đề, tóm tắt nội dung,
--phòng học (nếu tiến hành offline), online-link (nếu tiến hành online), sĩ số dự kiến.

-- CHIẾN LƯỢC THIẾT KẾ : GOM THÀNH 1 BẢNG 
-- XEM : ĐA TRỊ, COMPOSITE , LOOKUP, LẶP LẠI TRÊN 1 NHÓM CỘT 
--      TÁCH DÒNG HƠN TACHS CỘT 

CREATE DATABASE DBDESIGN_ACTIVITIES
USE DBDESIGN_ACTIVITIES 

Create table Activities_V1
(
LectID char(8) ,
LectName nvarchar(30), -- composite , tách nếu muốn sort 
Email varchar(50),
Phone char(11),
Major varchar(30),
StartDate datetime,
Actype nvarchar(30), -- workshop, phụ đạo
Topic nvarchar(30), -- giới thiệu về array list 
Intro nvarchar(250), -- giới thiệu nội dung 
Room nvarchar(50), -- lưu hyperlink của zoom, meet, phòng 
Seats int 
)

select * from Activities_V1

Insert into Activities_V1 values ('00000001',N'HÒA.ĐNT','hoadnt@','09x','CF','2021-11-3','seminar',N'Nhập môn Machine Learning',N'....',
                               N'Phòng seminar Thư viện FPT',100)

Insert into Activities_V1 values ('00000001',N'HÒA.ĐNT','hoadnt@','09x','CF','2021-11-3','Seminar',N'Giới thiệu về YOYO',N'....',
                               N'Phòng seminar Thư viện FPT',100)

Insert into Activities_V1 values ('00000001',N'HÒA.ĐNT','hoadnt@','09x','CF','2021-11-3 08:00:00','seminar',N'Nhập môn LQMB',N'....',
                               N'Phòng seminar Thư viện FPT',100)

-- Ưu điểm nhược điểm 
Create table giangVien_V2
(
LectID char(8) primary key ,
LectName nvarchar(30), -- composite , tách nếu muốn sort 
Email varchar(50),
Phone char(11),
Major varchar(30)
)
Insert into giangVien_V2 values ('00000001',N'HÒA.ĐNT','hoadnt@','09x','CF')
Create table Activities_V2
(
SQE int Identity primary key,
StartDate datetime,
Actype nvarchar(30), -- workshop, phụ đạo, coi chừng gõ 
Topic nvarchar(30), -- giới thiệu về array list 
Intro nvarchar(250), -- giới thiệu nội dung 
Room nvarchar(50), -- lưu hyperlink của zoom, meet, phòng 
Seats int ,
LectID char(8) references giangVien_V2(LectID)
)
Insert into Activities_V2 values ('2021-11-3','seminar',N'Nhập môn Machine Learning',N'....',
                               N'Phòng seminar Thư viện FPT',100,'00000001')
Insert into Activities_V2 values ('2021-11-3','seminar',N'Giới thiệu YOYO(p1)',N'....',
                               N'Phòng seminar Thư viện FPT',100,'00000001')
Insert into Activities_V2 values ('2021-11-3','seminar',N'Giới thiệu YOYO(p2)',N'....',
                               N'Phòng seminar Thư viện FPT',100,'00000001')

Select * from giangVien_V2
Select * from Activities_V2