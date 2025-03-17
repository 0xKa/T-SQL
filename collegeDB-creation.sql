-- 1 Create the Database
CREATE DATABASE CollegeDB;
GO

-- 2 Switch to the Database
USE CollegeDB;
GO

-- 3 Create Departments Table
CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName NVARCHAR(100) UNIQUE NOT NULL
);
GO

-- 4 Create Students Table
CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(15) UNIQUE,
    Address NVARCHAR(255)
);
GO

-- 5 Create Courses Table
CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    CourseName NVARCHAR(100) NOT NULL,
    Credits INT NOT NULL CHECK (Credits > 0),
    DepartmentID INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
GO

-- 6 Create Professors Table
CREATE TABLE Professors (
    ProfessorID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(15) UNIQUE,
    DepartmentID INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
GO

-- 7 Create Enrollments Table
CREATE TABLE Enrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE DEFAULT GETDATE(),
    Grade CHAR(2) CHECK (Grade IN ('A', 'B', 'C', 'D', 'F', 'W', NULL)),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID) ON DELETE CASCADE,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);
GO

-------------- Logging Tables --------------

CREATE TABLE StudentsInsertLog(
	LogID INT IDENTITY(1,1) PRIMARY KEY,
	InsertDateTime DATETIME2 DEFAULT GETDATE(),
	StudentID INT,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DateOfBirth DATE,
    Email NVARCHAR(100) ,
    Phone NVARCHAR(15),
    Address NVARCHAR(255)
)
GO

CREATE TABLE StudentsUpdateLog(
	LogID INT IDENTITY(1,1) PRIMARY KEY,
	UpdateDateTime DATETIME2 DEFAULT GETDATE(),
	StudentID INT,
    OldEmail NVARCHAR(100),
    NewEmail NVARCHAR(100),
    OldPhone NVARCHAR(15),
    NewPhone NVARCHAR(15),
    OldAddress NVARCHAR(255),
    NewAddress NVARCHAR(255)
)
GO

CREATE TABLE StudentsDeleteLog(
	LogID INT IDENTITY(1,1) PRIMARY KEY,
	DeleteDateTime DATETIME2 DEFAULT GETDATE(),
	StudentID INT,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DateOfBirth DATE,
    Email NVARCHAR(100) ,
    Phone NVARCHAR(15),
    Address NVARCHAR(255)
)
GO



GO

-------------- views --------------
CREATE VIEW [dbo].[Enrollments_view] AS
(
	SELECT EnrollmentID, s.FirstName, c.CourseName, e.EnrollmentDate, e.Grade FROM Enrollments e 
	JOIN Students s ON s.StudentID = e.StudentID
	JOIN Courses c ON c.CourseID = e.CourseID

)
GO

CREATE VIEW Courses_view AS
(
	SELECT CourseID, CourseName, Credits, DepartmentID, DepartmentName FROM Courses
	JOIN Departments ON Courses.DepartmentID = Departments.DepartmentID

)
GO

-------------- Insert Data --------------
INSERT INTO Departments (DepartmentName) VALUES 
('Computer Science'),
('Mathematics'),
('Physics'),
('Business Administration'),
('English Literature');

INSERT INTO Students (FirstName, LastName, DateOfBirth, Email, Phone, Address) VALUES 
('John', 'Doe', '2002-05-15', 'john.doe@example.com', '1234567890', '123 Elm Street'),
('Alice', 'Smith', '2001-08-22', 'alice.smith@example.com', '1234567891', '456 Oak Street'),
('Michael', 'Brown', '2003-01-10', 'michael.brown@example.com', '1234567892', '789 Pine Street'),
('Sarah', 'Johnson', '2000-12-30', 'sarah.johnson@example.com', '1234567893', '101 Maple Avenue'),
('David', 'Wilson', '2002-07-19', 'david.wilson@example.com', '1234567894', '202 Birch Lane');

INSERT INTO Courses (CourseName, Credits, DepartmentID) VALUES 
('Introduction to Programming', 3, 1),  -- Computer Science
('Database Management Systems', 3, 1),  -- Computer Science
('Calculus I', 4, 2),                   -- Mathematics
('Physics I', 4, 3),                     -- Physics
('Business Ethics', 3, 4);               -- Business Administration

INSERT INTO Professors (FirstName, LastName, Email, Phone, DepartmentID) VALUES 
('Robert', 'Anderson', 'robert.anderson@example.com', '9876543210', 1), -- Computer Science
('Emily', 'Davis', 'emily.davis@example.com', '9876543211', 2),         -- Mathematics
('James', 'White', 'james.white@example.com', '9876543212', 3),        -- Physics
('Laura', 'Harris', 'laura.harris@example.com', '9876543213', 4),      -- Business Administration
('William', 'Clark', 'william.clark@example.com', '9876543214', 5);    -- English Literature

INSERT INTO Enrollments (StudentID, CourseID, EnrollmentDate, Grade) VALUES 
(1, 8, '2024-01-15', 'A'), -- John Doe in "Introduction to Programming"
(32, 9, '2024-01-16', 'B'), -- Alice Smith in "Database Management Systems"
(33, 10, '2024-01-17', 'C'), -- Michael Brown in "Calculus I"
(34, 11, '2024-01-18', 'A'), -- Sarah Johnson in "Physics I"
(4, 12, '2024-01-19', 'B'); -- David Wilson in "Business Ethics"



SELECT * FROM Courses;
SELECT * FROM Departments;
SELECT * FROM Enrollments;
SELECT * FROM Professors;
SELECT * FROM Students;
SELECT * FROM Enrollments_view;
SELECT * FROM Courses_view;