-- ********************************************
-- Week 5 Demo 
-- Using Sportleagues database
-- Covering Simple Joins and Advanced Joins
-- i.e. SELECTs with multiple tables in the FROM portion of the statement
-- ********************************************
SELECT * FROM tbldatplayers;
SELECT COUNT(playerid) AS NumPlayers FROM tbldatplayers;

SELECT * FROM tbldatteams;
SELECT COUNT(teamid) AS NumTeams FROM tbldatteams;

SELECT * FROM tbljncRosters;
SELECT COUNT(rosterID) from tbljncrosters;

-- let's add names to to the rosters
SELECT namefirst, namelast, teamid, jerseynumber
    FROM tbldatplayers, tbljncrosters
    ORDER BY teamid, namelast, namefirst;
        -- oops we got 137000 records, wtf
SELECT namefirst, namelast, teamid, jerseynumber
    FROM tbldatplayers, tbljncrosters
    WHERE tbldatplayers.playerid = tbljncrosters.playerid
    ORDER BY teamid, namelast, namefirst;
    -- but we loaded 137000 records to only show 230
    -- not very efficient
    -- ***** ^ NEVER DO THIS ^
    
-- Let's use Joins
-- 5 types of joins
/*  1) Simple Join (NEVER USE THIS)
    2) INNER  (Default Join)
    3) FULL
    4) LEFT OUTER
    5) RIGHT OUTER */

SELECT namefirst, namelast, teamid, jerseynumber
    FROM tbldatplayers INNER JOIN tbljncrosters 
        ON tbldatplayers.playerid = tbljncrosters.playerid
    ORDER BY teamid, namelast, namefirst;
-- alternatively there is a shortcut if and only if the fields names are IDENTICAL
SELECT namefirst, namelast, teamid, jerseynumber
    FROM tbldatplayers INNER JOIN tbljncrosters 
        USING (playerid)
    ORDER BY teamid, namelast, namefirst;
    
-- let's show all players regardless if they are
-- currently on a team roster
SELECT namefirst, namelast, teamid, jerseynumber
    FROM tbldatplayers LEFT OUTER JOIN tbljncrosters 
        ON tbldatplayers.playerid = tbljncrosters.playerid
    ORDER BY teamid, namelast, namefirst;
-- just for clarity
SELECT namefirst, namelast, teamid, jerseynumber
    FROM tbljncrosters RIGHT OUTER JOIN tbldatplayers 
        ON tbldatplayers.playerid = tbljncrosters.playerid
    ORDER BY teamid, namelast, namefirst;
    -- IS EXACTLY THE SAME
    
-- BUT
SELECT namefirst, namelast, teamid, jerseynumber
    FROM tbljncrosters LEFT OUTER JOIN tbldatplayers 
        ON tbldatplayers.playerid = tbljncrosters.playerid
    ORDER BY teamid, namelast, namefirst;
-- so this returns only players actually currently on teams through the rosters table

-- we now want to show all records from BOTH tables
SELECT namefirst, namelast, teamid, jerseynumber
    FROM tbljncrosters FULL JOIN tbldatplayers 
        ON tbldatplayers.playerid = tbljncrosters.playerid
    ORDER BY teamid, namelast, namefirst;
    
-- now let's look at team names and player names
SELECT namefirst, namelast, tbljncrosters.teamid, teamnameshort, jerseynumber
    FROM (tbljncrosters INNER JOIN tbldatplayers 
        ON tbldatplayers.playerid = tbljncrosters.playerid)
        INNER JOIN tbldatteams
            ON tbldatteams.teamid = tbljncrosters.teamid
    ORDER BY teamid, namelast, namefirst;
    
    -- show an example where which table for ambiguous fields matters
SELECT namefirst, namelast, tbljncrosters.teamid, teamnameshort, jerseynumber
    FROM (tbljncrosters INNER JOIN tbldatplayers 
        ON tbldatplayers.playerid = tbljncrosters.playerid)
        RIGHT OUTER JOIN tbldatteams
            ON tbldatteams.teamid = tbljncrosters.teamid
    ORDER BY teamid, namelast, namefirst; 
    -- change ambiguous fields table reference
SELECT namefirst, namelast, tbldatteams.teamid, teamnameshort, jerseynumber
    FROM (tbljncrosters INNER JOIN tbldatplayers 
        ON tbldatplayers.playerid = tbljncrosters.playerid)
        RIGHT OUTER JOIN tbldatteams
            ON tbldatteams.teamid = tbljncrosters.teamid
    ORDER BY teamnameshort, namelast, namefirst;

    
-- let us display all players NOT currently on a roster 
SELECT namefirst, namelast, tbljncrosters.teamid, jerseynumber
    FROM (tbljncrosters RIGHT OUTER JOIN tbldatplayers 
        ON tbldatplayers.playerid = tbljncrosters.playerid)
    WHERE tbljncrosters.teamid IS NULL
    ORDER BY namelast, namefirst;
    
-- let's print 1 team only and show the team roster
SELECT namefirst, namelast, tbldatteams.teamid, teamnameshort, jerseynumber
    FROM (tbljncrosters INNER JOIN tbldatplayers 
        ON tbldatplayers.playerid = tbljncrosters.playerid)
       INNER JOIN tbldatteams
            ON tbldatteams.teamid = tbljncrosters.teamid
    WHERE tbldatteams.teamid = 222
    ORDER BY teamnameshort, namelast, namefirst;
    
    -- but i want to search by name
SELECT namefirst, namelast, tbldatteams.teamid, teamnameshort, jerseynumber
    FROM (tbljncrosters INNER JOIN tbldatplayers 
        ON tbldatplayers.playerid = tbljncrosters.playerid)
        INNER JOIN tbldatteams
            ON tbldatteams.teamid = tbljncrosters.teamid
    WHERE upper(teamnameshort) = 'BANAT'
    ORDER BY teamnameshort, namelast, namefirst;
-- we need flexibility and object oriented approach
-- add a parameter
SELECT namefirst, namelast, tbldatteams.teamid, teamnameshort, jerseynumber
    FROM (tbljncrosters INNER JOIN tbldatplayers 
        ON tbldatplayers.playerid = tbljncrosters.playerid)
        INNER JOIN tbldatteams
            ON tbldatteams.teamid = tbljncrosters.teamid
    WHERE upper(teamnameshort) = upper('&TeamName')
    ORDER BY teamnameshort, namelast, namefirst;
    
-- we don't know how to spell
SELECT namefirst, namelast, tbldatteams.teamid, teamnameshort, jerseynumber
    FROM (tbljncrosters INNER JOIN tbldatplayers 
        ON tbldatplayers.playerid = tbljncrosters.playerid)
        INNER JOIN tbldatteams
            ON tbldatteams.teamid = tbljncrosters.teamid
    WHERE upper(teamnameshort) LIKE upper('%&TeamName%')
    ORDER BY teamnameshort, namelast, namefirst;
    
-- One last thing  - Aliases
-- table aliases
SELECT namefirst, namelast, t.teamid, teamnameshort, jerseynumber
    FROM (tbljncrosters r INNER JOIN tbldatplayers p
        ON p.playerid = r.playerid)
        INNER JOIN tbldatteams t
            ON t.teamid = r.teamid
    WHERE upper(teamnameshort) LIKE upper('%&TeamName%')
    ORDER BY teamnameshort, namelast, namefirst;