-- ***********************
-- Name: Wenxuan Liu
-- ID: 160678173
-- Date: 2019/01/24
-- Purpose: Lab 3 DBS301
-- ***********************
-- Question 1 -  Query to dispaly the tomorrow's date 
-- Q1 SOLUTION --
SELECT to_char(sysdate + 1,'fmMonth ddth" of year "yyyy') AS "Tomorrow" 
    FROM dual;

-- Question 2 - Display last name, first name,salary, Good Salary and Annual Pay Increase of employees in department 20,50 and 60
-- Q2 SOLUTION --
-- I'd like to keep the salary accuracy in cents here, so i did round(salary,2);

SELECT last_name,first_name,salary, 
       round(salary*(1+0.04),2) AS "Good Salary", 
       (round(salary*(1+0.04),2)-salary)*12 AS "Annual Pay Increase",
       department_id
    FROM employees
    WHERE department_id IN (20,50,60)
    ORDER BY 'Annual Pay Increase 'DESC;

-- Question 3 - Display full name and job title of employees whose last name ends with S and first name start with C or K, and sort by last name
-- Q3 SOLUTION -- 
SELECT first_name||', '||last_name || ' is '||job_id AS "Full Name and Job Title"
    FROM employees
    WHERE upper(last_name) LIKE '%S' 
        AND REGEXP_LIKE(upper(first_name),'^[CK]')
        ORDER BY last_name;
 
-- Question 4 - Display last name,hire date and the number of hired years of employeese hired before 2012, and sort by the number of hired years
-- Q4 SOLUTION (1)--   
 
SELECT last_name,hire_date, round(months_between(sysdate,hire_date)/12,0) AS "Years Worked"
    FROM employees
    WHERE extract(year FROM hire_date) < 2012
    ORDER BY "Years Worked" DESC; 
   -- If think about the case on fire payment in reality, 'round()' should be replaced by 'trunc()'
   -- Q4 SOLUTION (2)--  
SELECT last_name,hire_date, trunc(months_between(sysdate,hire_date)/12,0) AS "Years Worked"
    FROM employees
    WHERE extract(year FROM hire_date) < 2012
    ORDER BY "Years Worked" DESC;  
   
   
-- Question 5 - Display city name,country codes,state province name of cities whose name start with S and has at least 8 characters
-- Q5 SOLUTION --   
SELECT city,country_id AS "Country Code",NVL(state_province,'Unknown Province') AS "State Province"
    FROM locations
    WHERE upper(city) LIKE 'S%' AND  length(city)>=8;

-- Question 6 - Display last name,hire date and salary review date of employees hired after 2017
-- Q6 SOLUTION -- 

SELECT last_name,hire_date,to_char(next_day(add_months(hire_date, 12), 'Thursday'),'fmDAY", "Month" the "Ddsp" of year "yyyy') AS "REVIEW DAY"
    FROM employees
    WHERE extract(year FROM hire_date) > 2017
    ORDER BY next_day(add_months(hire_date, 12), 'Thursday'); 