create database QuanLyBanHang
use QuanLyBanHang 

CREATE TABLE KhachHang (
    MaKH INT PRIMARY KEY IDENTITY(1,1),
    HoTen NVARCHAR(100),
    SoDienThoai VARCHAR(15),
    DiaChi NVARCHAR(255),
    Email VARCHAR(100)
);

CREATE TABLE SanPham (
    MaSP INT PRIMARY KEY IDENTITY(1,1),
    TenSP NVARCHAR(100),
    DonGia DECIMAL(18, 2),
    SoLuong INT,
    MoTa NVARCHAR(255),
    MaLoai INT
);

CREATE TABLE LoaiSanPham (
    MaLoai INT PRIMARY KEY IDENTITY(1,1),
    TenLoai NVARCHAR(100)
);

CREATE TABLE NhanVien (
    MaNV INT PRIMARY KEY IDENTITY(1,1),
    HoTen NVARCHAR(100),
    SoDienThoai VARCHAR(15),
    Email VARCHAR(100),
    ChucVu NVARCHAR(50)
);

CREATE TABLE HoaDon (
    MaHD INT PRIMARY KEY IDENTITY(1,1),
    NgayLap DATE,
    MaKH INT,
    MaNV INT,
    TongTien DECIMAL(18, 2),

    FOREIGN KEY (MaKH) REFERENCES KhachHang(MaKH),
    FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV)
);

CREATE TABLE ChiTietHoaDon (
    MaHD INT,
    MaSP INT,
    SoLuong INT,
    DonGia DECIMAL(18, 2),
    ThanhTien AS (SoLuong * DonGia) PERSISTED,

    PRIMARY KEY (MaHD, MaSP),
    FOREIGN KEY (MaHD) REFERENCES HoaDon(MaHD),
    FOREIGN KEY (MaSP) REFERENCES SanPham(MaSP)
);

INSERT INTO SanPham (TenSP, DonGia, SoLuong, MoTa, MaLoai)
VALUES
    (N'iPhone 15 Pro', 29990000, 10, N'Bản 128GB, màu đen', 1),
    (N'Samsung Galaxy S24', 24990000, 8, N'Bản 256GB, màu trắng', 1),
    (N'MacBook Air M2', 28990000, 5, N'Màn 13 inch, RAM 8GB', 2),
    (N'Dell XPS 13', 25990000, 4, N'Intel i7, SSD 512GB', 2),
    (N'Chuột Logitech M185', 250000, 50, N'Chuột không dây', 3),
    (N'Máy in HP LaserJet 107a', 2150000, 3, N'Máy in đen trắng', 4);

INSERT INTO KhachHang (HoTen, SoDienThoai, DiaChi, Email)
VALUES
    (N'Nguyễn Văn A', '0909123456', N'123 Trần Hưng Đạo, Q1', 'a.nguyen@gmail.com'),
    (N'Lê Thị B', '0934567890', N'456 Lê Văn Sỹ, Q3', 'b.le@gmail.com'),
    (N'Trần Văn C', '0911222333', N'789 Cách Mạng Tháng 8, Q10', 'c.tran@gmail.com');

INSERT INTO LoaiSanPham (TenLoai)
VALUES
    (N'Điện thoại'),
    (N'Máy tính'),
    (N'Phụ kiện'),
    (N'Thiết bị văn phòng');

INSERT INTO NhanVien (HoTen, SoDienThoai, Email, ChucVu)
VALUES
    (N'Ngô Minh Dũng', '0987654321', 'dung.nm@gmail.com', N'Nhân viên bán hàng'),
    (N'Phạm Thị Hằng', '0977888999', 'hang.pt@gmail.com', N'Quản lý');

INSERT INTO HoaDon (NgayLap, MaKH, MaNV, TongTien)
VALUES
    ('2025-04-10', 1, 1, 30240000),
    ('2025-04-11', 2, 2, 29000000);

INSERT INTO ChiTietHoaDon (MaHD, MaSP, SoLuong, DonGia)
VALUES
    (1, 1, 1, 29990000),
    (1, 5, 1, 250000),
    (2, 3, 1, 28990000),
    (2, 5, 2, 250000);
