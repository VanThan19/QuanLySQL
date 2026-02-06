USE Northwind 

------------------------------------------------------------------------------------
-- Lí thuyết 
-- Cú pháp chuẩn của câu lệnh Select 
-- Select *From <Table> Where ....
-- Where Cột = value nào đó 
-- Where Cột Like Patten/mẫu nào đó 
-- Where Cột Between Range
-- Where Cột IN (Tập hợp giá trị được liệt kê)
-- 1 câu select tùy cách viết có thể trả về đúng 1 value/cell 
-- 1 câu select tùy cách viết có thể trả về đúng 1 tập value/cell 
--1 tập kết quả này đồng nhất ( các giá trị khác nhau của 1 biến)

-- ***
-- Where cột = value nào đó - đã học, vd: year(dob) = 2003
--          = thay value này = 1 câu sql khác miễn trả về 1 cell 
-- kĩ thuật viết câu sql theo kiểu hỏi gián tiếp , lồng nhau, trong câu sql
-- chứa câu sql khác

-----------------------------------------------------------------------------------
-- Thực hành 
-- 1. In ra danh sách nhân viên
Select *From Employees
Select FirstName From Employees Where EmployeeID = 1 -- 1 value/cell trả về 
Select FirstName From Employees -- 1 tập giá trị/1 cột/phép chiếu 
-- 2. Liệt kê các nhân viên ở London
Select * from Employees where city = 'london'
-- 3. Liệt kê các nhân viên cùng quê với King Robert 
Select City From Employees where FirstName = 'Robert' -- 1 value london
-- đáp án cho câu 3 
Select * From Employees where  City = ( Select City From Employees where FirstName = 'Robert' )
-- trong kết quả còn robert bị dư, tìm cùng quê R ko cần nói lại R
Select * From Employees where  City = ( Select City From Employees where FirstName = 'Robert' ) AND FirstName <> 'Robert' 
-- 4. Liệt kê tất cả các đơn hàng 
Select *From Orders Order By Freight DESC 
-- 4.1 Liệt kê tất cả các đơn hàng trọng lượng lớn hơn 252 kg
Select *From Orders Where Freight >= 252 Order By Freight DESC
-- 4.2 Liệt kê các đơn hàng có trọng lượng lớn hơn trọng lượng đơn hàng 10555
Select *From Orders Where Freight >= ( Select Freight From Orders where OrderID = 10555) AND OrderID != 10555 

-- BTVN 
-- 1. Liệt kê danh sách các công ty vận chuyển hàng 
Select *From Shippers  
-- 2. Liệt kê danh schs các đơn hàng được vận chuyển bởi công ty giao vận có mã số 1
Select *From Orders Where ShipVia = 1
-- 3. liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao vận có tên Speedy Express 
Select * from Orders Where ShipVia = ( Select ShipperID From Shippers Where CompanyName = 'Speedy Express')
-- 4. Liệt kê danh sách các đơn hàng được vận chuyển bởi công ty giao vận có tên Speedy Express và trọng lường từ 50-100
Select * From Orders Where ShipVia = ( Select ShipperID From Shippers Where CompanyName = 'Speedy Express') 
                                        AND (Freight Between 50 AND 100) Order By Freight Desc   
-- 5. Liệt kê các mặt hàng cùng chủng loại ( table cét li) với mặt hàng Filo Mix 
-- Filo Mix là sp/mặt hàng, thuộc nhóm gì mình chưa biết 
Select * From Categories
Select *From Products
Select *From Products Where CategoryID = ( Select CategoryID From Products where ProductName = 'Filo Mix')

-- 6. Liệt kê các nhân viên trẻ tuổi hơn nhân viên Janet 
-- Trẻ hơn là năm sinh lớn hơn
Select *From Employees Where BirthDate > (Select BirthDate From Employees Where FirstName = 'Janet') 