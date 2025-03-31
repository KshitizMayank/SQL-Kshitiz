SELECT * 
FROM employee_salary
where first_name='Leslie';

SELECT * 
FROM employee_salary
where salary>50000;

SELECT * 
FROM employee_salary
where salary>=50000; #same with < and <=

SELECT * 
FROM employee_demographics
where gender!='female';

SELECT * 
FROM employee_demographics
where birth_date>'1985-01-01';

-- AND OR NOT LOGICAL OPERATORS----

SELECT * 
FROM employee_demographics
where birth_date>'1985-01-01'
AND GENDER='MALE'
;

SELECT *
FROM employee_demographics
WHERE (first_name='Leslie' AND age=44) OR age>55; #PEMDAS RULES APPLY HERE ALSO


#LIKE STATEMENT
# %-ANYTHING _-SPECIFIC

SELECT *
FROM employee_demographics
WHERE FIRST_NAME LIKE '%ER%';

SELECT *
FROM employee_demographics
WHERE FIRST_NAME LIKE 'A%';

SELECT *
FROM employee_demographics
WHERE FIRST_NAME LIKE 'A__';#TWO UNDESCORE DASHES MEANS ONLY TWO MORE CHARACTERS CAN FIT IN THERE, HENCE ANN ONLY OUTPUT

SELECT *
FROM employee_demographics
WHERE BIRTH_DATE LIKE '1989%';


