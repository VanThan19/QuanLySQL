Create database DBESIGN_ONEMANY 
USE DBESIGN_ONEMANY

-- Table 1 tạo trước , table N tạo sau 
Create table MajorV1 
(
  MajorID char(2) primary key , -- mặc định dbe tự tạo tên ràng buộc 
  MajorName nvarchar(40) not null ,
  -- ....
)
-- chèn data - mua quần áo bỏ tủ 
Insert into MajorV1 values ('SE' ,N'Kĩ Thuật Phần Mềm')
Insert into MajorV1 values ('AI' ,N'An Toàn Thông Tin')

create table StudentV1
(
studentID char(8) not null,
LastName nvarchar(30) not null , 
FirstName nvarchar(15) not null ,
DOB datetime ,
diaChi nvarchar(30),
MID char(2) -- tên cột khóa ngoại/tham chiếu ko cần trùng bên 1-key 
            -- nhưng bắt buộc trùng 100% kiểu dữ liệu, cần tham chiếu data thôi 
--primary key(studentID) -- tự dbe đặt tên cho ràng buộc 
Constraint PK_STUDENTV1 primary key (StudentID)
)
-- chèn data sinh viên 
select *from StudentV1
insert into studentV1 values ('SE1','Nguyễn','An',NULL,NULL,'SE')
-- Thiết kế ở trên là bị sai  vì k có tham chiếu giữa majorID của Student với major phía trên 
-- 

----------------------------------------------------------------------------------------------------------
Create table MajorV2 
(
  MajorID char(2) primary key , -- mặc định dbe tự tạo tên ràng buộc 
  MajorName nvarchar(40) not null ,
  -- ....
)

create table StudentV2
(
studentID char(8) primary key,
LastName nvarchar(30) not null , 
FirstName nvarchar(15) not null ,
DOB datetime ,
diaChi nvarchar(30),
--MID char(2) REFERENCES MajorV2(MajorID) -- tớ chọn chuyên ngành ở trên kia kìa , xin tham chiếu trên kia 
MajorID char(2) foreign key references MajorV2(MajorID)
)
Insert into MajorV2 values ('SE' ,N'Kĩ Thuật Phần Mềm')
Insert into MajorV2 values ('AI' ,N'An Toàn Thông Tin')
select *from MajorV2
select *from StudentV2
insert into studentV2 values ('SE2','Nguyễn','An',NULL,NULL,'SE')
insert into studentV2 values ('SE2','Nguyễn','An',NULL,NULL,'OE')

-- KHÔNG ĐƯỢC XÓA TABLE 1 NẾU NÓ ĐANG ĐƯỢC THAM CHIẾU BỞI THẰNG KHÁC
-- NẾU CÓ 1 QUAN HỆ 1-N, XÓA N TRƯỚC RỒI XÓA 1 SAU 

-- Bài cũ 
-- Dạ thưa thầy liên quan đến cái việc thiết kế table nó có tình huống là dữ liệu k gom cho 1 table mà nó tách thành 
-- nhiều table khác nhau. Khi mà người ta tách nhiều table thì khả năng nó bị phân mảnh data nên tái nhập dữ liệu. 
-- tái nhập bằng cách mình nhập dữ liệu lại bản gốc ( 1 table thì có kĩ thuật join) . Nhưng mà liên quan đến nhập dữ liệu
-- lại , liên quan đến việc tách bảng thầy biết 1 điều là dữ liệu nó phân thành 2 bảng khác nhau ,như vậy khi ghép ta phải
-- có tiêu chí ghép , chuyện join em học rồi nhưng bàn về nhập dữ liệu đó thì nếu mà 2 bảng thầy thiết kế độc lập mà tách
-- ra thầy k có nói năng gì thêm thì về nguyên tắc dữ liệu bên này và bên kia nó đã có 1 cái chút xíu ràng buộc và nó
-- cứ nhập thoải mái về nguyên tắc mình vẫn join được nhưng mà nó gây nên một hệ quả là nó sẽ bị vênh vào nhau dc gọi nó
-- ko nhất quán trong việc nhập dữ liệu . Lấy ví dụ : Nếu thầy thiết kế 1 table tên là sinh viên , 1 table tên là chuyên
-- ngành , create table với primary key tương ứng , em xin khẳng định 1 ngày nào đó người nào đó ahihi dc đưa vào
-- cũng chẳng ai phản đối em vì cấy cách create table 2 câu lệnh hoàn toàn độc lập nhau nên nó sẽ gây ra 1 hệ quả 
-- thoải mái nhập theo cách của nó .
-- Như vậy khi mình tách bảng ,thì dữ liệu phải đảm bảo 1 tính nhất quán nào đó , tính hợp lý nào đó thì thầy chỉ cho bọn
-- em gài mối quan hệ , gài cái ràng buộc thì ko có ngành bú sịt hay chuyên ngành ahihi nào cả . Thầy phải dùng cái từ 
-- khóa References và Foreign Key , 2 từ khóa này dùng có thể cùng 1 lúc cũng dc , để nó gài dữ liệu của tao tuy tách 
-- biệt với mình nhưng tao vẫn cần có mày xác thực đấy , có tính hợp lý  từ phía mày . Khi em gàn References trên cái cột
-- này sang cột table bên kia điều đó có nghĩa là em ko nhập lung tung cột bên này được em phải nương theo cột bên kia 
-- Đấy người ta là gọi là ràng buộc tham chiếu . Nhìn từ primary key nó tìm ra duy nhất 1 dòng dữ liệu 
-- Key chính đi xuất ngoại em gọi là Foreigin key 
--  RELATIONSHIP / MỐI QUAN HỆ , relationship chính là cấy tham chiếu nó xuất hiện khi đảm bảo tính nhất quán của việc
-- nhập xuất dữ liệu 
-- Trong 1 table của tao cấm cho trùng primary key nhưng t đóng vai trò tao móc sang chỗ khác để tao kết nối với người ta
-- để tao mở rộng thông tin .

-- Xóa key chính trước ngoại là không đúng vì bên khóa ngoại có ai đó đang móc vào/tham chiếu vào .

-- FK ... : tên ràng buộc của khóa ngoại 
-----------------------------------------------------------------------------------------------
-- THÊM KĨ THUẬT VIẾT FK, Y CHANG CÁCH VIẾT CỦA PK 
Create table MajorV3
(
  MajorID char(2) primary key , -- mặc định dbe tự tạo tên ràng buộc 
  MajorName nvarchar(40) not null ,
  -- ....
)
DROP TABLE STUDENTV3 

/*
create table StudentV3
(
studentID char(8) primary key,
LastName nvarchar(30) not null , 
FirstName nvarchar(15) not null ,
DOB datetime ,
diaChi nvarchar(30) null,
MajorID char(2) default 'se', -- đéo học hành gì cả thì tự nhiên se 
Constraint FK_STUDENTV3_MajorV3  foreign key(MajorID) references MajorV3(MajorID)
)
*/
create table StudentV3
(
studentID char(8) primary key,
LastName nvarchar(30) not null , 
FirstName nvarchar(15) not null ,
DOB datetime ,
diaChi nvarchar(30) null,
MajorID char(2) default 'se', -- đéo học hành gì cả thì tự nhiên se 
-- cho sv ko chọn chuyên , hắn học gì ?? học se đấy
Constraint FK_STUDENTV3_MajorV3  foreign key(MajorID) references MajorV3(MajorID) 
             on delete set default 
			 on update cascade 
)
-- ALTER TABLE STUDENTV3 ADD CONSTRAINT...Ở TRÊN 
-- Ta có quyền gỡ 1 ràng buộc đã thiết lập
Alter table studentV3 drop constraint FK_StudentV3_MajorV3

-- Bổ sung lại 1 ràng buộc khác 
Alter table studentV3 add constraint FK_StudentV3_MajorV3 foreign key (MajorID) References MajorV3(MajorID)

Insert into MajorV3 values ('SE' ,N'Kĩ Thuật Phần Mềm')
Insert into MajorV3 values ('AI' ,N'An Toàn Thông Tin')
select *from MajorV3
select *from StudentV3
insert into studentV3 values ('SE2',N'Nguyễn','An',NULL,NULL,'SE')
insert into studentV3 values ('AI3',N'Nguyễn','Un',NULL,NULL,'AI')
insert into studentV3 (studentid,lastname,firstname) values ('AI5',N'Nguyễn','IN')

-- Thao tác mạnh tay trên data/ món đồ quần áo trong tủ - DML ( UPDATE & DELETE)
Delete from StudentV3 -- cực kì nguy hiểm khi thiếu where, xóa hết data 

delete from studentV3 where StudentID ='AI3'

delete from MajorV3 where MajorID ='AI'

select *from MajorV3
select *from StudentV3

-- GÀI THÊM HÀNH XỬ KHI XÓA, SỬA DATA Ở RÀNG BUỘC KHÓA NGOẠI/DÍNH KHÓA CHÍNH LUÔN 
-- HIỆU ỨNG DOMINO, SỤP ĐỔ DÂY CHUYỀN , 1 XÓA , N ĐI SẠCH >>> CASCADE DELETE 
--                                      1 SỬA, N BỊ SỬA THEO >>> CASCADE UPDATE
-- NGAY LÚC DESIGN TABLE/CREATE TABLE ĐÃ PHẢI TÍNH VỤ NÀY RỒI 
-- VẪN CÓ THỂ SỬA SAU NÀY KHI CÓ DATA , CÓ THỂ TROUBLE 
-- CỤM LỆNH : CREATE/ALTER/DROP 

Alter table studentV3 drop constraint FK_StudentV3_MajorV3 -- XÓA RÀNG BUỘC KHÓA NGOẠI BI THIẾU VIỆC GÀI THÊM RULE 
                                                           -- NHỎ LIÊN QUAN ĐẾN SỬA XÓA DATA 
Alter table studentV3 add constraint FK_StudentV3_MajorV3 foreign key (MajorID) References MajorV3(MajorID) 
ON DELETE CASCADE ON UPDATE CASCADE 
-- UPDATE DML, MẠNH MẼ, SỬA DATA 
UPDATE MAJORV3 SET MAJORID = 'AK' WHERE MAJORID = 'AI'-- CẨN THẬN NẾU KO CÓ WHERE , TOÀN BỘ TABLE BỊ ẢNH HƯỞNG 

-- SỤP ĐỔ, XÓA 1, N ĐI SẠCH SẼ 
-- XÓA CHUYÊN NGÀNH AN TOÀN THÔNG TIN CÒN SINH NÀO KHÔNG??
DELETE FROM MAJORV3 WHERE MAJORID = 'AK' 
select *from MajorV3
select *from StudentV3

-- CÒN 2 CÁI GÀI NỮA LIÊN QUAN ĐẾN TÍNH ĐỒNG BỘ DATA/CONSISTENCY
-- SET NULL VÀ DEFAULT 
-- KHI 1 XÓA , N VỀ NULL 
-- KHI 1 XÓA , N VỀ DEFAULT 
select *from MajorV3
select *from StudentV3

-- **** CHỐT HẠ
-- XÓA BÊN 1 TỨC LÀ MẤT BÊN 1 , KO LẼ SỤP ĐỔ CẢ ĐÁM BÊN N, KO HAY, NÊN CHỌN ĐƯA BÊN N VỀ NULL 
-- UPDATE BÊN 1 , 1 VẪN CÒN GIỮ DÒNG/ROW, THÌ NÊN ĐỒNG BỘ BÊN N,ĂN THEO , CASCADE 
Alter table studentV3 drop constraint FK_StudentV3_MajorV3 -- XÓA RÀNG BUỘC KHÓA NGOẠI BI THIẾU VIỆC GÀI THÊM RULE 
                                                           -- NHỎ LIÊN QUAN ĐẾN SỬA XÓA DATA 
Alter table studentV3 add constraint FK_StudentV3_MajorV3 foreign key (MajorID) References MajorV3(MajorID) 
 ON DELETE SET NULL -- XÓA CHO MỒ CÔI, BƠ VƠ, NULL, TỪ TỪ TÍNH 
 ON UPDATE CASCADE -- SỬA BỊ ẢNH HƯỞNG DÂY CHUYỀN 

 -- CHO SINH VIÊN BƠ VƠ CHUYÊN NGÀNH VỀ HỌC SE 
 UPDATE STUDENTV3 SET MAJORID ='SE' -- TOÀN TRƯỜNG HỌC SE 
 UPDATE STUDENTV3 SET MAJORID ='SE' WHERE STUDENTID ='AI3'

 UPDATE STUDENTV3 SET MAJORID ='SE' WHERE MAJORID IS NULL 


