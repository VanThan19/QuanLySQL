use QLBanHangg

--2.1. Hiện thông tin Nhà cung cấp, số đặt hàng, tên vật tư, số lượng đặt hàng.
Declare csNhaCungCap cursor for 
Select ncc.MaNCC,dh.SoDH,vt.TenVTu,ct.SoLuongDat
from tblNhaCungCap ncc join tblDONDH dh on dh.MaNCC = ncc.MaNCC join tblChiTietDH ct on ct.SoDH = dh.SoDH
join tblVatTu vt on vt.MaVTu = ct.MaVTu
Open csNhaCungCap 
While 1=1 
begin 
Declare @MaNCC char(5), @SoDH char(5),@TenVTu nvarchar(255),@SoLuongDat int 
Fetch next from csNhaCungCap into @MaNCC,@SoDH,@TenVTu,@SoLuongDat
if @@FETCH_STATUS != 0 break
print @MaNCC+'|'+@SoDH+'|'+@TenVTu+'|'+str(@SoLuongDat)
end 
close csNhaCungCap 
Deallocate csNhaCungCap 
--2.2. Hiện thông tin Nhà cung cấp, số đặt hàng, tên vật tư, số lượng đặt hàng
--có số lượng đặt hàng >=A.
Declare csNhaCungCap cursor for 
Select ncc.MaNCC,dh.SoDH,vt.TenVTu,ct.SoLuongDat
from tblNhaCungCap ncc join tblDONDH dh on dh.MaNCC = ncc.MaNCC join tblChiTietDH ct on ct.SoDH = dh.SoDH
join tblVatTu vt on vt.MaVTu = ct.MaVTu Where ct.SoLuongDat >= 50 
Open csNhaCungCap 
While 1=1 
begin 
Declare @MaNCC char(5), @SoDH char(5),@TenVTu nvarchar(255),@SoLuongDat int 
Fetch next from csNhaCungCap into @MaNCC,@SoDH,@TenVTu,@SoLuongDat
if @@FETCH_STATUS != 0 break
print @MaNCC+'|'+@SoDH+'|'+@TenVTu+'|'+str(@SoLuongDat)
end 
close csNhaCungCap 
Deallocate csNhaCungCap 
--2.3. Hiện các phiếu nhập, tên vật tư, số lượng nhập theo ngày nhập hàng
--tăng dần.
Declare csPhieuNhap cursor for 
Select n.SoPN,vt.TenVTu,ctpn.SoLuongNhap,n.NgayNhap
from tblCTPNHAP ctpn join tblVatTu vt on ctpn.MaVTu = vt.MaVTu join tblPNHAP n on n.SoPN = ctpn.SoPN order by n.NgayNhap
Open csPhieuNhap
While 1=1 
begin 
Declare @SoPN char(5),@TenVTu nvarchar(25),@SoLuongNhap int,@NgayNhap date
Fetch next from csPhieuNhap into @SoPN,@TenVTu,@SoLuongNhap,@NgayNhap
if @@FETCH_STATUS != 0 break 
print @SoPN+'|'+@TenVTu+'|'+str(@SoLuongNhap)+'|'+CONVERT(NVARCHAR, @NgayNhap)
end 
close csPhieuNhap
Deallocate csPhieuNhap 
--2.4. Hiện số lượng đặt hàng của các vật tư có đơn đặt hàng là N.
Declare csDonDH cursor for 
Select vt.TenVTu, ct.SoLuongDat from tblChiTietDH ct join tblVatTu vt on ct.MaVTu = vt.MaVTu where ct.SoDH = 'DH003'
Open csDonDH 
While 1=1 
Begin 
Declare @TenVTu nvarchar(255),@SoLuongDat int 
Fetch next from csDonDH into @TenVTu,@SoLuongDat 
if @@FETCH_STATUS !=0 break;
print @TenVTu +'|'+str(@SoLuongDat)
End 
Close csDonDH
Deallocate csDonDH 
--2.5. Hiện số lượng đặt hàng của các vật tư có số lượng đặt hàng >=N
Declare csDonDH cursor for 
Select vt.TenVTu, ct.SoLuongDat from tblChiTietDH ct join tblVatTu vt on ct.MaVTu = vt.MaVTu where ct.SoLuongDat >= 500 
Open csDonDH 
While 1=1 
Begin 
Declare @TenVTu nvarchar(255),@SoLuongDat int 
Fetch next from csDonDH into @TenVTu,@SoLuongDat 
if @@FETCH_STATUS !=0 break;
print @TenVTu +'|'+str(@SoLuongDat)
End 
Close csDonDH
Deallocate csDonDH 
--2.6. Hiện số lượng xuất hàng của các vật tư có phiếu xuất là N.
Declare csPhieuXuat cursor for 
Select vt.TenVTu, ctpx.SoLuongXuat from tblCTPXUAT ctpx join tblVatTu vt on ctpx.MaVTu = vt.MaVTu where ctpx.SoPX ='PX001'
Open csPhieuXuat
While 1=1 
Begin 
Declare @TenVTu nvarchar(255),@SoLuongXuat int 
Fetch next from csPhieuXuat into @TenVTu,@SoLuongXuat 
if @@FETCH_STATUS !=0 break;
print @TenVTu +'|'+str(@SoLuongXuat)
End 
Close csPhieuXuat
Deallocate csPhieuXuat
--2.7. Hiện số lượng xuất hàng của các vật tư có số lượng xuất hàng >=N
Declare csPhieuXuat cursor for 
Select vt.TenVTu, ctpx.SoLuongXuat from tblCTPXUAT ctpx join tblVatTu vt on ctpx.MaVTu = vt.MaVTu where ctpx.SoLuongXuat >= 100
Open csPhieuXuat
While 1=1 
Begin 
Declare @TenVTu nvarchar(255),@SoLuongXuat int 
Fetch next from csPhieuXuat into @TenVTu,@SoLuongXuat 
if @@FETCH_STATUS !=0 break;
print @TenVTu +'|'+str(@SoLuongXuat)
End 
Close csPhieuXuat
Deallocate csPhieuXuat
--2.8. Hiện tổng số lượng đặt hàng của các vật tư.
Declare csVatTu cursor for 
Select vt.MaVTu,vt.TenVTu,Sum(ctdh.SoLuongDat) TongSLD from tblChiTietDH ctdh join tblVatTu vt on vt.MaVTu = ctdh.MaVTu
group by vt.MaVTu,vt.TenVTu
Open csVatTu
While 1=1 
Begin 
Declare @MaVTu char(5),@TenVTu nvarchar(255),@TongSLD int
Fetch next from csVatTu into @MaVTu,@TenVTu,@TongSLD
if @@FETCH_STATUS !=0 break;
print @MaVTu+'|'+@TenVTu +'|'+str(@TongSLD)
End 
Close csVatTu
Deallocate csVatTu
--2.9. Hiện các vật tư có tổng lượng đặt hàng >=N.
Declare csVatTu cursor for 
Select vt.MaVTu,vt.TenVTu,Sum(ctdh.SoLuongDat) TongSLD from tblChiTietDH ctdh join tblVatTu vt on vt.MaVTu = ctdh.MaVTu
group by vt.MaVTu,vt.TenVTu Having Sum(ctdh.SoLuongDat) >= 500 
Open csVatTu
While 1=1 
Begin 
Declare @MaVTu char(5),@TenVTu nvarchar(255),@TongSLD int
Fetch next from csVatTu into @MaVTu,@TenVTu,@TongSLD
if @@FETCH_STATUS !=0 break;
print @MaVTu+'|'+@TenVTu +'|'+str(@TongSLD)
End 
Close csVatTu
Deallocate csVatTu
--2.10.Hiện tổng số lượng bán hàng của các vật tư.
Declare csVatTu cursor for 
Select vt.MaVTu,vt.TenVTu,Sum(ctpx.SoLuongXuat) TongSLBan from tblCTPXUAT ctpx join tblVatTu vt on ctpx.MaVTu = vt.MaVTu
group by vt.MaVTu,vt.TenVTu
Open csVatTu
While 1=1 
Begin 
Declare @MaVTu char(5),@TenVTu nvarchar(255),@TongSLBan int
Fetch next from csVatTu into @MaVTu,@TenVTu,@TongSLBan
if @@FETCH_STATUS !=0 break;
print @MaVTu+'|'+@TenVTu +'|'+str(@TongSLBan)
End 
Close csVatTu
Deallocate csVatTu
--2.11.Thống kê số lượng đặt hàng của các vật tư theo Nhà cung cấp.
Declare csNhaCungCap cursor for 
Select ncc.MaNCC,ncc.TenNCC,vt.TenVTu,Sum(ct.SoLuongDat) TongSoLuongDat
from tblNhaCungCap ncc join tblDONDH dh on dh.MaNCC = ncc.MaNCC join tblChiTietDH ct on ct.SoDH = dh.SoDH
join tblVatTu vt on vt.MaVTu = ct.MaVTu
group by ncc.MaNCC,ncc.TenNCC,vt.TenVTu order by ncc.TenNCC
Open csNhaCungCap 
While 1=1 
begin 
Declare @MaNCC char(5),@TenNCC nvarchar(255),@TenVTu nvarchar(255),@TongSoLuongDat int 
Fetch next from csNhaCungCap into @MaNCC,@TenNCC,@TenVTu,@TongSoLuongDat
if @@FETCH_STATUS != 0 break
print @MaNCC+'|'+@TenNCC+'|'+@TenVTu+'|'+str(@TongSoLuongDat)
end 
close csNhaCungCap 
Deallocate csNhaCungCap 
--2.12.Thống kê số lượng nhập hàng của các vật tư theo Nhà cung cấp
Declare csNhaCungCap cursor for 
select nc.MaNCC,nc.TenNCC, vt.TenVTu, Sum(ctpn.SoLuongNhap) TongSLNhap from tblCTPNHAP ctpn join tblVATTU vt on ctpn.MaVTu = vt.MaVTu
join tblPNHAP pn on ctpn.SoPN = pn.SoPN join tblDONDH dh on pn.SoDH = dh.SoDH join tblNhaCungCap nc on dh.MaNCC = nc.MaNCC
Group by  nc.MaNCC,nc.TenNCC, vt.TenVTu
Order by  nc.TenNcc
Open csNhaCungCap 
While 1=1 
begin 
Declare @MaNCC char(5),@TenNCC nvarchar(255),@TenVTu nvarchar(255),@TongSLNhap int 
Fetch next from csNhaCungCap into @MaNCC,@TenNCC,@TenVTu,@TongSLNhap
if @@FETCH_STATUS != 0 break
print @MaNCC+'|'+@TenNCC+'|'+@TenVTu+'|'+str(@TongSLNhap)
end 
close csNhaCungCap 
Deallocate csNhaCungCap 
