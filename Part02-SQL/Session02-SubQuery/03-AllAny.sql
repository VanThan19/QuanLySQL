USE Northwind 

------------------------------------------------------------------------------------
-- Lí thuyết 
-- Cú pháp chuẩn của câu lệnh Select 
-- Select *From <Table> Where ....
-- WHERE CỘT TOÁN - TỬ - SO - SÁNH VỚI - VALUE - CẦN - LỌC 
--       CỘT > >= < <= = != VALUE 
--                          DÙNG CÂU SUB-QUERY TÙY NGỮ CẢNH
--       CỘT              = (SUB CHỈ CÓ 1 VALUE)
--       CỘT              IN (SUB CHỈ CÓ 1 CỘT NHƯNG NHIỀU VALUE)
--       CỘT              > >= < <= ALL (1 CÂU SUB 1 CỘT NHIỀU VALUE)
--                                  ANY (1 CÂU SUB 1 CỘT NHIỀU VALUE)
------------------------------------------------------------------------------------
-- THỰC HÀNH 
-- tạo 1 table có 1 cột tên là Numbr , chỉ chứa 1 đống dòng các số nguyên
CREATE TABLE Num
(
   Numbr int 
)
Select *From Num
Insert Into Num values(1) 
Insert Into Num values(1) 
Insert Into Num values(2) 
Insert Into Num values(9) 
Insert Into Num values(17) 
Insert Into Num values(100) 
-- 1. In ra những số > 5
Select *From Num Where Numbr > 5
-- 2. In ra số lớn nhất trong các số đã nhập 
-- số lớn nhất trong đám được định nghĩa là : mày lớn hơn hết cả đám đó 
-- lớn hơn tất cả ngoại trừ chính mình --> mình là Max của đám
Select * From Num where Numbr >= All(Select *From Num)
-- 3. Nhân viên nào lớn tuổi nhất 
Select *From Employees Where BirthDate <= ALL(Select Birthdate From Employees)
--4. Đơn hàng nào có trọng lượng nặng nhất 
Select *From Orders Where Freight >= All(Select Freight From Orders)
