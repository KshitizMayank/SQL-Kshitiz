-- limit --for limiting the number of records that you want to see in the output
select * 
from employee_demographics
limit 3
; #will give only top 3 records

#can be used with order by for more advanced functioning

select * 
from employee_demographics
order by age desc
limit 3
;

select * 
from employee_demographics
order by age desc
limit 2,1 #from second position, give me the 1 next one
;

select * 
from employee_demographics
order by age desc
limit 1,2 
;
select * 
from employee_demographics
order by age desc
limit 0,3 
;

-- ALIASING --for giving alias names to the columns

select gender, avg(age)
from employee_demographics
group by gender
having avg(age)>40
;

select gender, avg(age) AS avg_age #now the name of avg(age) has been aliased to avg_age
from employee_demographics
group by gender
having avg_age>40
;

#but the AS is not even necessary

select gender, avg(age) avg_age #now the name of avg(age) has been aliased to avg_age
from employee_demographics
group by gender
having avg_age>40
;