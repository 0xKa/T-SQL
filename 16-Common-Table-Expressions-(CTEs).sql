USE CollegeDB;
GO

---- Sub-Query ----
SELECT * FROM (SELECT StudentID, FirstName + ' ' + LastName AS FullName, IsActive FROM Students) SubQuery_tabel
WHERE SubQuery_tabel.IsActive = 0;
GO

---- CTE ----
WITH CTE_table AS
(
	SELECT StudentID, FirstName + ' ' + LastName AS FullName, IsActive 
	FROM Students
)

SELECT * FROM CTE_table WHERE IsActive = 0;
GO


---- Recursive CTE ----
WITH Numbers AS
(
	SELECT 1 AS Number

	UNION ALL 

	SELECT Number + 1 FROM Numbers WHERE Number < 10

)

SELECT * FROM Numbers;
GO


---- CTEs for Building Hierarchies ----
DECLARE @Managers TABLE
(
    EmployeeID INT PRIMARY KEY,
    ManagerID INT NULL,
    Name VARCHAR(50)
);
INSERT INTO @Managers (EmployeeID, ManagerID, Name)
VALUES
    (1, NULL, 'CEO'),
    (2, 1, 'VP of Sales'),
    (3, 1, 'VP of Marketing'),
    (4, 2, 'Sales Manager'),
    (5, 2, 'Sales Representative'),
    (6, 3, 'Marketing Manager'),
    (7, 4, 'Sales Associate'),
    (8, 6, 'Marketing Specialist'),
    (9, 1, 'VP IT');

WITH EmployeeTreeHierarchy AS 
(
    -- Anchor member: Select the top-most manager (CEO)
    SELECT EmployeeID, ManagerID, [Name], 
           CAST([Name] AS VARCHAR(MAX)) AS Hierarchy, 0 AS [Level]
    FROM @Managers 
    WHERE ManagerID IS NULL

    UNION ALL 

    -- Recursive member: Join employees with their managers
    SELECT m.EmployeeID, m.ManagerID, m.[Name],
           CAST(eth.Hierarchy + ' -> ' + m.[Name] AS VARCHAR(MAX)), eth.[Level] + 1
    FROM @Managers m 
    JOIN EmployeeTreeHierarchy eth ON m.ManagerID = eth.EmployeeID
)

SELECT * FROM EmployeeTreeHierarchy 
ORDER BY Hierarchy;

GO

---- Generating a Date Series Using CTE ----
-- won't work with large dates because Maximum Recursion Depth Exceeded (Default = 100) in sql server
DECLARE @StartDate DATE = '2004-08-06';
DECLARE @EndDate DATE = '2004-09-06';

WITH DateSeries AS
(
	SELECT @StartDate AS DateValue

	UNION ALL

	SELECT DATEADD(DAY, 1, DateValue)
    FROM DateSeries WHERE DateValue < @EndDate

)
SELECT * FROM DateSeries;

GO

---- Identifying Duplicate Records Using CTE ----

WITH DuplicateAddresses AS (

	SELECT [Address], COUNT(*) AS DuplicateAddresses FROM Students
	GROUP BY [Address] HAVING COUNT(*) > 1
	
)
SELECT s.StudentID, s.FirstName, s.Address
FROM Students s
JOIN DuplicateAddresses d ON  d.Address = s.Address;


GO

---- Ranking Items Using CTE ----

WITH TotalProfessorsPerDepartment AS
(
	SELECT DepartmentName, COUNT(*) AS TotalProfessors, SUM(Salary) AS TotalSalaries
	FROM Professors_view
	GROUP BY DepartmentName
),
RankedDepartments AS
(
	SELECT DepartmentName, TotalProfessors, TotalSalaries,
	DENSE_RANK() OVER (ORDER BY TotalProfessors DESC) AS DepartmentRank
	FROM TotalProfessorsPerDepartment
)

SELECT * FROM RankedDepartments;
GO


---- Calculating Average Salaries of Top Performing Employees Per Department Using CTE ----

WITH TotalProfessorsPerDepartment AS
(
	SELECT DepartmentName, SUM(PerformanceRating) AS TotalRating, SUM(Salary) AS TotalSalaries 
	FROM Professors_view
	GROUP BY DepartmentName
),
TopRatingProfessors AS
(
	SELECT TOP(3) * FROM TotalProfessorsPerDepartment ORDER BY TotalRating DESC
)

SELECT AVG(TotalSalaries) AS 'Average Salary of Top Departments' FROM TopRatingProfessors 

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
