# Deploy Student Management System to Tomcat
# Run this script from the project directory

$ErrorActionPreference = "Stop"

$projectPath = "c:\Users\HP\DBMS project 2"
$tomcatPath = "C:\Program Files\Apache Software Foundation\Tomcat 9.0"
$webappPath = "$tomcatPath\webapps\StudentManagementSystem"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Student Management System - Deployment" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Create webapp directory
Write-Host "Creating webapp directory..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path $webappPath | Out-Null
Write-Host "✓ Directory created: $webappPath" -ForegroundColor Green

# Copy JSP and web files
Write-Host ""
Write-Host "Copying web files..." -ForegroundColor Yellow
Copy-Item -Path "$projectPath\src\main\webapp\*" -Destination $webappPath -Recurse -Force
Write-Host "✓ Web files copied" -ForegroundColor Green

# Create WEB-INF\classes directory
Write-Host ""
Write-Host "Creating classes directory..." -ForegroundColor Yellow
$classesPath = "$webappPath\WEB-INF\classes"
New-Item -ItemType Directory -Force -Path $classesPath | Out-Null
Write-Host "✓ Classes directory created" -ForegroundColor Green

# Create lib directory
Write-Host ""
Write-Host "Creating lib directory..." -ForegroundColor Yellow
$libPath = "$webappPath\WEB-INF\lib"
New-Item -ItemType Directory -Force -Path $libPath | Out-Null
Write-Host "✓ Lib directory created" -ForegroundColor Green

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "DEPLOYMENT COMPLETED!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

Write-Host "⚠️  IMPORTANT NEXT STEPS:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. COMPILE JAVA FILES:" -ForegroundColor Cyan
Write-Host "   You need to compile the Java source files and copy .class files to:"
Write-Host "   $classesPath\com\sms\" -ForegroundColor White
Write-Host ""
Write-Host "2. DOWNLOAD JAR FILES:" -ForegroundColor Cyan
Write-Host "   Download and place in: $libPath" -ForegroundColor White
Write-Host "   - mysql-connector-java-8.0.33.jar" -ForegroundColor White
Write-Host "   - jstl-1.2.jar" -ForegroundColor White
Write-Host ""
Write-Host "   Download links:"
Write-Host "   https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar"
Write-Host "   https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar"
Write-Host ""
Write-Host "3. SETUP DATABASE:" -ForegroundColor Cyan
Write-Host "   Use MySQL Workbench to run the SQL scripts in database/ folder"
Write-Host ""
Write-Host "4. START TOMCAT:" -ForegroundColor Cyan
Write-Host "   Run: $tomcatPath\bin\startup.bat" -ForegroundColor White
Write-Host ""
Write-Host "5. ACCESS APPLICATION:" -ForegroundColor Cyan
Write-Host "   http://localhost:3080/StudentManagementSystem/" -ForegroundColor White
Write-Host ""
Write-Host "Login: admin@sms.com / admin123" -ForegroundColor Green
Write-Host ""

Read-Host "Press Enter to continue"
