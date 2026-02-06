Select *From Vndict,Endict -- tích đề các ko quan tâm việc có filter hay ko 
Select *From Vndict cross join Endict -- tích đề các 
Select *From Vndict vn ,Endict en where vn.Numbr = en.Numbr
-- CHUẨN THẾ GIỚI 
Select *From Vndict  INNER JOIN Endict  ON VnDict.Numbr = Endict.Numbr 
-- Nhìn sâu table rồi ghép , ko ghép bừa bãi , ghép có tương quan bên trong, theo điểm chung 
-- ko dc dùng where 
Select *From Vndict  JOIN Endict  ON VnDict.Numbr = Endict.Numbr 
-- CÓ THỂ DÙNG THÊM WHERE DC HAY KO??? KHI XÀI INNER , JOIN 
-- JOIN CHỈ LÀ THÊM DATA ĐỂ TÍNH TOÁN , GỘP DATA LẠI NHIỀU HƠN, SAU ĐÓ ÁP DỤNG TBO KIẾN THỨC SELECT ĐÃ HỌC 

-- THÍ NGHIỆM THÊM CHO INNER JOIN , GHÉP NGANG CÓ XEM XÉT MÔN ĐĂNG HỘ ĐỐI HAY K?
SELECT *FROM Endict
select *from Vndict

select *from Endict en, Vndict vn where en.Numbr = vn.Numbr

select *from Endict en, Vndict vn where en.Numbr > vn.Numbr -- ghép có chọn lọc nhưng k xài dấu bằng mà dùng 
-- dấu > < >= <= != . Người ta gọi là NON-EQUI JOIN 
-- vẫn ko là ghép bừa bãi 
select *from Endict en, Vndict vn where en.Numbr != vn.Numbr
select *from Endict en JOIN Vndict vn on en.Numbr != vn.Numbr