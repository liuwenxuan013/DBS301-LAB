-- Week 6 Demo  (Sub-Queries and putting it together)
-- Using Sportleagues database and Employees database
-- Feb 14, 2019
-- *****************************

-- Types of Queries
-- TABULAR - Returns a table with columns and rows
-- LIST    - Single Column, multiple Rows
-- SCALAR  - Returns a single value

-- SCALAR EXAMPLE:
-- What was the most goals scored in one game by a single player..
SELECT max(NumGoals) AS "Max Goals"
    FROM tbldatgoalscorers;
    -- we see the answer was 5
-- which player or players scored 5
SELECT playerID
    FROM tbldatgoalscorers
    WHERE NumGoals = 5;
-- we see 4 results, but 1 was a duplicate, meaning the same player scored 5 goals twice
SELECT DISTINCT playerID
    FROM tbldatgoalscorers
    WHERE NumGoals = 5;
-- no hard coding, we need to find out the 5 on the fly

SELECT DISTINCT playerID
    FROM tbldatgoalscorers
    WHERE NumGoals = 
        (
        SELECT max(NumGoals) 
            FROM tbldatgoalscorers
        );
   -- proof of yesterday, today and tomorrow
UPDATE tbldatgoalscorers SET NumGoals = 6 WHERE goalID = 12;
        -- rerun statement, now only get 1 results....prooving tomorrow works.
UPDATE tbldatgoalscorers SET NumGoals = 5 WHERE goalID = 12;

-- we want names
SELECT namefirst, namelast, playerid
    FROM tbldatplayers
    WHERE playerid IN (
        SELECT DISTINCT playerID
            FROM tbldatgoalscorers
            WHERE NumGoals = 
                (
                SELECT max(NumGoals) 
                    FROM tbldatgoalscorers
                )
        );
        
 -- LISTS
-- List all employees that work in Seattle (Do not use joins)

-- Inside to outside, inside first
SELECT location_id 
    FROM locations
    WHERE upper(city) = 'SEATTLE';
    
-- let's look at the middle
SELECT department_id
    FROM departments
    WHERE location_id IN (
        SELECT location_id 
            FROM locations
            WHERE upper(city) = 'SEATTLE'
        );
-- outside, employees that work in this 
--      list of departments that are in the 
--      list of locations that are 
--      in Seattle
SELECT first_name, last_name
    FROM employees
    WHERE department_id IN 
        (
        SELECT department_id 
            FROM departments
            WHERE location_id IN 
                (
                SELECT location_id 
                    FROM locations
                    WHERE upper(city) = 'SEATTLE'
                )
        )
    ORDER BY last_name, first_name;


-- List all the employees, by name, and their department names (DO NOT USE JOINS)
SELECT  first_name, 
        last_name, 
        (SELECT department_name FROM departments WHERE department_id = e.department_id) AS DeptName
    FROM employees e
    ORDER BY last_name, first_name;

-- Show using the above query, only those records that the persons first name contains an "i"
SELECT first_name, last_name, DeptName
    FROM    (
            SELECT  first_name, 
                    last_name, 
                    (SELECT department_name FROM departments WHERE department_id = e.department_id) AS DeptName
                FROM employees e
                ORDER BY last_name, first_name
            ) t
    WHERE upper(first_name) LIKE '%I%'
    ORDER BY DeptName, last_name;
    