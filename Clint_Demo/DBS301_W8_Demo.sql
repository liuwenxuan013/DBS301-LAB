-- *************************
-- WEEK 8 Demos DBS301
-- Clint MacDonald
-- March 5, 2019
-- SET OPERATORS and DDL, DML, CREATE review
-- *************************

-- Coverage for Part 2 of DBS301

-- SET OPERATORS
--------------------------------------
-- UNION
-- UNION ALL
-- INTERSECT
-- MINUS

-- EXAMPLE 1:   List all players whose last name starts with "st" or whose first name starts with "D"
--              DO NOT use any comparator operators in the statement (i.e. no AND or OR)
SELECT * FROM tbldatplayers
    WHERE upper(namelast) LIKE 'ST%'
    ORDER BY namelast;
    -- returned 13 rows
-- now the second half
SELECT * FROM tbldatplayers
    WHERE upper(namefirst) LIKE 'D%'
    ORDER BY namefirst;
    --returned 53 rows
    
-- Join them together using UNION
SELECT * FROM tbldatplayers
    WHERE upper(namelast) LIKE 'ST%'

UNION

SELECT * FROM tbldatplayers
    WHERE upper(namefirst) LIKE 'D%';
-- note, you cannot use ORDER BY and UNION together without doing other things
-- note - 63 records, not 66, duplicate records are removed
-- but what if we need information about duplicate records
SELECT * FROM tbldatplayers
    WHERE upper(namelast) LIKE 'ST%'
UNION ALL
SELECT * FROM tbldatplayers
    WHERE upper(namefirst) LIKE 'D%';
    -- now we get 66 rows
    -- BUT, we need to order it.
    
SELECT * FROM (
        SELECT * FROM tbldatplayers
            WHERE upper(namelast) LIKE 'ST%'
        UNION ALL
        SELECT * FROM tbldatplayers
            WHERE upper(namefirst) LIKE 'D%'
)
ORDER BY namelast, namefirst;


    -- Combine this with aggregates
    
    
SELECT namelast, namefirst, COUNT(playerid) AS NumRepeats
    FROM (
        SELECT * FROM tbldatplayers
            WHERE upper(namelast) LIKE 'ST%'
        UNION ALL
        SELECT * FROM tbldatplayers
            WHERE upper(namefirst) LIKE 'D%'
    )
    GROUP BY namelast, namefirst
    ORDER BY NumRepeats DESC, namelast, namefirst;
    
        
-- EXAMPLE 2 - List all teams who play today
SELECT * FROM (SELECT hometeam AS tID, teamnameshort, gameid
    FROM tbldatgames JOIN tbldatteams 
        ON tbldatgames.hometeam = tbldatteams.teamid
    WHERE gamedatetime BETWEEN sysdate - 1 AND sysdate + 3

UNION

SELECT visitteam, teamnameshort, gameid
    FROM tbldatgames JOIN tbldatteams 
        ON tbldatgames.visitteam = tbldatteams.teamid
    WHERE gamedatetime BETWEEN sysdate - 1 AND sysdate + 3)
    ORDER BY gameid;
    
-- INTERSECT
-- back to names example
SELECT * FROM tbldatplayers
    WHERE upper(namelast) LIKE 'ST%'
INTERSECT
SELECT * FROM tbldatplayers
    WHERE upper(namefirst) LIKE 'D%';
    
-- MINUS
SELECT * FROM tbldatplayers
    WHERE upper(namelast) LIKE 'ST%'
MINUS
SELECT * FROM tbldatplayers
    WHERE upper(namefirst) LIKE 'D%';
    
    -- OR
SELECT * FROM tbldatplayers
    WHERE upper(namefirst) LIKE 'D%'
MINUS
SELECT * FROM tbldatplayers
    WHERE upper(namelast) LIKE 'ST%';

-- ********************************************
-- DDL - Data Definition Language
-- CREATE, ALTER, DROP
-- CONSTRAINTS
--    CHECK, DEFAULT, NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY
--    INDEXES

-- DML - Data Manipulation Language
-- INSERT, UPDATE, DELETE
-- others include TRUNCATE
-- Transactions
--   COMMIT, ROLLBACK, FOR UPDATE
-- ********************************************
-- CREATE review
 -- 7 CONSTRAINTS
 --     PRIMARY KEY
 --     FOREIGN KEY
 --     NOT NULL
 --     UNIQUE
 --     DEFAULT
 --     CHECK
 --     INDEXES
 
 -- quick review of CREATE
  -- Generic Format
 --CREATE TABLE table_name (
--    column1 datatype <constraint1> <constraint2>...,
--    column2 datatype <constraint1> <constraint2>...,
--    column3 datatype <constraint1> <constraint2>...,
--    CONSTRAINT <constraintname> details...,
--);
CREATE TABLE tblListLocations (
    locationID INT PRIMARY KEY,
    locationName varchar(50) NOT NULL,
    fieldLength INT CHECK (fieldLength BETWEEN 90 AND 110)
    );
    
INSERT INTO tbllistlocations VALUES (1, 'Field 1', 100);
INSERT INTO tbllistlocations (locationID, fieldLength, locationName) VALUES (2, 95, 'Field 2');

UPDATE tbllistlocations SET locationName = 'Banat Field' WHERE locationID = 1;

DELETE FROM tbllistlocations WHERE locationID = 2;

    