USE CollegeDB
GO

---- While Syntax ----
DECLARE @Counter INT = 1;
WHILE @Counter <= 5
	BEGIN 
		PRINT 'Counter = ' + CAST (@Counter AS VARCHAR)
		SET @Counter = @Counter + 1
	END;

GO
---- Iterating Over a Table ----
DECLARE @StudentID INT;
SELECT @StudentID = MIN(StudentID) FROM Students;

DECLARE @MaxID INT;
SELECT @MaxID = MAX(StudentID) FROM Students;


DECLARE @FullName VARCHAR(100);
WHILE (@StudentID IS NOT NULL) AND (@StudentID <= @MaxID)
BEGIN
	SELECT @FullName = FirstName + ' ' + LastName FROM Students WHERE StudentID = @StudentID;
	PRINT('ID: ' + CAST(@StudentID AS VARCHAR) + ', Name: ' + @FullName)

	SELECT @StudentID = MIN(StudentID) FROM Students WHERE StudentID > @StudentID;
END;
GO
---- Loop with Conditional Exit ----
DECLARE @Balance DECIMAL(10,2) = 950.00;
DECLARE @WithdrawAmount DECIMAL(10,2) = 100.00;

WHILE @Balance > 0
BEGIN 
	IF (@Balance <= @WithdrawAmount OR @Balance = 0)
	BEGIN
		PRINT 'Balance = ' + CAST(@Balance AS VARCHAR) + ', Insufficient funds for withdrawal.';
		BREAK; --exit loop
	END;

	SET @Balance = @Balance - @WithdrawAmount;
	PRINT 'New Balance = ' + CAST(@Balance AS VARCHAR);
END;

GO
---- Nested While Loops (Multiplication 1 - 10) ----
DECLARE @num1 INT = 1;
DECLARE @num2 INT = 1;

WHILE @num1 <= 10
BEGIN
	
	SET @num2 = 1;
	
	WHILE @num2 <= 10
	BEGIN
		PRINT CAST(@num1 AS VARCHAR) + ' x ' + CAST(@num2 AS VARCHAR) + ' = ' + CAST((@num1 * @num2) AS VARCHAR);
		SET @num2 = @num2 + 1;
	END;

	SET @num1 = @num1 + 1;

END;


GO
---- Nested While Loops (Matrix Multiplication Table 30x30) ----
DECLARE @Row INT = 1;
DECLARE @Col INT = 1;
DECLARE @TopHeader VARCHAR(500) = CHAR(9); --char(9) for Tab
DECLARE @RowString VARCHAR(500); 

--Print RowHeader first
WHILE @Col <= 30
BEGIN
	SET @TopHeader =  @TopHeader + CAST(@Col AS VARCHAR) + CHAR(9); 
	SET @Col = @Col + 1;
END;
PRINT @TopHeader;

--Generate Multiplication table rows
WHILE @Row <= 30
BEGIN
	
	SET @Col = 1;
	SET @RowString = CAST(@Row AS VARCHAR) + CHAR(9);
	
	WHILE @Col <= 30
	BEGIN
		SET @RowString = @RowString + CAST((@Row * @Col) AS VARCHAR) + CHAR(9);
		SET @Col = @Col + 1;
	END;
	
	PRINT @RowString;
	SET @Row = @Row + 1;

END;

GO
---- CONTINUE Statements ----
DECLARE @counter INT = 1;
DECLARE @to INT = 100;

PRINT 'Even Numbers from [' + CAST(@counter AS VARCHAR) + '] to [' + CAST(@to AS VARCHAR) + ']: ';
WHILE (@counter <= @to)
BEGIN
	SET @counter = @counter + 1;
	IF (@counter % 2 <> 0)
		CONTINUE; --skips to the next iteration
		
	PRINT '[' + CAST(@counter AS VARCHAR) + ']'

END;


GO

---- TABLES ----
SELECT * FROM Courses;
SELECT * FROM Departments;
SELECT * FROM Enrollments;
SELECT * FROM Professors;
SELECT * FROM Students;
GO