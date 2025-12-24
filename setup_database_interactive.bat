@echo off
echo ========================================
echo Student Management System
echo Database Setup - Interactive
echo ========================================
echo.

set MYSQL_PATH=C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe

echo Enter your MySQL root password (or press Enter if no password):
set /p MYSQL_PASS=Password: 

echo.
echo Testing connection...
"%MYSQL_PATH%" -u root -p%MYSQL_PASS% -e "SELECT 'Connection successful!' AS Status;"
if %errorlevel% neq 0 (
    echo ERROR: Could not connect to MySQL
    echo Please verify your password and try again
    pause
    exit /b 1
)

echo.
echo Creating database...
"%MYSQL_PATH%" -u root -p%MYSQL_PASS% < database\database_schema.sql
if %errorlevel% neq 0 (
    echo ERROR: Database creation failed
    pause
    exit /b 1
)
echo Database created successfully!

echo.
echo Inserting sample data...
"%MYSQL_PATH%" -u root -p%MYSQL_PASS% < database\sample_data.sql
if %errorlevel% neq 0 (
    echo ERROR: Sample data insertion failed
    pause
    exit /b 1
)
echo Sample data inserted successfully!

echo.
echo ========================================
echo DATABASE SETUP COMPLETE!
echo ========================================
echo.
echo NOTE: Remember to update DatabaseUtil.java with your password:
echo   DB_PASSWORD = "%MYSQL_PASS%"
echo.
pause
