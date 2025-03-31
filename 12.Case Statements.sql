-- case statements
#allows to create logic in our query like what if else does in coding

select age,first_name,last_name,
case
	when age<=30 then 'Young'
end
from 
employee_demographics
;

#can add multiple when's inside the case
select first_name,last_name,age,
case
	when age<=30 then 'Young' 
    when age between 31 and 50 then 'Old'
    when age >50 then 'time to sleep'
end
from 
employee_demographics
;

-- can name the big colname as :-
select first_name,last_name,age,
case
	when age<=30 then 'Young' 
    when age between 31 and 50 then 'Old'
    when age >50 then 'time to sleep'
end as age_bracket

from 
employee_demographics
;

-- use case involving pay increase and bonus
-- <50000=5% hike
-- >50000=7% hike
-- finance dept=10% bonus

select first_name,last_name,
case
	when salary<50000 then salary*1.05
    when salary>50000 then salary*1.07
end as new_salary,
case
	when dept_id=6 then salary*.10 #dept id when 6 is the finance dept we know from the parks_dept table
end as bonus
from employee_salary
;

