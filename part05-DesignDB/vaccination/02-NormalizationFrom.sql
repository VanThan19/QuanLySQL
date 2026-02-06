-- THIẾT KẾ ĐẦU TIÊN : GOM TẤT CẢ TRONG 1 TABLE 
-- ĐẶC ĐIỂM CHÍNH LÀ CỘT, VALUE ĐẶC ĐIỂM CHÍNH LÀ CELL
-- THÔNG TIN CHÍCH NGỪA BAO GỒM : TÊN : AN NGUYỄN , CCCD : 123456789...
Create database DBDESIGN_VACCINATION
USE DBDESIGN_VACCINATION

CREATE TABLE VaccinationV1
(
ID char(11) primary key ,
LastName nvarchar(30) ,
FirstName nvarchar(10),
Phone varchar(11) not null UNIQUE , -- constraint - cấm cho trùng nhưng ko phải là PK
                                     -- key ứng viên, candidate key
InjectionInfo nvarchar(255)
)-- Cách thiết kế này lưu trữ các mũi chích của mình được không ? được 
Select * from VaccinationV1

Insert into VaccinationV1 values ('00000000001',N'Nguyễn',N'An','090X',N'AZ ngày 28.9.2021 ĐH FPT | AZ ngày 28.10.2021 BV')

-- Phân tích : 
-- Ưu : dễ lưu trữ , select , có ngay , đa trị tốt trong vụ này 
-- Nhược : thông kê éo được, ít nhất phải đi cắt chuỗi, căng !! BỊ CĂNG DO ĐA TRỊ

-- SOLUTIONE : CẦN QUAN TÂM THỐNG KÊ, TÍNH TOÁN SỐ LIỆU (? MŨI, AZ CÓ BAO NGƯỜI...)
-- TÁCH CỘT, TÁCH BẢNG 

CREATE TABLE VaccinationV2
(
ID char(11) primary key ,
LastName nvarchar(30) ,
FirstName nvarchar(10),
Phone varchar(11) not null UNIQUE , -- constraint - cấm cho trùng nhưng ko phải là PK
                                     -- key ứng viên, candidate key
Dose1 nvarchar(100),
Dose2 nvarchar(100)
)
-- Phân tích : 
-- * Ưu : gọn gàng, select gọn gàng 
-- * Nhược : NULL !! Người nào cũng tốn như nhau số cột , thêm mũi nhắc 3,4 hàng năm thì sao 
--            Chỉ vì vài người, mà ta phải chừa chỗ null 
--              Thống kê !!! cột composite chưa cho mình được thống kê 


-- MULTI-VALUED CELL : MỘT CELL CHỨA NHIỀU INFO ĐỘC LẬP BÌNH ĐẲNG VỀ NHIỀU NGỮ NGHĨA 
--     Ví dụ : Address : 1/1 LL, Q.1, TP.HCM ; 1/1 Man Thiện, TP.TĐ
--         gói compo , nhiều đồ trong 1 cell 

-- COMPOSITIVE VALUE CELL (phức hợp) : là 1 cell chỉ chứa 1 value duy nhất , mỗi value này gom nhiều miếng nhỏ hơn 
--                         nhiều miếng nhỏ hơn, mỗi miếng có 1 vai trò riêng gom chung lại thành 1 thứ khác 
--                         Adress : 1/1 Man Thiện, P.5, TPHCM 
--                         FullName : Hoàng Ngọc Trinh --> cả : Tên gọi đầy đủ 
--                                     first   last 

-- Vì số lần chích còn có thể gia tăng cho từng người , mũi 2, mũi nhắc, mũi thường niên 
-- Ai chích nhiều thì nhiều dòng, hay hơn hẳn 

CREATE TABLE PersonV3
(
ID char(11) primary key ,
LastName nvarchar(30) ,
FirstName nvarchar(10),
Phone varchar(11) not null UNIQUE  -- constraint - cấm cho trùng nhưng ko phải là PK
                                     -- key ứng viên, candidate key
)

-- Composite gộp N info vào trong 1 cell, dễ nhanh là ưu điểm, nhập 1 chuỗi dài là xong 
--       Nhược điểm : éo thống kê tốt, éo sort được
--                    fullname sort làm sao 
-- Composite sẽ tách cột, vì mình đã cố gom trước đó gom N thứ khác nhau để làm ra 1 thứ khác 
CREATE TABLE VaccinationV3
(
Dose nvarchar(100),
PersonID char(11) references PersonV3(ID)
)
-- Phân tích :
-- Ưu : Chích thêm nhát nào, thêm dòng nhát đó , chấp 10 mũi đủ chỗ lưu, ko ảnh hưởng người chưa chích 
-- Nhược : Thống kê éo được 
-- Composite tách tiếp thành cột cột cột cột , trả lại đúng nghĩa cho từng miếng info nhỏ 
select * from VaccinationV3
CREATE TABLE PersonV4
(
ID char(11) primary key ,
LastName nvarchar(30) ,
FirstName nvarchar(10),
Phone varchar(11) not null UNIQUE  -- constraint - cấm cho trùng nhưng ko phải là PK
                                     -- key ứng viên, candidate key
)


CREATE TABLE VaccinationV4
(
-- tách cột thôi 
Dose int , -- liều chích số 1
InjDate datetime, -- giờ chích 
Vaccine nvarchar(50) , -- tên vắc cin 
Lot nvarchar(20), -- số lô 
[Location] nvarchar(50), -- địa điểm chích 
PersonID char(11) references PersonV4(ID)
)

Insert into PersonV4 values ('00000000001', N'Nguyễn', N'An','090x')
Insert into PersonV4 values ('00000000002', N'Nguyễn', N'Bình','091x')
delete from VaccinationV4 where Dose = 2 
Insert into VaccinationV4 values(1,Getdate(),'AZ',NULL,NUll,'00000000001')
Insert into VaccinationV4 values(2,Getdate(),'AZ',NULL,NUll,'00000000001')

select * from PersonV4
select * from VaccinationV4

-- In ra xanh vàng cho mỗi người 
select * from PersonV4 p Left JOIN VaccinationV4 v on p.ID = v.PersonID

select p.ID,p.FirstName,count(v.Dose) [No dose] from PersonV4 p Left JOIN VaccinationV4 v on p.ID = v.PersonID group by p.ID,p.FirstName
-- count * là đếm dòng --> count đếm cột mới đúng 

-- Ăn tiền xanh đỏ 
select p.ID,p.FirstName,IIF (count(v.Dose) = 0 , 'NOOP',IIF(count(v.Dose)=1,'YELLOW','GREEN')) 
            AS STATUS 
-- NẾU COUNT = 0 THÌ GHI NOOP CÒN NGƯỢC LẠI COUNT = 1 THÌ GHI YELLOW NGƯỢC LẠI GREEN 
from PersonV4 p Left JOIN VaccinationV4 v on p.ID = v.PersonID group by p.ID,p.FirstName

-- TÊN VẮC XIN MÀ CHO NHẬP LÀ BÚ SỊT 

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- * PHÂN TÍCH : 
-- CỘT VACCINE CHO PHÉP GÕ CÁC GIÁ TRỊ TÊN VC 1 CÁCH TỰ DO -->INCONSISTENCY 
-- AZ , ASTRA, ASTRAZENECA 
-- >>> CÓ MÙI CỦA DROPDOWN, MÙI CỦA COMBO BOX >>> LOOKUP TABLE 
-- KO CHO GÕ MÀ CHO CHỌN TỪ DANH SÁCH CÓ SẴN 
-- THAM CHIẾU TỪ DANH SÁCH CÓ SẴN 
-- Vaccine phải tách thành table Cha, table 1 , đám con đám N 
-- phải references về 
Create table VaccineNamev5 
(
Vaccine varchar(30) primary key 
) -- PRIMARY KEY MÀ LÀ VARCHAR LÀM GIẢM HIỆU NĂNG VỀ THỰC THI QUERY 
-- CHẠY CHẬM, THƯỜNG NGƯỜI TA SẼ CHỌN PK LÀ CON SỐ LÀ TỐT NHẤT , TỐT NHÌ CHAR
Insert into VaccineNameV5 values  ('AstraZeneca')
Insert into VaccineNamev5 values ('Pfizer')
Insert into VaccineNamev5 values ('Verocell')
Insert into VaccineNamev5 values ('Moderna')

CREATE TABLE PersonV5
(
ID char(11) primary key ,
LastName nvarchar(30) ,
FirstName nvarchar(10),
Phone varchar(11) not null UNIQUE  -- constraint - cấm cho trùng nhưng ko phải là PK
                                     -- key ứng viên, candidate key
)


CREATE TABLE VaccinationV5
(
SEQ int IDENTITY primary key ,
Dose int , -- liều chích số 1, 2 có thể lặp lại cho mỗi người , k thể là key 
InjDate datetime, -- giờ chích 
Vaccine varchar(30) references VaccineNameV5(Vaccine) , -- tên vắc cin 
Lot nvarchar(20), -- số lô 
[Location] nvarchar(50), -- địa điểm chích là COMPOSITE , tách thành cột city, quận/huyện 
-- lại là lookup nếu muốn, để ko gõ lung tung, thống kê 
PersonID char(11) references PersonV5(ID)
)

Insert into PersonV5 values ('00000000001', N'Nguyễn', N'An','090x')
Insert into PersonV5 values ('00000000002', N'Nguyễn', N'Bình','091x')
delete from VaccinationV5 where Dose = 2 
Insert into VaccinationV5 values(1,Getdate(),'AstraZeneca',NULL,NUll,'00000000001')
Insert into VaccinationV5 values(2,Getdate(),'AstraZeneca',NULL,NUll,'00000000001')
Insert into VaccinationV5 values(1,Getdate(),'AstraZeneca',NULL,NUll,'00000000002')
-- CHỐT HẠ : TÁCH ĐA TRỊ, HAY COMPOSITE DỰA TRÊN NHU CẦU THỐNG KÊ NẾU CÓ CỦA DỮ LIỆU TA LƯU TRỮ 
--            GOM BẢNG -> TÌM ĐA TRỊ, TÌM COMPOSITE , TÌM LOOKUP TÁCH THEO NHU CẦU 

select * from PersonV5
select * from VaccinationV5

-- 1. Thống kê có bao nhiêu mũi vaccine AZ đã dc chích ( chích bao nhiêu nhát, ko care người)
-- output : loại vaccin, tổng số mũi đã chích
-- 2. Ngày x có bao nhiêu mũi đã dc chích
-- output : ngày, tổng số mũi đã chích 
-- 3. Thống kê số mũi chích của mỗi cá nhân 
-- ouput : cccd , tên ,sdt,số mũi đã chích 
-- 4. In ra thông tin của mỗi cá nhân 
-- ouput : màu 
-- 5. Có bao nhiêu công dân đã chích ít nhất 1 vaccine
-- 6. Những công dân nào chưa chích vắc xin mũi nào 
-- 7. Công dân có cccd X đã chích những mũi ào 
-- output : cccd, tên , thông tin chích 
-- 8. Thống kê số mũi vaccine đã chích của mỗi loại vaccine 
Select v.Vaccine,count(c.SEQ) from VaccineNamev5 v left  JOIN  VaccinationV5 c on v.Vaccine = c.Vaccine group by v.Vaccine
-- Where data chích là thống kê ngày 




--1. Trong cơ sở dữ liệu:
--Đa trị (Multivalued attribute):

--Một thuộc tính có thể chứa nhiều giá trị cùng một lúc cho một thực thể (entity) duy nhất. Ví dụ, một thực 
--thể "Nhân viên" có thể có thuộc tính "Số điện thoại", và nếu một nhân viên có nhiều số điện thoại, thì thuộc tính 
--này là đa trị.
--Thuộc tính đa trị không phải là thuộc tính hợp thành (composite), vì nó chỉ chứa các giá trị riêng lẻ thay vì các 
--nhóm giá trị.

-- Ví dụ:

--Nhân viên: {
--  Tên: "Lê Văn",
--    Số điện thoại: { "0987654321", "0123456789" }
--}
--Ở đây, "Số điện thoại" là thuộc tính đa trị vì nó chứa nhiều số.

--Hợp thành (Composite attribute):

--Là một thuộc tính có thể được chia thành các thành phần nhỏ hơn, mỗi thành phần có ý nghĩa riêng. Ví dụ, 
--thuộc tính "Địa chỉ" có thể bao gồm "Số nhà", "Đường", "Quận", "Thành phố", mỗi phần tử này là một thuộc tính 
--nhỏ hơn.
--Ví dụ:
/*
--Nhân viên: {
--    Tên: "Lê Văn",
    Địa chỉ: {
        Số nhà: "123",
        Đường: "Nguyễn Trãi",
        Quận: "1",
        Thành phố: "Hồ Chí Minh"
    }
}
Ở đây, "Địa chỉ" là thuộc tính hợp thành, vì nó chứa nhiều thuộc tính nhỏ hơn, liên quan đến địa chỉ.
*/