-- PHẦN NÀY THÍ NGHIỆM CÁC LOẠI RÀNG BUỘC - CONSTRAINT - QUY TẮC GÀI TRÊN DATA 

-- 1. RÀNG BUỘC PRIMARY KEY 
-- TẠM THỜI CHẤP NHẬN PK LÀ 1 CỘT ( TƯƠNG LAI CÓ THỂ CÓ NHIỀU CỘT) MÀ GIÁ TRỊ CỦA NÓ TRÊN MỌI DÒNG/MỌI CELL CỘT NÀY 
-- KHÔNG TRÙNG LẠI, MỤC ĐÍCH DÙNG ĐỂ WHERE RA ĐƯỢC 1 DÒNG DUY NHẤT 
-- 
-- VALUE CỦA KEY CÓ THỂ DC TẠO RA THEO 2 CÁCH 
-- CÁCH 1 : TỰ NHẬP = TAY. DB ENGINE SẼ TỰ KIỂM TRA GIÙM MÌNH CÓ TRÙNG HAY KO?
--               NẾU TRÙNG DBE TỰ BÁO VI PHẠM PK CONSTRAINT

-- CÁCH 2 : ÉO CẦN NHẬP = TAY CÁI VALUE CỦA PK, MÁY/DBE TỰ GENERATE CHO MÌNH 1 CON SỐ KO TRÙNG LẠI !!! CON SỐ TỰ TĂNG,
--                                                                       CON SỐ HEXA...

-- THỰC HÀNH 
-- Thiết kế table lưu thông tin đăng kí event nào đó ( giống đăng kí qua Google Form)
-- thông tin cần lưu trữ : số thứ tự đăng kí, tên full name, email, ngày giờ đăng kí , số di động,...
-- * phân tích : 
-- ngày giờ đki: ko bắt nhập, default 
-- số thứ tự : nhập vào là bậy rồi!!! tự gán chứ !!!
-- email, phone : ko cho trùng nha, 1 email 1 lần đki 
-- ...
USE DBDESIGN_ONETABLE
/*
CREATE TABLE REGISTRATION 
(
  SEQ INT PRIMARY KEY,
  FIRTNAME nvarchar (10),
  LastName nvarchar (30),
  Email varchar(50),
  Phone varchar(11),
  RegDate datetime Default getdate() -- constraint default 

)
*/
CREATE TABLE REGISTRATION 
(
  SEQ INT PRIMARY KEY IDENTITY , -- mặc định đi từ 1, nhảy ++ cho người sau 
                                 -- IDENTITY(1,5) , từ 1,6,11...
  FIRTNAME nvarchar (10),
  LastName nvarchar (30),
  Email varchar(50),
  Phone varchar(11),
  RegDate datetime Default getdate() -- constraint default 

)
-- Đăng kí event 
Insert into REGISTRATION values (N'An',N'Nguyễn','an@...','090x') -- báo lỗi ko có map dc các cột rõ ràng 

Insert into REGISTRATION values (N'An',N'Nguyễn','an@...','090x',null)
select *from REGISTRATION

Insert into REGISTRATION (firtName,Lastname,Email,Phone) values (N'Bình',N'Nguyễn','an@...','091x')
--  XÓA 1 DÒNG CÓ AUTO GENERATED KEY, THÌ TABLE SẼ LỦNG SỐ, DBE KO LẤP CHỖ LỦNG 
-- 1 2 3 4 5 6 , XÓA 3, CÒN 1 2 4 5 6, ĐĂNG KÍ TIẾP TÍNH TỪ 7 
