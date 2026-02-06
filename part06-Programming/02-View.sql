-- Khi có nhiều câu lệnh SQL Select phức tạp, hay ta cần viết lại nhiều lần 1 câu select nào đó ,ta đặt cho 
-- câu lệnh SQL Select này 1 cái tên sau này muốn xài lại câu SQL Select này chỉ gọi tên ra là được 

-- 1 câu lệnh Select ~~~ 1 table được trả về khi chạy 
-- 1 câu lệnh Select ---- đặt cho nó 1 cái tên ~~~ 1 table được trả về khi chạy 
-- Nếu ta muốn nhìn table này, chạy lại lệnh select này 
-- ta chỉ việc select 8 from cái tên đã đặt 

USE Northwind
Select * from Employees

-- Liệt kê các nhân viên ở London 
Select * from Employees where city = 'London'
-- coi câu này là 1 table , cho nó 1 cái tên, sau này muốn xem lại data, select cái tên 
GO

Create View VW_LondonEmployess AS Select * from Employees where city = 'London'

GO -- phân cách 

-- Xài view , coi mày là table, vì sau lưng mày là 1 câu select chống lưng
Select * From VW_LondonEmployess
-- nếu muốn xem view thì ấn phải chuột chọn Scrip View -> Create To -> New Query 
Select * From [Product Sales for 1997]

