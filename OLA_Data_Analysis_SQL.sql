CREATE DATABASE Ola;
USE Ola;

CREATE TABLE rides(
Date DATETIME,	
Time TIME,
Booking_ID VARCHAR(20),
Booking_Status VARCHAR(20),
Customer_ID	VARCHAR(20),
Vehicle_Type VARCHAR(50),
Pickup_Location	VARCHAR(50),
Drop_Location VARCHAR(50),
V_TAT VARCHAR(50),
C_TAT VARCHAR(50),
Canceled_Rides_by_Customer VARCHAR(50),
Canceled_Rides_by_Driver VARCHAR(50),
Incomplete_Rides VARCHAR(50),
Incomplete_Rides_Reason	VARCHAR(50),
Booking_Value VARCHAR(50),
Payment_Method	VARCHAR(50),
Ride_Distance INT,
Driver_Ratings VARCHAR(20),
Customer_Rating	VARCHAR(20)

);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Bookings-70000-Rows - July.csv' -- Reads data from the given file path (CSV file).
INTO TABLE rides          -- Inserts the data into the table named 'rides'.
FIELDS TERMINATED BY ','  -- Columns in the file are separated by commas (,)
ENCLOSED BY '"'           -- Columns may be enclosed in double quotes (")
LINES TERMINATED BY '\n'  -- Each row ends with a new line character.
IGNORE 1 ROWS;            -- Skips the first row which usually has column headers.

SELECT COUNT(*) FROM rides;

SELECT * FROM rides LIMIT 10;

-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- 1. Retrieve all successful bookings:
CREATE VIEW Successful_Bookings AS
SELECT * FROM rides
WHERE Booking_Status = "Success";
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- 2. Find the average ride distance for each vehicle type:
CREATE VIEW Average_Ride_Distance_For_Each_Vehicle_Type AS
SELECT Vehicle_Type, AVG(Ride_Distance) AS Avg_Distance
FROM rides
GROUP BY Vehicle_Type;
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- 3. Get the total number of cancelled rides by customers:

CREATE VIEW Cancelled_Rides_By_Customers AS
SELECT COUNT(*) FROM  rides 
WHERE Booking_Status = "Canceled by Customer";
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- 4. List the top 5 customers who booked the highest number of rides:

CREATE VIEW Top_5_Customers AS
SELECT Customer_ID, COUNT(Booking_ID) AS Max_ride
FROM rides
GROUP BY Customer_ID
ORDER BY Max_ride DESC LIMIT 5;
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
CREATE VIEW Rides_Cancelled_By_Drivers_Due_To_P_CR_Issue AS
SELECT COUNT(*) AS Cancelled_Rides FROM rides
WHERE Canceled_Rides_by_Driver = 'Personal & Car related issue';
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
CREATE VIEW Max_Min_Ratings_For_Prime_Sedan_bookings AS
SELECT MAX(Driver_Ratings) AS Max_Rating,
MIN(Driver_Ratings) AS Min_Rating
FROM rides WHERE Vehicle_Type = 'Prime Sedan';
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- 7. Retrieve all rides where payment was made using UPI:
CREATE VIEW UPI_Payments AS
SELECT * FROM rides
WHERE Payment_Method = 'UPI';
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- 8. Find the average customer rating per vehicle type:
CREATE VIEW Avg_Cust_Rating_Per_Vechile_Type AS
SELECT Vehicle_Type, AVG(Customer_Rating) AS Average_Customer_Rating FROM rides
GROUP BY Vehicle_Type;
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- 9. Calculate the total booking value of rides completed successfully:
CREATE VIEW Total_Booking_Completed_Successfully AS
SELECT SUM(Booking_Value) AS Total_Booking_Value FROM rides
WHERE Booking_Status = 'Success';
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
-- 10. List all incomplete rides along with the reason:
CREATE VIEW All_Incomplete_Rides_With_Reasons AS
SELECT  Booking_ID, Incomplete_Rides_Reason
FROM rides
WHERE Incomplete_Rides = 'Yes';
-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------

-- RETRIEVE ALL ANSWERS:-
------------------------------------------------ **
-- Ques_1. Retrieve all successful bookings:
SELECT * FROM Successful_Bookings;
-- Ques2. Find the average ride distance for each vehicle type:
SELECT * FROM Average_Ride_Distance_For_Each_Vehicle_Type;
-- Ques3. Get the total number of cancelled rides by customers:
SELECT * FROM Cancelled_Rides_By_Customers;
-- Ques4. List the top 5 customers who booked the highest number of rides:
SELECT * FROM Top_5_Customers;
-- Ques5. Get the number of rides cancelled by drivers due to personal and car-related issues:
SELECT * FROM Rides_Cancelled_By_Drivers_Due_To_P_CR_Issue;
-- Ques6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT * FROM Max_Min_Ratings_For_Prime_Sedan_bookings;
-- Ques7. Retrieve all rides where payment was made using UPI:
SELECT * FROM UPI_Payments;
-- Ques8. Find the average customer rating per vehicle type:
SELECT * FROM Avg_Cust_Rating_Per_Vechile_Type ;
-- Ques9. Calculate the total booking value of rides completed successfully:
SELECT * FROM Total_Booking_Completed_Successfully;
-- Ques10. List all incomplete rides along with the reason:
SELECT * FROM All_Incomplete_Rides_With_Reasons;