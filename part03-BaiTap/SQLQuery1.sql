create database ThiGiuaKi122 
use ThiGiuaKi122 

create table tblDonVi
(
maDv char(3) primary key,
tenDv nvarchar(50) ,
diaChiDv nvarchar(50),
dienThoai int 
)
create table tblCanBo
(
maCB char(3) references tblLuong(maCB),
maDv char(3) references tblDonVi(maDv),
tenCB nvarchar(50),
gioiTinh nvarchar(10),
soNamCongTac nvarchar(30),
diaChi nvarchar(30)
)
create table tblLuong
(
maCB char(3) primary key,
heSoLuong int
)
-- Nhap du lieu vao 
INSERT INTO tblDonVi (maDv, tenDv, diaChiDv, dienThoai)
VALUES 
('DV1', N'Phòng Kế Toán', N'123 Đường A', 123456789),
('DV2', N'Phòng Nhân Sự', N'456 Đường B', 987654321),
('DV3', N'Phòng IT', N'789 Đường C', 112233445);
INSERT INTO tblDonVi (maDv, tenDv, diaChiDv, dienThoai)
VALUES ('DV4', N'Phòng IT', N'789 Đường C', 112233445);
INSERT INTO tblLuong (maCB, heSoLuong)
VALUES 
('CB1', 3),
('CB2', 4),
('CB3', 2),
('CB4', 5);
INSERT INTO tblCanBo (maCB, maDv, tenCB, gioiTinh, soNamCongTac, diaChi)
VALUES 
('CB1', 'DV1', N'Nguyễn Văn A', N'Nam', N'5 năm', N'Nghệ An'),
('CB2', 'DV2', N'Phạm Thị B', N'Nữ', N'10 năm', N'Hà Tĩnh'),
('CB3', 'DV3', N'Trần Văn C', N'Nam', N'3 năm', N'Thanh Hóa'),
('CB4', 'DV1', N'Lê Thị D', N'Nữ', N'7 năm', N'Nghệ An');

--1 .
SELECT cb.tenCB,dv.tenDv,l.heSoLuong FROM tblDonVi dv join tblCanBo cb on dv.maDv = cb.maDv join tblLuong l on l.maCB = cb.maCB
where cb.diaChi = N'Nghệ An'
-- 2.
SELECT cb.tenCB AS TenCanBo,dv.tenDv AS TenDonVi,lg.heSoLuong AS HeSoLuong,(lg.heSoLuong * 1250000) AS LuongChinh,
 (lg.heSoLuong * 1250000 * 0.2) AS PhuCap,(lg.heSoLuong * 1250000) + (lg.heSoLuong * 1250000 * 0.2) AS TongLuong
FROM tblCanBo cb INNER JOIN tblDonVi dv ON cb.maDv = dv.maDv INNER JOIN tblLuong lg ON cb.maCB = lg.maCB;

-- 3. 
SELECT dv.tenDv AS TenDonVi,SUM(l.heSoLuong * 1250000) AS TongLuong
FROM tblDonVi dv JOIN tblCanBo cb ON dv.maDv = cb.maDv
JOIN tblLuong l ON l.maCB = cb.maCB
GROUP BY dv.tenDv;
-- 4.
SELECT tenDv FROM (SELECT dv.tenDv, SUM(l.heSoLuong * 1250000) AS TongLuong
FROM tblDonVi dv JOIN tblCanBo cb ON dv.maDv = cb.maDv
JOIN tblLuong l ON l.maCB = cb.maCB
GROUP BY dv.tenDv) AS DonViLuong
WHERE TongLuong = (SELECT MAX(SUM(l.heSoLuong * 1250000))FROM tblDonVi dv
JOIN tblCanBo cb ON dv.maDv = cb.maDv
JOIN tblLuong l ON l.maCB = cb.maCB
GROUP BY dv.tenDv);
-- 5. xem những tên dịch vụ chưa có trong bảng cán bộ 
SELECT tenDv FROM tblDonVi WHERE maDv NOT IN (SELECT maDv FROM tblCanBo)