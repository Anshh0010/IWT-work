# Simple Compilation Test
$java_home = "C:\Program Files\Java\jdk-24"
$project_home = "c:\Users\HP\DBMS project 2"
$file = "$project_home\src\main\java\com\sms\util\DatabaseUtil.java"
$classes_dir = "$project_home\src\main\webapp\WEB-INF\classes"

# Create dir
New-Item -ItemType Directory -Path $classes_dir -Force | Out-Null

Write-Host "Compiling DatabaseUtil.java..."
& "$java_home\bin\javac.exe" -d $classes_dir $file

if ($LASTEXITCODE -eq 0) {
    Write-Host "SUCCESS" -ForegroundColor Green
} else {
    Write-Host "FAILURE" -ForegroundColor Red
}
