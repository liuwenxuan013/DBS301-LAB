--*********************************************************
--Name:         Wenxuan Liu
--ID:           160678173 
--Date:         2019/01/10
--Purpose:      Lab 1  DBS301
--*********************************************************
--Question 1 - Which one table appeared to be the widest or longest?
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM job_history;
--Q1 Solution -- The table EMPLOYEES appeared to be the widest and longest.

--Question 2 - How to fix the given wrong command?
SELECT last_name  "LName", job_id  "Job Title", hire_date  "Job Start"
    FROM employees;
--Q2 Solution -- Hire Date should be written as hire_date.

--Question 3 - Identify three coding errors in the statement.
SELECT employee_id, last_name, commission_pct "Emp Comm"
    FROM employees;  
--Q3 Solution -- There are 3 errors as below:
------(1)last name should be written as last_name;
------(2)Emp Comm should be quoted as alias;
------(3)The last colum(field) selected no need to be followed by comma;

--Question 4 - What command would show the structure of the table locations?
--Q4 Solution -- 
DESCRIBE locations;

--Question 5 - Create a query to display the output shown below.
--Q5 Solution --
SELECT location_id "City#", city "City", state_province || ' IN THE ' || country_id AS "Province with Country Code"
    FROM locations;

    ---Q5 correct answer below---
    SELECT location_id AS "City#", 
           city AS "City", 
           state_province || ' IN THE ' || country_id AS "Province with Country Code"
    FROM   locations
    ORDER BY location_id;
    --BONUS--
      SELECT location_id AS "City#", 
           city AS "City", 
           (CASE
           WHEN state_province IS NOT NULL
           THEN state_province || ' IN THE ' || country_id
           ELSE country_id)
        AS "Province with Country Code"
    FROM   locations
    ORDER BY location_id;

