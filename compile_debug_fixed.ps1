# PowerShell Compilation Script (Debug Fixed)
$java_home = "C:\Program Files\Java\jdk-24"
$tomcat_home = "C:\Program Files\Apache Software Foundation\Tomcat 9.0"
$project_home = "c:\Users\HP\DBMS project 2"
$classes_dir = "$project_home\src\main\webapp\WEB-INF\classes"

Write-Host "Compiling with PowerShell (Debug)..." -ForegroundColor Cyan

# Clean Local
if (Test-Path $classes_dir) { Remove-Item $classes_dir -Recurse -Force }
New-Item -ItemType Directory -Path $classes_dir | Out-Null

# Classpath (Quote it)
$classpath = "$tomcat_home\lib\servlet-api.jar;$tomcat_home\lib\jsp-api.jar;$tomcat_home\lib\el-api.jar;$tomcat_home\lib\mysql-connector-java-8.0.33.jar"

# Get Sources
$sources = Get-ChildItem -Path "$project_home\src\main\java" -Recurse -Filter "*.java" | Select-Object -ExpandProperty FullName
Write-Host "Found $($sources.Count) source files."

# Compile
$javac = "$java_home\bin\javac.exe"
$compile_log = "$project_home\compile.log"

Write-Host "Running javac..."
# Use Start-Process to handle arguments safely
$argList = @("-d", $classes_dir, "-cp", $classpath) + $sources
$p = Start-Process -FilePath $javac -ArgumentList $argList -NoNewWindow -PassThru -RedirectStandardError $compile_log -Wait

if ($p.ExitCode -eq 0) {
    Write-Host "✓ Compilation Successful!" -ForegroundColor Green
} else {
    Write-Host "✗ Compilation Failed! Exit Code: $($p.ExitCode)" -ForegroundColor Red
}

# Show Log
Write-Host "--- Compilation Log ---"
if (Test-Path $compile_log) { Get-Content $compile_log }
Write-Host "-----------------------"

# Check output dir
$files = Get-ChildItem -Path $classes_dir -Recurse
Write-Host "Generated $($files.Count) class files."
