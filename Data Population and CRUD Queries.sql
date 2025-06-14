Create Database HotelDB;
Use HotelDB;

CREATE TABLE Hotel (
    Hotel_id INT PRIMARY KEY,
    Location VARCHAR(100),
    Rating DECIMAL(2,1),
    Contact VARCHAR(50)
);

INSERT INTO Hotel VALUES 
(1, 'Islamabad', 4.5, '051-1234567'),
(2, 'Lahore', 4.2, '042-7654321');

CREATE TABLE Type (
    Type_id INT PRIMARY KEY,
    Description VARCHAR(50),
    Capacity INT,
    Price DECIMAL(10,2)
);

INSERT INTO Type VALUES 
(1, 'Single Room', 1, 3500.00),
(2, 'Double Room', 2, 5000.00),
(3, 'Suite', 4, 10000.00);

CREATE TABLE Room (
    Room_id INT PRIMARY KEY,
    Hotel_id INT,
    Type_id INT,
    Status VARCHAR(20),
    FOREIGN KEY (Hotel_id) REFERENCES Hotel(Hotel_id),
    FOREIGN KEY (Type_id) REFERENCES Type(Type_id)
);

INSERT INTO Room VALUES 
(101, 1, 1, 'Available'),
(102, 1, 2, 'Occupied'),
(201, 2, 3, 'Maintenance');

CREATE TABLE Employee (
    Emp_id INT PRIMARY KEY,
    Hotel_id INT,
    Name VARCHAR(50),
    Contact VARCHAR(50),
    Role VARCHAR(30),
    FOREIGN KEY (Hotel_id) REFERENCES Hotel(Hotel_id)
);

INSERT INTO Employee VALUES 
(1, 1, 'Ali Raza', '03001234567', 'Manager'),
(2, 2, 'Ayesha Khan', '03211234567', 'Receptionist'),
(3, 1, 'Bilal Ahmed', '03451234567', 'Cleaner'),
(4, 1, 'Ali Raza', '03001234567', 'Receptionist'),
(5, 1, 'Sana Khan', '03019876543', 'Manager'),
(6, 2, 'Usman Tariq', '03211223344', 'Housekeeping'),
(7, 1, 'Ayesha Malik', '03112233445', 'Chef'),
(8, 2, 'Hamza Sheikh', '03452341234', 'Receptionist'),
(9, 2, 'Nimra Ahmed', '03331234567', 'Security'),
(10, 1, 'Bilal Arshad', '03004567891', 'IT Support'),
(11, 2, 'Fatima Zahra', '03216549874', 'Accountant'),
(12, 2, 'Hassan Nawaz', '03007894561', 'Manager'),
(13, 2, 'Zainab Iqbal', '03451239876', 'HR Assistant');

UPDATE Employee
SET Name = 'Usman Ghani',
    Contact = '03111234567',
    Role = 'Supervisor'
WHERE Emp_id = 6;

CREATE TABLE Login (
    Login_id INT PRIMARY KEY,
    Emp_id INT,
    Password VARCHAR(255),
    FOREIGN KEY (Emp_id) REFERENCES Employee(Emp_id)
);

INSERT INTO Login VALUES 
(101, 1, 'ali123'),
(102, 2, 'ayesha321'),
(103, 3, 'bilal111'),
(104, 5, 'sana456'),
(105, 6, 'usman789'),
(106, 8, 'hamza321'),
(107, 9, 'nimra654'),
(108, 11, 'fatima987'),
(109, 12, 'hassan147'),
(110, 13, 'zainab369');

UPDATE Login
SET Password = 'usman123'
WHERE Emp_id = 6;

DELETE FROM Login
WHERE Emp_id = 8;

CREATE TABLE History (
    H_id INT IDENTITY(1,1) PRIMARY KEY,
    Login_id INT FOREIGN KEY REFERENCES Login(Login_id),
    Time TIME,
    Date DATE
);

CREATE TABLE Guest (
    Guest_id INT PRIMARY KEY,
    Service_id INT,
    Name VARCHAR(50),
    Contact VARCHAR(50),
    National_id VARCHAR(20),
    FOREIGN KEY (Service_id) REFERENCES Service(Service_id)
);

CREATE TABLE Service (
    Service_id INT PRIMARY KEY,
    Name VARCHAR(50),
    Description TEXT,
    Price DECIMAL(10,2)
);

INSERT INTO Service VALUES 
(1, 'Laundry', 'Full clothes washing and ironing', 300.00),
(2, 'Room Service', 'Food and drinks delivery', 150.00),
(3, 'WiFi', 'High speed internet access', 100.00);

INSERT INTO Guest VALUES 
(201, 1, 'Zain Ul Abideen', '03011234567', '35201-1234567-1'),
(202, 2, 'Maria Bukhari', '03121234567', '35202-7654321-2'),
(203, NULL, 'Hamza Shah', '03451234567', '35203-1122334-5');

CREATE TABLE Feedback (
    Feedback_id INT PRIMARY KEY,
    Guest_id INT,
    Comments TEXT,
    Rating INT,
    FOREIGN KEY (Guest_id) REFERENCES Guest(Guest_id)
);

INSERT INTO Feedback VALUES 
(1, 201, 'Great service!', 5),
(2, 202, 'Room was clean but noisy.', 3),
(3, 203, NULL, 4);

CREATE TABLE Invoice (
    Invoice_id INT PRIMARY KEY,
    Issued_date DATE,
    Amount DECIMAL(10,2),
    Status VARCHAR(20)
);

INSERT INTO Invoice VALUES 
(301, '2025-06-01', 8500.00, 'Paid'),
(302, '2025-06-10', 12000.00, 'Unpaid'),
(303, '2025-06-12', NULL, 'Pending');

CREATE TABLE Reservation (
    Reservation_id INT PRIMARY KEY,
    Guest_id INT,
    Invoice_id INT,
    Room_id INT,
    Status VARCHAR(20),
    FOREIGN KEY (Guest_id) REFERENCES Guest(Guest_id),
    FOREIGN KEY (Invoice_id) REFERENCES Invoice(Invoice_id),
    FOREIGN KEY (Room_id) REFERENCES Room(Room_id)
);

INSERT INTO Reservation VALUES 
(401, 201, 301, 101, 'Confirmed'),
(402, 202, 302, 102, 'Pending'),
(403, 203, 303, 201, 'Cancelled');

CREATE TABLE Payment (
    Pay_id INT PRIMARY KEY,
    Invoice_id INT,
    Pay_date DATE,
    Method VARCHAR(20),
    FOREIGN KEY (Invoice_id) REFERENCES Invoice(Invoice_id)
);

INSERT INTO Payment VALUES 
(501, 301, '2025-06-02', 'Cash'),
(502, 302, NULL, 'Card'),
(503, 303, '2025-06-12', 'Online');

CREATE PROCEDURE Login_User
    @user_id INT,
    @user_pass VARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1 FROM Login WHERE Login_id = @user_id AND Password = @user_pass
    )
    BEGIN
        INSERT INTO History (Login_id, Time, Date)
        VALUES (@user_id, CAST(GETDATE() AS TIME), CAST(GETDATE() AS DATE));
    END
END;



EXEC Login_User @user_id = 101, @user_pass = 'ali123';
SELECT * FROM History;

SELECT 
    g.Name AS GuestName,
    g.Contact AS GuestContact,
    r.Reservation_id,
    rm.Room_id,
    h.Location AS HotelLocation,
    r.Status AS ReservationStatus
FROM Guest g
JOIN Reservation r ON g.Guest_id = r.Guest_id
JOIN Room rm ON r.Room_id = rm.Room_id
JOIN Hotel h ON rm.Hotel_id = h.Hotel_id;


SELECT 
    e.Emp_id,
    e.Name AS EmployeeName,
    e.Contact,
    e.Role,
    h.Location AS HotelLocation,
    l.Login_id
FROM Employee e
JOIN Hotel h ON e.Hotel_id = h.Hotel_id
JOIN Login l ON e.Emp_id = l.Emp_id;


SELECT 
    g.Name AS GuestName,
    s.Name AS ServiceName,
    s.Price
FROM Guest g
JOIN Service s ON g.Service_id = s.Service_id;

SELECT 
    g.Name AS GuestName,
    r.Reservation_id,
    r.Status
FROM Guest g
INNER JOIN Reservation r ON g.Guest_id = r.Guest_id;
