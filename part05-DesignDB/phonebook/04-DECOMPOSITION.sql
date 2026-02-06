create DATABASE DBDESIGN_PHONEBOOK
USE DBDESIGN_PHONEBOOK 

CREATE TABLE PERSONV4_1
(
 Nick nvarchar(30),
 Title nvarchar(30),
 Company nvarchar(40)
 )
 -------------------------------------------------------------------------
 -- TÁCH BẢNG 
 -- KHỐN NẠN, INFO BỊ PHÂN MẢNH , NẰM NHIỀU NƠI, PHẢI JOIN RỒI 
 -- NHẬP DATA COI CHỪNG BỊ VÊNH, XÓA DATA COI CHỪNG LẠC TRÔI ,
 -- PHÂN MẢNH PHẢI CÓ LÚC TÁI NHẬP (JOIN) JOIN TRÊN CỘT MẸ NÀO ???
 -- fk xuất hiện 
 -- hok thích chơi fk có dc ko ?? được và ko được 
 -- nếu chỉ cần join éo cần fk , cột = value , khớp là join, nối bảng , ghép ngang 
 -- nếu kèm thêm xóa , sửa , thêm , chết mẹ lộn xộng ko nhất quán 

 CREATE TABLE PhoneBookV4_1
(
 Phone char(11) , 
 PhoneType nvarchar(20),
 Nick nvarchar(20) -- éo cần fk , chỉ cần join vẫn oke 
 )

 select *from PERSONV4_1
 select *from PhoneBookV4_1 

 Insert into PERSONV4_1 values (N'HoangNt','Lecturer','FTUHCM')
 
 Insert into PERSONV4_1 values (N'AnNt','Student','FTUHCM')
 
 Insert into PERSONV4_1 values (N'BinhNt','Student','FTUHCM')

 
 Insert into PhoneBookV4_1 values ('098x','Home',N'HoangNt')
 
 Insert into PhoneBookV4_1 values ('090x','Cell',N'AnNt')
 Insert into PhoneBookV4_1 values ('091x','Home',N'AnNt')

 Insert into PhoneBookV4_1 values ('090x','work',N'BinhNt')
 Insert into PhoneBookV4_1 values ('095x','cell',N'BinhNt' )
 Insert into PhoneBookV4_1 values ('096x','work',N'BinhNt')

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

