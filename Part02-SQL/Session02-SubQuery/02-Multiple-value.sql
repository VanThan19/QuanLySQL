USE Northwind 

------------------------------------------------------------------------------------
-- Lí thuyết 
-- Cú pháp chuẩn của câu lệnh Select 
-- Select *From <Table> Where ....
-- Where Cột = value nào đó 
-- Where Cột IN (Một tập hợp nào đó)
--ví dụ : City IN('London','Berlin','NewYork')-- thay bằng OR OR OR
-- Nếu có 1 câu sql mà trả về được 1 cột, nhiều dòng 
-- Một cột và nhiều dòng thì ta có thể xem nó tương đương 1 tập hợp 
-- Select CITY From Employees, bạn được 1 loạt các thành phố 
-- Ta có thể nhét/ lồng câu 1 cột nhiều dòng vào trong mệnh đề IN của câu Sql bên ngoài 
-- * Cú pháp 
-- WHERE CỘT IN ( MỘT CÂU SELECT TRẢ VỀ 1 CỘT NHIỀU DÒNG - NHIỀU VALUE CÙNG KIỂU- TẬP HỢP)
-------------------------------------------------------------------------------------------

-- Thực hành 
--1. Liệt kê các nhóm hàng 
select *From Categories
--2. In ra các món hàng thuộc nhóm 1 6 8
select *From Products Where CategoryID IN ( 1, 6, 8)
select *From Products Where CategoryID = 1 OR CategoryID = 6 Or CategoryID = 8 
-- 3. In ra các món hàng thuộc nhóm bia/rượu, thịt, và hải sản
select *From Products Where CategoryID IN ( Select CategoryID From Categories
               Where CategoryName IN ('Beverages','Meat/Poultry','seafood'))
-- 4. Nhân viên quê London phụ trách những đơn hàng nào 
Select *From Orders Where EmployeeID IN (Select EmployeeID From Employees Where City ='London')

--BTVN
-- Sử dụng IN để đảm bảo rằng nếu có nhiều nhà cung cấp đến từ Mỹ, tất cả các sản phẩm từ những nhà cung cấp sẽ được lấy ra 
-- dấu = trong sql chỉ dùng so sánh một giá trị duy nhất, nghĩa là kết quả từ câu truy vấn con (subquery) phải 
-- trả về đúng một giá trị (scalar value). Nếu câu truy vấn con trả về nhiều hơn một giá trị, thì dấu = sẽ gây ra lỗi 
-- vì ko thể si sánh 1 giá trị đơn với một tập hợp nhiều giá trị
-- 1. Các nhà cung cấp đến từ Mĩ cung cấp những mặt hàng nào 
Select *From Suppliers
select *From Products
Select *From Products Where SupplierID IN (Select SupplierID From Suppliers Where Country='USA') 
-- 2. Các nhà cung cấp đến từ Mĩ cung cấp những nhóm hàng nào
Select *From Categories where CategoryID IN (Select SupplierID From Suppliers Where Country='USA') 
-- 3. Các đơn hàng vận chuyển tới thành phố Sao Paulo đc vận chuyển bởi những hãng nào 
-- các công ty nào đã vận chuyển tới Sao paulo
Select * From Orders Where ShipCity = 'Oulu'
Select * From Shippers
Select * From Shippers Where ShipperID IN ( Select ShipVia From Orders Where ShipCity = 'Reims')
-- 4. Khách hàng đến từ thành phố Berlin, London, madrid có những đơn hàng nào
-- Liệt kê các đơn hàng của khách hàng đến từ Berlin, london, madrid
select * from Customers
Select *From Orders Where CustomerID IN ( Select CustomerID From Customers Where CITY IN ('Berlin' , 'London' , 'Madrid'))
