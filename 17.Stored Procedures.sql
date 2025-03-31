-- stored procedure
-- help in reusing the sql code like what we do with functions in programming

select *
from employee_salary
where salary>=50000
; -- lets create a procedure for this

create procedure large_salaries() -- these brackets are necessary
select *
from employee_salary
where salary>=50000
;-- after executing this  we can see that in the lhs,under stores procedures , large salaries has been created

-- how to call? just use call or can click on the lightning bolt icon in lhs beside the procedure name. altho itll open it in a new window.

call large_salaries();

-- how to include multiple queries in one procedure. vvi

create procedure salaries()
select *
from employee_salary
where salary>=50000
;
select *
from employee_salary
where salary<50000
;
-- this wont work as the first semicolon will mark termination and the below query will just fetch output.. it is because ; is being treated as the ending point
-- but what if we change that

delimiter $$
create procedure salaries()
BEGIN 
	
	select *
	from employee_salary
	where salary>=50000
	;
	select *
	from employee_salary
	where salary<50000
	;		
END $$
delimiter ; -- make sure to reverse it back or else $$ will be set as default terminator

call salaries;

-- lets create a stored procedure from the lhs schema side
-- go to stored procedure, right click ->new procedure. then put the required query and apply

-- parameters
-- are variables that are passed as inputs in a SP
-- allows SP to receive an input value


delimiter $$
create procedure salaries3(employee_id_parameter INT) -- the emp id parameter can be named anything but make sure to assign the right data type of what you want to input.here int
BEGIN  
	
	select salary
	from employee_salary
	where employee_id=employee_id_parameter
    ;
	
END $$
delimiter ;

call salaries3(3); -- given the input as int


