-- UNION
#Allows to combine rows together
#we do so by combining two select statements together using UNION

select first_name,last_name
from employee_demographics
UNION
select first_name,last_name
from employee_salary
;#by default we see that only unique values have been printed. we make an inference here that when we just write UNION it means UNION DISTINCT.so writing both have the same effect

select first_name,last_name
from employee_demographics
UNION DISTINCT
select first_name,last_name
from employee_salary
;

select first_name,last_name
from employee_demographics
UNION ALL #This gives us duplicate values as well
select first_name,last_name
from employee_salary
;
#lets consider a use case where the company wants to know who are old and are highly paid so they can be cut off later

select first_name,last_name,'Old Man' AS LABEL #helps to create label and prints the value inside the single quotes when an entry is found
from employee_demographics
where age>40 AND gender='MALE'
UNION
select first_name,last_name,'Old Lady' As Label
from employee_demographics
where age>40 AND gender='Female'
UNION
select first_name,last_name,'Highly Paid' AS LABEL
from employee_salary
where salary>70000
order by first_name,last_name #to get in alphabetical order
;

select first_name, 'halla' as label #confirming our label logic that for all the records prints the value under single quotes
from employee_demographics
;