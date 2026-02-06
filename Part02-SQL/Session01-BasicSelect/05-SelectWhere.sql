USE Northwind 

------------------------------------------------------------------------------------
-- Lí thuyết 
-- Cú pháp mở rộng lệnh Select 
-- MỆNH ĐỀ WHERE : DÙNG LÀM BỘ LỌC/FILTER/ NHẶT RA NHỮNG DỮ LIỆU TA CẦN THEO 1 TIÊU CHÍ NÀO ĐÓ
-- VÍ DỤ : LỌC RA NHỮNG SINH VIÊN CÓ QUÊ Ở BÌNH DƯƠNG
--         LỌC RA NHỮNG CÓ QUÊ Ở TIỀN GIANG VÀ ĐIỂM TB >=8
-- CÚ PHÁP DÙNG BỘ LỌC :
-- SELECT * ( CỘT BẠN MUỐN IN RA) FROM <TÊN-TABLE> WHERE <ĐIỀU KIỆN LỌC>
-- ĐIỀU KHIỆN LỌC : TÌM TỪNG DÒNG, VỚI CÁI CỘT CÓ GIÁ TRỊ CẦN LỌC
--                  LỌC THEO TÊN CỘT VỚI VALUE THẾ NÀO, LẤY TÊN CỘT, XEM VALUE TRONG CELL
--                  CÓ THỎA MÃN ĐIỀU KIỆN LỌC HAY KO 
-- ĐỂ VIẾT ĐIỀU KIỆN LỌC TA CẦN
-- > TÊN CỘT
-- VALUE CỦA CỘT(CELL)
-- TOÁN TỬ (OPERATOR) > >= < <= = (MỘT DẤU = HOY, KO GIỐNG C JAVA ==), !=, <> (!= HOẶC <> CUNNGF Ý NGHĨA 
-- nhiều điều kiện lọc đi kèm , dungf thêm logic operators ,and,or,not(~~~J,C:&&||!)
-- víu dụ : where city = N'Binnhf dương'
--          where city = N'Tiền Giang' AND Gpa >=8

-- Lọc liên quan đến giá trị/value/cell chứa gì, ta phải quan tâm đến data types 
-- số : nguyên/ thực ,ghi số ra như truyền thống 5,10,3
-- Chuỗi/ kí tự : 'A', 'ahihi'
--Ngày thannngs : '2003-01-01'

------------------------------------------------------------------------------------
-- Thực hành 
--1. In ra danh sách các khách hàng 
Select *From Customers --

-- 2. In ra danh sách kh đến từ Ý 
Select * From Customers Where Country = 'Italy'

--3. In ra danh sách kh đến từ Mĩ 
Select * From Customers Where Country = 'USA'

--4. In ra những kh đênns từ Mĩ,Ý
Select * From Customers Where Country = 'Italy' OR Country = 'USA' Order By Country DESC -- giảm dần

-- 5. Inn ra kh đến từ thủ đô nước đức
Select * From Customers Where Country = 'Germany' AND City = 'Berlin'

-- 6, In thông tin ncuar nhân viên
Select * From Employees

-- 7. In ra thông tinnn của nhânn viên có năm sinh 1960 trở lại gần đây 
Select * From Employees Where Year(BirthDate) >= 1960

-- 8.. In ra thông tin nhaan viên có tuổi từ 60 tuổi lên
Select Year(GETDATE()) - Year(BirthDate) as [Tuổi], * From Employees Where Year(GETDATE()) - Year(BirthDate) >= 60 

-- 9. Những nhân viên nào ở london
Select * From Employees Where City = 'London'

-- 10 . Những ai k ở london
Select * From Employees Where City <> 'London'
-- Đảo mệnh đề 
Select * From Employees Where NOT(City = 'London')

-- 11. In ra hồ sơ nhaan viên có mã số là 1
-- đi vào ngân hầng giao dịch, hoặc đưa số tk, kèm cmnd 
Select * From Employees Where EmployeeID = 1
-- where trên key chỉ ra 1 mà thôi
-- select mà có where key chỉ 1 dòng trẩ về , distinct là vô nghĩa 

-- CThuc Full ko che của select 
-- SELECT ...     FROM ...      WHERE ... gROUP ... HAVING ... ORDER BY...
--       DISTINCT      1,N TABLE

-- 12. Xem thông tin bên đơn hàng 
Select * From Orders
-- 13. Sắp xếp giảm dần theo trọng lượng đơn hàng
Select * From Orders Order By Freight DESC 
-- 14. In cấc thông tin đơn hàng có trọng lượng > 500
Select * From Orders Where Freight >= 500 Order By Freight DESC 
-- 15. trọng lượng từ 100-500 
Select * From Orders Where Freight >= 100 AND Freight <= 500 Order By Freight DESC 
-- 16. 100-500 và ship bởi cty giao vận số 1 
Select * From Orders Where Freight >= 100 AND Freight <= 500 AND ShipVia = 1 Order By Freight DESC

--17. và không ship tới london
Select *From Orders Where Freight >= 100 AND Freight <= 500 AND ShipVia = 1 AND ShipCity <> 'London'
Select *From Orders Where Freight >= 100 AND Freight <= 500 AND ShipVia = 1 AND NOT(ShipCity = 'London')

--18. Liệt kê k/h đến từ Mĩ hoặc Mexico
select *From Customers Where Country = 'USA' OR Country = 'Mexico'
--19. liệt kê các nhân viên sinh ra trong đoạn 1960 và 1970
Select *From Employees Where Year(BirthDate) >= 1960 AND Year(BirthDate)<=1970  Order By BirthDate DESC 