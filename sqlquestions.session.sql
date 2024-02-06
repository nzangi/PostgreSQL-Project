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

--@block
SELECT x.* FROM employee e JOIN (
    SELECT *,
max(salary) OVER(PARTITION BY dept_name) as max_salary,
min(salary) OVER(PARTITION BY dept_name) as min_salary
FROM employee
) as x 
ON e.emp_id=x.emp_id AND (e.salary=x.max_salary or e.salary=min_salary)
ORDER BY x.dept_name,x.salary;

--@block
-- From the students table, write a SQL query to interchange the adjacent student names.
create table students
(
id int primary key,
student_name varchar(50) not null
);
insert into students values
(1, 'James'),
(2, 'Michael'),
(3, 'George'),
(4, 'Stewart'),
(5, 'Robin');

--@block
SELECT * FROM students;
--@block
SELECT id,student_name,
    CASE WHEN id % 2 <> 0 THEN lead(student_name,1,student_name) OVER(ORDER BY id)
    WHEN id % 2 = 0 THEN lag(student_name) OVER(ORDER BY id) 
    END as new_student_name FROM students;

--@block
create table weather
(
id int,
city varchar(50),
temperature int,
day date
);
insert into weather values
(1, 'London', -1, to_date('2021-01-01','yyyy-mm-dd')),
(2, 'London', -2, to_date('2021-01-02','yyyy-mm-dd')),
(3, 'London', 4, to_date('2021-01-03','yyyy-mm-dd')),
(4, 'London', 1, to_date('2021-01-04','yyyy-mm-dd')),
(5, 'London', -2, to_date('2021-01-05','yyyy-mm-dd')),
(6, 'London', -5, to_date('2021-01-06','yyyy-mm-dd')),
(7, 'London', -7, to_date('2021-01-07','yyyy-mm-dd')),
(8, 'London', 5, to_date('2021-01-08','yyyy-mm-dd'));

--@block
SELECT * FROM (
    SELECT *,
        CASE WHEN temperature < 0
            AND LEAD(temperature) OVER(ORDER BY day) < 0
            AND LEAD(temperature,2) OVER (ORDER BY day) < 0
        THEN 'Y'
        WHEN temperature < 0
            AND LEAD(temperature) OVER(ORDER BY day) < 0
            AND LAG(temperature) OVER(ORDER BY day) < 0
        THEN 'Y'
        WHEN temperature < 0
            AND LAG(temperature) OVER(ORDER BY day) < 0
            AND LAG(temperature,2) OVER(ORDER BY day) < 0
        THEN 'Y'
        END as flag FROM
weather) x
WHERE  x.flag='Y';

--@block
create table event_category
(
  event_name varchar(50),
  category varchar(100)
);

create table physician_speciality
(
  physician_id int,
  speciality varchar(50)
);

create table patient_treatment
(
  patient_id int,
  event_name varchar(50),
  physician_id int
);


insert into event_category values ('Chemotherapy','Procedure');
insert into event_category values ('Radiation','Procedure');
insert into event_category values ('Immunosuppressants','Prescription');
insert into event_category values ('BTKI','Prescription');
insert into event_category values ('Biopsy','Test');


insert into physician_speciality values (1000,'Radiologist');
insert into physician_speciality values (2000,'Oncologist');
insert into physician_speciality values (3000,'Hermatologist');
insert into physician_speciality values (4000,'Oncologist');
insert into physician_speciality values (5000,'Pathologist');
insert into physician_speciality values (6000,'Oncologist');


insert into patient_treatment values (1,'Radiation', 1000);
insert into patient_treatment values (2,'Chemotherapy', 2000);
insert into patient_treatment values (1,'Biopsy', 1000);
insert into patient_treatment values (3,'Immunosuppressants', 2000);
insert into patient_treatment values (4,'BTKI', 3000);
insert into patient_treatment values (5,'Radiation', 4000);
insert into patient_treatment values (4,'Chemotherapy', 2000);
insert into patient_treatment values (1,'Biopsy', 5000);
insert into patient_treatment values (6,'Chemotherapy', 6000);

--@block
SELECT ps.speciality,count(1) as speciality_count FROM patient_treatment pt JOIN event_category ec ON 
ec.event_name = pt.event_name JOIN physician_speciality ps ON ps.physician_id = pt.physician_id WHERE
ec.category = 'Procedure' AND pt.physician_id NOT IN (
    SELECT pt2.physician_id FROM patient_treatment pt2 JOIN event_category ec ON ec.event_name = pt2.event_name
    WHERE ec.category in ('Prescription')
)
GROUP BY ps.speciality;

--@block
create table patient_logs
(
  account_id int,
  date date,
  patient_id int
);

insert into patient_logs values (1, to_date('02-01-2020','dd-mm-yyyy'), 100);
insert into patient_logs values (1, to_date('27-01-2020','dd-mm-yyyy'), 200);
insert into patient_logs values (2, to_date('01-01-2020','dd-mm-yyyy'), 300);
insert into patient_logs values (2, to_date('21-01-2020','dd-mm-yyyy'), 400);
insert into patient_logs values (2, to_date('21-01-2020','dd-mm-yyyy'), 300);
insert into patient_logs values (2, to_date('01-01-2020','dd-mm-yyyy'), 500);
insert into patient_logs values (3, to_date('20-01-2020','dd-mm-yyyy'), 400);
insert into patient_logs values (1, to_date('04-03-2020','dd-mm-yyyy'), 500);
insert into patient_logs values (3, to_date('20-01-2020','dd-mm-yyyy'), 450);

--@block
select * from patient_logs;