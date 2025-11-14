select * from Student

select *
from Student
where St_Address = 'cairo'

select top(5)*
from Student

select top(5) st_fname ,st_age
from Student

select top(1)*
from Student

select top (1)*
from Student
where st_address = 'alex'

select Max(salary)
from Instructor

select top(2) Max(salary)
from Instructor

--execution order ===> from select order top
select top(2) salary
from Instructor
order by salary desc

--fullpath
--[ServerName].[DRName].[SchemaName].[objectname]

select *
from Student

select *
from [Rami].[ITI].[dbo].student

use ITI

select *
from Project -- ITI.dbo.Project

select *
from Company_SD.dbo.Project

select dept_name from Department
union all
select dname from Company_SD.dbo.Departments

--newid built in function GUID

select newid();

select * , newid() as Xid
from Student

select *, newid() as Xid
from Student
order by Xid

select top(1)*
from Student

select top(1)*
from Student
order by newid()

select top(10)*
from questions
order by newid()
---------------------------------------------------------
--select into
--DDL
--create table from existing one
select * into tab2
from Student

select * into tab3
from Student

select st_id,st_fname into tab5
from Student
where St_Address = 'cairo'

select * into Company_SD.dbo.Student
from Student

select * into tab7
from Student
where 1=2 -- false condition only structure will be copied no data

--insert based on select
insert into tab5(st_id,st_fname)
values(666,'ahmed')

insert into tab5(st_id,st_fname)
values(66,'ahmed') ,(55,'ali'),(88,'eman')

insert into tab5
select st_id,st_fname from Student where St_Address='alex'

--bulk insert
--insert data from file
bulk insert tab5
from 'E:\mydata.txt'
with(fieldterminator=',')


select *
from (select *,ROW_NUMBER() over(order by st_age desc) as RN
      from Student) as newtable
where RN=1

select *
from (select *,Dense_rank() over(order by st_age desc) as DR
      from Student) as newtable
where DR=1

select *
from (select *,NTile(3) over(order by st_age desc) as G
      from Student) as newtable
where g=1


select *
from (select *,ROW_NUMBER() over(Partition by dept_id order by st_age desc) as RN
      from Student) as newtable
where RN=1

select *
from (select *,Dense_rank() over(Partition by dept_id order by st_age desc) as DR
      from Student) as newtable
where DR=1

select *
from (select *,NTile(2) over(Partition by dept_id order by st_id desc) as G
      from Student) as newtable
where g=1 and Dept_Id=10

select *
from (select *,NTile(2) over(Partition by dept_id order by st_id desc) as G
      from Student) as newtable
where g=1 
----------------------------------------------------------------------------------------------
--Transact-SQL
--top  newid  selectinto bulkinsert  Ranking

--bultin functions
getdate()  year month day  coalesce  isnull convert

select st_fname ,st_lname
from Student

select upper(st_fname) ,lower(st_lname)
from Student

select len(St_fname) , st_fname
from Student

select SUBSTRING(st_fname,1,3)
from Student

select SUBSTRING(st_fname,3,3)
from Student

select SUBSTRING(st_fname,1,len(st_fname)-1)
from Student

select *
from Student
where len(st_fname)>4

select datediff(year,'1/1/2010','1/1/2012')
select datediff(month,'1/1/2010','1/1/2012')
select datediff(day,'1/1/2010','1/1/2012')

select st_fname+' '+convert(varchar(20),st_age)
from Student

select isnull(st_fname,'')+' '+convert(varchar(20),isnull(st_age,0))
from Student

select concat(st_fname ,' ',st_age)
from Student

select concat('ahmed',4343,'cairo','1/1/2000',NULL,'ali',NULL)
select concat_ws('  &  ','ahmed',4343,'cairo','1/1/2000',NULL,'ali',NULL)

use AdventureWorks2012

select * from department  ---dbo.department

select * from HumanResources.department 
