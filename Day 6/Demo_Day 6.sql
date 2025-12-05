use ITI

declare @x int=(select avg(St_age) from Student)

set @x=10

select @x=100

select @x

declare @y int
	select @y=st_age from Student
	where st_id=5
select @y

declare @y int
	select @y=st_age from Student
	where st_id=-1
select @y

declare @y int
	select @y=st_age from Student
	where St_Address='alex'
select @y

--Arrays  ---> table variable
declare @t table(col1 int) --->1D array of integers
	insert into @t
	values(4),(7),(10)
select * from @t
select count(*) from @t

declare @t table(col1 int) --->1D array of integers
	insert into @t
	select st_age from Student where st_address='alex'
select * from @t
select count(*) from @t

declare @t table(col1 int,col2 varchar(20)) --->2D
	insert into @t
	select st_age,st_fname from Student where st_address='alex'
select * from @t
select count(*) from @t

declare @x int,@name varchar(20)
	select @x=st_age , @name=st_fname from Student
	where st_id=5
select @x,@name
declare @sal int
	update Instructor
		set ins_name='ahmed' , @sal=salary
	where ins_id=5
select @sal

-->variables dynamic queries

declare @par int=2

select * from Student
where st_id=@par


declare @par int=6

select top(@par)*
from Student

--metadata   --dynamic
declare @col varchar(20)='salary',@t varchar(20)='instructor'
execute('select '+@col+' from '+@t)

declare @col varchar(20)='*',@t varchar(20)='instructor',@cond varchar(20)='salary>5000'
execute('select '+@col+' from '+@t+' where '+@cond)

declare @col varchar(20)='st_fname',@t varchar(20)='student',@cond varchar(20)='st_age>25'
execute('select '+@col+' from '+@t+' where '+@cond)

select 'select * from student'
execute('select * from student')

--Global var
select @@SERVERNAME

select @@VERSION

update Instructor set Salary+=100
select @@ROWCOUNT

select * from Stud_Course where grade>150
select @@ROWCOUNT
select @@ROWCOUNT

select  * from Stud_Course where grade>150
go
select @@ERROR

insert into test values('ali')
select @@IDENTITY

select * from test
---------------------------------------------->
--control of flow statements
--if
declare @x int
	update Student set st_age+=1
select @x=@@ROWCOUNT
if @x>0
	begin
		select 'multi rows affected'
		select 'welcome to ITI'
	end
else 
	begin
		select 'zero rows affected'
	end
--begin end
--if exists   --if not exists

if exists(select name from sys.tables where name='myexam')
	select 'table is existed'
else
	create table myexam
	(
	id int,
	sname varchar(20)
	)


if not exists(select top_id from course where top_id=3)
	delete from topic where top_id=3
else
	select 'table has relationship'

begin try
	delete from topic where top_id=4
end try
begin catch
	select 'error'
	select ERROR_LINE(),ERROR_NUMBER(),ERROR_MESSAGE()
end catch

--while
--continue break
declare @x int=10
while @x<=20
	begin
		set @x+=1     --11  12  13 14 15 --16
		if @x=14
			continue  --condition
		if @x=16
			break      --exit
		select @x    --11  12 13 15
	end



--case iif
select ins_name ,salary,
                case
					when Salary>=5000 then 'high salary'
					when salary<5000 then 'low'
					else 'No data'
				end  as Nelcol
from Instructor

select ins_name ,iif(salary>=5000,'high','low')
from Instructor

--update   case
update Instructor
	set Salary=Salary*1.20

update Instructor
	set Salary=
				case
					when Salary>=5000 then Salary*1.10
					else Salary*1.20
				end

--waitfor
--choose
-------------------------------------------------------
--variables
--control of flow
--windowing function
--create function
----Scalar
--function       fun_name    return_val   Parameters   body

create function getsname(@sid int)
returns varchar(30)
	begin
		declare @name varchar(30)
			select @name=st_fname from Student
			where st_id=@sid
		return @name
	end
-----------
--call
select dbo.getsname(2)
alter schema hr transfer getsname
select hr.getsname(2)
alter schema dbo transfer hr.getsname
drop function getsname


----Inline
create function getinsts(@did int)
returns table
as
	return	
		(
		 select ins_name, salary*12 as annualsal
		 from Instructor
		 where Dept_Id=@did
		)

--calling
select * from getinsts(10)
select ins_name from getinsts(10)
select sum(annualsal) from getinsts(10)

----Multi
create function getstuds(@format varchar(20))
returns @t table
         (
		  id int,
		  sname varchar(20)
		 )
as
	begin
		if @format='first'
			insert into @t
			select st_id,st_fname from Student
		else if @format='last'
			insert into @t
			select st_id,st_lname from Student
		else if @format='fullname'
			insert into @t
			select st_id,concat(st_fname,' ',st_lname) from Student
		return 
	end

--calling
select * from getstuds('first')
----------------------------------------------------
--execute + function  XXXXXXX
create function getdata(..........)
returns .....
as
	return
		(
		  execute('')
		)
------------------------------------------------------
--bultin functions
---NULL values
select isnull(st_fname,'')
from Student

select coalesce(st_fname,st_lname,st_address,'no data')
from Student

--data conversion
select convert(varchar(50),getdate())
select cast(getdate() as varchar(50))

select convert(varchar(50),getdate(),101)
select convert(varchar(50),getdate(),102)
select convert(varchar(50),getdate(),103)
select convert(varchar(50),getdate(),104)
select convert(varchar(50),getdate(),105)

select format(getdate(),'dd-MM-yyyy')
select format(getdate(),'dddd-MMMM-yyyy')
select format(getdate(),'ddd-MMM-yy')
select format(getdate(),'dddd')
select format(getdate(),'MMMM')
select format(getdate(),'hh:mm:ss')
select format(getdate(),'hh')
select format(getdate(),'hh tt')
select format(getdate(),'dd-MM-yyyy hh:mm:ss tt')

select format(getdate(),'yyyy')   --return string
select year(getdate())  --return int

select eomonth(getdate())
select format(eomonth(getdate()),'dd')
select format(eomonth(getdate()),'dddd')

select eomonth(getdate(),+1)
select eomonth(getdate(),-2)

--system function
select db_name()

select suser_name()

select IDENT_CURRENT('test')

select SCOPE_IDENTITY()

select OBJECT_ID('student')

select OBJECT_ID('exam')

if OBJECT_ID('instructor') is not null
	select 'table is existed'

--Aggregate function
select count(st_id),count(st_fname)
from Student

--date
select getdate()
year   month day
select DATEDIFF(year,'1/1/2012','1/1/2025')
select DATEDIFF(month,'1/1/2012','1/1/2025')
select DATEDIFF(week,'1/1/2012','1/1/2025')
select DATEDIFF(day,'1/1/2012','1/1/2025')

--math
sin cos tan log power abs sqrt
select sqrt(25)
select abs(-5)

select power(Salary,2)
from Instructor

--string
select concat ('ahmed','1/1/2012','cairo',43434,NULL)
select concat_ws('  -  ','ahmed','1/1/2012','cairo',43434,NULL)

select upper(st_fname),lower(st_lname)
from Student

select len(St_fname)
from Student

select substring(St_fname,1,3)
from Student

select substring(St_fname,2,2)
from Student

select Max(len(st_fname))
from Student

select top(1) st_fname
from Student
order by len(st_fname) desc

select trim('   ahmed   ')
select Rtrim('   ahmed   ')
select Ltrim('   ahmed   ')

select REVERSE('ahmed')
select REPLICATE('ahmed',3)

select REPLICATE(st_fname,3)
from Student

select st_fname+space(10)+st_lname
from Student

select CHARINDEX('a','mohamed')
select CHARINDEX('x','mohamed')

select CHARINDEX('a',st_fname)
from Student

select REPLACE('ahmed$gmail.com','$','@')

select stuff('ahmedomarkhalid',6,4,'ali')

--logical
--iif

select isdate('1/1/2000')
select isdate('1/10000')

select isnumeric('434e')
select isnumeric('434')

select str(st_id)
from Student