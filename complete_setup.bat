@echo off
echo ===============================================
echo Student Management System - Complete Setup
echo ===============================================
echo.

REM Step 1: Change Tomcat Port
echo Step 1: Changing Tomcat port to 3080...
powershell -Command "(Get-Content 'C:\Program Files\Apache Software Foundation\Tomcat 9.0\conf\server.xml') -replace 'port=\"8080\"', 'port=\"3080\"' | Set-Content 'C:\Program Files\Apache Software Foundation\Tomcat 9.0\conf\server.xml'"
echo ✓ Port changed to 3080
echo.

REM Step 2: Create Database
echo Step 2: Creating database...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -proot -e "DROP DATABASE IF EXISTS student_management_system; CREATE DATABASE student_management_system;"
echo ✓ Database created
echo.

REM Step 3: Create Tables
echo Step 3: Creating tables...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -proot student_management_system < "database\database_schema_simple.sql"
echo ✓ Tables created
echo.

REM Step  4: Insert Data
echo Step 4: Inserting sample data...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -proot student_management_system < "database\sample_data_simple.sql"
echo ✓ Data inserted
echo.

echo ===============================================
echo ✓ SETUP COMPLETE!
echo ===============================================
echo.
echo Port: 3080
echo Database: Created with all tables
echo Data: Admin + Students loaded
echo.
echo Next: Run start_tomcat.bat
echo Then open: http://localhost:3080/StudentManagementSystem/
echo.
pause
