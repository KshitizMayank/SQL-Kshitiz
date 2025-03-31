-- subquery-query within a query

select * 
from employee_demographics
where employee_id in
    	(select employee_id
        from employee_salary
     where dept_id=1)#1,2,3,4,5,6,12.  the query inside the bracket is called inner query or subquery and the one before or outside is called outer query. the inner query is also called an OPERAND as it is beign operated by an OPERATOR , here, IN

;   #1,3,4,5,6,12 . not the 2 as we are selecting everything (*) from the dem table and it doesnt have 2. 
    
select * 
from employee_demographics
where employee_id in
    	(select employee_id
        from employee_salary
     where dept_id=1)
     ;     #here we are getting error that operand should contain 1 column. so we infer that the operand or the subquery can only select 1 column.


#compare the salary of the person to the average salary
select first_name,salary,avg(salary)
from employee_salary
;#asking us to use group by as we are using an aggregate function


select first_name,salary,avg(salary)
from employee_salary
group by first_name,salary
;#not the correct output

select first_name,salary,
(select avg(salary) from employee_salary)
from employee_salary
;#correct output


#using it on aggregate functions

select gender,max(age),min(age),avg(age),count(age)
from employee_demographics
group by gender
;

select *
from 
(select gender,max(age),min(age),avg(age),count(age)
from employee_demographics
group by gender) as age_table #can seelect everything from the same table as this way also but make sure to give an alias
;
#lets try accessing some particular cols of this new table

select avg(`max(age)`) #notice how i used a symbol called as back ticks to include the function name as a colname, otherwise it would have been faulty
from 
(select gender,max(age),min(age),avg(age),count(age)
from employee_demographics
group by gender) as age_table 
;

#can always use aliasing to make it simpler
select avg(maxi) 
from 
(select gender,
max(age) as maxi,
min(age) as mini,
avg(age) as avgu,
count(age) as contu
from employee_demographics
group by gender) as age_table 
;

select *
from 
(select gender,
max(age) as maxi,
min(age) as mini,
avg(age) as avgu,
count(age) as contu
from employee_demographics
group by gender) as age_table 
;

