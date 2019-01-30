DROP VIEW IF EXISTS q0, q1i, q1ii, q1iii, q1iv, q2i, q2ii, q2iii, q3i, q3ii, q3iii, q4i, q4ii, q4iii, q4iv, q4v;

-- Question 0
CREATE VIEW q0(era) 
AS
  select max(era)
  from pitching
;

-- Question 1i
CREATE VIEW q1i(namefirst, namelast, birthyear)
AS
  select namefirst, namelast, birthyear
  from people
  where weight > 300
;

-- Question 1ii
CREATE VIEW q1ii(namefirst, namelast, birthyear)
AS
  select namefirst, namelast, birthyear
  from people
  where rtrim(namefirst) like '% %'
;

-- Question 1iii
CREATE VIEW q1iii(birthyear, avgheight, count)
AS
  select birthyear, avg(height), count(*)
  from people
  group by birthyear
  order by birthyear asc
;

-- Question 1iv
CREATE VIEW q1iv(birthyear, avgheight, count)
AS
  select *
  from q1iii
  where avgheight > 70
  order by birthyear asc
;

-- Question 2i
CREATE VIEW q2i(namefirst, namelast, playerid, yearid)
AS
  select people.namefirst, people.namelast, people.playerid, halloffame.yearid
  from halloffame, people
  where inducted = 'Y' and halloffame.playerid = people.playerid
  order by yearid desc
;

-- Question 2ii
CREATE VIEW q2ii(namefirst, namelast, playerid, schoolid, yearid)
AS
  select q2i.namefirst, q2i.namelast, q2i.playerid, c.schoolid, q2i.yearid
  from q2i, collegeplaying as c, schools as s
  where q2i.playerid = c.playerid and c.schoolid = s.schoolid and s.schoolstate = 'CA'
  order by yearid desc, schoolid, playerid asc
;

-- Question 2iii
CREATE VIEW q2iii(playerid, namefirst, namelast, schoolid)
AS
  select q2i.playerid, namefirst, namelast, schoolid
  from q2i
  left join collegeplaying c on q2i.playerid = c.playerid
  order by playerid desc, schoolid asc
;

-- Question 3i
CREATE VIEW q3i(playerid, namefirst, namelast, yearid, slg)
AS
  
;

-- Question 3ii
CREATE VIEW q3ii(playerid, namefirst, namelast, lslg)
AS
  SELECT 1, 1, 1, 1 -- replace this line
;

-- Question 3iii
CREATE VIEW q3iii(namefirst, namelast, lslg)
AS
  SELECT 1, 1, 1 -- replace this line
;

-- Question 4i
CREATE VIEW q4i(yearid, min, max, avg, stddev)
AS
  SELECT 1, 1, 1, 1, 1 -- replace this line
;

-- Question 4ii
CREATE VIEW q4ii(binid, low, high, count)
AS
  SELECT 1, 1, 1, 1 -- replace this line
;

-- Question 4iii
CREATE VIEW q4iii(yearid, mindiff, maxdiff, avgdiff)
AS
  SELECT 1, 1, 1, 1 -- replace this line
;

-- Question 4iv
CREATE VIEW q4iv(playerid, namefirst, namelast, salary, yearid)
AS
  SELECT 1, 1, 1, 1, 1 -- replace this line
;
-- Question 4v
CREATE VIEW q4v(team, diffAvg) AS
  SELECT 1, 1 -- replace this line
;

