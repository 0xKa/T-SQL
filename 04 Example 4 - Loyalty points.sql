
DECLARE @CustomerID INT = 2;
DECLARE @CurrentYear INT = YEAR(GETDATE());

DECLARE @TotalSpent DECIMAL(10,2);
SELECT @TotalSpent = SUM(Amount) FROM Purchases 
WHERE CustomerID = @CustomerID AND YEAR(PurchaseDate) = @CurrentYear;


DECLARE @PointEarned INT = CAST (@TotalSpent / 10 AS INT);

--add points to the customer record
UPDATE Customers 
SET LoyaltyPoints = LoyaltyPoints + @PointEarned
WHERE CustomerID = @CustomerID;

PRINT 'Customer ID: ' + CAST (@CustomerID AS VARCHAR);
PRINT 'Total Spent: ' + CAST (@TotalSpent AS VARCHAR);
PRINT 'Earned Points: ' + CAST (@PointEarned AS VARCHAR);

SELECT * FROM Purchases;
SELECT * FROM Customers;