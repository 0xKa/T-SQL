
DECLARE @EmployeeID INT = 101;
DECLARE @Year INT = 2023;
DECLARE @Month INT = 7;
DECLARE @Day INT = 1;


--Calculate total days in a month (28,29,30,31)
DECLARE @TotalDays INT = DAY( EOMONTH ( DATEFROMPARTS( @Year, @Month, @Day)));

DECLARE @PresentDays INT; 
SELECT @PresentDays = COUNT(*) 
FROM EmployeeAttendance 
WHERE @EmployeeID = EmployeeID AND MONTH(AttendanceDate) = @Month AND YEAR(AttendanceDate) = @Year AND [Status] = 'Present'

DECLARE @AbsentDays INT; 
SELECT @AbsentDays = COUNT(*) 
FROM EmployeeAttendance 
WHERE @EmployeeID = EmployeeID AND MONTH(AttendanceDate) = @Month AND YEAR(AttendanceDate) = @Year AND [Status] = 'Absent'

DECLARE @LeaveDays INT; 
SELECT @LeaveDays = COUNT(*) 
FROM EmployeeAttendance 
WHERE @EmployeeID = EmployeeID AND MONTH(AttendanceDate) = @Month AND YEAR(AttendanceDate) = @Year AND [Status] = 'Leave'

PRINT('Employee Attndance Report for Employee ID: ' + CAST(@EmployeeID AS VARCHAR));
PRINT('Month: ' + CAST(@Month AS VARCHAR) + ' / Year: ' + CAST(@Year AS VARCHAR));
PRINT('Total Days in Month: ' + CAST(@TotalDays AS VARCHAR));
PRINT('Days Present: ' + CAST(@PresentDays AS VARCHAR)); 
PRINT('Days Absent: ' + CAST(@AbsentDays AS VARCHAR)); 
PRINT('Days Leave: ' + CAST(@LeaveDays AS VARCHAR)); 

