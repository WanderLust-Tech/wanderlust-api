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
    "clientVersion": "1.0.0.0",
    "installId": "{UUID}",
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
| `apps[].version` | Four-part version string, e.g. `1.0.0.0`. `"0.0.0.0"` (or empty) is a special sentinel meaning "brand-new install, no prior version" — see "Version logic" below. |
| `clientVersion` | Optional. The `omaha_client` updater tool's own release version (not the browser's) — logged for observability, not used in update-decision logic. Older clients may omit it. |
| `installId` | Optional. A stable per-install GUID, generated once and persisted by the client (**not** `sessionId`, which regenerates every check). Used to deterministically bucket this install for staged rollouts/A-B experiments — see "Version logic" below. Clients that omit it only ever receive releases with `RolloutWeight=100`. |

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

`OmahaController` fetches **every** active release for the matching
`(appId, platform, arch)` triple (`IBrowserReleaseRepository.GetActiveReleasesAsync`,
newest first), then hands them to `IReleaseRolloutSelector` to pick exactly
one — usually there's only one active row and this is a no-op, but multiple
can coexist during a staged rollout or A/B experiment.

**Selection (`ReleaseRolloutSelector`)** — a deterministic weighted
waterfall, tried newest-first:
1. If `installId` is missing, only releases with `RolloutWeight = 100` are
   eligible (never opt an unbucketable client into a partial experiment).
2. Compute `bucket = SHA256(installId + ":" + appId)[0..4] % 100` (0-99) —
   **not** a randomized/process-local hash, so the same install always
   lands in the same bucket across repeated checks.
3. Walk candidates newest-first, accumulating `RolloutWeight`; return the
   first whose cumulative range covers `bucket`.

A single active row at the default `RolloutWeight=100` covers every bucket
— today's "always get the newest active release" behavior is just the
degenerate case of this algorithm, unchanged for anyone who never sets a
custom weight.

**Version comparison** — once a release is selected: if the client's
`apps[].version` is the fresh-install sentinel (`"0.0.0.0"` or empty), the
selected release is always returned as `ok` — there's nothing to compare
against. Otherwise, `System.Version` four-part comparison applies as
before: `ok` if the selected release's version is strictly greater than
the client's, `noupdate` otherwise.

**Example** — stage v1.1.0.0 to 20% of installs, leaving v1.0.0.0 (already
active at the default weight) to cover the rest:

| Version | RolloutWeight | Result |
|---|---|---|
| 1.1.0.0 | 20 | buckets 0-19 |
| 1.0.0.0 | 100 | buckets 20-99 (and all clients with no `installId`) |

---

## Releases Admin API

Manage available releases via the authenticated REST API.

> **Admin only (since 2026-10-21).** Every `/api/releases` endpoint, and the
> write endpoints of `/api/whatsnew`, require a JWT whose role is **`Admin`**
> (`[Authorize(Roles = "Admin")]`, the same convention as the feedback triage
> endpoints). Before this, any logged-in user could publish: sign-up is open and
> new accounts are `Member`, so anyone could register and publish an installer URL
> that every install's updater would then download and run. A `Member` token now gets
> `403`, no token gets `401`.
>
> **Granting Admin** is a database operation (there is deliberately no API for it):
> `UPDATE Users SET Role = 'Admin' WHERE Username = N'<name>';`
> A token carries the role it was issued with, so log in again afterwards.
>
> The diagnostic endpoints `GET /api/auth/test-jwt` and `GET /api/auth/config-status`
> are Admin-only for the same reason (`test-jwt` used to hand out a validly signed
> token to anyone).
>
> `scripts/Add-BrowserRelease.ps1` and the generated `scripts/releases/*.sql` write
> to the database directly and are unaffected; they are the trusted path.

### List releases

```
GET /api/releases
Authorization: Bearer <admin token>
```

Returns **all** `BrowserRelease` records, including deactivated ones, in descending creation order.

### Publish a new release

```
POST /api/releases
Authorization: Bearer <admin token>
Content-Type: application/json

{
  "appId":         "{A1B2C3D4-E5F6-7890-ABCD-EF1234567890}",
  "version":       "1.0.1.0",
  "platform":      "win",
  "arch":          "x64",
  "installerName": "wanderlust-setup-1.0.1.0-win-x64.exe",
  "installerUrl":  "https://cdn.wanderlustbrowser.com/releases/1.0.1.0/wanderlust-setup-1.0.1.0-win-x64.exe",
  "hashSha256":    "a1b2c3d4e5f6...",
  "sizeBytes":     98304000,
  "rolloutWeight": 100,
  "experimentName": null
}
```

`rolloutWeight` and `experimentName` are both optional — omit them (or
pass `100`/`null`) for a normal release that should immediately replace
whatever was previously active. Set `rolloutWeight` lower to stage a
gradual rollout or run an A/B experiment alongside other still-active
releases for the same `appId`/`platform`/`arch` (see "Version logic"
above); `experimentName` is a free-text label for your own tracking, not
read by the selection logic.

`InstallerUrl` is stored as a plain string — the client downloads directly from whatever URL it points to; this API never proxies or reads the file's bytes through the update-check request itself. It can point to an external CDN/blob store, **or** this API's own self-hosted `/releases/` static route (see "Installer Hosting" below) — both work, see that section for the tradeoffs.

**Validation.** The request is rejected with `400 {"errors": [...]}` (one message per problem) unless:

| Field | Rule |
|---|---|
| `appId` | a GUID in braces, e.g. `{8A69D345-D564-463c-AFF1-A69D9E530F96}` |
| `version` | exactly four numeric parts (`1.11.15.0`) |
| `platform` / `arch` | `win`\|`linux`\|`mac` / `x64`\|`x86`\|`arm64` |
| `installerName` | a plain file name (letters, digits, `.`, `_`, `-`; no path) |
| `installerUrl` | `https://`, no credentials, and the host is on the allow-list — config key `Releases:AllowedInstallerHosts` (a string array); **default `api.wander-lust.tech`** (this API's own `/releases/` route). Add a CDN host there *before* publishing a release that points at it. |
| `hashSha256` | 64 hexadecimal characters |
| `sizeBytes` | 1 … 2 GiB |
| `rolloutWeight` | 0 … 100 |
| `experimentName` | at most 100 characters |

Every publish, activate and deactivate is written to the application log at *Warning* level with the acting user (name and id), e.g. `Release published by admin (id 1): id 44, app {…}, version 1.11.15.0, win/x64, weight 100, url …`. There is no "published by" database column yet.

### Deactivate a release

```
POST /api/releases/{id}/deactivate
Authorization: Bearer <admin token>
```

Soft-deletes a release (sets `IsActive = 0`). The update endpoint never returns deactivated releases. Use this to roll back a bad build without deleting the record.

> **IONOS note**: PUT and DELETE HTTP verbs are blocked by the host. All mutations use POST.

---

## Installer Hosting

`InstallerUrl` just needs to resolve to a direct HTTPS download of the installer binary — this API doesn't care where. Two supported options:

### Option A — external CDN / blob storage (originally documented default)

Upload the installer to whatever CDN/blob store you use, and set `installerUrl` to that stable link (e.g. `https://cdn.example.com/releases/1.0.1.0/wanderlust-setup-1.0.1.0-win-x64.exe`). Best if you expect meaningful download volume — large binaries never flow through this API's own process.

### Option B — self-hosted via this API's `/releases/` route

`Program.cs` serves static files from a `releases` folder via `app.UseStaticFiles()`:

```csharp
var releasesDir = Path.Combine(AppContext.BaseDirectory, "releases");
app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new PhysicalFileProvider(releasesDir),
    RequestPath = "/releases"
});
```

This exists specifically because **IONOS's IIS config does not serve static files natively** — `web.config`'s `AspNetCoreModuleV2` handler mapping is `path="*"` with no exclusion, so every request (including static content) gets routed into the .NET process regardless. Without this middleware, dropping a file into a `releases/` folder on the server does nothing — it 404s no matter what's on disk, because nothing ever handles that route.

To use this option:
1. FTP the installer into a `releases/` folder that's a **direct sibling of `web.config`/`WanderlustApi.dll`** on the server (i.e. `AppContext.BaseDirectory/releases` — not nested elsewhere, not the repo's own `Migrations/`-style layout).
2. Set `installerUrl` to `https://api.wander-lust.tech/releases/<installer-filename>.exe`.
3. Redeploy the API build that includes the `UseStaticFiles()` middleware above — it isn't live until that's published, separately from just uploading the file.

Fine for this project's current scale; if download volume grows, moving to Option A avoids routing large binary transfers through the managed ASP.NET Core pipeline.

---

## What's New Admin API

Deliberately **not** part of `BrowserRelease`/`api/releases` above — that
entity is pure Omaha installer metadata (one row per platform/arch per
version, no human-readable field at all). `chrome://whats-new` in the
browser needs a title/body per logical release, not per installer, so
this is a separate table/endpoint instead.

### List active entries (anonymous)

```
GET /api/whatsnew?appId={A1B2C3D4-E5F6-7890-ABCD-EF1234567890}
```

No `Authorization` header required — a `chrome://` WebUI page has no
login session with this API, and this data isn't sensitive. Returns all
active `WhatsNewEntry` records for the given `appId`, most recent first.

### Publish a new entry

```
POST /api/whatsnew
Authorization: Bearer <token>
Content-Type: application/json

{
  "appId":   "{A1B2C3D4-E5F6-7890-ABCD-EF1234567890}",
  "version": "1.7.32",
  "title":   "Floating undocked sidebar",
  "body":    "Right-click the sidebar and choose Undock to pop it into its own window."
}
```

### Deactivate an entry

```
POST /api/whatsnew/{id}/deactivate
Authorization: Bearer <token>
```

Same soft-delete/IONOS-no-PUT-DELETE convention as `/api/releases`.

---

## Database

Run `Migrations/add_browser_releases.sql` once against the SQL Server instance before deploying, then `Migrations/add_release_rollout.sql` for the rollout/A-B columns. Both are idempotent (`IF NOT EXISTS`).

```sql
-- key columns
AppId          NVARCHAR(64)   -- app GUID from config.h
Version        NVARCHAR(32)   -- four-part, e.g. 1.0.1.0
Platform       NVARCHAR(16)   -- win | linux | mac
Arch           NVARCHAR(8)    -- x64 | x86 | arm64
InstallerUrl   NVARCHAR(1024) -- direct HTTPS download link
HashSha256     NVARCHAR(128)  -- hex-encoded SHA-256
SizeBytes      BIGINT
IsActive       BIT DEFAULT 1     -- soft-delete flag
CreatedAt      DATETIME2         -- selection order (newest first)
RolloutWeight  INT DEFAULT 100   -- 0-100; see "Version logic"
ExperimentName NVARCHAR(128)     -- nullable, admin/reporting label only
```

A non-clustered index on `(AppId, Platform, Arch, IsActive, CreatedAt DESC)` covers the primary update lookup query.

Run `Migrations/add_whats_new_entries.sql` (same idempotent `IF NOT EXISTS` pattern) for the separate `WhatsNewEntries` table backing the API above.

---

## Adding a New Platform

1. Build an installer for the target platform.
2. Hash it: `sha256sum installer.bin` (or `CertUtil -hashfile installer.exe SHA256` on Windows).
3. Upload it per one of the two options in "Installer Hosting" above (CDN, or this API's own `/releases/` folder).
4. `POST /api/releases` with `"platform": "linux"` (or `"mac"`) and the new fields.

No code changes required — the `(appId, platform, arch)` lookup is fully data-driven.

---

## Code Layout

```
Controllers/
  OmahaController.cs     POST /v4/update — anonymous, raw JSON, SkipResponseWrapper
  ReleasesController.cs  GET|POST /api/releases — Admin-only CRUD, validated, audit-logged
  WhatsNewController.cs  GET /api/whatsnew (anonymous) | POST (Admin) — changelog entries
Data/
  Entities/BrowserRelease.cs
  Entities/WhatsNewEntry.cs
  Repositories/IBrowserReleaseRepository.cs
  Repositories/BrowserReleaseRepository.cs   (Dapper)
  Repositories/IWhatsNewRepository.cs
  Repositories/WhatsNewRepository.cs         (Dapper)
  Mock/MockBrowserReleaseRepository.cs       (DB-unavailable fallback)
  Mock/MockWhatsNewRepository.cs             (DB-unavailable fallback)
Services/
  ReleaseRolloutSelector.cs   Deterministic weighted waterfall bucketing (rollout/A-B)
  ReleaseRequestValidator.cs  Input rules for POST /api/releases (https + host allow-list, hash, version, ...)
Filters/
  ApiResponseFilters.cs  SkipResponseWrapperAttribute — opt-out from the global wrapper
Migrations/
  add_browser_releases.sql
  add_release_rollout.sql
  add_whats_new_entries.sql
Models/
  Omaha/OmahaRequest.cs
  Omaha/OmahaResponse.cs
```

---

## Client

The native update client is [`custom-omaha-client`](https://github.com/eightpoint/custom-omaha-client) (`src/BUILD.gn`'s `declare_args()`). Its compile-time defaults must match this server and the browser's own app GUID:

```
Server URL:  https://api.wander-lust.tech/v4/update
App ID:      {8A69D345-D564-463c-AFF1-A69D9E530F96}
```

The App ID must match `custom_windows_app_guid` in `custom-browser/src/custom/custom_browser_config.gni` exactly — a mismatch here doesn't error, it silently produces `noupdate` regardless of what's in `BrowserReleases`, since the lookup is by `(appId, platform, arch)` and a wrong `appId` simply matches no row. (Do not use `custom_windows_google_update_app_guid` — that's a separate, currently-unused identifier reserved for real Google-Omaha-compatibility purposes, unrelated to this fork's own update mechanism.)

`custom-browser`'s own `UpdateManager` (`src/custom/chrome/browser/autoupdate/update_manager.cc`) independently calls this same `/v4/update` endpoint directly (for the in-browser update-available badge), separately from the `custom-omaha-client` subprocess the installer/updater flow invokes — both must point at the same server URL and app ID.
