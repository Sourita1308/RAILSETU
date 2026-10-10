import sys
import urllib.request
import base64

if len(sys.argv) != 2:
    raise SystemExit('Usage: python fetch_kudu_log.py <url>')
url = sys.argv[1]
user = '$railway-app-e7bhahbshp6ca'
password = 'Da5wmvsin9HvjWnjCurhzgy3EgR31QvX4FPfJ9KNejlE19WBaXz1cJbP2dn4'
creds = base64.b64encode(f"{user}:{password}".encode('utf-8')).decode('utf-8')
req = urllib.request.Request(url)
req.add_header('Authorization', 'Basic ' + creds)
with urllib.request.urlopen(req) as resp:
    print(resp.read().decode('utf-8'))
