import urllib.parse
import urllib.request
import ssl

BASE = 'https://railway-app-e7bhahbshp6ca.azurewebsites.net/'
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

# First, test GET /signup
try:
    with urllib.request.urlopen(BASE + 'signup.jsp', context=ctx) as resp:
        print('GET /signup.jsp', resp.status)
        html = resp.read().decode('utf-8', errors='replace')
        print('signup page title snippet:', html[0:200])
except Exception as e:
    print('GET signup failed:', type(e), e)

# Try to sign up a test user
signup_data = {
    'name': 'Auto Tester',
    'email': 'auto_test_user_2026@example.com',
    'phone': '9998887777',
    'location': 'Test City',
    'location-type': 'home',
    'password': 'TestPass123',
    'age': '30'
}

req = urllib.request.Request(BASE + 'signup', data=urllib.parse.urlencode(signup_data).encode('utf-8'), method='POST')
req.add_header('Content-Type', 'application/x-www-form-urlencoded')
try:
    with urllib.request.urlopen(req, context=ctx) as resp:
        print('POST /signup ->', resp.status)
        body = resp.read().decode('utf-8', errors='replace')
        print('Response snippet:', body[:4000])
except urllib.error.HTTPError as e:
    print('HTTPError', e.code)
    print(e.read().decode('utf-8', errors='replace')[:4000])
except Exception as e:
    print('Signup exception:', type(e), e)
