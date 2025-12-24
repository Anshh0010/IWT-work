# PowerShell Compilation V4
$java_home = "C:\Program Files\Java\jdk-24"
$tomcat_home = "C:\Program Files\Apache Software Foundation\Tomcat 9.0"
$project_home = "c:\Users\HP\DBMS project 2"
$classes_dir = "$project_home\src\main\webapp\WEB-INF\classes"

Write-Host "Compiling V4..." -ForegroundColor Cyan

# Clean
if (Test-Path $classes_dir) { Remove-Item $classes_dir -Recurse -Force }
New-Item -ItemType Directory -Path $classes_dir | Out-Null

# Classpath
$cp = "$tomcat_home\lib\servlet-api.jar;$tomcat_home\lib\jsp-api.jar;$tomcat_home\lib\el-api.jar;$tomcat_home\lib\mysql-connector-java-8.0.33.jar"

# Files
$files = Get-ChildItem -Path "$project_home\src\main\java" -Recurse -Filter "*.java" | Select-Object -ExpandProperty FullName
Write-Host "Files to compile: $($files.Count)"

# Arguments
$javac_args = @("-d", $classes_dir, "-cp", $cp) + $files

# Run
$p = Start-Process -FilePath "$java_home\bin\javac.exe" -ArgumentList $javac_args -Wait -NoNewWindow -PassThru

if ($p.ExitCode -eq 0) {
    Write-Host "✓ Compilation Successful!" -ForegroundColor Green
    
    # Deploy
    $webapps = "$tomcat_home\webapps\StudentManagementSystem"
    Write-Host "Deploying to $webapps..."
    
    # Clean remote classes
    if (Test-Path "$webapps\WEB-INF\classes") { Remove-Item "$webapps\WEB-INF\classes" -Recurse -Force }
    
    # Copy
    Copy-Item $classes_dir "$webapps\WEB-INF\" -Recurse -Force
    Copy-Item "$project_home\src\main\webapp\register.jsp" "$webapps\register.jsp" -Force
    Copy-Item "$project_home\src\main\webapp\dbtest.jsp" "$webapps\dbtest.jsp" -Force
    Copy-Item "$project_home\src\main\webapp\WEB-INF\web.xml" "$webapps\WEB-INF\web.xml" -Force
    
    Write-Host "✓ Deployed!" -ForegroundColor Green
} else {
    Write-Host "✗ Failed with code $($p.ExitCode)" -ForegroundColor Red
    exit 1
}
