use Northwind
--1. In ra thông tin các sản phẩm (nhãn hàng/mặt hàng) có trong hệ thống
-- Output 1: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, mã chủng loại, đơn giá, số lượng trong kho 
-- Output 2: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, xuất xứ nhà cung cấp (quốc gia)
-- Output 3: mã sản phẩm, tên sản phẩm, mã chủng loại, tên chủng loại
-- Output 4: mã sản phẩm, tên sản phẩm, mã chủng loại, tên chủng loại, mã nhà cung cấp, tên nhà cung cấp, xuất xứ nhà cung cấp
select *from Categories
select *from Products
select *from Suppliers
-- ouput 1 
select p.ProductID,p.ProductName,p.SupplierID,p.CategoryID,p.UnitPrice,p.QuantityPerUnit from Products p
-- output 2 
select p.ProductID,p.ProductName,p.SupplierID,s.ContactName,s.Country from Products p join Suppliers s 
                                                      on p.SupplierID = s.SupplierID
-- output 3 
select p.ProductID,p.ProductName,p.CategoryID,c.CategoryName from Products p join Categories c on p.CategoryID = c.CategoryID
-- output 4 
select p.ProductID,p.ProductName,p.CategoryID,c.CategoryName,p.SupplierID,s.ContactName ,s.Country
from Products p join Categories c 
on p.CategoryID = c.CategoryID join Suppliers s on p.SupplierID = s.SupplierID

--2. In ra thông tin các sản phẩm được cung cấp bởi nhà cung cấp đến từ Mỹ
-- Output 1: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, quốc gia, đơn giá, số lượng trong kho 
-- Output 2: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, đơn giá, số lượng trong kho, mã chủng loại, tên chủng loại 

select p.ProductID,p.ProductName,s.SupplierID,s.CompanyName,s.Country,p.UnitPrice,p.QuantityPerUnit from Products p join Suppliers s
on p.SupplierID = s.SupplierID where s.Country = 'USA' 

select p.ProductID,p.ProductName,s.SupplierID,s.CompanyName,p.UnitPrice,p.QuantityPerUnit,c.CategoryID,c.CategoryName
from Products p join Suppliers s on p.SupplierID = s.SupplierID join Categories c on p.CategoryID = c.CategoryID 
where s.Country = 'USA'

--3. In ra thông tin các sản phẩm được cung cấp bởi nhà cung cấp đến từ Anh, Pháp, Mỹ
-- Output: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp, quốc gia, đơn giá, số lượng trong kho
select p.ProductID,p.ProductName,s.SupplierID,s.CompanyName,s.Country,p.UnitPrice,p.QuantityPerUnit from Products p join Suppliers s
on p.SupplierID = s.SupplierID where s.Country IN ('USA','France','UK')

-- 4. Có bao nhiêu nhà cung cấp?
select count(*) as [Count] from Suppliers 
-- 5. Có bao nhiêu nhà cung cấp đến từ Mỹ
select count(country) as [Count] from Suppliers s where s.Country = 'USA' 

-- 6. Nhà cung cấp Exotic Liquids cung cấp những sản phẩm nào
-- Output 1: mã sản phẩm, tên sản phẩm, đơn giá, số lượng trong kho
-- Output 2: mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
-- Output 3: mã nhà cung cấp, tên nhà cung cấp, mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
select p.ProductID,p.ProductName,p.UnitPrice,p.QuantityPerUnit from Products p join Suppliers s 
on p.SupplierID = s.SupplierID where s.CompanyName = 'Exotic Liquids'
 
 --7. Mỗi nhà cung cấp cung cấp bao nhiêu mặt hàng (nhãn hàng)
-- Output 1: mã nhà cung cấp, số lượng mặt hàng
-- Output 2: mã nhà cung cấp, tên nhà cung cấp, số lượng mặt hàng
select s.SupplierID, s.CompanyName, count(c.ProductID) from Suppliers s join Products c on s.SupplierID = c.SupplierID
group by s.SupplierID, s.CompanyName

--8. Nhà cung cấp Exotic Liquids cung cấp bao nhiêu nhãn hàng?
-- Output: mã nhà cung cấp, tên nhà cung cấp, số lượng mặt hàng
select s.SupplierID, s.CompanyName, count(p.ProductID) as Count from Suppliers s join Products p on s.SupplierID = p.SupplierID 
where s.CompanyName = 'Exotic Liquids' group by s.SupplierID , s.CompanyName

--9. Nhà cung cấp nào cung cấp nhiều nhãn hàng nhất?
-- Output: mã nhà cung cấp, tên nhà cung cấp, số lượng nhãn hàng
select s.SupplierID, s.CompanyName, count(p.ProductID) from Suppliers s join Products p
on s.SupplierID = p.SupplierID group by s.SupplierID, s.CompanyName
having count(p.ProductID) >= All ( select count(p1.ProductID) from Products p1 join Suppliers s1 on s1.SupplierID = p1.SupplierID
group by s1.SupplierID)  

SELECT s.SupplierID, s.CompanyName, COUNT(p.ProductID) AS SoLuongMatHang
FROM Suppliers s
JOIN Products p ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierID, s.CompanyName
HAVING COUNT(p.ProductID) = (
    SELECT MAX(SoLuong)
    FROM (
        SELECT COUNT(p2.ProductID) AS SoLuong
        FROM Products p2
        GROUP BY p2.SupplierID
    ) AS Temp
);
--10. Liệt kê các nhà cung cấp cung cấp từ 3 nhãn hàng trở lên
-- Output: mã nhà cung cấp, tên nhà cung cấp, số lượng nhãn hàng
select s.SupplierID, s.CompanyName, count(p.ProductID) from Suppliers s join Products p
on s.SupplierID = p.SupplierID group by s.SupplierID, s.CompanyName having count(p.ProductID) >= 3

--11. Có bao nhiêu nhóm hàng/chủng loại hàng 
select count(*) from Categories 

--12. In ra thông tin các sản phẩm (mặt hàng) kèm thông tin nhóm hàng
-- Output: mã nhóm hàng, tên nhóm hàng, mã sản phẩm, tên sản phẩm
select p.CategoryID,c.CategoryName,p.ProductID,p.ProductName from Products p join Categories c on p.CategoryID = c.CategoryID 

-- 13. Liệt kê các sản phẩm thuộc nhóm hàng Seafood
-- Output 1: mã sản phẩm, tên sản phẩm
-- Output 2: mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
select p.ProductID,p.ProductName,c.CategoryID,c.CategoryName from Categories c join Products p on c.CategoryID = p.CategoryID where c.CategoryName = 'seafood'
select *from Categories
select *from Products

--14. Liệt kê các sản phẩm thuộc nhóm hàng Seafood và Beverages, sắp xếp theo nhóm hàng
--- Output 1: mã sản phẩm, tên sản phẩm
--- Output 2: mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
select p.ProductID,p.ProductName,c.CategoryID,c.CategoryName from Categories c join Products p 
on c.CategoryID = p.CategoryID where c.CategoryName IN ('seafood','beverages') order by c.CategoryID DESC

-- 15. Mỗi nhóm hàng có bao nhiêu nhãn hàng/mặt hàng
-- Output 1: mã nhóm hàng số lượng nhãn hàng 
-- Output 2: mã nhóm hàng, tên nhóm hàng, số lượng nhãn hàng 
select c.CategoryID,c.CategoryName,count(c.CategoryID) [Count] from Products p join Categories c
on p.CategoryID = c.CategoryID group by c.CategoryID,c.CategoryName

-- 16. Nhóm hàng nào có nhiều nhãn hàng/mặt hàng nhất
-- Output: mã nhóm hàng, tên nhóm hàng, số lượng nhãn hàng 
select c.CategoryID,c.CategoryName,count(c.CategoryID) [Count]  from Categories c join Products p 
on p.CategoryID = c.CategoryID group by c.CategoryID,c.CategoryName 
HAVING count(c.CategoryID) = ( select MAX(soLuong) from ( select count(p1.ProductID) soLuong from Categories c1 join Products p1 on p1.CategoryID = c1.CategoryID
group by c1.CategoryID ) as subque )