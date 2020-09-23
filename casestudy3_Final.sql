/*1. Add dữ liệu*/
use casestudy_module3;
delimiter //
create procedure addNewCustomers (id_loai_khach int, ho_ten varchar(45),ngay_sinh date, c_m_n_d 
varchar(45),so_dien_thoai varchar(45),
email varchar(45),dia_chi varchar(45))
begin
insert into khach_hang(id_loai_khach, ho_ten,ngay_sinh, c_m_n_d,so_dien_thoai,email,dia_chi)
value(id_loai_khach, ho_ten,ngay_sinh, c_m_n_d,so_dien_thoai,email,dia_chi);
end; //
delimiter ;
call addNewCustomers('3','','1988-12-12','145745589','01471592365','rett@gmail.com','Atlanta');
call addNewCustomers('5','Cherry','1996-02-24','145274273','0144787378','cherry@gmail.com','London');

delimiter //
create procedure addNewEmployees (ho_ten varchar(45),id_trinh_do int,id_vi_tri int,id_bo_phan int,ngay_sinh date,
so_cmnd varchar(45),Luong varchar(45),so_dien_thoai varchar(45),Email varchar(45),dia_chi varchar(45))
begin
insert into nhan_vien(ho_ten,id_trinh_do,id_vi_tri,id_bo_phan,ngay_sinh,so_cmnd,Luong,so_dien_thoai,Email,dia_chi)
value(ho_ten,id_trinh_do,id_vi_tri,id_bo_phan,ngay_sinh,so_cmnd,Luong,so_dien_thoai,Email,dia_chi);
end; //
delimiter ;
call addNewEmployees ('Cao Tiệp','1','1','1','1994-10-01','145236786','4000','01478523691','truong@gmail.com','Hải Châu');

/*2.Hiển thị những nhân viên có tên bắt đầu bằng H,K,T và độ dài của tên tối đa 15 ký tự*/
use casestudy_module3;
select *from nhan_vien
where substring_index(ho_ten,' ',-1) regexp binary '^[HKT]' and char_length(ho_ten) <= 15;

/*3.Hiển thị những khách hàng tuổi từ 18-50, có địa chỉ ở ĐN, Q.Trị*/
select * , timestampdiff(year,ngay_sinh,current_date()) as 'Age' from khach_hang
having Age between 18 and 50 and (khach_hang.dia_chi in ("Đà Nẵng", "Quảng Trị"));

/*4.Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu lần. 
Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của khách hàng. 
Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”. */
select kh.id_loai_khach, kh.ngay_sinh, kh.dia_chi,kh.ho_ten, lk.ten_loai_khach, hd.id_khach_hang,
count(hd.id_khach_hang) 'số lần đặt phòng'
from khach_hang kh 
left join loai_khach lk on kh.id_loai_khach = lk.id_loai_khach
left join hop_dong hd on kh.id_khach_hang = hd.id_khach_hang
where lk.ten_loai_khach = 'Diamond' 
group by kh.ho_ten
order by count(hd.id_khach_hang) asc;

/*5.Hiển thị IDKhachHang, HoTen, TenLoaiKhach, IDHopDong, TenDichVu, NgayLamHopDong, NgayKetThuc, TongTien 
(Với TongTien được tính theo công thức như sau: ChiPhiThue + SoLuong*Gia, với SoLuong và Giá là từ bảng DichVuDiKem) 
cho tất cả các Khách hàng đã từng đặt phỏng. (Những Khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).*/
SELECT 
    kh.id_khach_hang,
    kh.ho_ten,
    lk.ten_loai_khach,
    hd.id_hop_dong,
    dv.ten_dich_vu,
    hd.ngay_lam_hop_dong,
    hd.ngay_ket_thuc,
    sum(dv.chi_phi_thue + (dvdk.don_vi * dvdk.gia))'tong_tien'
from khach_hang kh
left join loai_khach lk on kh.id_loai_khach = lk.id_loai_khach
left join hop_dong hd on hd.id_khach_hang = kh.id_khach_hang
left join dich_vu dv on hd.id_dich_vu = dv.id_dich_vu
left join hop_dong_chi_tiet hdct on hdct.id_hop_dong = hd.id_hop_dong
left join dich_vu_di_kem dvdk on dvdk.id_dich_vu_di_kem = hdct.id_dich_vu_di_kem
group by ho_ten
order by sum(dv.chi_phi_thue + (dvdk.don_vi * dvdk.gia)) desc;

/*6.Hiển thị IDDichVu, TenDichVu, DienTich, ChiPhiThue, TenLoaiDichVu của tất cả các loại Dịch vụ chưa 
từng được Khách hàng thực hiện đặt từ quý 1 của năm 2019 (Quý 1 là tháng 1, 2, 3)*/
SELECT dich_vu.id_dich_vu, loai_dich_vu.ten_loai_dich_vu, dich_vu.dien_tich,dich_vu.chi_phi_thue,
hop_dong.id_hop_dong, hop_dong.ngay_lam_hop_dong
from casestudy_module3.dich_vu 
inner join kieu_thue on dich_vu.id_kieu_thue = kieu_thue.id_kieu_thue
inner join loai_dich_vu on dich_vu.id_loai_dich_vu = loai_dich_vu.id_loai_dich_vu
inner join hop_dong on hop_dong.id_dich_vu = dich_vu.id_dich_vu
WHERE year(hop_dong.ngay_lam_hop_dong) = 2019 and datediff(hop_dong.ngay_lam_hop_dong,'2019/03/31') > 0
group by id_dich_vu
order by (hop_dong.ngay_lam_hop_dong) asc;
/*Hiển thị dịch vụ chưa từng được khách hàng đặt từ quý I/2019 đến nay*/
SELECT dich_vu.id_dich_vu, dich_vu.ten_dich_vu, dich_vu.dien_tich,dich_vu.chi_phi_thue,hop_dong.id_hop_dong
from casestudy_module3.dich_vu 
inner join kieu_thue on dich_vu.id_kieu_thue = kieu_thue.id_kieu_thue
inner join loai_dich_vu on dich_vu.id_loai_dich_vu = loai_dich_vu.id_loai_dich_vu
inner join hop_dong on hop_dong.id_dich_vu = dich_vu.id_dich_vu
WHERE year(hop_dong.ngay_lam_hop_dong) not in (2019,2020)
group by id_dich_vu;

/*7.Hiển thị IDDichVu, TenDichVu, DienTich, SoNguoiToiDa, ChiPhiThue, TenLoaiDichVu của tất cả các loại dịch vụ 
đã từng được Khách hàng đặt phòng trong năm 2018 nhưng chưa từng được Khách hàng đặt phòng trong năm 2019*/
select d_v.id_dich_vu, d_v.ten_dich_vu, d_v.dien_tich, d_v.chi_phi_thue, loai_dich_vu.ten_loai_dich_vu 
from dich_vu d_v
inner join loai_dich_vu on d_v.id_loai_dich_vu = loai_dich_vu.id_loai_dich_vu
inner join hop_dong h_d on h_d.id_dich_vu = d_v.id_dich_vu
where year(h_d.ngay_lam_hop_dong) = 2018
and d_v.id_dich_vu not in (select
	d_v.id_dich_vu
from dich_vu d_v
inner join hop_dong h_d on h_d.id_dich_vu = d_v.id_dich_vu
where year(h_d.ngay_lam_hop_dong) = 2019)
group by d_v.id_dich_vu
order by d_v.id_dich_vu;

/*8.Hiển thị thông tin HoTenKhachHang có trong hệ thống, với yêu cầu HoThenKhachHang không trùng nhau.*/
select distinct ho_ten from khach_hang;
select ho_ten from khach_hang group by ho_ten;
select ho_ten from khach_hang union
select ho_ten from khach_hang;

/*9.Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong 
năm 2019 thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.*/
select month(hop_dong.ngay_lam_hop_dong) 'thang',count(id_hop_dong) 'so_hop_dong_trong_nam_2019',sum(tong_tien)
'doanh_thu' from hop_dong where year(hop_dong.ngay_lam_hop_dong) = 2019
group by month(hop_dong.ngay_lam_hop_dong) order by month(hop_dong.ngay_lam_hop_dong) desc;

/*10.Hiển thị thông tin tương ứng với từng Hợp đồng thì đã sử dụng bao nhiêu Dịch vụ đi kèm. 
Kết quả hiển thị bao gồm IDHopDong, NgayLamHopDong, NgayKetthuc, TienDatCoc, SoLuongDichVuDiKem 
(được tính dựa trên việc count các IDHopDongChiTiet)*/
select h_d.id_hop_dong, h_d.ngay_lam_hop_dong, h_d.ngay_ket_thuc, h_d.tien_dat_coc,d_v_d_k.ten_dich_vu_di_kem ,
sum(h_d_c_t.so_luong) 'so_luong_DVDK'
from hop_dong h_d
left join hop_dong_chi_tiet h_d_c_t on h_d.id_hop_dong = h_d_c_t.id_hop_dong
left join dich_vu_di_kem d_v_d_k on d_v_d_k.id_dich_vu_di_kem = h_d_c_t.id_dich_vu_di_kem
group by h_d.id_hop_dong;

SELECT hop_dong.id_hop_dong,hop_dong.ngay_lam_hop_dong,hop_dong.ngay_ket_thuc,hop_dong.tien_dat_coc,
count(hdct.id_hop_dong_chi_tiet) as SoLuongDichVuDiKem FROM casestudy_module3.hop_dong
inner join casestudy_module3.hop_dong_chi_tiet hdct on hop_dong.id_hop_dong = hdct.id_hop_dong
group by hop_dong.id_hop_dong;

/*11.Hiển thị thông tin các Dịch vụ đi kèm đã được sử dụng bởi những Khách hàng có TenLoaiKhachHang 
là “Diamond” và có địa chỉ là “Vinh” hoặc “Quảng Ngãi”*/
select ho_ten,c_m_n_d,dia_chi,hop_dong.id_hop_dong, hop_dong.ngay_lam_hop_dong,hop_dong.ngay_ket_thuc,
loai_khach.ten_loai_khach,dich_vu_di_kem.ten_dich_vu_di_kem
from khach_hang
join loai_khach on loai_khach.id_loai_khach = khach_hang.id_loai_khach
join hop_dong on khach_hang.id_khach_hang = hop_dong.id_khach_hang
join hop_dong_chi_tiet on hop_dong_chi_tiet.id_hop_dong = hop_dong.id_hop_dong
join dich_vu_di_kem on dich_vu_di_kem.id_dich_vu_di_kem = hop_dong_chi_tiet.id_dich_vu_di_kem
where khach_hang.dia_chi in ('Vinh','Quảng Ngãi') 
and loai_khach.ten_loai_khach = 'Diamond';

/*12.Hiển thị thông tin IDHopDong, TenNhanVien, TenKhachHang, SoDienThoaiKhachHang, TenDichVu, 
SoLuongDichVuDikem (được tính dựa trên tổng Hợp đồng chi tiết), TienDatCoc 
của tất cả các dịch vụ đã từng được khách hàng đặt vào 3 tháng cuối năm 2019 nhưng chưa từng được khách hàng 
đặt vào 6 tháng đầu năm 2019.*/
select hop_dong.id_hop_dong, hop_dong.ngay_lam_hop_dong, hop_dong.tien_dat_coc, nhan_vien.ho_ten as 'ho_ten_NV',
 khach_hang.ho_ten as 'ho_ten_KH', khach_hang.so_dien_thoai,
 dich_vu.ten_dich_vu, hop_dong_chi_tiet.so_luong 'so_luong'
from hop_dong 
inner join nhan_vien on nhan_vien.id_nhan_vien = hop_dong.id_nhan_vien
inner join khach_hang on khach_hang.id_khach_hang = hop_dong.id_khach_hang
inner join dich_vu on dich_vu.id_dich_vu = hop_dong.id_dich_vu
inner join hop_dong_chi_tiet on hop_dong.id_hop_dong = hop_dong_chi_tiet.id_hop_dong
where datediff(hop_dong.ngay_lam_hop_dong,'2019-10-01')>=0 
and datediff(hop_dong.ngay_lam_hop_dong,'2019-12-31')<=0
and hop_dong.id_dich_vu not in (select hop_dong.id_dich_vu
        where datediff(hop_dong.ngay_lam_hop_dong,'2019-01-01')>=0 
			and datediff(hop_dong.ngay_lam_hop_dong,'2019-06-30')<=0)
            group by dich_vu.id_dich_vu;
            
/*13.Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các Khách hàng đã đặt phòng.*/
create view count_dich_vu_di_kem as 
select dich_vu_di_kem.ten_dich_vu_di_kem, dich_vu_di_kem.gia, dich_vu_di_kem.trang_thai_kha_dung, 
count(hop_dong_chi_tiet.so_luong) as 'so_luong_dich_vu_di_kem'
from hop_dong_chi_tiet
inner join dich_vu_di_kem on dich_vu_di_kem.id_dich_vu_di_kem = hop_dong_chi_tiet.id_dich_vu_di_kem
inner join hop_dong on hop_dong.id_hop_dong = hop_dong_chi_tiet.id_hop_dong
group by hop_dong_chi_tiet.id_dich_vu_di_kem;
select ten_dich_vu_di_kem, gia, so_luong_dich_vu_di_kem, trang_thai_kha_dung
from count_dich_vu_di_kem 
where so_luong_dich_vu_di_kem = (select max(so_luong_dich_vu_di_kem) from count_dich_vu_di_kem);

/*14.Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một lần duy nhất. 
Thông tin hiển thị bao gồm IDHopDong, TenLoaiDichVu, TenDichVuDiKem, SoLanSuDung.*/
select hop_dong_chi_tiet.id_hop_dong, dich_vu_di_kem.ten_dich_vu_di_kem, loai_dich_vu.ten_loai_dich_vu, 
count(hop_dong_chi_tiet.id_dich_vu_di_kem) as 'so_luong'
from hop_dong_chi_tiet
inner join dich_vu_di_kem on hop_dong_chi_tiet.id_dich_vu_di_kem = dich_vu_di_kem.id_dich_vu_di_kem
inner join hop_dong on hop_dong_chi_tiet.id_hop_dong = hop_dong.id_hop_dong
inner join dich_vu on dich_vu.id_dich_vu = hop_dong.id_dich_vu
inner join loai_dich_vu on loai_dich_vu.id_loai_dich_vu = dich_vu.id_loai_dich_vu
group by hop_dong_chi_tiet.id_dich_vu_di_kem
having so_luong = 1;

/*15.Hiển thi thông tin của tất cả nhân viên bao gồm IDNhanVien, HoTen, TrinhDo, TenBoPhan, SoDienThoai, DiaChi 
mới chỉ lập được tối đa 3 hợp đồng từ năm 2018 đến 2019.*/
select nhan_vien.id_nhan_vien, nhan_vien.ho_ten, nhan_vien.so_dien_thoai, nhan_vien.dia_chi,
trinh_do.trinh_do, bo_phan.ten_bo_phan, count(hop_dong.id_nhan_vien) 'so_lan_ki_hop_dong'
from nhan_vien
left join trinh_do on nhan_vien.id_trinh_do = trinh_do.id_trinh_do
left join bo_phan on nhan_vien.id_bo_phan = bo_phan.id_bo_phan
left join hop_dong on nhan_vien.id_nhan_vien = hop_dong.id_nhan_vien
where datediff(hop_dong.ngay_lam_hop_dong,'2018-01-01') >= 0
and datediff(hop_dong.ngay_lam_hop_dong,'2019-12-31') <= 0
group by nhan_vien.id_nhan_vien
having so_lan_ki_hop_dong <= 3
order by nhan_vien.id_nhan_vien asc;
/*16.Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2017 đến năm 2019.*/
create view hop_dong_2017_2019 as
select * from hop_dong
where year(ngay_lam_hop_dong) between 2017 and 2019;
select * from hop_dong_2017_2019;
delete from nhan_vien
where id_nhan_vien not in (select id_nhan_vien from hop_dong_2017_2019);
/*Add lại thông tin sau khi xóa để review*/
call addNewEmployees('Huỳnh Thiên Hương','1','1','1','1979/12/12','201478952','7000','0145753159',
'huong@gmail.com','Sơn Trà');
call addNewEmployees('Huỳnh Thúy Nga','1','2','3','1980/11/11','207428952','6000','0145742159',
'nga@gmail.com','Hòa Vang');
INSERT INTO `casestudy_module3`.`hop_dong` (`id_hop_dong`, `id_nhan_vien`, `id_khach_hang`, `id_dich_vu`, `ngay_lam_hop_dong`, `ngay_ket_thuc`, `tien_dat_coc`, `tong_tien`) VALUES ('276', '20', '26', '3', '2016-01-01', '2013-01-05', '500', '2500');
INSERT INTO `casestudy_module3`.`hop_dong` (`id_hop_dong`, `id_nhan_vien`, `id_khach_hang`, `id_dich_vu`, `ngay_lam_hop_dong`, `ngay_ket_thuc`, `tien_dat_coc`, `tong_tien`) VALUES ('277', '21', '27', '1', '2016-03-03', '2012-03-05', '500', '2500');
INSERT INTO `casestudy_module3`.`hop_dong` (`id_hop_dong`, `id_nhan_vien`, `id_khach_hang`, `id_dich_vu`, `ngay_lam_hop_dong`, `ngay_ket_thuc`, `tien_dat_coc`, `tong_tien`) VALUES ('278', '20', '28', '1', '2016-04-04', '2012-04-06', '500', '2500');

/*18.Xóa những khách hàng có hợp đồng trước năm 2016 (chú ý ràngbuộc giữa các bảng).*/
create view khach_hang_before2016 as
select * from hop_dong
where year(ngay_lam_hop_dong) <2016;
select * from khach_hang_before2016;
delete from khach_hang where id_khach_hang in (select id_khach_hang from khach_hang_before2016);
call addNewCustomers('2','Maria','1946-09-09','145236741','0147875365','maria@gmail.com','Berlin');
call addNewCustomers('3','Michael','1986-11-11','145245653','0147415365','michael@gmail.com','Paris');
INSERT INTO `casestudy_module3`.`hop_dong` (`id_hop_dong`, `id_nhan_vien`, `id_khach_hang`, `id_dich_vu`, `ngay_lam_hop_dong`, `ngay_ket_thuc`, `tien_dat_coc`, `tong_tien`) VALUES ('279', '1', '32', '1', '2014-01-01', '2014-01-05', '500', '2500');
INSERT INTO `casestudy_module3`.`hop_dong` (`id_hop_dong`, `id_nhan_vien`, `id_khach_hang`, `id_dich_vu`, `ngay_lam_hop_dong`, `ngay_ket_thuc`, `tien_dat_coc`, `tong_tien`) VALUES ('280', '2', '33', '5', '2015-01-01', '2015-01-04', '500', '2500');

/*17.Cập nhật thông tin những khách hàng có TenLoaiKhachHang từ  Platinium lên Diamond, chỉ cập nhật những khách hàng đã từng đặt phòng với 
tổng Tiền thanh toán trong năm 2019 là lớn hơn 10.000.000 VNĐ.*/

update khach_hang set id_loai_khach = 5 where id_khach_hang in (
select distinct(id_khach_hang) from (
select khach_hang.id_khach_hang, hop_dong.ngay_lam_hop_dong, sum(dich_vu.chi_phi_thue + dich_vu_di_kem.gia*hop_dong_chi_tiet.so_luong)
 as total_pay from khach_hang
join loai_khach on khach_hang.id_loai_khach = loai_khach.id_loai_khach
join hop_dong on khach_hang.id_khach_hang = hop_dong.id_khach_hang
join hop_dong_chi_tiet on hop_dong.id_hop_dong = hop_dong_chi_tiet.id_hop_dong
join dich_vu on dich_vu.id_dich_vu = hop_dong.id_dich_vu
join dich_vu_di_kem on hop_dong_chi_tiet.id_dich_vu_di_kem = dich_vu_di_kem.id_dich_vu_di_kem
where khach_hang.id_loai_khach = 2 and year(hop_dong.ngay_lam_hop_dong) = 2019
group by khach_hang.id_khach_hang
having total_pay >10000000) as temp
);
/*Kiểm tra thông tin đã được update*/
select khach_hang.ho_ten, hop_dong.ngay_lam_hop_dong, hop_dong.id_hop_dong, loai_khach.ten_loai_khach, 
(dich_vu.chi_phi_thue + dich_vu_di_kem.gia*hop_dong_chi_tiet.so_luong) as total_pay from khach_hang
join loai_khach on khach_hang.id_loai_khach = loai_khach.id_loai_khach
join hop_dong on khach_hang.id_khach_hang = hop_dong.id_khach_hang
join hop_dong_chi_tiet on hop_dong.id_hop_dong = hop_dong_chi_tiet.id_hop_dong
join dich_vu on dich_vu.id_dich_vu = hop_dong.id_dich_vu
join dich_vu_di_kem on hop_dong_chi_tiet.id_dich_vu_di_kem = dich_vu_di_kem.id_dich_vu_di_kem
where loai_khach.ten_loai_khach = 'Diamond'  and year(hop_dong.ngay_lam_hop_dong) = 2019 
group by khach_hang.id_khach_hang
having total_pay > 10000000;

/*19.Cập nhật giá cho các Dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2019 lên gấp đôi.*/
update dich_vu_di_kem set gia = gia*2 where (id_dich_vu_di_kem) in (
select distinct(id_dich_vu_di_kem) from (
select dich_vu_di_kem.id_dich_vu_di_kem, dich_vu_di_kem.gia, sum(hop_dong_chi_tiet.so_luong) as 'so_lan_su_dung',hop_dong.ngay_lam_hop_dong 
from hop_dong_chi_tiet
inner join hop_dong on hop_dong_chi_tiet.id_hop_dong = hop_dong.id_hop_dong
inner join dich_vu_di_kem on hop_dong_chi_tiet.id_dich_vu_di_kem = dich_vu_di_kem.id_dich_vu_di_kem
where year(hop_dong.ngay_lam_hop_dong) = 2019
group by dich_vu_di_kem.id_dich_vu_di_kem
having so_lan_su_dung > 10) as temp
);
select dich_vu_di_kem.id_dich_vu_di_kem, dich_vu_di_kem.ten_dich_vu_di_kem,
dich_vu_di_kem.gia, sum(hop_dong_chi_tiet.so_luong) as 'so_lan_su_dung'
from hop_dong_chi_tiet
inner join hop_dong on hop_dong_chi_tiet.id_hop_dong = hop_dong.id_hop_dong
inner join dich_vu_di_kem on hop_dong_chi_tiet.id_dich_vu_di_kem = dich_vu_di_kem.id_dich_vu_di_kem
where year(hop_dong.ngay_lam_hop_dong) = 2019
group by dich_vu_di_kem.id_dich_vu_di_kem
having so_lan_su_dung > 10;

/*20.Hiển thị thông tin của tất cả các Nhân viên và Khách hàng có trong hệ thống, thông tin hiển thị bao gồm ID 
(IDNhanVien, IDKhachHang), HoTen, Email, SoDienThoai, NgaySinh, DiaChi.*/
select nv.id_nhan_vien 'ID_NV', nv.ho 'ho_ten_NV', nv.Email 'email_NV', nv.so_dien_thoai 'sdt_NV', 
nv.ngay_sinh 'ngay_sinh_NV', nv.dia_chi 'dia_chi_NV'
from nhan_vien nv
union
select kh.id_khach_hang 'id_KH',kh.ho_ten 'ho_ten_KH',kh.email 'email_KH',kh.so_dien_thoai 'sdt_KH',
kh.ngay_sinh 'ngay_sinh_KH',kh.dia_chi 'dia_chi_KH'
from khach_hang kh;

/*21.Tạo khung nhìn có tên là V_NHANVIEN để lấy được thông tin của tất cả các nhân viên 
có địa chỉ là “Hải Châu” và đã từng lập hợp đồng cho 1 hoặc nhiều Khách hàng bất kỳ  
với ngày lập hợp đồng là “12/12/2019”*/
create view v_nhanvien as
select nhan_vien.ho_ten, nhan_vien.dia_chi, nhan_vien.ngay_sinh, hop_dong.ngay_lam_hop_dong
from nhan_vien, hop_dong
where dia_chi = 'hải châu' and ngay_lam_hop_dong = '2019/12/12';
select * from v_nhanvien;
/*22.Thông qua khung nhìn V_NHANVIEN thực hiện cập nhật địa chỉ thành “Liên Chiểu” đối với tất cả các 
Nhân viên được nhìn thấy bởi khung nhìn này.*/


/*23.Tạo Store procedure Sp_1 Dùng để xóa thông tin của một Khách hàng nào đó với Id Khách hàng được truyền 
vào như là 1 tham số của Sp_1.*/
delimiter //
create procedure Sp_1(in id_found int) 
begin
delete from khach_hang
where id_khach_hang = id_found;
end; //
delimiter ;
call Sp_1(1);
select * from khach_hang;

/*24.Tạo Store procedure Sp_2 Dùng để thêm mới vào bảng HopDong với yêu cầu Sp_2 phải thực hiện kiểm tra 
tính hợp lệ của dữ liệu bổ sung, với nguyên tắc không được trùng khóa chính và đảm bảo toàn vẹn tham chiếu 
đến các bảng liên quan.*/




