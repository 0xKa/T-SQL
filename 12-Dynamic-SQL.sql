USE CollegeDB;
GO

-- Dynamic SQL refers to SQL statements that are constructed and executed at runtime as strings. This approach allows for a high degree of flexibility, but it also requires careful handling to avoid issues such as SQL injection.
DECLARE @SQL NVARCHAR(MAX);
SET @SQL = 'SELECT * FROM Courses WHERE Credits >= 70';
PRINT @SQL
EXECUTE(@SQL);
GO

-- Stored procedures in SQL Server can be used to generate and execute dynamic SQL. 
---- Creating Dynamic SQL Stored Procedure
CREATE PROCEDURE dbo.GenerateDynamicSQL (@TableName VARCHAR(255)) AS
BEGIN 

	DECLARE @SQL NVARCHAR(MAX);
	SET @SQL = 'SELECT * FROM ' + @TableName;
	EXECUTE(@SQL) --or use sp_executesql

END
GO

---- Call Procedure ----
EXEC GenerateDynamicSQL 'Students';

---- Tabels ----
SELECT * FROM Students;
SELECT * FROM Professors;
SELECT * FROM Departments;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
GO
