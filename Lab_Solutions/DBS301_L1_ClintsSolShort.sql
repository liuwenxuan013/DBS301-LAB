-------------------------------------------------------
-- Lab 1 Week 1 Solution files
-- Created by: Clint MacDonald
-- Question 1
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM job_history;
-----------------------------------------------------------------
-- Question 2
SELECT 
    last_name AS "Last Name", 
    job_id AS "Job Title", 
    Hire_Date AS "Job Start" 
    FROM employees;
-----------------------------------------------------------------
-- Question 3
-- 1 - comma at end before FROM    
-- 2 - emp comm needs an underscore or AS with quotes
-- 3 - last name needs an underscore
ELECT 
    employee_id, 
    last_name, 
    commission_pct AS "Emp Comm"
    FROM employees;
-----------------------------------------------------------------
-- Question 4
DESCRIBE locations;  -- Works in both SQL Developer and SQL*PLUS

-----------------------------------------------------------------
-- Question 5 
SELECT 
    location_ID AS "City#", 
    City as "City", 
    state_province || ' IN THE ' || country_id AS "Province with Country Code" 
    FROM 
        locations ;
-- Advanced answer
SELECT 
    location_ID AS "City#", 
    City as "City", 
    (CASE 
        WHEN state_province IS NOT NULL 
            THEN state_province || ' IN THE ' || country_id 
        ELSE 
            country_id 
    END) AS "Province with Country Code" 
    FROM 
        locations;
