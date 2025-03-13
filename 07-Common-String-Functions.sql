USE CollegeDB;
GO

DECLARE @string VARCHAR(255) = '  Reda Bassam Hilal  ';

--Common String Functions...

-- Using the LEN function to get the length of each employee's name
SELECT LEN(@string) AS NameLength;

-- Converting employee names to uppercase using the UPPER function
SELECT UPPER(@string) AS UpperCaseName

-- Converting employee names to lowercase using the LOWER function
SELECT LOWER(@string) AS UpperCaseNam

-- Extracting the first three characters of each name using SUBSTRING
SELECT SUBSTRING(@string, 1, 3) AS NameSubstring

-- Finding the position of '0' in each name using CHARINDEX
SELECT CHARINDEX('b', @string) AS CharPosition

-- Replacing 'Hilal' with 'Bader' using REPLACE
SELECT REPLACE(@string, 'Hilal', 'Bader') AS NewDepartment 

-- Concatenating the name with a hyphen in between using CONCAT
SELECT CONCAT(@string, ' - ', @string) AS ConcatenatedString

-- Practice Exercise: Format Name and Department in a specific format using CONCAT, UPPER, and LOWER
-- Objective: Format the Name and Department columns as a single string, where names are in uppercase, and department names are in lowercase, separated by a colon (:)
SELECT CONCAT(UPPER(@string), ' : ', LOWER(@string)) AS FormattedOutput

-- Extracting the first 3 characters from the left side of the employee's name using LEFT
SELECT LEFT(@string, 3) AS LeftSubstring

-- Extracting the last 3 characters from the right side of the employee's name using RIGHT
SELECT RIGHT(@string, 3) AS RightSubstring

-- Removing leading spaces from the employee's name using LTRIM
SELECT LTRIM(@string) AS NameWithNoLeadingSpaces

-- Removing trailing spaces from the employee's name using RTRIM
SELECT RTRIM(@string) AS NameWithNoTrailingSpaces


-- Removing spaces from the start and end of each name using LTRIM and RTRIM
SELECT LTRIM(RTRIM(Name)) AS TrimmedName FROM dbo.Employees2

-- Removing both leading and trailing spaces from the employee's name using TRIM
SELECT TRIM(Name) AS NameWithNoSpaces FROM dbo.Employees2

go

