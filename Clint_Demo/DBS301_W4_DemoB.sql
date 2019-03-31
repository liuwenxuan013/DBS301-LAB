-------------------------------------------------------
-- Week 4 Working Demos
-- Created by: Clint MacDonald
-- May 29, 2018
-- Purpose: Week 4, Lesson 5 Working Demos DBS301
-- Description: Multi-Row Functions, Aggregate functions, and Grouping
-----------------------------------------------------------------

/* NEW GENERIC SYNTAX
SELECT column, group function
    FROM table
    [WHERE condition]
    [GROUP BY group by expression]
    [HAVING group condition]
    [ORDER BY column(s)];
    
    There are 7 aggregate functions
    -- AVG
    -- SUM
    -- COUNT
    -- MIN
    -- MAX
    -- STDDEV
    -- VARIANCE
    -- Aggregate functions are calculated fields, Therefore you MUST assign an alias
    
-- Let's get the total number of employees that work for the company */
SELECT * FROM employees;
-- use for larger data sets or use the result in a calculation
SELECT count(*) FROM employees;
-- better to use a single column, typically the primary key
SELECT count(employee_id) AS "NumEmp" FROM employees;

-- Now let's get the number of employees that work in each department
SELECT department_id, count(employee_id) AS "NumEmp"
    FROM employees;
    -- OOPS, this causes an error   

-- *****************
-- ANY FIELD IN THE SELECT STATEMENT NOT PART OF AN AGGREGATE FUNCTION MUST BE INCLUDED IN A GROUP BY 
-- *****************

SELECT department_id, count(employee_id) AS "NumEmp"
    FROM employees
    GROUP BY department_id
    ORDER BY department_id;
    
    -- OR -- sort by Count
SELECT department_id, count(employee_id) AS "NumEmp"
    FROM employees
    GROUP BY department_id
    ORDER BY "NumEmp" DESC;
    
-- Using DISTINCT
SELECT department_id FROM employees;
-- but there are repeats
SELECT DISTINCT department_id FROM employees ORDER BY department_id;

-- Let's display the number of different departments that have employees in the database
SELECT count(department_id) AS NumDepts FROM employees;
    -- why did we get 19 when there are only 8 departments
SELECT count(DISTINCT department_id) AS NumDepts FROM employees;    
    -- BUT WHAT HAPPENED TO THE 8 FROM 2 STATEMENTS AGO
    -- the NULL department
-- NVL function
SELECT count(DISTINCT nvl(department_id, 0)) AS NumDepts 
    FROM employees;   

-- more examples of NVL
-- Find the average commission rate for employees

-- The question is: to include NULLs or not
-- let's answer both ways
SELECT avg(commission_pct) AS AvgComm
    FROM employees;
    -- clearly this only include comm emplyees, notably the ones with a commission_pct
    
    -- BUT what if we want to inclue ALL employees
SELECT avg(NVL(commission_pct,0)) AS AvgComm
    FROM employees;

-- OTHER FUNCTIONS
-- Produce a SINGLE sql statement that returns a SINGLE line result that displays 
--   the minimum, maximum, and average salaries for all employees
SELECT  min(salary) AS "Min",
        max(salary) AS "Max",
        avg(salary) AS "Average"
    FROM employees;
-- Let's change the question by 1 word
-- Produce a SINGLE sql report that returns a SINGLE line result that displays 
--   the minimum, maximum, and average salaries for all employees
SELECT  to_char(min(salary),'$999,999.00') AS "Min",
        to_char(max(salary),'$999,999.00') AS "Max",
        to_char(avg(salary),'$999,999.00') AS "Average"
    FROM employees;

-- GROUPING BY MULTIPLE COLUMNS
-- display the average salary for employees in each job-title in each department
SELECT job_id, department_id, avg(salary) AS AvgSal
    FROM employees
    GROUP BY job_id, department_id;
    
-- HAVING
-- display the average salary for emplyees in each job title in each department, 
-- but only show those where the average is over $10,000.00.
SELECT job_id, department_id, avg(salary) AS AvgSal
    FROM employees
    GROUP BY job_id, department_id
    HAVING avg(salary) > 10000;

-- HAVING and WHERE at the same time
-- repeat the previous example but only include departments 20, 60, 80 and 90
SELECT job_id, department_id, avg(salary) AS AvgSal
    FROM employees
    WHERE department_id IN(20, 60, 80, 90)
    GROUP BY job_id, department_id
    HAVING avg(salary) > 10000;

-- NEW ORDER OF PRECENDENCE
/*

    FROM
    WHERE
    GROUP BY
    HAVING
    SELECT
    ORDER BY
    
    */
    

