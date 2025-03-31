select gender,avg(age)
from employee_demographics
where avg(age)>40 
group by gender
; #no output as says invalid use of group by function. as when we want to work with aggregated function columns(like on which agg functions can be used) with group by ,only having is recommended and not where


select gender,avg(age)
from employee_demographics
group by gender
having avg(age)>40
;

#but its not like that we cant use where when group by is getting used. below example shows that

select occupation,avg(salary)
from employee_salary
where occupation like '%manager%'
group by occupation
having avg(salary)> 75000
; #works


