-- Lab 5
-- tohashi
-- Jun 15, 2020

USE `AIRLINES`;
-- AIRLINES-1
-- Find all airports with exactly 17 outgoing flights. Report airport code and the full name of the airport sorted in alphabetical order by the code.
select Code, Name
from airports
join flights on Source = Code
group by Source
having count(*) = 17
order by Code;


USE `AIRLINES`;
-- AIRLINES-2
-- Find the number of airports from which airport ANP can be reached with exactly one transfer. Make sure to exclude ANP itself from the count. Report just the number.
select count(distinct f.Source)
from flights f, flights f2
where f.Destination = f2.Source
    and f2.Destination = 'ANP'
    and f.Source != 'ANP';


USE `AIRLINES`;
-- AIRLINES-3
-- Find the number of airports from which airport ATE can be reached with at most one transfer. Make sure to exclude ATE itself from the count. Report just the number.
select count(distinct f1.Source)
from flights f1
inner join flights f2 on f1.Destination = f2.Source
where (f2.Destination = 'ATE' or f1.Destination = 'ATE') and f1.Source != 'ATE';


USE `AIRLINES`;
-- AIRLINES-4
-- For each airline, report the total number of airports from which it has at least one outgoing flight. Report the full name of the airline and the number of airports computed. Report the results sorted by the number of airports in descending order. In case of tie, sort by airline name A-Z.
select distinct a.Name, count(distinct f.Source) as count1
from airlines a, flights f
where  a.Id = f.Airline
group by a.Name
having count(distinct f.Source) >= 1
order by count1 desc, a.Name;


USE `BAKERY`;
-- BAKERY-1
-- For each flavor which is found in more than three types of items offered at the bakery, report the flavor, the average price (rounded to the nearest penny) of an item of this flavor, and the total number of different items of this flavor on the menu. Sort the output in ascending order by the average price.
select Flavor, round(avg(Price), 2) as avgPrice, count(food)
from goods
group by Flavor
having count(food) > 3
order by avgPrice asc;


USE `BAKERY`;
-- BAKERY-2
-- Find the total amount of money the bakery earned in October 2007 from selling eclairs. Report just the amount.
select sum(g.Price) as total
from goods g, receipts r, items i
where g.Food = 'Eclair'
    and r.RNumber = i.Receipt
    and i.Item = g.GId
    and r.SaleDate >= '2007-10-01' and r.SaleDate <= '2007-10-31';


USE `BAKERY`;
-- BAKERY-3
-- For each visit by NATACHA STENZ output the receipt number, sale date, total number of items purchased, and amount paid, rounded to the nearest penny. Sort by the amount paid, greatest to least.
select r.RNumber, r.SaleDate, count(i.Item), round(sum(g.Price),2)
from customers c, goods g, items i, receipts r
where c.FirstName = 'NATACHA' and c.LastName = 'STENZ'
    and i.Receipt = r.RNumber
    and r.Customer = c.CId
    and i.Item = g.GId
group by r.RNumber, r.SaleDate, c.FirstName, c.LastName
order by round(sum(g.Price),2) desc;


USE `BAKERY`;
-- BAKERY-4
-- For the week starting October 8, report the day of the week (Monday through Sunday), the date, total number of purchases (receipts), the total number of pastries purchased, and the overall daily revenue rounded to the nearest penny. Report results in chronological order.
select dayname(r.SaleDate), r.SaleDate, count(distinct RNumber), count(i.Item), round(sum(g.Price),2) as 'revenue'
from goods g, items i, receipts r
where i.Item = g.GId
    and i.Receipt = r.RNumber
    and r.SaleDate >= '2007-10-8'
    and r.Saledate <= '2007-10-14'
group by r.SaleDate
order by r.SaleDate;


USE `BAKERY`;
-- BAKERY-5
-- Report all dates on which more than ten tarts were purchased, sorted in chronological order.
select r.SaleDate
from goods g, items i, receipts r
where i.Item = g.GId
    and i.Receipt = r.RNumber
    and g.Food = 'Tart'
group by r.SaleDate
having count(*) > 10
order by r.SaleDate;


USE `CSU`;
-- CSU-1
-- For each campus that averaged more than $2,500 in fees between the years 2000 and 2005 (inclusive), report the campus name and total of fees for this six year period. Sort in ascending order by fee.
select c.Campus, sum(f.Fee) as 'feeTot'
from fees f, campuses c
where c.Id = f.CampusID
    and f.Year >= 2000 and f.Year <= 2005
group by c.campus
having avg(f.Fee) > 2500
order by feeTot;


USE `CSU`;
-- CSU-2
-- For each campus for which data exists for more than 60 years, report the campus name along with the average, minimum and maximum enrollment (over all years). Sort your output by average enrollment.
select c.Campus, avg(e.Enrolled) as average, min(e.Enrolled), max(e.Enrolled)
from campuses c, enrollments e
where c.Id = e.CampusId
group by c.Id
having count(e.year) > 60
order by average;


USE `CSU`;
-- CSU-3
-- For each campus in LA and Orange counties report the campus name and total number of degrees granted between 1998 and 2002 (inclusive). Sort the output in descending order by the number of degrees.

select c.Campus, sum(d.Degrees) as sumDeg
from degrees d
join campuses c on d.CampusId = c.Id
where d.Year >= 1998 and d.Year <= 2002 
    and (c.County = 'Los Angeles'
    or c.County = 'Orange')
group by c.Campus
order by sumDeg desc;


USE `CSU`;
-- CSU-4
-- For each campus that had more than 20,000 enrolled students in 2004, report the campus name and the number of disciplines for which the campus had non-zero graduate enrollment. Sort the output in alphabetical order by the name of the campus. (Exclude campuses that had no graduate enrollment at all.)
select c.Campus, count(*)
from campuses c, discEnr dE, disciplines d, enrollments e
where e.Enrolled > 20000
    and e.Year = 2004
    and dE.Gr > 0
    and c.Id = dE.CampusId
    and c.Id = e.CampusId
    and e.Year = dE.Year
    and d.ID = dE.Discipline
group by c.Campus
order by c.Campus;


USE `INN`;
-- INN-1
-- For each room, report the full room name, total revenue (number of nights times per-night rate), and the average revenue per stay. In this summary, include only those stays that began in the months of September, October and November. Sort output in descending order by total revenue. Output full room names.
select RoomName as roomname,
    sum(datediff(CheckOut, CheckIn) * Rate) as total,
    round(avg(datediff(CheckOut, CheckIn) * Rate), 2) as average
from rooms
inner join reservations on reservations.Room = rooms.RoomCode
where month(CheckIn) = 9 or month(CheckIn) = 10 or month(CheckIn) = 11
group by Room
order by total desc;


USE `INN`;
-- INN-2
-- Report the total number of reservations that began on Fridays, and the total revenue they brought in.
select count(res.CheckIn), sum(datediff(res.CheckOut, res.CheckIn)*res.Rate)
from reservations res
where dayname(res.CheckIn) = 'Friday';


USE `INN`;
-- INN-3
-- List each day of the week. For each day, compute the total number of reservations that began on that day, and the total revenue for these reservations. Report days of week as Monday, Tuesday, etc. Order days from Sunday to Saturday.
select dayname(res.CheckIn),
    count(res.CheckIn),
     sum(datediff(res.CheckOut, res.CheckIn)*res.Rate)
from reservations res
group by dayname(res.CheckIn), dayofweek(res.CheckIn)
order by dayofweek(res.CheckIn);


USE `INN`;
-- INN-4
-- For each room list full room name and report the highest markup against the base price and the largest markdown (discount). Report markups and markdowns as the signed difference between the base price and the rate. Sort output in descending order beginning with the largest markup. In case of identical markup/down sort by room name A-Z. Report full room names.
select r.RoomName,
    max(res.Rate - r.basePrice) as markup,
    min(res.Rate - r.basePrice) as markdown
from reservations res, rooms r
where r.RoomCode = res.Room
group by r.RoomName
order by markup desc, r.RoomName;


USE `INN`;
-- INN-5
-- For each room report how many nights in calendar year 2010 the room was occupied. Report the room code, the full name of the room, and the number of occupied nights. Sort in descending order by occupied nights. (Note: this should be number of nights during 2010. Some reservations extend beyond December 31, 2010. The ”extra” nights in 2011 must be deducted).
select r.RoomCode, r.RoomName, sum(datediff(res.CheckOut, res.CheckIn)) as sum
from rooms r, reservations res
where r.RoomCode = res.Room
    and if (CheckIn <= '2010-01-01', CheckIn = '2010-01-01', CheckIn = CheckIn)
    and if (CheckOut >= '2010-12-31', CheckOut = '2010-12-31', CheckOut = CheckOut)
group by r.RoomCode
order by sum desc;


USE `KATZENJAMMER`;
-- KATZENJAMMER-1
-- For each performer, report first name and how many times she sang lead vocals on a song. Sort output in descending order by the number of leads.
select b.Firstname, count(Id) as count
from Band b, Vocals v
where v.Bandmate = b.Id
group by v.VocalType, b.Firstname
having v.VocalType = 'lead'
order by count desc;


USE `KATZENJAMMER`;
-- KATZENJAMMER-2
-- Report how many different instruments each performer plays on songs from the album 'Le Pop'. Include performer's first name and the count of different instruments. Sort the output by the first name of the performers.
select b.Firstname, count(distinct i.Instrument)
from Instruments i, Band b, Albums a, Songs s, Tracklists t
where i.Bandmate = b.Id
    and i.Song = s.SongId
    and t.Album = a.AId
    and t.Song = s.SongId
    and a.Title = 'Le Pop'
group by b.Firstname
order by b.Firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-3
-- List each stage position along with the number of times Turid stood at each stage position when performing live. Sort output in ascending order of the number of times she performed in each position.

select p.StagePosition, count(b.Firstname) as count
from Performance p, Songs s, Band b
where p.Song = s.SongId
    and p.bandmate = b.Id
    and b.Firstname = 'Turid'
group by p.StagePosition
order by count asc;


USE `KATZENJAMMER`;
-- KATZENJAMMER-4
-- Report how many times each performer (other than Anne-Marit) played bass balalaika on the songs where Anne-Marit was positioned on the left side of the stage. List performer first name and a number for each performer. Sort output alphabetically by the name of the performer.

select b.Firstname
from Band b, Band b2, Instruments i, Performance p
where b.Firstname != 'Anne-Marit'
    and p.bandmate = b.Id
    and i.Bandmate = b.Id
    and (b2.Firstname = 'AnneMarit' and p.StagePosition = 'Left')
group by b.Firstname
order by b.Firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-5
-- Report all instruments (in alphabetical order) that were played by three or more people.
select distinct i.Instrument
from Band b, Instruments i
where i.Bandmate = b.Id
group by i.Instrument
having count(distinct i.bandmate) > 2
order by i.Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-6
-- For each performer, list first name and report the number of songs on which they played more than one instrument. Sort output in alphabetical order by first name of the performer
select b.Firstname, count(distinct i.Song)
from Instruments i
inner join Instruments i2 on i.Song = i2.Song and i.Bandmate = i2.Bandmate and i.Instrument != i2.Instrument
inner join Band b on i.Bandmate = b.Id and i2.Bandmate = b.Id
group by b.Id
order by b.Firstname;


USE `MARATHON`;
-- MARATHON-1
-- List each age group and gender. For each combination, report total number of runners, the overall place of the best runner and the overall place of the slowest runner. Output result sorted by age group and sorted by gender (F followed by M) within each age group.
select distinct m.AgeGroup, m.Sex, count(m.BibNumber), min(m.Place), max(m.Place)
from marathon m
group by m.AgeGroup, m.Sex
order by m.AgeGroup, m.Sex;


USE `MARATHON`;
-- MARATHON-2
-- Report the total number of gender/age groups for which both the first and the second place runners (within the group) are from the same state.
select count(*)
from marathon m1, marathon m2
where m1.State = m2.State
    and m1.BibNumber != m2.BibNumber
    and m1.GroupPlace = 1
    and m2.GroupPlace = 2
    and m1.AgeGroup = m2.AgeGroup
    and m1.Sex = m2.Sex;


USE `MARATHON`;
-- MARATHON-3
-- For each full minute, report the total number of runners whose pace was between that number of minutes and the next. In other words: how many runners ran the marathon at a pace between 5 and 6 mins, how many at a pace between 6 and 7 mins, and so on.
select minute(Pace), count(BibNumber)
from marathon
group by minute(Pace);


USE `MARATHON`;
-- MARATHON-4
-- For each state with runners in the marathon, report the number of runners from the state who finished in top 10 in their gender-age group. If a state did not have runners in top 10, do not output information for that state. Report state code and the number of top 10 runners. Sort in descending order by the number of top 10 runners, then by state A-Z.
select State, count(BibNumber) as count
from marathon
where GroupPlace <= 10
group by State
order by count desc;


USE `MARATHON`;
-- MARATHON-5
-- For each Connecticut town with 3 or more participants in the race, report the town name and average time of its runners in the race computed in seconds. Output the results sorted by the average time (lowest average time first).
select m.town,
    round((avg(hour(m.RunTime) * 60 * 60) +
       (avg(minute(m.RunTime) * 60)) +
       avg(second(m.RunTime))), 1) as "avg1"
from marathon m
where m.State = 'CT'
group by m.town
having count(*) >= 3
order by avg1 asc;


USE `STUDENTS`;
-- STUDENTS-1
-- Report the last and first names of teachers who have between seven and eight (inclusive) students in their classrooms. Sort output in alphabetical order by the teacher's last name.
select t.Last, t.First
from list l, teachers t
where l.Classroom = t.classroom
group by t.classroom
having count(t.Classroom = l.Classroom) >= 7
    and count(t.Classroom = l.Classroom) <= 8
order by t.last;


USE `STUDENTS`;
-- STUDENTS-2
-- For each grade, report the grade, the number of classrooms in which it is taught, and the total number of students in the grade. Sort the output by the number of classrooms in descending order, then by grade in ascending order.

select l.Grade, count(distinct l.Classroom) as count, count(LastName)
from list l, teachers t
where l.Classroom = t.Classroom
group by l.Grade
order by count desc, l.Grade asc;


USE `STUDENTS`;
-- STUDENTS-3
-- For each Kindergarten (grade 0) classroom, report classroom number along with the total number of students in the classroom. Sort output in the descending order by the number of students.
select l.Classroom, count(distinct l.LastName) as num
from list l, teachers t
group by l.Classroom, l.Grade
having l.Grade = 0
order by num desc;


USE `STUDENTS`;
-- STUDENTS-4
-- For each fourth grade classroom, report the classroom number and the last name of the student who appears last (alphabetically) on the class roster. Sort output by classroom.
select l.Classroom, max(l.LastName)
from list l
where l.grade = 4
group by l.Classroom
order by l.Classroom;


