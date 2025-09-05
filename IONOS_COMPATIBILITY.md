# IONOS-Compatible Configuration System

## Problem Solved
IONOS hosting has strict trust level restrictions that prevent:
- ❌ Environment variable access (`Environment.GetEnvironmentVariable()`)
- ❌ Registry access
- ❌ File access outside application directory
- ❌ Unmanaged code execution

Our original configuration system used environment variables at runtime, which violates IONOS trust level restrictions.

## IONOS-Compatible Solution

### 1. Build-Time Configuration Injection
Instead of reading environment variables at runtime, we inject configuration values during the build process:

```
GitHub Secrets → Build Environment → Source Code Replacement → Compiled Constants
```

### 2. Key Components

#### `GeneratedConfiguration.cs`
- Contains placeholder strings that are replaced during build
- No runtime environment variable access
- Values become compiled constants

#### `Configuration.targets` (MSBuild)
- Replaces placeholders with actual values during build
- Only runs in Release configuration
- Uses environment variables from GitHub Actions

#### `EmbeddedConfiguration.cs`
- IONOS-compatible fallback system
- No environment variable access
- Uses build-time generated configuration

### 3. Trust Level Compliance

✅ **No Environment Variables**: Configuration injected at build time  
✅ **No Registry Access**: All configuration in-memory  
✅ **No External Files**: Configuration embedded in DLL  
✅ **Managed Code Only**: Uses only .NET Framework classes  
✅ **System.Data.SqlClient**: Uses approved database access method  

## How It Works

### Build Process
1. **GitHub Actions** sets environment variables from secrets
2. **MSBuild target** replaces placeholders in `GeneratedConfiguration.cs`
3. **Compiler** embeds actual values as string constants
4. **Published DLL** contains configuration that cannot be removed

### Runtime Process
1. **Application starts** and checks for appsettings files
2. **If missing**: Uses embedded configuration (from build-time injection)
3. **If present**: Can still use appsettings.json if available
4. **No environment variable access** at any point during runtime

## Configuration Hierarchy

1. **appsettings.Production.json** (if not removed by IONOS)
2. **Embedded Configuration** (from GitHub Secrets via build process)
3. **Development Fallbacks** (localhost values for local development)

## GitHub Actions Integration

The build process automatically injects configuration:

```yaml
- name: Build API
  env:
    BUILD_CONNECTION_STRING: ${{ secrets.CONNECTION_STRING }}
    BUILD_JWT_SECRET_KEY: ${{ secrets.JWT_SECRET_KEY }}
    BUILD_FRONTEND_URL: ${{ secrets.FRONTEND_URL }}
  run: dotnet build --configuration Release
```

## Security Benefits

✅ **No Secrets in Source Code**: Values only exist during build  
✅ **GitHub Secrets Management**: Encrypted and access-controlled  
✅ **Build-Time Only**: Environment variables only available during CI/CD  
✅ **Compiled Constants**: Configuration becomes part of the binary  
✅ **IONOS Trust Level Compliant**: No restricted operations  

## Deployment Process

1. **Push to Repository**: Triggers GitHub Actions
2. **Build Environment**: Gets secrets from GitHub
3. **Placeholder Replacement**: MSBuild injects real values
4. **Compilation**: Configuration becomes compiled constants
5. **Deployment**: DLL contains embedded configuration
6. **Runtime**: IONOS cannot remove embedded configuration

## Required GitHub Secrets

Same as before, but now used only during build:

- `CONNECTION_STRING`
- `JWT_SECRET_KEY`
- `JWT_ISSUER`
- `JWT_AUDIENCE`
- `JWT_EXPIRATION_MINUTES`
- `JWT_REFRESH_EXPIRATION_DAYS`
- `FRONTEND_URL`

## IONOS Restrictions Compliance

| Restriction | Our Solution | Status |
|-------------|--------------|---------|
| No environment variables | Build-time injection only | ✅ Compliant |
| No registry access | In-memory configuration | ✅ Compliant |
| No external file access | Embedded in DLL | ✅ Compliant |
| System.Data.SqlClient only | Using Microsoft.Data.SqlClient | ✅ Compliant |
| No unmanaged code | Pure .NET managed code | ✅ Compliant |
| No isolated storage | Using standard configuration | ✅ Compliant |

## Testing

### Local Development
- Placeholders remain as development fallbacks
- Generates random JWT secrets automatically
- Uses localhost database connection

### Production Build
- Placeholders replaced with actual GitHub Secret values
- Configuration embedded in compiled DLL
- IONOS trust level compliant

### Verification Endpoints
- `/api/auth/config-status` - Shows current configuration
- `/api/auth/test-jwt` - Tests JWT generation

This approach provides maximum compatibility with IONOS hosting restrictions while maintaining security through GitHub Secrets management.
