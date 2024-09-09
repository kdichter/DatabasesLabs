/* REPLACE THIS WITH YOUR NAME */
/* Lab 04: Recursive */

/* PROBLEM 1 BEGIN */
SELECT empl_number, empl_firstname
from employee
where boss_number is null;
/* PROBLEM 1 END */

/* PROBLEM 2 BEGIN */
SELECT emp.empl_number, emp.empl_firstname, boss.empl_number as mngr_number, boss.empl_firstname as mngr_firstname
from employee emp
join employee boss
on emp.boss_number = boss.empl_number
where emp.boss_number is not null
order by emp.empl_firstname asc;
/* where emp.boss_number is not null */
/* PROBLEM 2 END */

/* PROBLEM 3 BEGIN */
SELECT d.dept_name
from department d
where (select avg(empl_salary)
        from employee e 
        where d.empl_number <> e.empl_number and d.dept_name = e.dept_name) > 25000;

/*
join employee e 
on d.empl_number = e.empl_number
*/
/* PROBLEM 3 END */

/* PROBLEM 4 BEGIN */
SELECT emp.empl_number, emp.empl_firstname
from employee emp
where emp.empl_number in (select empl_number from employee e where e.boss_number = 
(select ee.boss_number from employee ee where ee.empl_firstname = 'Andrew'));
/* PROBLEM 4 END */

/* PROBLEM 5 BEGIN */
/* (select max(emp.empl_salary) from employee
where employee.boss_number = (select boss_number from employee e where e.empl_firstname = 'Andrew'))
*/

SELECT emp.empl_number, emp.empl_firstname, emp.empl_salary
from employee emp
join employee boss
on emp.boss_number = boss.empl_number
where emp.empl_salary = (select max(empl_salary) from employee e where e.boss_number = 
(select boss_number from employee ee where ee.empl_firstname = 'Andrew'));

/* PROBLEM 5 END */

/* PROBLEM 6 BEGIN */
SELECT emp.empl_number, emp.empl_firstname
from employee emp
join department d 
on emp.dept_name = d.dept_name
where d.empl_number <> emp.empl_number and emp.empl_number in 
(select distinct e.boss_number
from employee e );

/* join employee boss
on e.boss_number = boss.empl_number
*/
/* PROBLEM 6 END */

/* PROBLEM 7 BEGIN */

SELECT prod.prod_id, prod.prod_description, prod.prod_price
from product prod
where prod.prod_price = 
(select max(p.prod_price) 
from product p
join assembly a
on p.prod_id = a.subprod_id
where a.subprod_id in
(select subprod_id from product pp join assembly
on pp.prod_id = assembly.prod_id
where pp.prod_description = 'Animal photography kit'));

/* PROBLEM 7 END */
