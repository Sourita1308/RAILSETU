import urllib.request
import base64
import sys

user = '$railway-app-e7bhahbshp6ca'
password = 'Da5wmvsin9HvjWnjCurhzgy3EgR31QvX4FPfJ9KNejlE19WBaXz1cJbP2dn4'
creds = base64.b64encode(f"{user}:{password}".encode('utf-8')).decode('utf-8')
headers = {'Authorization': 'Basic ' + creds}

urls = [
    'https://railway-app-e7bhahbshp6ca.scm.azurewebsites.net/api/vfs/site/wwwroot/hostingstart.html',
    'https://railway-app-e7bhahbshp6ca.scm.azurewebsites.net/api/vfs/site/wwwroot/test-upload.txt'
]

for url in urls:
    req = urllib.request.Request(url, method='DELETE', headers=headers)
    try:
        with urllib.request.urlopen(req) as resp:
            print(f'DELETED {url} -> {resp.status}')
    except urllib.error.HTTPError as exc:
        print(f'FAILED {url} -> {exc.code} {exc.reason}')

list_req = urllib.request.Request('https://railway-app-e7bhahbshp6ca.scm.azurewebsites.net/api/vfs/site/wwwroot/', headers=headers)
with urllib.request.urlopen(list_req) as resp:
    print(resp.read().decode('utf-8'))
