# Deployment Troubleshooting Guide

## "Bad Request" Error Resolution

If you're getting `{"error":"Bad Request","message":"Invalid request parameters"}` on your hosted server, follow these troubleshooting steps:

## 🔍 **Issue Analysis**

The error was likely caused by:
1. **Missing custom middleware** - The original Program.cs referenced non-existent middleware classes
2. **JWT configuration inconsistencies** - Different property names between config files
3. **CORS configuration** - Hard-coded origins that don't match your hosted environment
4. **HTTPS enforcement** - May cause issues if SSL isn't properly configured

## ✅ **Fixes Applied**

### 1. Simplified Program.cs
- Removed references to missing middleware classes (`SecurityValidationService`, `UseSecurityHeaders`, etc.)
- Simplified JWT configuration with basic authentication
- Made CORS more permissive for testing (`AllowAnyOrigin`)
- Removed HTTPS enforcement that could cause issues
- Added better error handling and logging

### 2. Fixed Configuration Inconsistencies
- Standardized JWT property names across all appsettings files
- Ensured all required configuration sections are present

### 3. Added Debugging Features
- Console logging for startup issues
- Health check endpoint: `/health`
- Test endpoint without database: `/api/test`

## 🚀 **Deployment Steps**

### Step 1: Publish the Fixed Version
```powershell
cd "f:\Wanderlust\wanderlust-platform\api"
dotnet publish -c Release -o ./publish
```

### Step 2: Test Health Endpoints
After deployment, test these endpoints:
- `https://your-domain.com/health` - Should return health status
- `https://your-domain.com/api/test` - Should return test message

### Step 3: Verify Configuration
Ensure your production `appsettings.Production.json` has:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "your-production-connection-string"
  },
  "JWT": {
    "SecretKey": "your-jwt-secret",
    "Issuer": "WanderlustApi",
    "Audience": "WanderlustClient",
    "ExpirationMinutes": 60,
    "RefreshTokenExpirationDays": 7
  },
  "AllowedHosts": "*"
}
```

## 🔧 **Common Issues & Solutions**

### Database Connection Issues
**Symptom**: App hangs during startup or returns 500 errors
**Solution**: 
1. Verify connection string in production config
2. Ensure database server is accessible from hosting environment
3. Check firewall rules and database permissions

### CORS Issues
**Symptom**: Browser console shows CORS errors
**Solution**:
1. Current config allows all origins for testing
2. For production, update CORS policy in Program.cs:
```csharp
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowFrontend",
        policyBuilder =>
        {
            policyBuilder.WithOrigins("https://your-frontend-domain.com")
                       .AllowAnyHeader()
                       .AllowAnyMethod()
                       .AllowCredentials();
        });
});
```

### SSL/HTTPS Issues
**Symptom**: App doesn't start or SSL errors
**Solution**:
1. The simplified Program.cs removed HTTPS enforcement
2. Ensure your hosting provider handles SSL termination
3. If you need to re-enable HTTPS, add:
```csharp
if (!app.Environment.IsDevelopment())
{
    app.UseHttpsRedirection();
}
```

### JWT Authentication Issues
**Symptom**: 401 Unauthorized errors
**Solution**:
1. Verify JWT secret key is consistent
2. Check token expiration settings
3. Ensure JWT configuration matches between environments

## 📋 **Deployment Checklist**

- [ ] Published with `dotnet publish -c Release`
- [ ] Copied published files to hosting server
- [ ] Updated `appsettings.Production.json` with correct values
- [ ] Tested `/health` endpoint
- [ ] Tested `/api/test` endpoint
- [ ] Verified database connectivity
- [ ] Checked application logs for errors

## 🔍 **Debug Information**

### Environment Variables to Check
- `ASPNETCORE_ENVIRONMENT` should be set to `Production`
- Connection strings should point to production database
- JWT settings should be configured

### Log Locations
The application now logs to console. Check your hosting provider's log viewer for:
- "Starting Wanderlust API" - App startup
- "Configuring database..." - Database setup
- Any error messages during startup

### Test Endpoints
1. **Health Check**: `GET /health`
   - Should return: `{"status":"healthy","timestamp":"...","environment":"Production","version":"3.3.0"}`

2. **API Test**: `GET /api/test`
   - Should return: `{"message":"API is working","timestamp":"..."}`

## 🆘 **Still Having Issues?**

If you're still experiencing problems:

1. **Check hosting provider logs** for specific error messages
2. **Test locally** with production configuration:
   ```powershell
   set ASPNETCORE_ENVIRONMENT=Production
   dotnet run
   ```
3. **Verify hosting requirements**:
   - .NET 8 Runtime installed
   - Correct permissions for file access
   - Database connectivity

4. **Enable detailed logging** by updating `appsettings.Production.json`:
   ```json
   {
     "Logging": {
       "LogLevel": {
         "Default": "Debug",
         "Microsoft.AspNetCore": "Information"
       }
     }
   }
   ```

## 📞 **Next Steps**

1. Deploy the updated version
2. Test the health endpoints
3. If issues persist, check the specific error messages in your hosting provider's logs
4. You can gradually re-enable security features once basic functionality works

The simplified version should resolve the "Bad Request" error and get your API running on the hosted server.
