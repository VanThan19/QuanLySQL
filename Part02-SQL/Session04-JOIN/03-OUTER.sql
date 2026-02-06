use Cartersian
-- 1. liệt kê cho tôi các cặp từ điển tiếng anh - việt 
select *from Endict e , Vndict v where e.Numbr=v.Numbr -- có bằng cell thì mới ghép 
select *from Endict e JOIN Vndict v ON e.Numbr=v.Numbr -- hãy ghép đi, trên cột này có cell/value này = cell/value kia 
-- 2. Hụt mất của tui từ 4- four và 5 ko thấy xuất hiện 
-- muốn xuất hiện 4 và 5 thì tích đề các 
select *from Endict e , Vndict v
-- 3. Tui muốn xuất hiện lấy tiếng anh làm chuẩn, tim các nghĩa tiếng việt tương đương 
-- nếu k có tương đương vẫn phải tìm ra 
select *from Endict e Left join  Vndict v on e.Numbr=v.Numbr
select *from Endict e Left outer join  Vndict v on e.Numbr=v.Numbr
-- ngược lại muốn lấy tiếng việt làm đầu 
select *from Endict e Right join  Vndict v on e.Numbr=v.Numbr -- right là lấy bên phải làm chuẩn 
-- dù chung và riêng của mỗi bên, lấy tất, chấp nhận fa ở 1 vế 
select *from Endict e full join  Vndict v on e.Numbr=v.Numbr
-- full outer join , thứ tự table ko quan trọng, viết trước viết sau đều được 
-- left , right join thứ tự table là có chuyện khác nhau 

-- outer join sinh ra để đảm bảo việc kết nối ghép bảng ko bị mất data
-- do inner join , join = chỉ tìm cái chung 2 bên 

-- sau khi tìm ra được data chung riêng, ta có quyền filter trên loại cell nào đó , where như bình thường 

-- 6. In ra bộ từ điển anh việt (anh làm chuẩn) của những con số từ 3 trở lên 
select *from Endict e Left join  Vndict v on e.Numbr=v.Numbr where e.Numbr >=3
select *from Endict e Left join  Vndict v on e.Numbr=v.Numbr where v.Numbr >=3

-- 6. In ra bộ từ điển anh việt việt anh của những con số từ 3 trở lên
select *from Endict e full join  Vndict v on e.Numbr=v.Numbr where e.Numbr >=3 or v.Numbr >=3 
