SELECT * 
FROM employee_demographics;

SELECT gender
FROM employee_demographics
group by gender;

SELECT first_name
FROM employee_demographics
group by gender; #no output because when using group by, the select ke sath going wala (here first name) should be in type of an aggregate function (sum,max,avg etc)or should be the same function written with group by(here gender)

SELECT gender,max(age)
FROM employee_demographics
group by gender; #example 1 of above statement

SELECT gender,avg(age)
FROM employee_demographics
group by gender; #example 2

select occupation
from employee_salary
group by occupation
;

select occupation,salary
from employee_salary
group by occupation,salary  #can use multiple group by's as well
;

#all aggregate functions
SELECT gender,avg(age), max(age),min(age),count(age) #count is giving here number of female and male ages
FROM employee_demographics
group by gender
;

#ORDER BY--SORT EITHER IN ASCNEDING OR DESCENDING ORDER
SELECT *
FROM employee_demographics
;

SELECT *
FROM employee_demographics
order by first_name #by default ascending order me hai
;

SELECT *
FROM employee_demographics
order by first_name DESC
;

SELECT *
FROM employee_demographics
order by gender,age #female goes before male in alphabet and also the age number is smaller increasing to higher for both male and female
;

SELECT *
FROM employee_demographics
order by age,gender #gender didnt even get used only as all age values are unique and hence we didnt requiring order by gender
;

SELECT *
FROM employee_demographics
order by 5,4 #can remember column names to use here but not adviced
;
