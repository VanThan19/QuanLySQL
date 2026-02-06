Create database ThiGiuaKi
Use ThiGiuaKi
Create Table tblPNhap
(
SoPN char(3) primary key,
NgayNhap date
)
Create Table tblVATTU
(
MaVTU char(3) primary key,
TenVTU nvarchar(20),
DoGia decimal(10,2)
)

Create Table tblCTPNHAP
(
SoPN char(3) references tblPNHAP(SoPN),
MaVTU char(3) references tblVATTU(MaVTU),
SlNhap int
)
INSERT INTO tblPNhap (SoPN, NgayNhap) VALUES 
('PN1', '2024-12-01'),
('PN2', '2024-12-02'),
('PN3', '2024-12-03');
Insert into tblPNhap values ('PN4','2015-02-11'),('PN5','2015-04-15')
-- Chèn dữ liệu vào bảng tblVATTU
INSERT INTO tblVATTU (MaVTU, TenVTU, DoGia) VALUES 
('VT1', N'Vật tư A', 5000.00),
('VT2', N'Vật tư B', 12000.00),
('VT3', N'Vật tư C', 8000.00);
INSERT INTO tblCTPNHAP (SoPN, MaVTU, SlNhap) VALUES 
('PN1', 'VT1', 100),
('PN1', 'VT2', 200),
('PN2', 'VT3', 150),
('PN3', 'VT1', 120),
('PN3', 'VT2', 180);
Insert into tblCTPNHAP values ('PN4','VT1',200),('PN5','VT3',100)
-- Thuc hien truy van sau 
--1 . Cho xem soPN,ngayNhap,tenVtu,DonGia,SLNhap
select n.SoPN,n.NgayNhap,v.TenVTU,v.DoGia,nh.SlNhap 
from tblPNHAP n join  tblCTPNHAP nh on n.SoPN = nh.SoPN join tblVATTU v on v.MaVTU = nh.MaVTU
--2. Cho xem soPN,ngayNhap,tenVtu,DonGia,SLNhap có ngayNhap trong thang 2 năm 2015
SELECT p.SoPN, p.NgayNhap, v.TenVTU, v.DoGia, c.SlNhap
FROM tblPNhap p JOIN tblCTPNHAP c ON p.SoPN = c.SoPN JOIN tblVATTU v ON c.MaVTU = v.MaVTU
WHERE MONTH(p.NgayNhap) = 2 AND YEAR(p.NgayNhap) = 2015;
-- 3.
SELECT v.MaVTU,  v.TenVTU,  SUM(c.SlNhap) AS TongSoLuong
FROM tblPNhap p
JOIN tblCTPNHAP c ON p.SoPN = c.SoPN
JOIN tblVATTU v ON c.MaVTU = v.MaVTU
WHERE YEAR(p.NgayNhap) = 2015
GROUP BY v.MaVTU, v.TenVTU;

-- 4 
SELECT TOP 1 v.TenVTU, SUM(c.SlNhap) AS TongSoLuong
FROM tblPNhap p
JOIN tblCTPNHAP c ON p.SoPN = c.SoPN
JOIN tblVATTU v ON c.MaVTU = v.MaVTU
GROUP BY  v.TenVTU
ORDER BY SUM(c.SlNhap) DESC;
-- 4 
Select 

