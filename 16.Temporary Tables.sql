-- Temporary Tables
-- only created for the particular session. for ex, if i create a temp table now, close mysql, re run it, then the table wont be there
-- used primarliy for storing intermediate results before publishing them in the final tables

create temporary table temp_table
(
first_name varchar(100),
last_name varchar(100),
fav_movie varchar(100)
); -- if we do create table, normal table will be created and will be shown in schema. but since this is a temp table

select * 
from temp_table
;

insert into temp_table
values('Kshitiz','Mayank','Ravi Kumar')
;

select * from temp_table;
 -- lets see how we can get a portion of a real table to show in our temp table
 
 create temporary table salary_over_50k
 select * 
 from employee_salary
 where salary>=50000
 ;
 
 select * from salary_over_50k; -- if i close the current mysql session and run thsi again, i wont get the results. as this is a temp table.