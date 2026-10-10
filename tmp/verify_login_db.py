import urllib.parse
import urllib.request
import ssl

url = 'https://railway-app-e7bhahbshp6ca.azurewebsites.net/login'
data = urllib.parse.urlencode({'email': 'test@example.com', 'password': 'Test1234'}).encode('utf-8')
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE
req = urllib.request.Request(url, data=data, method='POST')
req.add_header('Content-Type', 'application/x-www-form-urlencoded')
try:
    with urllib.request.urlopen(req, context=ctx) as resp:
        body = resp.read().decode('utf-8', errors='replace')
        print('STATUS', resp.status)
        print(body[:4000])
except urllib.error.HTTPError as e:
    print('HTTP', e.code)
    print(e.read().decode('utf-8', errors='replace')[:4000])
