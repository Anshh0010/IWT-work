@echo off
REM Start Tomcat with correct environment variables

echo Setting up environment...
set JAVA_HOME=C:\Program Files\Java\jdk-24
set CATALINA_HOME=C:\Program Files\Apache Software Foundation\Tomcat 9.0

echo JAVA_HOME: %JAVA_HOME%
echo CATALINA_HOME: %CATALINA_HOME%
echo.

echo Starting Tomcat...
cd /d "%CATALINA_HOME%\bin"
call startup.bat

echo.
echo Tomcat is starting...
echo Wait 10-15 seconds, then open your browser to:
echo http://localhost:3080/StudentManagementSystem/login.jsp
echo.
echo Login: admin@sms.com / admin123
echo.
pause
