-- Câu 1. Hiện thông tin Mã Vật tư, Tên vật tư, Đơn giá.
Select MaVTu,TenVTu,DonGia from tblVatTu
-- Câu 2. Hiện thông tin các vật tư có tên bắt đầu bằng chữ cái ‘T’
Select * From tblVatTu Where TenVTu Like 'T%'
-- Câu 3. Hiện thông tin các vật tư có đơn giá trên 1 triệu
Select * From tblVatTu Where DonGia > 1000000
-- Câu 4. Hiện thông tin các nhà cung cấp có địa chỉ thuộc tỉnh Nghệ An
Select * From tblNhaCungCap Where DiaChi = N'Nghệ An'
-- Câu 5. Hiện các đơn đặt hàng trong ngày 20/02/2025
Select * From tblDONDH Where NgayDH = '2025-02-20'
-- Câu 6. Hiện thông tin các nhà cung cấp có đơn đặt hàng trong ngày hôm nay
Select * From tblDONDH dh join tblNhaCungCap ncc on dh.MaNCC = ncc.MaNCC
Where NgayDH = Convert(date,getDate())
-- Câu 7. Cho biết thông tin Số phiếu nhập, mã vật tư, số lượng nhập, đơn giá nhập, thành tiền của từng mã vật tư 
Select ctpn.SoPN,vt.MaVTu,ctpn.SoLuongNhap,ctpn.DonGiaNhap,ctpn.DonGiaNhap*ctpn.SoLuongNhap [Thành Tiền]
From tblCTPNHAP ctpn join tblVatTu vt on vt.MaVTu = ctpn.MaVTu
-- Câu 8. Cho biết thông tin sopn, tenvatu, slnhap, dgnhap, thanhtien của từng mavtu
Select n.SoPN, vt.TenVTu, cn.SoLuongNhap, cn.DonGiaNhap, cn.SoLuongNhap * cn.DonGiaNhap  ThanhTien
From tblPNHAP n join tblCTPNHAP cn on n.SoPN = cn.SoPN join tblVatTu vt on vt.MaVTu = cn.MaVTu
-- Câu 9. Cho biết thông tin sopn, ngaynhap, slgnhap, dgnhap, thanh tien của từng mavtu
Select n.SoPN,n.NgayNhap,ctpn.SoLuongNhap,ctpn.DonGiaNhap,ctpn.DonGiaNhap*ctpn.SoLuongNhap [Thành Tiền]
From tblPNHAP n join tblCTPNHAP ctpn on n.SoPN = ctpn.SoPN join tblVatTu vt on vt.MaVTu = ctpn.MaVTu
-- Câu 10. Cho biết thông tin sopn, ngaynhap, tên vật tư, slnhap, dgnhap, thanh tien của từng mavtu trong tháng 01 năm 2025. 
Select n.SoPN,n.NgayNhap,vt.TenVTu,ctpn.SoLuongNhap,ctpn.DonGiaNhap,ctpn.DonGiaNhap*ctpn.SoLuongNhap [Thành Tiền]
From tblPNHAP n join tblCTPNHAP ctpn on n.SoPN=ctpn.SoPN join tblVatTu vt on vt.MaVTu = ctpn.MaVTu
Where Convert (char(7),n.NgayNhap) = '2025-01'
-- Câu 11. Hiện thông tin của nhà cung cấp có mã là ‘NCC01’ và ‘NCC02’
Select * From tblNhaCungCap WHERE MaNCC IN ('NCC01', 'NCC02')
-- Câu 12. Hiện thông tin sopx, mavtu, slgxuat, dgxuat, thanh tien của từng mavtu
Select ctpx.SoPX,vt.MaVTu,ctpx.SoLuongXuat,ctpx.DonGiaXuat,ctpx.DonGiaXuat*ctpx.SoLuongXuat [Thành Tiền]
From tblCTPXUAT ctpx join tblVatTu vt on ctpx.MaVTu = vt.MaVTu
-- Câu 13. Cho biết thông tin sopx, tenvattu, slgxuat, dgxuat, thanh tien của từng mavtu.
Select px.SoPX,vt.TenVTu,ctpx.SoLuongXuat,ctpx.DonGiaXuat,ctpx.DonGiaXuat*ctpx.SoLuongXuat [Thành Tiền]
From tblPXUAT px join tblCTPXUAT ctpx on px.SoPX = ctpx.SoPX join tblVatTu vt on vt.MaVTu = ctpx.MaVTu
-- Câu 14. Cho biết thông tin sopx, ngayxuat, mavtu, slgxuat, dgxuat, thanh tien của từng mavtu.
Select px.SoPX,px.NgayXuat,vt.MaVTu,ctpx.SoLuongXuat,ctpx.DonGiaXuat,ctpx.DonGiaXuat*ctpx.SoLuongXuat [Thành Tiền] 
From tblPXUAT px join tblCTPXUAT ctpx on px.SoPX = ctpx.SoPX join tblVatTu vt on vt.MaVTu = ctpx.MaVTu
-- Câu 15. Cho biết thông tin sopx, ngayxuat, ten vật tư, slgxuat, dgxuat, thanh tien của từng mavtu từ ngày 15/01/2025 
-- đến 03/02/2025.Yêu cầu ngày nhập có định dạng dd-mm yyyy
Select PX.SoPX, NgayXuat = CONVERT(char(10), PX.NgayXuat),VT.TenVTu, CTPX.SoLuongXuat, CTPX.DonGiaXuat, CTPX.SoLuongXuat * CTPX.DonGiaXuat AS ThanhTien
From tblCTPXUAT CTPX join tblPXUAT PX on CTPX.SoPX = PX.SoPX join tblVATTU VT on CTPX.MaVTu = VT.MaVTu
Where PX.NgayXuat BETWEEN '2025-01-15' AND '2025-02-19'
-- Câu 16. Xoá mã vật tư có dvtinh là ‘Cái’
Delete tblCTPNHAP Where MaVTu IN (Select MaVTu From tblVatTu Where DVTinh = N'Cái')
-- Câu 17. Đổi đơn vị tính của các vật tư từ kg sang kilogam (lệnh update)
Update tblVatTu Set DVTinh = N'Cái' Where DVTinh = N'Đôi'
Select * From tblVatTu
-- Câu 18. Hiển thị danh sách vật tư trong bảng VATTU, sắp xếp đơn giá giảm dần
Select * From tblVatTu order by DonGia DESC 
-- Câu 19. Hiển thị danh sách các nhà cung cấp ở Nghệ An, sắp xếp họ tên nhà cung cấp tăng dần
Select * From tblNhaCungCap order by TenNCC 
-- Câu 20. Hiển thị một vật tư có đơn giá lớn nhất
Select TenVTu, DonGia From tblVatTu Where DonGia = (
Select Max(DonGia) From tblVatTu)
