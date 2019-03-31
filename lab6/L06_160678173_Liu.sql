-- ***********************
-- Name: Wenxuan Liu
-- ID: 160678173
-- Date: 2019/02/14
-- Purpose: Lab 6 DBS301 
-- ***********************
-- Question 1 -  

--SET AUTOCOMMIT ON (do this each time you log on) so any updates, deletes and inserts are automatically committed before you exit from Oracle.
-- Q1 SOLUTION -- 
SET AUTOCOMMIT ON;

-- Question 2 -
--Create an INSERT statement to do this.  Add yourself as an employee with a NULL salary, 0.21 commission_pct, in department 90, and Manager 100.  You started TODAY.  
-- Q2 SOLUTION -- 
INSERT INTO employees(employee_id,first_name,last_name,email,phone_number,hire_date,job_id,commission_pct,manager_id,department_id) 
    VALUES (173,'Wenxuan','Liu','WLIU122','647.000.0000',sysdate,'SA_REP',0.21,100,90);

-- Question 3 -
--Create an Update statement to: Change the salary of the employees with a last name of Matos and Whalen to be 2500.
--You must use subqueries for these questions (must minimize the number of tables being used in the main query)
-- Q3 SOLUTION -- 
UPDATE (
        SELECT salary
            FROM employees
            WHERE upper(last_name) IN ('MATOS','WHALEN')
        ) 
    SET salary=2500;


-- Question 4 -
--Display the last names of all employees who are in the same department as the employee named Abel.
-- Q4 SOLUTION -- 
SELECT last_name 
    FROM employees 
    WHERE department_id IN (
        SELECT department_id
            FROM employees 
            WHERE upper(first_name) IN ('ABEL') OR
                upper(last_name) IN ('ABEL')
    );
--the employees named 'Abel' could be that his last os first name 
            
-- Question 5 -
--Display the last name of the lowest paid employee(s)
-- Q5 SOLUTION -- 
SELECT last_name
    FROM employees 
    WHERE salary = (
        SELECT min(salary)
            FROM employees
    );


-- Question 6 -
--Display the city that the lowest paid employee(s) are located in.
-- Q6 SOLUTION -- 
SELECT city 
    FROM locations
    WHERE location_id IN(
        SELECT location_id
            FROM departments
            WHERE department_id IN(
                SELECT department_id
                    FROM employees
                    WHERE salary = (
                         SELECT min(salary)
                            FROM employees
                    )
            )
    );
-- Question 7 -
--Display the last name, department_id, and salary of the lowest paid employee(s) in each department. 
--Sort by Department_ID. (HINT: careful with department 60)
-- Q7 SOLUTION -- 

SELECT last_name,department_id,salary
    FROM employees
    WHERE (department_id,salary) IN (
        SELECT department_id,min(salary) 
            FROM employees 
            GROUP BY department_id
    )
    ORDER BY department_id;


--clint answer
SELECT last_name,department_id,minsalary
    FROM employees emp JOIN ( 
        SELECT department_id,min(salary) AS minsalary
            FROM employees 
            GROUP BY department_id)  
    ) t using(department_id)
    WHERE emp.salary=minsalary
    ORDER BY department_id;
-- Question 8 -
--Display the last name of the lowest paid employee(s) in each city
-- Q8 SOLUTION -- 

SELECT last_name, city,salary
    FROM employees 
        JOIN departments USING(department_id)
        JOIN locations USING (location_id)
    WHERE( salary,city )IN
        (SELECT min(salary),city
            FROM employees JOIN departments 
                USING(department_id)
                     JOIN locations 
                        USING(location_id)       
            GROUP BY city ) 
    ORDER BY city;
            
     

-- Question 9 -
--Display last name and salary for all employees who earn less than the lowest salary in ANY department.  
--Sort the output by top salaries first and then by last name.
-- Q9 SOLUTION -- 
SELECT last_name,salary
    FROM employees
    WHERE salary < ANY(
        SELECT min(salary)
            FROM employees
            GROUP BY department_id
    )    
    ORDER BY salary DESC, last_name;

-- Question 10 -
--Display last name, job title and salary for all employees whose salary matches any of the salaries from the IT Department. 
--Do NOT use Join method.  
--Sort the output by salary ascending first and then by last_name
-- Q10 SOLUTION -- 
SELECT last_name,job_id,salary
    FROM employees
    WHERE salary IN(
        SELECT salary 
            FROM employees
            WHERE department_id =(
                SELECT department_id
                    FROM departments
                    WHERE upper(department_name) = 'IT'
            )
    )
    ORDER BY salary,last_name;
 