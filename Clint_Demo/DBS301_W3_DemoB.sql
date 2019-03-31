-------------------------------------------------------
-- Week 3 Working Demos
-- Created by: Clint MacDonald
-- January 22, 2019
-- Purpose: Week 3, Lesson 3 Working Demos DBS301
-- Description: Using Single-Line Functions in SELECT statements
-- 				in addition to more string formatting
-----------------------------------------------------------------

-- From week 2
-- list all countries that start with "C"
SELECT * FROM countries WHERE upper(country_name) LIKE 'C%';

-- but what if I want to use a different letter, without making 26 SQL statements
-- introduce a PARAMETER
SELECT * FROM countries WHERE upper(country_name) LIKE upper('&EnterLetter%');

-- let's optimize the country_name field by setting it to the perfect length (size)
SELECT country_name, length(country_name) AS "Name Length"
    FROM countries
    ORDER BY "Name Length" DESC;
    
-- just for fun, let's play with the replace function
-- replace all a's in countries with o's.
SELECT country_name, replace(country_name, 'a', 'o') AS "The New World Order"
    FROM countries
    ORDER BY country_name;
    
-- straight up calculated field
SELECT  last_name, first_name,
        salary AS "Old Salary",
        salary + 200 AS "New Salary"
    FROM employees;
    
-- relative math
SELECT  last_name, first_name,
        salary AS "Old Salary",
        salary * 1.2 AS "New Salary"
    FROM employees;
    
-- DATES
-- get today's date
SELECT sysdate FROM dual;
-- for fun
SELECT * FROM dual;

-- what is the date 10 days ago
SELECT sysdate - 10 FROM dual;

-- list all employees hired in 1998
SELECT * FROM employees
    WHERE hire_date BETWEEN to_date('01011998','ddmmyyyy') AND to_date('12311998', 'mmddyyyy');

SELECT * FROM employees
    WHERE hire_date >= to_date('01011998','ddmmyyyy') 
        AND hire_date < to_date('01011999', 'mmddyyyy');   
        
-- let's use extract
SELECT * FROM employees
    WHERE extract(year FROM hire_date) = 1998;
    
-- what is the date of next Saturday
SELECT next_day(sysdate, 'Saturday') AS "Next Saturday"
    FROM dual;

-- what is the date 3 thursdays from now
SELECT next_day(sysdate + (2 * 7), 'Thursday') AS "A Thursday"
    FROM dual;
    
-- let's let the user request the number of weeks away
SELECT to_char(next_day(sysdate + ((&NumWeeks - 1) * 7), 'Thursday'), 'dd-mon-yyyy') AS "A Thursday"
    FROM dual;
    
-- Let's play with stroing formatting of dates
SELECT sysdate FROM dual;
-- let's make it look like   Jan 22, 2019
SELECT to_char(sysdate, 'Mon dd, yyyy') FROM dual;

-- make it look like   Jan the 22 of 2019
SELECT to_char(sysdate, 'Mon" the "dd" of "yyyy') FROM dual;

-- entire month name
SELECT to_char(sysdate + 120, 'Month" the "dd" of "yyyy') FROM dual;

-- but what's with the space after May
SELECT to_char(sysdate + 120, 'fmMonth" the "dd" of "yyyy') FROM dual;

-- let's spell the day out in text
SELECT to_char(sysdate + 107, 'fmMonth" the "Ddsp" of "yyyy') FROM dual;

Week 3 Single Line Functions

Concepts
- the built-in "dual" table

Single Line Functions
NOTE: value often means field name
STRING FUNCTIONS
- to_char(value, format)
- upper, lower, initcap, 
- concat, substr, length, instr, 
- lpad, rpad, trim
- to_date(date string, format string)
- replace(value, string to replace, replacement string)

MATH FUNCTIONS
- round(value, # decimals), trunc(value, #decimals), mod(value)
- Ceil, Floor

DATE FUNCTIONS
- next_day(value, day name string), last_day, add_months, months_between, 
- round, trunc, sysdate

MISC FUNCTIONS
- case() - used in case selects
- NVL(value, replacement string)

CALCULATED FIELDS
- using either single line functions, or mathematics to alter the field values
- usually require an alias to be assigned