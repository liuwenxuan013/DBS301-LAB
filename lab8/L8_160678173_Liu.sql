-- ***********************
-- Name: Wenxuan Liu
-- ID: 160678173
-- Date: 2019/03/14
-- Purpose: Lab 8 DBS301
-- ***********************
--Q1--Display the names of the employees whose salary is the same as the lowest salaried employee in any department.
--Q1--Solution--
SELECT first_name||' '||last_name AS "Name" 
    FROM employees 
    WHERE salary = ANY (
        SELECT min(salary) 
            FROM employees 
            GROUP BY department_id
            );
        
--Q2--Display the names of the employee(s) whose salary is the lowest in each department.
--Q2--Solution--
SELECT first_name||' '||last_name AS "Name" 
    FROM employees 
    WHERE (department_id,salary) IN (
        SELECT department_id,min(salary)
            FROM employees
            GROUP BY department_id)
    ORDER BY last_name,first_name;

--Q3--Give each of the employees in question 2 a $120 bonus
--Q3--Solution--
SELECT first_name||' '||last_name AS "Name" ,to_char(salary+120,'$999,999.99') AS" new salary"
    FROM employees 
    WHERE (department_id,salary) IN (
        SELECT department_id,min(salary)
            FROM employees
            GROUP BY department_id)
    ORDER BY last_name,first_name;


--Q4--Create a view named vwAllEmps that consists of all employees includes employee_id, last_name, salary, 
--      department_id, department_name, city and country (if applicable)
--Q4--Solution--
CREATE VIEW vwAllEmps AS
    SELECT employee_id, last_name, salary, department_id, department_name, city, country_name
        FROM employees LEFT OUTER JOIN departments USING (department_id)
                LEFT OUTER JOIN locations USING (location_id)
                    LEFT OUTER JOIN countries USING (country_id);
--SELECT * FROM vwAllEmps;       
--DROP VIEW vwAllEmps;
--Q5--1--Use the vwAllEmps view to:
--      Display the employee_id, last_name, salary and city for all employees
--Q5--1--Solution--
SELECT employee_id, last_name, to_char(salary,'$999,999.99') AS "Salary", city
    FROM vwAllEmps;
--Q5--2--Display the total salary of all employees by city
--Q5--2--Solution--
SELECT city,to_char(sum(salary),'$999,999.99') AS "Total salary"
    FROM vwAllEmps 
    GROUP BY city
    ORDER BY sum(salary);
--Q5--3--Increase the salary of the lowest paid employee(s) in each department by 120
--Q5--3--Solution--
UPDATE vwAllEmps 
SET salary= salary+120
WHERE (department_id,salary) IN (
        SELECT department_id,min(salary)
            FROM vwAllEmps 
            GROUP BY department_id);
--to check the increase by the query below
--SELECT employee_id,last_name,to_char(salary,'$999,999.99') AS "Salary"
--    FROM vwAllEmps 
--     WHERE (department_id,salary) IN (
--        SELECT department_id,min(salary)
--            FROM vwAllEmps 
--            GROUP BY department_id)
--    ORDER BY last_name;

--Q5--4--What happens if you try to insert an employee by providing values for all columns in this view?
--Q5--4--Solution--
--Try to run this script: INSERT INTO vwAllEmps VALUES (208,'Laura',70000,111,'Office','Toronto','Canada');
--Generates a erroe because it cannot modify more than one base table through a join view,
--the view is a sql script and the columns of the view belonging to more than one underlying table were either inserted into or updated.

--Q5--5--Delete the employee named Vargas. Did it work? Show proof.
--Q5--5--Solution--
--Delete from a view would work. it would actually delete data from the underlying table.


DELETE FROM vwAllEmps  WHERE last_name='Vargas';
--It works,run the above script then delete the record of 'Vargas';
--to check the result by select query below:
--SELECT * FROM vwAllEmps WHERE upper(last_name)='VARGAS';
 
--Q6--Create a view named vwAllDepts that consists of all departments and includes department_id, 
--      department_name, city and country (if applicable)
--Q6--Solution--
CREATE VIEW vwAllDepts AS
    SELECT department_id, department_name, city, country_name
        FROM departments LEFT OUTER JOIN locations USING (location_id)
            LEFT OUTER JOIN countries USING (country_id);
--Q7--Use the vwAllDepts view to:
--Q7--1--For all departments display the department_id, name and city
--Q7--1--Solution--
SELECT department_id, department_name, city
    FROM vwAllDepts;
--Q7--2--For each city that has departments located in it display the number of departments by city
--Q7--2--Solution--
SELECT city,count(DISTINCT department_id) AS "Number of Dept."
    FROM vwAllDepts
    GROUP BY city
    ORDER BY "Number of Dept." DESC;
--Q8--Create a view called vwAllDeptSumm that consists of all departments and includes for each department: 
--      department_id, department_name, number of employees, number of salaried employees, total salary of all employees. 
--      Number of Salaried must be different from number of employees. The difference is some get commission.

--Q8--Solution
create VIEW vwAllDeptSumm AS
    SELECT d.department_id, department_name, 
           count(employee_id) AS "Emp#",
           count(employee_id)-count(commission_pct) AS "Salaried#", 
           --the number of salaried employee is the only the number of employess who do not get commission
           sum(salary) AS "Total Salary"
        FROM departments d LEFT OUTER JOIN employees e ON d.department_id  = e.department_id
        GROUP BY d.department_id,department_name;
--DROP VIEW vwAllDeptSumm;
       
--Q9-- Use the vwAllDeptSumm view to display department name and number of employees for departments 
--      that have more than the average number of employees 
select * from vwAllDeptSumm;
--Q9--Solution--
SELECT department_name,"Emp#"
    FROM vwAllDeptSumm
    WHERE "Emp#" > (SELECT AVG("Emp#") 
                        FROM vwAllDeptSumm
                    );

--Q10-- A) Use the GRANT statement to allow another student (Neptune account) to retrieve data for your employees 
--      table and to allow them to retrieve, insert and update data in your departments table. Show proof 
--      B) Use the REVOKE statement to remove permission for that student to insert and update data in 
--      your departments table
--Q10--Solution--
GRANT SELECT ON employees TO dbs301_191b30;
GRANT SELECT, INSERT, UPDATE ON departments TO dbs301_191b30;
REVOKE INSERT,UPDATE ON departments FROM dbs301_191b30;--try to run using account dbs301_191b30;
