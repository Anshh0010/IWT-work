@echo off
echo ========================================
echo Compiling Student Management System
echo ========================================
echo.

set JAVA_HOME=C:\Program Files\Java\jdk-24
set TOMCAT_HOME=C:\Program Files\Apache Software Foundation\Tomcat 9.0
set PROJECT_HOME=c:\Users\HP\DBMS project 2

echo Cleaning old classes...
rmdir /s /q "%PROJECT_HOME%\src\main\webapp\WEB-INF\classes" 2>nul
mkdir "%PROJECT_HOME%\src\main\webapp\WEB-INF\classes"

echo.
echo Compiling Java source files...
"%JAVA_HOME%\bin\javac.exe" -d "%PROJECT_HOME%\src\main\webapp\WEB-INF\classes" ^
    -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar;%TOMCAT_HOME%\lib\el-api.jar;%TOMCAT_HOME%\lib\mysql-connector-java-8.0.33.jar" ^
    "%PROJECT_HOME%\src\main\java\com\sms\util\*.java" ^
    "%PROJECT_HOME%\src\main\java\com\sms\model\*.java" ^
    "%PROJECT_HOME%\src\main\java\com\sms\dao\*.java" ^
    "%PROJECT_HOME%\src\main\java\com\sms\filter\*.java" ^
    "%PROJECT_HOME%\src\main\java\com\sms\servlet\*.java"

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Compilation failed!
    pause
    exit /b 1
)

echo.
echo ✓ Compilation successful!
echo.
echo Deploying to Tomcat...
xcopy /E /I /Y "%PROJECT_HOME%\src\main\webapp\register.jsp" "%TOMCAT_HOME%\webapps\StudentManagementSystem\"
xcopy /E /I /Y "%PROJECT_HOME%\src\main\webapp\WEB-INF\classes" "%TOMCAT_HOME%\webapps\StudentManagementSystem\WEB-INF\classes"

echo.
echo ✓ Deployed successfully!
echo.
pause
