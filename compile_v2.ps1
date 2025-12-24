# PowerShell Compilation Script V2 (Start-Process)
$java_home = "C:\Program Files\Java\jdk-24"
$tomcat_home = "C:\Program Files\Apache Software Foundation\Tomcat 9.0"
$project_home = "c:\Users\HP\DBMS project 2"
$classes_dir = "$project_home\src\main\webapp\WEB-INF\classes"

Write-Host "Compiling with PowerShell V2..." -ForegroundColor Cyan

# Clean Local
if (Test-Path $classes_dir) { Remove-Item $classes_dir -Recurse -Force }
New-Item -ItemType Directory -Path $classes_dir | Out-Null

# Classpath
$classpath = "$tomcat_home\lib\servlet-api.jar;$tomcat_home\lib\jsp-api.jar;$tomcat_home\lib\el-api.jar;$tomcat_home\lib\mysql-connector-java-8.0.33.jar"

# Get Sources (Absolute paths)
$sources = Get-ChildItem -Path "$project_home\src\main\java" -Recurse -Filter "*.java" | Select-Object -ExpandProperty FullName

Write-Host "Found $($sources.Count) source files."

# Construct Arguments for javac
# -d output_dir
# -cp classpath
# source_files...
$javac = "$java_home\bin\javac.exe"
$arguments = @("-d", $classes_dir, "-cp", $classpath) + $sources

Write-Host "Starting javac..."
$p = Start-Process -FilePath $javac -ArgumentList $arguments -Wait -NoNewWindow -PassThru

if ($p.ExitCode -eq 0) {
    Write-Host "✓ Compilation Successful!" -ForegroundColor Green
    
    # Verify
    $count = (Get-ChildItem $classes_dir -Recurse -Filter "*.class").Count
    Write-Host "Generated $count class files."
    
    if ($count -gt 0) {
        # Clean Remote
        $tomcat_classes = "$tomcat_home\webapps\StudentManagementSystem\WEB-INF\classes"
        Write-Host "Cleaning Tomcat classes..."
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
        Write-Host "✗ Compilation succeeded but NO CLASSES generated!" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "✗ Compilation Failed! Exit Code: $($p.ExitCode)" -ForegroundColor Red
    exit 1
}
