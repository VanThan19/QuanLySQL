Use Northwind 
------------------------------------------------------------------------------------
-- Lí thuyết 
-- Một DB là nới chứa data (bán hàng, thư viện, qlsv..)
-- Data được lưu trữ dưới dạng Table, tách thành nhiều Table (nghệ thuật design db, NF)
-- Dùng lệnh Select để xem/in dữ liệu Table, cũng hiển thị dưới dạng Table
-- Cú pháp chuẩn : SELECT * FROM <tên - table>
--           * : đại diện cho việc tui muốn lấy all of colums/ có bao nhiêu cột lấy sạch

-- Cú pháp mở rộng : 
--                SELECT tên-các-cột-muốn-lấy, cách-nhau-dấu-phẩy FROM <tên-TABLE>
--                SELECT có-thể-dùng-các-hàm-xử-lí-các-cột-để-độ-lại-thông-tin-hiển-thị
--                     FROM <tên-Table>

-- Data trả về có cell/ô có từ NULL , hiểu rằng chưa xác định value/giá trị, chưa có,chưa 
-- biết từ từ cập nhật sau . Ví dụ sinh viên kí tên vào danh sách thi, cột điểm ngay lúc 
-- kí tên gọi là NULL là mang trạng thái chưa xác định 
-------------------------------------------------------------------------------------
-- 1. Xem thông tin của tất cả các khách hàng đang giao dịch với mình
select * from Customers
-- 2. Xem thông tin nhân viên, xem hết các cột luôn
select * from Employees
-- 3. Xem các sản phẩm có trong kho
select * from Products
-- 4. Mua hàng, thì thông tin sẽ nằm ở table orders và orderDetails
select *from Orders
-- 5. Xem công ty giao hàng 
select * from Shippers
INSERT INTO Shippers(CompanyName,Phone) Values ('NguyenThan','(084)83838')
-- 6. Xem chi tiết mua hàng
select * from [Order Details]
-- 7. In ra thông tin khách hàng, chỉ gồm cột ID, ComName, ContactName, Country
Select CustomerID, CompanyName, ContactName, Country From Customers
-- 8. In ra thông tin nhân viên
-- Tên người tách thành Last và First : dành cho mục tiêu sort theo tiêu chí tên,họ. In ra 
-- tên theo quy ước mỗi quốc gia.
Select * From Employees
Select EmployeeID, LastName, FirstName, BirthDate From Employees
--9. Ghép tên in ra thông tin nhân viên, ghép tên cho đẹp/gộp cột, tính luôn tuổi giùm
Select EmployeeID, LastName + ' ' + FirstName as [FULL NAME], YEAR(BirthDate) as [Tuổi] From Employees
Select EmployeeID, LastName + ' ' + FirstName as [FULL NAME],BirthDate,Year(GETDATE()) - YEAR(BirthDate) as [Tuổi] From Employees
--10.In ra thông tin chi tiết mua hàng.
Select *From [Order Details]
Select *, UnitPrice * Quantity as [Tổng] From [Order Details]
-- Công Thức Tính Tổng tiền phải trả từng món, có trừ đi giảm giá, phần trăm
-- SL * DG - Tiền giảm giá ==>> Tiền phải trả 
-- Sl * DG - SL * DG * Discount (%) == Phải trả 
-- SL * DG(1- Discount) == tiền phải trả 
Select *, UnitPrice * Quantity * (1-Discount) as [Tổng] From [Order Details]