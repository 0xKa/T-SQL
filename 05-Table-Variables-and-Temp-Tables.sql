USE BankDB
GO

-- Temporary Tables (#TempTables) → Used for storing temporary data within a session.
-- Global Temporary Tables (##GlobalTempTables) → Available to all sessions until they close.
-- Table Variables (@TableVariable) → A lightweight, in-memory table that only exists within the batch/procedure.

---- Table Variable ----
DECLARE @MyTable TABLE(
	
	[ID] INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(100) UNIQUE,
	[DateOfBirth] DATE

);

INSERT INTO @MyTable VALUES
('Reda', '2004-08-06'),
('Mohammed', '2003-01-14'),
('Ahmed', '2005-12-30');

SELECT * FROM @MyTable;

GO
---- Temporary Local Table ----
CREATE TABLE #MyLocalTempTable (
	
	[ID] INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(100) UNIQUE,
	[DateOfBirth] DATE

);

INSERT INTO #MyLocalTempTable VALUES
('Reda', '2004-08-06'),
('Mohammed', '2003-01-14'),
('Ahmed', '2005-12-30');

SELECT * FROM #MyLocalTempTable;
DROP TABLE #MyLocalTempTable; --sqlserver will automatically drop the table if you didn't do it


GO
---- Temporary Global Table ----
CREATE TABLE ##MyGlobalTempTable (
	
	[ID] INT PRIMARY KEY IDENTITY(1,1),
	[Name] NVARCHAR(100) UNIQUE,
	[DateOfBirth] DATE

);

INSERT INTO ##MyGlobalTempTable VALUES
('Reda', '2004-08-06'),
('Mohammed', '2003-01-14'),
('Ahmed', '2005-12-30');

SELECT * FROM ##MyGlobalTempTable;
DROP TABLE ##MyGlobalTempTable; --sqlserver will automatically drop the table if you didn't do it

---- Tabels ----
SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Branches;
SELECT * FROM Loans;
SELECT * FROM Transactions;
GO