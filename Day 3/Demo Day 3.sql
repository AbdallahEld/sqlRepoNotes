--insert based on select
insert into cairoStud(st_id,st_fname)
select id,name
from mansouraStud
-------------------------
--join +DML
--subquery +DML
delete from Stud_Course
where st_id in (select st_id from student
                where st_address='cairo')
---------------------
select st_fname+' '+convert(varchar(2),st_age)
from student

select 'stud name= '+st_fname+' &age= '+convert(varchar(2),st_age)
from student

select isnull(st_fname,'')+' '+convert(varchar(2),isnull(st_age,0))
from student

select concat(st_fname,' ',st_age)
from student

select db_name()

select suser_name()