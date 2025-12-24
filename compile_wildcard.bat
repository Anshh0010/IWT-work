@echo off
echo ========================================
echo Robust Compilation (Wildcard Method)
echo ========================================

set JAVA_HOME=C:\Program Files\Java\jdk-24
set TOMCAT_HOME=C:\Program Files\Apache Software Foundation\Tomcat 9.0
set PROJECT_HOME=c:\Users\HP\DBMS project 2
set SOURCE_DIR=%PROJECT_HOME%\src\main\java
set CLASSES_DIR=%PROJECT_HOME%\src\main\webapp\WEB-INF\classes

echo Cleaning output directory...
rmdir /s /q "%CLASSES_DIR%" 2>nul
mkdir "%CLASSES_DIR%"

set CP="%TOMCAT_HOME%\lib\servlet-api.jar;%TOMCAT_HOME%\lib\jsp-api.jar;%TOMCAT_HOME%\lib\el-api.jar;%TOMCAT_HOME%\lib\mysql-connector-java-8.0.33.jar;%CLASSES_DIR%"

echo Compiling Utils...
"%JAVA_HOME%\bin\javac.exe" -d "%CLASSES_DIR%" -cp %CP% "%SOURCE_DIR%\com\sms\util\*.java"
if %errorlevel% neq 0 exit /b 1

echo Compiling Models...
"%JAVA_HOME%\bin\javac.exe" -d "%CLASSES_DIR%" -cp %CP% "%SOURCE_DIR%\com\sms\model\*.java"
if %errorlevel% neq 0 exit /b 1

echo Compiling DAOs...
"%JAVA_HOME%\bin\javac.exe" -d "%CLASSES_DIR%" -cp %CP% "%SOURCE_DIR%\com\sms\dao\*.java"
if %errorlevel% neq 0 exit /b 1

echo Compiling Filters...
"%JAVA_HOME%\bin\javac.exe" -d "%CLASSES_DIR%" -cp %CP% "%SOURCE_DIR%\com\sms\filter\*.java"
if %errorlevel% neq 0 exit /b 1

echo Compiling Servlets...
"%JAVA_HOME%\bin\javac.exe" -d "%CLASSES_DIR%" -cp %CP% "%SOURCE_DIR%\com\sms\servlet\*.java"
if %errorlevel% neq 0 exit /b 1

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
