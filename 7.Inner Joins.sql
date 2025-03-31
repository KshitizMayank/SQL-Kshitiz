-- JOINS

select * 
from employee_demographics;

select *
from employee_salary;

-- 1- INNER JOIN --gives all ROWS which are there IN BOTH TABLES. WHEN WE WRITE only JOIN IN THE QUERY BY DEFAULT IT MEANS INNER JOIN

SELECT *
FROM employee_demographics
INNER JOIN employee_salary #just writing JOIN would also work but INNER JOIN also proves no harm
	ON employee_id=employee_id #giving tab for readability of code
;#this code gives erorr saying emp id is ambiguous as it doesnt know which emp id is of which table


SELECT *
FROM employee_demographics
INNER JOIN employee_salary
	ON employee_demographics.employee_id= employee_salary.employee_id 
;
#when we see the output we see that emp id 2, which is Ron is not in the final output , but is originally present in the emp salary table
#this is because all the matching rows should be present. since 2 is only is emp salary and not in emp demo, hence it is not included

#employee_demographics.employee_id= employee_salary.employee_id #this line looks so big , hence we can use aliasing to shorten it 
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary as sal
	ON dem.employee_id= sal.employee_id 
;

select employee_id,age,occupation
FROM employee_demographics AS dem
INNER JOIN employee_salary as sal
	ON dem.employee_id= sal.employee_id 
; #we will get error as in the select statement we are askign for employee_id. but whose empid? demo's or salary's? we have to mention that

select dem.employee_id,age,occupation
FROM employee_demographics AS dem
INNER JOIN employee_salary as sal
	ON dem.employee_id= sal.employee_id 
; #now works. using tablename.colname is a good way to get that particular column in joins when there are same colnames in both the joining tables.




