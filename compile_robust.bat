@echo off
echo ========================================
echo Robust Compilation Script
echo ========================================
setlocal

set JAVA_HOME=C:\Program Files\Java\jdk-24
set TOMCAT_HOME=C:\Program Files\Apache Software Foundation\Tomcat 9.0
set PROJECT_HOME=c:\Users\HP\DBMS project 2

echo Generating source file list...
dir /s /b "%PROJECT_HOME%\src\main\java\*.java" > sources.txt

echo Cleaning output directory...
if exist "%PROJECT_HOME%\src\main\webapp\WEB-INF\classes" rmdir /s /q "%PROJECT_HOME%\src\main\webapp\WEB-INF\classes"
mkdir "%PROJECT_HOME%\src\main\webapp\WEB-INF\classes"

echo Compiling...
"%JAVA_HOME%\bin\javac.exe" -d "%PROJECT_HOME%\src\main\webapp\WEB-INF\classes" ^
  -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar;%TOMCAT_HOME%\lib\el-api.jar;%TOMCAT_HOME%\lib\mysql-connector-java-8.0.33.jar" ^
  @sources.txt

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Compilation failed!
    echo Check sources.txt for file list.
    pause
    exit /b 1
)

echo.
echo ✓ Compilation successful!

echo Deploying configuration...
xcopy /Y "%PROJECT_HOME%\src\main\webapp\WEB-INF\web.xml" "%TOMCAT_HOME%\webapps\StudentManagementSystem\WEB-INF\"

echo Deploying JSP...
xcopy /Y "%PROJECT_HOME%\src\main\webapp\register.jsp" "%TOMCAT_HOME%\webapps\StudentManagementSystem\"

echo Deploying classes...
xcopy /E /I /Y "%PROJECT_HOME%\src\main\webapp\WEB-INF\classes" "%TOMCAT_HOME%\webapps\StudentManagementSystem\WEB-INF\classes"

echo.
echo ✓ Deployment complete.
echo.
pause
