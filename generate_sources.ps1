$project_home = "c:\Users\HP\DBMS project 2"
$sources = Get-ChildItem -Path "$project_home\src\main\java" -Recurse -Filter "*.java"
$sources | ForEach-Object { '"' + $_.FullName + '"' } | Set-Content -Path "$project_home\sources.txt" -Encoding Ascii
Write-Host "Generated sources.txt with $($sources.Count) files."
