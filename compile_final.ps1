# PowerShell Compilation Script (Fixed Quotes)
$java_home = "C:\Program Files\Java\jdk-24"
$tomcat_home = "C:\Program Files\Apache Software Foundation\Tomcat 9.0"
$project_home = "c:\Users\HP\DBMS project 2"
$classes_dir = "$project_home\src\main\webapp\WEB-INF\classes"

Write-Host "Compiling with PowerShell (Fixed)..." -ForegroundColor Cyan

# Clean
if (Test-Path $classes_dir) { Remove-Item $classes_dir -Recurse -Force }
New-Item -ItemType Directory -Path $classes_dir | Out-Null

# Classpath
$classpath = "$tomcat_home\lib\servlet-api.jar;$tomcat_home\lib\jsp-api.jar;$tomcat_home\lib\el-api.jar;$tomcat_home\lib\mysql-connector-java-8.0.33.jar"

# Get Sources and Quote them
$sources = Get-ChildItem -Path "$project_home\src\main\java" -Recurse -Filter "*.java" | ForEach-Object { '"' + $_.FullName + '"' }

# Create sources file with UTF-8 encoding
$sources | Set-Content -Path "sources_final.txt" -Encoding Ascii

# Compile
$javac = "$java_home\bin\javac.exe"
$args = @("-d", $classes_dir, "-cp", $classpath, "@sources_final.txt")

Write-Host "Running javac..."
& $javac $args

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Compilation Successful!" -ForegroundColor Green
    
    # Deploy
    Write-Host "Deploying..."
    $webapp_dir = "$tomcat_home\webapps\StudentManagementSystem"
    
    # Stop Tomcat (optional, cleaner)
    # Stop-Service Tomcat9 -ErrorAction SilentlyContinue
    
    Copy-Item "$project_home\src\main\webapp\register.jsp" "$webapp_dir\register.jsp" -Force
    Copy-Item "$project_home\src\main\webapp\WEB-INF\web.xml" "$webapp_dir\WEB-INF\web.xml" -Force
    Copy-Item $classes_dir "$webapp_dir\WEB-INF\" -Recurse -Force
    
    Write-Host "✓ Deployed!" -ForegroundColor Green
} else {
    Write-Host "✗ Compilation Failed!" -ForegroundColor Red
    exit 1
}
