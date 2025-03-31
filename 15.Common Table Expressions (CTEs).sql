-- from here on we are starting the advanced sql series
-- CTEs- common table expressions
-- allows to define a subquery block that can be referenced in the main query
-- can be used just after its declaration


select gender,avg(salary) as avg_sal,max(salary)as max_sal,min(salary)as min_sal,count(salary)as count_sal
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id=sal.employee_id
group by gender
;-- this is a query that we want to make a CTE of. how do we make it..see below

WITH CTE_Example AS
(
select gender,avg(salary) as avg_sal,max(salary)as max_sal,min(salary)as min_sal,count(salary)as count_sal
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id=sal.employee_id
group by gender
)
select * 
from cte_example
; -- we see that we are getting the same output of the above query what we got of it independently.
-- the difference between the above CTE and subquery is that of readability. a cte is much more simple.

-- the same cte in form of a subquery
select avg(avg_sal)
from
(
select gender,avg(salary) as avg_sal,max(salary)as max_sal,min(salary)as min_sal,count(salary)as count_sal
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id=sal.employee_id
group by gender
) as sub_sal
;

-- one feature of CTE is that when we have made it , we can only use it just after its declaration and not after. for example
select * 
from cte_example; -- this wont work now

-- we can create multiple CTE's in one block and can also join on them. for example

WITH cte_ex1 as
(
select employee_id,gender ,birth_date
from employee_demographics as dem
where birth_date>'1985-01-01'
),
cte_ex2 as
(
select employee_id,salary
from employee_salary as sal
where salary >50000
)
select * 
from cte_ex1 
join cte_ex2 
on cte_ex1.employee_id=cte_ex2.employee_id
;

-- final thing on cte is we will see how we can just rename the colnames from the firstline itself rather than using as in the query
WITH CTE_Example (GENDER,AVERAGE_SALARY,MAXIMUM_SALARY,MINIMUM_SALARY,COUNT_OF_SALARY) AS
(
select gender,avg(salary) as avg_sal,max(salary)as max_sal,min(salary)as min_sal,count(salary)as count_sal
from employee_demographics as dem
join employee_salary as sal
	on dem.employee_id=sal.employee_id
group by gender
)
select * 
from cte_example
;-- notice how we were able to change/overwrite the colnames of the colmns that we were taking

