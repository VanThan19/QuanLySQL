create database DBDESIGN_ONETABLE
-- create dùng để tạo cấu trúc lưu trữ/ dàn khung/thùng chứa dùng lưu trữ data/info
-- tương đương việc xây phòng chứa đồ - database
--             mua tủ để trong phòng - table
-- 1 DB chứa nhiều table - 1 phòng có nhiều tủ 
--                         1 nhà có nhiều phòng 
-- tạo ra cấu trúc lưu trữ - chưa nói data bỏ vào -- DDL ( phân nhánh của sql)

use DBDESIGN_ONETABLE 

-- tạo tavle lưu trữ hồ sơ sv : mã số (phân biệt các sv với nhau), tên , năm sinh , địa chỉ....
-- 1 sinh viên ~~~ 1 object ~~~ 1 entity 
-- 1 table dùng lưu trữ nhiều entity 

create table StudentV1 
(
StudentId char(8) ,
LastName nvarchar(30), -- tại sao không gộp fullname, N : lưu kí tự unicode tiếng việt
-- char là lưu trữ sẽ to ,k sài hết vẫn phải cấp 
-- varchar tiết kiệm hơn muốn xài bao nhiều tao cấp bấy nhiêu , xử lý sẽ lâu hơn 
FirstName nvarchar(15),
DOB datetime ,
diaChi nvarchar(30)
)
select *from StudentV1

-- đưa data vào table / mua đồ quần áo bỏ vào tủ 
insert into StudentV1 values('se12345',N'Nguyễn',N'An','2005-06-19',N'Nghệ An') -- đưa hết vào các cột, sv full ko che thông tin 

-- một số cột chưa thèm nhập info, được quyền bỏ trống nếu cột cho phép trống vale 
-- default khi đóng cái tủ/ mua tủ/thiết kế tủ, mặc định null 
insert into StudentV1 values('se12345',N'Nguyễn',N'Bình','2004-06-19',null)

-- tên thành phố là null, where = 'null' oke vì nó là data
-- null ở câu trên where address is null 
insert into StudentV1 values('se12345',N'Nguyễn',N'Võ','2009-06-19',N'NULL')

-- tui chỉ muốn lưu vài info , ko đủ số cột, miễn cột còn lại cho phép bỏ trống 
insert into StudentV1(StudentId, LastName,FirstName) values('se12345',N'Nguyễn',N'Cường')

insert into StudentV1(LastName,FirstName,StudentId) values(N'Nguyễn',N'Cường','se12345')

insert into StudentV1(LastName,FirstName,StudentId) values(Null,Null,Null)-- siêu nguy hiểm , sv toàn info bỏ trống 
-- gài cách đưa data vào các cột sao cho hợp lí 
-- constraint trên data/cell 

select *from StudentV1

-- cú nguy hiểm này còn lớn hơn !!!
-- trùng mã số ko chấp nhận dc -- ta phải gài ràng buộc dưx liệu quan trọng này 
-- cột mà value cấm trùng trên mọi cell cùng cột dùng làm chìa khóa/key để tìm ra/mở ra/xác định duy nhất 1 info,dòng,
-- 1 sv, 1 entity , 1 object cột này dc gọi là PRIMARY KEY 
insert into StudentV1(LastName,FirstName,StudentId) values(N'Nguyễn',N'Fuck','se12345')

select *from StudentV1 where StudentId = 'se12345'

-- gài cách đưa data vào table để ko có những hiện tượng bất thường, 1 dòng trống trơn, key trùng 
-- key null - default thiết kế cho phép null tất cả 
-- gài - constraints 
create table StudentV2
(
StudentId char(8) primary key , -- bao hàm luôn not null - bắt buộc đưa data , cấm trùng 
LastName nvarchar(30) not null , 
FirstName nvarchar(15) not null ,
DOB datetime ,
diaChi nvarchar(30)
)
insert into StudentV2 values('se12345',N'Nguyễn',N'An','2005-06-19',N'Nghệ An')
insert into StudentV2 values('se12346',N'Nguyễn',N'Bình','2004-06-19',null)
insert into StudentV2(StudentId, LastName,FirstName) values('se12347',N'Nguyễn',N'Cường')
--insert into StudentV2(LastName,FirstName,StudentId) values(Null,Null,Null)
select *from StudentV2

create table StudentV3
(
studentID char(8) not null,
LastName nvarchar(30) not null , 
FirstName nvarchar(15) not null ,
DOB datetime ,
diaChi nvarchar(30),
primary key(studentID)
)
insert into StudentV3 values('se12345',N'Nguyễn',N'An','2005-06-19',N'Nghệ An')
insert into StudentV3 values('se12346',N'Nguyễn',N'Bình','2004-06-19',null)
insert into StudentV3(StudentId, LastName,FirstName) values('se12347',N'Nguyễn',N'Cường')

select *from StudentV3

-- Generate tuwf erd trong tool thiết kế 
CREATE TABLE StudentV4 (
  Student  char(8) NOT NULL, 
  LastName varchar(30) NOT NULL, 
  FirtName varchar(10) NOT NULL, 
  PRIMARY KEY (Student));

  select *from StudentV4

---------------------------------------------------------------------------------------------------------------------
-- HỌC THÊM VỀ CÁI CONSTRAINTS - TRONG ĐÓ PK CONSTRAINT 
-- RÀNG buộc là các ta / db designer ép cell/ cột nào đó value phải ntn
-- đặt ra quy tắc/rule cho việc nhập data 
-- Vì có nhiều quy tắc, nên tránh nhầm lẫn, dễ kiểm soát ta sẽ có quyền đặt tên cho các quy tắc, constraint name
-- Ví dụ : Má ở nhà đặt quy tắc/ nội quy cho mình 
-- Rude #1 : Vào sài gòn học thật tốt nha con. Tốt : điểm tb >= 8 && ko rớt môn nào 
--            && 9 học kì ra trường && không đổi chuyên ngành 
-- Rude #2 : Tối đi chơi về nhà sớm. 
--Rude #3 : ???
-- tên ràng buộc/ quy tắc :    nội dung/cái data dc gài vào 
--     PK_???                     Primary Key 
-- Mặc định các DB Engine nó tự đặt tên cho các ràng buộc nó thấy khi bạn gõ lệnh DDL 
-- DBE cho mình cơ chế tự đặt tên ràng buộc 

create table StudentV6
(
studentID char(8) not null,
LastName nvarchar(30) not null , 
FirstName nvarchar(15) not null ,
DOB datetime ,
diaChi nvarchar(30),
--primary key(studentID) -- tự dbe đặt tên cho ràng buộc 
Constraint PK_STUDENTS primary key (StudentID)
)
-- Dân chuyên đôi khi còn làm cách sau. Người ta tách hẳn việc tạo ràng buộc khóa chính, khóa ngoại ra hẳn 
-- cấu trúc table, tức là create table chỉ chứa tên cấu trúc - cột - domain 
-- tạo table xong rồi chỉnh sửa table -- sửa cái tủ chứ không phải data trong tủ 
drop table StudentV7 
create table StudentV7
(
studentID char(8) not null,
LastName nvarchar(30) not null , 
FirstName nvarchar(15) not null ,
DOB datetime ,
diaChi nvarchar(30),
--primary key(studentID) -- tự dbe đặt tên cho ràng buộc 
--Constraint PK_STUDENTV7 primary key (StudentID)
)
-- Alter table : chỉnh sửa 
Alter table StudentV7 add constraint PK_STUDENTV7 primary key (StudentID)

-- Xóa 1 ràng buộc dc không , được , cho add thì cho drop 
alter table studentV7 Drop constraint PK_STUDENTV7