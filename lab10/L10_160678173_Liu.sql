-- ***********************
-- Name: Wenxuan Liu
-- ID: 160678173
-- Date: 2019/3/28
-- Purpose: Lab 10 DBS301
-- ***********************

--Q1--
--Create table L10Cities from table LOCATIONS,
--but only for location numbers less than 2000 
--(do NOT create this table from scratch, i.e. 
--create and insert in one statement).
--You will have exactly 10 rows here.
--When you describe L10Cities, the output is shown below:
--Q1--SOLUTION
CREATE TABLE L10Cities AS
    SELECT * FROM locations
            WHERE location_id <2000;
SELECT * FROM L10Cities;
DESCRIBE L10Cities;  

--Q2--
--Create table L10Towns from table LOCATIONS, but only for location 
--numbers less than 1500 (do NOT create this table from scratch). 
--This table will have same structure as table L10Cities. 
--You will have exactly 5 rows here.
--Q2--SOLUTION
CREATE TABLE L10Towns AS
    SELECT * FROM locations
        WHERE location_id<1500;
SELECT * FROM L10Towns;
DESCRIBE L10Towns; 

--Q3--
--Now you will empty your RECYCLE BIN with one powerful command. 
--Then remove your table L10Towns, so that will remain in the recycle bin. 
--Check that it is really there and what time was removed.
--Hint: Show RecycleBin,   Purge,  Flashback
--Q3--SOLUTION
PURGE RecycleBin;
SHOW RecycleBin;
DROP TABLE L10Towns;
--it was removed just now;

 --Q4--
-- Restore your table L10Towns from recycle bin and describe it. 
-- Check what is in your recycle bin now.
--Q4--SOLUTION
 FLASHBACK TABLE L10Towns TO BEFORE DROP;
 DESCRIBE L10Towns;
 SHOW RecycleBin;--it was empty now

--Q5--
--Now remove table L10Towns so that does NOT remain in the recycle bin. 
--Check that is really NOT there and then try to restore it. 
--Explain what happened?
--Q5--SOLUTION
DROP TABLE L10Towns;
PURGE RecycleBin;
FLASHBACK  TABLE L10Towns TO BEFORE DROP;
--FLASHBACK failed because of trying to Flashback Drop an object which is already not in RecycleBin. 

--Q6--
--Create simple view called CAN_CITY_VU, based on table L10Cities so 
--that will contain only columns Street_Address, Postal_Code, City 
--and State_Province for locations only in CANADA. Then display 
--all data from this view.
--Q6--SOLUTION
CREATE VIEW CAN_CITY_VU AS
    SELECT street_address, postal_code,city,state_province 
        FROM L10Cities
        WHERE upper(country_id) ='CA';
SELECT * FROM CAN_CITY_VU;

--Q7--
--	Modify your simple view so that will have following 
--    aliases instead of original column names: Str_Adr, P_Code, City 
--    and Prov and also will include cities from ITALY as well. 
--    Then display all data from this view. 
--Q7--SOLUTION
CREATE OR REPLACE VIEW CAN_CITY_VU AS
     SELECT street_address AS Str_Adr, 
            postal_code AS P_Code,
            city AS City,
            state_province AS Prov
        FROM L10Cities
        WHERE upper(country_id) IN ('CA','IT');
SELECT * FROM CAN_CITY_VU;
--Q8--
--Create complex view called vwCity_DName_VU, based on tables LOCATIONS 
--and DEPARTMENTS, so that will contain only columns Department_Name, City 
--and State_Province for locations in ITALY or CANADA. Include situations even 
--when city does NOT have department established yet. 
--Then display all data from this view.
--Q8--SOLUTION
CREATE VIEW vwCity_DName_VU AS
    SELECT department_name,city,state_province
            FROM departments RIGHT OUTER JOIN locations USING (location_id)
            WHERE upper(country_id) IN ('CA','IT');
SELECT * FROM vwCity_DName_VU;

--Q9--
--Modify your complex view so that will have following aliases instead of 
--original column names: DName, City and Prov and also will 
--include all cities outside United States   Include situations even 
--when city does NOT have department established yet. 
--Then display all data from this view.
--Q9--SOLUTION--
CREATE OR REPLACE VIEW vwCity_DName_VU AS
    SELECT department_name AS DName,
           city AS City,
           state_province AS Prov
            FROM departments RIGHT OUTER JOIN locations USING (location_id)
            WHERE upper(country_id) !='US';
SELECT * FROM vwCity_DName_VU;
--Q10--
--Check in the Data Dictionary what Views (their names and definitions) 
--are created so far in your account. Then drop your vwCity_DName_VU and
--check Data Dictionary again. What is different? resource: 
--https://docs.oracle.com/cd/A97630_01/server.920/a96524/c05dicti.htm 
--Q10--SOLUTION
SELECT * FROM ALL_OBJECTS WHERE upper(Object_Type) = 'VIEW' AND upper(owner) = 'DBS301_191A38';
DROP VIEW vwCity_DName_VU;
SELECT * FROM ALL_OBJECTS WHERE upper(Object_Type) = 'VIEW' AND upper(owner) = 'DBS301_191A38';
--The view vwCity_DName_VU is removed from my Data Dictionary.

