-- data cleaning

select *
from layoffs;

-- jobs we will do
-- 1. Remove Duplicates
-- 2.Standarize the data
-- 3.Null Values or Blank Values
-- 4.Remove Any Columns

-- now first of all is that our layoffs table is the only raw data available to us. and we wouldnt want to do chherchaar with it.
-- so we create a staging table that is the duplicate of our main table. uspe changes krke we can do chherchhar aram se

create table layoffs_staging
like layoffs;

select *from layoffs_staging; -- only the cols as of now. lets get the data

insert into layoffs_staging
select *
from layoffs
;-- now all data is showing in this table also

--                                  1. remove duplicates--------------------------------------------------------------------------------------------

-- for removing duplicates it would be good if we use the row number function as it tells us the uniqueness of the particular record

select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
from layoffs_staging
; -- now we know that whoever has row number 1 is only 1 in the table. whoever has 2 or more than 1 has multiple rows of it. so lets find them

with duplicate_finder_cte as
(
select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
from layoffs_staging

)
select * 
from duplicate_finder_cte
where row_num>1
; -- gives us all the rownums having 2. 

-- how about we want to delete them directly from the cte itself?
with duplicate_finder_cte as
(
select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
from layoffs_staging

)
delete
from duplicate_finder_cte
where row_num>1
;-- getting error that a cte is not updatable

-- so the approach that we are taking here to delete is that. we will create a new staging table and put the entire data along with the row nums now and delete all row nums>1

-- creating new table layoffs_staging2
-- can just copy to clipboard from the earlier staging table in the lhs and just put row num as a new col
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
  
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * from layoffs_Staging2;-- cols have been added, now add the data

insert into layoffs_staging2
select *,
row_number() over(
partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) AS row_num
from layoffs_staging
;-- data updated

select * 
from layoffs_staging2
where row_num>1;

-- now delete them
delete
from layoffs_staging2
where row_num>1; -- it might happen(happened with me) that safe update option be on which prevents update and delete commands. so to disable that. go to edit->preferences->sql editor->untick that box of safe updtes

-- verify
select * 
from layoffs_staging2
where row_num>1; -- all deleted

--  -------------------------------                          2.Standarizing data ---------------------------
-- we see that comapny column has company names with no trims. like there are unwanted white spaces
select company 
from layoffs_Staging2;

select company,trim(company)
from layoffs_staging2; -- now we can see the difference of how it got trimmed

-- now we saw the comparison of how the trimmed data of company looks. but we want to set it as the main company column. so we want to update it. 
update layoffs_staging2
set company=trim(company)
; -- now if we run the previous command we can see that company has been updated 

-- now look at this
select distinct industry
from layoffs_staging2
order by industry; -- to get in alphabetic manner of industry
-- we see now that there is one industry of crypto. which has different namings . crypto cryptocurrency and crypto currency are all the same thing

select * 
from layoffs_Staging2 
where industry like 'crypto%'; -- we can see that there are rows with this discrepancyu

update layoffs_staging2
set industry='Crypto'
where industry like 'Crypto%';

-- verify
select distinct industry
from layoffs_staging2
order by industry; -- we see now only crypto is there

-- lets check for other colmns
-- location
select distinct location
from layoffs_Staging2
order by location; -- all look similar

-- country
select distinct country
from layoffs_staging2
order by 1; -- rather than writing country can write just 1 as it is the only colm
-- we see issue with USA. United States and United States. , the dot is the issue here

select distinct country,trim(trailing '.' from country)
from layoffs_staging2
order by 1;-- we solved using this. now update in table

update layoffs_staging2
set country=trim(trailing '.' from country)
where country like 'united states%'
;-- solved and updated


-- now one change we want to do is convert data type of date colm from text to data. how do we know its text atm?go lhs in schema. go ls2,columns,date, click and below youll see in definition that it is a text data type
-- way to convert date colm from text to date

select `date`, -- using back ticks to ensure that we want to select the date column only as date is also a keyword
str_to_date(`date`,'%m/%d/%Y') -- make sure the format whatever be mm dd or dd mm, the m and d along with % should always be in lowercase as uppercase M and D have different meanings. and also Y should always be capital
from layoffs_staging2
;
-- now lets update the date colm in the main ls2 table

update layoffs_staging2
set `date`=str_to_date(`date`,'%m/%d/%Y')
;-- updated

select `date` from layoffs_staging2; -- verified
-- but the job is not complete. our aim was to change the data type of date colm from text to date. altho we changed the format of date written inside the colm , but the type still shows as text for date colm
-- we change the date type as

alter table layoffs_staging2
modify column `date` DATE; -- now it is a date colm with date dt. also make sure not to use alter table command with raw tables. always do it with staging tables

-- ----------------------------------------------------------------- 3. dealing with NULL values or BLANK values ------------------------------------
-- POPULATING NULL VALUES
select * from 
layoffs_staging2; -- we see that many colmns have null. first colm is total laid off. so lets deal with it

select * from 
layoffs_staging2
where total_laid_off is null -- fetches all null records of tlo. also note that is null and = null arent same. if you try where total laid off=null. it wont work
and percentage_laid_off is null;

-- looking at the industry colm for a sec
select distinct industry
from layoffs_staging2; -- it also has some null and blanks, lets look into it

select *
from layoffs_staging2
where industry is null
or industry='';-- lets look at airbnb

select *
from layoffs_staging2
where company='Airbnb';

-- we see that airbnb in one record has the industry name, in the other it doesnt. so it only makes sense to put the industry name of airbnb in the other record as well
-- lets do a join condition

select *
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company=t2.company
where (t1.industry is null or t1.industry='')
and t2.industry is not null
;

-- seeing the indsutry in retrospect
select t1.industry,t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
	on t1.company=t2.company
where (t1.industry is null or t1.industry='')
and t2.industry is not null
;
-- now is the time for update now we know which all columns need to be populated. in the video , alex found a problem with blank values populating. so rather he converted those blank values into null values only for unity
update layoffs_staging2
set industry=null
where industry='';-- all blank done into null now

-- now final update
update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company=t2.company
set t1.industry=t2.industry
where t1.industry is null
and t2.industry is not null;

-- verification
select *
from layoffs_staging2
where company='Airbnb'
;

-- DELETING 100% useless rows
-- we note that from earlier query that both total laid off and % laid off, if it is null, then it is no use of us and we can delete that

select * from 
layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;

delete 
from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null; -- deleted

-- verification
select * from layoffs_staging2;


-- -------------------------------------------------------------------------------4. REMOVING ANY COLUMNS------------------
alter table layoffs_staging2
drop column row_num;

select * from layoffs_staging2; -- row num is dropped
















