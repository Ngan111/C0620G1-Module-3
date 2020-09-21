SELECT * FROM classicmodels.customers;
select * from customers where customerNumber =175;
explain select * from customers where customerNumber =175;
/*table : Bảng nào đang liên quan đến output data,
possible_keys: Những index có thể sử dụng để query, 
key: Index nào đang được sử dụng,
key_len: Chiều dài của từng mục trong index,
ref: Cột nào đang sử dụng,
rows: Số hàng mà MySQL dự đoán phải tìm,
extra: Thông tin phụ,
type : Column này cho chúng ta biết kiểu query nào nó đang sử dụng. 
Mức độ từ tốt nhất đến chậm nhất như sau: system, const, eq_ref, ref, range, index, all*/

alter table customers add index idx_customerNumber(customerNumber);
/*Thêm chỉ mục cho bảng customers*/

alter table customers add index idx_full_name(contactFirstName, contactLastName);
/*Thêm idx_full_name(bao gồm contactFirstName, contactLastName) làm chỉ mục cho bảng*/

alter table customers drop index idx_full_name;
/*Xóa chỉ mục idx_full_name trong bảng customers*/

