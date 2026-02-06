Create database QLBanHangg
Use QLBanHangg

Create Table tblVatTu (
    MaVTu char(5) PRIMARY KEY not null,
    TenVTu nvarchar(255),
    DVTinh nvarchar(50),
    DonGia decimal(18,2)
)

Create Table tblNhaCungCap (
    MaNCC char(5) PRIMARY KEY not null,
    TenNCC nvarchar(255),
    DiaChi nvarchar(255),
	Sdt char(15)
)

Create Table tblDONDH (
    SoDH char(5) PRIMARY KEY not null,
    MaNCC char(5) FOREIGN KEY REFERENCES tblNhaCungCap(MaNCC),
    NgayDH date
)
Create Table tblChiTietDH (
   SoDH char(5) foreign key references tblDONDH(SoDH),
   MaVTu char(5) foreign key references tblVatTu(MaVTu),
   SoLuongDat int
)
Create Table tblPNHAP (
    SoPN char(5) PRIMARY KEY not null,
	SoDH char(5) foreign key references tblDONDH(SoDH),
    NgayNhap date
)

Create Table tblCTPNHAP (
    SoPN char(5) FOREIGN KEY REFERENCES tblPNHAP(SoPN),
    MaVTu char(5) FOREIGN KEY REFERENCES tblVATTU(MaVTu),
    SoLuongNhap int,
    DonGiaNhap decimal(18,2)   
)

Create Table tblPXUAT (
    SoPX char(5) PRIMARY KEY not null,
    NgayXuat date
)

Create Table tblCTPXUAT (
    SoPX char(5) FOREIGN KEY REFERENCES tblPXUAT(SoPX),
    MaVTu char(5) FOREIGN KEY REFERENCES tblVATTU(MaVTu),
    SoLuongXuat int,
    DonGiaXuat decimal(18,2)
)
Create Table tblTONKHO (
    NAMTHANG char(7),
    MaVTu char(5) FOREIGN KEY REFERENCES tblVatTu(MaVTu),
    TONGNHAP INT,
    TONGXUAT INT,
    SLTonkho INT  
)
Insert into tblVatTu values 
('VT001',N'Sách Giáo Khoa',N'Cuốn',50000.00),
('VT002',N'Giày Thể Đá Bóng',N'Đôi',100000.00),
('VT003',N'Đèn Học',N'Cái',90000.00),
('VT004',N'Giấy A4',N'Tờ',1000.00),
('VT005',N'Bút Tẩy',N'Cuốn',5000.00),
('VT006',N'Tay Cầm Gamming',N'Cái',100000.00)

INSERT INTO tblNhaCungCap VALUES 
('NCC01', N'Nhà Cung Cấp A', N'Nghệ An', '0912345678'),
('NCC02', N'Nhà Cung Cấp B', N'Hà Nội', '0987654321'),
('NCC03', N'Nhà Cung Cấp C', N'TP.HCM', '0971122334'),
('NCC04', N'Nhà Cung Cấp D', N'Nghệ An', '0909090909'),
('NCC05', N'Nhà Cung Cấp E', N'Hà Tĩnh', '0968686868')
Insert into tblNhaCungCap values 
('NCC06', N'Nhà Cung Cấp T', N'Lào Cai', '0968686869'),
('NCC07', N'Nhà Cung Cấp M', N'Đà Nẵng', '0968686866')
Insert into tblDONDH values 
('DH001', 'NCC01', '2025-02-19'),
('DH002', 'NCC02', '2025-01-15'),
('DH003', 'NCC03', '2025-02-01'),
('DH004', 'NCC04', '2025-02-20'),
('DH005', 'NCC05', '2025-01-10'),
('DH006', 'NCC04', '2025-01-01'),
('DH007', 'NCC03', '2025-01-17')
Insert into tblDONDH values 
('DH008', 'NCC05', '2025-01-05'),
('DH009', 'NCC05', '2025-01-12')
Insert into tblChiTietDH values
('DH001','VT003',5),
('DH003','VT001',15),
('DH002','VT002',55),
('DH004','VT004',95)
Insert into tblChiTietDH values
('DH005','VT005',95),
('DH006','VT004',90005)
Insert into tblPNHAP values 
('PN001','DH001', '2025-01-05'),
('PN002','DH002', '2024-01-20'),
('PN003','DH003', '2025-02-10'),
('PN004','DH004', '2025-02-05'),
('PN005','DH006', '2025-01-20')
Insert into tblCTPNHAP values 
('PN001', 'VT001', 100, 45000.00),
('PN001', 'VT002', 500, 900.00),
('PN002', 'VT003', 200, 1800.00),
('PN004', 'VT004', 1000, 400.00),
('PN003', 'VT005', 50, 1200.00),
('PN005', 'VT001', 100, 45000.00)
Insert into tblPXUAT values 
('PX001', '2025-01-10'),
('PX002', '2025-02-15'),
('PX003', '2024-02-15'),
('PX004', '2025-02-19'),
('PX005', '2023-02-15')
Insert into tblCTPXUAT values 
('PX001', 'VT001', 50, 50000.00),
('PX002', 'VT002', 200, 1000.00),
('PX003', 'VT003', 100, 2000.00),
('PX004', 'VT004', 500, 500.00),
('PX005', 'VT005', 20, 1500.00)
INSERT INTO tblTONKHO VALUES 
('2025-01', 'VT001', 100, 50, 50),
('2025-01', 'VT002', 500, 200, 300)
-- Câu 1. Hiện thông tin Mã Vật tư, Tên vật tư, Đơn giá.
Select MaVTu,TenVTu,DonGia From tblVatTu
-- Câu 2. Hiện thông tin các vật tư có tên bắt đầu bằng chữ cái ‘T’
Select * From tblVatTu Where TenVTu Like 'T%'
-- Câu 3. Hiện thông tin các vật tư có đơn giá trên 1 triệu
Select * From tblVatTu Where DonGia = 1000000
-- Câu 4. Hiện thông tin các nhà cung cấp có địa chỉ thuộc tỉnh Nghệ An
Select * From tblNhaCungCap Where DiaChi = N'Nghệ An'
-- Câu 5. Hiện các đơn đặt hàng trong ngày 20/02/2025
Select * From tblDONDH Where NgayDH = '2025-02-20'
-- Câu 6. Hiện thông tin các nhà cung cấp có đơn đặt hàng trong ngày hôm nay
Select * From tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC = dh.MaNCC
Where dh.NgayDH = CONVERT(DATE, GETDATE())
-- Câu 7. Cho biết thông tin Số phiếu nhập, mã vật tư, số lượng nhập, đơn giá nhập, thành tiền của từng mã vật tư 
Select SoPN, MaVTu, SoLuongNhap, DonGiaNhap, SoLuongNhap * DonGiaNhap ThanhTien From tblCTPNHAP
-- Câu 8. Cho biết thông tin sopn, tenvatu, slnhap, dgnhap, thanhtien của từng mavtu
Select n.SoPN, vt.TenVTu, cn.SoLuongNhap, cn.DonGiaNhap, cn.SoLuongNhap * cn.DonGiaNhap  ThanhTien
From tblPNHAP n join tblCTPNHAP cn on n.SoPN = cn.SoPN join tblVatTu vt on vt.MaVTu = cn.MaVTu

-- Câu 9. Cho biết thông tin sopn, ngaynhap, slgnhap, dgnhap, thanh tien của từng mavtu
Select n.SoPN, n.NgayNhap, cn.SoLuongNhap, cn.DonGiaNhap, cn.SoLuongNhap * cn.DonGiaNhap ThanhTien
From tblCTPNHAP cn join tblPNHAP n ON cn.SoPN = n.SoPN
-- Câu 10. Cho biết thông tin sopn, ngaynhap, tên vật tư, slnhap, dgnhap, thanh tien của từng mavtu trong tháng 01 năm 2025. 
Select pn.SoPN,pn.NgayNhap,vt.TenVTu,ctpn.SoLuongNhap,ctpn.DonGiaNhap,ctpn.DonGiaNhap * ctpn.SoLuongNhap ThanhTien
From tblVatTu vt join tblCTPNHAP ctpn on vt.MaVTu = ctpn.MaVTu join tblPNHAP pn on ctpn.SoPN=pn.SoPN
Where Convert(char(7),pn.NgayNhap) = '2025-01'
-- Câu 11. Hiện thông tin của nhà cung cấp có mã là ‘NCC01’ và ‘NCC02’
Select * From tblNhaCungCap WHERE MaNCC IN ('NCC01', 'NCC02')
-- Câu 12. Hiện thông tin sopx, mavtu, slgxuat, dgxuat, thanh tien của từng mavtu
Select SoPX, MaVTu, SoLuongXuat, DonGiaXuat, SoLuongXuat * DonGiaXuat ThanhTien From tblCTPXUAT
-- Câu 13. Cho biết thông tin sopx, tenvattu, slgxuat, dgxuat, thanh tien của từng mavtu.
Select PX.SoPX, VT.TenVTu, CTPX.SoLuongXuat, CTPX.DonGiaXuat, CTPX.SoLuongXuat * CTPX.DonGiaXuat ThanhTien
From tblCTPXUAT CTPX join tblPXUAT PX on CTPX.SoPX = PX.SoPX join tblVATTU VT on CTPX.MaVTu = VT.MaVTu;
-- Câu 14. Cho biết thông tin sopx, ngayxuat, mavtu, slgxuat, dgxuat, thanh tien của từng mavtu.
Select PX.SoPX, PX.NgayXuat, CTPX.MaVTu, CTPX.SoLuongXuat, CTPX.DonGiaXuat, CTPX.SoLuongXuat * CTPX.DonGiaXuat ThanhTien
From tblCTPXUAT CTPX JOIN tblPXUAT PX on CTPX.SoPX = PX.SoPX;
-- Câu 15. Cho biết thông tin sopx, ngayxuat, ten vật tư, slgxuat, dgxuat, thanh tien của từng mavtu từ ngày 15/01/2025 đến 03/02/2025.Yêu cầu ngày nhập có định dạng dd-mm yyyy
Select PX.SoPX, NgayXuat = CONVERT(char(10), PX.NgayXuat),VT.TenVTu, CTPX.SoLuongXuat, CTPX.DonGiaXuat, CTPX.SoLuongXuat * CTPX.DonGiaXuat AS ThanhTien
From tblCTPXUAT CTPX join tblPXUAT PX on CTPX.SoPX = PX.SoPX join tblVATTU VT on CTPX.MaVTu = VT.MaVTu
Where PX.NgayXuat BETWEEN '2025-01-15' AND '2025-02-19'
-- Câu 16. Xoá mã vật tư có dvtinh là ‘Cái’
DELETE From tblCTPNHAP Where MaVTu IN (Select MaVTu From tblVATTU Where DVTinh = N'Cái');
-- Câu 17. Đổi đơn vị tính của các vật tư từ kg sang kilogam (lệnh update)
UPDATE tblVATTU SET DVTinh = 'Kilogam'Where DVTinh = 'kg'
-- Câu 18. Hiển thị danh sách vật tư trong bảng VATTU, sắp xếp đơn giá giảm dần
Select * From tblVATTU order by DonGia DESC
-- Câu 19. Hiển thị danh sách các nhà cung cấp ở Nghệ An, sắp xếp họ tên nhà cung cấp tăng dần
Select * From tblNhaCungCap Where DiaChi LIKE N'%Nghệ An%' ORDER BY TenNCC
-- Câu 20. Hiển thị một vật tư có đơn giá lớn nhất
Select * From tblVatTu Where DonGia = (
Select Max(DonGia)From tblVatTu)