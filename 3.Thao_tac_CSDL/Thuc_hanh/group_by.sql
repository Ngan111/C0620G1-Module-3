SELECT * FROM classicmodels.customers;
select status from orders;
/*Khi thực hiện lệnh trên, MySQL sẽ xuất hiện tất cả trạng thái của đơn hàng, rất nhiều và không có trật tự*/
select status from orders group by status;
/*Lệnh này sẽ nhóm lại và hiển thị những trạng thái chính của đơn hàng:Resolved, Cancelled, On Hold, Disputed và In Process*/
select status, count(*) as 'so luong status'
from orders
group by status;
/*Tính tổng đơn hàng trong mỗi trạng thái*/
select status, sum(quantityOrdered*priceEach) as amount 
from orderdetails inner join orders on orders.orderNumber = orderdetails.orderNumber
group by status; 
/*Tính tổng số tiền, phân loại theo status*/
select orderNumber, sum(quantityOrdered*priceEach) as amount 
from orderdetails group by orderNumber;
/*Tính tổng tiền theo từng đơn hàng*/
select year(orderDate) as year, sum(quantityOrdered*priceEach) as turnover
from orders inner join orderdetails on orders.orderNumber = orderdetails.orderNumber
where status = 'shipped'
group by year
having year > 2003;
/*tính doanh thu của những năm sau 2003*/