CREATE DATABASE HMS;
USE HMS;



CREATE TABLE Hotel (
    Hotel_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Location VARCHAR(255),
    Contact VARCHAR(50),
    Rating DECIMAL(3,1)
);

CREATE TABLE Staff (
    Staff_id INT PRIMARY KEY,
    Hotel_id INT,
    Name VARCHAR(100),
    Role VARCHAR(50),
    Salary DECIMAL(10,2),
    Shift_Schedule VARCHAR(50),
    FOREIGN KEY (Hotel_id) REFERENCES Hotel(Hotel_id)
);
CREATE TABLE Type (
    Type_id INT PRIMARY KEY,
    Name VARCHAR(50),
    Description VARCHAR(255),
    Capacity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Room (
    Room_id INT PRIMARY KEY,
    Hotel_id INT,
    Type_id INT,
    Status VARCHAR(20),
    FOREIGN KEY (Hotel_id) REFERENCES Hotel(Hotel_id),
    FOREIGN KEY (Type_id) REFERENCES Type(Type_id)
);



CREATE TABLE Guest (
    Guest_id INT PRIMARY KEY,
    Name VARCHAR(100),
    Contact VARCHAR(50),
    Address VARCHAR(255),
    National_id VARCHAR(20)
);

CREATE TABLE Service (
    Service_id INT PRIMARY KEY,
    Service_Type VARCHAR(50),
    Cost DECIMAL(10,2)
);

CREATE TABLE Reservation (
    Reservation_id INT PRIMARY KEY,
    Guest_id INT,
    Room_id INT,
    Service_id INT,
    Check_in_Date DATE,
    Check_out_Date DATE,
    Status VARCHAR(50),
    FOREIGN KEY (Guest_id) REFERENCES Guest(Guest_id),
    FOREIGN KEY (Room_id) REFERENCES Room(Room_id),
    FOREIGN KEY (Service_id) REFERENCES Service(Service_id)
);

CREATE TABLE Invoice (
    Invoice_id INT PRIMARY KEY,
    Reservation_id INT,
    Amount DECIMAL(10,2),
    Issued_Date DATE,
    Status VARCHAR(50),
    FOREIGN KEY (Reservation_id) REFERENCES Reservation(Reservation_id)
);

CREATE TABLE Payment (
    Payment_id INT PRIMARY KEY,
    Invoice_id INT,
    Amount_paid DECIMAL(10,2),
    Payment_method VARCHAR(50),
    Payment_Date DATE,
    FOREIGN KEY (Invoice_id) REFERENCES Invoice(Invoice_id)
);

CREATE TABLE Feedback (
    Feedback_id INT PRIMARY KEY,
    Guest_id INT,
    Comments TEXT,
    Rating DECIMAL(3,1),
    FOREIGN KEY (Guest_id) REFERENCES Guest(Guest_id)
);


INSERT INTO Hotel VALUES 
(1, 'Grand Plaza', 'Islamabad', '051-1234567', 4.5),
(2, 'Ocean View', 'Karachi', '021-9876543', 4.2),
(3, 'Mountain Retreat', 'Murree', '051-7654321', 4.7),
(4, 'City Inn', 'Lahore', '042-1122334', 4.0),
(5, 'Desert Oasis', 'Bahawalpur', '062-3344556', 4.1),
(6, 'Riverside Haven', 'Multan', '061-5566778', 4.6);

INSERT INTO Staff VALUES 
(1, 1, 'Ali Khan', 'Manager', 85000, 'Morning'),
(2, 1, 'Sara Ahmed', 'Receptionist', 45000, 'Evening'),
(3, 2, 'Kamran Iqbal', 'Housekeeping', 40000, 'Morning'),
(4, 3, 'Farhan Malik', 'Chef', 95000, 'Night'),
(5, 4, 'Aisha Noor', 'Security', 55000, 'Night'),
(6, 5, 'Hamza Shaikh', 'Bellboy', 35000, 'Morning');

INSERT INTO Type VALUES 
(1, 'Single', 'Single bed room', 1, 5000),
(2, 'Double', 'Double bed room', 2, 8000),
(3, 'Suite', 'Luxury suite', 4, 15000),
(4, 'Penthouse', 'Top floor penthouse', 6, 25000),
(5, 'Cabana', 'Private beach cabana', 2, 12000),
(6, 'Studio', 'Small studio apartment', 2, 7000);

INSERT INTO Room VALUES 
(1, 1, 1, 'Available'),
(2, 1, 2, 'Occupied'),
(3, 2, 3, 'Available'),
(4, 3, 4, 'Maintenance'),
(5, 4, 5, 'Available'),
(6, 5, 6, 'Occupied');

INSERT INTO Guest VALUES 
(1, 'Usman Tariq', '0301-1234567', 'Islamabad', '42301-1234567-8'),
(2, 'Fatima Shaikh', '0321-7654321', 'Karachi', '42401-7654321-3'),
(3, 'Ahmed Raza', '0333-1122334', 'Lahore', '42501-1122334-5'),
(4, 'Hira Hussain', '0312-5566778', 'Multan', '42601-5566778-6'),
(5, 'Bilal Aslam', '0344-9876543', 'Peshawar', '42701-9876543-7'),
(6, 'Nida Ali', '0300-4455667', 'Quetta', '42801-4455667-9');

INSERT INTO Service VALUES 
(1, 'Room Cleaning', 1500),
(2, 'Laundry', 800),
(3, 'Food Delivery', 2500),
(4, 'Spa', 4000),
(5, 'Gym Access', 2000),
(6, 'Airport Shuttle', 3000);

INSERT INTO Reservation VALUES
(1, 1, 1, 1, '2025-06-10', '2025-06-15', 'Confirmed'),
(2, 2, 2, 2, '2025-06-12', '2025-06-18', 'Confirmed'),
(3, 3, 3, 3, '2025-06-08', '2025-06-14', 'Completed'),
(4, 4, 4, 4, '2025-06-11', '2025-06-16', 'Cancelled'),
(5, 5, 5, 5, '2025-06-09', '2025-06-13', 'Completed'),
(6, 6, 6, 6, '2025-06-07', '2025-06-12', 'Completed');

INSERT INTO Invoice VALUES
(1, 1, 20000, '2025-06-10', 'Paid'),
(2, 2, 32000, '2025-06-12', 'Paid'),
(3, 3, 45000, '2025-06-08', 'Paid'),
(4, 4, 28000, '2025-06-11', 'Cancelled'),
(5, 5, 35000, '2025-06-09', 'Paid'),
(6, 6, 50000, '2025-06-07', 'Paid');

INSERT INTO Payment VALUES
(1, 1, 20000, 'Credit Card', '2025-06-10'),
(2, 2, 32000, 'Bank Transfer', '2025-06-12'),
(3, 3, 45000, 'Cash', '2025-06-08'),
(4, 4, 28000, 'Cancelled', NULL),
(5, 5, 35000, 'Debit Card', '2025-06-09'),
(6, 6, 50000, 'Mobile Payment', '2025-06-07');



INSERT INTO Hotel VALUES (7, 'Skyline Resort', 'Gilgit', '05811-1122334', 4.8);
INSERT INTO Staff VALUES (7, 2, 'Zain Ali', 'Receptionist', 50000, 'Morning');
INSERT INTO Room VALUES (7, 3, 2, 'Available');
INSERT INTO Guest VALUES (7, 'Tariq Hussain', '0345-6789012', 'Rawalpindi', '42305-6789012-3');
INSERT INTO Reservation VALUES (7, 7, 7, 3, '2025-06-15', '2025-06-20', 'Confirmed');
INSERT INTO Invoice VALUES (7, 7, 40000, '2025-06-15', 'Unpaid');
INSERT INTO Payment VALUES (7, 7, 40000, 'Credit Card', '2025-06-16');
INSERT INTO Feedback VALUES (7, 7, 'Great experience, will visit again!', 4.9);

SELECT * FROM Hotel WHERE Location = 'Gilgit';
SELECT * FROM Staff WHERE Hotel_id = 2;
SELECT * FROM Room WHERE Status = 'Available';
SELECT * FROM Guest WHERE Contact = '0345-6789012';
SELECT * FROM Reservation WHERE Status = 'Confirmed';
SELECT * FROM Invoice WHERE Status = 'Unpaid';
SELECT * FROM Payment WHERE Payment_method = 'Credit Card';
SELECT * FROM Feedback WHERE Rating >= 4.5;

UPDATE Hotel SET Rating = 4.9 WHERE Hotel_id = 7;
UPDATE Staff SET Salary = 55000 WHERE Staff_id = 7;
UPDATE Room SET Status = 'Occupied' WHERE Room_id = 7;
UPDATE Guest SET Address = 'Islamabad' WHERE Guest_id = 7;
UPDATE Reservation SET Status = 'Completed' WHERE Reservation_id = 7;
UPDATE Invoice SET Status = 'Paid' WHERE Invoice_id = 7;
UPDATE Payment SET Amount_paid = 45000 WHERE Payment_id = 7;
UPDATE Feedback SET Comments = 'Amazing service and hospitality!' WHERE Feedback_id = 7;

DELETE FROM Hotel WHERE Hotel_id = 7;
DELETE FROM Staff WHERE Staff_id = 7;
DELETE FROM Room WHERE Room_id = 7;
DELETE FROM Guest WHERE Guest_id = 7;
DELETE FROM Reservation WHERE Reservation_id = 7;
DELETE FROM Invoice WHERE Invoice_id = 7;
DELETE FROM Payment WHERE Payment_id = 7;
DELETE FROM Feedback WHERE Feedback_id = 7;
