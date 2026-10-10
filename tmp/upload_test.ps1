$user = '$railway-app-e7bhahbshp6ca'
$pass = 'Da5wmvsin9HvjWnjCurhzgy3EgR31QvX4FPfJ9KNejlE19WBaXz1cJbP2dn4'
$pair = $user + ':' + $pass
$b = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($pair))
$uri = 'https://railway-app-e7bhahbshp6ca.scm.azurewebsites.net/api/vfs/site/wwwroot/test-upload.txt'
# create small test file
Set-Content -Path .\tmp\test-upload.txt -Value "kudu upload test $(Get-Date)"
Write-Host "Uploading test file to $uri ..."
Invoke-WebRequest -Uri $uri -Method Put -InFile .\tmp\test-upload.txt -Headers @{ Authorization = "Basic $b" } -TimeoutSec 60 -UseBasicParsing -Verbose
Write-Host "Upload completed (or error thrown)."
