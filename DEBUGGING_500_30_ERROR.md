# 500.30 Error Troubleshooting Guide

## What We've Configured for Debugging

### 1. Enhanced web.config
- ✅ `stdoutLogEnabled="true"` - Enables console output logging
- ✅ `stdoutLogFile=".\logs\stdout"` - Logs will be written to logs folder
- ✅ `ASPNETCORE_DETAILEDERRORS="true"` - Shows detailed error messages
- ✅ `httpErrors existingResponse="PassThrough"` - Passes through ASP.NET Core errors

### 2. Enhanced Logging in Production
- ✅ Information level logging for startup process
- ✅ Console logging with scopes
- ✅ Detailed connection string validation
- ✅ Repository registration logging

### 3. Startup Error Handling
- ✅ Comprehensive exception logging
- ✅ Stack trace details
- ✅ Inner exception handling
- ✅ Error log file creation

## Where to Find Error Information

### 1. Stdout Logs
**Location**: `logs/stdout_*.log` files in your application directory
**Contains**: All console output from your application startup

### 2. Startup Error Logs
**Location**: `logs/startup-error.log`
**Contains**: Critical startup errors with full stack traces

### 3. IIS Application Event Log
**Location**: Windows Event Viewer → Windows Logs → Application
**Filter by**: Source = "IIS AspNetCore Module V2"

## Common 500.30 Error Causes & Solutions

### 1. **Database Connection Issues**
```
Error: Unable to connect to database
Solution: Verify connection string in appsettings.Production.json
Check: MySQL server accessibility from hosting environment
```

### 2. **Missing Dependencies**
```
Error: Could not load file or assembly
Solution: Ensure all required DLLs are in the deployment
Check: MySqlConnector.dll, Dapper.dll are present
```

### 3. **Environment Variables**
```
Error: Configuration not found
Solution: Verify ASPNETCORE_ENVIRONMENT is set to "Production"
Check: Environment variables in web.config
```

### 4. **Permission Issues**
```
Error: Access denied to logs folder
Solution: Ensure IIS_IUSRS has write permissions to logs folder
Check: Application pool identity permissions
```

## Deployment Checklist

1. ✅ Copy all files from `publish/` folder
2. ✅ Include the `web.config` file
3. ✅ Create `logs/` folder with write permissions
4. ✅ Verify MySQL database is accessible
5. ✅ Test database connection string
6. ✅ Check IIS application pool .NET version (.NET 8.0)
7. ✅ Verify ASP.NET Core Hosting Bundle is installed

## Testing Database Connection

You can test your database connection locally:

```bash
dotnet run --environment Production
```

This will use your production connection string and show any database issues.

## Next Steps After Deployment

1. Deploy the updated files
2. Check `logs/stdout_*.log` files immediately after deployment
3. Look for specific error messages in the startup logs
4. If database errors, verify the connection string and MySQL accessibility
5. Report back any specific error messages found in the logs

The enhanced logging will now give you detailed information about exactly what's failing during startup!
