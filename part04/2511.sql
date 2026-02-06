Create database BaiTapOnTap
Use BaiTapOnTap


Create table tblSV
(
maSV int primary key,
tenSv nvarchar(30),
queQuan nvarchar(30),
namSinh int,
diemRL decimal(5,2)
)
Create table tblDeTai
(
maDT int primary key,
tenDT nvarchar(30),
kinhPhi decimal(10,2)
)
Create table thucTap
(
maSV int references tblSV(maSV),
maDT int references tblDeTai(maDT),
Diem decimal(5,2)
)
Insert into tblSV values (1,N'Nguyễn Văn Thân',N'Nghệ An',2005,8.9),
(2,N'Hoàng Minh Thắng',N'Lào Cai',2005,8.9),
(3,N'Nguyễn Trọng Mạnh',N'Nghệ An',1999,9.8),
(4,N'Bùi Đình Dương',N'Yên Bái',1888,4.5),
(5,N'Phạm Võ Tuấn Minh',N'Cà Mau',2005,9.9)
Insert into tblSV values (6,N'Nguyễn Văn Mạnh',N'Nghệ An',2005,8.9)
Insert into tblDeTai values (01,N'Tây Du Ký',100000),
(02,N'Quản Lý Sách',200000),
(03,N'Quản Lý Web',500000),
(04,N'Quản Lý Bệnh Viên',1000000),
(05,N'Quản lý nhà hàng',50000000)

Insert into thucTap values (1,05,9.9), (2,02,8.8),(3,04,7.5),(4,01,8.5),(5,03,5.5)
Insert into thucTap values (6,05,8.0)
--1.Cho xem các thông tin MaSV, TenSV, QueQuan, DiemRL, Diem, TenDT, KinhPhi 
Select sv.maSV,sv.tenSv,sv.queQuan,sv.diemRL,t.Diem,d.tenDT,d.kinhPhi
from tblSV sv join thucTap t on sv.maSV = t.maSV join tblDeTai d on d.maDT = t.maDT
--2.Cho xem danh sách gồm MaSV, TenSV, QueQuan, TenDT của những sinh viên sinh trước 1980
Select sv.maSV,sv.tenSv,sv.queQuan,d.tenDT
from tblSV sv join thucTap t on sv.maSV = t.maSV join tblDeTai d on d.maDT = t.maDT
where sv.namSinh < 1980 
--3.Iin ra là danh sách các thông tin MaSV, TenSV, QueQuan, NamSinh, TenDT, Diem của những sinh viên có Diem>= D
Select sv.maSV,sv.tenSv,sv.queQuan,sv.diemRL,t.Diem,d.tenDT,d.kinhPhi
from tblSV sv join thucTap t on sv.maSV = t.maSV join tblDeTai d on d.maDT = t.maDT
where t.Diem between 4.0 and 10 
--4.Thống kê mỗi đề tài có bao nhiêu SV thực hiện
Select d.tenDT,count(*) SoLuong from thucTap t join tblDeTai d on d.maDT = t.maDT group by d.tenDT
--5.Hiện thị Tên đề tài có 2 SV làm trở lên
Select d.tenDT,count(*) SoLuong from thucTap t join tblDeTai d on d.maDT = t.maDT group by d.tenDT having count(*) >= 2 
--6.Cho xem Tên đề tài có nhiều SV thực hiện nhất
SELECT TOP 1 
    dt.TenDT, COUNT(d.MaSV) AS SoLuongSV
FROM 
    tblDETAI dt
JOIN 
    thucTap d ON dt.MaDT = d.MaDT
GROUP BY 
    dt.TenDT
ORDER BY 
    SoLuongSV DESC;

