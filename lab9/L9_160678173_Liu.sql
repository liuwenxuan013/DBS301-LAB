-- ***********************
-- Name: Wenxuan Liu
-- ID: 160678173
-- Date: 2019/3/20
-- Purpose: Lab 9 DBS301
-- ***********************

--Q1--
--Create table L09SalesRep and load it with data from table EMPLOYEES table. 
--Use only the equivalent columns from EMPLOYEE as shown below and only for people in department 80.
--Column          		Type    	    
--RepId			NUMBER	(6)	
--FName			VARCHAR2(20)    
--LName			VARCHAR2(25)   
--Phone#			VARCHAR2(20)         ALL these columns’ data types match 
--Salary			NUMBER(8,2)                            one’s in table EMPLOYEES
--Commission		NUMBER(2,2)
--	You will have exactly 3 rows here.

--Q1--Solution
CREATE TABLE L09SalesRep AS
    SELECT employee_id AS "RepId",
           first_name AS "FName",
           last_name AS "LName",
           phone_number AS "Phone#",
           salary AS "Salary",
           commission_pct AS "Commission"
        FROM employees
        WHERE department_id =80;

SELECT * FROM  L09SalesRep;
--Q2--Create L09Cust table.
--NOTE: Caution that copying from WORD will create errors if WORD is using quotes that look like ‘this’ 
--- SQL needs straight quotes like 'this'
--The constraints were left off in the above.  
--The constraints shown below are what would normally be applied as shown. 
--These were applied at the table level.  Do not add these at this time, 
--you will do so through the following questions.
--Q2-Solution
CREATE TABLE L09Cust(
    CUST#	  	NUMBER(6),
    CUSTNAME 	VARCHAR2(30),
    CITY 		VARCHAR2(20),
    RATING		CHAR(1),
    COMMENTS	VARCHAR2(200),
    SALESREP#	NUMBER(7) 
    );
   
INSERT ALL
    INTO L09Cust(CUST#,CUSTNAME,CITY,RATING,SALESREP#) VALUES (501,'ABC LTD.','Montreal','C',201)
    INTO L09Cust(CUST#,CUSTNAME,CITY,RATING,SALESREP#) VALUES (502,'Black Giant','Ottawa','B',202)
    INTO L09Cust(CUST#,CUSTNAME,CITY,RATING,SALESREP#) VALUES (503,'Mother Goose','London','B',202)
    INTO L09Cust(CUST#,CUSTNAME,CITY,RATING,SALESREP#) VALUES (701,'BLUE SKY LTD','Vancouver','B',102)
    INTO L09Cust(CUST#,CUSTNAME,CITY,RATING,SALESREP#) VALUES (702,'MIKE and SAM Inc.','Kingston','A',107)
    INTO L09Cust(CUST#,CUSTNAME,CITY,RATING,SALESREP#) VALUES (703,'RED PLANET','Mississauga','C',107)
    INTO L09Cust(CUST#,CUSTNAME,CITY,RATING,SALESREP#) VALUES (717,'BLUE SKY LTD','Regina','D',102)
    SELECT * FROM dual;
--Q3--
--Create table L09GoodCust by using following columns but only if their rating is A or B. 
--Q3 Solution
CREATE TABLE L09GoodCust AS
    SELECT CUST# AS "CustId",
           CUSTNAME AS "Name",
           CITY AS "Location",
           SALESREP# AS "RepId"
        FROM L09Cust
        WHERE RATING IN ('A','B');
SELECT * FROM L09GoodCust;       

--Q4--
--Now add new column to table L09SalesRep called JobCode 
--that will be of variable character type with max length of 12.
--Do a DESCRIBE L09SalesRep to ensure it executed
--Q4--Solution
ALTER TABLE L09SalesRep 
    ADD "JobCode" varchar2(12);
DESCRIBE L09SalesRep;
--Q5--
--Declare column Salary in table L09SalesRep as mandatory one and 
--Column Location in table L09GoodCust as optional one. 
--You can see location is already optional.
--Q5--Solution
ALTER TABLE L09SalesRep
    MODIFY "Salary" NOT NULL;
--DESCRIBE  L09GoodCust;
--ALTER TABLE L09GoodCust 
--    MODIFY "Location" NULL;
-- it failed because the column already allow NULL values;

DESCRIBE L09SalesRep;
DESCRIBE L09GoodCust;
--Q5--
--Lengthen FNAME in L09SalesRep to 37.
--The result of a DESCRIBE should show it happening
ALTER TABLE L09SalesRep
    MODIFY "FName" varchar2(37);
DESCRIBE L09SalesRep;
--You can only decrease the size or length of Name in L09GoodCust to the maximum 
--length of data already stored. Do it by using SQL and not by looking at each entry 
--and counting the characters. May take two SQL statements
--DESC L09GoodCust;
--SELECT * FROM L09GoodCust;
--DECLARE @a NUMERIC SET @a = (SELECT max(length("Name")) from L09GoodCust);--17
--ALTER TABLE L09GoodCust
--    MODIFY "Name" varchar2(@a);
--Q6--
--Now get rid of the column JobCode in table L09SalesRep in a way 
--that will not affect daily performance. 
--Q6 Solution
ALTER TABLE L09SalesRep
    SET UNUSED("JobCode");
DESCRIBE L09SalesRep;

--Q7--
--Declare PK constraints in both new tables -> RepId and CustId
--Q7 Solution
ALTER TABLE L09SalesRep
    ADD CONSTRAINT  PK_L09SalesRep PRIMARY KEY ("RepId");
ALTER TABLE L09GoodCust
    ADD CONSTRAINT  PK_L09GoodCust PRIMARY KEY ("CustId");

--Q8--
--Declare UK constraints in both new tables ->  Phone# and Name
--Q8 Solution
ALTER TABLE L09SalesRep
    ADD CONSTRAINT UC_L09SalesRep UNIQUE ("Phone#");
ALTER TABLE L09GoodCust
    ADD CONSTRAINT UC_L09GoodCust UNIQUE ("Name");   
--Q9--
--Restrict amount of Salary column to be in the range [6000, 12000] 
--and Commission to be not more than 50%.
--Q9 Solution
ALTER TABLE L09SalesRep
    ADD CONSTRAINT CK_L09SalesRep CHECK(("Salary" BETWEEN 6000 AND 12000) AND "Commission" < 0.5);
--Q10--
--Ensure that only valid RepId numbers from table L09SalesRep may be entered in the table L09GoodCust. 
--Why this statement has failed?
--Q10--Solution
--ALTER TABLE L09GoodCust
--    ADD CONSTRAINT FK_L09GoodCust FOREIGN KEY ("RepId") REFERENCES L09SalesRep("RepId");
--It has failed because the table L09GoodCust already has the values of the "RepId" 
--Q11--
--Firstly write down the values for RepId column in table L09GoodCust and then make all these values blank. 
--Now redo the question 10. Was it successful? 
UPDATE L09GoodCust SET "RepId" = NULL;
ALTER TABLE L09GoodCust
    ADD CONSTRAINT FK_L09GoodCust FOREIGN KEY ("RepId") REFERENCES L09SalesRep("RepId");
--it was successful

--Q12--
--Disable this FK constraint now and enter old values for RepId in table L09GoodCust and save them. 
--Then try to enable your FK constraint. What happened? 
--Q12 Solution
ALTER TABLE L09GoodCust DISABLE CONSTRAINT FK_L09GoodCust;
UPDATE  L09GoodCust SET "RepId" = 202 WHERE "CustId"=502;
UPDATE  L09GoodCust SET "RepId" = 202 WHERE "CustId"=503;
UPDATE  L09GoodCust SET "RepId" = 102 WHERE "CustId"=701;
UPDATE  L09GoodCust SET "RepId" = 107 WHERE "CustId"=702;
ALTER TABLE L09GoodCust ENABLE CONSTRAINT FK_L09GoodCust;
-- it failed because the table has child records, the same cause as Q10

--Q13--
--Get rid of this FK constraint. Then modify your CK constraint from question 9 to allow 
--Salary amounts from 5000 to 15000.
--Q13 Solution
ALTER TABLE L09GoodCust DROP CONSTRAINT FK_L09GoodCust;
ALTER TABLE L09SalesRep DROP CONSTRAINT CK_L09SalesRep;
ALTER TABLE L09SalesRep
    ADD CONSTRAINT CK_L09SalesRep CHECK("Salary" BETWEEN 5000 AND 15000);
--Q14--
--Describe both new tables L09SalesRep and L09GoodCust and then show all constraints for 
--these two tables by running the following query:
--Q14 Solution
DESCRIBE L09SalesRep;
DESCRIBE L09GoodCust;
SELECT constraint_name,constraint_type,search_condition,table_name 
    FROM  user_constraints
    WHERE upper(table_name) IN ('L09SALESREP','L09GOODCUST')
    ORDER BY 4,2;