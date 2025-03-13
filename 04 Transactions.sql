USE BankDB
GO

---- Performing a Bank Transfer ----
BEGIN TRANSACTION;

BEGIN TRY

	DECLARE @TransferFromAccountID DECIMAL(18,2) = 1002;
	DECLARE @TransferToAccountID DECIMAL(18,2) = 1000;
	DECLARE @TransferAmount DECIMAL(18,2) = 1500;


	-- Check if the source account has enough balance
    DECLARE @FromAccountBalance DECIMAL(18,2);
    SELECT @FromAccountBalance = Balance FROM Accounts WHERE AccountID = @TransferFromAccountID;

    IF @FromAccountBalance < @TransferAmount
        THROW 51000, 'Insufficient funds in the source account.', 1;

	-- Subtract $1000 from Account 1002
	UPDATE Accounts SET Balance = Balance - @TransferAmount WHERE AccountID = @TransferFromAccountID;
	
	-- Add $1000 to Account 1000
	UPDATE Accounts SET Balance = Balance + @TransferAmount WHERE AccountID = @TransferToAccountID;
	
	-- Log the transaction
	INSERT INTO Transactions VALUES (@TransferFromAccountID, 'Transfer', @TransferAmount, GETDATE())

	COMMIT; -- Commit the transaction

END TRY
BEGIN CATCH
	
	ROLLBACK; -- Rollback in case of error
	
	--handle error
	PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
    PRINT 'Error Message: ' + ERROR_MESSAGE();

END CATCH;



---- Tabels ----
SELECT * FROM Customers;
SELECT * FROM Accounts;
SELECT * FROM Branches;
SELECT * FROM Loans;
SELECT * FROM Transactions;
GO
