"""Smoke test for release-publishing authorization and input validation.

Run against a LOCAL WanderlustApi in Development (it falls back to mock data when
no database is reachable):

    $env:ASPNETCORE_ENVIRONMENT = 'Development'; dotnet run      # http://localhost:5070
    python scripts/test_release_auth.py [base-url]

It mints HS256 tokens for a Member and an Admin with the Development signing key
from appsettings.Development.json. Never point it at production and never put a
production secret in that file: with the key, anyone can mint an Admin token.
Expected: Member/anonymous get 401/403 on every release, what's-new write and
diagnostic endpoint; Admin passes authorization; invalid release requests get 400.
"""
import base64, hashlib, hmac, io, json, sys, time, urllib.request, urllib.error

BASE = sys.argv[1].rstrip('/') if len(sys.argv) > 1 else 'http://localhost:5070'
import os
raw = open(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..', 'appsettings.Development.json'), 'rb').read()
cfg = json.loads(raw.decode('utf-16' if raw[:2] in (b'\xff\xfe', b'\xfe\xff') else 'utf-8-sig'))['JWT']
ROLE = 'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'
NAME = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/name'
NID = 'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'


def b64(b):
    return base64.urlsafe_b64encode(b).rstrip(b'=').decode()


def token(role, uid):
    h = b64(json.dumps({'alg': 'HS256', 'typ': 'JWT'}).encode())
    now = int(time.time())
    p = b64(json.dumps({NID: str(uid), NAME: role.lower() + '-test', ROLE: role, 'sub': str(uid),
                        'iat': now, 'nbf': now - 5, 'exp': now + 600,
                        'iss': cfg['Issuer'], 'aud': cfg['Audience']}).encode())
    sig = b64(hmac.new(cfg['SecretKey'].encode(), f'{h}.{p}'.encode(), hashlib.sha256).digest())
    return f'{h}.{p}.{sig}'


def call(method, path, tok=None, body=None):
    req = urllib.request.Request(BASE + path, method=method,
                                 data=json.dumps(body).encode() if body is not None else None)
    req.add_header('Content-Type', 'application/json')
    if tok:
        req.add_header('Authorization', 'Bearer ' + tok)
    try:
        r = urllib.request.urlopen(req, timeout=15)
        return r.status, r.read().decode()[:300]
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode()[:300]


GOOD = {'appId': '{8A69D345-D564-463c-AFF1-A69D9E530F96}', 'version': '9.9.9.0', 'platform': 'win', 'arch': 'x64',
        'installerName': 'wanderlust-setup-9.9.9.0-win-x64.exe',
        'installerUrl': 'https://api.wander-lust.tech/releases/wanderlust-setup-9.9.9.0-win-x64.exe',
        'hashSha256': 'a' * 64, 'sizeBytes': 100000000, 'rolloutWeight': 100}

member, admin = token('Member', 2), token('Admin', 1)
fails = 0


def check(name, got, want):
    global fails
    ok = got in want if isinstance(want, (list, tuple, set)) else got == want
    fails += 0 if ok else 1
    print(('PASS ' if ok else 'FAIL ') + name + f'  -> {got} (want {want})')


# --- authorization
check('anonymous  POST /api/releases', call('POST', '/api/releases', None, GOOD)[0], 401)
check('Member     POST /api/releases', call('POST', '/api/releases', member, GOOD)[0], 403)
check('Member     GET  /api/releases', call('GET', '/api/releases', member)[0], 403)
check('Member     POST /api/releases/1/deactivate', call('POST', '/api/releases/1/deactivate', member)[0], 403)
check('Member     POST /api/releases/1/activate', call('POST', '/api/releases/1/activate', member)[0], 403)
check('Member     POST /api/whatsnew', call('POST', '/api/whatsnew', member, {'appId': GOOD['appId'], 'version': '9.9.9.0', 'title': 't', 'body': 'b'})[0], 403)
check('Member     POST /api/whatsnew/1/deactivate', call('POST', '/api/whatsnew/1/deactivate', member)[0], 403)
check('anonymous  GET  /api/auth/test-jwt', call('GET', '/api/auth/test-jwt')[0], 401)
check('Member     GET  /api/auth/test-jwt', call('GET', '/api/auth/test-jwt', member)[0], 403)
check('anonymous  GET  /api/auth/config-status', call('GET', '/api/auth/config-status')[0], 401)
check('Member     GET  /api/auth/config-status', call('GET', '/api/auth/config-status', member)[0], 403)
# --- still public
check('anonymous  GET  /api/whatsnew (public read)', call('GET', '/api/whatsnew?appId=x')[0], 200)
check('anonymous  POST /v4/update (the updater)', call('POST', '/v4/update', None, {'protocol': '4.0', 'apps': [{'appId': GOOD['appId'], 'version': '1.0.0.0', 'updateCheck': {}}], 'os': {'platform': 'win', 'version': '10', 'arch': 'x64'}})[0], 200)
# --- Admin is allowed through authorization; validation applies
check('Admin      GET  /api/releases', call('GET', '/api/releases', admin)[0], 200)
check('Admin      POST valid release (mock repo accepts)', call('POST', '/api/releases', admin, GOOD)[0], [200, 201])
bad = {
    'attacker URL host': dict(GOOD, installerUrl='https://evil.example/x.exe'),
    'http (not https) URL': dict(GOOD, installerUrl='http://api.wander-lust.tech/releases/x.exe'),
    'URL with credentials': dict(GOOD, installerUrl='https://user:pw@api.wander-lust.tech/releases/x.exe'),
    'host look-alike suffix': dict(GOOD, installerUrl='https://api.wander-lust.tech.evil.example/x.exe'),
    'bad hash length': dict(GOOD, hashSha256='abc'),
    'non-hex hash': dict(GOOD, hashSha256='z' * 64),
    'three-part version': dict(GOOD, version='1.2.3'),
    'non-numeric version': dict(GOOD, version='1.x.3.0'),
    'unknown platform': dict(GOOD, platform='amiga'),
    'unknown arch': dict(GOOD, arch='mips'),
    'path in installerName': dict(GOOD, installerName='../x.exe'),
    'weight 150': dict(GOOD, rolloutWeight=150),
    'weight -1': dict(GOOD, rolloutWeight=-1),
    'size 0': dict(GOOD, sizeBytes=0),
    'appId not a GUID': dict(GOOD, appId='hello'),
}
for label, body in bad.items():
    check('Admin      POST rejected: ' + label, call('POST', '/api/releases', admin, body)[0], 400)

# --- token with a wrong key must not work even with an Admin claim
forged = token('Admin', 1)[:-4] + 'AAAA'
check('forged-signature Admin token', call('POST', '/api/releases', forged, GOOD)[0], 401)
print('\nFAILED: %d' % fails)
sys.exit(1 if fails else 0)
