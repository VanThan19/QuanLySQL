use Northwind -- Chọn để chơi với thùng chứa data nào đó
              -- tại 1 thời điểm chơi với 1 thùng chứa data
			  
select * from Customers

select * from Employees

------------------------------------------------------------------------------
-- LÍ THUYẾT 
-- 1. DBE cung cấp câu lệnh SELECT dùng để 
--       in ra màn hình 1 cái gì đó ~~~ printf() sout()
--       in ra dữ liệu có trong table(hàng/cột)
--       dùng cho mục đích nào thì kết quả hiện thị luôn là table

-------------------------------------------------------------------------------

-- THỰC HÀNH
-- 1. Hôm nay ngày bao nhiêu??
SELECT GETDATE()

SELECT GETDATE() as [Hôm nay là ngày]

-- 2. bây giờ là tháng mấy hỡi em??
SELECT month (GETDATE()) as [Bây giờ tháng mấy?]

SELECT year (GETDATE())

-- 3. Trị tuyệt đối của -5 là mấy ??
SELECT  abs(-5) as [Trị tuyệt đối của -5 là mấy ??]

-- 4. 5+5 là mấy?
select 5 + 5 

-- 5. in ra tên của mình 
select N'Nguyễn Văn Thân' as [ Họ và Tên]
select N'Nguyễn' + N'Văn Thân' as [ Họ và Tên] -- N là tao muốn in tiếng việt

-- 6. Tính tuổi và in ra tuổi
select year (GETDATE()) - 2005 as [ Tuổi của tui :]
--select N'Nguyễn' + N'Văn Thân' + (year (GETDATE()) - 2005) + 'years old' Lỗi vì lộn xộn kiểu data

select N'Nguyễn'  +  N'Văn Thân' + convert(varchar, year (GETDATE()) - 2005) + ' years old' as [ My profile]
-- convert là biến đổi : được cấy năm sinh , tuổi xong biến đổi thành varchar kiểu dữ liệu chữ.

select N'Nguyễn'  +  N'Văn Thân' + cast(year (GETDATE()) - 2005 as varchar) + ' years old' as MyProfile
--7. Phép nhân 2 số
Select 10*10 



