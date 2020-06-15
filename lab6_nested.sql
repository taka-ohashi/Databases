-- Lab 6
-- tohashi
-- Jun 15, 2020

USE `BAKERY`;
-- BAKERY-1
-- Find all customers who did not make a purchase between October 5 and October 11 (inclusive) of 2007. Output first and last name in alphabetical order by last name.
with date_first_last_ofwhohaspurchased(date1, cid, first1, last1)
as (
select distinct r.SaleDate, c.CId, c.FirstName, c.LastName
from customers c, receipts r
where c.CId = r.Customer
    and year(r.SaleDate) = 2007
    and (r.SaleDate >= '2007-10-05' and r.SaleDate <= '2007-10-11')
group by r.SaleDate, c.CId
order by c.LastName),
justnames(cid1, f1, l1)
as (
select distinct x.cid, x.first1, x.last1
from date_first_last_ofwhohaspurchased x
)

select distinct c.FirstName, c.LastName
from customers c
where c.LastName not in (select l1 from justnames)
order by c.LastName;


USE `BAKERY`;
-- BAKERY-2
-- Find the customer(s) who spent the most money at the bakery during October of 2007. Report first, last name and total amount spent (rounded to two decimal places). Sort by last name.
with sum_list(last1, first1, sum1)
as(select c.LastName as last1, c.FirstName as first1, sum(g.Price) as sum1
    from goods g
    join customers c
    join items i on i.Item = g.GId
    join receipts r on r.RNumber = i.Receipt and r.Customer = c.CId
    where month(r.SaleDate) = 10 and year(r.SaleDate) = 2007
    group by c.CId)

select first1,last1, round(sum1, 2) as spent
from sum_list
where sum1 = (select max(sum1) from sum_list);


USE `BAKERY`;
-- BAKERY-3
-- Find all customers who never purchased a twist ('Twist') during October 2007. Report first and last name in alphabetical order by last name.

with date_first_last_ofwhohaspurchased(date1, cid, first1, last1)
as (
select distinct r.SaleDate, c.CId, c.FirstName, c.LastName
from customers c, receipts r, goods g, items i
where c.CId = r.Customer
    and i.Item = g.GId
    and r.RNumber = i.Receipt
    and g.Food = 'Twist'
group by r.SaleDate, c.CId
having month(r.SaleDate) = 10 and year(r.SaleDate) = 2007
order by c.LastName),
justnames(cid1, f1, l1)
as (
select distinct x.cid, x.first1, x.last1
from date_first_last_ofwhohaspurchased x
)

select distinct c.FirstName, c.LastName
from customers c
where c.LastName not in (select l1 from justnames)
order by c.LastName;


USE `BAKERY`;
-- BAKERY-4
-- Find the baked good(s) (flavor and food type) responsible for the most total revenue.
with findSums(flavor, food, totalRev)
as ( select g.Flavor, g.Food, sum(g.Price)
from customers c, goods g, items i, receipts r
where i.Item = g.GId
    and r.RNumber = i.Receipt
    and r.Customer = c.CId
group by g.Food, g.Flavor
)

select f.flavor, f.food
from findSums f
where totalRev = (select max(totalRev) from findSums);


USE `BAKERY`;
-- BAKERY-5
-- Find the most popular item, based on number of pastries sold. Report the item (flavor and food) and total quantity sold.
with findSums(flavor, food, goodsCount)
as ( select g.Flavor, g.Food, count(g.GId)
from customers c, goods g, items i, receipts r
where i.Item = g.GId
    and r.RNumber = i.Receipt
    and r.Customer = c.CId
group by g.GId
)

select f.flavor, f.food, goodsCount
from findSums f
where goodsCount = (select max(goodsCount) from findSums);


USE `BAKERY`;
-- BAKERY-6
-- Find the date(s) of highest revenue during the month of October, 2007. In case of tie, sort chronologically.
with findSums(date1, rev)
as ( select r.SaleDate, sum(g.Price)
from customers c, goods g, items i, receipts r
where i.Item = g.GId
    and r.RNumber = i.Receipt
    and r.Customer = c.CId
    and month(r.SaleDate) = 10
    and year(r.SaleDate) = 2007
group by r.SaleDate, g.GId
)

select date1
from findSums f
where rev = (select max(rev) from findSums);


USE `BAKERY`;
-- BAKERY-7
-- Find the best-selling item(s) (by number of purchases) on the day(s) of highest revenue in October of 2007.  Report flavor, food, and quantity sold. Sort by flavor and food.
with findSums(date1, flavor, food, c1, rev)
as ( select r.SaleDate, g.Flavor, g.Food, count(g.GId), sum(g.Price)
from customers c, goods g, items i, receipts r
where i.Item = g.GId
    and r.RNumber = i.Receipt
    and r.Customer = c.CId
    and month(r.SaleDate) = 10
    and year(r.SaleDate) = 2007
group by r.SaleDate, g.GId
)

select f.flavor, f.food, c1
from findSums f
where rev = (select max(rev) from findSums);


USE `BAKERY`;
-- BAKERY-10
-- Find out if sales (in terms of revenue) of Chocolate-flavored items or sales of Croissants (of all flavors) were higher in October of 2007. Output the word 'Chocolate' if sales of Chocolate-flavored items had higher revenue, or the word 'Croissant' if sales of Croissants brought in more revenue.

with salesofChocolate(flavor1, food1, rev)
as(select g.Flavor, g.Food, sum(g.Price)
from goods g, items i, receipts r
where i.Item = g.GId
    and r.RNumber = i.Receipt
    and month(r.SaleDate) = 10
    and year(r.SaleDate) = 2007
    and g.Flavor = 'Chocolate'
group by g.GId
),
salesofCroissant(flavor2, food2, rev2)
as(select g.Flavor, g.Food, sum(g.Price)
from goods g, items i, receipts r
where i.Item = g.GId
    and r.RNumber = i.Receipt
    and month(r.SaleDate) = 10
    and year(r.SaleDate) = 2007
    and g.Food = 'Croissant'
group by g.GId
),
higher(chocSale, croiSale)
as (select sum(a.rev), sum(b.rev2)
from salesofChocolate a, salesofCroissant b
)

select 'Chocolate';


USE `INN`;
-- INN-1
-- Find the most popular room(s) (based on the number of reservations) in the hotel  (Note: if there is a tie for the most popular room, report all such rooms). Report the full name of the room, the room code and the number of reservations.

with countRes(RoomCode, RoomName, c)
as(select r.RoomCode, r.RoomName, count(res.CheckIn)
from rooms r, reservations res
where r.RoomCode = res.Room
group by r.RoomCode)

select RoomName, RoomCode, c
from countRes
where c = (select max(c) from countRes);


USE `INN`;
-- INN-2
-- Find the room(s) that have been occupied the largest number of days based on all reservations in the database. Report the room name(s), room code(s) and the number of days occupied. Sort by room name.
with countRes(RoomCode, RoomName, s)
as(select r.RoomCode, r.RoomName, sum(datediff(res.CheckOut,res.CheckIn))
from rooms r, reservations res
where r.RoomCode = res.Room
group by r.RoomCode)

select RoomName, RoomCode, s
from countRes
where s = (select max(s) from countRes);


USE `INN`;
-- INN-3
-- For each room, report the most expensive reservation. Report the full room name, dates of stay, last name of the person who made the reservation, daily rate and the total amount paid (rounded to the nearest penny.) Sort the output in descending order by total amount paid.
with countRes(RoomName, CODE, diff, CheckIn, CheckOut, last1, Rate, total)
as(select RoomName, CODE, datediff(res.CheckOut, res.CheckIn), res.CheckIn, res.CheckOut, res.Lastname, res.Rate, round(res.Rate * datediff(res.CheckOut, res.CheckIn), 2)
from rooms r, reservations res
where r.RoomCode = res.Room
group by RoomName, CODE),
maxdays(RoomName, total)
as (select RoomName, max(total)
from countRes
group by RoomName
),
temp1(RoomName, CheckIn, CheckOut, lastname, rate, total)
as( select cR.RoomName, cR.CheckIn, cR.CheckOut, cR.last1, cR.rate, cR.total
from countRes cR, maxdays md
where cR.RoomName = md.RoomName
    and cR.total = md.total
)

select *
from temp1 t1
order by t1.total desc;


USE `STUDENTS`;
-- STUDENTS-1
-- Find the teacher(s) with the largest number of students. Report the name of the teacher(s) (last, first) and the number of students in their class.

with teacher_studentCount(lastname, firstname, num)
as(select t.Last, t.First, count(l.LastName)
from teachers t, list l
where l.Classroom = t.Classroom
group by t.Classroom
)

select ts.lastname, ts.firstname, ts.num
from teacher_studentCount ts
where ts.num = (select max(num) from teacher_studentCount);


USE `STUDENTS`;
-- STUDENTS-2
-- Find the grade(s) with the largest number of students whose last names start with letters 'A', 'B' or 'C' Report the grade and the number of students. In case of tie, sort by grade number.
with grade_and_last(grade, student)
as (select l.Grade, count(l.LastName)
from list l
where left(l.LastName, 1) = 'A'
    or left(l.LastName, 1) =  'B'
    or  left(l.LastName, 1) =  'C'
group by l.Grade
order by l.Grade
)

select grade, student
from grade_and_last
where student = (select max(student) from grade_and_last);


USE `STUDENTS`;
-- STUDENTS-3
-- Find all classrooms which have fewer students in them than the average number of students in a classroom in the school. Report the classroom numbers and the number of student in each classroom. Sort in ascending order by classroom.
with temp1(classNum, studentCount) 
as (select Classroom, count(LastName)
from list
group by Classroom
),
temp2(averageNum)
as (select avg(studentCount)
from temp1)

select * 
from temp1
where studentCount < (select averageNum from temp2)
order by classNum;


USE `STUDENTS`;
-- STUDENTS-4
-- Find all pairs of classrooms with the same number of students in them. Report each pair only once. Report both classrooms and the number of students. Sort output in ascending order by the number of students in the classroom.
with temp1(classNum, studentCount) 
as (select Classroom, count(LastName)
from list
group by Classroom
)

select t1.classNum, t2.classNum, t1.studentCount 
from temp1 t1, temp1 t2
where t1.studentCount = t2.studentCount
    and t1.classNum != t2.classNum
    and t1.classNum < t2.classNum
order by t1.studentCount;


USE `CSU`;
-- CSU-1
-- Find the campus(es) with the largest enrollment in 2000. Output the name of the campus and the enrollment. Sort by campus name.

with camp_enrolled(campName, numEnrolled)
as (select distinct c.Campus, sum(e.Enrolled)
from campuses c, enrollments e
where c.Id = e.CampusId
    and e.Year = 2000
group by c.Id
)

select *
from camp_enrolled
where numEnrolled = (select max(numEnrolled) from camp_enrolled);


USE `CSU`;
-- CSU-2
-- Find the university (or universities) that granted the highest average number of degrees per year over its entire recorded history. Report the name of the university, sorted alphabetically.

with camp_deg(campName, avgDegrees)
as (select distinct c.Campus, avg(d.Degrees)
from campuses c, degrees d
where c.Id = d.CampusId
group by c.Id
)

select campName
from camp_deg
where avgDegrees = (select max(avgDegrees) from camp_deg);


USE `CSU`;
-- CSU-3
-- Find the university with the lowest student-to-faculty ratio in 2003. Report the name of the campus and the student-to-faculty ratio, rounded to one decimal place. Use FTE numbers for enrollment. In case of tie, sort by campus name.
with name_ratio(name, ratio)
as (select c.Campus, round(e.FTE/f.FTE, 1)
from campuses c, enrollments e, faculty f
where f.Year = e.Year
    and f.Year = 2003
    and c.Id = e.CampusId
    and c.Id = f.CampusId
group by c.Campus, e.FTE, f.FTE
)

select *
from name_ratio
where ratio = (select min(ratio) from name_ratio);


USE `CSU`;
-- CSU-6
-- For each campus report the year of the highest student-to-faculty ratio, together with the ratio itself. Sort output in alphabetical order by campus name. Use FTE numbers to compute ratios  and round to two decimal places.
with name_ratio(name, ratio, year)
as (select c.Campus, round(e.FTE/f.FTE, 2), e.Year
from campuses c, enrollments e, faculty f
where f.Year = e.Year
    and c.Id = e.CampusId
    and c.Id = f.CampusId
group by c.Campus, e.FTE, f.FTE, e.Year
),
ratio_year(name1, year1, ratio1)
as (select name, year, ratio
from name_ratio
),
highest_name_ratio(name2, ratio2)
as (select nr1.name, max(nr1.ratio)
from name_ratio nr1
group by nr1.name
order by nr1.name
)

select name2, year1, ratio1
from highest_name_ratio hnr
join ratio_year ry on ry.ratio1 = hnr.ratio2 and ry.name1 = hnr.name2
order by name2;


USE `MARATHON`;
-- MARATHON-1
-- Find the state(s) with the largest number of participants. List state code(s) sorted alphabetically.

with state_and_count(State, c)
as(select State, count(BibNumber) as c
    from marathon
    group by State
)

select State
from state_and_count
where c = (select max(c) from state_and_count)
order by State;


USE `MARATHON`;
-- MARATHON-2
-- Find all towns in Rhode Island (RI) which fielded more female runners than male runners for the race. Include only those towns that fielded at least 1 male runner and at least 1 female runner. Report the names of towns, sorted alphabetically.

with female_numbers(Town1, Count)
as(select Town, count(BibNumber)
from marathon
where Sex = 'F' and State = 'RI'
group by State, Town),
male_numbers(Town1, Count)
as(select Town, count(BibNumber)
from marathon
where Sex = 'M' and State = 'RI'
group by State, Town)

select f.Town1
from female_numbers f, male_numbers m
where f.Town1 = m.Town1
    and f.Count > m.Count
order by f.Town1;


USE `MARATHON`;
-- MARATHON-3
-- For each state, report the gender-age group with the largest number of participants. Output state, age group, gender, and the number of runners in the group. Report only information for the states where the largest number of participants in a gender-age group is greater than one. Sort in ascending order by state code, age group, then gender.
with nums(State1, AgeGroup1, Sex1, c1)
as (select distinct State, AgeGroup, Sex, count(BibNumber)
from marathon
group by State, AgeGroup, Sex
),
maxState(s, c1)
as (select State1, max(c1)
from nums
group by State1
)

select n.State1, n.AgeGroup1, n.Sex1, n.c1
from nums n, maxState m
where n.State1 = m.s
    and n.c1 = m.c1
    and m.c1 > 1
order by n.State1, n.AgeGroup1, n.Sex1 asc;

USE `KATZENJAMMER`;
-- KATZENJAMMER-1
-- Report the first name of the performer who never played accordion.

with played_accordion(name, id)
as (select b.Firstname, b.Id
from Instruments i, Band b
where b.Id = i.Bandmate
    and i.Instrument = 'accordion'
group by b.Id, i.Instrument
)

select b.Firstname
from Band b
where b.Id not in (select Id from played_accordion);


USE `KATZENJAMMER`;
-- KATZENJAMMER-3
-- Report the title(s) of the song(s) that involved the largest number of different instruments played (if multiple songs, report the titles in alphabetical order).
with name_count(songName, c)
as(select s.Title, count(i.Instrument) 
from Songs s, Instruments i
where i.Song = s.SongId
group by s.SongId
)

select songName
from name_count
where c = (select max(c) from name_count);


USE `KATZENJAMMER`;
-- KATZENJAMMER-6
-- Report, in alphabetical order, the first name(s) of the performer(s) who played the largest number of different instruments.

with name_count(firstname, c)
as(select b.Firstname, count(distinct i.Instrument) 
from Band b, Instruments i
where b.Id = i.Bandmate
group by b.Id
)

select firstname
from name_count
where c = (select max(c) from name_count)
order by firstname;

