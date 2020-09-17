create database functions_in_MySQL;
use functions_in_MySQL;
create table student (
id int auto_increment,
`name` varchar(20),
age int,
course varchar(20),
fee long,
primary key (id)
);
select * from student;
INSERT INTO `functions_in_mysql`.`student` (`name`, `age`, `course`, `fee`) VALUES ('Huong', '21', 'CNTT', '200000');
INSERT INTO `functions_in_mysql`.`student` (`name`, `age`, `course`, `fee`) VALUES ('Viet', '19', 'DTVT', '320000');
INSERT INTO `functions_in_mysql`.`student` (`name`, `age`, `course`, `fee`) VALUES ('Thanh', '21', 'CNTT', '450000');
INSERT INTO `functions_in_mysql`.`student` (`name`, `age`, `course`, `fee`) VALUES ('Nhan', '21', 'CNTT', '420000');
INSERT INTO `functions_in_mysql`.`student` (`name`, `age`, `course`, `fee`) VALUES ('Huong', '21', 'CNTT', '500000');
/*Hiển thị tất cả các dòng có tên Huong*/
select * from student
where name = 'Huong';
/*Tính tổng tiền của 'Huong'*/
select name, sum(fee)  from student
where name = 'Huong';
/*	Lấy ra tên học viên, ko bị trùng lặp*/
select distinct name from student;
select name from student group by name;


