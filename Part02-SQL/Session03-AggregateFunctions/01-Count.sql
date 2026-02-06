USE Northwind
-------------------------------------------------------------------------------------------------
-- LÝ THUYẾT
-- DB ENGINE hỗ trợ 1 loạt nhóm hàm dùng thao tác trên nhóm dòng/cột , gom data tính toán 
-- trên đám data gom này - nhóm hàm gom nhóm - AGGREGATE Functions, AGGEGATION
-- COUNT() SUM() MIN() MAX() AVG()
-- * CÚ PHÁP CHUẨN 
-- SELECT CỘT...., HÀM GOM NHÓM(),.... FROM <TABLE>

--- * CÚ PHÁP MỞ RỘNG 
-- SELECT CỘT...., HÀM GOM NHÓM(),.... FROM <TABLE>...WHERE ....GROUP BY(GOM THEO CỤM CỘT NÀO)
-- SELECT CỘT...., HÀM GOM NHÓM(),.... FROM <TABLE>...WHERE...GROUP BY(GOM THEO CỤM CỘT NÀO) HAVING....

-- * HÀM COUNT() : Dùng để đếm số lần xuất hiện một cái gì đó 
--    Count(*) : đếm số dòng trong table , đếm tất cả các dòng ko care tiêu chuẩn nào khác 
--    Count(*) From ... where ... : chọn ra những dòng thỏa tiêu chí where nào đó trước đã, rồi mới đếm 
--                                  filter rồi đếm 

-- Count ( cột nào đó) :  

-------------------------------------------------------------------------------------------------
--1. In ra danh sách các nhân viên 
Select *From Employees
--2. Đếm xem có bao nhiêu nhân viên 
Select Count (*) as [số lần xuất hiện] From Employees
--3. Có bao nhân viên ở london 
Select Count(*) From Employees where City = 'London'
--4. Có bao nhiêu lượt thành phố xuất hiện- cứ xuất hiện tên thành phố là đếm, ko care lặp lại hay sao
Select *From Employees
Select Count(city) From Employees 
--5. đếm xem có bao nhiêu region
select count(region) from Employees
-- phát hiện hàm count(cột), nếu cell của cột chưa null, ko tính, ko đếm 
--5.1. đếm xem có bao nhiêu khu vực null, có bao nhiêu dòng region là null
select count(*) from Employees where region is null -- đếm sự xuất hiện của dòng chứa region null 
-- count (region) là trả về 0 vì null ko đếm được 0 value 

-- 6. có bao nhiêu thành phố trong table nv
select *from Employees
select city from Employees
select distinct city from Employees
-- coi kết quả này là 1 table , mất công sức lọc ra 5 thành phố 
-- sub query mới , coi 1 câu select là 1 table, biến table này vào trong mệnh đề from 
Select count(*) From (select distinct city from Employees) as cities--5  -- tên giả quy tắc table có 1 định danh 
-- biểu thức đc xem là 1 table 

select count(*) from Employees --9
select count(city) from Employees -- 9

select count(distinct city) from Employees--5

--7. đếm xem mỗi thành phố có bao nhiêu nhân viên 
-- khi câu hỏi có tính toán gom data (hàm aggegate) mà lại chưa từ khóa mỗi .... 
-- gặp từ mỗi , chính là chia để đếm, chia để trị , chia cụm để gom đếm 
select * from Employees 

-- seatle có 2 | tacoma 1 | kirland 1| redmon 1| london 4|
-- sự xuất hiện của nhóm
-- đếm theo sự xuất hiện của nhóm , count++ trong nhóm thoy, sau đó reset ở nhóm mới 
Select count (city) from Employees group by city -- đếm value của city , nhưng đếm theo nhóm 
      -- chia city thành nhóm , rồi đếm trong nhóm 
Select city, count (city) as [NO em] from Employees group by city-- câu chuẩn 
-- theo chiều dọc
-- lưu ý : gom city mà in mã nhân viên thì k gom được . Nếu bên mệnh đề select có cái gì xuất hiện ngoài hàm count 
--         tức là hàm gom nhóm có bất cứ cột gì xuất hiện thì cột đó phải được gom nhóm luôn 

-- Câu lỗi 
Select EmployeeID, city, count (city) as [NO em] from Employees group by city
-- Câu đúng :
Select EmployeeID, city, count (city) as [NO em] from Employees group by city , EmployeeID
-- câu này chạy được nhưng mà vô nghĩa, còn đây cố tình in ra mã nhân viên khác nhau thì city phải khác nhau 
-- thì phải đếm theo kiểu khác nhau . Mặc dù chạy được vô nghĩa vì bạn đưa mã nhân viên vào mà mã nhân viên là duy 
-- nhất thì đếm cái đéo gì bây giờ 

-- CHỐT HẠ : KHI XÀI HÀM GOM NHÓM BẠN CÓ QUYỀN LIỆT KÊ TÊN CỘT LẺ Ở SELECT 
--           NHƯNG CỘT LẺ ĐÓ BẮT BUỘC PHẢI XUẤT HIỆN TRONG MỆNH ĐỀ GROUP BY
--           ĐỂ ĐẢM BẢO LOGIC : CỘT HIỂN THỊ VÀ SỐ LƯỢNG ĐI KÈM, ĐẾM GOM THEO CỘT HIỂN THỊ THÌ MỚI LOGIC 
-- Mày muốn in thành phố thì đếm số thành phố , mày muốn gom theo tuổi thì mày đếm số đứa cùng tuổi 
-- Cứ theo cột mà gom , cứ theo cột city mà gom, cột city nằm ở select là hợp lý 
-- muốn hiện thị số lượng ai đó, cái gì đó , gom nhóm theo cái gì đó 
-- nếu bạn gom theo key,id thì vô nghĩa nha, vì key ko trùng, mỗi thằng 1 nhóm, đếm cái gì bây giờ 

-- Mã số SV --- đếm cái gì ?? vô nghĩa 
-- mã chuyên ngành -- đếm số sinh viên chuyên ngành 
-- mã quốc gia -- đếm số đơn hàng 
-- điểm thi -- đếm số lượng đạt được điểm đó 

-- Có cột để gom nhóm, cột đó sẽ dùng để hiện thị kết quả 

Select city, count (city) as [NO em] from Employees group by city 
-- 9. Hãy cho tui biết thành phố nào có từ 2 nhân viên trở lên 
-- 2 chặng 
-- 9.1 . các thành phố có bao nhiêu nhân viên 
Select city, count (city) as [NO em] from Employees group by city
Select city, count (*) as [NO em] from Employees group by city
-- 9.2 đếm xong mỗi thành phố , ta bắt đầu lọc lại kết quả sau đếm 
-- Filter sau đếm / where sau đếm / where sau khi đã gom nhóm, aggregate thì gọi là having
Select city, count (city) as [NO em] from Employees group by city Having Count(*) >=2 
-- 10. Đếm số nhân viên của 2 thành phố Seatle và London 
Select city,Count(*) From Employees where City IN ('London', 'Seattle')-- 6 đứa , sai riiuf , yêu cầu mỗi mà 
Select city,Count(*) From Employees where City IN ('London', 'Seattle') Group by city 
-- 11. trong 2 tp, london và seattle có nhiều hơn 3 sv 
Select city,Count(*) From Employees where city IN ('London', 'Seattle') Group by city having count(*) >=3 
-- 12. Đếm xem có bao nhiêu đơn hàng bán ra 
Select * From Orders 
Select Count (*) as [Số đơn hàng bán ra] From Orders 
Select Count (OrderID) as [Số đơn hàng bán ra] From Orders 
-- 830 mã đơn khác nhau, đếm mã đơn, hay đếm cả cái đơn là như nhau
-- nếu cột có value NULL ăn hành 
-- 12.1 Nước Mĩ có bao nhiêu đơn hàng 
-- đi tìm nước mĩ mà đếm, lọc mĩ rồi tính tiếp , where mĩ 
-- ko phải là câu gom chia nhóm, không có mỗi quốc gia bao nhiêu đơn hàng 
-- mỗi quốc gia có bao nhiêu đơn, count theo quốc giá, group by theo quốc gia 
Select Count (ShipCountry) as [Số đơn hàng bán ra] From Orders Where ShipCountry = 'USA'
-- 12.2 Mĩ Anh Pháp chiếm tổng cộng bao nhiêu đơn hàng 
Select Count (*) as [Số đơn hàng bán ra] From Orders Where ShipCountry IN ('USA', 'UK','france')

-- 12.3 Mĩ Anh Pháp , mỗi quốc gia có bao nhiêu đơn hàng 
Select ShipCountry,Count (*) as [Số đơn hàng bán ra] From Orders Where ShipCountry IN ('USA', 'UK','france') Group BY ShipCountry

 -- 12.4 trong 3 quốc gia APM quốc gia nào có từ 100 đơn hàng trở lên 
 Select ShipCountry,Count (*) as [Số đơn hàng bán ra] From Orders Where ShipCountry IN ('USA', 'UK','france')
                                Group BY ShipCountry Having count(*) >= 100

-- 13. đếm xem có bao nhiêu mặt hàng có trong kho
Select Count (*) as [Số đơn hàng bán ra] From Orders 

-- 14, đếm xem có bao nhiêu lượt quốc gia đã mua hàng 
select count(distinct shipCountry) from orders 
-- 15. đếm xem có bao nhiêu quốc gia đã mua hàng , mỗi quốc gia đếm 1 lần
select shipCountry, count(*) from orders group by ShipCountry 
-- 16. đếm số lượng đơn hàng 
select count(*) from orders 
-- 17. quốc gia nào có từ 10 đơn hàng trở lên 
select shipCountry,count(*) from orders group by shipCountry having count(*) >= 10
-- 18. đếm xem mỗi chủng loại có bao nhiêu mặt hàng ( bia rượu có 5 sp, thủy sản 10sp)
select CategoryID , count(*) from Products Group by CategoryID
-- 19. đếm quốc gia nào có nhiều đơn hàng nhất 
Select shipCountry,count(*) from Orders group by ShipCountry order by count(*) DESC
Select shipCountry,count(*) from Orders group by ShipCountry Having count(*) >= all (Select count(*) from orders group by ShipCountry)
-- 20. Thành phố nào có nhiều nhân viên nhất .
Select city,count(*) from Employees group by city having count(*) >= all (
                               select count(*) from Employees group by city )
--21. Trong 3 quốc gia APM , quốc gia nào có nhiều đơn hàng nhất
Select shipcountry,count(*) from Orders where ShipCountry IN ('USA','UK','France') group by ShipCountry having count(*) >= all (
                   select count(*) from orders group by ShipCountry)
-- CHỐT HẠ :
-- Trong mệnh đề where so sánh cột với value gì . Toán tử so sánh > < .... đặc biệt có thêm toán tử IN 
--= và In có câu chuyện : Khi dấu bằng có thể thay value bên mệnh đề where bằng mệnh đề select khác trả về 1 giá trị 
--                        Khi In tập giá trị miễn tập giá trị trả về Select khác
--Độ mệnh where trên 3 cơ sở : Single value ( Sub là câu phụ câu con )
--                            IN : where theo kiểu Multi value . Không hỏi trực diện value mà nó hỏi value đó thông qua
--value khác . Đó là câu gián tiếp . về câu hỏi gián tiếp là hỏi trên 1 tập giá trị thì IN. Sub trên 1 tập giá trị, trả về 1 cột
--                            ALL: phải trả về 1 câu sub. câu sub vẫn phải 1 cột chính là 1 tập hợp . So sánh với tất cả với thằng bên trong nhiều value
--
--Lệnh Select là lấy xem data thao tác tính toán trên data từ table ( nhiều tbale là phép Join)

--Sesion03 : gom data , select là hiển thị ra 
