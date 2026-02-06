-- 1. Tạo CSDL QLBanHang với các yêu cầu về kích thước
CREATE DATABASE QLBH
ON Primary
(  NAME = QLBH_Data,
   FILENAME = 'D:\QLBH_Data.mdf',
   SIZE = 50MB,
   MAXSIZE = 200MB,
   FILEGROWTH = 10%
)
LOG ON
(
   NAME=QLBH_Log,
   FILENAME='D:\QLBH_Log.ldf',	
   SIZE=10MB,
   MAXSIZE = UNLIMITED,
   FILEGROWTH = 5MB
)