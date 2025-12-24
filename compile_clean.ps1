# PowerShell Compilation Script (Clean Deploy)
$java_home = "C:\Program Files\Java\jdk-24"
$tomcat_home = "C:\Program Files\Apache Software Foundation\Tomcat 9.0"
$project_home = "c:\Users\HP\DBMS project 2"
$classes_dir = "$project_home\src\main\webapp\WEB-INF\classes"

Write-Host "Compiling with PowerShell (Clean Deploy)..." -ForegroundColor Cyan

# Clean Local
if (Test-Path $classes_dir) { Remove-Item $classes_dir -Recurse -Force }
New-Item -ItemType Directory -Path $classes_dir | Out-Null

# Classpath
$classpath = "$tomcat_home\lib\servlet-api.jar;$tomcat_home\lib\jsp-api.jar;$tomcat_home\lib\el-api.jar;$tomcat_home\lib\mysql-connector-java-8.0.33.jar"

# Get Sources
$sources = Get-ChildItem -Path "$project_home\src\main\java" -Recurse -Filter "*.java" | Select-Object -ExpandProperty FullName

# Compile
& "$java_home\bin\javac.exe" -d $classes_dir -cp $classpath $sources

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Compilation Successful!" -ForegroundColor Green
    
    # Clean Remote (Tomcat)
    Write-Host "Cleaning Tomcat classes..."
    $tomcat_classes = "$tomcat_home\webapps\StudentManagementSystem\WEB-INF\classes"
    if (Test-Path $tomcat_classes) { Remove-Item $tomcat_classes -Recurse -Force }
    
    # Deploy
    Write-Host "Deploying..."
    $webapp_dir = "$tomcat_home\webapps\StudentManagementSystem"
    
    Copy-Item "$project_home\src\main\webapp\register.jsp" "$webapp_dir\register.jsp" -Force
    Copy-Item "$project_home\src\main\webapp\dbtest.jsp" "$webapp_dir\dbtest.jsp" -Force
    Copy-Item "$project_home\src\main\webapp\WEB-INF\web.xml" "$webapp_dir\WEB-INF\web.xml" -Force
    Copy-Item $classes_dir "$webapp_dir\WEB-INF\" -Recurse -Force
    
    Write-Host "✓ Deployed!" -ForegroundColor Green
} else {
    Write-Host "✗ Compilation Failed!" -ForegroundColor Red
    exit 1
}
