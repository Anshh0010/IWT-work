# PowerShell Compilation Loop (Direct Invocation)
$java_home = "C:\Program Files\Java\jdk-24"
$tomcat_home = "C:\Program Files\Apache Software Foundation\Tomcat 9.0"
$project_home = "c:\Users\HP\DBMS project 2"
$classes_dir = "$project_home\src\main\webapp\WEB-INF\classes"

Write-Host "Compiling Loop (Direct)..." -ForegroundColor Cyan

# Clean
if (Test-Path $classes_dir) { Remove-Item $classes_dir -Recurse -Force }
New-Item -ItemType Directory -Path $classes_dir | Out-Null

# Classpath (Quote paths in variables if needed, but PS handles object passing well usually)
$classpath = "$tomcat_home\lib\servlet-api.jar;$tomcat_home\lib\jsp-api.jar;$tomcat_home\lib\el-api.jar;$tomcat_home\lib\mysql-connector-java-8.0.33.jar;$classes_dir"

$sources = Get-ChildItem -Path "$project_home\src\main\java" -Recurse -Filter "*.java"
$total = $sources.Count
$current = 0
$errors = 0

foreach ($file in $sources) {
    try {
        $current++
        Write-Host "[$current/$total] Compiling $($file.Name)..."
        
        # Use simple direct invocation
        & "$java_home\bin\javac.exe" -d "$classes_dir" -cp "$classpath" "$($file.FullName)"
        
        if ($LASTEXITCODE -ne 0) {
            Write-Host "ERROR compiling $($file.Name)" -ForegroundColor Red
            $errors++
        }
    } catch {
        Write-Host "EXCEPTION: $_" -ForegroundColor Red
        $errors++
    }
}

if ($errors -eq 0) {
    Write-Host "✓ All files compiled successfully!" -ForegroundColor Green
    
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
    Write-Host "✗ Compilation Failed with $errors errors!" -ForegroundColor Red
    exit 1
}
