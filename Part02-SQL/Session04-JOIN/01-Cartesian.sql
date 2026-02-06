
create database Cartersian
USE Cartersian 
-- DB tương đương 1 cái kho tủ ~~ thùng chứa data bên trong
-- data bên trong cất dưới dạng kệ có ngăn - table 
create table Endict  -- DDL(một nhánh Sql) -- tạo dàn khung -- Data Defintion Language -- giúp định nghĩa ra các cấu trúc 
                                                                                       -- dữ liệu 
(
  Numbr int ,
  Endesc varchar(30)
)
--Drop table Endict       -- DDL 
-- Từ điển tiếng anh số đếm 
--1 one 
--2 two
-- CHÈN DATA 
select *from Endict -- DML Data Manipulation Language : tạo dựng data 
insert into endict Values (1, 'one') -- DML 
insert into endict Values (2, 'two')
insert into endict Values (3, 'three')

-- Phần này thêm cho outer join 
insert into endict Values (4, 'four')

create table Vndict  
(
  Numbr int ,
  Vndesc Nvarchar(30) -- nvarchar () string lưu tiếng việt -- varchar string lưu tiếng anh 
)
--Drop table Vndict 
select *from Vndict -- DML Data Manipulation Language : tạo dựng data 
insert into Vndict Values (1, N'Một') -- DML 
insert into Vndict Values (2, N'Hai')
insert into Vndict Values (3, N'Ba')
insert into Vndict Values (5, N'Năm')

Select *from Endict 
Select *from Vndict 
-- BÔI ĐEN CẢ 2 LỆNH NÀY CHẠY THÌ NÓ KO PHẢI LÀ JOIN , NÓ LÀ 2 CÂU RIÊNG BIỆT CHẠY 
-- CÙNG LÚC CHO 2 TẬP KẾT QUẢ RIÊNG BIỆT.
-- JOIN LÀ GỘP CHUNG 1 THÀNH 1 BẢNG TẠM TRONG RAM, KO ẢNH HƯỞNG DỮ LIỆU GỐC CỦA MỖI TABLE 
-- JOIN LÀ SELECT CÙNG LÚC NHIỀU TABLE 
Select *from Endict , Vndict -- sinh table mới, tạm thời lúc chạy thôi 
                             -- số cột = tổng 2 bên 
							 -- số dòng - tích 2 bên
Select *from Vndict, Endict order by Endesc   
-- KHI GHÉP TABLE , JOIN BỊ TRÙNG TÊN CỘT, dùng alias (as), đặt tên giả để tham chiếu chỉ định cột thuộc table tránh nhầm 

Select *from Vndict, Endict order by VnDict.Numbr 
-- tham chiếu cột qua table 
Select *from Vndict vn, Endict en  order by en.Numbr -- đặt tên ngắn/giả cho table dùng tham chiếu cho các cột
Select vn.Numbr, vn.VnDesc,en.Endesc From Vndict vn, Endict en  order by en.Numbr
Select vn.*, en.* From Vndict vn, Endict en  order by en.Numbr

-- CÚ PHÁP THỨ 2 
Select vn.*,en.Endesc From Vndict vn Cross Join  Endict en  order by en.Numbr
-- TUI BIẾT RẰNG CÓ CẶP GHÉP XÀI DC VÌ CÓ SỰ TƯƠNG HỢP TRONG CELL NÀO ĐÓ.
Select * From Vndict vn , Endict en WHERE VN.Numbr = EN.Numbr -- GHÉP CÓ CHỌN LỌC KHI TÌM TƯƠNG QUAN CỘT/CELL ĐỂ GHÉP 
                                                              -- iNNER JOIN/OUTER /EQUI JOIN/
															  -- ĐA PHẦN TƯƠNG GHÉP THEO TOÁN TỬ =
															  -- CÒN CÓ THỂ GHÉP THEO > >= < <> !=

