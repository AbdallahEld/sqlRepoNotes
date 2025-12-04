--Security
--SQL server schema
--Object
--SchemaName.Objectname
--dbo database owner
--default schema
--logical group of objects

create schema HR

create schema sales

alter schema HR transfer student

alter schema HR transfer instructor

alter schema sales transfer department

select * from student  --dbo.student

select * from hr.student  

create table student
(
 id int,
 ename varchar(20)
)

create table sales.student
(
 id int,
 ename varchar(20)
)

select * from Student

--Security
--ITI  login+user
--permissions    student,Instructor   [HR]
----------------grant select ,insert
----------------Deny  update,delete
--10 steps of scurity
----change auth mode
----restart server
----create login
----create user
----create schema
----assign objects to schema
----link schema+user
----set Permissions
----disconnect & reconnect 
----test queries

drop schema HR

alter schema hr transfer course

select * into hr.course
from course

alter schema dbo transfer hr.instructor

alter schema dbo transfer sales.department

use AdventureWorks2012

select * from HumanResources.EmployeeDepartmentHistory

--fullpath
use ITI

select * from AdventureWorks2012.HumanResources.EmployeeDepartmentHistory

--shortcut Object
--synonym
create synonym EDH
for  AdventureWorks2012.HumanResources.EmployeeDepartmentHistory

select * from EDH
-----------------------------------------------------

--queries  + specific time
--Regular query + sch  ===> jobs   backup  12PM

--Create DB
--SQL server schema
--System dbs
--DB integrity
--constraints _ rules

create table depts
(
 did int Primary key,
 dname varchar(20)
)

create table emps
(
 eid int identity(1,1),
 ename varchar(20) ,
 eadd varchar(20) default 'cairo',
 hiredate date default getdate(),
 salary int,
 overtime int,
 netsal as isnull(salary,0)+isnull(overtime,0) persisted, --computed+saved
 bd date,
 age as year(getdate())-year(bd), --computed
 gender varchar(1),
 hour_rate int not null,
 dnum int,
 constraint c1 Primary key(eid,ename),--composite PK
 constraint c2 unique(salary), 
 constraint c3 unique(overtime),
 constraint c4 check(Salary>1000),
 constraint c5 check(overtime between 100 and 500),
 constraint c6 check(eadd in('alex','mansoura','cairo')),
 constraint c7 check(gender='f' or gender='m'),
 constraint c8 foreign key(dnum) references depts(did)
	on delete set null on update cascade
)

alter table emps drop constraint c4

alter table emps add constraint c10 check(hour_rate>1000)

alter table instructor add constraint c11 check(salary>1000)

--constraint ====> new data XXXXXX
--constraint ====> shared between tables XXXXX
--constraint ====> new data type  XXXXXX

---> Rule  ===> Global check constraint
create rule r1 as @x>1000

sp_bindrule r1,'instructor.salary'
sp_bindrule r1,'emps.overtime'

sp_unbindrule 'instructor.salary'
sp_unbindrule 'emps.overtime'

drop rule r1

----------------------------------------
create default def1 as 5000

sp_bindefault def1,'instructor.salary'

sp_unbindefault 'instructor.salary'

drop default def1
---------------------------------------------
---->New data type      int       value>1000       default 5000    

sp_addtype complexdt,'int'

create rule r1 as @x>1000

create default def1 as 5000

sp_bindrule r1,complexdt

sp_bindefault def1,complexdt

create table mystaff
(
 id int primary key,
 ename varchar(20),
 salary complexdt
)
----------------------------------------------
--Data types
------------
--Numeric DT
bit        --boolean   0:1    false:true
tinyint    --1B   0:255
smallint   --2B   -32768:+32767
int        --4B
bigint     --8B
--Decimal DT
smallmoney  --4B  .0000$
money       --8B  .0000P
real              .0000000
float             .0000000000000000000000
dec   decimal   dec(5,2)   324.33   1.4    18.432 XXXXXXX
--text DT
char(10)     --Array   fixed length string     ahmed 10    ali 10  على محمد ؟؟؟
varchar(10)  --variable length string   ahmed 5   ali  3
nchar(10)    unicode language   محمد على 
nvarchar(10) unicode language  محمد على 
nvarchar(max)  --up to 2GB
text --8000 char    old
--Data time
Date     MM/dd/yyyy
time     hh:mm:12.234
time(7)  hh:mm:12.2344342
smalldatetime   MM/dd/yyyy hh:mm:00          [range year up to 100]
datetime        MM/dd/yyyy hh:mm:ss.123      [range year 1753:9999]
datetime2       MM/dd/yyyy hh:mm:ss.1236432  [range year 1:9999]
datetimeoffset   11/11/2025 10:30 +2:00
--binary
binary   1000110   11010101  11111100101
image  byte[]
--others
XML
SQL_variant
uniqueidentifier
Geography
hierarchyid
-------------------------------------------------------