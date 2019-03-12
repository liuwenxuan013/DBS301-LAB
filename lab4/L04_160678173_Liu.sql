-- ***********************
-- Name: Wenxuan Liu
-- ID: 160678173
-- Date: 2019/01/24
-- Purpose: Lab 4 DBS301 
-- ***********************
-- Question 1 -  Query to dispaly the different between the average pay and the lowest pay in the company.
-- Q1 SOLUTION -- 
SELECT  to_char(avg(salary),'$999,999.99') AS "Average Amount" ,
        to_char(min(salary),'$999,999.99') AS "Lowest Amount" ,
        to_char((avg(salary)-min(salary)),'$999,999.99') AS "Real Amout" 
    FROM employees;

-- Question 2 -  Query to dispaly the department number and highest,lowest and average pay per each department, sort by average salary
-- Q2 SOLUTION --
SELECT DISTINCT department_id,
       to_char(max(salary),'$999,999.99') AS "High",
       to_char(min(salary),'$999,999.99') AS "Low",
       to_char(avg(salary),'$999,999.99') AS "Avg"
    FROM employees
    GROUP BY department_id
    ORDER BY "Avg" DESC;

-- Question 3 -  Query to dispaly department number, job, and the number of employees who work the same job in the same department 
-- Q3 SOLUTION --    
SELECT department_id AS "Dept#", 
       job_id AS "Job", 
       count(employee_id) AS "How Many"
    FROM employees
    GROUP BY department_id,job_id
    HAVING  count(employee_id)>1
    ORDER BY "How Many" DESC,"Job";
    --I'd like to sort the result by "How many" and "Job" fields.

-- Question 4 -  Query to dispaly job title and total amount paid each month exclude 'AD_PRES' AND 'AD_VP' AND  only include more than$11,000.00
-- Q4 SOLUTION --      
SELECT job_id, 
       to_char(sum(salary),'$999,999.99') AS "Total Amount Pay"
    FROM employees
    WHERE upper(job_id) NOT IN ('AD_PRES','AD_VP')
    GROUP BY job_id
    HAVING sum(salary) > 11000
    ORDER BY "Total Amount Pay" DESC;


-- Question 5 -  Query to dispaly the number of employees under the same manager excluding '100','101' and '102', and only including manage more than 2 employees
-- Q5 SOLUTION --      
SELECT NVL(manager_id,0) AS "Manager", count(employee_id) AS "How Many"
    FROM employees
    WHERE manager_id NOT IN (100,101,102)
    GROUP BY NVL(manager_id,0)
    HAVING count(employee_id)>2
    ORDER BY "How Many" DESC;
-- Question 6 -  Query to dispaly the latest and the earliest hire date of each department excluding department 10,20, and which last person was hired in this decade, sort by most recent
-- Q6 SOLUTION --     
SELECT  department_id,count(employee_id),
        to_char( max(hire_date), 'yyyy-mm-dd') AS "Latest Hire Date",
        to_char( min(hire_date), 'yyyy-mm-dd') AS "Earliest Hire Date"
    FROM employees
    WHERE department_id NOT IN(10,20)
    GROUP BY department_id
    HAVING max(hire_date) < to_date('20110101','yyyymmdd') 
    ORDER BY "Latest Hire Date" DESC;