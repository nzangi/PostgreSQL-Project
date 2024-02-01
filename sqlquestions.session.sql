create table users
(
user_id int primary key,
user_name varchar(30) not null,
email varchar(50));

insert into users values
(1, 'Sumit', 'sumit@gmail.com'),
(2, 'Reshma', 'reshma@gmail.com'),
(3, 'Farhana', 'farhana@gmail.com'),
(4, 'Robin', 'robin@gmail.com'),
(5, 'Robin', 'robin@gmail.com');

--@block
SELECT users.user_id,users.user_name,users.email
 FROM users INNER JOIN(
SELECT user_name,email FROM users GROUP BY
user_name,email HAVING count(*)>1) as dup on 
users.user_name = dup.user_name LIMIT 1;
;



---@block
SELECT users.user_id,users.user_name,users.email
FROM users JOIN(
SELECT user_name,email FROM users GROUP BY  user_name,email
HAVING count(*) >1) as dup ON
users.user_name = dup.user_name AND users.email =
dup.email LIMIT 1;

--@block
create table employee
( emp_ID int primary key
, emp_NAME varchar(50) not null
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);


--@block
SELECT * FROM (SELECT * ,row_number() OVER (ORDER BY
emp_id DESC) as rn FROM employee
) x WHERE rn=2;



--@block
SELECT * FROM(
SELECT *,row_number() 
OVER(ORDER BY emp_id DESC) as rn FROM employee)
x WHERE rn=2;

--@block
create table employee
( emp_ID int primary key
, emp_NAME varchar(50) not null
, DEPT_NAME varchar(50)
, SALARY int);

insert into employee values(101, 'Mohan', 'Admin', 4000);
insert into employee values(102, 'Rajkumar', 'HR', 3000);
insert into employee values(103, 'Akbar', 'IT', 4000);
insert into employee values(104, 'Dorvin', 'Finance', 6500);
insert into employee values(105, 'Rohit', 'HR', 3000);
insert into employee values(106, 'Rajesh',  'Finance', 5000);
insert into employee values(107, 'Preet', 'HR', 7000);
insert into employee values(108, 'Maryam', 'Admin', 4000);
insert into employee values(109, 'Sanjay', 'IT', 6500);
insert into employee values(110, 'Vasudha', 'IT', 7000);
insert into employee values(111, 'Melinda', 'IT', 8000);
insert into employee values(112, 'Komal', 'IT', 10000);
insert into employee values(113, 'Gautham', 'Admin', 2000);
insert into employee values(114, 'Manisha', 'HR', 3000);
insert into employee values(115, 'Chandni', 'IT', 4500);
insert into employee values(116, 'Satya', 'Finance', 6500);
insert into employee values(117, 'Adarsh', 'HR', 3500);
insert into employee values(118, 'Tejaswi', 'Finance', 5500);
insert into employee values(119, 'Cory', 'HR', 8000);
insert into employee values(120, 'Monica', 'Admin', 5000);
insert into employee values(121, 'Rosalin', 'IT', 6000);
insert into employee values(122, 'Ibrahim', 'IT', 8000);
insert into employee values(123, 'Vikram', 'IT', 8000);
insert into employee values(124, 'Dheeraj', 'IT', 11000);

--@block
SELECT e.emp_ID,e.emp_NAME,e.DEPT_NAME,e.salary,max_salary.max_salary 
FROM employee as e INNER JOIN(
    SELECT DEPT_NAME, max(salary) as max_salary FROM employee  GROUP BY DEPT_NAME) 
    as max_salary 
    ON e.salary = max_salary.max_salary AND
    e.DEPT_NAME = max_salary.DEPT_NAME

UNION

SELECT e.emp_ID,e.emp_NAME,e.DEPT_NAME,e.salary,min_salary.min_salary 
FROM employee as e INNER JOIN(
    SELECT DEPT_NAME, min(salary) as min_salary FROM employee  GROUP BY DEPT_NAME) 
    as min_salary 
    ON e.salary = min_salary.min_salary AND
    e.DEPT_NAME = min_salary.DEPT_NAME

ORDER BY DEPT_NAME ASC
;
--@block

SELECT e.emp_ID,e.emp_NAME, e.DEPT_NAME,e.salary,max_salary.max_salary,min_salary.min_salary
FROM employee as e 

JOIN(
    SELECT DISTINCT DEPT_NAME, max(salary) as max_salary FROM employee  GROUP BY DEPT_NAME) 
    as max_salary 
    ON
    e.DEPT_NAME = max_salary.DEPT_NAME
    AND e.salary = max_salary.max_salary

JOIN(
    SELECT  DISTINCT DEPT_NAME, min(salary) as min_salary FROM employee  GROUP BY DEPT_NAME) 
    as min_salary 
    ON
    e.DEPT_NAME = min_salary.DEPT_NAME
    AND e.salary = min_salary.min_salary

ORDER BY DEPT_NAME ASC
;

--@block
SELECT * FROM employee;

--@block
create table doctors
(
id int primary key,
name varchar(50) not null,
speciality varchar(100),
hospital varchar(50),
city varchar(50),
consultation_fee int
);

insert into doctors values
(1, 'Dr. Shashank', 'Ayurveda', 'Apollo Hospital', 'Bangalore', 2500),
(2, 'Dr. Abdul', 'Homeopathy', 'Fortis Hospital', 'Bangalore', 2000),
(3, 'Dr. Shwetha', 'Homeopathy', 'KMC Hospital', 'Manipal', 1000),
(4, 'Dr. Murphy', 'Dermatology', 'KMC Hospital', 'Manipal', 1500),
(5, 'Dr. Farhana', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1700),
(6, 'Dr. Maryam', 'Physician', 'Gleneagles Hospital', 'Bangalore', 1500);

--@block
SELECT * FROM doctors d1 JOIN doctors d2 ON
d1.hospital = d2.hospital and d1.speciality 
<> d2.speciality and d1.id <> d2.id;

--@block
-- Now find the doctors who work in same 
-- hospital irrespective of their speciality.
SELECT d1.name,d1.speciality,d1.hospital FROM 
doctors d1 JOIN doctors d2 ON 
d1.hospital = d2.hospital and d1.id<>d2.id;

--@block
create table login_details(
login_id int primary key,
user_name varchar(50) not null,
login_date date);

delete from login_details;
insert into login_details values
(101, 'Michael', current_date),
(102, 'James', current_date),
(103, 'Stewart', current_date+1),
(104, 'Stewart', current_date+1),
(105, 'Stewart', current_date+1),
(106, 'Michael', current_date+2),
(107, 'Michael', current_date+2),
(108, 'Stewart', current_date+3),
(109, 'Stewart', current_date+3),
(110, 'James', current_date+4),
(111, 'James', current_date+4),
(112, 'James', current_date+5),
(113, 'James', current_date+6);

--@block
select *,
case when user_name = lead(user_name) over(order by login_id)
and  user_name = lead(user_name,2) over(order by login_id)
then user_name else null end as repeated_names
from login_details
--@block
SELECT DISTINCT repeated_names FROM(
SELECT *, 
CASE WHEN user_name = LEAD(user_name)  OVER (ORDER BY login_id)
AND user_name = LEAD(user_name,2)  OVER (ORDER BY login_id)
THEN user_name ELSE NULL END
as repeated_names FROM login_details) x 
WHERE x.repeated_names is not NULL;