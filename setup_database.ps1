# Complete Database Setup Script
# This will create all tables with data

$mysqlPath = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
$dbUser = "root"
$dbPass = "root"
$projectPath = "c:\Users\HP\DBMS project 2"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Database Setup - Student Management System" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Test connection
Write-Host "Testing MySQL connection..." -ForegroundColor Yellow
$testResult = & $mysqlPath -u $dbUser -p$dbPass -e "SELECT 'Connected!' AS Status;" 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ MySQL connection successful!" -ForegroundColor Green
} else {
    Write-Host "✗ MySQL connection failed!" -ForegroundColor Red
    Write-Host "Error: $testResult" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Create database and tables
Write-Host ""
Write-Host "Creating database schema..." -ForegroundColor Yellow

$schemaPath = Join-Path $projectPath "database\database_schema.sql"
& $mysqlPath -u $dbUser -p$dbPass < $schemaPath 2>&1 | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Database schema created!" -ForegroundColor Green
} else {
    Write-Host "✗ Schema creation failed!" -ForegroundColor Red
}

# Insert sample data
Write-Host ""
Write-Host "Inserting sample data..." -ForegroundColor Yellow

$dataPath = Join-Path $projectPath "database\sample_data.sql"
& $mysqlPath -u $dbUser -p$dbPass < $dataPath 2>&1 | Out-Null

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Sample data inserted!" -ForegroundColor Green
} else {
    Write-Host "✗ Data insertion failed!" -ForegroundColor Red
}

# Verify
Write-Host ""
Write-Host "Verifying database..." -ForegroundColor Yellow
& $mysqlPath -u $dbUser -p$dbPass -e "USE student_management_system; SHOW TABLES;"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✓ DATABASE SETUP COMPLETE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Database: student_management_system" -ForegroundColor Cyan
Write-Host "Tables: 8 tables created" -ForegroundColor Cyan
Write-Host "Data: Admin + 10 students loaded" -ForegroundColor Cyan
Write-Host ""

Read-Host "Press Enter to continue"
