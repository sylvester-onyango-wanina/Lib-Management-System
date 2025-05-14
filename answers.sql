-- SQL for Library Management System

-- 1. Create a database for the Library Management System
CREATE DATABASE LibraryManagement;
USE LibraryManagement;

-- 2. Create the Books table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    ISBN VARCHAR(20) UNIQUE,
    PublicationYear INT,
    Genre VARCHAR(100),
    Quantity INT NOT NULL CHECK (Quantity >= 0)
);

-- 3. Create the Members table
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    MembershipDate DATE NOT NULL
);

-- 4. Create the Checkouts table
CREATE TABLE Checkouts (
    CheckoutID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT,
    BookID INT,
    CheckoutDate DATE NOT NULL,
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    CONSTRAINT chk_return_date CHECK (ReturnDate >= CheckoutDate OR ReturnDate IS NULL)
);

-- 5. Create an Index on Email column of Members for faster search
CREATE INDEX idx_member_email ON Members (Email);

-- 6. Insert sample data for Books table
INSERT INTO Books (Title, Author, ISBN, PublicationYear, Genre, Quantity) VALUES
('To Kill a Mockingbird', 'Harper Lee', '9780061120084', 1960, 'Fiction', 5),
('1984', 'George Orwell', '9780451524935', 1949, 'Dystopian', 3),
('Moby-Dick', 'Herman Melville', '9781503280786', 1851, 'Adventure', 2);

-- 7. Insert sample data for Members table
INSERT INTO Members (FirstName, LastName, Email, Phone, MembershipDate) VALUES
('John', 'Doe', 'john.doe@email.com', '1234567890', '2025-01-15'),
('Jane', 'Smith', 'jane.smith@email.com', '0987654321', '2025-02-20');

-- 8. Insert sample data for Checkouts table
INSERT INTO Checkouts (MemberID, BookID, CheckoutDate, ReturnDate) VALUES
(1, 1, '2025-04-10', '2025-04-20'),
(2, 2, '2025-04-12', NULL);

-- 9. Query to see all data (Join operation to view books borrowed by each member)
SELECT 
    m.FirstName, 
    m.LastName, 
    b.Title AS BookTitle, 
    c.CheckoutDate, 
    c.ReturnDate
FROM Checkouts c
JOIN Members m ON c.MemberID = m.MemberID
JOIN Books b ON c.BookID = b.BookID;
