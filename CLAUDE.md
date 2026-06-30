# Claude Instructions — wanderlust-api

## What This Repo Is

The .NET 8 Web API backend for the WanderLust Knowledge Base platform — a Chromium learning platform. Provides user authentication, code example management, community discussions, real-time SignalR notifications, and content management. Hosted on IONOS Windows Hosting.

**Frontend clients**: `wanderlust-knowledgebase` React app (production: `https://kb.wander-lust.tech`, dev: `http://localhost:3000`).

## Tech Stack

- **.NET 8** / ASP.NET Core Web API
- **Dapper 2** + **Microsoft SQL Server** (no Entity Framework)
- **JWT Bearer** authentication (HS256, 60-min access tokens, 7-day refresh tokens)
- **SignalR** — real-time notifications and community features (`/hubs/community`)
- **Bcrypt** — password hashing
- **Serilog** — structured logging (disabled in production per IONOS constraints)
- **Swagger** — OpenAPI docs at `/swagger`

## Key Commands

```bash
dotnet build WanderlustApi.csproj   # Build
dotnet run                          # Run locally (HTTP)
npm run watch                       # dotnet watch (hot reload)
npm run publish:ftp                 # Deploy to IONOS via FTP
npm run publish:iis                 # Deploy to local IIS
npm run publish:linux               # Linux self-contained build
```

Health check endpoints (no auth required):
- `GET /health` — general health
- `GET /api/health/database` — DB connectivity status
- `GET /api/auth/config-status` — configuration loading
- `GET /api/auth/test-jwt` — JWT generation test

## Directory Structure

```
Controllers/        # HTTP endpoints (AuthController, CodeExamplesController, CommunityController, OmahaController, ReleasesController, etc.)
Services/           # Business logic (JwtService, PasswordService, UserService, RealTimeNotificationService)
Data/
├── Entities/       # DB entity classes (BrowserRelease, etc.)
├── Repositories/   # Dapper-based data access (IUserRepository, ICodeExampleRepository, IBrowserReleaseRepository, etc.)
└── Mock/           # Mock repositories — returned if DB unavailable at startup
Models/             # Domain entities (User, Article, CodeExample, CommunityPost, ApiResponse<T>)
├── Omaha/          # Omaha 4 protocol DTOs (OmahaRequest, OmahaResponse, OmahaManifest, OmahaPackage)
DTOs/               # Request/response data transfer objects
Middleware/         # GlobalExceptionHandling, InputValidation, RateLimiting, SecurityHeaders
Filters/            # ValidationFilterAttribute, ApiResponseWrapperAttribute, SkipResponseWrapperAttribute
Hubs/               # CommunityHub.cs (SignalR)
Configuration/      # EmbeddedConfiguration.cs (IONOS fallback), SecurityConfiguration.cs
Migrations/         # Raw SQL migration scripts (not EF Core)
```

## Architecture Patterns

- **Repository pattern**: All data access through `IXxxRepository` interfaces — enables the mock fallback.
- **`ApiResponse<T>` wrapper**: Every endpoint returns `{ success, data, error, message, timestamp, requestId, statusCode }`. The `ApiResponseWrapperAttribute` filter applies this automatically. To return raw JSON (e.g. for external wire protocols), decorate the controller or action with `[SkipResponseWrapper]`.
- **Omaha 4 update protocol**: `POST /v4/update` (anonymous) — serves browser installer metadata to `custom-omaha-client`. Admin releases managed via `GET/POST /api/releases`. See [`UPDATE_PROTOCOL.md`](UPDATE_PROTOCOL.md) for full documentation.
- **Mock fallback**: If the DB connection fails at startup, the API switches to `MockXxxRepository` implementations and continues running. Check `/api/health/database` to confirm DB status.
- **Standard error codes**: Use the `ApiErrorCodes` class (e.g., `AUTHENTICATION_FAILED`, `VALIDATION_ERROR`, `DATABASE_ERROR`) — never hardcode error strings.
- **Enum type handler**: All C# enums mapped to SQL string values via `DapperEnumTypeHandler<T>` — register any new enums in `Program.cs`.

## Auth Flow

1. `POST /api/auth/login` or `/api/auth/register` → returns JWT access token (60 min) + refresh token (7 days).
2. Client sends `Authorization: Bearer <token>` header.
3. `[Authorize]` enforces authentication; `[Authorize(Roles = "Admin")]` enforces roles.
4. Roles: `Member`, `Contributor`, `Moderator`, `Admin`.

## IONOS Hosting Constraints — Critical

The production host (IONOS Windows) imposes hard restrictions:

1. **No PUT or DELETE HTTP verbs** — use `POST /api/resource/{id}/update` and `POST /api/resource/{id}/delete` instead of `PUT`/`DELETE`.
2. **No environment variable access at runtime** — use `appsettings.Production.json` or `EmbeddedConfiguration.cs` as fallback. `GeneratedConfiguration.cs` is written at build time.
3. **No Console logging in production** — Serilog file logging is also disabled per host restrictions. Use the `/health` endpoints to verify state.
4. **OutOfProcess hosting model** — set in `web.config`; required for IONOS compatibility.

## Configuration

| File | Purpose |
|------|---------|
| `appsettings.json` | Defaults (localhost DB, CORS for `http://localhost:3000`) |
| `appsettings.Development.json` | Debug logging, local DB |
| `appsettings.Production.json` | Production DB, HTTPS required, CORS for `https://kb.wander-lust.tech` |

**Critical keys**: `ConnectionStrings:DefaultConnection`, `JWT:SecretKey`, `JWT:Issuer`, `JWT:Audience`, `CORS:AllowedOrigins`.

## Database

- Schema managed via raw SQL scripts in `Migrations/` — not EF Core migrations.
- Run migration scripts manually against the SQL Server instance.
- Connection factory: `IDbConnectionFactory` / `SqlServerConnectionFactory` — inject this, never create `SqlConnection` directly.

## Ecosystem Role

Backend for `wanderlust-knowledgebase`. Not directly related to the `custom-browser` Chromium code — this is a standalone web service for the knowledge base platform.
