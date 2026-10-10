import urllib.request
import base64

user = '$railway-app-e7bhahbshp6ca'
password = 'Da5wmvsin9HvjWnjCurhzgy3EgR31QvX4FPfJ9KNejlE19WBaXz1cJbP2dn4'
creds = base64.b64encode(f"{user}:{password}".encode('utf-8')).decode('utf-8')
req = urllib.request.Request(
    'https://railway-app-e7bhahbshp6ca.scm.azurewebsites.net/api/vfs/LogFiles/StartupLogs/')
req.add_header('Authorization', 'Basic ' + creds)
with urllib.request.urlopen(req) as resp:
    print(resp.read().decode('utf-8'))
