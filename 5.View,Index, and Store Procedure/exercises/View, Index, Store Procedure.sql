create database demo;
use demo;
create table products (
id int auto_increment,
productCode varchar(20),
productName varchar(20),
productPrice int,
productAmount int,
productDescription varchar(30),
productStatus varchar(20),
primary key (id)
);
create unique index product_code
on Products(productCode);
/*Tạo chỉ mục cho bảng Products bằng column productCode*/

create unique index compositeIndexProductPrice
on Products(productCode,productPrice);
/*Tạo chỉ mục cho bảng Products bằng column productCode và productPrice*/

explain select * from Products;
/*Sử dụng câu lệnh EXPLAIN để biết được câu lệnh SQL của bạn thực thi như nào*/
CREATE VIEW Products_view AS
    SELECT 
        productCode, productName, productPrice, productStatus
    FROM
        Products;
select * from Products_view;

update Products_view
set productPrice = 352
where productName = 'Acer';
/*Update thông tin*/

drop view products_view; /*Xóa view*/

delimiter //
create procedure getAllProducts ()
begin
select productName,productPrice,productAmount,productDescription,productStatus
from Products;
end; //
delimiter ;
call getAllProducts(); /*Lấy ra thông tin của sản phẩm*/

delimiter //
create procedure addNewProducts (productCode varchar(50),productName varchar(50),productPrice varchar(50),productAmount int,productDescription 
varchar(50),productStatus varchar(50))
begin
insert into Products(productCode,productName,productPrice,productAmount,productDescription,productStatus)
value(productCode,productName,productPrice,productAmount,productDescription,productStatus);
end; //
delimiter ;
call addNewProducts('SM','Sakura Markers','25','24','From Japan','Available');
select * from products;
/*Thêm sản phẩm mới*/

delimiter //
create procedure UpdateInfo(
in id_found int,
in `code` varchar(45),
in `name` varchar(45),
in price int,
in amount int,
in descrip varchar(45),
in `status` varchar(45)
)
begin
update products
set  productCode = `code`,productName = `name`,
productPrice = price, productAmount = amount, 
productDescription = descrip, productStatus = `status`
 where id = id_found;
end ; //
delimiter ;
call UpdateInfo(4,'IP12','iphone 12','2000','9','The newest version','Confirming');
select * from products;
/*Update thông tin sp bằng id*/

delimiter //
create procedure delete_prd(in id_found int) 
begin
delete from products
where id = id_found;
end; //
delimiter ;
call delete_prd();
select * from products;

