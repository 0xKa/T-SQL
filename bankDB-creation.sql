-- Create the Bank Database
CREATE DATABASE BankDB;
GO

-- Use the Bank Database
USE BankDB;
GO


-- Customers Table
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(15) NOT NULL,
    Address NVARCHAR(255) NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- Accounts Table
CREATE TABLE Accounts (
    AccountID INT IDENTITY(1000,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    AccountType NVARCHAR(50) CHECK (AccountType IN ('Saving', 'Checking', 'Business')),
    Balance DECIMAL(18,2) DEFAULT 0.00 CHECK (Balance >= 0),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

-- Transactions Table
CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NOT NULL,
    TransactionType NVARCHAR(50) CHECK (TransactionType IN ('Deposit', 'Withdrawal', 'Transfer')),
    Amount DECIMAL(18,2) CHECK (Amount > 0),
    TransactionDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID) ON DELETE CASCADE
);

-- Loans Table
CREATE TABLE Loans (
    LoanID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL,
    LoanAmount DECIMAL(18,2) CHECK (LoanAmount > 0),
    InterestRate DECIMAL(5,2) CHECK (InterestRate > 0),
    LoanTermMonths INT CHECK (LoanTermMonths > 0),
    Status NVARCHAR(20) CHECK (Status IN ('Approved', 'Pending', 'Rejected')),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
);

-- Branches Table
CREATE TABLE Branches (
    BranchID INT IDENTITY(1,1) PRIMARY KEY,
    BranchName NVARCHAR(100) NOT NULL,
    Location NVARCHAR(255) NOT NULL,
    ManagerName NVARCHAR(100) NOT NULL
);

GO

---- INSERT DATA ----
USE BankDB;
GO


-- Insert Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) 
VALUES 
('John', 'Doe', 'john.doe@email.com', '1234567890', '123 Main St, NY'),
('Jane', 'Smith', 'jane.smith@email.com', '9876543210', '456 Elm St, LA'),
('Alice', 'Brown', 'alice.brown@email.com', '5556667777', '789 Oak St, TX');

-- Insert Branches
INSERT INTO Branches (BranchName, Location, ManagerName) 
VALUES 
('Downtown Branch', '100 Bank St, NY', 'Michael Scott'),
('West Side Branch', '200 Finance Rd, LA', 'Pam Beesly');

-- Insert Accounts (Linking them to Customers)
INSERT INTO Accounts (CustomerID, AccountType, Balance) 
VALUES 
(1, 'Saving', 5000.00),
(1, 'Checking', 1200.50),
(2, 'Saving', 7500.75),
(3, 'Business', 25000.00);

-- Insert Transactions
INSERT INTO Transactions (AccountID, TransactionType, Amount) 
VALUES 
(1000, 'Deposit', 200.00),
(1001, 'Withdrawal', 50.00),
(1002, 'Transfer', 300.00),
(1003, 'Deposit', 1000.00);

-- Insert Loans
INSERT INTO Loans (CustomerID, LoanAmount, InterestRate, LoanTermMonths, Status) 
VALUES 
(1, 15000.00, 5.5, 36, 'Approved'),
(2, 10000.00, 6.0, 24, 'Pending'),
(3, 50000.00, 4.5, 60, 'Approved');

GO


