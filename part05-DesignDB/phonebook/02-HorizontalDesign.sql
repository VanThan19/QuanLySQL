create DATABASE DBDESIGN_PHONEBOOK
USE DBDESIGN_PHONEBOOK 

CREATE TABLE PhoneBookV2_ 
(
 Nick nvarchar(30),
 --Phone varchar(50)-- cấm đa trị, cấm gộp nhiều số phone trong 1 cell 
 Phone1 char(11) , -- chỉ 1 số phone thôi 
 Phone2 char(11),
 Phone3 char(11) -- éo biết cột nào là loại phone nào
 )

CREATE TABLE PhoneBookV2 
(
 Nick nvarchar(30),
 --Phone varchar(50)-- cấm đa trị, cấm gộp nhiều số phone trong 1 cell 
 HomePhone char(11) , -- chỉ 1 số phone thôi 
 WorkPhone char(11),
 CellPhone char(11) -- mở rộng table theo chiều ngang - thêm cột!!!
 )
 select *from PhoneBookV2
 Insert into PhoneBookV2 values (N'HoangNt',null,null,'090x')
 
 Insert into PhoneBookV2 values (N'AnNt','090x', '091x',null)

 Insert into PhoneBookV2 values (N'BinhNt','090x', '095x' ,'096x')

 -- PHÂN TÍCH :
 -- ƯU ĐIỂM : SELECT PHONE LÀ RA ĐƯỢC TẤT CẢ CÁC SỐ DI ĐỘNG
 -- 1. Sql. Cho tui biết các số di động của mọi người 
 Select Nick,CellPhone from PhoneBookV2
 -->>> Nhược điểm :
 -- Thống kê số lượng số điện thoại mỗi người xài, mấy sim ?? ko trả lời dc 
 -- Data bị null, phí ko gian lưu trữ 
 -- Người có 4 phone, 5 phone thì sao ??
 -- Solution : thêm cột, càng thêm cột trừ hao về người có nhiều phone những người còn lại bị null càng nhiều 
 -- Phí vì chỉ 1 vài người đặc biệt nhiều phone mà tất cả anh em khác đều được 
 -- xem chung là nhiều số phone, phí không gian lưu trữ 
 -- Giả sử vẫn quyết tâm theo cột, nở cột ra, thì giá phải trả sửa code lập trình
 -- Sau này , vì tên cột mới dc thêm vô khi nâng cấp app, sửa thêm câu query 
 -- TRIẾT LÍ THIẾT KẾ : CỐ GẮNG GIỮ NGUYÊN CÁI TỦ, CHỈ THÊM ĐỒ,
 --                     KO THÊM CỘT CỦA TABLE, CHỈ CẦN THÊM DÒNG NẾU CÓ BIẾN ĐỘNG SỐ LƯỢNG 

 -- PHIÊN BẢN 3 : PHIÊN BẢN NGON BẮT ĐẦU, AI NHIỀU PHONE THÌ NHIỀU DÒNG, NHIỀU CELL THEO CHIỀU DỌC THÊM DÒNG
 -- COUNT NGON LÀNH LUÔN, TRẢ LỜI NGAY ĐC CÂU BAO NHIÊU SIM BAO NHIÊU SÓNG





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

