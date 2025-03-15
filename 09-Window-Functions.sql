USE CollegeDB;
GO

---- Aggregate Functions ----
SELECT DepartmentName, 
COUNT(*) AS NumberOfProfessors,
SUM(Professors.PerformanceRating) AS TotalProfessorsRatings,
AVG(Professors.Salary) AS AverageProfessorSalary,
MAX(Professors.Salary) AS MaxProfessorSalary,
MIN(Professors.Salary) AS MinProfessorSalary
FROM Professors
JOIN Departments ON Departments.DepartmentID = Professors.DepartmentID
GROUP BY DepartmentName;
GO

-------- Window Functions --------

---- 1-ROW_NUMBER() ----> [assign a number for each row]
SELECT StudentID, FirstName, DateOfBirth, 
ROW_NUMBER() OVER (ORDER BY [DateOfBirth] DESC) AS RowNum
FROM Students;
GO

---- 2-RANK() ----> [assign a rank for each row based on its specified column value, high value -> high rank] [skip ranks after ties] 
SELECT ProfessorID, FirstName, Salary, PerformanceRating,
RANK() OVER (ORDER BY [PerformanceRating] DESC) AS RatingRank
FROM Professors;
GO

---- 3-DENSE_RANK() ----> [same as RANK(), but doesn't skip ranks after ties.] 
SELECT ProfessorID, FirstName, Salary, PerformanceRating,
DENSE_RANK() OVER (ORDER BY [PerformanceRating] DESC) AS RatingRank
FROM Professors;
GO

---- 4-PARTITION BY ----> [used to partition records] 
SELECT ProfessorID, FirstName, Salary, DepartmentName, PerformanceRating,
DENSE_RANK() OVER (PARTITION BY [DepartmentName] ORDER BY [PerformanceRating] DESC) AS RatingRank
FROM Professors JOIN Departments ON Departments.DepartmentID = Professors.DepartmentID;

---- You can user aggregate function with PARTITION BY
SELECT ProfessorID, FirstName, Salary, DepartmentName,
AVG(Salary) OVER (PARTITION BY [DepartmentName]) AS AvgSalaryPerDepartment,
SUM(Salary) OVER (PARTITION BY [DepartmentName]) AS TotalSalaryPerDepartment
FROM Professors JOIN Departments ON Departments.DepartmentID = Professors.DepartmentID;

GO

---- 5-LAG() and LEAD() ----> [Retrieves data from a preceding/following row in the result set.]
SELECT CourseID, CourseName, Credits,
LAG(Credits, 1) OVER (ORDER BY [CourseID] ASC) AS PreviousCredit,
LEAD(Credits, 1) OVER (ORDER BY [CourseID] ASC) AS NextCredit
FROM Courses

GO

---- 6-OFFSET and FETCH NEXT ----
SELECT * FROM Professors ORDER BY ProfessorID
OFFSET 5 ROWS           --skips first 5 records
FETCH NEXT 3 ROWS ONLY;  --gets the next 3 records only after the skip

GO

---- 7-Paging using OFFSET and FETCH NEXT ----
DECLARE @PageNumber INT = 1;
DECLARE @RowsPerPage INT = 5;

SELECT * FROM Professors ORDER BY ProfessorID
OFFSET ((@PageNumber - 1) * @RowsPerPage) ROWS
FETCH NEXT @RowsPerPage ROWS ONLY;

---- Tabels ----
SELECT * FROM Students;
SELECT * FROM Professors;
SELECT * FROM Departments;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
GO

--SQL window functions are functions that perform calculations across a set of rows, known as a window. 
--They allow you to perform calculations such as ranking, row numbering, percent ranking, and more, 
--based on specific criteria within the window.