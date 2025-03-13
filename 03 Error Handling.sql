USE CollegeDB;

---- Error Handling Example ----
BEGIN TRY
	INSERT INTO Students VALUES (NULL,'','','','',1); -- error 1 example
	DECLARE @num DECIMAL(10,2) = 1 / 0; --error 2 example

END TRY
BEGIN CATCH
	
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
    PRINT 'Error Message: ' + ERROR_MESSAGE();
    PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR);
    PRINT 'Error State: ' + CAST(ERROR_STATE() AS VARCHAR);
    PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR);
    PRINT 'Error Procedure: ' + CAST(ERROR_Procedure() AS VARCHAR);

END CATCH;
GO
---- THROW Statement (use for custom error) ----  
--error_number: A constant or variable between 50,000 and 2,147,483,647.
--message: The error message text. It should be a string less than 2048 characters.
--state: A constant or variable between 0 and 255. 

DECLARE @DateOfBirth DATE = '2010-08-06';

BEGIN TRY
	
	--check if age less 18
	IF DATEDIFF(YEAR, @DateOfBirth, GETDATE()) - CASE WHEN DATEADD(YEAR, DATEDIFF(YEAR, @DateOfBirth, GETDATE()), @DateOfBirth) > GETDATE() THEN 1 ELSE 0 END < 18
		THROW 51000, 'Student cannot be less than 18 years old. ', 1; --breaks here and goes to CATCH statment
	
	INSERT INTO Students VALUEs ('Reda', 'Hilal', @DateOfBirth, 'reda@hilal.com', '12341234', 'earth' );

END TRY
BEGIN CATCH
	
    PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
    PRINT 'Error Message: ' + ERROR_MESSAGE();
    PRINT 'Error State: ' + CAST(ERROR_STATE() AS VARCHAR);

END CATCH;

GO
---- TABLES ----
SELECT * FROM Courses;
SELECT * FROM Departments;
SELECT * FROM Enrollments;
SELECT * FROM Professors;
SELECT * FROM Students;
GO

---- extra, @@ROWCOUNT ---
SELECT * FROM Students;
PRINT 'Rows Affected: ' + CAST(@@ROWCOUNT AS VARCHAR);
