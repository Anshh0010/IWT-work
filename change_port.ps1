# Change Tomcat Port to 3080
$serverXmlPath = "C:\Program Files\Apache Software Foundation\Tomcat 9.0\conf\server.xml"

Write-Host "Changing Tomcat port from 8080 to 3080..." -ForegroundColor Yellow

# Read the file
$content = Get-Content $serverXmlPath -Raw

# Replace port 8080 with 3080
$newContent = $content -replace 'port="8080"', 'port="3080"'

# Write back
Set-Content -Path $serverXmlPath -Value $newContent

Write-Host "✓ Port changed to 3080 successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Tomcat will now run on: http://localhost:3080" -ForegroundColor Cyan
