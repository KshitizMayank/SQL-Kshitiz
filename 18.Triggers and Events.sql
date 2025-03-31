-- Triggers and Events
-- trigger is a block of code which automatically executes when some event takes place

-- lets create a trigger that when we insert a new row into emp salary , it also goes in the emp demo table

delimiter $$
create trigger emp_entry
	after insert on employee_salary
    for each row 
begin
	insert into employee_demographics(employee_id,first_name,last_name)
    values(new.employee_id,new.first_name,new.last_name)
    ;
end $$
delimiter ;

-- now we have created the trigger.lets enter a new record in emp salary table
 insert into employee_salary values(13,'Kshitiz','Mayank','Biz Analyst',35000,NULL);
 -- verifying the entry
 select * from employee_salary;
 -- verifying if the trigger worked 
 select * from employee_demographics; -- it did
 
 -- events
 -- takes place when it is scheduled.
 
 -- lets say we want to remove the people who are over 60 and cause an event so it can be checked every month, year or some stipulated time
 select *
 from employee_Demographics;
 
 delimiter $$
 create event delete_retirees
 on schedule every 30 second
 do
 begin
	delete
    from employee_demographics
    where age>=60
    ;
end $$
delimiter ;

show variables like'event%'; -- to check if event scheduler is on or no


    
    
        