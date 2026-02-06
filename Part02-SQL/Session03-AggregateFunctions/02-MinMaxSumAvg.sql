USE Northwind
-------------------------------------------------------------------------------------------------
-- LÝ THUYẾT
-- DB ENGINE hỗ trợ 1 loạt nhóm hàm dùng thao tác trên nhóm dòng/cột , gom data tính toán 
-- trên đám data gom này - nhóm hàm gom nhóm - AGGREGATE Functions, AGGEGATION
-- COUNT() SUM() MIN() MAX() AVG()
-- * CÚ PHÁP CHUẨN 
-- SELECT CỘT...., HÀM GOM NHÓM(),.... FROM <TABLE>
-- SELECT CỘT ,.... HÀM GOM NHÓM(),....FROM<TABLE> WHERE .... GROUP BY...HAVING (TỨC LÀ WHERE THỨ 2)

-------------------------------------------------------------------------------------------------
-- THỰC HÀNH 
--1. liệt kê danh sách nhân viên 
select *from Employees
--2. năm sinh nào là bé nhất 
select *from Employees where BirthDate <= All (select BirthDate from Employees)
select MIN(BirthDate) from Employees
-- 3. Ai sinh năm bé nhất, ai lớn tuổi nhất, in ra info 
select *from Employees where BirthDate = (select MIN(BirthDate) from Employees)
select *from Employees where BirthDate <= ALL (select MIN(BirthDate) from Employees)
-- 4. trong các đơn hàng , đơn hàng nào có trọng lượng nặng nhất/nhỏ nhất 
Select *from orders where Freight = (select MAX(Freight) from orders)
--4.1 trọng lượng nào là lớn nhất trong các đơn hàng đã bán 
Select *from orders order by Freight DESC 
select MAX(Freight) from orders 
-- 5. tính tổng khối lượng của các đơn hàng đã vận chuyển -- 830 đơn hàng 
Select *from orders 
select count(*) from orders 
select sum(freight) from orders 
-- 6. trung bình các đơn hàng nặng bao nhiêu 
select avg(freight) from orders 
--7. liệt kê các đơn hàng có trọng lượng nặng hơn trọng lượng trung bình của tất cả 
select *from orders where Freight >= (select avg(freight) from orders)
--8. có bao nhiêu đơn hàng có trọng lượng nặng hơn trọng lượng trung bình 
select count(*) from orders where Freight >= (select avg(freight) from orders)
-- Nhắc lại 
-- Cột xuất hiện trong select hàm ý đếm theo cột này, cột phải xuất hiện trong group by
-- Tỉnh, <đếm cái gì đó của tỉnh > --> rõ ràng phải chia theo tỉnh mà đếm -- group by tỉnh 
-- chuyên ngành , <đếm của chuyên ngành> -> chia theo chuyên ngành mà đếm 
                                          -- group by chuyên ngành
-- có quyền group by trên nhiều cột 
-- ÔN tập thêm 
-- 1. In ra danh sách nhân viên 
Select *From Employees 
--2. đếm xem mỗi khu vực có bao nhân viên 
Select region,count(region) From Employees Group by Region -- sai do đếm null 
-- 0 và 5 , do null ko dc xem là value để đếm, nhưng vẫn là 1 value để được chia nhóm , nhóm ko có giá trị 
Select region,count(*) From Employees Group by Region -- đúng do đếm dòng 

--3. Khảo sát đơn hàng 
select *from orders 
-- mỗi quốc gia có bao nhiêu đơn hàng 
select count(*) from orders group by ShipCountry
-- quốc gia nào từ 100 đơn hàng trở lên
select shipCountry,count(*) from orders group by ShipCountry having count(*) >=100 
-- quốc gia nào có nhiều đơn hàng nhất 
select shipCountry , count(*) from orders group by  shipCountry having count(*) <= ALL(select count(*) from orders group by ShipCountry) 
Select MAX(NO) from 
(select shipCountry,count(*) as NO from orders group by ShipCountry) as ctyd

-- 6. liệt kê các đơn hàng của khách hàng mã số vinet 
select *from orders where CustomerID = 'Vinet' 
-- 7. Vinet đã mua bao nhiêu lần 
select CustomerID, count(*) from orders where CustomerID = 'Vinet' group by CustomerID