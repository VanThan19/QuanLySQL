USE Northwind 
-- LỌC DỮ LIỆU 
------------------------------------------------------------------------------------
-- Lí thuyết 
-- Một DB là nới chứa data (bán hàng, thư viện, qlsv..)
-- Data được lưu trữ dưới dạng Table, tách thành nhiều Table (nghệ thuật design db, NF)
-- Dùng lệnh Select để xem/in dữ liệu Table, cũng hiển thị dưới dạng Table
-- Cú pháp chuẩn : SELECT * FROM <tên - table>
--           * : đại diện cho việc tui muốn lấy all of colums/ có bao nhiêu cột lấy sạch

-- Cú pháp mở rộng : 
--                SELECT tên-các-cột-muốn-lấy, cách-nhau-dấu-phẩy FROM <tên-TABLE>
--                SELECT có-thể-dùng-các-hàm-xử-lí-các-cột-để-độ-lại-thông-tin-hiển-thị
--                     FROM <tên-Table>
-- Khi ta Select ít cột từ table gốc thì có nguy cơ dữ liệu sẽ bị trùng lại 
-- Không phải ta bị sai, không phải người thiết kế table và người nhập liệu bị sai
-- Do chúng ta có nhiều info trùng nhau/ đặc điểm trùng nhau, nếu chỉ tập trung vào data này 
-- trùng nhau chắc chắn xảy ra
-- ví dụ 100 triệu người dân VN đc quản lý info bao gồm : Tên , DOB,....Tỉnh thành sinh sống 
-- Lệnh select hỗ trợ loại trừ dòng trùng nhau/ trùng 100%
-- Select Distinct tên-các-cột From <tên-table> 

-- Data trả về có cell/ô có từ NULL , hiểu rằng chưa xác định value/giá trị, chưa có,chưa 
-- biết từ từ cập nhật sau . Ví dụ sinh viên kí tên vào danh sách thi, cột điểm ngay lúc 
-- kí tên gọi là NULL là mang trạng thái chưa xác định 
-------------------------------------------------------------------------------------

-- 1. Liệt kê danh sách nhân viên
Select * From Employees
-- Phaan tichs : 9 nguowif nhuwng chir cos 4 title ~~~~ 100 trieweuj dân VN chỉ có 63 tỉnh
Select TitleOfCourtesy From Employees -- 9 danh xưng 
Select DISTINCT TitleOfCourtesy From Employees -- chỉ là 4 

Select DISTINCT EmployeeID, TitleOfCourtesy From Employees
-- NẾu Distinct đi kèm với id/key thì nó vô dụng, ket sao trùng mà loại trừ 

-- 2. In ra thông tin khách hàng 
Select * From Customers
-- 3. Có bao nhiêu quốc gia xuất hiện trong thông tin khách hàng, in ra 
Select Distinct Country From Customers
