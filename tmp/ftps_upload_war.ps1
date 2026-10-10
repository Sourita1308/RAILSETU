$ftpHost = 'waws-prod-pn1-043.ftp.azurewebsites.windows.net'
$remoteDir = '/site/wwwroot/webapps'
$remotePath = "$remoteDir/ROOT.war"
$user = 'railway-app-e7bhahbshp6ca\$railway-app-e7bhahbshp6ca'
$pass = 'Da5wmvsin9HvjWnjCurhzgy3EgR31QvX4FPfJ9KNejlE19WBaXz1cJbP2dn4'
$bytes = [System.IO.File]::ReadAllBytes('target\\RailwayManagement.war')

function Make-FtpDirectory($uri, $cred){
    try{
        $req = [System.Net.FtpWebRequest]::Create($uri)
        $req.Method = [System.Net.WebRequestMethods+Ftp]::MakeDirectory
        $req.Credentials = $cred
        $req.EnableSsl = $true
        $req.UsePassive = $true
        $resp = $req.GetResponse()
        $resp.Close()
        Write-Host "Created directory $uri"
    } catch {
        Write-Host "MakeDir: $($_.Exception.Message)"
    }
}

$cred = New-Object System.Net.NetworkCredential($user, $pass)
$mkUri = "ftps://$ftpHost$remoteDir"
Make-FtpDirectory $mkUri $cred

$uploadUri = "ftps://$ftpHost$remotePath"
$req = [System.Net.FtpWebRequest]::Create($uploadUri)
$req.Method = [System.Net.WebRequestMethods+Ftp]::UploadFile
$req.Credentials = $cred
$req.EnableSsl = $true
$req.UseBinary = $true
$req.UsePassive = $true
$req.KeepAlive = $false
$req.ContentLength = $bytes.Length
$rs = $req.GetRequestStream()
$rs.Write($bytes,0,$bytes.Length)
$rs.Close()
$resp = $req.GetResponse()
Write-Host "Upload status: $($resp.StatusDescription)"
$resp.Close()
