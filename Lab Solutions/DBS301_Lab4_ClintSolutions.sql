-------------------------------------------------------
-- Lab 4 Week 4 Solution files
-----------------------------------------------------------------
-- Question 1
SELECT 
    to_char(ROUND(AVG(salary) - MIN(salary),2),'$99999.99') AS "Real Amount" 
    FROM employees;
-----------------------------------------------------------------
-- Question 2
SELECT  department_ID AS "Dept ID",
        TO_CHAR(MAX(salary),'$999,999.99') AS "High",
        TO_CHAR(MIN(salary),'$999,999.99') AS "Low",
        TO_CHAR(ROUND(AVG(salary),2),'$999,999.99') AS "Avg"
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC;
-----------------------------------------------------------------
-- Question 3
SELECT  department_id AS "Dept#",
        job_id AS "Job",
        COUNT(employee_id) AS "How Many"
    FROM employees
    GROUP BY department_id, job_id
	HAVING Count(employee_id) > 1
    ORDER BY "How Many" DESC;
-----------------------------------------------------------------
-- Question 4
SELECT  job_id as "Job",
        TO_CHAR(SUM(salary), '$999,999.99') AS "Amount Paid"
    FROM employees
    GROUP BY job_id
    HAVING  job_id NOT IN ('AD_PRES','AD_VP')
            AND
            SUM(salary) > 11000
    ORDER BY SUM(salary) DESC;
-----------------------------------------------------------------
-- Question 5
SELECT  manager_id AS "Manager",
        COUNT(employee_id) AS "Employees"
    FROM employees
    GROUP BY manager_id
    HAVING 
        manager_id NOT IN (100,101,102)
        AND 
        COUNT(employee_id) > 2
    ORDER BY "Employees" DESC;
-----------------------------------------------------------------
-- Question 6
SELECT  department_id AS "Dept#",
        MAX(hire_date) AS "Latest",
        MIN(hire_date) AS "Earliest"
    FROM employees
    GROUP BY department_id
    HAVING  department_id NOT IN (10, 20)
            AND
            MAX(hire_date) < to_date('01012021','mmddyyyy')
			AND MAX(hire_date) > to_date('12/31/2010','mmddyyyy')
    ORDER BY MAX(hire_date) DESC;
