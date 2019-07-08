########################################
####        Zero Level            ######
########################################

use organisation;
#1.
select * from dept_manager;
#2.
SELECT * from dept_manager limit 10;

SELECT * FROM organisation.salaries;
SELECT salary FROM organisation.salaries;
#3.
set@var1 = (SELECT max(salary) from organisation.salaries);
select @var1;
#4.
SELECT emp_id, salary from organisation.salaries where salary= (select max(salary) from organisation.salaries);
SELECT emp_id, max(salary) from organisation.salaries; 
#5.
SELECT min(emp_id) from organisation.employees;
SELECT emp_id, first_name, last_name, hire_date from organisation.employees
where hire_date=(SELECT min(hire_date) from organisation.employees) limit 1;

select emp_id, first_name, last_name, hire_date from organisation.employees 
order by hire_date asc limit 1;

########################################
####        Beginner Level        ######
########################################

#1.
select gender from organisation.employees;
select birth_date from organisation.employees;
SELECT count(gender) from organisation.employees where gender="F";
SELECT count(gender) from organisation.employees where gender="M";
#2.
Select count(gender) from organisation.employees where gender="F" and birth_date between '1955-01-01' and '1960-12-31';
#3.
select max(birth_date) from organisation.employees;
select birth_date, first_name, last_name from organisation.employees where birth_date=(select max(birth_date) from organisation.employees);
#4.
select (select count(gender) from organisation.employees where gender = "F")
/(select count(emp_id) from organisation.employees)*100 as"Share of female employees";
#5.
select * from organisation.departments;
#6.
select * from organisation.dept_emp;
select count(emp_id) from organisation.dept_emp where dept_no="d009";
#7.
(select  dept_no, count(*) as numberofemp  from organisation.dept_emp group by dept_no order by numberofemp desc, dept_no asc);


select dept_no, count(emp_id) from organisation.dept_emp 
where dept_no = any(select dept_no from organisation.dept_emp);

########################################
####        Medium Level          ######
########################################

#1.
select departments.dept_name, dept_emp.emp_id
from dept_emp
inner join departments on departments.dept_no=dept_emp.dept_no
where emp_id between 10004 and 10010;

#2.
select departments.dept_name,  count(dept_emp.emp_id)
from departments
right join dept_emp on departments.dept_no=dept_emp.dept_no
group by dept_name
order by dept_name asc;

#3.
select dept_no,from_date,to_date,employees.emp_id,birth_date,first_name,last_name,gender,hire_date
from dept_emp
left join employees 
on dept_emp.emp_id=employees.emp_id
order by from_date asc;

#4.
select year(from_date) as 'calendar_year', count(emp_id) as 'employee_count'
from (select dept_no,from_date,to_date,employees.emp_id,birth_date,first_name,last_name,gender,hire_date
from dept_emp
left join employees 
on dept_emp.emp_id=employees.emp_id) as Table1
group by year(from_date)
order by year(from_date) desc;

#5.
select year(from_date) as 'calendar_year', count(emp_id) as 'employee_count'
from (select dept_no,from_date,to_date,employees.emp_id,birth_date,first_name,last_name,gender,hire_date
from dept_emp
left join employees 
on dept_emp.emp_id=employees.emp_id) as Table1
where year(from_date)>=1990
group by year(from_date)
order by year(from_date) desc;
#having year(from_date)>=1990;

#6.
select year(from_date) as 'calendar_year', gender as 'gender', count(emp_id) as 'employee_count'
from (select dept_no,from_date,to_date,employees.emp_id,birth_date,first_name,last_name,gender,hire_date
from dept_emp
join employees 
on dept_emp.emp_id=employees.emp_id) as Table1
where year(from_date)>=1990
group by year(from_date),gender
order by year(from_date) asc;

########################################
####        Advanced Level        ######
########################################

#1.
select year(from_date) as 'calendar_year', count(emp_id) as 'managers'
from dept_manager
group by year(from_date)
order by year(from_date) asc;

#2.
select year(from_date) as 'calendar_year', dept_name as 'department_name', count(emp_id) as 'employee'
from dept_manager
left join departments on dept_manager.dept_no=departments.dept_no
group by calendar_year,department_name
order by calendar_year,department_name asc;

#3.
select year(from_date) as 'calendar_year', gender as 'gender', count(to_date) as 'managers'
from employees
join dept_manager on employees.emp_id=dept_manager.emp_id
group by calendar_year, gender
order by calendar_year;
