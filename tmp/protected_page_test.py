import urllib.request
import ssl

BASE = 'https://railway-app-e7bhahbshp6ca.azurewebsites.net/'
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

for path in ['dashboard.jsp', 'viewTrains.jsp', 'account.html']:
    req = urllib.request.Request(BASE + path)
    try:
        with urllib.request.urlopen(req, context=ctx) as resp:
            body = resp.read().decode('utf-8', errors='replace')
            print(path, resp.status, 'len=', len(body), 'title=', 'dashboard' if 'dashboard' in body.lower() else 'login' if 'login' in body.lower() else 'account' if 'account' in body.lower() else 'unknown')
    except urllib.error.HTTPError as e:
        print(path, 'HTTPError', e.code)
    except Exception as e:
        print(path, 'Exception', type(e), e)
