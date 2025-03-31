select length('skyfall');

select first_name,length(first_name)
from employee_demographics
order by length(first_name)
;

select upper('skyfall');
select lower('SKYFALL');

select ('                  sky             ');
select trim('                  sky             ');#all leading and trailing
select ltrim('                  sky             ');#all on left
select rtrim('                  sky             ');#all on right

select first_name,
LEFT(first_name,4),#number of chars from left
RIGHT(first_name,3),#number of chars from right
SUBSTRING(first_name,3,2),#start at 3rd char and take 2 chars including the 3rd char
birth_date,
SUBSTRING(birth_date,1,4) as birth_year,
SUBSTRING(birth_date,6,2) as birth_month,
SUBSTRING(birth_date,9,2) as birth_date
from employee_demographics
;

select first_name, replace(first_name,'A','Z') #NOTE that this function is case sensitive
from employee_demographics
;

select LOCATE('Z','Kshitiz'); #this is not case sensitive3
select first_name,locate('an',first_name)
from employee_demographics
;

select first_name,last_name,
concat(first_name,' ',last_name) as full_name
from 
employee_demographics
;