# PowerShell Compilation Script (Smart Sourcepath)
$java_home = "C:\Program Files\Java\jdk-24"
$tomcat_home = "C:\Program Files\Apache Software Foundation\Tomcat 9.0"
$project_home = "c:\Users\HP\DBMS project 2"
$classes_dir = "$project_home\src\main\webapp\WEB-INF\classes"
$source_path = "$project_home\src\main\java"

Write-Host "Compiling with Smart Sourcepath..." -ForegroundColor Cyan

# Clean
if (Test-Path $classes_dir) { Remove-Item $classes_dir -Recurse -Force }
New-Item -ItemType Directory -Path $classes_dir | Out-Null

$classpath = "$tomcat_home\lib\servlet-api.jar;$tomcat_home\lib\jsp-api.jar;$tomcat_home\lib\el-api.jar;$tomcat_home\lib\mysql-connector-java-8.0.33.jar"

# Get Sources
$sources = Get-ChildItem -Path $source_path -Recurse -Filter "*.java" | Select-Object -ExpandProperty FullName
Write-Host "Found $($sources.Count) source files."

# Construct Arguments
# Use -sourcepath so javac can find dependencies
$javac = "$java_home\bin\javac.exe"
$args_list = @("-d", $classes_dir, "-cp", $classpath, "-sourcepath", $source_path) + $sources

Write-Host "Running javac..."
$p = Start-Process -FilePath $javac -ArgumentList $args_list -Wait -NoNewWindow -PassThru

if ($p.ExitCode -eq 0) {
    Write-Host "✓ Compilation Successful!" -ForegroundColor Green
    
    # Deploy
    $tomcat_webapps = "$tomcat_home\webapps\StudentManagementSystem"
    $tomcat_classes = "$tomcat_webapps\WEB-INF\classes"
    
    Write-Host "Cleaning Remote..."
    if (Test-Path $tomcat_classes) { Remove-Item $tomcat_classes -Recurse -Force }
    
    Write-Host "Deploying..."
    Copy-Item "$project_home\src\main\webapp\register.jsp" "$tomcat_webapps\register.jsp" -Force
    Copy-Item "$project_home\src\main\webapp\dbtest.jsp" "$tomcat_webapps\dbtest.jsp" -Force
    Copy-Item "$project_home\src\main\webapp\WEB-INF\web.xml" "$tomcat_webapps\WEB-INF\web.xml" -Force
    Copy-Item $classes_dir "$tomcat_webapps\WEB-INF\" -Recurse -Force
    
    Write-Host "✓ Deployed!" -ForegroundColor Green
} else {
    Write-Host "✗ Compilation Failed! Exit Code: $($p.ExitCode)" -ForegroundColor Red
    exit 1
}
