create database library_management;
use library_management;
create table student (
student_IDnumber int auto_increment,
student_name varchar(30),
email varchar(20),
image varchar(50),
primary key (student_IDnumber)
);

create table book (
book_id int primary key,
book_name varchar(20),
category_number int,
foreign key (category_number) references category(category_id)
);

create table category (
category_id int primary key
);

create table address (
student_id int,
address varchar(20),
foreign key (student_id) references student(student_IDnumber)
);

create table borrow_ticket (
id_ticket int primary key,
student_id int,
book_id int,
limit_day int default 7,
fired_each_day double,
status varchar(20),
borrowed_day date,
returned_day date,
foreign key (student_id) references student(student_IDnumber),
foreign key (book_id) references book(book_id)
);
select student.student_name,book.book_name, borrow_ticket.status from student inner join borrow_ticket 
inner join book on student.student_IDnumber = borrow_ticket.student_id 
and borrow_ticket.book_id = book.book_id
where status = 'borrowing';
/*Hiển thị tên sv, tên sách của những sv đang mượn từ bảng STUDENT - BORROW_TICKET (đk: student_IDnumber = student_id)
và bảng STUDENT - BOOK*/

select student.student_name, book.book_name, borrow_ticket.status from student inner join book
inner join borrow_ticket on borrow_ticket.book_id = book.book_id
and student.student_IDnumber = borrow_ticket.student_id
where status = 'returned';
