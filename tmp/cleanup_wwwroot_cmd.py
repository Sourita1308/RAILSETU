import urllib.request
import json
import base64

user = '$railway-app-e7bhahbshp6ca'
password = 'Da5wmvsin9HvjWnjCurhzgy3EgR31QvX4FPfJ9KNejlE19WBaXz1cJbP2dn4'
creds = base64.b64encode(f"{user}:{password}".encode('utf-8')).decode('utf-8')
headers = {
    'Authorization': 'Basic ' + creds,
    'Content-Type': 'application/json'
}

body = json.dumps({
    'command': 'rm -f /home/site/wwwroot/hostingstart.html /home/site/wwwroot/test-upload.txt'
}).encode('utf-8')
req = urllib.request.Request('https://railway-app-e7bhahbshp6ca.scm.azurewebsites.net/api/command', data=body, headers=headers, method='POST')
with urllib.request.urlopen(req) as resp:
    print(resp.status)
    print(resp.read().decode('utf-8'))

list_req = urllib.request.Request('https://railway-app-e7bhahbshp6ca.scm.azurewebsites.net/api/vfs/site/wwwroot/', headers={'Authorization': 'Basic ' + creds})
with urllib.request.urlopen(list_req) as resp:
    print(resp.read().decode('utf-8'))
