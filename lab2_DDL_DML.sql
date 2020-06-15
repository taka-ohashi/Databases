-- Lab 2
-- tohashi
-- Jun 15, 2020

USE `tohashi`;
-- BAKERY
-- Create and populate relational tables corresponding to the BAKERY dataset (schema and data provided on Canvas)
drop table customers;
drop table goods;
drop table items;
drop table receipts;

create table customers(
    CId int,
    LastName char(30),
    FirstName char(30),
    PRIMARY KEY(FirstName, LastName)
);

create table goods(
    GId char(30),
    Flavor char(30),
    Food char(30),
    Price float,
    UNIQUE(GId),
    PRIMARY KEY(Food, Flavor)
);

create table items(
    Receipt int,
    Ordinal int,
    Item char(30) REFERENCES goods(GId),
    Primary Key(Receipt, Ordinal)
);

create table receipts(
    RNumber int,
    SaleDate date,
    Customer int References customers(CId)
);

INSERT INTO customers(CId, LastName, FirstName) VALUES(1, "LOGAN", "JULIET");
INSERT INTO customers(CId, LastName, FirstName) VALUES(2, "ARZT", "TERRELL");
INSERT INTO customers(CId, LastName, FirstName) VALUES(3, "ESPOSITA", "TRAVIS");
INSERT INTO customers(CId, LastName, FirstName) VALUES(4, "ENGLEY", "SIXTA");
INSERT INTO customers(CId, LastName, FirstName) VALUES(5, "DUNLOW", "OSVALDO");
INSERT INTO customers(CId, LastName, FirstName) VALUES(6, "SLINGLAND", "JOSETTE");
INSERT INTO customers(CId, LastName, FirstName) VALUES(7, "TOUSSAND", "SHARRON");
INSERT INTO customers(CId, LastName, FirstName) VALUES(8, "HELING", "RUPERT");
INSERT INTO customers(CId, LastName, FirstName) VALUES(9, "HAFFERKAMP", "CUC");
INSERT INTO customers(CId, LastName, FirstName) VALUES(10, "DUKELOW", "CORETTA");
INSERT INTO customers(CId, LastName, FirstName) VALUES(11, "STADICK", "MIGDALIA");
INSERT INTO customers(CId, LastName, FirstName) VALUES(12, "MCMAHAN", "MELLIE");
INSERT INTO customers(CId, LastName, FirstName) VALUES(13, "ARNN", "KIP");
INSERT INTO customers(CId, LastName, FirstName) VALUES(14, "S'OPKO", "RAYFORD");
INSERT INTO customers(CId, LastName, FirstName) VALUES(15, "CALLENDAR", "DAVCID");
INSERT INTO customers(CId, LastName, FirstName) VALUES(16, "CRUZEN", "ARIANE");
INSERT INTO customers(CId, LastName, FirstName) VALUES(17, "MESDAQ", "CHARLENE");
INSERT INTO customers(CId, LastName, FirstName) VALUES(18, "DOMKOWSKI", "ALMETA");
INSERT INTO customers(CId, LastName, FirstName) VALUES(19, "STENZ", "NATACHA");
INSERT INTO customers(CId, LastName, FirstName) VALUES(20, "ZEME", "STEPHEN");
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("20-BC-C-10", "Chocolate", "Cake", 8.95);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("20-BC-L-10", "Lemon", "Cake", 8.95);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("20-CA-7.5", "Casino", "Cake", 15.95);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("24-8x10", "Opera", "Cake", 15.95);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("25-STR-9", "Strawberry", "Cake", 11.95);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("26-8x10", "Truffle", "Cake", 15.95);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("45-CH", "Chocolate", "Eclair", 3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("45-CO", "Coffee", "Eclair", 3.5);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("45-VA", "Vanilla", "Eclair", 3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("46-11", "Napoleon", "Cake", 13.49);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("90-ALM-I", "Almond", "Tart", 3.75);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("90-APIE-10", "Apple", "Pie", 5.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("90-APP-11", "Apple", "Tart", 3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("90-APR-PF", "Apricot", "Tart", 3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("90-BER-11", "Berry", "Tart", 3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("90-BLK-PF", "Blackberry", "Tart", 3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("90-BLU-11", "Blueberry", "Tart", 3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("90-CH-PF", "Chocolate", "Tart", 3.75);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("90-CHR-11", "Cherry", "Tart", 3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("90-LEM-11", "Lemon", "Tart", 3.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("90-PEC-11", "Pecan", "Tart", 3.75);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("70-GA", "Ganache", "Cookie", 1.15);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("70-GON", "Gongolais", "Cookie", 1.15);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("70-R", "Raspberry", "Cookie", 1.09);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("70-LEM", "Lemon", "Cookie", 0.79);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("70-M-CH-DZ", "Chocolate", "Meringue", 1.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("70-M-VA-SM-DZ", "Vanilla", "Meringue", 1.15);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("70-MAR", "Marzipan", "Cookie", 1.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("70-TU", "Tuile", "Cookie", 1.25);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("70-W", "Walnut", "Cookie", 0.79);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("50-ALM", "Almond", "Croissant", 1.45);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("50-APP", "Apple", "Croissant", 1.45);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("50-APR", "Apricot", "Croissant", 1.45);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("50-CHS", "Cheese", "Croissant", 1.75);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("50-CH", "Chocolate", "Croissant", 1.75);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("51-APR", "Apricot", "Danish", 1.15);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("51-APP", "Apple", "Danish", 1.15);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("51-ATW", "Almond", "Twist", 1.15);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("51-BC", "Almond", "Bear Claw", 1.95);
INSERT INTO goods(GId,Flavor,Food,Price) VALUES("51-BLU", "Blueberry", "Danish", 1.15);
INSERT INTO items(Receipt, Ordinal, Item) VALUES(18129, "1", "70-TU");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(51991, "1", "90-APIE-10");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(51991, "2", "90-CH-PF");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(51991, "3", "90-APP-11");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(51991, "4", "26-8x10");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(83085, "1", "25-STR-9");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(83085, "2", "24-8x10");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(83085, "3", "90-APR-PF");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(83085, "4", "51-ATW");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(83085, "5", "26-8x10");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(70723, "1", "45-CO");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(13355, "1", "24-8x10");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(13355, "2", "70-LEM");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(13355, "3", "46-11");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(52761, "1", "90-ALM-I");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(52761, "2", "26-8x10");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(52761, "3", "50-CHS");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(52761, "4", "90-BLK-PF");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(52761, "5", "90-ALM-I");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(99002, "1", "50-CHS");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(99002, "2", "45-VA");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(58770, "1", "50-CHS");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(58770, "2", "46-11");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(58770, "3", "45-CH");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(58770, "4", "20-CA-7.5");
INSERT INTO items(Receipt, Ordinal, Item) VALUES(84665, "1", "90-BER-11");
INSERT INTO receipts(RNumber, SaleDate, Customer) VALUES(18129, "2007-10-28", "15");
INSERT INTO receipts(RNumber, SaleDate, Customer) VALUES(51991, "2007-10-17", "14");
INSERT INTO receipts(RNumber, SaleDate, Customer) VALUES(83085, "2007-10-12", "7");
INSERT INTO receipts(RNumber, SaleDate, Customer) VALUES(70723, "2007-10-28", "20");
INSERT INTO receipts(RNumber, SaleDate, Customer) VALUES(13355, "2007-10-12", "7");
INSERT INTO receipts(RNumber, SaleDate, Customer) VALUES(52761, "2007-10-27", "8");
INSERT INTO receipts(RNumber, SaleDate, Customer) VALUES(99002, "2007-10-13", "20");
INSERT INTO receipts(RNumber, SaleDate, Customer) VALUES(58770, "2007-10-22", "18");
INSERT INTO receipts(RNumber, SaleDate, Customer) VALUES(84665, "2007-10-10", "6");


USE `tohashi`;
-- AIRLINES
-- Create and populate the AIRLINES database
SET FOREIGN_KEY_CHECKS=0;
drop table airlines;
drop table airports;
drop table flights;

create table airlines(
    Id int,
    Airline char(30),
    Abbreviation varchar(30),
    Country char(30),
    PRIMARY KEY(Abbreviation)
);

create table airports(
    City char(30),
    AirportCode char(3) NOT NULL,
    AirportName char(100),
    Country char(30),
    CountryAbbrev char(30),
    PRIMARY KEY(AirportCode)
);

create table flights(
    Airline int REFERENCES airlines(Id),
    FlightNo int,
    SourceAirport char(3) NOT NULL, 
    DestAirport char (3) NOT NULL,
    Primary Key(Airline, FlightNo),
    FOREIGN KEY(SourceAirport) REFERENCES airports(AirportCode),
    FOREIGN KEY(DestAirport) REFERENCES airports(AirportCode)
);


INSERT INTO airlines(Id,Airline,Abbreviation,Country) VALUES(1, "United Airlines", "UAL", "USA");
INSERT INTO airlines(Id,Airline,Abbreviation,Country) VALUES(2, "US Airways", "USAir", "USA");
INSERT INTO airlines(Id,Airline,Abbreviation,Country) VALUES(3, "Delta Airlines", "Delta", "USA");
INSERT INTO airlines(Id,Airline,Abbreviation,Country) VALUES(4, "Southwest Airlines", "Southwest", "USA");
INSERT INTO airlines(Id,Airline,Abbreviation,Country) VALUES(5, "American Airlines", "American", "USA");
INSERT INTO airlines(Id,Airline,Abbreviation,Country) VALUES(6, "Northwest Airlines", "Northwest", "USA");
INSERT INTO airlines(Id,Airline,Abbreviation,Country) VALUES(7, "Continental Airlines", "Continental", "USA");
INSERT INTO airlines(Id,Airline,Abbreviation,Country) VALUES(8, "JetBlue Airways", "JetBlue", "USA");
INSERT INTO airlines(Id,Airline,Abbreviation,Country) VALUES(9, "Frontier Airlines", "Frontier", "USA");
INSERT INTO airlines(Id,Airline,Abbreviation,Country) VALUES(10, "AirTran Airways", "AirTran", "USA");
INSERT INTO airlines(Id,Airline,Abbreviation,Country) VALUES(11, "Allegiant Air", "Allegiant", "USA");
INSERT INTO airlines(Id,Airline,Abbreviation,Country) VALUES(12, "Virgin America", "Virgin", "USA");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Aberdeen", "APG", "Phillips AAF", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Aberdeen", "ABR", "Municipal", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Abilene", "DYS", "Dyess AFB", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Abilene", "ABI", "Municipal", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Abingdon", "VJI", "Virginia Highlands", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Ada", "ADT", "Ada", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Adak Island", "ADK", "Adak Island Ns", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Adrian", "ADG", "Lenawee County", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Afton", "AFO", "Municipal", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Aiken", "AIK", "Municipal", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Ainsworth", "ANW", "Ainsworth", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Akhiok", "AKK", "Akhiok SPB", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Akiachak", "KKI", "Spb", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Akiak", "AKI", "Akiak", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Akron CO", "AKO", "Colorado Plains Regional Airport", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Akron/Canton OH", "CAK", "Akron/canton Regional", "United States", "US ");
INSERT INTO airports(City,AirportCode,AirportName,Country,CountryAbbrev  ) VALUES("Akron/Canton", "AKC", "Fulton International", "United States", "US");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(1, 28, "APG", "ABR");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(1, 29, "AIK", "ADT");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(1, 44, "AKO", "AKI");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(1, 45, "CAK", "APG");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(1, 54, "AFO", "AKO");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(3, 2, "AIK", "ADT");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(3, 3, "DYS", "ABI");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(3, 26, "AKK", "VJI");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(9, 1260, "AKO", "AKC");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(9, 1261, "APG", "ABR");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(9, 1286, "ABR", "APG");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(9, 1287, "DYS", "ANW");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(10, 6, "KKI", "AKC");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(10, 7, "VJI", "APG");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(10, 54, "ADT", "APG");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(6, 4, "AIK", "AKO");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(6, 5, "CAK", "APG");
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) VALUES(6, 28, "AKO", "ABI");


USE `tohashi`;
-- KATZENJAMMER
-- Create and populate the KATZENJAMMER database
drop table Albums;
drop table Band;
drop table Instruments;
drop table Performance;
drop table Songs;
drop table Tracklists;
drop table Vocals;

create table Albums(
    AId int,
    Title char(60),
    Year int,
    Label char(30),
    Type char(30),
    PRIMARY KEY(AId)
);

create table Band(
    Id int,
    Firstname char(30),
    LastName char(30),
    PRIMARY KEY(Id)
);

create table Instruments(
    SongId int REFERENCES songs(SongId),
    BandmateId int REFERENCES band(Id),
    Instrument char(30),
    PRIMARY KEY(SongId, BandmateId, Instrument)
);


create table Performance(
    SongId int REFERENCES songs(SongId),
    Bandmate int REFERENCES band(Id),
    StagePosition char(10),
    PRIMARY KEY(SongId, Bandmate)
);

create table Songs(
    SongId int,
    Title char(100),
    Primary Key(SongId, Title)
);

create table Tracklists(
    AlbumId int REFERENCES albums(AId),
    Position int,
    SongId int REFERENCES songs(SongId),
    PRIMARY KEY(AlbumId)
);


create table Vocals(
    SongId int REFERENCES songs(SongId),
    Bandmate int REFERENCES band(Id),
    Type char(10)
);

INSERT INTO Albums(AId,Title,Year,Label,Type) VALUES(1, "Le Pop", 2008, "Propeller Recordings", "Studio");
INSERT INTO Albums(AId,Title,Year,Label,Type) VALUES(2, "A Kiss Before You Go", 2011, "Propeller Recordings", "Studio");
INSERT INTO Albums(AId,Title,Year,Label,Type) VALUES(3, "A Kiss Before You Go: Live in Hamburg", 2012, "Universal Music Group", "Live");
INSERT INTO Albums(AId,Title,Year,Label,Type) VALUES(4, "Rockland", 2015, "Propeller Recordings", "Studio");
INSERT INTO Band(Id,Firstname,Lastname) VALUES(1, "Solveig", "Heilo");
INSERT INTO Band(Id,Firstname,Lastname) VALUES(2, "aMrianne", "Sveen");
INSERT INTO Band(Id,Firstname,Lastname) VALUES(3, "Anne-Marit", "Bergheim");
INSERT INTO Band(Id,Firstname,Lastname) VALUES(4, "Turid", "Jorgensen");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(1, 1, "trumpet");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(1, 2, "keyboard");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(1, 3, "accordion");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(1, 4, "bass balalaika");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(2, 1, "trumpet");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(2, 2, "drums");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(2, 3, "guitar");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(2, 4, "bass balalaika");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(3, 1, "drums");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(3, 1, "ukalele");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(3, 2, "banjo");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(3, 3, "bass balalaika");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(3, 4, "keyboards");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(4, 1, "drums");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(4, 2, "ukalele");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(4, 3, "accordion");
INSERT INTO Instruments(SongId,BandmateId,Instrument) VALUES(4, 4, "bass balalaika");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(1, 1, "back");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(1, 2, "left");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(1, 3, "center");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(1, 4, "right");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(2, 1, "center");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(2, 2, "back");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(2, 3, "left");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(2, 4, "right");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(3, 1, "back");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(3, 2, "right");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(3, 3, "center");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(3, 4, "left");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(4, 1, "back");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(4, 2, "center");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(4, 3, "left");
INSERT INTO Performance(SongId,Bandmate,StagePosition) VALUES(4, 4, "right");
INSERT INTO Songs(SongId,Title) VALUES(1, "Overture");
INSERT INTO Songs(SongId,Title) VALUES(2, "A Bar In Amsterdam");
INSERT INTO Songs(SongId,Title) VALUES(3, "Demon Kitty Rag");
INSERT INTO Songs(SongId,Title) VALUES(4, "Tea With Cinnamon");
INSERT INTO Songs(SongId,Title) VALUES(5, "Hey Ho on the Devil's Back");
INSERT INTO Songs(SongId,Title) VALUES(6, "Wading in Deeper");
INSERT INTO Songs(SongId,Title) VALUES(7, "Le Pop");
INSERT INTO Songs(SongId,Title) VALUES(8, "Der Kapitan");
INSERT INTO Songs(SongId,Title) VALUES(9, "Virginia Clemm");
INSERT INTO Songs(SongId,Title) VALUES(10, "Play My Darling");
INSERT INTO Songs(SongId,Title) VALUES(11, "To the Sea");
INSERT INTO Songs(SongId,Title) VALUES(12, "Mother Superior");
INSERT INTO Songs(SongId,Title) VALUES(13, "Aint no Thang");
INSERT INTO Songs(SongId,Title) VALUES(14, "A Kiss Before You Go");
INSERT INTO Songs(SongId,Title) VALUES(15, "I Will Dance (When I Walk Away)");
INSERT INTO Songs(SongId,Title) VALUES(16, "Cherry Pie");
INSERT INTO Songs(SongId,Title) VALUES(17, "Land of Confusion");
INSERT INTO Songs(SongId,Title) VALUES(18, "Lady Marlene");
INSERT INTO Songs(SongId,Title) VALUES(19, "Rock-Paper-Scissors");
INSERT INTO Songs(SongId,Title) VALUES(20, "Cocktails and Ruby Slippers");
INSERT INTO Songs(SongId,Title) VALUES(21, "Soviet Trumpeter");
INSERT INTO Songs(SongId,Title) VALUES(22, "Loathsome M");
INSERT INTO Songs(SongId,Title) VALUES(23, "Shepherds Song");
INSERT INTO Songs(SongId,Title) VALUES(24, "Gypsy Flee");
INSERT INTO Songs(SongId,Title) VALUES(25, "Gods Great Dust Storm");
INSERT INTO Songs(SongId,Title) VALUES(26, "Ouch");
INSERT INTO Songs(SongId,Title) VALUES(27, "Listening to the World");
INSERT INTO Songs(SongId,Title) VALUES(28, "Johnny Blowtorch");
INSERT INTO Songs(SongId,Title) VALUES(29, "Flash");
INSERT INTO Songs(SongId,Title) VALUES(30, "Driving After You");
INSERT INTO Songs(SongId,Title) VALUES(31, "My Own Tune");
INSERT INTO Songs(SongId,Title) VALUES(32, "Badlands");
INSERT INTO Songs(SongId,Title) VALUES(33, "Old De Spain");
INSERT INTO Songs(SongId,Title) VALUES(34, "Oh My God");
INSERT INTO Songs(SongId,Title) VALUES(35, "Lady Gray");
INSERT INTO Songs(SongId,Title) VALUES(36, "Shine Like Neon Rays");
INSERT INTO Songs(SongId,Title) VALUES(37, "Flash in the Dark");
INSERT INTO Songs(SongId,Title) VALUES(38, "My Dear");
INSERT INTO Songs(SongId,Title) VALUES(39, "Bad Girl");
INSERT INTO Songs(SongId,Title) VALUES(40, "Rockland");
INSERT INTO Songs(SongId,Title) VALUES(41, "Curvaceous Needs");
INSERT INTO Songs(SongId,Title) VALUES(42, "Borka");
INSERT INTO Songs(SongId,Title) VALUES(43, "Let it Snow");
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(1, 1, 1);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(1, 2, 2);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(1, 3, 3);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(1, 4, 4);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(1, 5, 5);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(1, 6, 6);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(1, 7, 7);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(1, 8, 8);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(1, 9, 9);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(1, 10, 10);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(1, 11, 11);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(1, 12, 12);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(1, 13, 13);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(2, 1, 14);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(2, 2, 15);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(2, 3, 16);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(2, 4, 17);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(2, 5, 18);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(2, 6, 19);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(2, 7, 20);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(2, 8, 21);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(2, 9, 22);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(2, 10, 23);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(2, 11, 24);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(2, 12, 25);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 1, 14);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 2, 26);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 3, 3);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 4, 15);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 5, 11);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 6, 19);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 7, 18);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 8, 16);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 9, 12);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 10, 17);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 11, 22);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 12, 20);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 13, 2);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 14, 5);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 15, 8);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 16, 7);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 17, 25);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 18, 13);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(3, 19, 24);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(4, 1, 33);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(4, 2, 41);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(4, 3, 34);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(4, 4, 35);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(4, 5, 31);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(4, 6, 36);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(4, 7, 30);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(4, 8, 37);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(4, 9, 38);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(4, 10, 39);
INSERT INTO Tracklists(AlbumId,Position,SongId) VALUES(4, 11, 40);
INSERT INTO Vocals(SongId,Bandmate,Type) VALUES(2, 1, "lead");
INSERT INTO Vocals(SongId,Bandmate,Type) VALUES(2, 3, "chorus");
INSERT INTO Vocals(SongId,Bandmate,Type) VALUES(2, 4, "chorus");
INSERT INTO Vocals(SongId,Bandmate,Type) VALUES(3, 2, "lead");
INSERT INTO Vocals(SongId,Bandmate,Type) VALUES(4, 1, "chorus");
INSERT INTO Vocals(SongId,Bandmate,Type) VALUES(4, 2, "lead");
INSERT INTO Vocals(SongId,Bandmate,Type) VALUES(4, 3, "chorus");
INSERT INTO Vocals(SongId,Bandmate,Type) VALUES(4, 4, "chorus");


USE `tohashi`;
-- CUSTOM
-- Create and populate your custom data set.
drop table bank;
drop table consumer;
drop table saudi;

create table bank(
	Periodicity char(30),
	Year int,
	Quarter char(30),
	Month char(30),
	DepositType char(30),
	Depositvalue float
);

create table consumer(
	Periodicity char(30),
	Year int,
	Quarter char(30),
	MaturityTerms char(100),
	LoansValuePerMaturityTerms float,
	LoanType char (30),
	LoanValueSaudiRiyal float
);

create table saudi(
	Periodicity char(30),
	Year int,
	Quarter char(30),
	Month char(30),
	Date char(30),
	Item char(30),
	MoneySupply float
);


