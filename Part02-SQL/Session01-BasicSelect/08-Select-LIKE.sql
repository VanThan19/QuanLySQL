USE Northwind 

------------------------------------------------------------------------------------
-- Lí thuyết 
-- Cú pháp mở rộng lệnh Select 
-- Trong thực tế có những lúc ta muốn tìm dữ liệu/filter theo kiểu gần đúng
-- gần đúng trên kiểu chuỗi , ví dụ, liệt kê ai đó có tên là An , khác câu liệt kê ai đó tên bắt đầu 
-- bằng chữ A.
-- Tìm đúng, Toán Tử = 'AN'
-- Tìm gần đúng, tìm sự xuất hiện, ko dùng =, dùng toán tử like
--              LIKE 'A...'...
-- Để sử dụng toán tử Like, ta cần thêm 2 thứ trợ giúp, dấu % và dấu _ 
-- % đại diện cho 1 chuỗi bất kì nào đó
-- _ đại diện cho 1 kí tự nào đó
-- ví dụ : name Like 'A%',bất kì ai có tên xuất hiện bằng chữ A, phần còn lại là gì ko quan tâm
--         name Like'A_',bất kì ai có tên là 2 kí tự, trong đó kí tự đầu phải là A

-------------------------------------------------------------------------------------------------
-- 1. In ra danh sách nhân viên 
Select *From Employees
-- 2. Nhân viên nào có tên bắt đầu chữ A
Select *From Employees Where FirstName Like 'A%'
-- 2.1 Nhân viên nào có tên bắt đầu chữ A, in ra cả fullname được ghép vào đầy đủ
Select EmployeeID , FirstName + ' ' + Lastname as FullName, Title From Employees Where FirstName Like 'A%'
Select EmployeeID ,CONCAT( FirstName , ' ' , Lastname) as FullName, Title From Employees Where FirstName Like 'A%'
-- CONCAT hàm ghép chuỗi 
-- 3. Nhân viên nào tên có chữ A cuối cùng 
Select *From Employees Where FirstName Like '%A'
-- 4. Nhân viên nào tên có 4 kí tự 
Select *From Employees Where FirstName Like '____'
-- 5. Xem danh sách các sản phẩm/món đồ đang có 
Select *From Products
-- 6. Những sản phẩm tên bắt đầu bằng Ch
select *From Products Where ProductName Like 'Ch%'
select *From Products Where ProductName Like '%Ch%' -- trong tên có từ ch , ko quan tâm vị trí xuất hiện 
-- 7. Những sản phẩm có 5 kí tự 
select *From Products Where ProductName Like '_____'
-- 8. Những sản phẩm tên có từ cuối cùng là 5 kí tự
select *From Products Where ProductName Like '%_____' -- tên có từ 5 kí tự trở lên
select *From Products Where ProductName Like '% _____' -- tên có ít nhất 2 từ 
                                                       -- từ cuối cùng 5 kí tự 
													   -- vô tình loại đi thằng tên chỉ có đúng 5 kí tự 
select *From Products Where ProductName Like '% _____' or ProductName Like '_____' 