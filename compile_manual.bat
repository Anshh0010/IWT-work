@echo off
echo ========================================
echo Manual Compilation (javac @sources.txt)
echo ========================================

set JAVA_HOME=C:\Program Files\Java\jdk-24
set TOMCAT_HOME=C:\Program Files\Apache Software Foundation\Tomcat 9.0
set PROJECT_HOME=c:\Users\HP\DBMS project 2
set CLASSES_DIR=%PROJECT_HOME%\src\main\webapp\WEB-INF\classes

echo Cleaning local classes...
rmdir /s /q "%CLASSES_DIR%" 2>nul
mkdir "%CLASSES_DIR%"

echo Compiling...
"%JAVA_HOME%\bin\javac.exe" -d "%CLASSES_DIR%" ^
 -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar;%TOMCAT_HOME%\lib\el-api.jar;%TOMCAT_HOME%\lib\mysql-connector-java-8.0.33.jar" ^
 @sources.txt

if %errorlevel% neq 0 (
    echo.
    echo ✗ Compilation Failed!
    pause
    exit /b 1
)

echo.
echo ✓ Compilation Successful!

echo Cleaning Tomcat classes...
rmdir /s /q "%TOMCAT_HOME%\webapps\StudentManagementSystem\WEB-INF\classes" 2>nul

echo Deploying...
xcopy /E /I /Y "%CLASSES_DIR%" "%TOMCAT_HOME%\webapps\StudentManagementSystem\WEB-INF\classes"
copy /Y "%PROJECT_HOME%\src\main\webapp\register.jsp" "%TOMCAT_HOME%\webapps\StudentManagementSystem\"
copy /Y "%PROJECT_HOME%\src\main\webapp\dbtest.jsp" "%TOMCAT_HOME%\webapps\StudentManagementSystem\"
copy /Y "%PROJECT_HOME%\src\main\webapp\WEB-INF\web.xml" "%TOMCAT_HOME%\webapps\StudentManagementSystem\WEB-INF\"

echo.
echo ✓ Deployed!
pause
