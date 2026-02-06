CREATE DATABASE AI4DB;
use AI4DB;
CREATE TABLE GiangVien (
    magv INT PRIMARY KEY,
    hotengv CHAR(30),
    bomon CHAR(50)
);
CREATE TABLE SinhVien (
    masv INT PRIMARY KEY,
    hotensv CHAR(30),
    namsinh INT,
    quequan CHAR(30)
);
CREATE TABLE DeTai (
    madt CHAR(10) PRIMARY KEY,
    tendt CHAR(30),
    kinhphi DECIMAL(10, 2)
);
 
CREATE TABLE HuongDan (
    masv INT foreign key references sinhVien(maSv),
    madt CHAR(10) foreign key references deTai(madt),
    magv INT foreign key references giangVien(magv) ,
    ketqua DECIMAL(5, 2)
--    PRIMARY KEY (masv, madt, magv),
--    FOREIGN KEY (masv) REFERENCES SinhVien(masv),
--   FOREIGN KEY (madt) REFERENCES DeTai(madt),
--    FOREIGN KEY (magv) REFERENCES GiangVien(magv)
);

INSERT INTO GiangVien (magv, hotengv, bomon) VALUES
(101, 'Nguyen Van A', 'Cong nghe thong tin'),
(102, 'Tran Thi B', 'Khoa hoc may tinh'),
(103, 'Le Van C', 'Khoa hoc du lieu'),
(104, 'Pham Thi D', 'Ky thuat phan mem'),
(105, 'Do Van E', 'Tri tue nhan tao');

INSERT INTO SinhVien (masv, hotensv, namsinh, quequan) VALUES
(201, 'Nguyen Van K', 2000, 'Ha Noi'),
(202, 'Tran Thi L', 1999, 'Hai Phong'),
(203, 'Le Van M', 2001, 'Da Nang'),
(204, 'Pham Thi N', 2000, 'Hue'),
(205, 'Do Van O', 1998, 'Ho Chi Minh');

INSERT INTO DeTai (madt, tendt, kinhphi) VALUES
('DT01', 'Phan mem quan ly', 5000.00),
('DT02', 'Tri tue nhan tao', 8000.00),
('DT03', 'Phan tich du lieu', 6500.00),
('DT04', 'Ung dung IOT', 7000.00),
('DT05', 'Hoc sau may', 10000.00);

INSERT INTO HuongDan (masv, madt, magv, ketqua) VALUES
(201, 'DT01', 101, 8.5),  -- Giảng viên 101 hướng dẫn SV 201
(202, 'DT02', 102, 9.0),  -- Giảng viên 102 hướng dẫn SV 202
(203, 'DT03', 103, 7.8),  -- Giảng viên 103 hướng dẫn SV 203
(204, 'DT01', 102, 8.2);  -- Giảng viên 102 hướng dẫn SV 204, nhưng cho đề tài DT01
INSERT INTO HuongDan (masv, madt, magv, ketqua)
VALUES (205, 'DT03', 103, NULL);

select *from GiangVien
select *from sinhVien 
select *from DeTai
select *from HuongDan