-- ********************************
-- DBS301 - W19 - Week 11, Lecture Demo
-- Clint MacDonald
-- March 26, 2019
-- ********************************

-- AGENDA
    -- A little review of CREATE AS
    -- TRANSACTIONAL SQL
        -- commit, rollback, savepoint
    -- Recycling Bin
        -- show, purge, flashback
    -- Data Dictionary
    
-- Advanced CREATE
 SELECT gameID poGameID, gameNum, hometeam hTeamID, visitteam vTeamID, homescore, visitscore,
        locationid, isplayed, notes
        FROM tblDatGames
        WHERE divid IN (30);
        
-- ANY SELECT statement can be inserted into a CREATE statement
DROP TABLE d11tblDatPlayoffGames;
CREATE TABLE d11tblDatPlayoffGames AS (
    SELECT gameID poGameID, gameNum, hometeam hTeamID, visitteam vTeamID, homescore, visitscore,
        locationid, isplayed, notes
        FROM tblDatGames
        WHERE divid IN (30)
    );
    
-- CREATE using multiple tables
DROP TABLE d11tblTEMPdatPOSchedule;
CREATE TABLE d11tblTEMPdatPOSchedule AS (
    SELECT gameID poGameID, gameNum, h.teamnameshort HomeTeam, v.teamnameshort AwayTeam, homescore, visitscore,
        locationid, isplayed, notes
        FROM tbldatgames JOIN tbldatteams h ON (h.teamid = tbldatgames.hometeam)
          JOIN tbldatteams v ON (v.teamid = tbldatgames.visitteam)
        WHERE divid IN (30)
    );
    

-- TRANSACTIONS
-- in MS SQL Server

-- START TRANSACTION
-- Do Stuff
-- END TRANSACTION
-- COMMIT

-- Oracle

-- 3 Keywords
    -- COMMIT
    -- ROLLBACK
    -- SAVEPOINT <savepoint name>
    
INSERT INTO tbldatplayers VALUES (99977, '431A', 'MacDonald', 'Alexander', 1) ;
SELECT * FROM tblDatPlayers WHERE playerid = 99977;

-- i have only tried to do it, like a test, but not committed to the change yet
ROLLBACK;
SELECT * FROM tblDatPlayers WHERE playerid = 99977;
-- note the player is NOT in the dbase now

INSERT INTO tbldatplayers VALUES (99977, '431A', 'MacDonald', 'Alexander', 1) ;
SELECT * FROM tblDatPlayers WHERE playerid = 99977;
COMMIT;
-- we have now committed the transaction to the server
ROLLBACK;
SELECT * FROM tblDatPlayers WHERE playerid = 99977;

-- Multiple step transactions
SELECT * FROM tbljncrosters WHERE playerid IN(1019404, 1746230);

UPDATE tbljncrosters SET teamid = 221 WHERE rosterid = 4;
UPDATE tbljncrosters SET teamid = 214 WHERE rosterid = 14;

ROLLBACK;

-- savepoints
UPDATE tbljncrosters SET teamid = 221 WHERE rosterid = 4;
SAVEPOINT a;
UPDATE tbljncrosters SET teamid = 214 WHERE rosterid = 14;
SELECT * FROM tbljncrosters WHERE playerid IN(1019404, 1746230);
ROLLBACK to a;
SELECT * FROM tbljncrosters WHERE playerid IN(1019404, 1746230);
ROLLBACK;
SELECT * FROM tbljncrosters WHERE playerid IN(1019404, 1746230);

UPDATE tbljncrosters SET teamid = 221 WHERE rosterid = 4;
SAVEPOINT a;
UPDATE tbljncrosters SET teamid = 214 WHERE rosterid = 14;
SAVEPOINT b;
UPDATE tbljncrosters SET JerseyNumber = 99 WHERE rosterid = 4;
SELECT * FROM tbljncrosters WHERE playerid IN(1019404, 1746230);

ROLLBACK to a;
SELECT * FROM tbljncrosters WHERE playerid IN(1019404, 1746230);
ROLLBACK to b;
ROLLBACK;
SELECT * FROM tbljncrosters WHERE playerid IN(1019404, 1746230);

-- essentially we have actually done NOTHING to this point
CREATE TABLE d11Temp AS (
    SELECT * FROM tbldatplayers WHERE UPPER(namelast) LIKE 'R%'
    );
ROLLBACK;
SELECT * FROM d11Temp;
DROP TABLE d11Temp;

-- RECYCLE BIN
SHOW RecycleBin;
FLASHBACK TABLE d11Temp TO BEFORE DROP;

PURGE RecycleBin;
SHOW RecycleBin;

-- DATA DICTIONARY
SELECT * FROM ALL_OBJECTS;
SELECT * FROM ALL_OBJECTS WHERE upper(owner) NOT IN ('PUBLIC','SYS');
SELECT * FROM ALL_OBJECTS WHERE upper(owner) = 'DBS301_191B45';

CREATE VIEW d11vwPlayerRosters AS (
    SELECT  namelast || ', ' || namefirst AS FullName,
        jerseynumber AS ShirtNum,
        teamnameshort AS TeamName
    FROM (tbldatteams t LEFT OUTER JOIN tbljncrosters r USING (teamid))
        LEFT OUTER JOIN tbldatplayers p USING (playerid)
    WHERE p.isactive = 1 AND r.isactive = 1 OR p.isactive IS NULL
    ); 
    
SELECT * FROM ALL_OBJECTS WHERE upper(Object_Type) = 'VIEW' AND upper(owner) = 'DBS301_191B45';

DROP VIEW d11vwPlayerRosters;
SHOW RecycleBin;

-- GOTCHA HINT
DROP TABLE tempDODO;
CREATE TABLE tempDODO AS (
    SELECT hometeam AS "HomeTeamID", visitteam AS "VisitTeamID", homescore AS hscore, visitscore, isplayed
        FROM tbldatgames)
        ;
        
SELECT * FROM tempdodo; 
SELECT "HomeTeamID", "VisitTeamID", hscore, visitscore, isplayed FROM tempDODO;
