CREATE DATABASE ThucTap;
USE ThucTap;
CREATE TABLE TBLKhoa
(Makhoa char(10)primary key, Tenkhoa char(30),
Dienthoai char(10));
CREATE TABLE TBLGiangVien(
Magv int primary key, Hotengv char(30), Luong decimal(5,2),
Makhoa char(10) references TBLKhoa);
CREATE TABLE TBLSinhVien(
Masv int primary key, Hotensv char(40),
Makhoa char(10)foreign key references TBLKhoa, Namsinh int,
Quequan char(30));
CREATE TABLE TBLDeTai(
Madt char(10)primary key, Tendt char(30),
Kinhphi int, Noithuctap char(30));
CREATE TABLE TBLHuongDan(
Masv int primary key,
Madt char(10)foreign key references TBLDeTai, Magv int foreign key references TBLGiangVien, KetQua decimal(5,2));
INSERT INTO TBLKhoa VALUES ('Geo','Dia ly va QLTN',3855413), ('Math','Toan',3855411),
('Bio','Cong nghe Sinh hoc',3855412);
INSERT INTO TBLGiangVien VALUES
(11,'Thanh Binh',700,'Geo'),

(12,'Thu Huong',500,'Math'),
(13,'Chu Vinh',650,'Geo'),
(14,'Le Thi Ly',500,'Bio'),
(15,'Tran Son',900,'Math');
INSERT INTO TBLSinhVien VALUES
(1,'Le Van Son','Bio',1990,'Nghe An'),
(2,'Nguyen Thi Mai','Geo',1990,'Thanh Hoa'),
(3,'Bui Xuan Duc','Math',1992,'Ha Noi'),
(4,'Nguyen Van Tung','Bio',null,'Ha Tinh'),
(5,'Le Khanh Linh','Bio',1989,'Ha Nam'),
(6,'Tran Khac Trong','Geo',1991,'Thanh Hoa'),
(7,'Le Thi Van','Math',null,'null'),
(8,'Hoang Van Duc','Bio',1992,'Nghe An');
INSERT INTO TBLDeTai VALUES ('Dt01','GIS',100,'Nghe An'),
('Dt02','ARC GIS',500,'Nam Dinh'),
('Dt03','Spatial DB',100, 'Ha Tinh'),
('Dt04','MAP',300,'Quang Binh' );
INSERT INTO TBLHuongDan VALUES (1,'Dt01',13,8),
(2,'Dt03',14,0),
(3,'Dt03',12,10),
(5,'Dt04',14,7),
(6,'Dt01',13,Null),
(7,'Dt04',11,10),
(8,'Dt03',15,6);

-- 1. Đưa ra thông tin gồm mã số, họ tênvà tên khoa của tất cả các giảng viên
Select g.Magv,g.Hotengv,k.Tenkhoa from TBLGiangVien g join TBLKhoa k on g.Makhoa = k.Makhoa
-- 2. Đưa ra thông tin gồm mã số, họ tênvà tên khoa của các giảng viên của khoa ‘DIA LY & QLTN’
Select g.Magv,g.Hotengv,k.Tenkhoa from TBLGiangVien g join TBLKhoa k on g.Makhoa = k.Makhoa where k.Tenkhoa = 'DIA LY va QLTN' 
-- 3. Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’
select count(s.Masv) soLuong from TBLSinhVien s join TBLKhoa k on s.Makhoa = k.Makhoa where k.Tenkhoa = 'Cong nghe sinh hoc'
-- 4. Đưa ra danh sách gồm mã số, họ tênvà tuổi của các sinh viên khoa ‘TOAN’
select s.Masv,s.Hotensv,Year(GETDATE())-Namsinh TuoiLon from TBLSinhVien s join TBLKhoa k on s.Makhoa = k.Makhoa 
-- 5. Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’
Select count(g.Magv) soLuong from TBLGiangVien g join TBLKhoa k on g.Makhoa = k.Makhoa where k.Tenkhoa = 'Cong nghe sinh hoc'
-- 6. Cho biết thông tin về sinh viên không tham gia thực tập
select * from TBLSinhVien s left join TBLHuongDan h on s.Masv = h.Masv where h.Masv is null
select * from TBLSinhVien s where s.Masv not in (select Masv from TBLHuongDan)
-- 7. Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
select k.Makhoa,k.Tenkhoa,sum(g.Magv) soLuong from TBLGiangVien g join TBLKhoa k on g.Makhoa = k.Makhoa group by k.Makhoa,k.Tenkhoa
-- 8. Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học
select k.Dienthoai from TBLKhoa k join TBLSinhVien s on k.Makhoa = s.Makhoa where s.Hotensv LIKE '%Le Van Son%'
-- 9.Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn
select d.Madt,d.Tendt from TBLDeTai d join TBLHuongDan h on d.Madt = h.Madt join TBLGiangVien g on h.Magv = g.Magv 
where g.Hotengv LIKE '%Tran Son%'
-- 10. Cho biết tên đề tài không có sinh viên nào thực tập
select * from TBLDeTai d where d.Madt not in (select Madt from TBLHuongDan)
-- 11.Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên trở lên.
select a.Magv,a.Hotengv,d.Tenkhoa from TBLGiangVien a
join TBLHuongDan b on a.Magv=b.Magv
join TBLSinhVien c on b.Masv=c.Masv
join TBLKhoa d on a.Makhoa=d.Makhoa
group by a.Magv,a.Hotengv,d.Tenkhoa
having count(b.Masv)>3
--12.	Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất
select Madt,Tendt from TBLDeTai
where Kinhphi=(select max(kinhphi) from TBLDeTai)

select Madt,Tendt from TBLDeTai where kinhPhi >= ALL (Select kinhPhi from TBLDeTai)

--13.	Cho biết mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
select a.Madt,a.Tendt from TBLDeTai a
join TBLHuongDan b on a.Madt=b.Madt
join TBLSinhVien c on b.Masv=c.Masv
group by a.Madt,a.Tendt
having count(b.Madt)>2
--14.	Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’
select a.Masv,a.Hotensv,b.KetQua from TBLSinhVien a
join TBLHuongDan b on a.Masv=b.Masv
join TBLKhoa c on a.Makhoa=c.Makhoa
where c.Tenkhoa='dia ly va qltn'
-- 15.Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
select k.Tenkhoa, count(s.Masv) soLuong from TBLKhoa k join TBLSinhVien s on k.Makhoa = s.Makhoa group by k.Tenkhoa
-- 16.Cho biết thông tin về các sinh viên thực tập tại quê nhà
select * from TBLSinhVien s join TBLHuongDan h on s.Masv = h.Masv join TBLDeTai d on d.Madt = h.Madt
where s.Quequan = d.Noithuctap
-- 17. Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
select * from TBLSinhVien s left join TBLHuongDan h on s.Masv = h.Masv where h.Masv is NULL 
select * from TBLSinhVien s where s.Masv not in (select maSv from TBLHuongDan)
-- 18.Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng 0
select * from TBLSinhVien s join TBLHuongDan h on s.Masv = h.Masv where h.KetQua = 0.0 
-- 19.Nhận xét về hai câu truy vấn sau: 
SELECT * FROM TBLHuongDan; -- in hết tất cả điểm kể cả NULL 
SELECT * FROM TBLHuongDan WHERE ketqua>5 or ketqua<=5; -- in điểm nằm trong điều kiện >5 hoặc <=5 
-- 20.Tạo một bảng mới có tên HocTap với cấu trúc tương tự bảng GiangVien.
CREATE TABLE TBLHocTap (
    Magv int PRIMARY KEY,
    Hotengv char(30),
    Luong decimal(5,2),
    Makhoa char(10) REFERENCES TBLKhoa
);
-- 21.Nhập dữ liệu cho bảng HocTap. Yêu cầu dữ liệu được lấy từ bảng GiangVien, chỉ lấy các giảng viên có mã số từ 11 đến 14, và 
-- sử dụng lệnh INSERT INTO <tên_bảng> SELECT <tên_cột> FROM <tên_bảng> WHERE <điều_kiện>.
INSERT INTO TBLHocTap (Magv, Hotengv, Luong, Makhoa)
SELECT Magv, Hotengv, Luong, Makhoa
FROM TBLGiangVien
WHERE Magv BETWEEN 11 AND 14;
-- 22.Thêm cột TienHoc với kiểu dữ liệu decimal(10,2) vào bảng HocTap. Cột TienHoc này được dùng để nhập tiền học, và có giá trị từ
-- 0 đến 100. Nếu có giá trị 0, nghĩa là giảng viên đó không phải nạp tiền học.
ALTER TABLE TBLHocTap
ADD TienHoc decimal(10,2) CHECK (TienHoc BETWEEN 0 AND 100) DEFAULT 0;
select * from TBLHocTap
UPDATE TBLHocTap
SET TienHoc = 50.00
WHERE Magv = 11;

UPDATE TBLHocTap
SET TienHoc = 30.00
WHERE Magv = 12;

UPDATE TBLHocTap
SET TienHoc = 70.00
WHERE Magv = 13;

UPDATE TBLHocTap
SET TienHoc = 0.00  -- Giảng viên này không phải đóng tiền học
WHERE Magv = 14;
-- 23.Đưa ra mã số, họ tên các giảng viên hoặc phải đóng tiền học hoặc có lương nhỏ hơn 600.
select Magv,Hotengv from TBLHocTap t where t.Luong < 600 or t.TienHoc > 0 
-- 24.Đưa ra mã số, họ tên các giảng viên vừa phải đóng tiền học vừa có lương nhỏ hơn 600.
select Magv,Hotengv from TBLHocTap t where t.Luong < 600 and t.TienHoc > 0
-- 25.Đưa ra mã số, họ tên các giảng viên không tham gia khóa học có lương nhỏ hơn 1 000 000.
select Magv,Hotengv from TBLHocTap t where t.Luong < 1000000 and tienHoc = 0 