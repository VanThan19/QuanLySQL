USE Northwind 

------------------------------------------------------------------------------------
-- Lí thuyết 
-- Cú pháp mở rộng lệnh Select 
-- Trong thực tế có những lúc dữ liệu/info chưa xác định được nó là gì??
-- kí tên danh sách thi, danh sách kí tên có cột điểm 
-- chưa xác định được. Từ từ sẽ có, sẽ update sau
-- Hiện tượng dữ liệu chưa xác định, chưa biết, từ từ đưa vào sau, hiện nhìn vào 
-- chưa thấy có data , thì ta gọi giá trị chưa xác định này là NULL
-- Null đại diện cho thứ chưa xác định, chưa xác định tức là ko có giá trị, ko giá trị thì 
-- ko thể so sánh > >= < <= = != 
-- cấm tuyệt đối xài các toán tử so sánh kèm với giá trị null
-- ta dùng toán tử , is null, is not null, not(is null) để filter cell có giá trị null 
-- Ta dùng toán tử , IS NULL, IS NOT NULL, NOT (IS NULL) để lọc cell có giá trị null

--------------------------------------------------------------------------------------------------
--1. In ra danh sách nhân viên 
Select *From Employees
--2. Ai chưa xác định khu vực ở, region null
Select *From Employees Where Region = NULL -- 0 , vì không có ai ở khu vực tên là Null
Select *From Employees Where Region IS Null -- 4
--3. Những ai đã xác định được khu vực cư trú 
Select *From Employees Where Region IS NOT Null 
Select *From Employees Where NOT Region IS NULL
--Not đi kèm với mệnh đề 
-- 4. Những nhân viên đại diện kinh doanh và xác định dc nơi cư trú 
Select *From Employees Where Title = 'Sales Representative' AND NOT (Region IS NULL)
Select *From Employees Where Title = 'Sales Representative' AND  Region IS NOT NULL
-- 5. Liệt kê danh sách khách hàng đến từ Anh,Pháp ,Mĩ ,có cả thông tin số faxx và region
Select *From Customers Where Country IN ('UK','USA','France') AND FAX IS NOT NULL AND Region IS NOT NULL 