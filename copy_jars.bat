@echo off
echo ========================================
echo Copying JAR Files to Tomcat
echo ========================================
echo.

set TOMCAT_LIB=C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib

echo Checking Downloads folder...
dir "%USERPROFILE%\Downloads\*.jar" | findstr /i "jstl mysql"

echo.
echo Attempting to copy JAR files...

if exist "%USERPROFILE%\Downloads\jstl-1.2.jar" (
    copy /Y "%USERPROFILE%\Downloads\jstl-1.2.jar" "%TOMCAT_LIB%\"
    echo ✓ Copied jstl-1.2.jar
) else (
    echo ✗ jstl-1.2.jar not found in Downloads
)

if exist "%USERPROFILE%\Downloads\mysql-connector-java-8.0.33.jar" (
    copy /Y "%USERPROFILE%\Downloads\mysql-connector-java-8.0.33.jar" "%TOMCAT_LIB%\"
    echo ✓ Copied mysql-connector-java-8.0.33.jar
) else (
    echo ✗ mysql-connector-java-8.0.33.jar not found in Downloads
)

echo.
echo Checking Tomcat lib folder...
dir "%TOMCAT_LIB%\*.jar" | findstr /i "jstl mysql"

echo.
pause
