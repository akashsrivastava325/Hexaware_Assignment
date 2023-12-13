-- Create Vehicle Table
CREATE TABLE Vehicle (
    vehicleID INT PRIMARY KEY,
    make VARCHAR(255),
    model VARCHAR(255),
    year INT,
    dailyRate DECIMAL(10, 2),
    status VARCHAR(20) CHECK (status IN ('available', 'notAvailable')),
    passengerCapacity INT,
    engineCapacity INT
);

-- Create Customer Table
CREATE TABLE Customer (
    customerID INT PRIMARY KEY,
    firstName VARCHAR(255),
    lastName VARCHAR(255),
    email VARCHAR(255),
    phoneNumber VARCHAR(20)
);

-- Create Lease Table
CREATE TABLE Lease (
    leaseID INT PRIMARY KEY,
    vehicleID INT,
    customerID INT,
    startDate DATE,
    endDate DATE,
    type VARCHAR(20) CHECK (type IN ('DailyLease', 'MonthlyLease')),
    FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

-- Create Payment Table
CREATE TABLE Payment (
    paymentID INT PRIMARY KEY,
    leaseID INT,
    paymentDate DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (leaseID) REFERENCES Lease(leaseID)
);


-- Insert data into Vehicle Table
INSERT INTO Vehicle (vehicleID, make, model, year, dailyRate, status, passengerCapacity, engineCapacity)
VALUES
(1, 'Toyota', 'Camry', 2022, 50.00, 'available', 4, 1450),
(2, 'Honda', 'Civic', 2023, 45.00, 'available', 7, 1500),
(3, 'Ford', 'Focus', 2022, 48.00, 'notAvailable', 4, 1400),
(4, 'Nissan', 'Altima', 2023, 52.00, 'available', 7, 1200),
(5, 'Chevrolet', 'Malibu', 2022, 47.00, 'available', 4, 1800),
(6, 'Hyundai', 'Sonata', 2023, 49.00, 'notAvailable', 7, 1400),
(7, 'BMW', '3 Series', 2023, 60.00, 'available', 7, 2499),
(8, 'Mercedes', 'C-Class', 2022, 58.00, 'available', 8, 2599),
(9, 'Audi', 'A4', 2022, 55.00, 'notAvailable', 4, 2500),
(10, 'Lexus', 'ES', 2023, 54.00, 'available', 4, 2500);


-- Insert data into Customer Table
INSERT INTO Customer (customerID, firstName, lastName, email, phoneNumber)
VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
(3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
(5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
(6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
(7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
(8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
(9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');



-- Insert data into Lease Table
INSERT INTO Lease (leaseID, vehicleID, customerID, startDate, endDate, type)
VALUES
(1, 1, 1, '2023-01-01', '2023-01-05', 'DailyLease'),
(2, 2, 2, '2023-02-15', '2023-02-28', 'MonthlyLease'),
(3, 3, 3, '2023-03-10', '2023-03-15', 'DailyLease'),
(4, 4, 4, '2023-04-20', '2023-04-30', 'MonthlyLease'),
(5, 5, 5, '2023-05-05', '2023-05-10', 'DailyLease'),
(6, 4, 3, '2023-06-15', '2023-06-30', 'MonthlyLease'),
(7, 7, 7, '2023-07-01', '2023-07-10', 'DailyLease'),
(8, 8, 8, '2023-08-12', '2023-08-15', 'MonthlyLease'),
(9, 3, 3, '2023-09-07', '2023-09-10', 'DailyLease'),
(10, 10, 10, '2023-10-10', '2023-10-31', 'MonthlyLease');


-- Insert data into Payment Table
INSERT INTO Payment (paymentID, leaseID, paymentDate, amount)
VALUES
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00);



-- Update the daily rate for a Mercedes car to 68
UPDATE Vehicle
SET dailyRate = 68
WHERE make = 'Mercedes';

-- Delete a specific customer and all associated leases and payments
DELETE FROM Payment
WHERE leaseID IN (SELECT leaseID FROM Lease WHERE customerID = 3);

DELETE FROM Lease
WHERE customerID = 3;

DELETE FROM Customer
WHERE customerID = 3;

-- Rename the "paymentDate" column in the Payment table to "transactionDate"
EXEC sp_rename 'Payment.paymentDate', 'transactionDate', 'COLUMN';

-- Find a specific customer by email
SELECT * FROM Customer
WHERE email = 'robert@example.com';

-- Get active leases for a specific customer
SELECT * FROM Lease
WHERE customerID = 1
AND GETDATE() BETWEEN startDate AND endDate;

-- Find all payments made by a customer with a specific phone number
SELECT Payment.*
FROM Payment
JOIN Lease ON Payment.leaseID = Lease.leaseID
JOIN Customer ON Lease.customerID = Customer.customerID
WHERE Customer.phoneNumber = '555-555-5555';

-- Calculate the average daily rate of all available cars
SELECT AVG(dailyRate) AS AverageDailyRate
FROM Vehicle
WHERE status = 'available';

-- Find the car with the highest daily rate
SELECT TOP 1 *
FROM Vehicle
ORDER BY dailyRate DESC;

-- Retrieve all cars leased by a specific customer
SELECT Vehicle.*
FROM Vehicle
JOIN Lease ON Vehicle.vehicleID = Lease.vehicleID
WHERE Lease.customerID = 2;

-- Find the details of the most recent lease
SELECT TOP 1 *
FROM Lease
ORDER BY startDate DESC;

-- List all payments made in the year 2023
SELECT *
FROM Payment
WHERE YEAR(transactionDate) = 2023;

-- Retrieve customers who have not made any payments
SELECT *
FROM Customer
WHERE customerID NOT IN (SELECT DISTINCT customerID FROM Payment);

-- Retrieve Car Details and Their Total Payments
SELECT Vehicle.*, ISNULL(SUM(Payment.amount), 0) AS TotalPayments
FROM Vehicle
LEFT JOIN Lease ON Vehicle.vehicleID = Lease.vehicleID
LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID
GROUP BY Vehicle.vehicleID, Vehicle.make, Vehicle.model, Vehicle.year, Vehicle.dailyRate, Vehicle.status, Vehicle.passengerCapacity, Vehicle.engineCapacity;

-- Calculate Total Payments for Each Customer
SELECT Customer.*, ISNULL(SUM(Payment.amount), 0) AS TotalPayments
FROM Customer
LEFT JOIN Lease ON Customer.customerID = Lease.customerID
LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID
GROUP BY Customer.customerID, Customer.firstName, Customer.lastName, Customer.email, Customer.phoneNumber;

-- List Car Details for Each Lease
SELECT Lease.*, Vehicle.*
FROM Lease
JOIN Vehicle ON Lease.vehicleID = Vehicle.vehicleID;

-- Retrieve Details of Active Leases with Customer and Car Information
SELECT Lease.*, Customer.*, Vehicle.*
FROM Lease
JOIN Customer ON Lease.customerID = Customer.customerID
JOIN Vehicle ON Lease.vehicleID = Vehicle.vehicleID
WHERE GETDATE() BETWEEN Lease.startDate AND Lease.endDate;

-- Find the Customer Who Has Spent the Most on Leases
SELECT TOP 1 Customer.*, ISNULL(SUM(Payment.amount), 0) AS TotalPayments
FROM Customer
LEFT JOIN Lease ON Customer.customerID = Lease.customerID
LEFT JOIN Payment ON Lease.leaseID = Payment.leaseID
GROUP BY Customer.customerID, Customer.firstName, Customer.lastName, Customer.email, Customer.phoneNumber
ORDER BY TotalPayments DESC;

-- List All Cars with Their Current Lease Information
SELECT Vehicle.*, Lease.*, Customer.*
FROM Vehicle
LEFT JOIN Lease ON Vehicle.vehicleID = Lease.vehicleID
LEFT JOIN Customer ON Lease.customerID = Customer.customerID;