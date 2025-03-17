USE CollegeDB;
GO


---- Satatic Cursor ----
DECLARE static_cursor CURSOR STATIC FOR
SELECT * FROM Professors_view;

OPEN static_cursor; --initialize the cursor

DECLARE @ProfessorID INT, @FullName VARCHAR(100), @DepartmentName VARCHAR(100), @PerformanceRating INT, @Salary DECIMAL(10,2);

FETCH NEXT FROM static_cursor INTO @ProfessorID, @FullName,  @DepartmentName, @PerformanceRating, @Salary;

WHILE @@FETCH_STATUS = 0
BEGIN 

	PRINT CAST(@ProfessorID AS VARCHAR) + ', ' + CAST(@FullName AS VARCHAR) + ', ' + CAST(@DepartmentName AS VARCHAR) + ', ' + CAST(@PerformanceRating AS VARCHAR) + ', ' +CAST(@Salary AS VARCHAR);
	FETCH NEXT FROM static_cursor INTO @ProfessorID, @FullName,  @DepartmentName, @PerformanceRating, @Salary;
	--FETCH PRIOR (to go back)

END;
CLOSE static_cursor;
DEALLOCATE static_cursor;

GO

----  Dynamic Cursor ----
DECLARE dynamic_cursor CURSOR DYNAMIC FOR
SELECT * FROM Professors_view;

OPEN dynamic_cursor; --initialize the cursor

DECLARE @ProfessorID INT, @FullName VARCHAR(100), @DepartmentName VARCHAR(100), @PerformanceRating INT, @Salary DECIMAL(10,2);

FETCH NEXT FROM dynamic_cursor INTO @ProfessorID, @FullName,  @DepartmentName, @PerformanceRating, @Salary;

WHILE @@FETCH_STATUS = 0
BEGIN 

	PRINT CAST(@ProfessorID AS VARCHAR) + ', ' + CAST(@FullName AS VARCHAR) + ', ' + CAST(@DepartmentName AS VARCHAR) + ', ' + CAST(@PerformanceRating AS VARCHAR) + ', ' +CAST(@Salary AS VARCHAR);
	FETCH NEXT FROM dynamic_cursor INTO @ProfessorID, @FullName,  @DepartmentName, @PerformanceRating, @Salary;

END;
CLOSE dynamic_cursor;
DEALLOCATE dynamic_cursor;

GO

---- Forward-Only Cursor (you can apply it to Static and Dynamic cursors) ----
DECLARE dynamic_forward_only_cursor CURSOR DYNAMIC FORWARD_ONLY FOR
SELECT * FROM Professors_view;

OPEN dynamic_forward_only_cursor; --initialize the cursor

DECLARE @ProfessorID INT, @FullName VARCHAR(100), @DepartmentName VARCHAR(100), @PerformanceRating INT, @Salary DECIMAL(10,2);

FETCH NEXT FROM dynamic_forward_only_cursor INTO @ProfessorID, @FullName,  @DepartmentName, @PerformanceRating, @Salary;

WHILE @@FETCH_STATUS = 0
BEGIN 

	PRINT CAST(@ProfessorID AS VARCHAR) + ', ' + CAST(@FullName AS VARCHAR) + ', ' + CAST(@DepartmentName AS VARCHAR) + ', ' + CAST(@PerformanceRating AS VARCHAR) + ', ' +CAST(@Salary AS VARCHAR);
	FETCH NEXT FROM dynamic_forward_only_cursor INTO @ProfessorID, @FullName,  @DepartmentName, @PerformanceRating, @Salary;

END;
CLOSE dynamic_forward_only_cursor;
DEALLOCATE dynamic_forward_only_cursor;

GO

---- Scrollable Cursor (you can apply it to Static and Dynamic cursors) ----
DECLARE dynamic_scrollable_cursor CURSOR DYNAMIC SCROLL FOR
SELECT * FROM Professors_view;

OPEN dynamic_scrollable_cursor; --initialize the cursor

DECLARE @ProfessorID INT, @FullName VARCHAR(100), @DepartmentName VARCHAR(100), @PerformanceRating INT, @Salary DECIMAL(10,2);

FETCH NEXT FROM dynamic_scrollable_cursor INTO @ProfessorID, @FullName,  @DepartmentName, @PerformanceRating, @Salary;

WHILE @@FETCH_STATUS = 0
BEGIN 

	PRINT CAST(@ProfessorID AS VARCHAR) + ', ' + CAST(@FullName AS VARCHAR) + ', ' + CAST(@DepartmentName AS VARCHAR) + ', ' + CAST(@PerformanceRating AS VARCHAR) + ', ' +CAST(@Salary AS VARCHAR);
	FETCH NEXT FROM dynamic_forward_only_cursor INTO @ProfessorID, @FullName,  @DepartmentName, @PerformanceRating, @Salary;
	--use FETCH PRIOR to go backward
END;
CLOSE dynamic_scrollable_cursor;
DEALLOCATE dynamic_scrollable_cursor;

GO


---- Tabels ----
SELECT * FROM Students;
SELECT * FROM Professors;
SELECT * FROM Departments;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
SELECT * FROM Enrollments_view;
SELECT * FROM Courses_view;
SELECT * FROM Professors_view;
GO
