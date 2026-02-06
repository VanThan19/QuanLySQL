Use th03

--2.1. Hiện thị thông tin SoDH, MaVTu, SLDat, NgayDH, Manhacc của 2
--bảng tblCTDonDH và tblDonDH.
Create view b2_1 as
Select dh.SoDH,ctdh.MaVTu,SoLuongDat,NgayDH,ncc.MaNCC
From tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC = dh.MaNCC join tblChiTietDH ctdh on ctdh.SoDH = dh.SoDH
Select * From b2_1
--2.2. Hiện thị thông tin trong bảng DONDH và 2 cột địa chỉ, Tên nhà cung
--cấp trong bảng NHACC
Create view b2_2 as
Select ncc.DiaChi,ncc.TenNCC From tblDONDH dh join tblNhaCungCap ncc on dh.MaNCC = ncc.MaNCC
Select * From b2_2
--2.3. Hiện thông tin các đơn đặt hàng trong bảng DONDH và Họ tên nhà
--cung cấp trong bảng NHACC với yêu cầu sắp xếp theo mã nhà cung cấp
--tăng dần.
Create view b2_3 as
Select dh.*,ncc.TenNCC From tblDONDH dh join tblNhaCungCap ncc on dh.MaNCC = ncc.MaNCC
Select * From b2_3 order by MaNCC 
--2.4. Hiện thông tin Nhà cung cấp, số đặt hàng, tên vật tư, số lượng đặt
--hàng.
Create view b2_4 as
Select ncc.*,dh.SoDH, vt.TenVTu,ctdh.SoLuongDat
From tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC = dh.MaNCC join tblChiTietDH ctdh
on ctdh.SoDH = dh.SoDH join tblVatTu vt on vt.MaVTu = ctdh.MaVTu
Select * From b2_4
--2.5. Hiện thông tin Nhà cung cấp, số đặt hàng, tên vật tư, số lượng đặt
--hàng có số lượng đặt hàng >=A.
Create view b2_5 as
Select ncc.*,dh.SoDH, vt.TenVTu,ctdh.SoLuongDat
From tblNhaCungCap ncc join tblDONDH dh on ncc.MaNCC = dh.MaNCC join tblChiTietDH ctdh
on ctdh.SoDH = dh.SoDH join tblVatTu vt on vt.MaVTu = ctdh.MaVTu
Where ctdh.SoLuongDat >= 20
Select * From b2_5
--2.6. Hiện các phiếu nhập, tên vật tư, số lượng nhập theo ngày nhập hàng
--tăng dần.
Create view b2_6 as
Select ctpn.SoPN,vt.TenVTu,ctpn.SoLuongNhap,n.NgayNhap 
From tblCTPNHAP ctpn join tblPNHAP n on ctpn.SoPN = n.SoPN join tblVatTu vt on vt.MaVTu = ctpn.MaVTu
Select * From b2_6 order by NgayNhap 
--2.7. Hiện số lượng đặt hàng của các vật tư có đơn đặt hàng là N.
Create view b2_7 as
Select vt.TenVTu,ctdh.SoLuongDat From tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu
Where SoLuongDat = 55
Select * From b2_7
--2.8. Hiện số lượng đặt hàng của các vật tư có số lượng đặt hàng >=N
Create view b2_8 as
Select vt.TenVTu,ctdh.SoLuongDat From tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu where ctdh.SoLuongDat >= 15
Select * From b2_8
--2.9. Hiện số lượng xuất hàng của các vật tư có phiếu xuất là N.
Create view b2_9 as 
Select vt.TenVTu,ctpx.SoLuongXuat From tblCTPXUAT ctpx join tblVatTu vt on ctpx.MaVTu = vt.MaVTu where ctpx.SoLuongXuat = 100
Select * From b2_9
--2.10. Hiện số lượng xuất hàng của các vật tư có số lượng xuất hàng >=N
Create view b2_10 as
Select vt.TenVTu,ctpx.SoLuongXuat From tblCTPXUAT ctpx join tblVatTu vt on ctpx.MaVTu = vt.MaVTu where ctpx.SoLuongXuat >= 100
Select * From b2_10
--2.11. Hiện số lượng nhập hàng của các vật tư có đơn đặt hàng là N.
Create view b2_11 as
Select vt.TenVTu,ctn.SoLuongNhap From tblCTPNHAP ctn join tblVatTu vt on ctn.MaVTu = vt.MaVTu where ctn.SoLuongNhap = 100
Select * From b2_11
--2.12. Hiện số lượng nhập hàng của các vật tư có số lượng đặt hàng >=N
Create view b2_12 as
Select vt.TenVTu,ctn.SoLuongNhap From tblCTPNHAP ctn join tblVatTu vt on ctn.MaVTu = vt.MaVTu where ctn.SoLuongNhap >= 100
Select * From b2_12
--2.13. Hiện tổng số lượng đặt hàng của các vật tư.
Create view b2_13 as
Select vt.TenVTu,Sum(ctdh.SoLuongDat) [Tổng SL Đặt] From tblChiTietDH ctdh join tblVatTu vt on vt.MaVTu = ctdh.MaVTu 
group by vt.TenVTu
Select * From b2_13
--2.14. Hiện các vật tư có tổng lượng đặt hàng >=N.
Create view b2_14 as 
Select vt.TenVTu,Sum(ctdh.SoLuongDat) [Tổng SL Đặt] From tblChiTietDH ctdh join tblVatTu vt on vt.MaVTu = ctdh.MaVTu
Group by vt.TenVTu Having sum(ctdh.SoLuongDat) >= 5 
Select * From b2_14 
--2.15. Hiện tổng số lượng bán hàng của các vật tư.
Create view b2_15 as
Select vt.TenVTu,Sum(ctpx.SoLuongXuat) [Tổng SL Bán] From tblCTPXUAT ctpx join tblVatTu vt on ctpx.MaVTu = vt.MaVTu
Group by vt.TenVTu
Select * From b2_15
--2.16. Hiện tổng số lượng bán hàng của các vật tư có tên là Gạch và Ngói.
Create view b2_16 as 
Select vt.TenVTu,SUM(ctpx.SoLuongXuat) [Tổng SL Bán] From tblCTPXUAT ctpx join tblVatTu vt on ctpx.MaVTu = vt.MaVTu group by vt.TenVTu
having vt.TenVTu IN (N'Bút Tẩy',N'Đèn Học')
Select * From b2_16
--2.17. Thống kê tổng số lượng nhập hàng của các vật tư
Create view b2_17 as
Select vt.TenVTu,Sum(ctn.SoLuongNhap) [Tổng SL Nhập] From tblCTPNHAP ctn join tblVatTu vt on ctn.MaVTu = vt.MaVTu 
group by vt.TenVTu
Select * From b2_17
--2.18. Thống kê tổng số lượng nhập hàng của các vật tư có tên vật tư bắt
--đầu là S
Create view b2_18 as
Select vt.TenVTu,Sum(ctn.SoLuongNhap) [Tổng SL Nhập] From tblCTPNHAP ctn join tblVatTu vt on vt.MaVTu = ctn.MaVTu 
 Where vt.TenVTu Like 'S%' Group by vt.TenVTu
 Select * From b2_18 
--2.19. Thống kê mỗi vật tư có bao nhiêu số đơn hàng (SoDH)
Create view b2_19 as
Select vt.TenVTu, count(ctdh.SoLuongDat) [Số DH] From tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu
group by vt.TenVTu
Select * From b2_19 
--2.20. Hiện tổng số đơn hàng (SoDH) của các vật tư có tên vật tư là Gạch
--và Ngói
Create view b2_20 as 
Select vt.TenVTu,Sum(ctdh.SoLuongDat) [Tổng SDH] From tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu 
Where vt.TenVTu IN (N'Đèn Học',N'Giấy A4') group by vt.TenVTu
Select * From b2_20 
--2.21. Thống kê mỗi vật tư có bao nhiêu số nhập hàng (SoPN)
Create view b2_21 as
Select vt.TenVTu,count(ctn.SoPN) [Số PN]  From tblCTPNHAP ctn join tblVatTu vt on ctn.MaVTu = vt.MaVTu group by vt.TenVTu
Select * From b2_21 
--2.22. HIện tổng số phiếu nhập hàng (SoPN) của các tên vật tư có tổng số
--phiếu nhập hàng >=N
create view b2_22 as
Select vt.TenVTu,Sum(ctn.SoLuongNhap) [Tổng Số PN]  From tblCTPNHAP ctn join tblVatTu vt on ctn.MaVTu = vt.MaVTu 
group by vt.TenVTu having sum(ctn.SoLuongNhap) >= 10 
Select * From b2_22 
--2.23. Thống kê mỗi vật tư có bao nhiêu số phiếu xuất (SoPX)
Create view b2_23 as
Select vt.TenVTu,count(ctpx.SoPX) [Số PX] From tblCTPXUAT ctpx join tblVatTu vt on ctpx.MaVTu = vt.MaVTu group by vt.TenVTu
Select * From b2_23 
--2.24. Hiện tổng số phiếu xuất (SoPX)của các tên vật tên vật tư bắt đầu là S
Create view b2_24 as
Select vt.TenVTu,Sum(ctpx.SoLuongXuat) [Tổng Số PX] From tblCTPXUAT ctpx join tblVatTu vt on ctpx.MaVTu = vt.MaVTu
Where vt.TenVTu Like 'S%' group by vt.TenVTu
Select * From b2_24
-- 2.25. Thống kê tổng số đơn đặt hàng mà công ty đã đặt hàng theo từng
--nhà cung cấp và sắp xếp dữ liệu theo tổng số đơn đặt hàng tăng dần.
create view b2_25 as 
Select ncc.TenNCC,count(ctdh.SoLuongDat) [Tổng Số Đơn]
From tblDONDH dh join tblChiTietDH ctdh  on dh.SoDH=ctdh.SoDH join tblNhaCungCap ncc on dh.MaNCC = ncc.MaNCC group by ncc.TenNCC
Select * From b2_25 order by [Tổng Số Đơn]
--2.26. Bảng câu trên nhưng lọc những bản ghi có mã nhà cung cấp bắt đầu = ‘C’ và tổng số đơn đặt hàng >1
Create view b2_26 as
Select ncc.TenNCC,count(ctdh.SoLuongDat) [Tổng Số Đơn]
From tblDONDH dh join tblChiTietDH ctdh  on dh.SoDH=ctdh.SoDH join tblNhaCungCap ncc on dh.MaNCC = ncc.MaNCC
where ncc.MaNCC Like 'C%' group by ncc.TenNCC Having count(ctdh.SoLuongDat) >=1 

Select * From b2_26
-- 2.27. Tính tổng số lượng đặt hàng của các vật tư theo từng nhà cung cấp 
Create view b2_27 as
Select vt.TenVTu,ncc.TenNCC,Sum(ctdh.SoLuongDat) [Tổng số lượng DH]
From tblChiTietDH ctdh join tblDONDH dh on dh.SoDH = ctdh.SoDH
join tblNhaCungCap ncc on dh.MaNCC = ncc.MaNCC join tblVatTu vt on ctdh.MaVTu = vt.MaVTu
group by vt.TenVTu, ncc.TenNCC

Select * From b2_27 
--2.28. Tính tổng số lượng nhập hàng của các vật tư theo từng nhà cung
--cấp 
Create view b2_28 as
Select dh.MaNCC,Sum(ctn.SoLuongNhap) [Tổng SL Nhập] 
From tblCTPNHAP ctn join tblPNHAP n on ctn.SoPN = n.SoPN join tblDONDH dh on dh.SoDH = n.SoDH Group by dh.MaNCC

Select * From b2_28
--2.29. Tính tổng số lượng đặt, tổng số lượng nhập của các các vật tư theo
--các nhà cung cấp
Create view b2_29 as
Select dh.MaNCC, Sum(ctdh.SoLuongDat) [Tổng SL Đặt],Sum(ctn.SoLuongNhap) [Tổng SL Nhập] 
From tblChiTietDH ctdh join tblDONDH dh on ctdh.SoDH = dh.SoDH join tblPNHAP n on ctdh.SoDH = dh.SoDH
join tblCTPNHAP ctn on ctn.SoPN = n.SoPN group by dh.MaNCC

Select * From b2_29