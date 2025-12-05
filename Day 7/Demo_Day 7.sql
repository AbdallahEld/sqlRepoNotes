create clustered index i2
on student(St_fname)

create nonclustered index i2
on student(St_fname)

create nonclustered index i3
on student(St_address)

select * from Student
where st_id=1

select * from grades
where sid=1

--> Primary key constraint ====> clustered index
--> unique constraint =========> nonclustered index

create table mydata
(
 eid int identity,
 ssn int primary key,
 ename varchar(20),
 salary int unique,  --unique constraint + nonclustered index
 overtime int unique,
 constraint c21 check(Salary>1000)
)

create unique index i7   -->unique constraint + nonclustered index
on student(st_age)

create index i7   -->nonclustered index
on student(st_age)


select * from Instructor where Salary=5000

select * from course where Crs_Duration=90

--------------------------
--types of tables
-----------------
--physical table
create table exam 
(
 id int,
 edate date,
 Sub varchar(20)
)

select * from exam

insert into exam values(1,'1/1/2026','OOP')

drop table exam

--variable table
declare @exam table
		(id int,edate date,Sub varchar(20))
insert into @exam values(1,'1/1/2026','OOP')
select * from @exam

--local table
create table #exam 
(
 id int,
 edate date,
 Sub varchar(20)
)

insert into #exam values(1,'1/1/2026','OOP')
select * from #exam

--global table
create table ##exam 
(
 id int,
 edate date,
 Sub varchar(20)
)

------------------------------------------

create view vstuds
as
	select * from student

--calling
select * from vstuds

create view vcairo(sid,sname,sadd)
as
	select st_id,st_fname,st_address
	from Student
	where St_Address='cairo'

--calling
select * from vcairo
select sname from vcairo
alter schema hr transfer vcairo
select * from hr.vcairo
alter schema dbo transfer hr.vcairo
drop view vcairo

create view valex(sid,sname,sadd)
as
	select st_id,st_fname,st_address
	from Student
	where St_Address='alex'

select * from valex

create view vcairo_alex
as
	select * from valex
	union all	
	select * from vcairo

select * from vcairo_alex

--complex queries
alter view vjoin(sid,sname,did,dname)
with encryption
as
	select St_Id,St_Fname,d.Dept_Id,Dept_Name
	from Student S  inner join Department d
	on d.Dept_Id = s.Dept_Id

select * from vjoin

sp_helptext 'vjoin'


select sname,dname from vjoin

create view vgrades
as
	select sname,dname ,grade
	from vjoin v inner join Stud_Course sc
	on v.sid=sc.St_Id

select * from vgrades

--DML + view
----view   one table
alter view valex(sid,sname,sadd)
as
	select st_id,st_fname,st_address
	from Student
	where St_Address='alex'
with check option

insert into valex
values(66,'ahmed','alex')

insert into valex
values(710,'ahmed','mansoura')

select * from valex

---view multi tables
create view vjoin(sid,sname,did,dname)
as
	select St_Id,St_Fname,d.Dept_Id,Dept_Name
	from Student S  inner join Department d
	on d.Dept_Id = s.Dept_Id


--Delete XXXXX
--insert   update
insert into vjoin(sid,sname)
values(55,'ahmed')

insert into vjoin(did,dname)
values(4000,'cloud')

update vjoin
	set sname='ahmed'
where sid=1

insert into vjoin
values(55,'ahmed',4000,'cloud')

update vjoin
	set sname='ahmed',dname='hr'
where sid=1
