USE Northwind 

------------------------------------------------------------------------------------
-- Lí thuyết 
-- Cú pháp mở rộng lệnh Select 
-- Ta muốn sắp xếp dữ liệu/sort theo tiêu chí nào đó, thường là tăng dần - Ascending/Asc
--                                                              giảm dần - Descending/DESC
-- mặc định ko nói gì cả thì là sort tăng dần
-- A < B < C
--1 < 2 < 3
-- Ta có thể sort trên nhiều cột, logic này từ từ tính
-- Select .... From <Tên-Table> Order By tên - cột muốn sort ( kiểu sort>

------------------------------------------------------------------------------------

--1. In ra dan sách nhân viên
Select * From Employees

-- 2. In ra danh sách nhân viên tăng dần theo năm sinh
Select *From Employees Order By BirthDate ASC
Select *From Employees Order By BirthDate -- Mặc định là tăng dần 

-- 3. Sắp xếp giảm dần .
Select *From Employees Order By BirthDate DESC 

-- 4. Tính tiền chi tiết mua hàng .
Select * From [Order Details]

Select *, UnitPrice * Quantity * ( 1- Discount)  From [Order Details]

-- 5. Tính tiền chi tiết mua hàng, sắp xếp giảm giần theo số tiền 
Select * From [Order Details]
Select *, UnitPrice * Quantity * ( 1- Discount) as Tong  From [Order Details] Order by Tong DESC

-- 6. In ra danh sách nhân viên giảm dần theo tuổi
Select * From Employees
Select EmployeeID,FirstName , BirthDate, Year(GetDate()) - Year(BirthDate) as Age From Employees Order by Age DESC
