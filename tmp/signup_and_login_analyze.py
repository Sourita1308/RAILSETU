import urllib.parse
import urllib.request
import ssl

BASE = 'https://railway-app-e7bhahbshp6ca.azurewebsites.net/'
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

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
        body = resp.read().decode('utf-8', errors='replace')
        print('status', resp.status)
        markers = ['Invalid email or password', 'Signup successful', 'An account with this email already exists', 'A database error occurred', 'Email and Password are required', 'Name, Email, and Password are required']
        for m in markers:
            if m in body:
                print('FOUND:', m)
        if 'login.jsp' in body:
            print('Contains login.jsp')
        if 'signup.jsp' in body:
            print('Contains signup.jsp')
        print('Body tail:', body[-600:])
except urllib.error.HTTPError as e:
    print('HTTPError', e.code)
    body = e.read().decode('utf-8', errors='replace')
    print(body[-600:])
except Exception as e:
    print('Exception', type(e), e)
