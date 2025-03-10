USE CollegeDB;
GO

---- Variables ----
DECLARE @StudentName VARCHAR(50);
SELECT @StudentName = FirstName FROM Students WHERE FirstName = 'John';

PRINT '--------------------------------------';
PRINT  'Student Name: ' + @StudentName;
PRINT '--------------------------------------';
GO

---- IF Statement ----
DECLARE @X INT = 150;
DECLARE @Y INT = 150;

IF (@X > @Y)
	BEGIN 
		PRINT('X = ' + CAST(@X AS VARCHAR))
		PRINT('Y = ' + CAST(@Y AS VARCHAR))
		PRINT('X is Bigger than Y');
		END;
ELSE IF (@X < @Y)
	BEGIN
		PRINT('X = ' + CAST(@X AS VARCHAR))
		PRINT('Y = ' + CAST(@Y AS VARCHAR))
		PRINT('Y is Bigger than X');		
		END;
ELSE 
	BEGIN
		PRINT('X = ' + CAST(@X AS VARCHAR))
		PRINT('Y = ' + CAST(@Y AS VARCHAR))
		PRINT('X is Equal to Y');		
		END;

GO
---- Error Handling with @@ERROR ----
INSERT INTO Courses VALUES ('xyz', 0, 0, 0);
GO
DECLARE @ErrorValue INT = @@ERROR;

IF @ErrorValue <> 0
	PRINT 'Error Number = ' + CAST(@ErrorValue AS VARCHAR);

GO
---- Using IF with EXISTS ----
DECLARE @CourseName VARCHAR(50) = 'C++ Programming'
IF EXISTS (SELECT * FROM Courses WHERE CourseName = @CourseName)
	PRINT @CourseName + ' Course Exists.'
ELSE
	PRINT @CourseName + ' Course Does not Exists.'


GO
---- CASE STATEMENT (note: case statement always return a field) ----
--using Simple Case Statement
SELECT *,
	CASE Grade
		WHEN 'A' THEN 'Excellent'
		WHEN 'B' THEN  'Very Good'
		WHEN 'C' THEN  'Good'
		WHEN 'D' THEN  'Bad'
		WHEN 'E' THEN  'Very Bad'
		ELSE 'Fail'
		END AS 'Grade Description'
FROM Enrollments;

--using Searched Case Statement
SELECT *,
	CASE 
		WHEN Grade = 'A' THEN 'Excellent'
		WHEN Grade = 'B' THEN  'Very Good'
		WHEN Grade = 'C' THEN  'Good'
		WHEN Grade = 'D' THEN  'Bad'
		WHEN Grade = 'E' THEN  'Very Bad'
		ELSE 'Fail'
		END AS 'Grade Description'
FROM Enrollments;
GO
---- Using CASE in ORDER BY (Custom Sorting) ----
SELECT * FROM Courses
ORDER BY 
	CASE 
		WHEN DepartmentID = 4 THEN 1
		WHEN Credits >= 50 THEN 2
		ELSE 3
		END;
--explaination: the numbers 1,2,3 represents the order priority.

SELECT * FROM Courses ORDER BY
	CASE
		WHEN Credits >= 70 THEN 1
		ELSE 2
		END, 
		DepartmentID DESC;
--explaination: similar to example1, but it order by the CASE statemnt then DepartmentID column.

GO
---- CASE in UPDATE Statements ----
UPDATE Professors
SET Salary = 
	CASE 
		WHEN PerformanceRating >= 100 THEN Salary * 1.25
		WHEN PerformanceRating >= 50 THEN Salary * 1.10
		WHEN PerformanceRating BETWEEN 10 AND 40 THEN Salary * 0.95
		WHEN PerformanceRating < 10 THEN Salary * 0.85
		END;

GO
---- Neasted CASE Statements ----
UPDATE Professors
SET Salary = 
	CASE DepartmentID
		WHEN 1 THEN
			CASE
				WHEN PerformanceRating >= 100 THEN Salary * 1.35
				WHEN PerformanceRating >= 50 THEN Salary * 1.10
				WHEN PerformanceRating BETWEEN 10 AND 40 THEN Salary * 0.95
				WHEN PerformanceRating < 10 THEN Salary * 0.85
			END
		WHEN 2 THEN 
			CASE
				WHEN PerformanceRating >= 100 THEN Salary * 1.10
				WHEN PerformanceRating >= 50 THEN Salary * 1.05
				WHEN PerformanceRating BETWEEN 10 AND 40 THEN Salary * 0.80
				WHEN PerformanceRating < 10 THEN Salary * 0.70
			END
		WHEN 3 THEN 
			CASE
				WHEN PerformanceRating >= 100 THEN Salary * 1.50
				WHEN PerformanceRating >= 50 THEN Salary * 1.35
				WHEN PerformanceRating BETWEEN 10 AND 40 THEN Salary * 0.90
				WHEN PerformanceRating < 10 THEN Salary * 0.60
			END
		ELSE Salary
	END;
GO
---- CASE statement within a GROUP BY ----
SELECT Difficulty, COUNT(*) AS NumberOfCourses
FROM
	(SELECT CourseName, Credits,
		CASE  
			WHEN Credits >= 100 THEN 'Very Hard'
			WHEN Credits >= 70 THEN 'Hard'
			WHEN Credits BETWEEN 40 AND 69 THEN 'Medium'
			ELSE 'Easy'
		END AS Difficulty FROM Courses) AS DifficultyTable
GROUP BY Difficulty ORDER BY Difficulty DESC

SELECT SalaryDescription, COUNT(*) AS NumberOfProfessors, AVG(Salary) AS AverageSalary
FROM
	(SELECT 
	FirstName + ' ' + LastName AS FullName,
	Salary,
	CASE
		WHEN Salary >= 1200 THEN 'High'
		WHEN Salary >= 1000 THEN 'Medium'
		ELSE 'Low'
	END AS SalaryDescription
	FROM Professors) AS SalaryTable
GROUP BY SalaryDescription

GO
---- TABLES ----
SELECT * FROM Courses;
SELECT * FROM Departments;
SELECT * FROM Enrollments;
SELECT * FROM Professors;
SELECT * FROM Students;

GO
--/Introduction to T-SQL
--What is T-SQL?
--T-SQL, or Transact-SQL, is an extension of SQL (Structured Query Language) developed by Microsoft. It's used primarily in Microsoft SQL Server and Azure SQL Database. T-SQL not only supports the standard SQL commands for database interaction but also introduces several additional features tailored to Microsoft's database platforms.

--Transact-SQL (T-SQL) is a programming language used to manage and manipulate relational databases. It is a proprietary language developed by Microsoft and is the primary language used for programming Microsoft SQL Server.
--T-SQL is an extension of the SQL (Structured Query Language) standard and adds additional functionality and control over data and database objects. It supports a wide range of operations including data definition, data manipulation, data control, and data query.
--T-SQL also supports programming constructs such as variables, loops, and conditional statements, making it a powerful tool for database programming and management. Additionally, T-SQL has built-in functions for performing tasks such as string manipulation, mathematical operations, and date and time calculations.
--T-SQL allows the creation of stored procedures and functions, which can improve code reusability, enhance security, and provide better performance. Stored procedures can be precompiled, leading to faster execution, and they can be called from various applications.
--T-SQL supports explicit transaction control using keywords like BEGIN TRANSACTION, COMMIT, and ROLLBACK. This helps ensure data integrity by allowing developers to define and manage transaction boundaries explicitly.
--T-SQL provides robust error-handling mechanisms, allowing developers to catch and handle errors gracefully. TRY...CATCH blocks can be used to encapsulate code where errors may occur, making it easier to identify and address issues.
--T-SQL supports both DML and DDL operations, allowing developers to not only query and manipulate data but also define and modify the structure of the database. This comprehensive support streamlines the development and maintenance of database applications.
--T-SQL provides a range of security features, including the ability to define user roles, grant permissions, and implement encryption. This ensures that data is accessed and modified only by authorized users, contributing to a secure database environment.
--Overall T-SQL is a powerful and versatile language that is widely used in enterprise environments for managing and manipulating relational databases.

--In Oracle there is PL/SQL

--T-SQL (Transact-SQL) and PL/SQL (Procedural Language/SQL) are both extensions of SQL, the standard language for interacting with relational databases. While they share some similarities, they are distinct in several ways, primarily because they are designed for use with different database management systems.

--Database Compatibility
--T-SQL: Primarily used with Microsoft SQL Server.
--PL/SQL: Developed by Oracle Corporation for use with Oracle Database.
--/


