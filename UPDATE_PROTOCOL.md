# Omaha 4 Update Protocol

Wanderlust API implements the Google Omaha 4 JSON update protocol at `POST /v4/update`. The native [`custom-omaha-client`](https://github.com/eightpoint/custom-omaha-client) binary uses this endpoint to check for browser updates and download installers.

---

## Endpoint

```
POST /v4/update
Content-Type: application/json
```

No authentication required. The endpoint bypasses the global `ApiResponseWrapperAttribute` and returns raw Omaha 4 JSON directly.

### Request body

```json
{
  "request": {
    "protocol": "4.0",
    "sessionId": "{UUID}",
    "isMachine": false,
    "os": {
      "platform": "win",
      "version": "10.0.26200",
      "arch": "x64"
    },
    "apps": [
      {
        "appId": "{A1B2C3D4-E5F6-7890-ABCD-EF1234567890}",
        "version": "1.0.0.0",
        "lang": "en",
        "installSource": "update",
        "updateCheck": {}
      }
    ]
  }
}
```

| Field | Values |
|---|---|
| `os.platform` | `win` \| `linux` \| `mac` |
| `os.arch` | `x64` \| `x86` \| `arm64` |
| `apps[].appId` | Must match a registered app ID in `BrowserReleases` |
| `apps[].version` | Four-part version string, e.g. `1.0.0.0` |

### Response — update available

```json
{
  "response": {
    "apps": [
      {
        "updateCheck": {
          "status": "ok",
          "manifest": {
            "version": "1.0.1.0",
            "packages": [
              {
                "name": "wanderlust-setup-1.0.1.0-win-x64.exe",
                "hash_sha256": "a1b2c3d4...",
                "url": "https://cdn.wanderlustbrowser.com/releases/1.0.1.0/wanderlust-setup-1.0.1.0-win-x64.exe",
                "size": 98304000
              }
            ]
          }
        }
      }
    ]
  }
}
```

### Response — already up to date

```json
{
  "response": {
    "apps": [{ "updateCheck": { "status": "noupdate" } }]
  }
}
```

### Response — error

```json
{
  "response": {
    "apps": [{ "updateCheck": { "status": "error", "errorMessage": "..." } }]
  }
}
```

### Version logic

The server compares the client's `apps[].version` against the most recently created active release in `BrowserReleases` for the matching `(appId, platform, arch)` triple using `System.Version` four-part comparison. If the stored version is strictly greater than the client version, the response is `ok` with the installer manifest. Otherwise it is `noupdate`.

---

## Releases Admin API

Manage available releases via the authenticated REST API (`JWT Bearer` required).

### List releases

```
GET /api/releases
Authorization: Bearer <token>
```

Returns all active `BrowserRelease` records in descending creation order.

### Publish a new release

```
POST /api/releases
Authorization: Bearer <token>
Content-Type: application/json

{
  "appId":         "{A1B2C3D4-E5F6-7890-ABCD-EF1234567890}",
  "version":       "1.0.1.0",
  "platform":      "win",
  "arch":          "x64",
  "installerName": "wanderlust-setup-1.0.1.0-win-x64.exe",
  "installerUrl":  "https://cdn.wanderlustbrowser.com/releases/1.0.1.0/wanderlust-setup-1.0.1.0-win-x64.exe",
  "hashSha256":    "a1b2c3d4e5f6...",
  "sizeBytes":     98304000
}
```

The `InstallerUrl` should be a stable CDN or storage link. The client downloads directly from this URL — the API does not proxy the file.

### Deactivate a release

```
POST /api/releases/{id}/deactivate
Authorization: Bearer <token>
```

Soft-deletes a release (sets `IsActive = 0`). The update endpoint never returns deactivated releases. Use this to roll back a bad build without deleting the record.

> **IONOS note**: PUT and DELETE HTTP verbs are blocked by the host. All mutations use POST.

---

## Database

Run `Migrations/add_browser_releases.sql` once against the SQL Server instance before deploying. The migration is idempotent (`IF NOT EXISTS`).

```sql
-- key columns
AppId         NVARCHAR(64)   -- app GUID from config.h
Version       NVARCHAR(32)   -- four-part, e.g. 1.0.1.0
Platform      NVARCHAR(16)   -- win | linux | mac
Arch          NVARCHAR(8)    -- x64 | x86 | arm64
InstallerUrl  NVARCHAR(1024) -- direct HTTPS download link
HashSha256    NVARCHAR(128)  -- hex-encoded SHA-256
SizeBytes     BIGINT
IsActive      BIT DEFAULT 1  -- soft-delete flag
CreatedAt     DATETIME2      -- most recent active row wins
```

A non-clustered index on `(AppId, Platform, Arch, IsActive, CreatedAt DESC)` covers the primary update lookup query.

---

## Adding a New Platform

1. Build an installer for the target platform.
2. Hash it: `sha256sum installer.bin` (or `CertUtil -hashfile installer.exe SHA256` on Windows).
3. Upload to CDN / Azure Blob / wherever `InstallerUrl` points.
4. `POST /api/releases` with `"platform": "linux"` (or `"mac"`) and the new fields.

No code changes required — the `(appId, platform, arch)` lookup is fully data-driven.

---

## Code Layout

```
Controllers/
  OmahaController.cs     POST /v4/update — anonymous, raw JSON, SkipResponseWrapper
  ReleasesController.cs  GET|POST /api/releases — JWT-protected admin CRUD
Data/
  Entities/BrowserRelease.cs
  Repositories/IBrowserReleaseRepository.cs
  Repositories/BrowserReleaseRepository.cs   (Dapper)
  Mock/MockBrowserReleaseRepository.cs       (DB-unavailable fallback)
Filters/
  ApiResponseFilters.cs  SkipResponseWrapperAttribute — opt-out from the global wrapper
Migrations/
  add_browser_releases.sql
Models/
  Omaha/OmahaRequest.cs
  Omaha/OmahaResponse.cs
```

---

## Client

The native update client is [`custom-omaha-client`](https://github.com/eightpoint/custom-omaha-client). Its compile-time defaults match this server:

```
Server URL:  https://update.wanderlustbrowser.com/v4/update
App ID:      {A1B2C3D4-E5F6-7890-ABCD-EF1234567890}
```

The client binary is invoked as a subprocess by `custom-browser`'s auto-update system (`src/custom/chrome/browser/autoupdate/`).
