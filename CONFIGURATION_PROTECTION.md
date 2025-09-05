# Configuration Protection for Hosting Environments

## Problem
Some hosting providers (including IONOS and others) remove or overwrite `appsettings.json` files during deployment, causing the application to fail with missing configuration errors.

## Solution Implemented

### 1. Embedded Configuration System
- **File**: `Configuration/EmbeddedConfiguration.cs`
- **Purpose**: Contains all production configuration values embedded directly in the application code
- **Benefit**: Cannot be removed by hosting providers since it's compiled into the DLL

### 2. Configuration Hardening in Program.cs
- **Environment Detection**: Automatically applies embedded configuration in production
- **Environment Variable Support**: Allows overriding via environment variables
- **Validation System**: Checks all required configuration is present
- **Fallback Chain**: appsettings.json → environment variables → embedded defaults

### 3. Diagnostic Endpoints
- **`/api/auth/config-status`**: Shows current configuration status and missing keys
- **`/api/auth/test-jwt`**: Tests JWT generation to verify configuration

## Configuration Priority (Highest to Lowest)
1. Environment Variables (set by hosting provider)
2. appsettings.Production.json (if not removed)
3. Embedded Configuration (always available)

## Environment Variables (Optional)
If your hosting provider supports environment variables, you can set:

```
CONNECTION_STRING=Data Source=...
JWT_SECRET_KEY=your-secret-key
JWT_ISSUER=WanderlustApi
JWT_AUDIENCE=WanderlustClient
JWT_EXPIRATION_MINUTES=60
JWT_REFRESH_EXPIRATION_DAYS=7
FRONTEND_URL=https://kb.wander-lust.tech
```

## Deployment Instructions

### Option 1: Standard Deployment (with config protection)
1. Publish normally with: `dotnet publish -c Release`
2. Upload all files including appsettings.json files
3. If hosting provider removes appsettings files, the embedded configuration will activate automatically

### Option 2: Environment Variables Only
1. Set environment variables in hosting control panel
2. Deploy without appsettings.Production.json
3. Application will use environment variables + embedded defaults

### Option 3: Embedded Only
1. Deploy with just the DLL and web.config
2. All configuration comes from embedded values
3. Most reliable for problematic hosting providers

## Verification Steps

1. **Check Configuration Status**:
   - Visit: `https://your-domain.com/api/auth/config-status`
   - Should show `"IsValid": true`

2. **Test JWT Generation**:
   - Visit: `https://your-domain.com/api/auth/test-jwt`
   - Should return a valid JWT with 3 parts

3. **Check Logs**:
   - Look for "Production configuration hardening applied" in startup logs
   - Verify "All required configuration settings are present"

## Current Embedded Configuration
The following values are embedded and will be used if appsettings files are missing:

- **Database**: `db1062671304.hosting-data.io` (your IONOS database)
- **JWT Secret**: `wCDHSUPSjlP+LoqKrNiW6LQARIuFCXewRhZDVvDeYMM=`
- **CORS Origin**: `https://kb.wander-lust.tech`
- **JWT Settings**: 60min access token, 7 days refresh token

## Troubleshooting

### If API returns 500 errors:
1. Check `/api/auth/config-status` endpoint
2. Look for missing configuration keys
3. Verify environment variables are set correctly

### If CORS errors occur:
1. Verify `FRONTEND_URL` environment variable
2. Check that embedded CORS origin matches your frontend domain
3. Restart application after configuration changes

### If authentication fails:
1. Test `/api/auth/test-jwt` endpoint
2. Verify JWT secret key is consistent
3. Check token format has exactly 3 parts

## Benefits of This Approach

✅ **Hosting Provider Proof**: Configuration cannot be removed  
✅ **Environment Variable Support**: Easy to override for different environments  
✅ **Automatic Fallback**: Works even if all external config files are missing  
✅ **Diagnostic Tools**: Built-in endpoints to verify configuration  
✅ **No Code Changes Required**: Existing controllers work unchanged  

This solution ensures your API will start and function correctly regardless of what the hosting provider does to your configuration files.
