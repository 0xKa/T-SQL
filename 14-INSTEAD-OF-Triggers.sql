USE CollegeDB;
--- Note: the INSTEAD OF Triggers will cancel the AFTER Triggers
GO

---- Instead Of Delete Trigger ----
CREATE TRIGGER trg_InsteadOfDeleteStudent ON Students INSTEAD OF DELETE AS
BEGIN
	--Marking student as inactive instead of deleting them
	UPDATE Students SET IsActive = 0 
	FROM Students s JOIN deleted d ON s.StudentID = d.StudentID;
END;
DELETE FROM Students WHERE StudentID = 17;
SELECT * FROM Students;
GO

---- Instead Of Update Trigger ----
CREATE TRIGGER trg_UpdateCoursesview ON Courses_view INSTEAD OF UPDATE AS
BEGIN
	--update each table one by one
	UPDATE Courses
	SET CourseName = i.CourseName, Credits = i.Credits
	FROM Courses JOIN inserted i ON Courses.CourseID = i.CourseID

	UPDATE Departments
	SET DepartmentName = i.DepartmentName
	FROM Departments d JOIN inserted i ON d.DepartmentID  = i.DepartmentID;

END;

UPDATE Courses_view SET CourseName = 'Physics I', Credits = 4, DepartmentName = 'Physics' WHERE CourseID = 11;
SELECT * FROM Courses_view;
SELECT * FROM Departments;
SELECT * FROM Courses;


GO

---- Instead Of Insert Trigger ----
CREATE TRIGGER trg_InsertIntoCoursesview ON Courses_view INSTEAD OF INSERT AS
BEGIN
	--insert into each table one by one
	
	INSERT INTO Departments (DepartmentName)
	SELECT DepartmentName FROM inserted;
	
	INSERT INTO Courses (CourseName, Credits, DepartmentID)
	SELECT i.CourseName, i.Credits, i.DepartmentID FROM inserted i;

END;

INSERT INTO Courses_view (CourseName, Credits, DepartmentID, DepartmentName)
VALUES ('Data Structures', 5, 1, 'CS')

SELECT * FROM Courses_view;
SELECT * FROM Departments;
SELECT * FROM Courses;

GO

---- Tabels ----
SELECT * FROM Students;
SELECT * FROM Professors;
SELECT * FROM Departments;
SELECT * FROM Courses;
SELECT * FROM Enrollments;
SELECT * FROM Enrollments_view;
SELECT * FROM Courses_view;
GO
