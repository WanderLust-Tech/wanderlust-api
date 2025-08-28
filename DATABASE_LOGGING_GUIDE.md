# Database Connection Failure Logging Guide

## Overview
The Wanderlust API now includes comprehensive database connection failure logging to help diagnose connection issues, especially when deploying to hosting environments like IONOS.

## Enhanced Logging Features

### 1. **Detailed Error Information**
When a database connection fails, the system logs:
- Exact timestamp (UTC)
- Masked connection string (passwords hidden)
- Exception type and message
- Full stack trace
- Inner exception details (if present)

### 2. **SQL Server Specific Diagnostics**
For SQL Server errors, additional information is logged:
- SQL Error Number
- SQL Error Class
- SQL Error State
- Specific troubleshooting hints based on error codes

### 3. **Common Error Code Hints**
- **Error 2**: Network-related error. Check server name and port.
- **Error 18456**: Login failed. Check username/password.
- **Error 53**: Network path not found. Check server accessibility.
- **Error 11001**: SQL Server does not exist or access denied.

### 4. **Multiple Logging Destinations**
Logs are written to:
1. **File**: `logs/db-connection-failure-{timestamp}.log`
2. **Console**: During development (non-production)
3. **Application Logger**: Using the configured Serilog system

## Log File Locations

### Development
- `logs/db-connection-failure-{yyyyMMdd-HHmmss}.log`
- `logs/app.log` (general application logs)

### Production (IONOS)
- `logs/` directory in the application root
- Individual failure logs with timestamps
- Stdout logging enabled in web.config

## Sample Log Output

```
=== DATABASE CONNECTION FAILURE ===
Timestamp: 2024-01-15 14:30:22 UTC
Connection String: Server=myserver;Database=WanderlustDb;User Id=***MASKED***;Password=***MASKED***;TrustServerCertificate=True;
Exception Type: SqlException
Exception Message: A network-related or instance-specific error occurred while establishing a connection to SQL Server.
Stack Trace: [Full stack trace here]

=== TROUBLESHOOTING HINTS ===
SQL Error Number: 2
SQL Error Class: 20
SQL Error State: 0
HINT: Network-related error. Check server name and port.

=== FALLBACK ACTION ===
Switching to MOCK DATA mode for continued operation.
Check /api/health/database endpoint for real-time status.
=====================================
```

## Fallback Behavior

When database connection fails:
1. **Automatic Fallback**: System switches to mock data repositories
2. **Continued Operation**: API remains functional with sample data
3. **Health Monitoring**: `/api/health/database` endpoint shows current status
4. **Recovery**: System automatically reconnects when database becomes available

## Monitoring and Diagnostics

### Health Endpoints
- `/api/health` - Overall application health
- `/api/health/database` - Database-specific health status

### Log Analysis
- Check `logs/` directory for detailed failure logs
- Monitor stdout for real-time connection status
- Use application logs for ongoing diagnostics

## Security Features
- Connection strings are automatically masked
- Passwords and user IDs are replaced with `***MASKED***`
- Sensitive information is never logged in plain text

## IONOS Specific Considerations
- Logs are written to the application directory
- Stdout logging is enabled for the hosting environment
- OutOfProcess hosting model ensures logs are accessible
- Proxy configuration errors are also logged

## Troubleshooting Steps

1. **Check Log Files**: Look for detailed error messages and hints
2. **Verify Connection String**: Ensure server name, database, and credentials are correct
3. **Network Connectivity**: Test if the database server is accessible
4. **Firewall Settings**: Check if necessary ports are open
5. **SSL/TLS Configuration**: Add `TrustServerCertificate=True` if needed
6. **Health Endpoints**: Use `/api/health/database` for real-time status

## Configuration

The logging system automatically activates when:
- Database connection fails during application startup
- Any database operation encounters a connection error
- The health check service detects database unavailability

No additional configuration is required - the system automatically provides comprehensive diagnostics while maintaining secure operation through the mock data fallback.
