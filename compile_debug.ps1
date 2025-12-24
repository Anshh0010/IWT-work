# PowerShell Compilation Script (Debug)
$java_home = "C:\Program Files\Java\jdk-24"
$tomcat_home = "C:\Program Files\Apache Software Foundation\Tomcat 9.0"
$project_home = "c:\Users\HP\DBMS project 2"
$classes_dir = "$project_home\src\main\webapp\WEB-INF\classes"

Write-Host "Compiling with PowerShell (Debug)..." -ForegroundColor Cyan

# Clean Local
if (Test-Path $classes_dir) { Remove-Item $classes_dir -Recurse -Force }
New-Item -ItemType Directory -Path $classes_dir | Out-Null

# Classpath
$classpath = "$tomcat_home\lib\servlet-api.jar;$tomcat_home\lib\jsp-api.jar;$tomcat_home\lib\el-api.jar;$tomcat_home\lib\mysql-connector-java-8.0.33.jar"

# Get Sources
$sources = Get-ChildItem -Path "$project_home\src\main\java" -Recurse -Filter "*.java" | Select-Object -ExpandProperty FullName
Write-Host "Found $($sources.Count) source files."

# Compile
$javac = "$java_home\bin\javac.exe"
$compile_log = "$project_home\compile.log"

Write-Host "Running javac..."
& $javac -d $classes_dir -cp $classpath $sources 2> $compile_log

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Compilation Successful!" -ForegroundColor Green
} else {
    Write-Host "✗ Compilation Failed!" -ForegroundColor Red
}

# Show Log
Write-Host "--- Compilation Log ---"
Get-Content $compile_log
Write-Host "-----------------------"

# Check output dir
$files = Get-ChildItem -Path $classes_dir -Recurse
Write-Host "Generated $($files.Count) class files."
