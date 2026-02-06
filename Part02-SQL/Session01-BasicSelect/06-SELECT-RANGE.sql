USE Northwind 

------------------------------------------------------------------------------------
-- Lí thuyết 
-- Cú pháp mở rộng lệnh Select 
-- Khi cần lọc dữ liệu trong 1 đoạn cho trước , thay vì dùng >= ... AND <= ..., ta có thể thay thế
-- bằng mệnh đề BETWEEN , IN 
-- * CÚ PHÁP : CỘT BETWEEN VALUE-1 AND VALUE-2 
-- ==> between thay thế cho 2 mệnh đề >= <= AND 
-- * CÚ PHÁP : CỘT IN (MỘT TẬP HỢP CÁC GIÁ TRỊ ĐƯỢC LIỆT KÊ CÁCH NHAU DẤU PHẨY)
-- ==>>> IN sẽ thay thế cho 1 loạt OR 

----------------------------------------------------------------------------------------
-- 1. Liệt kê danh sách nhân viên sinh trong đoạn trong năm 1960-1970 
Select *From Employees Where Year(BirthDate) >= 1960 AND Year(BirthDate)<=1970  
                       Order By BirthDate DESC -- 4 
Select *From Employees Where Year(BirthDate) Between 1960 AND 1970  
                       Order By BirthDate DESC -- 4
					   
-- 2. Liệt kê các đơn hàng có trọng lượng từ 100...500
Select *From Orders Where Freight Between 100 And 500
--3. Liệt kê đơn hàng gửi tới Anh,Pháp,Mĩ
Select *From Orders Where ShipCountry ='USA' OR ShipCountry = 'UK' OR ShipCountry ='France' 
Select *From Orders Where ShipCountry IN ('USA', 'UK', 'France' ) 
-- 4. Đơn hàng nào k gửi đến Anh,Pháp, Mĩ
Select *From Orders Where NOT(ShipCountry IN('USA','UK','France'))
--5. Liệt kê các đơn hàng trong năm 1996 ngoại trừ các tháng 6789
Select *From Orders Where Year(OrderDate)= 1996 AND Month(OrderDate) NOT IN (6,7,8,9) 

-- Lưu ý in : Chỉ khi ta liệt kê được tập giá trị thì mới chơi in 
-- khoảng số thực thì k làm được 
