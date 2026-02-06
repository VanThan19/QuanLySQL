use QLBanHangg

--3.1. Hiện các đơn đặt hàng trong ngày gần đây nhất
Select * from tblDONDH where NgayDH = (Select Max(NgayDH) From tblDONDH)
--3.2. Hiện SoDH, MaVTu có SLDat lớn nhất.
Select SoDH,MaVTu,SoLuongDat From tblChiTietDH Where SoLuongDat = (Select Max(SoLuongDat) From tblChiTietDH)
--3.3. Hiện SoDH, Tên vật tư có SLĐặt lớn nhất.
Select ctdh.SoDH,vt.TenVTu,ctdh.SoLuongDat From tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu
where SoLuongDat = (Select Max(SoLuongDat) From tblChiTietDH)
--3.4. Hiện SoDH, Tên nhà cung cấp, Tên Vật tư có số lượng đặt lớn nhất.
Select dh.SoDH,ncc.MaNCC,vt.TenVTu,ctdh.SoLuongDat From tblDONDH dh join tblNhaCungCap ncc on dh.MaNCC = ncc.MaNCC join tblChiTietDH ctdh on ctdh.SoDH = dh.SoDH
join tblVatTu vt on vt.MaVTu = ctdh.MaVTu Where ctdh.SoLuongDat = (Select Max(SoLuongDat) From tblChiTietDH)
--3.5. Hiện Tên vật tư có tổng sldat lớn nhất.
select MaVTu,Sum(SoLuongDat) TongDat into #b3_5 from tblChiTietDH group by MaVTu
Go 
Select vt.TenVTu,Sum(ctdh.SoLuongDat) [Tổng Đặt] From tblChiTietDH ctdh join tblVatTu vt on ctdh.MaVTu = vt.MaVTu
Group by vt.TenVTu having Sum(ctdh.SoLuongDat) = (Select Max(TongDat) From #b3_5)
Drop table #b3_7
--3.6. Hiện Tên nhà cung cấp có tổng số lượng đặt Tên Vật tư A lớn nhất.
select vt.MaVTu,Sum(SoLuongDat) TongDat into #b3_6 from tblChiTietDH ctdh join tblVatTu vt on vt.MaVTu = ctdh.MaVTu 
where vt.TenVTu = N'Đèn Học' group by vt.MaVTu
Go 
Select ncc.TenNCC,Sum(SoLuongDat) [Tổng Đặt],vt.TenVTu From tblDONDH dh join tblNhaCungCap ncc on dh.MaNCC = ncc.MaNCC join tblChiTietDH ctdh on ctdh.SoDH = dh.SoDH
join tblVatTu vt on vt.MaVTu = ctdh.MaVTu where vt.TenVTu = N'Đèn Học' Group by ncc.TenNCC,vt.TenVTu
Having Sum(SoLuongDat) = (Select Max(TongDat) From #b3_6)
Drop table #b3_6
--3.7. Hiện Tên vật tư có tổng số lượng nhập hàng lớn nhất.
Select MaVTu,Sum(SoLuongNhap) TongDat into #b3_7 From tblCTPNHAP Group by MaVTu
Go
Select vt.TenVTu,Sum(SoLuongNhap) [Tổng Nhập] From tblCTPNHAP pn join tblVatTu vt on pn.MaVTu = vt.MaVTu 
group by vt.TenVTu Having Sum(SoLuongNhap) = (Select Max(TongDat) From #b3_7)
--3.8. Hiện Tên vật tư có tổng số lượng bán hàng lớn nhất.
Select MaVTu,Sum(SoLuongXuat) TongXuat into #3_8 From tblCTPXUAT group by MaVTu
Go
Select vt.TenVTu,Sum(SoLuongXuat) [Tổng Xuất] From tblCTPXUAT px join tblVatTu vt on vt.MaVTu = px.MaVTu Group by vt.TenVTu
having Sum(SoLuongXuat) = (Select Max(TongXuat) From #3_8)
--3.9. Hiện họ tên nhà cung cấp, Điện thoại của bảng NHACC mà công ty đã
--có đơn đặt hàng trong tháng 01-2002
Select ncc.TenNCC,ncc.DiaChi,dh.NgayDH From tblDONDH dh join tblNhaCungCap ncc on ncc.MaNCC = dh.MaNCC
Where Convert(char(7),NgayDH,121) = '2025-01'
--3.10. Hiện danh sách các nhà cung cấp mà công ty chưa bao giờ đặt hàng. 
Select * From tblNhaCungCap Where MaNCC Not In (Select MaNCC From tblDONDH) 
--3.11. Hiện danh sách vật tư mà công ty chưa bao giờ đặt hàng.
Select * From tblVatTu Where MaVTu Not in (Select MaVTu From tblChiTietDH)
--3.12. Hiện danh sách các nhà cung cấp chưa nhập hàng mà ta đã đặt hàng
select distinct ncc.* from tblNhaCungCap ncc join tblDONDH dh on dh.MaNCC = ncc.MaNCC where dh.SoDH not in 
(Select SoDH from tblPNHAP)
--3.13. Hiện danh sách các nhà cung cấp và số đặt hàng chưa nhập hàng mà ta
--đã đặt hàng
select distinct ncc.MaNCC,ncc.TenNCC,count(dh.SoDH) [số đặt hàng] from tblNhaCungCap ncc join tblDONDH dh on dh.MaNCC = ncc.MaNCC
where dh.SoDH not in (Select SoDH from tblPNHAP) group by ncc.MaNCC, ncc.TenNCC
--3.14. Hiện danh sách các nhà cung cấp, số đặt hàng, tên vật tư chưa nhập
--hàng đủ so với đơn đặt hàng
Select ncc.MaNCC,Sum(ctdh.SoLuongDat) [TSoDat],Sum(ctpn.SoLuongNhap) [TSoNhap]
From tblDONDH dh join tblNhaCungCap ncc on ncc.MaNCC = dh.MaNCC join tblChiTietDH ctdh on ctdh.SoDH = dh.SoDH
Join tblCTPNHAP ctpn on ctpn.MaVTu = ctdh.MaVTu
Group by ncc.MaNCC
having Sum(ctdh.SoLuongDat) > Sum(ctpn.SoLuongNhap)
--3.15. Hiện danh sách các nhà cung cấp, số đặt hàng, tên vật tư chưa nhập
--hàng đủ so với đơn đặt hàng và số lượng còn thiếu
Select ncc.MaNCC,ctdh.SoDH,vt.TenVTu,Sum(ctdh.SoLuongDat) [TSoDat],Sum(ctpn.SoLuongNhap) [TSoNhap],
(Sum(ctdh.SoLuongDat)-Sum(ctpn.SoLuongNhap)) [Số Lượng Thiếu]
From tblDONDH dh join tblNhaCungCap ncc on ncc.MaNCC = dh.MaNCC join tblChiTietDH ctdh on ctdh.SoDH = dh.SoDH
Join tblCTPNHAP ctpn on ctpn.MaVTu = ctdh.MaVTu join tblVatTu vt on vt.MaVTu = ctdh.MaVTu
Group by ncc.MaNCC,ctdh.SoDH,vt.TenVTu
having Sum(ctdh.SoLuongDat) > Sum(ctpn.SoLuongNhap)

