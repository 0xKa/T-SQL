USE CollegeDB
GO

--note it is not recommended to use SP_ prefix

---- 1- Getting All Students ----
CREATE PROCEDURE SP_GetAllStudents 
AS
BEGIN
	SELECT * FROM Students;
END;
GO

---- 2- Getting Student By ID ----
CREATE PROCEDURE SP_GetStudentByID(@StudentID INT) AS
BEGIN 
	SELECT * FROM Students WHERE StudentID = @StudentID;
END;
GO

---- 3- Getting Student By ID (2nd way) ----
CREATE PROCEDURE SP_GetStudentByID2(
	@StudentID INT,
	@FirstName NVARCHAR(50) OUTPUT,
	@LastName NVARCHAR(50) OUTPUT,
	@DateOfBirth DATE OUTPUT,
	@Email NVARCHAR(100) OUTPUT,
	@Phone NVARCHAR(15) OUTPUT,
	@Address NVARCHAR(255) OUTPUT,
	@IsFound BIT OUTPUT) AS
BEGIN
	
	IF EXISTS (SELECT 1 FROM Students WHERE StudentID = @StudentID)
	BEGIN
		
		SELECT 
		@FirstName = [FirstName],
		@LastName = [LastName],
		@DateOfBirth = [DateOfBirth],
		@Email = [Email],
		@Phone = [Phone],
		@Address = [Address]
		FROM Students WHERE StudentID = @StudentID;

		SET @IsFound = 1; 
	END;
	ELSE
		SET @IsFound = 0;

END;
GO


---- 4- Adding a Student ----
CREATE PROCEDURE SP_AddNewStudent(
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@DateOfBirth DATE,
	@Email NVARCHAR(100),
	@Phone NVARCHAR(15),
	@Address NVARCHAR(255),
	@NewStudentID INT OUTPUT) AS
BEGIN

	INSERT INTO Students ([FirstName], [LastName], [DateOfBirth], [Email], [Phone], [Address])
    VALUES (@FirstName, @LastName, @DateOfBirth, @Email, @Phone, @Address);

	SET @NewStudentID = SCOPE_IDENTITY();

END; 
GO

---- 5- Update a Student ----
CREATE PROCEDURE SP_UpdateStudent(
	@StudentID INT,
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@DateOfBirth DATE,
	@Email NVARCHAR(100),
	@Phone NVARCHAR(15),
	@Address NVARCHAR(255)) AS
BEGIN
	UPDATE Students 
	SET [FirstName] = @FirstName,
	[LastName] = @LastName,
	[DateOfBirth] = @DateOfBirth,
	[Email] = @Email,
	[Phone] = @Phone,
	[Address] = @Address
	WHERE [StudentID] = @StudentID;
END;
GO

---- 6- Delete a Student ----
CREATE PROCEDURE SP_DeleteStudent(@StudentID INT) AS
BEGIN
	DELETE FROM Students WHERE StudentID = @StudentID;
END;
GO

---- 7- Is Student Exists ----
CREATE PROCEDURE SP_IsStudentExists(@StudentID INT) AS
BEGIN
	IF EXISTS(SELECT 1 FROM Students WHERE StudentID = @StudentID)
		RETURN 1;
	ELSE
		RETURN 0;
END;
GO


---- Executing Stored Procedures ----
--1
EXEC SP_GetAllStudents;
GO

--2
DECLARE @ID INT = 11;
EXEC SP_GetStudentByID @ID;
GO

--3
DECLARE @ID INT = 11;
DECLARE	@FirstName NVARCHAR(50)
DECLARE	@LastName NVARCHAR(50)
DECLARE	@DateOfBirth DATE
DECLARE	@Email NVARCHAR(100)
DECLARE	@Phone NVARCHAR(15)
DECLARE	@Address NVARCHAR(255)
DECLARE	@IsFound BIT;

EXEC SP_GetStudentByID2 @ID, @FirstName OUTPUT, @LastName OUTPUT, @DateOfBirth OUTPUT, @Email OUTPUT, @Phone OUTPUT, @Address OUTPUT, @IsFound OUTPUT;

IF @IsFound = 1
	SELECT @ID, @FirstName, @LastName, @DateOfBirth, @Email, @Phone, @Address; 
ELSE 
	PRINT  'ID: ' + CAST(@ID AS VARCHAR) + ', Not Found.'

GO

--4
DECLARE @NewID INT;
EXEC SP_AddNewStudent 'reda', 'hilal', '2004-08-06', 'email@1233', '1233', 'earth', @NewID OUTPUT

SELECT * FROM Students WHERE StudentID = @NewID;
GO

--5
DECLARE @ID INT = 21;
EXEC SP_UpdateStudent  @ID, 'ahmed', 'mohammed', '2000-12-12', 'A@A', '13213132', 'mars'; 

SELECT * FROM Students WHERE StudentID = @ID;
GO


--6
DECLARE @ID INT = 6;
EXEC SP_DeleteStudent @ID;
GO

--7
DECLARE @ID INT = 20;
DECLARE @Result INT;
EXEC @Result = SP_IsStudentExists @ID;

SELECT @Result;
GO


---- Tabels ----
SELECT * FROM Students;
SELECT * FROM Professors;
SELECT * FROM Departments;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
GO

--basics: 
--to create stored procedure: CREATE PROCEDURE SP_name
--to delete stored procedure: DROP PROCEDURE SP_name
--to modify stored procedure: ALTER PROCEDURE SP_name
--to xecute stored procedure: EXCE SP_name


---- SP_HELPTEXT ----
--The sp_helptext command in SQL Server is a system stored procedure that is used to retrieve the text definition of a stored procedure, function, trigger, view, or user-defined function in a SQL Server database. It is a useful tool for developers and database administrators to examine the source code or the SQL statements within these database objects. Here's a lesson on how to use the sp_helptext command

EXEC sp_helptext 'SP_AddNewStudent';
EXEC sp_helptext 'SP_UpdateStudent';
EXEC sp_helptext 'SP_GetAllStudents';
