create DATABASE DBDESIGN_PHONEBOOK
USE DBDESIGN_PHONEBOOK 

CREATE TABLE PERSONV5_1_
(
 Nick nvarchar(30),
 Title nvarchar(30),
 Company nvarchar(40)
 )
 

 CREATE TABLE PhoneBookV5_1_
(
 Phone char(11) , 
 PhoneType nvarchar(20), -- cho người ta gõ trực tiếp loại phone, gây nên lộn xộn loại phone, cell, di động , mobile 
 --                         thống kê sẽ khó khăn , OR và còn tiếp tục sửa OR nữa do cho gõ tự do 
 --                         Hạn chế ko cho gõ lộn xộn, tức là phải gõ/ chọn theo ai đó trước ,FK 
 Nick nvarchar(20) -- éo cần fk , chỉ cần join vẫn oke 
 )


 CREATE TABLE PERSONV5_1
(
 Nick nvarchar(30),
 Title nvarchar(30),
 Company nvarchar(40)
 )
 

 -- TABLE MỚI XUẤT HIỆN, LƯU LOẠI PHONE, KO CHO GÕ LUNG TUNG ~~~ TABLE PROVINCE , CITY, COUNTRY, SEMESTER 

 CREATE TABLE PhoneTypeV5_1 
 (
 TypeName nvarchar(20)
 )
 -- ko mún xóa table mà vẫn thêm khóa chính 
 alter table phoneTypeV5_1 add constraint PK_PHONETYPE55_1 PRIMARY KEY (TypeName)
 alter table phoneTypeV5_1 alter COLUMN typeName nvarchar(20) not null 

 CREATE TABLE PhoneBookV5_1
(
 Phone char(11) , 
 TypeName nvarchar(20) references phoneTypeV5_1(TypeName), -- tham chiếu 
 Nick nvarchar(20)  
 )

 select *from PhoneTypeV5_1
 select *from PERSONV5_1
 select *from PhoneBookV5_1

 Insert into PhoneTypeV5_1 values (N'Di động')
 Insert into PhoneTypeV5_1 values (N'Nhà/Để bàn')
 Insert into PhoneTypeV5_1 values (N'Công ty')

 Insert into PERSONV5_1 values (N'HoangNt','Lecturer','FTUHCM')
 
 Insert into PERSONV5_1 values (N'AnNt','Student','FTUHCM')
 
 Insert into PERSONV5_1 values (N'BinhNt','Student','FTUHCM')

 
 Insert into PhoneBookV5_1 values ('098x',N'Di động',N'HoangNt')
 
 Insert into PhoneBookV5_1 values ('090x',N'di động',N'AnNt')
 Insert into PhoneBookV5_1 values ('091x',N'Công ty',N'AnNt')

 Insert into PhoneBookV5_1 values ('090x',N'Nhà/để bàn',N'BinhNt')
 Insert into PhoneBookV5_1 values ('095x',N'Di động',N'BinhNt' )
 Insert into PhoneBookV5_1 values ('096x',N'Công ty',N'BinhNt')
 
 select *from PERSONV4_1 p join PhoneBookV4_1 h on p.Nick = h.Nick
 -- PHÂN TÍCH :
 -- ƯU ĐIỂM : 
 -- COUNT NGON, GROUP BY NICK , THEO LUÔN LOẠI PHONE 
 -- WHERE THEO LOẠI PHONE NGON 
 SELECT * FROM PhoneBookV3_2 WHERE PHONETYPE = 'CELL' 
 -- REDUNDANCY TRÊN INFO CỦA NICK NAME GIẢI QUYẾT XONG Ở BẢNG PERSON 
 
 -- NHƯỢC ĐIỂM: 
 -- tÍNH KO NHẤT QUÁN (INCONSISTENCY) CỦA LOẠI PHONE : CÓ NGƯỜI GÕ : CELL,cell,Cell , éo sợ vì cùng 1 kiểu 
 --                                                      gõ thêm : Di động , DĐ --> cả đám này là 1 theo logic con người hiểu
 --                                                     máy hiểu là khác nhau 
 -- query liệt kê các số di động của tất cả mọi người, toang khi where 
 -- vì éo biết được có bao nhiêu loại chữ biểu diễn cho di động 
 -- nhập tự do k tốt đối với typePhone 
 -- để tránh bị inconsistency , ko cho nhập lộn xộn, khi ta biết nó chỉ có vài loại, ta sẽ thống nhất , ko cho nhập mà cho chọn 

 -- QUY TẮC THÊM : CÓ NHỮNG LOẠI DỮ LIỆU BIẾT TRƯỚC LÀ NHEIEUF, NHƯNG HỮU HẠN CÁI VALUE NHẬP TỈNH 
 -- THÀNH NHIỀU, CHỈ CÓ 63, QUỐC GIA NHIỀU 230, CHÂU LỤC NHIỀU 56 ...
 -- CÓ NÊN CHO NGƯỜI TA GÕ TAY HAY KO ?? KO , VÌ NÓ SẼ GÂY NÊN KO NHẤT QUÁN !!!
 -- TỐT NHẤT CHO CHỌN, CHỌN PHẢI TỪ CÁI CÓ SẴN , SẴN, TỨC LÀ TỪ TABLE KHÁC 
 -- KHÔNG CHO GÕ LUNG TUG, GÕ TRONG CÁI ĐÃ CÓ - DÍNH 2 THỨ , TABLE KHÁC(ĐÃ NÓI TRÊN)
 --                        FK ĐỂ ĐẢM BẢO CHỌN ĐÚNG TRONG ĐÓ THÔI 

 --=============================================================================================
 
 CREATE TABLE PERSONV5
(
 Nick nvarchar(30) primary key ,
 Title nvarchar(30),
 Company nvarchar(40)
 )

 CREATE TABLE PhoneTypeV5 
 (
 TypeName nvarchar(20) not null,
  constraint PK_PHONETYPEV5 primary key (TypeName)
 )

 CREATE TABLE PhoneBookV5
(
 Phone char(11) , 
 TypeName nvarchar(20) references phoneTypeV5(TypeName),-- nó thuộc loại gì
 Nick nvarchar(30) references PersonV5(Nick) -- của thằng ku nào 
 )-- loại gì & của ai, ko gõ lung tung 
alter table PhoneBookV5 add constraint PK_PHONEBOOKV5 primary key (Phone)
alter table PhoneBookV5 alter Column Phone char(11) not null 

select * from PERSONV5_1
select * from PhoneTypeV5_1
select * from PhoneBookV5_1