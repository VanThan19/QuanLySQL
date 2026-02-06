CREATE DATABASE DBDESIGN_VNLOCATIONS
USE DBDESIGN_VNLOCATIONS

-- Thiết kế csdl lưu dc thông tin phường/ xã, quận/huyện, tỉnh/tp 
-- chính là 1 phần của địa chỉ được tách ra cho nhu cầu thống kê 
-- nó là 1 phần của Composite field 
--  |SQE|DOSE|INJDATE|Vaccine(fk lk)|Lot|Địa chỉ chích - compo|
-- |SQE|DOSE|INJDATE|Vaccine(fk lk)|Lot|số nhà|phường-quận-tỉnh|

-- xét riêng phường- quận - tỉnh rõ ràng 3 cột lookup
Create table locations 
(
province nvarchar(30),
district nvarchar(30),
ward nvarchar(30)
)
select * from locations

-- Phân tích table 
-- 1. Trùng lặp cụm info tỉnh quận 

-- 2. Lookup trên province, district (ward)

-- 3. Sự phụ thuộc logic giữa tỉnh và district (ward)
-- functional dependency - fd - phụ thuộc hàm 
-- có 1 cái ánh xạ, mối quan hệ giữa a và b, province với district 
-- cứ chọn tphcm sẽ ra q1,q2,q3 
--          ĐN         BH,LBT,LK 
-- từ cái này suy ra dc cái kia gọi là phụ thuộc hàm 
-- Y = F(x) = x^2 , cứ chọn f(2) -> 4 

-- Tách lookup vì dễ nhất 
-- Ra 1 table, phần table còn lại thì fk sang lookup 

-- Vaccine ( liều, tên-vaccine)
--                   FK         sang Vaccine(tên-Vaccine) 
-- Ko gõ lung tung nha mày, tao đã thống nhất tên vaccine

CREATE TABLE Province 
(
Pname nvarchar(30)
)
-- chỉ lookup 63 tỉnh, ko cho chọn lộn xộn 
Select * from Province
Select * from locations -- 10581 dòng ứng với 10581 xã/phương khác nhau
                        -- nhưng chỉ có 63 tỉnh thành lặp lại 

Select distinct Province from locations -- giống cục thống kê 

-- dùng nó để insert sang table lookup 
Insert into Province values (N'Thành phố Đà Nẵng')
Insert into Province values (N'Tỉnh Cà Mau')

Delete Province
select * from Province

-- cách insert thứ 2 
Insert into Province values (N'Tỉnh Cà Mau'),(N'Thành phố Đà Nẵng')

-- Tuyệt chiêu insert thứ 3 
-- copy and paste đã học cho 10k dòng 

-- tuyệt chiêu insert thứ 4 
--Insert into Province values có 63 tỉnh thành là ngon-ta xài kiểu sub-query trong lệnh insert 

Insert into Province  select distinct Province from locations

select * from Province
Select count(*) from locations -- 10k 
Select count(province) from locations -- 10k
Select count(distinct Province) from locations -- 63 

-- Tạo table lookup quận/huyện 
Create table District 
(
Dname nvarchar(30)
)
-- có bao nhiêu quận ở việt nam 
Select District From locations
Select Distinct  District From locations -- 683 dòng , 683 quận khác nhau 
Select count(Distinct  District) From locations
-- Rất cẩn thận khi chơi quận/huyện
-- tiền giang, vịnh long, trà vinh, đều có huyện " châu thành "
-- bảng distinict chỉ có 1 châu thành, lát hồi 
-- PK của distinct ko thể là tên quận/huyện dc 
-- 
-- lookup là giải quyết nhập value ko giải quyết 2 thằng phụ thuộc/ liên quan lẫn nhau 
-- gọi là phụ thuộc hàm FD 

-- Chèn vào table quận 
Insert into District Select Distinct  District From locations

Select * from District

-- PROVINCE và District có sưh phụ thuộc lẫn nhau, từ thằng này suy được ra thằng kia 
-- Nhìn quận có thể đoán thành phố (chiều này ko chắc an toàn)
-- Nhìn thành phố đoán ra quận ( chiều này hợp lý hơn về suy luận )
-- FD nên đọc là City -> District 

--Table chứa các FD kiểu phụ thuộc ngang giữa các cột->suy nghĩ tách bảng tách thằng vế trái, ra table khác
-- tách xong thì phải FK cho phần còn lại 

-- sau khi tách ta có trong 3 table 
-- province (Pname)
-- district (Dname,Pname(FK))
-- ward (Wname phường nào, quận nào Dname(FK))
-- em lookup lên quận, quận lok lên tỉnh 

-- Giải pháp  "Dở" cho huyện châu thành của 3 tỉnh miền tây !! ta sẽ làm sau 
-- dùng Natural Key, Key tự nhiên -- Dùng tên của tỉnh, huyện làm key 

-- Dùng key tự gán, tự tăng, key thay thế, key giả (Surrogate key/Artifical key )

-- PHIÊN BẢN ĐẸP NHƯNG CÒN CHÚT CHÂU THÀNH !!!
--DROP TABLE Province
DROP TABLE District

Create table Province 
(
Pname nvarchar(30) Primary key 
)

Insert into Province Select Distinct Province From locations

Create table District 
(
Dname nvarchar(30) primary key , -- Hok có 2 châu thành của 3 tỉnh miền tây
-- Quận nào vậy
-- và thuộc về tỉnh/Tp nào vậy
Pname nvarchar(30)   references Province(Pname) -- Tham chiếu để ko nhập tỉnh k tồn tại, tỉnh ahihi
)
INSERT INTO District SELECT DISTINCT District, Province FROM locations order by district;
--Dname là khóa chính, nghĩa là mỗi quận/huyện phải có một tên duy nhất trên toàn quốc.
--Hạn chế: Nếu có các quận/huyện trùng tên nhưng thuộc các tỉnh khác nhau (ví dụ "Quận 1" ở cả TP.HCM và 
--TP.Hà Nội), thì không thể nhập dữ liệu này vào vì vi phạm tính duy nhất của Dname.


Create table District 
(
Dname nvarchar(30) not null , -- Hok có 2 châu thành của 3 tỉnh miền tây
-- Quận nào vậy
-- và thuộc về tỉnh/Tp nào vậy
Pname nvarchar(30) not null  references Province(Pname),
-- Tham chiếu để ko nhập tỉnh k tồn tại, tỉnh ahihi
Primary key (Dname,Pname) -- key đôi , mày ở quận an lão,tỉnh hải phòng thì 2 thằng mày làm key đi nhá 
)
INSERT INTO District  SELECT DISTINCT District, Province FROM locations;

Select * from District

Select * from District Where PName = N'Tỉnh Nghệ An'
-- "An Lão, Hải Phòng" và "An Lão, Bình Định" là hai quận/huyện khác nhau. Nếu chỉ dùng Dname, chúng ta 
--không thể phân biệt giữa hai bản ghi này. Nhưng với khóa chính đôi, chúng ta có thể đảm bảo rằng mỗi 
--quận/huyện thuộc về một tỉnh cụ thể.
--Nếu không dùng khóa đôi, mà chỉ dùng một trong hai (Dname hoặc Pname) làm khóa chính, thì:
--Dùng Dname sẽ dẫn đến xung đột khi hai tỉnh có cùng tên quận/huyện.
--Dùng Pname thì không hợp lý vì sẽ có nhiều quận/huyện thuộc cùng một tỉnh.

-- THÀNH PHẦN ĐÔNG DATA NHẤT LÀ WARD/PHƯỜNG , CÓ 10581 DÒNG ỨNG VỚI VÔ SỐ LẶP LẠI CÁC QUẬN,FK
-- xã có trùng tên k
CREATE TABLE WARD 
(
Wname nvarchar(30), 
-- xã phường ơi bạn ở quận nào 
Dname nvarchar(30) --references District(Dname)
)

Select * from locations -- 10581 xã phường ,liệu có trùng ??
Select count(distinct ward) from locations -- 7884, trùng tên 3000
Select ward From locations order by ward 

Insert into Ward Select Ward,district from locations -- 10581 

Select * from ward 

-- Cho tui xem các phường của q1 tphcm 
Select * from ward where Dname = N'Huyện Nghi Lộc'

-- Huyện Châu Thành của Tiền Giang có những xã nào 
Select w.Wname,d.Dname,d.Pname from ward w inner join District d on w.Dname = d.Dname 
Where d.Dname = N'Huyện Châu Thành' AND d.Pname = N'Tỉnh Tiền Giang' -- vì trùng tên 

Select w.Wname,d.Dname,d.Pname from ward w inner join District d on w.Dname = d.Dname 
Where d.Dname = N'Huyện Ba Tri' AND d.Pname = N'Tỉnh Bến Tre' -- đúng 

Drop table Province
Drop table District
Drop table WARD
Select * from ward
CREATE TABLE Province (
    ProvinceID INT PRIMARY KEY,  -- Mã tỉnh/thành phố duy nhất
    Pname NVARCHAR(30) NOT NULL,  -- Tên tỉnh/thành phố
    ProvinceCapital NVARCHAR(30)  -- Thủ phủ của tỉnh/thành phố
);
Insert into Province Select Distinct Province From locations
CREATE TABLE District (
    DistrictID INT PRIMARY KEY,  -- Mã quận/huyện duy nhất
    Dname NVARCHAR(30) NOT NULL,  -- Tên quận/huyện
    ProvinceID INT NOT NULL,  -- Tham chiếu đến mã tỉnh/thành phố
    FOREIGN KEY (ProvinceID) REFERENCES Province(ProvinceID)
);

CREATE TABLE Ward (
    WardID INT PRIMARY KEY,  -- Mã phường/xã duy nhất
    Wname NVARCHAR(30) NOT NULL,  -- Tên phường/xã
    DistrictID INT NOT NULL,  -- Tham chiếu đến mã quận/huyện
    FOREIGN KEY (DistrictID) REFERENCES District(DistrictID)
);