-- Kiểu dữ liệu - Data type là cách ta lưu loại dữ liệu nào đó số, chữ,câu,..
-- 1 NNLT sẽ hỗ trợ nhiều loại dữ liệu khác nhau - data type 
-- Khi lập trình trong sql server , vì câu lệnh sẽ nằm trên nhiều dòng...
-- mình cần nhắc Tool này 1 câu : đừng nhìn lệnh riêng lẻ(nhiều dòng) mà hãy nhìn nguyên cụm lệnh mới có ý
-- nghĩa (BATCH)
-- Ta sẽ dùng lệnh Go để gom 1 cụm lệnh lập trình lại thành 1 đơn vị có ý nghĩa 

-- Khai báo biến 
Go
DECLARE @msg1 as nvarchar(30) 

DECLARE @msg nvarchar(30) = N'Xin Chào-Welcome to T-SQL'

-- In biến 
Print @msg -- In ra kết quả bên cửa sổ consol giống trong lập trình 
Select @msg -- In ra kết quả dưới dạng table 

DECLARE @yob int  --= 2003 
-- Gán giá trị cho biến 
SET @yob = 2003 
Select @yob = 2001 -- Select dùng 2 cách : gán giá trị cho biến, in giá trị của biến 

PRINT @yob 

IF @yob > 2003  -- bắt đầu từ 2 câu lệnh từ trên begin end tương đương với ngoặc nhọn 
  BEGIN
   Print 'HEY,BOY'
   PRINT 'HI'
  END
ELSE 
   PRINT 'HELLO'

GO