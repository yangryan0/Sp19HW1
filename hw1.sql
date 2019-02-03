DROP VIEW IF EXISTS q0, q1i, q1ii, q1iii, q1iv, q2i, q2ii, q2iii, q3i, q3ii, q3iii_helper, q3iii, q4i, q4ii_helper, salary_floor, tenth, inter, inter3, q4ii, q4iii, q4iv, q4v;

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
  select p.playerid, namefirst, namelast, yearid, cast(b1.h - (b1.h2b + b1.h3b + b1.hr) + (b1.h2b * 2) + (b1.h3b * 3) + (b1.hr * 4) as float) / cast(b1.ab as float) as slg
  from batting b1, people p
  where p.playerid = b1.playerid and b1.ab > 50
  order by slg desc, yearid, playerid asc
  limit 10 
;

-- Question 3ii
CREATE VIEW q3ii(playerid, namefirst, namelast, lslg)
AS
  select p.playerid, namefirst, namelast, cast(sum(b.h) - (sum(b.h2b) + sum(b.h3b) + sum(b.hr))  + (sum(b.h2b) * 2) + (sum(b.h3b) * 3) + (sum(b.hr) * 4) as float) / cast(sum(b.ab) as float) as lslg
  from batting b, people p
  where p.playerid = b.playerid
  group by p.playerid
  having sum(b.ab) > 50
  order by lslg desc, playerid asc
  limit 10
;

CREATE VIEW q3iii_helper(playerid, namefirst, namelast, lslg)
AS
  select p.playerid, namefirst, namelast, cast(sum(b.h) - (sum(b.h2b) + sum(b.h3b) + sum(b.hr))  + (sum(b.h2b) * 2) + (sum(b.h3b) * 3) + (sum(b.hr) * 4) as float) / cast(sum(b.ab) as float) as lslg
  from batting b, people p
  where p.playerid = b.playerid
  group by p.playerid
  having sum(b.ab) > 50
  order by lslg desc, playerid asc
;



-- Question 3iii
CREATE VIEW q3iii(namefirst, namelast, lslg)
AS
  select namefirst, namelast, lslg
  from q3iii_helper q
  where lslg >
  	any(select cast(sum(b.h) - (sum(b.h2b) + sum(b.h3b) + sum(b.hr)) + (sum(b.h2b) * 2) + (sum(b.h3b) * 3) + (sum(b.hr) * 4) as float) / cast(sum(b.ab) as float) as lslgwillie
  	from batting b
  	where b.playerid = 'mayswi01'
  	group by b.playerid)
;

-- Question 4i
CREATE VIEW q4i(yearid, min, max, avg, stddev)
AS
  select yearid, MIN(salary), MAX(salary), AVG(salary), stddev(salary)
  from salaries
  group by yearid
  order by yearid asc
;

create view q4ii_helper(salary)
as
  select salary
  from salaries
  where yearid = 2016
;

create view salary_floor(floors, min, floor_width)
as
  select floor((salary  - (select min(salary) from q4ii_helper))/ (((select max(salary) from q4ii_helper) - (select min(salary) from q4ii_helper)) / 10.0)) * (((select max(salary) from q4ii_helper) - (select min(salary) from q4ii_helper)) / 10.0), (select min(salary) from q4ii_helper), (((select max(salary) from q4ii_helper) - (select min(salary) from q4ii_helper)) / 10.0)
  from q4ii_helper
;

CREATE VIEW tenth(binid, low, high, count)
AS
  select (floors) / floor_width, floors + min, floors + min + floor_width, count(*) as count
  from salary_floor
  group by floors + min, floors, floor_width
  order by floors + min
;

create view inter(binid, low, high, count)
as
  select binid, low, high, count + (select max(a.count) from tenth a where a.binid=10)
  from tenth
  where binid = 9
;

create view inter3(binid, low, high, count)
as
  select binid, low, high, count
  from tenth
  order by binid asc
  limit 9
;
  

-- Question 4ii
CREATE VIEW q4ii(binid, low, high, count)
AS
  select * from inter3
  union all
  select * from inter
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

