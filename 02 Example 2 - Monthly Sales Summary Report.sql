Use C21_DB1

--SELECT * FROM Sales;


DECLARE @Year INT;
DECLARE @Month INT;
SET @Year = 2023;
SET @Month = 6;

DECLARE @TotalSales DECIMAL(10,2);
SELECT @TotalSales = SUM(SaleAmount)
FROM Sales WHERE YEAR(SaleDate) = @Year AND MONTH(SaleDate) = @Month

DECLARE @TotalTransactions INT;
SELECT @TotalTransactions = COUNT(*)
FROM Sales WHERE YEAR(SaleDate) = @Year AND MONTH(SaleDate) = @Month


DECLARE @AverageSales DECIMAL(10,2);
SET @AverageSales = @TotalSales / @TotalTransactions;

PRINT 'Monthly Sales Summary'
PRINT 'Year: ' + CAST(@Year AS VARCHAR) + ' Month: ' + CAST(@Month AS VARCHAR) 
PRINT 'Total Sales: ' + CAST(@TotalSales AS VARCHAR) 
PRINT 'Total Transactions: ' + CAST(@TotalTransactions AS VARCHAR) 
PRINT 'Average Sales Value: ' + CAST(@AverageSales AS VARCHAR) 
