create DATABASE DBDESIGN_PHONEBOOK
USE DBDESIGN_PHONEBOOK 

CREATE TABLE PhoneBookV1 
(
 Nick nvarchar(30),
 Phone varchar(50)
 )-- 3 sô phone gom vào 1 cột

 select *from PhoneBookV1
 Insert into PhoneBookV1 values (N'HoangNt','090x')
 -- An có 2 số phone , làm sao để lưu 
 Insert into PhoneBookV1 values (N'AnNt','098x, 091x')
 -- Bình có 3 số phone, làm sao lưu? mày k thấy tao để độ rộng phone 50 à
 Insert into PhoneBookV1 values (N'BinhNt','090x; 095x; 096x')

 -- PHÂN TÍCH :
 -- ƯU ĐIỂM : SELECT PHONE LÀ RA ĐƯỢC TẤT CẢ CÁC SỐ DI ĐỘNG

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

