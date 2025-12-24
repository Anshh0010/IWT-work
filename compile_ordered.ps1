# PowerShell Compilation V5 (Ordered & Direct)
$java_home = "C:\Program Files\Java\jdk-24"
$tomcat_home = "C:\Program Files\Apache Software Foundation\Tomcat 9.0"
$project_home = "c:\Users\HP\DBMS project 2"
$classes_dir = "$project_home\src\main\webapp\WEB-INF\classes"
$src_root = "$project_home\src\main\java\com\sms"

Write-Host "Compiling V5 (Ordered)..." -ForegroundColor Cyan

# Clean
if (Test-Path $classes_dir) { Remove-Item $classes_dir -Recurse -Force }
New-Item -ItemType Directory -Path $classes_dir | Out-Null

$classpath = "$tomcat_home\lib\servlet-api.jar;$tomcat_home\lib\jsp-api.jar;$tomcat_home\lib\el-api.jar;$tomcat_home\lib\mysql-connector-java-8.0.33.jar;$classes_dir"
$javac = "$java_home\bin\javac.exe"

function Compile-Package($pkgName, $path) {
    Write-Host "Compiling $pkgName..."
    $files = Get-ChildItem -Path $path -Filter "*.java" | Select-Object -ExpandProperty FullName
    if ($files) {
        # Pass files as separate arguments to & operator
        & $javac -d $classes_dir -cp $classpath $files
        if ($LASTEXITCODE -ne 0) {
            Write-Host "✗ Failed to compile $pkgName" -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "No files in $pkgName" -ForegroundColor Yellow
    }
}

Compile-Package "Utils" "$src_root\util"
Compile-Package "Models" "$src_root\model"
Compile-Package "DAOs" "$src_root\dao"
Compile-Package "Filters" "$src_root\filter"
Compile-Package "Servlets" "$src_root\servlet"

Write-Host "✓ Compilation Successful!" -ForegroundColor Green

# Deploy
$webapps = "$tomcat_home\webapps\StudentManagementSystem"
Write-Host "Deploying..."

if (Test-Path "$webapps\WEB-INF\classes") { Remove-Item "$webapps\WEB-INF\classes" -Recurse -Force }

Copy-Item $classes_dir "$webapps\WEB-INF\" -Recurse -Force
Copy-Item "$project_home\src\main\webapp\register.jsp" "$webapps\register.jsp" -Force
Copy-Item "$project_home\src\main\webapp\dbtest.jsp" "$webapps\dbtest.jsp" -Force
Copy-Item "$project_home\src\main\webapp\WEB-INF\web.xml" "$webapps\WEB-INF\web.xml" -Force

Write-Host "✓ Deployed!" -ForegroundColor Green
