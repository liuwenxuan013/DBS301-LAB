-- ***********************
-- Name: Wenxuan Liu
-- ID: 160678173
-- Date: 2019/02/07
-- Purpose: Lab 5 DBS301 
-- ***********************
-- Question 1 -  Query to dispaly the department name,city,street address and postal code and sort by city and department name
-- Q1 SOLUTION -- 
SELECT  department_name,city,street_address,postal_code
    FROM departments d,locations l
    WHERE d.location_id=l.location_id
    ORDER BY city,department_name;

-- Question 2 -  Query to dispaly full name of employees, hiredate, salary,department name and city which the departments name
--               starts A or S, sort by department name and employee name
-- Q2 SOLUTION --
SELECT last_name||','||first_name AS "Full Name",
       to_char(hire_date, 'yyyy-mm-dd') AS "Hire Date",
       to_char(salary,'$999,999.99') AS "Salary",
       department_name,city
    FROM employees e,departments d,locations l
    WHERE e.department_id=d.department_id 
        AND d.location_id=l.location_id
            AND (department_name LIKE 'A%'
                OR department_name LIKE 'S%')
    ORDER BY department_name,"Full Name";

-- Question 3 -  Query to dispaly full name of manager of each department in Ontario,New Jersey and Washington, department name,
--               city, postal code,province name, sort by city,department name
-- Q3 SOLUTION --    
SELECT DISTINCT(last_name||','||first_name ) AS "Full Name",
       department_name,city,postal_code,state_province
    FROM employees e,departments d,locations l
    WHERE e.employee_id=d.manager_id
            AND d.location_id=l.location_id
                    AND (state_province IN ('Ontario','New Jersy','Washington'))
    ORDER BY city,department_name;
    
-- Question 4 -  Query to dispaly last name of employees and their number, manager's last name,manager number
-- Q4 SOLUTION --      
SELECT e.last_name AS "Employee", e.employee_id AS "Emp#", m.last_name AS "Manager", m.employee_id AS "Mgr#"
    FROM employees e,employees m
    WHERE e.manager_id=m.employee_id --not display the employee who has no manager
    ORDER BY "Emp#" ;--I'd like to order by Emp#;


-- Question 5 -  Query to dispaly departname,city,street address,postal code, country name and sort by department name descending
-- Q5 SOLUTION --      
SELECT department_name,city,street_address,postal_code,country_name
    FROM departments LEFT OUTER JOIN locations 
        USING (location_id)
            LEFT OUTER JOIN countries 
            USING(country_id)
    ORDER BY department_name DESC;

-- Question 6 -  Query to dispaly full name of employees, hire date,salary and department which names start with A or S
--               sort by department name and last name
-- Q6 SOLUTION --     
SELECT  first_name||'/'||last_name AS"Full Name",
        to_char( hire_date, 'yyyy-mm-dd') AS "Hire Date",
        to_char( salary, '$999,999.99') AS "Salary",
        department_name
    FROM employees e INNER JOIN departments d 
        ON e.department_id=d.department_id
    WHERE department_name LIKE 'A%'
        OR department_name LIKE 'S%'
    ORDER BY department_name,last_name;

-- Question 7 -  Query to dispaly full name of managers of each department in Ontario,New Jersey,Washington and department name,
--               city,postal code, province name
--               sort by city and department name 
-- Q7 SOLUTION --       
SELECT last_name||','||first_name  AS "Full Name",
       department_name,city,postal_code,state_province
    FROM employees e INNER JOIN departments d --to display only matched records
        ON e.employee_id=d.manager_id
            LEFT OUTER JOIN locations l
            ON d.location_id=l.location_id
    WHERE (state_province IN ('Ontario','New Jersy','Washington'))
    ORDER BY city,department_name;


-- Question 8 -  Query to dispaly department name and the highest,lowest and average pay and sort by average pay descending
-- Q8 SOLUTION --     
SELECT  department_name,
        to_char(max(salary),'$999,999.99') AS "High",
        to_char(min(salary),'$999,999.99') AS "Low",
        to_char(avg(salary),'$999,999.99') AS "Avg"
    FROM departments d LEFT OUTER JOIN employees e
        ON d.department_id= e.department_id
    GROUP BY d.department_name
    ORDER BY --or 'ORDER BY "Avg" DESC; ' to dislay the departments whose salary is null first
        (CASE 
            WHEN avg(salary) IS NULL THEN 0
            ELSE avg(salary)
        END)DESC;
        
-- Question 9 -  Query to dispaly last name of employees and their number, manager's last name,manager number
-- Q9 SOLUTION --      
SELECT e.last_name AS "Employee", e.employee_id AS "Emp#", m.last_name AS "Manager", m.employee_id AS "Mgr#"
    FROM employees e FULL JOIN employees m 
        ON e.manager_id = m.employee_id
    ORDER BY "Emp#" ; --I'd like to sort by Emp#