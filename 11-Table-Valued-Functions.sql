USE CollegeDB;
GO

-- Table-Valued Functions (TVFs) are user-defined functions in T-SQL that return tabular data as a result. They are a powerful feature in SQL Server that can be used to encapsulate complex queries and logic into reusable components. In this lesson, we will explore the concept of TVFs, their types, and how to create and use them in T-SQL.
----- Types:
----- Inline Table-Valued Functions (ITVFs): These functions return a table variable inline and can be used in the FROM clause of a SELECT statement.
----- Multi-Statement Table-Valued Functions (MTVFs): These functions return a table variable using a series of SQL statements and can have multiple SELECT statements within them.
GO

---- Example 1 ----
---- Create Inline Table-Valued Function ----
CREATE FUNCTION dbo.GetProfessorsByDepartmentName(@DepartmentName VARCHAR(100))
RETURNS TABLE AS RETURN
(
	SELECT ProfessorID, FirstName + ' ' + LastName AS FullName , d.DepartmentID, DepartmentName, PerformanceRating, Salary 
	FROM Professors p JOIN Departments d ON d.DepartmentID = p.DepartmentID
	WHERE d.DepartmentName = @DepartmentName
)
GO

---- Call Inline Table-Valued Function ----
SELECT * FROM dbo.GetProfessorsByDepartmentName('Computer Science');
SELECT AVG(Salary) FROM dbo.GetProfessorsByDepartmentName('Physics');
SELECT * FROM dbo.GetProfessorsByDepartmentName('Mathematics')  WHERE PerformanceRating >= 70;
GO


---- Example 2 ----
---- Create Multi-Statement Table-Valued Function ----
CREATE FUNCTION dbo.GetTopPerformingProfessors(@Top INT)
RETURNS @Result TABLE 
(
	ProfessorID INT,
	FullName VARCHAR(100),
	DepartmentName VARCHAR(100),
	PerformanceRating INT
)
AS
BEGIN

	INSERT INTO @Result (ProfessorID, FullName, DepartmentName, PerformanceRating)
	SELECT TOP (@Top) ProfessorID, FirstName + ' ' + LastName AS FullName , DepartmentName, PerformanceRating 
	FROM Professors p JOIN Departments d ON d.DepartmentID = p.DepartmentID
	ORDER BY PerformanceRating DESC;
	RETURN;
END;
GO


---- Call Multi-Statement Table-Valued Function ----
SELECT * FROM dbo.GetTopPerformingProfessors(10);
GO

---- Tabels ----
SELECT * FROM Students;
SELECT * FROM Professors;
SELECT * FROM Departments;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
GO
