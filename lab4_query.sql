-- Lab 4
-- tohashi
-- Jun 15, 2020

USE `STUDENTS`;
-- STUDENTS-1
-- Find all students who study in classroom 111. For each student list first and last name. Sort the output by the last name of the student.
select l.FirstName, l.LastName from list l
where l.Classroom = "111"
order by l.Lastname;


USE `STUDENTS`;
-- STUDENTS-2
-- For each classroom report the grade that is taught in it. Report just the classroom number and the grade number. Sort output by classroom in descending order.
select distinct l.Classroom, l.Grade from list l
order by l.Classroom desc;


USE `STUDENTS`;
-- STUDENTS-3
-- Find all teachers who teach fifth grade. Report first and last name of the teachers and the room number. Sort the output by room number.
with teacher_classroom_grade(first, last, class, grade)
as (select t.First, t.Last, t.Classroom, l.Grade
from teachers t, list l
where l.Classroom = t.Classroom
),
teacher_teaching_5(f1, l1, c1)
as (select first, last, class
from teacher_classroom_grade
where grade = 5
)

select distinct * from teacher_teaching_5;


USE `STUDENTS`;
-- STUDENTS-4
-- Find all students taught by OTHA MOYER. Output first and last names of students sorted in alphabetical order by their last name.
select l.FirstName, l.LastName from list l, teachers t
where l.Classroom = t.Classroom and t.First = "OTHA" and t.Last = "MOYER"
order by l.LastName;


USE `STUDENTS`;
-- STUDENTS-5
-- For each teacher teaching grades K through 3, report the grade (s)he teaches. Each name has to be reported exactly once. Sort the output by grade and alphabetically by teacher’s last name for each grade.
select distinct t.First, t.Last, l.Grade
from list l, teachers t
where l.Grade >= 0 and l.Grade <= 3
    and l.Classroom = t.Classroom
order by l.Grade, t.Last asc;


USE `BAKERY`;
-- BAKERY-1
-- Find all chocolate-flavored items on the menu whose price is under $5.00. For each item output the flavor, the name (food type) of the item, and the price. Sort your output in descending order by price.
select g.Flavor, g.Food, g.Price from goods g
where g.Price < 5.00 and g.Flavor = "Chocolate"
order by g.price desc;


USE `BAKERY`;
-- BAKERY-2
-- Report the prices of the following items (a) any cookie priced above $1.10, (b) any lemon-flavored items, or (c) any apple-flavored item except for the pie. Output the flavor, the name (food type) and the price of each pastry. Sort the output in alphabetical order by the flavor and then pastry name.
select g.Flavor, g.Food, g.Price from goods g
where g.Food = "Cookie" and g.Price > 1.10 or
	g.Flavor = "Lemon" or
	g.Flavor = "Apple" and g.food != "Pie"
order by g.Flavor, g.Food;


USE `BAKERY`;
-- BAKERY-3
-- Find all customers who made a purchase on October 3, 2007. Report the name of the customer (last, first). Sort the output in alphabetical order by the customer’s last name. Each customer name must appear at most once.
select distinct c.LastName, c.FirstName from customers c, receipts r
where r.SaleDate = "2007-10-03" and c.CId = r.Customer
order by c.LastName;


USE `BAKERY`;
-- BAKERY-4
-- Find all different cakes purchased on October 4, 2007. Each cake (flavor, food) is to be listed once. Sort output in alphabetical order by the cake flavor.
select distinct g.Flavor, g.Food from goods g, receipts r, items i
where r.SaleDate = "2007-10-04" and 
    i.Item = g.GId and 
    r.RNumber = i.Receipt and 
    g.Food = "Cake"
order by g.Flavor;


USE `BAKERY`;
-- BAKERY-5
-- List all pastries purchased by ARIANE CRUZEN on October 25, 2007. For each pastry, specify its flavor and type, as well as the price. Output the pastries in the order in which they appear on the receipt (each pastry needs to appear the number of times it was purchased).
select Flavor, Food, Price
from items
inner join receipts on receipts.RNumber = items.Receipt and saleDate = '2007-10-25'
inner join customers on receipts.customer = customers.CId and Lastname = 'CRUZEN' and FirstName = 'ARIANE'
inner join goods on items.item = goods.GID;


USE `BAKERY`;
-- BAKERY-6
-- Find all types of cookies purchased by KIP ARNN during the month of October of 2007. Report each cookie type (flavor, food type) exactly once in alphabetical order by flavor.

select distinct Flavor, Food
from items
inner join receipts on receipts.RNumber = items.Receipt and month(SaleDate) = 10 and year(SaleDate)=2007
inner join customers on receipts.customer = customers.CId and Lastname = 'ARNN' and FirstName = 'KIP'
inner join goods on items.item = goods.GId and goods.Food = 'Cookie'
order by Flavor asc;


USE `CSU`;
-- CSU-1
-- Report all campuses from Los Angeles county. Output the full name of campus in alphabetical order.
select c.Campus from campuses c
where County = "Los Angeles"
order by c.Campus;


USE `CSU`;
-- CSU-2
-- For each year between 1994 and 2000 (inclusive) report the number of students who graduated from California Maritime Academy Output the year and the number of degrees granted. Sort output by year.
select d.Year, d.Degrees from degrees d, campuses c
where (d.Year >= 1994 and d.Year <= 2000) and 
    (c.Campus = "California Maritime Academy") and 
    (d.CampusId = c.Id)
order by d.Year;


USE `CSU`;
-- CSU-3
-- Report undergraduate and graduate enrollments (as two numbers) in ’Mathematics’, ’Engineering’ and ’Computer and Info. Sciences’ disciplines for both Polytechnic universities of the CSU system in 2004. Output the name of the campus, the discipline and the number of graduate and the number of undergraduate students enrolled. Sort output by campus name, and by discipline for each campus.
select c.Campus, d.Name, dE.Gr, dE.Ug
from discEnr dE, disciplines d, campuses c, degrees deg
where (d.Name = 'Mathematics' or d.Name = 'Engineering' or d.Name = "Computer and Info. Sciences")
    and (c.Campus = "California Polytechnic State University-San Luis Obispo" or c.Campus = "California State Polytechnic University-Pomona")
    and deg.Year = 2004
    and deg.CampusId = c.Id
    and dE.CampusId = c.Id
    and dE.Discipline = d.ID 
order by c.Campus, d.Name;


USE `CSU`;
-- CSU-4
-- Report graduate enrollments in 2004 in ’Agriculture’ and ’Biological Sciences’ for any university that offers graduate studies in both disciplines. Report one line per university (with the two grad. enrollment numbers in separate columns), sort universities in descending order by the number of ’Agriculture’ graduate students.
select campuses.Campus, de1.Gr, de2.Gr
from campuses
inner join discEnr de1 on de1.CampusId = campuses.Id and de1.Year = 2004 and de1.Discipline = 1 and de1.Gr != 0
inner join discEnr de2 on de2.CampusId = campuses.Id and de2.Year = 2004 and de2.Discipline = 4 and de2.Gr != 0
order by de1.Gr desc;


USE `CSU`;
-- CSU-5
-- Find all disciplines and campuses where graduate enrollment in 2004 was at least three times higher than undergraduate enrollment. Report campus names, discipline names, and both enrollment counts. Sort output by campus name, then by discipline name in alphabetical order.
select c.Campus, d.Name, dE.Ug, dE.Gr
from discEnr dE, campuses c, disciplines d
where dE.Gr > (3 * dE.Ug)
    and dE.CampusId = c.Id
    and dE.Discipline = d.ID
order by c.Campus, d.Name;


USE `CSU`;
-- CSU-6
-- Report the amount of money collected from student fees (use the full-time equivalent enrollment for computations) at ’Fresno State University’ for each year between 2002 and 2004 inclusively, and the amount of money (rounded to the nearest penny) collected from student fees per each full-time equivalent faculty. Output the year, the two computed numbers sorted chronologically by year.
select distinct e.Year, (e.FTE * f.Fee) as StudentFees, (round(((e.FTE * f.Fee) / fac.FTE),2)) as PerFaculty
from fees f, enrollments e, faculty fac, campuses c
where e.Year >= 2002
    and e.Year <= 2004
    and c.Campus = 'Fresno State University'
    and fac.CampusId = c.Id
    and e.CampusId = c.Id
    and f.CampusId = c.Id
    and f.Year = e.Year
    and f.Year = fac.Year
    and e.Year = fac.Year
order by e.Year;


USE `CSU`;
-- CSU-7
-- Find all campuses where enrollment in 2003 (use the FTE numbers), was higher than the 2003 enrollment in ’San Jose State University’. Report the name of campus, the 2003 enrollment number, the number of faculty teaching that year, and the student-to-faculty ratio, rounded to one decimal place. Sort output in ascending order by student-to-faculty ratio.
select c2.Campus, e2.FTE, fac.FTE, (round((e2.FTE / fac.FTE), 1)) as Ratio
from campuses c1, campuses c2, enrollments e1, enrollments e2, faculty fac
where e1.CampusId = c1.Id
    and e2.CampusId = c2.Id
    and fac.CampusId = c2.Id
    and c1.campus = 'San Jose State University'
    and e2.FTE > e1.FTE
    and (e1.Year = 2003 and e2.Year = 2003 and fac.Year = e2.Year and fac.Year = e1.year)
order by Ratio asc;


USE `INN`;
-- INN-1
-- Find all modern rooms with a base price below $160 and two beds. Report room code and full room name, in alphabetical order by the code.
select distinct r.RoomCode, r.RoomName 
from rooms r
where r.basePrice < 160 
    and r.Beds = 2
    and r.decor = 'modern'
order by r.RoomCode;


USE `INN`;
-- INN-2
-- Find all July 2010 reservations (a.k.a., all reservations that both start AND end during July 2010) for the ’Convoke and sanguine’ room. For each reservation report the last name of the person who reserved it, checkin and checkout dates, the total number of people staying and the daily rate. Output reservations in chronological order.
select res.LastName, res.CheckIn, res.CheckOut,(res.Adults + res.Kids) as 'total', res.Rate
from reservations res, rooms r
where res.CheckIn >= '2010-07-01' 
	and res.Checkout <= '2010-07-31'
	and r.RoomName = 'Convoke and sanguine'
	and res.Room = r.RoomCode
order by res.CheckIn;


USE `INN`;
-- INN-3
-- Find all rooms occupied on February 6, 2010. Report full name of the room, the check-in and checkout dates of the reservation. Sort output in alphabetical order by room name.
select r.RoomName, res.CheckIn, res.Checkout
from reservations res, rooms r
where res.CheckIn <= '2010-02-06'
    and res.Checkout > '2010-02-06'
    and res.Room = r.RoomCode
order by r.RoomName;


USE `INN`;
-- INN-4
-- For each stay by GRANT KNERIEN in the hotel, calculate the total amount of money, he paid. Report reservation code, room name (full), checkin and checkout dates, and the total stay cost. Sort output in chronological order by the day of arrival.

select res.CODE, r.RoomName, res.CheckIn, res.Checkout, (-1 * res.Rate * datediff(res.CheckIn, res.Checkout)) as total
from rooms r, reservations res
where res.LastName = 'KNERIEN' and res.FirstName = 'GRANT' 
    and r.RoomCode = res.Room
order by res.CheckIn;


USE `INN`;
-- INN-5
-- For each reservation that starts on December 31, 2010 report the room name, nightly rate, number of nights spent and the total amount of money paid. Sort output in descending order by the number of nights stayed.
select r.RoomName, res.Rate, (-1 * datediff(res.CheckIn, res.Checkout)) as nights, (-1 * res.Rate * datediff(res.CheckIn, res.Checkout)) as spent
from reservations res, rooms r
where res.CheckIn = '2010-12-31'
    and res.Room = r.RoomCode
order by nights desc;


USE `INN`;
-- INN-6
-- Report all reservations in rooms with double beds that contained four adults. For each reservation report its code, the room abbreviation, full name of the room, check-in and check out dates. Report reservations in chronological order, then sorted by the three-letter room code (in alphabetical order) for any reservations that began on the same day.
select res.CODE, res.Room, r.RoomName, res.CheckIn, res.Checkout
from rooms r, reservations res
where r.bedType = 'Double'
    and res.Adults = 4
    and res.Room = r.RoomCode
order by r.RoomCode;


USE `MARATHON`;
-- MARATHON-1
-- Report the overall place, running time, and pace of TEDDY BRASEL.
select m.Place, m.RunTime, m.Pace from marathon m
where m.FirstName = 'TEDDY' and m.LastName = 'BRASEL';


USE `MARATHON`;
-- MARATHON-2
-- Report names (first, last), overall place, running time, as well as place within gender-age group for all female runners from QUNICY, MA. Sort output by overall place in the race.
select m.FirstName, m.LastName, m.Place, m.RunTime, m.GroupPlace
from marathon m
where m.Sex = 'F' 
	and m.Town = "QUNICY" 
	and m.State = "MA"
order by m.Place;


USE `MARATHON`;
-- MARATHON-3
-- Find the results for all 34-year old female runners from Connecticut (CT). For each runner, output name (first, last), town and the running time. Sort by time.
select m.FirstName, m.LastName, m.Town, m.RunTime from marathon m
where m.Sex = 'F' and m.State = 'CT' and m.Age = 34
order by m.RunTime;


USE `MARATHON`;
-- MARATHON-4
-- Find all duplicate bibs in the race. Report just the bib numbers. Sort in ascending order of the bib number. Each duplicate bib number must be reported exactly once.
select distinct m1.BibNumber
from marathon m1, marathon m2
where m1.BibNumber = m2.BibNumber
    and m1.Place != m2.Place
order by m1.BibNumber;


USE `MARATHON`;
-- MARATHON-5
-- List all runners who took first place and second place in their respective age/gender groups. List gender, age group, name (first, last) and age for both the winner and the runner up (in a single row). Order the output by gender, then by age group.
select m1.Sex, m1.AgeGroup, m1.FirstName, m1.LastName, m1.Age, m2.FirstName, m2.LastName, m2.Age
from marathon as m1, marathon as m2
where m1.GroupPlace = 1
    and m2.GroupPlace = 2
    and m1.AgeGroup = m2.AgeGroup
    and m1.Sex = m2.Sex
order by m1.Sex, m1.AgeGroup;


USE `AIRLINES`;
-- AIRLINES-1
-- Find all airlines that have at least one flight out of AXX airport. Report the full name and the abbreviation of each airline. Report each name only once. Sort the airlines in alphabetical order.
select distinct a.Name, a.Abbr from airlines a, airports p, flights f
where f.Source = 'AXX' and 
    f.Airline = a.Id
order by a.Name;


USE `AIRLINES`;
-- AIRLINES-2
-- Find all destinations served from the AXX airport by Northwest. Re- port flight number, airport code and the full name of the airport. Sort in ascending order by flight number.

select distinct f.FlightNo, p.Code, p.Name
from airlines a, airports p, flights f
where f.Source = 'AXX'
    and a.Name = "Northwest Airlines"
    and f.Airline = a.Id
    and f.Destination = p.Code
order by f.FlightNo asc;


USE `AIRLINES`;
-- AIRLINES-3
-- Find all *other* destinations that are accessible from AXX on only Northwest flights with exactly one change-over. Report pairs of flight numbers, airport codes for the final destinations, and full names of the airports sorted in alphabetical order by the airport code.
select f1.FlightNo, f2.FlightNo, f2.Destination, airports. Name
from airlines, airports, flights as f1, flights as f2
where airlines.Abbr = "Northwest"
    and airlines.Id = f1.Airline
    and airlines.Id = f2.Airline
    and f1.Source = 'AXX'
    and f1.destination = f2.Source
    and f2.destination != 'AXX'
    and airports.Code = f2.Destination;


USE `AIRLINES`;
-- AIRLINES-4
-- Report all pairs of airports served by both Frontier and JetBlue. Each airport pair must be reported exactly once (if a pair X,Y is reported, then a pair Y,X is redundant and should not be reported).
select distinct f.Source, f.Destination
from flights f
inner join flights n on f.Airline = 8 and n.Airline = 9 and f.Source = n.Source and f.Destination = n.Destination and strcmp(f.Source, f.destination) <= 0
order by Source asc;


USE `AIRLINES`;
-- AIRLINES-5
-- Find all airports served by ALL five of the airlines listed below: Delta, Frontier, USAir, UAL and Southwest. Report just the airport codes, sorted in alphabetical order.
select distinct p.Code
from airlines a1, airlines a2, airlines a3, airlines a4, airlines a5, airports p, flights f1, flights f2, flights f3, flights f4, flights f5
where a1.Name = 'Delta Airlines'
    and a2.Name = 'Frontier Airlines'
    and a3.Name = 'US Airways'
    and a4.Name = 'United Airlines'
    and a5.Name = 'Southwest Airlines'
    and f1.Airline = a1.Id
    and f2.Airline = a2.Id
    and f3.Airline = a3.Id
    and f4.Airline = a4.Id
    and f5.Airline = a5.Id
    and (f1.Source = p.Code or f1.Destination = p.Code)
    and (f2.Source = p.Code or f2.Destination = p.Code)
    and (f3.Source = p.Code or f3.Destination = p.Code)
    and (f4.Source = p.Code or f4.Destination = p.Code)
    and (f5.Source = p.Code or f5.Destination = p.Code)
order by p.Code;


USE `AIRLINES`;
-- AIRLINES-6
-- Find all airports that are served by at least three Southwest flights. Report just the three-letter codes of the airports — each code exactly once, in alphabetical order.
select distinct p.Code
from flights f1, flights f2, flights f3, airlines a, airports p
where f1.FlightNo != f2.FlightNo
    and f1.FlightNo != f3.FlightNo
    and f2.FlightNo != f3.FlightNo
    and f1.Airline = a.Id
    and f2.Airline = a.Id
    and f3.Airline = a.Id
    and a.Name = 'Southwest Airlines'
    and (f1.Destination = p.Code)
    and (f2.Destination = p.Code)
    and (f3.Destination = p.Code)
order by p.Code;


USE `KATZENJAMMER`;
-- KATZENJAMMER-1
-- Report, in order, the tracklist for ’Le Pop’. Output just the names of the songs in the order in which they occur on the album.
select s.Title
from Albums a, Tracklists t, Songs s
where a.Title = 'Le Pop'
    and t.Song = s.SongId
    and t.Album = a.AId;


USE `KATZENJAMMER`;
-- KATZENJAMMER-2
-- List the instruments each performer plays on ’Mother Superior’. Output the first name of each performer and the instrument, sort alphabetically by the first name.
select b.Firstname, i.Instrument
from Band b, Instruments i, Songs s
where (b.Id = i.Bandmate and i.Song = s.SongId) and 
    (s.Title = "Mother Superior")
order by b.Firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-3
-- List all instruments played by Anne-Marit at least once during the performances. Report the instruments in alphabetical order (each instrument needs to be reported exactly once).
select distinct i.Instrument
from Band b, Instruments i, Songs s
where b.Id = i.Bandmate
    and i.Song = s.SongId
    and b.Firstname = 'Anne-Marit'
order by i.Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-4
-- Find all songs that featured ukalele playing (by any of the performers). Report song titles in alphabetical order.
select s.Title
from Songs s, Instruments i
where i.Instrument = 'ukalele'
    and s.SongId = i.Song
order by s.Title;


USE `KATZENJAMMER`;
-- KATZENJAMMER-5
-- Find all instruments Turid ever played on the songs where she sang lead vocals. Report the names of instruments in alphabetical order (each instrument needs to be reported exactly once).
select distinct i.instrument
from Vocals v, Instruments i, Band b, Songs s
where v.VocalType = 'lead'
    and v.Bandmate = b.Id
    and v.Song = s.SongId
    and i.Song = s.SongId
    and i.Bandmate = b.Id
    and b.Firstname = 'Turid'
order by i.instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-6
-- Find all songs where the lead vocalist is not positioned center stage. For each song, report the name, the name of the lead vocalist (first name) and her position on the stage. Output results in alphabetical order by the song, then name of band member. (Note: if a song had more than one lead vocalist, you may see multiple rows returned for that song. This is the expected behavior).
select s.Title, b.Firstname, p.StagePosition
from Vocals v, Performance p, Band b, Songs s
where v.VocalType = 'lead' 
    and v.Song = s.SongId
    and v.Bandmate = b.Id
    and p.StagePosition != 'center'
    and p.Song = s.SongId
    and p.Bandmate = b.Id
order by s.Title, b.Firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-7
-- Find a song on which Anne-Marit played three different instruments. Report the name of the song. (The name of the song shall be reported exactly once)
select distinct s.Title
from Songs s, Instruments i1, Instruments i2, Instruments i3, Band b
where b.Firstname = 'Anne-Marit'
    and i1.Instrument != i2.Instrument
    and i1.Instrument != i3.Instrument
    and i2.Instrument != i3.Instrument
    and i1.Song = i2.Song
    and i1.Song = i3.Song
    and i2.Song = i3.Song
    and i1.Song = s.SongId
    and i2.Song = s.SongId
    and i3.Song = s.SongId
    and i1.Bandmate = b.Id
    and i2.Bandmate = b.Id
    and i3.Bandmate = b.id;


USE `KATZENJAMMER`;
-- KATZENJAMMER-8
-- Report the positioning of the band during ’A Bar In Amsterdam’. (just one record needs to be returned with four columns (right, center, back, left) containing the first names of the performers who were staged at the specific positions during the song).
select b1.Firstname as 'right', b2.Firstname as 'center', b3.Firstname as 'back', b4.Firstname as 'left'
from Songs s
inner join Performance p1 on p1.Song = s.SongId and p1.StagePosition = 'right' and s.Title = 'A bar In Amsterdam'
inner join Performance p2 on p2.Song = s.SongId and p2.StagePosition = 'center'
inner join Performance p3 on p3.Song = s.SongId and p3.StagePosition = 'back'
inner join Performance p4 on p4.Song = s.SongId and p4.StagePosition = 'left'
inner join Band b1 on p1.Bandmate = b1.Id
inner join Band b2 on p2.Bandmate = b2.Id
inner join Band b3 on p3.Bandmate = b3.Id
inner join Band b4 on p4.Bandmate = b4.Id;


