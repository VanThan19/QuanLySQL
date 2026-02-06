use QlBanHangg 

--1.Xây dựng trigger trong tblpnhap để kiểm tra khi người dùng thêm mới mẫu tin.
--Khóa ngoại: sodh phải tồn tại trong tbldondh, manhacc phải tồn tại
--trong tblnhacc.
--− Miền giá trị: ngày nhập phải sau ngaydh trong bảng tbldondh
create trigger vd1 
on tblPNhap
instead of insert
as
begin
if exists(select *from inserted i join tblPNHAP pn on i.SoPN=pn.SoPN)
begin
print N'SoPN đã tồn tại'
rollback
return
end
else if not exists(select * from inserted i join tblDONDH dh on i.SoDH=dh.SoDH)
begin
print N'SoDH phải tồn tại trong bảng tblDONDH'
rollback
return
end
else if ((select NgayNhap from inserted)<(select NgayDH from tblDONDH where SoDH in(select SoDH from inserted)))
begin
print N'Ngày nhập phải sau ngày đặt'
rollback
return
end
begin
print N'Đã thêm thành công'
insert into tblPNHAP select *from inserted
end
end
insert into tblPNHAP values('PN009','DH001','2025-06-19')
select * from tblPNHAP
--2. Xóa 1 Sodh trong tbldondh. Nếu sodh này đã có trong bảng
--tblpnhap thì không xóa được. Nếu chưa có thì xóa nó cùng bản ghi có sodh
--đó trong tblctdondh. 
create trigger vd2
on tblDONDH
instead of delete
as
begin
if exists(select *from deleted d join tblPNHAP pn on d.SoDH=pn.SoDH)
print N'Không được xóa SoDH vì đã tồn tại trong bảng tblPNHAP'
rollback
return
end
else
begin
print N'Đã xóa'
delete from tblChiTietDH where SoDH in(select SoDH from deleted)
delete from tblDONDH where SoDH in(select SoDH from deleted)
end
delete from tblDONDH where SoDH='DH007'
select * from tblDONDH
--3. Sửa thông tin bảng tbldondh thõa mãn:
--− Không cho phép sửa dữ liệu cột sodh
--− Sửa manhacc phải tồn tại trong tblnhacc
--− Cột ngaydh phải trước ngày nhập hàng trong tblpnhap
create trigger vd3
on tblDONDH
for update
as
if update(SoDH)
begin
print N'Không được sửa cột SoDH'
rollback transaction
return
end
else if update(MaNCC)
begin
if not exists(select *from inserted i join tblNhaCungCap ncc on i.MaNCC=ncc.MaNCC)
begin
print N'MaNCC phải tồn tại trong bảng tblNCC'
rollback 
return
end
end
else if update(NgayDH)
begin
if exists (select * from inserted i join tblPNHAP pn on i.SoDH = pn.SoDH where i.NgayDH >= pn.NgayNhap)
begin
print N'Ngày đặt phải trước ngày nhập hàng'
rollback
return
end
end
update tblDONDH set NgayDH='2025-05-05',MaNCC='NCC01' where SoDH='DH003'
select * from tblDONDH
--4. Xây dựng trigger trong tblctdondh để kiểm tra khi người dùng
--thêm mới mẫu tin.
--− Khóa ngoại: sodh phải tồn tại trong tbldondh, mavtu phải tồn tại trong
--tblvattu.
--− Miền giá trị: sldat >=A và <=B.
create trigger vd4
on tblChiTietDH
instead of insert
as
if  not exists(select *from inserted i join tblDONDH dh on i.SoDH=dh.SoDH)
begin
print N'SoDH phải tồn tại trong bảng tblDONDH'
rollback
return
end
else if not exists(select *from inserted i join tblVATTU vt on i.MaVTu=vt.MaVTu)
begin
print N'MaVTu phải tồn tại trong bảng tblVatTu'
rollback
return
end
else if ((select SoLuongDat from inserted)<10 or (select SoLuongDat from inserted)>100)
begin
print N'SLDat nằm trong khoảng từ 10 đến 100'
rollback
return
end
else if exists(select *from inserted i join tblChiTietDH ct on i.SoDH=ct.SoDH and i.MaVTu=ct.MaVTu)
begin
print N'Đã có đơn hàng tương ứng với SoDH và MaVTu này rồi'
rollback
return
end
else
insert into tblChiTietDH select *from inserted
insert into tblChiTietDH values('DH002','VT003',50)
select * from tblChiTietDH
--5. Xây dựng trigger trong tblpnhap để kiểm tra khi người dùng thêm
--mới mẫu tin.
--− Khóa ngoại: sodh phải tồn tại trong tbldondh.
--− Miền giá trị: ngày nhập hàng phải sau ngày đặt trong bảng tbldondh.
create trigger vd5
on tblPNHAP
instead of insert
as
begin
if exists (select*from inserted i join tblPNHAP p on i.SoPN = p.SoPN)
begin
print N'Lỗi: Số phiếu nhập đã tồn tại.'
rollback
return
end
if exists (select * from inserted i left join tblDONDH d on i.SoDH = d.SoDH where d.SoDH IS NULL)
begin
print N'Lỗi: Số đơn hàng không tồn tại trong bảng DONDH.'
rollback
return
end
if exists (select * from inserted i join tblDONDH d on i.SoDH = d.SoDH where i.NgayNhap <= d.NgayDH)
begin
print N'Lỗi: Ngày nhập hàng phải sau ngày đặt hàng.'
rollback
return
end
insert into tblPNHAP (SoPN, SoDH, NgayNhap) select SoPN, SoDH, NgayNhap from inserted
end
insert into tblPNHAP values('PN118','DH001','2025-05-05')
select * from tblPNHAP

--6. Xây dựng trigger trong tblctpnhap để kiểm tra khi người dùng
--thêm mới mẫu tin.
--− Khóa ngoại: sopnhap phải tồn tại trong bảng tblpnhap, mavtu phải tồn
--tại trong tblvattu.
--− Miền giá trị: slnhap phải thõa mãn: tổng số lượng nhập của các vật tư
--này của các số phiếu nhập có cùng số đặt hàng phải <= số lượng đặt
--hàng của vật tư trong số đặt hàng đó.
create trigger vd6
on tblCTPNHAP
instead of insert
as
if not exists(select *from inserted i join tblPNHAP pn on i.SoPN=pn.SoPN)
begin
print N'SoPN phải tồn tại trong bảng tblPNHAP'
rollback
return
end
else if not exists(select *from inserted i join tblVATTU vt on i.MaVTu=vt.MaVTu)
begin
print N'MaVTu phải tồn tại trong bảng tblVATTU'
rollback
return
end
else if exists(select *from inserted i join tblCTPNHAP ctpn on i.MaVTu=ctpn.MaVTu and i.SoPN=ctpn.SoPN)
begin
print N'Đã tồn tại tương ứng với SoPN và MaVTu'
rollback
return
end
else if exists (select i.MaVTu, dh.SoDH from inserted i join tblPNHAP pn on i.SoPN = pn.SoPN join tblDONDH dh on pn.SoDH = dh.SoDH
join tblChiTietDH ct on dh.SoDH = ct.SoDH and i.MaVTu = ct.MaVTu left join tblCTPNHAP ctpn on ctpn.MaVTu = i.MaVTu
and ctpn.SoPN IN (SELECT SoPN FROM tblPNHAP WHERE SoDH = dh.SoDH)
group by i.MaVTu, dh.SoDH, ct.SoLuongDat having SUM(ISNULL(ctpn.SoLuongNhap, 0)) + SUM(i.SoLuongNhap) > ct.SoLuongDat)
begin
print N'Lỗi: Tổng số lượng nhập vượt quá số lượng đặt hàng trong đơn.'
rollback
return
end
else
insert into tblCTPNHAP select *from inserted
insert into tblCTPNHAP values('PN003','VT002',10,1500)
select * from tblCTPNHAP
--7. Xây dựng trigger trong tblctpxuat để kiểm tra khi người dùng
--thêm mới mẫu tin.
--− Khóa ngoại: sopx phải tồn tại trong tblpxuat, mavtu phải tồn tại trong
--tblvattu.
--− Miền giá trị: slxuat >=A và <=B
create trigger vd7
on tblCTPXUAT
instead of insert
as
if  not exists(select *from inserted i join tblPXUAT px on i.SoPX=px.SoPX)
begin
print N'SoPX phải tồn tại trong bảng tblPXUAT'
rollback
return
end
else if not exists(select *from inserted i join tblVATTU vt on i.MaVTu=vt.MaVTu)
begin
print N'MaVTu phải tồn tại trong bảng tblVATTU'
rollback
return
end
else if exists(select *from inserted i join tblCTPXUAT ctpx on i.SoPX=ctpx.SoPX and i.MaVTu=ctpx.MaVTu)
begin
print N'Đã tồn tại tương ứng với SoPX và MaVTu'
rollback
return
end
else if ((select SoLuongXuat from inserted)<50 or (select SoLuongXuat from inserted)>500)
begin
print N'SLXuat phải nằm trong khoảng từ 50-500'
rollback
return
end
else
insert into tblCTPXUAT select *from inserted
insert into tblCTPXUAT values('PX003','VT001',400,5000)
select * from tblCTPXUAT