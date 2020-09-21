SELECT * FROM classicmodels.customers;
create view customer_view AS
select customerNumber,customerName, phone
from customers;
select *from customer_view;
/*Hiển thị attribute customerNumber,customerName, phone nhưng ko chỉnh sửa thông tin đc*/

create view customer_view1 AS
select customerNumber, customerName, contactFirstName, contactLastName, phone
from customers
where city ='Nantes';

