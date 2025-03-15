USE CollegeDB;
GO

---- After Insert Trigger ----
CREATE TRIGGER trg_AfterInsertStudent ON Students AFTER INSERT AS
BEGIN
	
	INSERT INTO StudentsInsertLog(StudentID,FirstName, LastName, DateOfBirth, Email, Phone, Address)
	SELECT StudentID, FirstName, LastName, DateOfBirth, Email, Phone, Address FROM inserted
	PRINT 'New Student Inserted.' 
END;
SELECT * FROM StudentsInsertLog;
GO

---- After Update Trigger ----
CREATE TRIGGER trg_AfterUpdateStudent ON Students AFTER UPDATE AS
BEGIN
	
	IF UPDATE(Email) OR UPDATE(Phone) OR UPDATE(Address) --- or(SELECT Email FROM deleted) != (SELECT Email FROM inserted)
	BEGIN

		INSERT INTO StudentsUpdateLog(StudentID,OldEmail, NewEmail, OldPhone, NewPhone, OldAddress, NewAddress)
		SELECT i.StudentID, d.Email, i.Email, d.Phone, i.Phone, d.Address, i.Address
		FROM inserted i JOIN deleted d ON i.StudentID = d.StudentID 
		PRINT 'Student Updated.' 

	END;

END;
SELECT * FROM StudentsUpdateLog;
GO

---- After Delete Trigger ----
CREATE TRIGGER trg_AfterDeleteStudent ON Students AFTER DELETE AS
BEGIN
	
	INSERT INTO StudentsDeleteLog(StudentID,FirstName, LastName, DateOfBirth, Email, Phone, Address)
	SELECT StudentID, FirstName, LastName, DateOfBirth, Email, Phone, Address FROM deleted
	PRINT 'Deleted Student Info Logged.' 
END;
SELECT * FROM StudentsDeleteLog;
GO



---- Tabels ----
SELECT * FROM Students;
SELECT * FROM Professors;
SELECT * FROM Departments;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
GO
