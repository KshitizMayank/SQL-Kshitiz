SELECT * 
FROM employee_demographics; 

SELECT * 
FROM parks_and_recreation.employee_demographics; #another way to get the table . database.tablename

SELECT first_name
FROM employee_demographics;

SELECT first_name,last_name,employee_id #multiple cols
FROM employee_demographics;

SELECT first_name,
last_name,
employee_id,
age+10 #important to note that sql follows #PEMDAS rule. parantheses,exponent,multiplication,division,addn,subtracn
FROM employee_demographics;


SELECT gender
FROM employee_demographics;

SELECT DISTINCT gender #only unique values
From employee_demographics;

SELECT DISTINCT first_name, gender
FROM employee_demographics;


