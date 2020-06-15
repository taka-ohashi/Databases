import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import java.util.Map;
import java.util.Scanner;
import java.util.LinkedHashMap;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;

/*
Introductory JDBC examples based loosely on the BAKERY dataset from CSC 365 labs.
 */
public class InnReservations {

    private final String JDBC_URL = "jdbc:h2:~/csc365_lab7";
    private final String JDBC_USER = "";
    private final String JDBC_PASSWORD = "";
    
    public static void main(String[] args) {
	System.out.print("Carter Rules: ");
	try {
	    InnReservations hp = new InnReservations();
            hp.initDb();
	    //hp.RoomsandRates();
		hp.MainMenu();
	} catch (SQLException e) {
	    System.err.println("SQLException: " + e.getMessage());
	}
    }
    

    

	private void MainMenu() throws SQLException{
		// Scan for user input
	    Scanner scanner = new Scanner(System.in);
	    System.out.println("Enter an option!!!!: ");
		System.out.println("FR1: Rooms and Rates");
		System.out.println("FR2: Reservations");
		System.out.println("FR3: Reservation Change");
		System.out.println("FR4: Reservation Cancellation");
		System.out.println("FR5: Revenue Summary");
	    String option = scanner.nextLine();
		
		switch(option) {
			case "FR1":
				RoomsandRates();
				break;
			case "FR2":
				RoomsandRates();
				break;
			case "FR3":
				RoomsandRates();
				break;
			case "FR4":
				fr4();
				break;
			case "FR5":
				RoomsandRates();
				break;
			default:
				System.out.println("Try again! EX: 'FR1'");
				MainMenu();
				break;
		}
	
	}


    // Demo2 - Establish JDBC connection, execute SELECT query, read & print result
    private void demo2() throws SQLException {

	// Step 1: Establish connection to RDBMS
	try (Connection conn = DriverManager.getConnection(JDBC_URL,
							   JDBC_USER,
							   JDBC_PASSWORD)) {
	    // Step 2: Construct SQL statement
	    String sql = "SELECT * FROM hp_goods";

	    // Step 3: (omitted in this example) Start transaction

	    // Step 4: Send SQL statement to DBMS
	    try (Statement stmt = conn.createStatement();
		 ResultSet rs = stmt.executeQuery(sql)) {

		// Step 5: Receive results
		while (rs.next()) {
		    String flavor = rs.getString("Flavor");
		    String food = rs.getString("Food");
		    float price = rs.getFloat("Price");
		    System.out.format("%s %s ($%.2f) %n", flavor, food, price);
		}
	    }

	    // Step 6: (omitted in this example) Commit or rollback transaction
	}
	// Step 7: Close connection (handled by try-with-resources syntax)
    }








    // Demo5 - Construct a query using PreparedStatement
    private void RoomsandRates() throws SQLException {

	// Step 1: Establish connection to RDBMS
	try (Connection conn = DriverManager.getConnection(JDBC_URL,
							   JDBC_USER,
							   JDBC_PASSWORD)) {
	    Scanner scanner = new Scanner(System.in);

	    List<Object> params = new ArrayList<Object>();
	    StringBuilder sb = new StringBuilder("SELECT * FROM lab7_rooms");
	    
	    try (PreparedStatement pstmt = conn.prepareStatement(sb.toString())) {
		int i = 1;
		for (Object p : params) {
		    pstmt.setObject(i++, p);
		}
		
		try (ResultSet rs = pstmt.executeQuery()) {
		    System.out.println("List of Rooms and Rates:");
			System.out.format("%-15s %-15s %-15s %-15s %-15s %-15s %-15s %n", "RoomCode", "RoomName", "Beds", "bedType", "maxOccupancy", "basePrice", "decor");
		    int matchCount = 0;
		    while (rs.next()) {
			System.out.format("%-15s %-15s %-15.2f %-15s %-15.2f ($%12.2f) %-15s %n", rs.getString("RoomCode"), rs.getString("RoomName"), rs.getDouble("Beds"), rs.getString("bedType"), rs.getDouble("maxOccupancy"), rs.getDouble("basePrice"), rs.getString("decor"));
			matchCount++;
		    }
		    System.out.format("----------------------%nFound %d match%s %n", matchCount, matchCount == 1 ? "" : "es");
		}
	    }

	}
	MainMenu();
    }


        // Demo5 - Construct a query using PreparedStatement
    private void fr4() throws SQLException {

	// Step 1: Establish connection to RDBMS
	try (Connection conn = DriverManager.getConnection(JDBC_URL,
							   JDBC_USER,
							   JDBC_PASSWORD)) {
	    Scanner scanner = new Scanner(System.in);
	    System.out.println("Enter your reservation code number!!!!: ");
	    String option = scanner.nextLine();

	    String sql = "DELETE FROM lab7_reservations WHERE CODE = " + Integer.toString(option) + ";";
	    
	    try (Statement stmt = conn.createStatement()) {
                stmt.execute(sql);
	    }
	    }

	}
	MainMenu();
    }

    private void initDb() throws SQLException {
	try (Connection conn = DriverManager.getConnection(JDBC_URL,
							   JDBC_USER,
							   JDBC_PASSWORD)) {

		// Create lab7_reservations and populate
	    try (Statement stmt = conn.createStatement()) {
                stmt.execute("DROP TABLE IF EXISTS lab7_reservations cascade");
                stmt.execute("CREATE TABLE lab7_reservations (CODE INTEGER NOT NULL PRIMARY KEY,Room CHAR(3) NOT NULL,CheckIn DATE NOT NULL,Checkout DATE NOT NULL,Rate DECIMAL (5, 2) NOT NULL,LastName VARCHAR(100) NOT NULL,FirstName VARCHAR(100) NOT NULL,Adults INTEGER NOT NULL,Kids INTEGER NOT NULL,FOREIGN KEY (Room) REFERENCES lab7_rooms (RoomCode))");
                stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (80085,'GOF','2020-01-01','2020-01-10',50.0,'monkeyman','mister',1,0)");
                stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (12345,'GOF','2020-01-11','2020-01-20',51,'marbles','misses',0,1)");
                stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (20001,'PIG','2020-01-05','2020-01-07',80,'pig','mister',3,0)");
                stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (69420,'DOG','2020-01-01','2020-01-05',69,'dog','mister',2,0)");
                stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (42069,'CAT','2020-01-20','2020-01-24',59,'monkeyman','mister',1,0)");
                stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (13337,'SHP','2020-01-02','2020-01-04',44,'sheep','mister',1,0)");
				stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (10101,'BIG','2020-01-03','2020-01-10',33,'giant','mister',1,0)");
				stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (11010,'CAR','2020-01-01','2020-01-29',1,'fourRunner','Toyota',1,0)");
				stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (54321,'KNG','2020-01-09','2020-01-10',1,'kingguy','sirKingly',1,0)");
				stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (69696,'PIG','2020-01-10','2020-01-12',222,'pigdude','another',1,1)");
				stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (96969,'DOG','2020-01-11','2020-01-14',420,'dogdude','doggerson',1,0)");
				stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (44444,'SHP','2020-01-05','2020-01-09',111,'sheepyboi','a',1,2)");
				stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (33333,'BIG','2020-01-12','2020-01-19',100,'boi','smol',10,9)");
				stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (22222,'CAR','2020-01-26','2020-01-28',101,'fType','Jaguar',1,0)");
				stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (11111,'KNG','2020-01-16','2020-01-17',100,'peasant','peasantly',1,0)");
				stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (80000,'GOF','2020-01-21','2020-01-22',69.42,'golfguy','misterMan',2,0)");	
				stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (55555,'GOF','2020-01-24','2020-01-25',111,'golflady','misseslady',0,4)");	
				stmt.execute("INSERT INTO lab7_reservations(CODE,Room,CheckIn,Checkout,Rate,LastName,FirstName,Adults,Kids) VALUES (66666,'GOF','2020-01-29','2020-01-30',10,'WOOOOOODS','TYGA',0,1)");					
	    }
	   // Create lab7_rooms and populate
	    try (Statement stmt = conn.createStatement()) {
                stmt.execute("DROP TABLE IF EXISTS lab7_rooms cascade");
                stmt.execute("CREATE TABLE lab7_rooms (RoomCode CHAR(3) PRIMARY KEY,RoomName VARCHAR(100) NOT NULL,Beds INTEGER NOT NULL,bedType VARCHAR(100) NOT NULL,maxOccupancy INTEGER NOT NULL,basePrice INTEGER NOT NULL,decor VARCHAR(100) NOT NULL)");
                stmt.execute("INSERT INTO lab7_rooms(RoomCode,RoomName,Beds,bedType,maxOccupancy,basePrice,decor) VALUES ('GOF','golf room',1,'fairway',69,420,'fancypantsy')");
                stmt.execute("INSERT INTO lab7_rooms(RoomCode,RoomName,Beds,bedType,maxOccupancy,basePrice,decor) VALUES ('PIG','pig room',10,'mud',4,20,'farm');");
                stmt.execute("INSERT INTO lab7_rooms(RoomCode,RoomName,Beds,bedType,maxOccupancy,basePrice,decor) VALUES ('DOG','dog room',5,'grass',2,10,'farm')");
                stmt.execute("INSERT INTO lab7_rooms(RoomCode,RoomName,Beds,bedType,maxOccupancy,basePrice,decor) VALUES ('CAT','cat room',2,'grass',3,10,'farm')");
                stmt.execute("INSERT INTO lab7_rooms(RoomCode,RoomName,Beds,bedType,maxOccupancy,basePrice,decor) VALUES ('SHP','sheep room',69,'grass',19,24,'farm')");
                stmt.execute("INSERT INTO lab7_rooms(RoomCode,RoomName,Beds,bedType,maxOccupancy,basePrice,decor) VALUES ('BIG','big room',420,'bigbedyo',80085,1,'simple')");
				stmt.execute("INSERT INTO lab7_rooms(RoomCode,RoomName,Beds,bedType,maxOccupancy,basePrice,decor) VALUES ('CAR','car room',1,'cement',1,100000000,'racing')");
				stmt.execute("INSERT INTO lab7_rooms(RoomCode,RoomName,Beds,bedType,maxOccupancy,basePrice,decor) VALUES ('KNG','king room',100,'bestbedever',69,15,'fancypantsy')");
	    }
	}
    }


// OLD (STOCK) FUNCTIONS GO HERE

    private void OLDinitDb() throws SQLException {
	try (Connection conn = DriverManager.getConnection(JDBC_URL,
							   JDBC_USER,
							   JDBC_PASSWORD)) {
	    try (Statement stmt = conn.createStatement()) {
                stmt.execute("DROP TABLE IF EXISTS hp_goods");
                stmt.execute("CREATE TABLE hp_goods (GId varchar(15) PRIMARY KEY, Food varchar(100), Flavor varchar(100), Price DECIMAL(5,1), AvailUntil DATE)");
                stmt.execute("INSERT INTO hp_goods (GId, Flavor, Food, Price) VALUES ('L1', 'Lemon', 'Cake', 20.0)");
                stmt.execute("INSERT INTO hp_goods (GId, Flavor, Food, Price) VALUES ('L2', 'Lemon', 'Twist', 3.50)");
                stmt.execute("INSERT INTO hp_goods (GId, Flavor, Food, Price) VALUES ('A3', 'Almond', 'Twist', 4.50)");
                stmt.execute("INSERT INTO hp_goods (GId, Flavor, Food, Price) VALUES ('A4', 'Almond', 'Cookie', 4.50)");
                stmt.execute("INSERT INTO hp_goods (GId, Flavor, Food, Price) VALUES ('L5', 'Lemon', 'Cookie', 1.50)");
                stmt.execute("INSERT INTO hp_goods (GId, Flavor, Food, Price) VALUES ('A6', 'Almond', 'Danish', 2.50)");
	    }
	}
    }
	



    // Demo1 - Establish JDBC connection, execute DDL statement
    private void demo1() throws SQLException {

	// Step 0: Load JDBC Driver
	// No longer required as of JDBC 2.0  / Java 6
	try{
	    Class.forName("org.h2.Driver");
	    System.out.println("H2 JDBC Driver loaded");
	} catch (ClassNotFoundException ex) {
	    System.err.println("Unable to load JDBC Driver");
	    System.exit(-1);
	}

	// Step 1: Establish connection to RDBMS
	try (Connection conn = DriverManager.getConnection(JDBC_URL,
							   JDBC_USER,
							   JDBC_PASSWORD)) {
	    // Step 2: Construct SQL statement
	    String sql = "ALTER TABLE hp_goods ADD COLUMN AvailUntil DATE";

	    // Step 3: (omitted in this example) Start transaction

	    try (Statement stmt = conn.createStatement()) {

		// Step 4: Send SQL statement to DBMS
		boolean exRes = stmt.execute(sql);
		
		// Step 5: Handle results
		System.out.format("Result from ALTER: %b %n", exRes);
	    }

	    // Step 6: (omitted in this example) Commit or rollback transaction
	}
	// Step 7: Close connection (handled by try-with-resources syntax)
    }




    // Demo3 - Establish JDBC connection, execute DML query (UPDATE)
    // -------------------------------------------
    // Never (ever) write database code like this!
    // -------------------------------------------
    private void demo3() throws SQLException {
	    System.out.print("Carter Rules: ");
        demo2();
		RoomsandRates();
        
	// Step 1: Establish connection to RDBMS
	try (Connection conn = DriverManager.getConnection(JDBC_URL,
							   JDBC_USER,
							   JDBC_PASSWORD)) {
	    // Step 2: Construct SQL statement
	    Scanner scanner = new Scanner(System.in);
	    System.out.print("Enter a flavor!!!!: ");
	    String flavor = scanner.nextLine();
	    System.out.format("Until what date will %s be available (YYYY-MM-DD)? ", flavor);
	    String availUntilDate = scanner.nextLine();

	    // -------------------------------------------
	    // Never (ever) write database code like this!
	    // -------------------------------------------
	    String updateSql = "UPDATE hp_goods SET AvailUntil = '" + availUntilDate + "' " +
		               "WHERE Flavor = '" + flavor + "'";

	    // Step 3: (omitted in this example) Start transaction
	    
	    try (Statement stmt = conn.createStatement()) {
		
		// Step 4: Send SQL statement to DBMS
		int rowCount = stmt.executeUpdate(updateSql);
		
		// Step 5: Handle results
		System.out.format("Updated %d records for %s pastries%n", rowCount, flavor);		
	    }

	    // Step 6: (omitted in this example) Commit or rollback transaction
	    
	}
	// Step 7: Close connection (handled implcitly by try-with-resources syntax)

        demo2();
        
    }



    // Demo4 - Establish JDBC connection, execute DML query (UPDATE) using PreparedStatement / transaction    
    private void demo4() throws SQLException {

	// Step 1: Establish connection to RDBMS
	try (Connection conn = DriverManager.getConnection(JDBC_URL,
							   JDBC_USER,
							   JDBC_PASSWORD)) {
	    // Step 2: Construct SQL statement
	    Scanner scanner = new Scanner(System.in);
	    System.out.print("Enter a flavor!!!!: ");
	    String flavor = scanner.nextLine();
	    System.out.format("Until what date will %s be available (YYYY-MM-DD)? ", flavor);
	    LocalDate availDt = LocalDate.parse(scanner.nextLine());
	    
	    String updateSql = "UPDATE hp_goods SET AvailUntil = ? WHERE Flavor = ?";

	    // Step 3: Start transaction
	    conn.setAutoCommit(false);
	    
	    try (PreparedStatement pstmt = conn.prepareStatement(updateSql)) {
		
		// Step 4: Send SQL statement to DBMS
		pstmt.setDate(1, java.sql.Date.valueOf(availDt));
		pstmt.setString(2, flavor);
		int rowCount = pstmt.executeUpdate();
		
		// Step 5: Handle results
		System.out.format("Updated %d records for %s pastries%n", rowCount, flavor);

		// Step 6: Commit or rollback transaction
		conn.commit();
	    } catch (SQLException e) {
		conn.rollback();
	    }

	}
	// Step 7: Close connection (handled implcitly by try-with-resources syntax)
    }




    // Demo5 - Construct a query using PreparedStatement
    private void OLDdemo5() throws SQLException {

	// Step 1: Establish connection to RDBMS
	try (Connection conn = DriverManager.getConnection(JDBC_URL,
							   JDBC_USER,
							   JDBC_PASSWORD)) {
	    Scanner scanner = new Scanner(System.in);
	    System.out.print("Find pastries with price <=: ");
	    Double price = Double.valueOf(scanner.nextLine());
	    System.out.print("Filter by flavor (or 'Any'): ");
	    String flavor = scanner.nextLine();

	    List<Object> params = new ArrayList<Object>();
	    params.add(price);
	    StringBuilder sb = new StringBuilder("SELECT * FROM hp_goods WHERE price <= ?");
	    if (!"any".equalsIgnoreCase(flavor)) {
		sb.append(" AND Flavor = ?");
		params.add(flavor);
	    }
	    
	    try (PreparedStatement pstmt = conn.prepareStatement(sb.toString())) {
		int i = 1;
		for (Object p : params) {
		    pstmt.setObject(i++, p);
		}

		try (ResultSet rs = pstmt.executeQuery()) {
		    System.out.println("Matching Pastries:");
		    int matchCount = 0;
		    while (rs.next()) {
			System.out.format("%s %s ($%.2f) %n", rs.getString("Flavor"), rs.getString("Food"), rs.getDouble("price"));
			matchCount++;
		    }
		    System.out.format("----------------------%nFound %d match%s %n", matchCount, matchCount == 1 ? "" : "es");
		}
	    }

	}
    }  

}

