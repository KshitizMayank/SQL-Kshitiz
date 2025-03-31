-- SELF JOIN
#used when we want to tie the table with itself
#lets take an example when we want that one employee should be the secret santa of the employee who has emp id just +! of his. so empid 1 will be santa for empid 2 and so on

select emp1.employee_id as emp_santa,
emp1.first_name as first_name_santa,
emp1.last_name as last_name_santa,
emp2.employee_id as gift_receiver,
emp2.first_name as receiver_first_name,
emp2.last_name as reciever_last_name

from employee_salary as emp1
join employee_salary as emp2
	on emp1.employee_id+1=emp2.employee_id
;

-- JOINING MULTIPLE TABLES TOGETHER

select *
FROM employee_demographics AS dem
INNER JOIN employee_salary as sal
	ON dem.employee_id= sal.employee_id 
;

SELECT*
FROM parks_departments
;# we see that this table has a department id. so we can join it with the salary table which also has a dept id.alter

#we join the three tables as
select *
FROM employee_demographics AS dem
INNER JOIN employee_salary as sal
	ON dem.employee_id= sal.employee_id  #here the first two are joined, thats fine. to join the second with the third when the third has no connection with the first, we do so as:-
INNER JOIN parks_departments AS parks
	ON sal.dept_id=parks.department_id
;
