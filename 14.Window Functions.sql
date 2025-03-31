-- window functions
-- allow us to look over a portion of data
select gender,avg(salary) as avg_sal
from employee_demographics as dem
join employee_salary as sal on
	dem.employee_id=sal.employee_id
group by gender
;-- we see how on using group by everything gets rolled up to just 2 cols
	
    
select gender,avg(salary) over()
from employee_demographics as dem
join employee_salary as sal on
	dem.employee_id=sal.employee_id
;#here we are looking the average salary for everyone. it is different from group by as group by just 2 colms male and female. here multiple

select gender,avg(salary) over(partition by gender)
from employee_demographics as dem
join employee_salary as sal on
	dem.employee_id=sal.employee_id
;-- used partition by to get individual avg salary of male and females

#where does the differnece lie between the windown function and the group by
-- see here

select dem.first_name,dem.last_name,gender,avg(salary) over(partition by gender)
from employee_demographics as dem
join employee_salary as sal on
	dem.employee_id=sal.employee_id
;#the avg salary colmn remains unchanged even after asking for new cols, here fname and lname

select dem.first_name,dem.last_name,gender,avg(salary) as avg_sal
from employee_demographics as dem
join employee_salary as sal on
	dem.employee_id=sal.employee_id
group by dem.first_name,dem.last_name,gender
;#the value is getting changed on requesting new info 

-- trying other examples of window functions
select dem.first_name,dem.last_name,gender,
sum(salary) over(partition by gender) as sum
from employee_demographics as dem
join employee_salary as sal on
	dem.employee_id=sal.employee_id
;#so here we are getting the sum of salaries of male and female

#rolling total example
select dem.first_name,dem.last_name,gender,salary,
sum(salary) over(partition by gender order by dem.employee_id) as rolling_total #we can see how the total/sum of the salary is rolled up as final by one by one addition
from employee_demographics as dem
join employee_salary as sal on
	dem.employee_id=sal.employee_id
;    


-- row number
select dem.employee_id,dem.first_name,dem.last_name,gender,salary,
row_number() over() #over without any condition inside it means over entire data
from employee_demographics as dem
join employee_salary as sal on
	dem.employee_id=sal.employee_id
; 

select dem.employee_id,dem.first_name,dem.last_name,gender,salary,
row_number() over(partition by gender)
from employee_demographics as dem
join employee_salary as sal on
	dem.employee_id=sal.employee_id
; 

select dem.employee_id,dem.first_name,dem.last_name,gender,salary,
row_number() over(partition by gender order by salary desc)
from employee_demographics as dem
join employee_salary as sal on
	dem.employee_id=sal.employee_id
;
 -- rank
 
 select dem.employee_id,dem.first_name,dem.last_name,gender,salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num
from employee_demographics as dem
join employee_salary as sal on
	dem.employee_id=sal.employee_id
;#for duplicate same number and the next valid number is the positional value of the record. as andy was on 7th so it got 7th.

-- dense rank--for getting the next number positionally only in case of duplicates we use dense rank
 select dem.employee_id,dem.first_name,dem.last_name,gender,salary,
row_number() over(partition by gender order by salary desc) as row_num,
rank() over(partition by gender order by salary desc) as rank_num,
dense_rank() over(partition by gender order by salary desc) as dense_rank_num
from employee_demographics as dem
join employee_salary as sal on
	dem.employee_id=sal.employee_id
;
