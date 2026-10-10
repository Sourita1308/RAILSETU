$user = '$railway-app-e7bhahbshp6ca'
$pass = 'Da5wmvsin9HvjWnjCurhzgy3EgR31QvX4FPfJ9KNejlE19WBaXz1cJbP2dn4'
$pair = $user + ':' + $pass
$b = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($pair))
$uri = 'https://railway-app-e7bhahbshp6ca.scm.azurewebsites.net/api/vfs/site/wwwroot/webapps/ROOT.war'
Write-Host "Uploading WAR to $uri ..."
Invoke-WebRequest -Uri $uri -Method Put -InFile 'target\\RailwayManagement.war' -Headers @{ Authorization = "Basic $b" } -TimeoutSec 300 -UseBasicParsing -Verbose
Write-Host "Upload completed (or error thrown)."
