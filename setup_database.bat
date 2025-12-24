@echo off
REM Student Management System - Database Setup
REM This script sets up the MySQL database

echo ========================================
echo Student Management System
echo Database Setup
echo ========================================
echo.

REM Set MySQL path
set MYSQL_PATH=C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe

echo Checking MySQL connection...
"%MYSQL_PATH%" -u root -pRoot -e "SELECT 'Connected to MySQL successfully!' AS Status;"
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Cannot connect to MySQL
    echo Please verify:
    echo 1. MySQL service is running
    echo 2. Password is 'root'
    echo 3. MySQL path is correct
    echo.
    pause
    exit /b 1
)

echo.
echo Creating database schema...
"%MYSQL_PATH%" -u root -pRoot < database\database_schema.sql
if %errorlevel% neq 0 (
    echo ERROR: Failed to create database schema
    pause
    exit /b 1
)
echo ✓ Database schema created

echo.
echo Inserting sample data...
"%MYSQL_PATH%" -u root -pRoot < database\sample_data.sql
if %errorlevel% neq 0 (
    echo ERROR: Failed to insert sample data
    pause
    exit /b 1
)
echo ✓ Sample data inserted

echo.
echo Verifying database...
"%MYSQL_PATH%" -u root -pRoot -e "USE student_management_system; SELECT COUNT(*) AS 'Total Tables' FROM information_schema.tables WHERE table_schema = 'student_management_system';"

echo.
echo ========================================
echo ✓ DATABASE SETUP COMPLETE!
echo ========================================
echo.
echo Database: student_management_system
echo Tables: 8 tables created
echo Sample Data: Admin + 10 students
echo.
echo Login Credentials:
echo   Admin: admin@sms.com / admin123
echo   Student: rajesh.kumar@student.com / student123
echo.
echo Next Steps:
echo 1. Deploy to Tomcat
echo 2. Access: http://localhost:8080/StudentManagementSystem/
echo.
pause
