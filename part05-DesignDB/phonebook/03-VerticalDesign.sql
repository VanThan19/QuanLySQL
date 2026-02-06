create DATABASE DBDESIGN_PHONEBOOK
USE DBDESIGN_PHONEBOOK 

CREATE TABLE PhoneBookV3_ 
(
 Nick nvarchar(30),
 --Phone varchar(50)-- cấm đa trị, cấm gộp nhiều số phone trong 1 cell 
 Phone1 char(11) , -- chỉ 1 số phone thôi 
 Phone2 char(11),
 Phone3 char(11) -- éo biết cột nào là loại phone nào
 )

CREATE TABLE PhoneBookV3_1 
(
 Nick nvarchar(30),
 
 Phone char(11) , -- chỉ 1 số phone thôi 
 -- mở rộng table theo chiều dọc, ai có nhiều sim thì thêm dòng 
 )
 select *from PhoneBookV3_1
 Insert into PhoneBookV3_1 values (N'HoangNt','090x')
 
 Insert into PhoneBookV3_1 values (N'AnNt','090x')
 Insert into PhoneBookV3_1 values (N'AnNt','091x')

 Insert into PhoneBookV3_1 values (N'BinhNt','090x')
 Insert into PhoneBookV3_1 values (N'BinhNt','095x' )
 Insert into PhoneBookV3_1 values (N'BinhNt','096x')

 -- PHÂN TÍCH :
 -- ƯU ĐIỂM : SELECT PHONE LÀ RA ĐƯỢC TẤT CẢ CÁC SỐ DI ĐỘNG
 -- Thống kê số lượng số điện thoại mỗi người xài, mấy sim ?? ko trả lời dc 
 select nick,count(*) [phone] from PhoneBookV3_1 group by nick --> ko bị null 
 -->>> Nhược điểm :
  --Cho tui biết các số di động của mọi người 
 -- vi phạm PK , redundancy , annt lặp lại nhiều lần làm gì khi annt mới lưu nick thôi 
 --

 
 -- TRIẾT LÍ THIẾT KẾ : CỐ GẮNG GIỮ NGUYÊN CÁI TỦ, CHỈ THÊM ĐỒ,
 --                     KO THÊM CỘT CỦA TABLE, CHỈ CẦN THÊM DÒNG NẾU CÓ BIẾN ĐỘNG SỐ LƯỢNG 

 -- Tránh bị REDUNDANCY , PK -> TÁCH BẢNG, PHẦN LẶP LẠI RA 1 CHỖ KHÁC 

 -----------------------------------------------------------------------
 -- TA CẦN GIẢI QUYẾT PHONE NÀY Ở LOẠI NÀO 

 CREATE TABLE PhoneBookV3_2
(
 Nick nvarchar(30),
 
 Phone char(11) , 
 PhoneType nvarchar(20)
 )
 select *from PhoneBookV3_2
 Insert into PhoneBookV3_2 values (N'HoangNt','098x','Home')
 
 Insert into PhoneBookV3_2 values (N'AnNt','090x','Cell')
 Insert into PhoneBookV3_2 values (N'AnNt','091x','Home')

 Insert into PhoneBookV3_2 values (N'BinhNt','090x','work')
 Insert into PhoneBookV3_2 values (N'BinhNt','095x','cell' )
 Insert into PhoneBookV3_2 values (N'BinhNt','096x','work')

 -- PHÂN TÍCH :
 -- ƯU ĐIỂM : 
 -- COUNT NGON, GROUP BY NICK , THEO LUÔN LOẠI PHONE 
 -- WHERE THEO LOẠI PHONE NGON 
 SELECT * FROM PhoneBookV3_2 WHERE PHONETYPE = 'CELL' 
 -- NHƯỢC ĐIỂM :
 -- REDUNDANCY TRÊN INFO CỦA NICK NAME 

 -- MỘT KHI BỊ TRÙNG LẶP INFO , LẶP LẠI INFO, REDUNDANCY , CHỈ CÓ 1 SOLUTION KO CHO TRÙNG 
 -- TỨC LÀ XUẤT HIỆN 1 LẦN, TỨC LÀ RA BẢNG KHÁC >> DECOMPOSITION PHÂN RÃ 


 -- Cho tui biết số để bàn , ở nhà của anh bình ??? toang 
 --> đáp án : quy ước số đầu tiên là để bàn, số 2 là di động, số 3 work 
 -- Khốn nạn vì quy ước ngầm, số nào là loại nào !!! Khó nhớ cho người nhập liệu 
 -- câu hỏi : In cho tui số di động của mọi người ? 
 -- tiêu chí cắt chuỗi - DELIMITER DẤU PHÂN CÁCH KO NHẤT QUÁN 
 -- QUY ƯỚC NGẦM VỀ NHẬP DẤU PHÂN CÁCH 

 -- ĐẾM XEM MỖI NGƯỜI CÓ BAO NHIÊU SỐ PHONE !!! COUNT()Á QUEN 
 -- DẤU PHÂN CÁCH KHÓ KHĂN CHO CẮT ĐỂ COUNT 

 -- KHÓ KHĂN XẢY RA KHI TA GOM NHIỀU VALUE CÙNG KIỂU NGỮ NGHĨA VÀO TRONG 1 COLUMN ( cột phone lưu nhiều số phone 
 --các nhau dấu cách )
 --gây khó khắn cho nhập dữ liệu (ko nhất quán dấu cách), khi select count() thống kê theo tiêu chí (in số phone 
 -- ở nhà ) update thêm phone mới , xóa số cũ ,

 -- Một cell mà chứa nhiều value cùng kiểu, dc gọi là cột đa trị
 --MULTIVALUED --> Tiềm ẩn nhiều khó khăn cho việc xử lý data 

 -- NẾU 1 TABLE CÓ CỘT ĐA TRỊ NGƯỜI TA NÓI RẰNG NÓ ÉO ĐẠT CHUẨN 1 LEVEL THIẾT KẾ CHÁN QUÁ - 1ST NORMALIZATION 
 -- CHUẨN 1 , CHẤT LƯỢNG THIẾT KẾ TÍNH TỪ 1,2,3....

 -- THIẾT KẾ KÉM THÌ PHẢI NÂNG CẤP, KO CHƠI ĐA TRỊ NỮA 
 -- KO CHƠI GOM VALUE TRONG 1 CELL 
 -- 2 CHIẾN LƯỢC FIX
 -- CHIỀU NGANG (thêm cột), CHIỀU DỌC (thêm dòng)****

