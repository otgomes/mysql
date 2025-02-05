-- The system must create the following tables:

-- Table "hotel":
-- hotel_id (Primary key, INT): Unique hotel identifier.
-- hotel_name (VARCHAR, not null): Hotel name.
-- city (VARCHAR, not null): City where the hotel is located.
-- uf (VARCHAR, not null): Country where the hotel is located, with two digits.
-- classification (INT, not null): Hotel classification in stars (1 to 5).

-- Table "room":
-- room_id (Primary key, INT): Unique room identifier.
-- hotel_id (Foreign key not null for "hotel"): Hotel identifier which the room belongs.
-- room_number (INT, not null): Room number.
-- room_type (VARCHAR, not null): Room type (for example, "Standard", "Deluxe", "Suite").
-- daily_price (DECIMAL, not null): Daily room price.

-- Table "clients":
-- client_id (Primary key, INT): Unique client identifier.
-- name (VARCHAR, not null): Client name.
-- email (VARCHAR, unique and not null): client email adress.
-- phone (VARCHAR, not null): Client phone number.
-- ssn (VARCHAR, unique and not null): Client social security number.

-- Table "hosting":
-- hosting_id (Primary key, INT): Unique hosting identifier.
-- client_id (Foreign key and not null for "client"): Identifier of the customer who made the booking.
-- room_id (Foreign key and not null for "room"): Booked room identifier.
-- checkin_date (DATE): Hosting check-in date (not null).
-- checkout_date (DATE): Hosting check-out date (not null).
-- total_host_cost(FLOAT, not null): Total hosting cost, calculating when hosting is finished.
/* host_status (VARCHAR, not null): host_status of hosting, being able to receive the following values: “reserved”, reserved by the customer; “finished”,
hosting completed; “hosted”, the client is currently staying at the hotel; “canceled”, the accommodation (reserved) has been canceled.*/

-- ======================================== For this project map you must create a SQL code ========================================

-- 1. Create the database schema for the hotel management and accommodation system named “hotel_db”.
create database hotel_db;
use hotel_db;

-- 2. Create the tables “hotel”, “room”, “clients” and “hosting” with the columns previously specified.
create table hotel (
hotel_id INT AUTO_INCREMENT PRIMARY KEY,
hotel_name VARCHAR(255) NOT NULL,
hotel_city VARCHAR(255) NOT NULL,
hotel_fu VARCHAR(2) NOT NULL,
classification INT NOT NULL CHECK (classification >=1 AND classification <=5)
);

create table room (
room_id INT AUTO_INCREMENT PRIMARY KEY,
hotel_id INT NOT NULL,
room_number INT NOT NULL,
room_type VARCHAR(50) NOT NULL,
daily_price DECIMAL NOT NULL,
FOREIGN KEY (hotel_id) references hotel(hotel_id)
);

create table clients (
client_id INT AUTO_INCREMENT PRIMARY KEY,
client_name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
phone VARCHAR(20) NOT NULL,
ssn VARCHAR(14) UNIQUE NOT NULL
);

create table hosting (
hosting_id INT AUTO_INCREMENT PRIMARY KEY,
client_id INT NOT NULL,
room_id INT NOT NULL,
checkin_date DATE NOT NULL,
checkout_date DATE NOT NULL,
total_host_cost FLOAT NOT NULL,
host_status ENUM ('reserved', 'finished', 'hosted', 'canceled') NOT NULL,
FOREIGN KEY (client_id) references clients(client_id),
FOREIGN KEY (room_id) references room(room_id)
);

/* 3. Insert artificial data into the tables “hotel” (2 hotels), “room” (5 for each hotel), “clients” (3 clients) and “hosting”
 (20 accommodations, 5 for each of the “host_status”) to simulate hotels, rooms, clients and hosting.*/
insert into hotel (hotel_name, city, fu, classification) values
	('Hotel X', 'City X', 'CA', 2),
	('Hotel Y', 'City Y', 'NY', 5);
    
insert into room (hotel_id, room_number, room_type, daily_price) values
	(1, 101, 'Standard', 110.00),
    (1, 102, 'Suite', 220.00),
    (1, 103, 'Deluxe', 330.00),
    (1, 104, 'Suite', 220.00),
    (1, 105, 'Standard', 110.00),
    (2, 201, 'Suite', 560.00),
    (2, 202, 'Standard', 340.00),
    (2, 203, 'Deluxe', 790.00),
    (2, 204, 'Deluxe', 790.00),
    (2, 205, 'Suite', 560.00);
    
insert into clients (client_name, email, phone, ssn) values
	('Client 1', 'client1@mysql.com', '(16) 0000-0010', '111.111.111-01'),
    ('Client 2', 'client2@mysql.com', '(16) 0000-0020', '222.222.222-02'),
    ('Client 3', 'client3@mysql.com', '(16) 0000-0030', '333.333.333-03');
    
insert into hosting (client_id, room_id, checkin_date, checkout_date, total_host_cost, host_status) values
    (1, 1, '2025-01-25', '2025-01-26', 220.00, 'reserved'),
    (3, 9, '2025-01-02', '2025-01-03', 320.00, 'finished'),
    (1, 4, '2025-01-25', '2025-01-28', 320.00, 'finished'),
    (2, 7, '2025-01-12', '2025-01-13', 640.00, 'reserved'),
    (3, 5, '2025-01-27', '2025-01-28', 830.00, 'reserved'),
    (2, 6, '2025-01-14', '2025-01-18', 670.00, 'hosted'),
    (3, 1, '2025-01-01', '2025-01-06', 1280.00, 'canceled'),
    (1, 10, '2025-01-12', '2025-01-15', 720.00, 'hosted'),
    (1, 3, '2025-01-17', '2025-01-22', 170.00, 'canceled'),
    (2, 8, '2025-01-21', '2025-01-24', 910.00, 'finished'),
    (3, 5, '2025-01-04', '2025-01-12', 2080.00, 'hosted'),
    (1, 4, '2025-01-23', '2025-01-26', 440.00, 'reserved'),
    (2, 9, '2025-01-27', '2025-01-28', 340.00, 'canceled'),
    (2, 9, '2025-01-17', '2025-01-28', 3410.00, 'finished'),
    (1, 4, '2025-01-11', '2025-01-13', 460.00, 'canceled'),
    (1, 3, '2025-01-05', '2025-01-09', 1090.00, 'hosted'),
    (3, 2, '2025-01-13', '2025-01-19', 840.00, 'reserved'),
    (2, 4, '2025-01-10', '2025-01-12', 470.00, 'finished'),
    (3, 10, '2025-01-09', '2025-01-11', 720.00, 'canceled'),
    (2, 2, '2025-01-05', '2025-01-10', 1360.00, 'hosted');

-- 4. Write the following queries and SQL commands:
-- 	a. List all hotels and their respective rooms, presenting the following fields: for hotel, name and city; for room, type and daily_price;
SELECT
    h.hotel_name,
    h.hotel_city,
    q.room_type,
    q.daily_price,
    q.room_number
FROM hotel h
INNER JOIN room q on h.hotel_id = q.hotel_id;

-- 	b. ​List all customers who have already booked accommodations (host_status equal to “finished”), and their respective rooms and hotels;
SELECT
    c.client_name,
    r.room_number,
    h.hotel_name,
    h.hotel_city
FROM clients c
JOIN hosting hos on c.client_id = hos.client_id
JOIN room r on hos.room_id = r.room_id
JOIN hotel h on r.hotel_id = h.hotel_id
WHERE hos.host_status = 'finished';

-- 	c. ​Show the history of accommodations in chronological order for a given customer;
SELECT h.hotel_name, h.hotel_city, r.room_number, hos.checkin_date, hos.checkout_date, hos.total_host_cost, hos.host_status
FROM clients c
JOIN hosting hos on c.client_id = hos.client_id
JOIN room r on r.room_id = hos.room_id
JOIN hotel h on r.hotel_id = h.hotel_id
WHERE c.client_id = 3
ORDER BY hos.checkin_date;

-- 	d. ​Show the customer with the highest number of stays (regardless of the length of time they stayed);
SELECT c.client_name, count(hos.hosting_id) as total_stays
FROM clients c
JOIN hosting hos on c.client_id = hos.client_id
GROUP BY c.client_id
ORDER BY total_stays desc

-- 	e. ​Show customers who had their stays “canceled”, their respective rooms and hotels.
SELECT c.client_name, r.room_number, r.room_type, h.hotel_name, h.hotel_city
FROM clients c
JOIN hosting hos on c.client_id = hos.client_id
JOIN room r on hos.room_id = r.room_id
JOIN hotel h on r.hotel_id = h.hotel_id
WHERE hos.host_status = 'canceled';

-- 	f. ​Calculate the revenue for all hotels (stays with hosp_status equal to “finished”), sorted in descending order.
SELECT h.hotel_name, sum(total_host_cost) as revenue
FROM hotel h
JOIN room r on h.hotel_id = r.hotel_id
JOIN hosting hos on hos.room_id = r.room_id
WHERE hos.host_status = 'finished'
GROUP BY h.hotel_id
ORDER BY revenue desc;

-- 	g. ​List all customers who have already booked a reservation at a specific hotel.
SELECT DISTINCT c.client_name
FROM clients c
JOIN hosting hos on c.client_id = hos.client_id
JOIN room r on r.room_id = hos.room_id
WHERE r.hotel_id = 1;

-- 	h. ​List how much each customer spent on accommodations (hosp_status equal to “finished”), in descending order by amount spent.
SELECT c.client_name, sum(hos.total_host_cost) as total_spent
FROM clients c
JOIN hosting hos on c.client_id = hos.client_id
WHERE hos.host_status = 'finished'
GROUP BY c.client_id
ORDER BY total_spent desc;

-- 	i. ​List all rooms that have not yet received guests.
SELECT r.room_number, r.room_type
FROM room r
LEFT JOIN hosting hos on r.room_id = hos.room_id
WHERE hos.hosting_id is null;

-- 	j. ​Show the average daily rates for all hotels, by room type. 
SELECT h.hotel_name, r.room_type, avg(r.daily_price) as avg_daily_price
FROM room r, hotel h
GROUP BY r.room_type, h.hotel_id;

/*  k. ​Create the checkin_completed column of the boolean type in the hosting table (via code). Assign true to hostings with “finished” and “hosted” (hosted)
status, and false to Accommodations with “reserved” and “canceled” (hosted) status.*/
ALTER TABLE hosting
ADD COLUMN checkin_completed BOOLEAN;

UPDATE hosting
SET checkin_completed =
    CASE
        WHEN host_status in ('finished', 'hosted') THEN true
        ELSE false
    END;

-- 	l. ​Change the name of the “classification” column in the Hotel table to “rating” (via code).
ALTER TABLE hotel
CHANGE classification rating INT NOT NULL CHECK (rating >=1 AND rating <=5);
/* Had to drop constraint before change column name as below:
ALTER TABLE hotel
DROP CONSTRAINT  hotel_chk_1;

After dropping the constraint the name was changed with constraint declared as below in same command:
ALTER TABLE hotel
ADD CONSTRAINT hotel_chk_1 CHECK (rating >= 1 AND rating <= 5); */

-- 5. Create the following procedures using PL/MySQL:
/* a. Create a procedure called "CheckinRegister" that accepts host_id and checkin_date as parameters. The procedure should update the check-in date in the "hosting" table and change the host_status to "hosted".​*/
DELIMETER //

CREATE PROCEDURE CheckinRegister(
    host_id_param INT, ckeckin_date_param DATE
)
BEGIN /*update checkin date and host status*/
    UPDATE hosting
    SET checkin_date = ckeckin_date_param, host_status = 'hosted'
    WHERE hosting_id = host_id_param;
END // --end of procedure
DELIMITER;

/* b. Create a procedure called "HostingCalculate" that accepts host_id as a parameter. The procedure should calculate the total value of the accommodation based on the difference in days between check-in and check-out and the daily price of the reserved room. The value should be updated in the total_host_cost column.​*/
DELIMETER //

CREATE PROCEDURE HostingCalculate(
    host_id_param INT
)
BEGIN
    DECLARE daily_price DECIMAL(10,2);
    DECLARE checkin_date DATE;
    DECLARE checkout_date DATE;
    DECLARE total_days INT;
    DECLARE total_cost DECIMAL(10,2);

-- Getting the daily rate and check-in and check-out date
    SELECT r.daily_price, h.checkin_date, h.checkout_date
    INTO daily_price, checkin_date, checkout_date
    FROM hosting hos
    JOIN room r on r.room_id = hos.room_id
    WHERE hos.hosting_id = host_id_param;

-- Calculating the total number of days
    SET total_days = DATEDIFF(checkout_date, checkin_date) + 1;

-- Calculating the hosting total cost
    SET total_cost = daily_price * total_days;

-- Updating the total_host_cost column in hosting table
    UPDATE hosting
    SET total_host_cost = total_cost
    WHERE hosting_id = host_id_param;
END // --end of procedure

DELIMTETER;

/* c. Create a procedure called "CheckoutRegister" that accepts host_id and checkout_date as parameters. The procedure should update the check-out date in the "hosting" table and change the host_status to "finished".*/
DELIMETER //

CREATE PROCEDURE CheckoutRegister(
    host_id_param INT,
    checkout_date_param DATE
)
BEGIN
    UPDATE hosting
    SET checkout_date = checkout_date_param, host_status = 'finished'
    WHERE hosting_id = host_id_param;
END // --end of procedure

DELIMTETER;

-- 6. Create the following functions using PL/MySQL:

-- a. Create a function called "HotelTotalHosting" that accepts hotel_id as a parameter. The function should return the total number of stays made in a given hotel.​
DELIMITER //
CREATE FUNCTION HotelTotalHosting(
    hotel_id_param INT
) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total_host INT;

-- Calculatin the total amount of hotel hosting
    SELECT count(*)
    INTO total_host
    FROM hosting hos
    JOIN room r on r.room_id = hos.room_id
    WHERE r.hotel_id = hotel_id_param;

    RETURN total_host;
END // --end of function

DELIMITER;

/* b. Create a function called "HotelAverageDailyCost" that accepts hotel_id as a parameter. The function should calculate and return the average daily cost 
of the rooms in this hotel.*/
DELIMITER //
CREATE FUNCTION HotelAverageDailyCost(
    hotel_id_param INT
) RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE daily_average DECIMAL(10,2);

-- Calculating average daily cost from hotel rooms
    SELECT avg(daily_price)
    INTO daily_average
    FROM room
    WHERE hotel_id = hotel_id_param;

    RETURN daily_average;
END// --end of function

DELIMITER;

/* c. Create a function called "VerifyRoomAvailability" that accepts room_id and date as parameters. The function should return a boolean value indicating whether or not the room is available for reservation on the specified date.​*/
DELIMITER //
CREATE FUNCTION VerifyRoomAvailability(
    room_id_param INT,
    date_param DATE
) RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE room_availability INT;

-- Verifying room availability in a specific date
    SELECT count(*)
    INTO room_availability
    FROM hosting
    WHERE room_id = room_id_param
    AND date_param BETWEEN checkin_date AND checkout_date;

    RETURN room_availability = 0;
END// --end of function

DELIMITER;

-- 7. Create the following triggers using PL/MySQL:

/* a. Create a trigger called "BeforeInsertingAccommodation" that is triggered before an insertion into the "hosting" table. The trigger should check if the room is available on the check-in date. If it is not, the insertion should be canceled.*/
DELIMITER //
CREATE TRIGGER BeforeInsertingAccomodation
BEFORE INSERT ON hosting
FOR EACH ROW
BEGIN
    DECLARE room_availability boolean;

-- Verify room disponibility on check-in date_param
    SELECT NOT EXISTS(
        SELECT 1
        FROM hosting
        WHERE room_id = NEW.room_id
        AND NEW.checkin_date between checkin_date and checkout_date
    ) INTO room_availability;

-- If the room is not available, cancel insertion
    IF NOT room_availability THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The room is not available on check-in date.';
    END IF;
END // --end of trigger

DELIMITER;

/* b. Create a trigger called "AfterDeletingCustomer" that is triggered after a customer is deleted from the "Customer" table. The trigger should record the deletion in a log table.*/
DELIMITER //
CREATE TRIGGER AfterDeletingCustomer
AFTER DELETE ON clients
FOR EACH ROW
BEGIN

-- Inserting excluding register into log table
    INSERT INTO client_log (client_id, client_name, email, phone, ssn, delete_date)
    VALUES (OLD.client_id, OLD.client_name, OLD.email, OLD.phone, OLD.ssn, NOW());
END // --end of trigger

DELIMITER;