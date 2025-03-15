USE CollegeDB;
GO

--Scalar Function is similar to Stored Procedure, but it can return any datatype and can be use within a select statment
---- Example 1 ----
---- Create Scalar Function ----
CREATE FUNCTION dbo.GetAverageProfessorSalaryOfDepartment(@DepartmentID INT) RETURNS DECIMAL(10,2) AS
BEGIN
	
	DECLARE @AvgSalary DECIMAL(10,2);

	SELECT @AvgSalary = AVG(Salary) FROM Professors WHERE DepartmentID = @DepartmentID;

	RETURN @AvgSalary;
END;
GO

---- Call Scalar Function ----
--1
SELECT dbo.GetAverageProfessorSalaryOfDepartment(1);
--2
SELECT *, dbo.GetAverageProfessorSalaryOfDepartment(DepartmentID) AS AverageSalary FROM Departments;
GO


---- Example 2 ----
CREATE FUNCTION dbo.CalculateBonus(@Rating INT, @Salary DECIMAL(10,2)) RETURNS DECIMAL(10,2) AS
BEGIN 

	DECLARE @Bonus DECIMAL(10,2);

	IF (@Rating >= 120)
		SET @Bonus = @Salary * 0.05;
	ELSE IF (@Rating >= 100)
		SET @Bonus = @Salary * 0.03;
	ELSE IF (@Rating >= 70)
		SET @Bonus = @Salary * 0.02;
	ELSE IF (@Rating >= 40)
		SET @Bonus = @Salary * 0.01;
	ELSE
		SET @Bonus = @Salary * 0.005;

	RETURN @Bonus;
END;
GO

SELECT ProfessorID, FirstName, PerformanceRating, Salary, dbo.CalculateBonus(PerformanceRating, Salary) AS Bonus
FROM Professors
GO

---- Tabels ----
SELECT * FROM Students;
SELECT * FROM Professors;
SELECT * FROM Departments;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
GO
