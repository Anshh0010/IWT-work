# PowerShell Compilation Script (Smart + Log)
$java_home = "C:\Program Files\Java\jdk-24"
$tomcat_home = "C:\Program Files\Apache Software Foundation\Tomcat 9.0"
$project_home = "c:\Users\HP\DBMS project 2"
$classes_dir = "$project_home\src\main\webapp\WEB-INF\classes"
$source_path = "$project_home\src\main\java"
$log_file = "$project_home\compile_smart.log"

Write-Host "Compiling with Smart Sourcepath (Logging)..." -ForegroundColor Cyan

# Clean
if (Test-Path $classes_dir) { Remove-Item $classes_dir -Recurse -Force }
New-Item -ItemType Directory -Path $classes_dir | Out-Null

$classpath = "$tomcat_home\lib\servlet-api.jar;$tomcat_home\lib\jsp-api.jar;$tomcat_home\lib\el-api.jar;$tomcat_home\lib\mysql-connector-java-8.0.33.jar"

$sources = Get-ChildItem -Path $source_path -Recurse -Filter "*.java" | Select-Object -ExpandProperty FullName

$javac = "$java_home\bin\javac.exe"
$args_list = @("-d", $classes_dir, "-cp", $classpath, "-sourcepath", $source_path) + $sources

# Run with redirect
$p = Start-Process -FilePath $javac -ArgumentList $args_list -Wait -NoNewWindow -PassThru -RedirectStandardError $log_file -RedirectStandardOutput $log_file

if ($p.ExitCode -eq 0) {
    Write-Host "✓ Compilation Successful!" -ForegroundColor Green
    Copy-Item $classes_dir "$tomcat_home\webapps\StudentManagementSystem\WEB-INF\" -Recurse -Force
} else {
    Write-Host "✗ Compilation Failed! Exit Code: $($p.ExitCode)" -ForegroundColor Red
}

Write-Host "--- Log ---"
Get-Content $log_file
Write-Host "-----------"
