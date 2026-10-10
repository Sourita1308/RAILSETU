$user = '$railway-app-e7bhahbshp6ca'
$pass = 'Da5wmvsin9HvjWnjCurhzgy3EgR31QvX4FPfJ9KNejlE19WBaXz1cJbP2dn4'
$pair = $user + ':' + $pass
$b = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($pair))
$uri = 'https://railway-app-e7bhahbshp6ca.scm.azurewebsites.net/api/vfs/site/wwwroot/'
Write-Host "Listing $uri"
Invoke-RestMethod -Uri $uri -Headers @{ Authorization = "Basic $b" } -Method Get -UseBasicParsing | ConvertTo-Json -Depth 10 | Write-Output
