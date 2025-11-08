create database test_1
-- Create Table emp

--DDL
--create table

create table emp 
(
Eid int primary key,
Ename varchar(15),
salary int
addres varchar(50) default 'cairo'
)

alter table emp
add did int

create table dept
(
did int primary key,
deptname varchar(50)
)

drop table emp

--DML
--insert
insert into student(st_id,st_fname)
values(400, 'khaled')

insert into student(st_id,st_fname,st_lname,st_age,st_super,dept_id)
values(400,'khalid')

insert into student
values(400, 'khalid' , 'ali' , 'cairo',22,10,1)

--row constructor
insert into student
values(402,'khalid','ali',22,10,1),
      (403,'khalid','ali',22,10,1),
      (404,'khalid','ali',22,10,1),


--update
update student
set st_age=25

update student
set st_age = 25
where st_id = 3

--delete
delete from student
where st_id = 400

truncate table student

--DQL
--select
select *
from student

select st_id,st_fname
from student

select st_fname + ' '+st_lname as [full name]
from student

select *
from student
where st_age> 25 and st_age < 30

select *
from student
where st_age between 26 and 29

select * from student 
where st_address = 'alex' or st_address = 'cairo'

select * from student
where st_address in ('cairo' , 'alex' , 'mansoura')

--like
select *
from student
where st_fname like 'a%' -- % mean zero or more character

select *
from student where st_fname like 'a__' -- _ mean one character

select *
from student where st_lname is null