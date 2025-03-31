-- OUTER JOINS
#for outer joins we have a LEFT JOIN and a RIGHT JOIN or a LEFT OUTER or RIGHT OUTER join

#LEFT JOIN- everything (all rows) on the left table even if there is no match in the join and then only return the matches(rows) from the right table
select *
FROM employee_demographics AS dem
LEFT JOIN employee_salary as sal #either writing left join or left outer join both works
	ON dem.employee_id= sal.employee_id 
;

#RIGHT JOIN- just the exact opposite of left join
select *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary as sal #either writing left join or left outer join both works
	ON dem.employee_id= sal.employee_id 
; #see how Ron swanson is present in the final output as it was already there in the salary table and for the demo table it shows as null

