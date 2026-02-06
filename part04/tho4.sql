use QLBanHangg

-- 3. Truy vấn con
--3.1. Hiện các đơn đặt hàng trong ngày gần đây nhất
Select * From tblDONDH Where NgayDH = (
Select MAX(NgayDH) From tblDONDH)
--3.2. Hiện SoDH, MaVTu có SLDat lớn nhất.
Select SoDH,MaVTu,SoLuongDat From tblChiTietDH where SoLuongDat = 
( Select Max(SoLuongDat) From tblChiTietDH)
--3.3. Hiện SoDH, Tên vật tư có SLĐặt lớn nhất.
Select ctdh.SoDH,vt.TenVTu From tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu
where ctdh.SoLuongDat = ( Select Max(SoLuongDat) From tblChiTietDH)
--3.4. Hiện SoDH, Tên nhà cung cấp, Tên Vật tư có số lượng đặt lớn nhất.
Select dh.SoDH,ncc.TenNCC,vt.TenVTu 
From tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu join tblDONDH dh on ctdh.SoDH = dh.SoDH
join tblNhaCungCap ncc on ncc.MaNCC = dh.MaNCC Where ctdh.SoLuongDat = ( Select Max(SoLuongDat) From tblChiTietDH)
--3.5. Hiện Tên vật tư có tổng sldat lớn nhất.
Select MaVTu,Sum(SoLuongDat) TongDat into #t From tblChiTietDH group by MaVTu 
Go
Select vt.TenVTu,Sum(SoLuongDat) [Tổng Đặt] From tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu group by vt.TenVTu
Having Sum(SoLuongDat) = (Select Max(TongDat) from #t)
Drop table #t 
--3.6. Hiện Tên nhà cung cấp có tổng số lượng đặt Tên Vật tư A lớn nhất.
Select MaVTu,Sum(SoLuongDat) TongDat into #h From tblChiTietDH group by MaVTu
Go
Select ncc.TenNCC,Sum(SoLuongDat) [Tổng Đặt] 
From tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu join tblDONDH dh on ctdh.SoDH = dh.SoDH
join tblNhaCungCap ncc on ncc.MaNCC = dh.MaNCC group by ncc.TenNCC having Sum(SoLuongDat) = (Select Max(TongDat) from #h)
--3.7. Hiện Tên vật tư có tổng số lượng nhập hàng lớn nhất.
Select MaVTu,Sum(SoLuongNhap) SLNhap into #p From tblCTPNHAP group by MaVTu
Go
Select vt.TenVTu,Sum(SoLuongNhap) [Tổng Số Lượng Nhập] From tblCTPNHAP ctpn join tblVatTu vt on ctpn.MaVTu = vt.MaVTu
group by vt.TenVTu having Sum(SoLuongNhap) = (Select Max(SLNhap) from #p)
--3.8. Hiện Tên vật tư có tổng số lượng bán hàng lớn nhất.
Select MaVTu,Sum(SoLuongXuat) TongXuat into #k from tblCTPXUAT group by MaVTu 
Go
select vt.TenVTu,Sum(SoLuongXuat) [Tổng Số Lượng Xuất]  from tblCTPXUAT ctpx join tblVatTu vt on ctpx.MaVTu = vt.MaVTu
Group by vt.TenVTu having Sum(SoLuongXuat) = (Select Max(TongXuat) from #k) 
--3.9. Hiện họ tên nhà cung cấp, Điện thoại của bảng NHACC mà công ty đã
--có đơn đặt hàng trong tháng 01-2025
Select ncc.TenNCC,ncc.Sdt,dh.SoDH From tblDONDH dh join tblNhaCungCap ncc on ncc.MaNCC = dh.MaNCC 
Where Convert (char(7),NgayDH,121) = '2025-01'
Select * from tblDONDH
--3.10. Hiện danh sách các nhà cung cấp mà công ty chưa bao giờ đặt hàng. 
Select * From tblNhaCungCap ncc where ncc.MaNCC Not In 
(Select MaNCC From tblDONDH)
--3.11. Hiện danh sách vật tư mà công ty chưa bao giờ đặt hàng. 
Select * From tblVatTu where MaVTu not in (Select MaVTu from tblChiTietDH)
--3.12. Hiện danh sách các nhà cung cấp chưa nhập hàng mà ta đã đặt hàng
select distinct ncc.* from tblNhaCungCap ncc join tblDONDH dh on dh.MaNCC = ncc.MaNCC where dh.SoDH not in 
(Select SoDH from tblPNHAP)
--3.13. Hiện danh sách các nhà cung cấp và số đặt hàng chưa nhập hàng mà ta
--đã đặt hàng
select distinct ncc.MaNCC,ncc.TenNCC,count(dh.SoDH) [số đặt hàng] from tblNhaCungCap ncc join tblDONDH dh on dh.MaNCC = ncc.MaNCC
where dh.SoDH not in (Select SoDH from tblPNHAP) group by ncc.MaNCC, ncc.TenNCC
--3.14. Hiện danh sách các nhà cung cấp, số đặt hàng, tên vật tư chưa nhập
--hàng đủ so với đơn đặt hàng
Select ncc.MaNCC,ncc.TenNCC,dh.SoDH,vt.TenVTu,ctdh.SoLuongDat
From tblDONDH dh join tblNhaCungCap ncc on ncc.MaNCC = dh.MaNCC
join tblChiTietDH ctdh on ctdh.SoDH = dh.SoDH join tblVatTu vt on ctdh.MaVTu = vt.MaVTu
Where ctdh.SoLuongDat Not In (Select Sum(pn.SoLuongNhap) from tblCTPNHAP pn ) group by ncc.MaNCC,ncc.TenNCC,dh.SoDH,vt.TenVTu,ctdh.SoLuongDat
--3.15. Hiện danh sách các nhà cung cấp, số đặt hàng, tên vật tư chưa nhập
--hàng đủ so với đơn đặt hàng và số lượng còn thiếu