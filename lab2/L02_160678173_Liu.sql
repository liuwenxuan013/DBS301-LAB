-- ***********************
-- Name: Wenxuan Liu
-- ID: 160678173
-- Date: 2019/01/17
-- Purpose: Lab 2 DBS301 
-- ***********************  
-- Question 1 – Display the employee_id, last name and salary of employees (salary:$8,000 to $12,000),Sort by salaries and last name.
SELECT employee_id,last_name,to_char(salary,'$999,999.99') AS "Salary"
    FROM employees
    WHERE salary>=8000 AND salary<=12000
    ORDER BY salary DESC,last_name;

-- Question 2 – Query depends on the first query to display employees working as Programmers or Sales Representatives
SELECT employee_id,last_name,to_char(salary,'$999,999.99') AS "Salary", job_id AS "Job Title"
    FROM employees
    WHERE (salary>=8000 AND salary<=12000) AND
          (upper(job_id)='IT_PROG'  OR 
           upper(job_id)='SA_REP' )
    ORDER BY salary DESC,last_name;

-- Question 3 – Query depends on the second query to display employees' salary out of the range from 8000 to 12000
SELECT employee_id,last_name,to_char(salary,'$999,999.99') AS "Salary", job_id AS "Job Title"
    FROM employees
    WHERE (salary<8000 OR salary>12000) AND
          (upper(job_id)='IT_PROG'  OR 
           upper(job_id)='SA_REP' )
    ORDER BY salary DESC,last_name;
    
-- Question 4 – Query to display last_name,job_id,and salary of employees who hired before 2018 and sort by date
SELECT employee_id,last_name, job_id AS "Job Title", to_char(salary,'$999,999.99') AS "Salary",hire_date 
    FROM employees
    WHERE hire_date < to_date('2018-01-01', 'yyyy-dd-mm')
    ORDER BY hire_date;
    
-- Question 5 – Query to display job title of employees whose salary more than 12000 and sort by job title and salary
SELECT employee_id,last_name, job_id AS "Job Title", to_char(salary,'$999,999.99') AS "Salary"
    FROM employees
    WHERE salary>12000     
    ORDER BY upper(job_id), salary DESC;
    
-- Question 6 – Query to display job title, full name of employees whose first name contains an 'e' or 'E'
SELECT employee_id,first_name || ' ' || last_name AS "Full Name", job_id AS "Job Title"
    FROM employees
    WHERE upper(first_name) LIKE '%E%'
    ORDER BY upper(job_id), last_name ASC;
    
-- Question 7 – Create a report to display last_name,salary and commission percent
SELECT employee_id,last_name,to_char(salary,'$999,999.99') AS "Salary",commission_pct
    FROM employees
    WHERE upper(job_id) LIKE 'SA%';
    
-- Question 8 – same as above question but put the report in order of descending salaries
SELECT employee_id,last_name,to_char(salary,'$999,999.99') AS "Salary",commission_pct
    FROM employees
    WHERE upper(job_id) LIKE 'SA%'
    ORDER BY salary DESC;
    
-- Question 9 – same as above question but use a numeric value instead of a column name to do the sorting
SELECT employee_id,last_name,to_char(salary,'$999,999.99') AS "Salary",commission_pct
    FROM employees
    WHERE upper(job_id) LIKE 'SA%'
    ORDER BY 3 DESC;