# Logging Configuration Guide

## 🎯 Overview

Your Wanderlust API now includes comprehensive file logging using Serilog, which writes logs to files in the same directory as your application. This is perfect for hosted environments where you don't have access to IIS logs.

## 📁 **Log File Location**

When your API runs, it will create a `logs` directory in the same folder as your application and write daily log files:

```
your-app-directory/
├── WanderlustApi.exe (or .dll)
├── appsettings.json
└── logs/
    ├── wanderlust-api-20250827.log
    ├── wanderlust-api-20250828.log
    └── wanderlust-api-20250829.log
```

## 📊 **Log File Features**

### **File Naming & Rotation**
- **Pattern**: `wanderlust-api-YYYYMMDD.log`
- **Daily Rotation**: New file created each day automatically
- **Retention**: 
  - **Development**: 7 days of logs kept
  - **Production**: 30 days of logs kept
- **Shared Access**: Multiple processes can write to the same file safely

### **Real-time Logging**
- **Flush Interval**: Logs are written to disk every second
- **Immediate Error Logging**: Critical errors are flushed immediately
- **Shared File Access**: Safe for multiple app instances

## 🔧 **Log Levels & Content**

### **What Gets Logged**
- **Information**: Application startup, database connections, API operations
- **Warning**: Non-critical issues, deprecated API usage
- **Error**: Exceptions, database connection failures, API errors
- **Fatal**: Application crashes, startup failures

### **Log Format**
```
2025-08-27 10:38:27.932 [INF] WanderlustApi.Controllers.ArticlesController Configuring database connection...
2025-08-27 10:38:27.994 [INF] WanderlustApi.Controllers.ArticlesController Database configured successfully
2025-08-27 10:38:28.208 [ERR] Microsoft.AspNetCore.Hosting Application startup failed
System.Exception: Database connection could not be established...
```

**Format Breakdown**:
- `2025-08-27 10:38:27.932` - Timestamp with milliseconds
- `[INF]` - Log level (INF, WAR, ERR, FTL)
- `WanderlustApi.Controllers.ArticlesController` - Source context
- `Message content...` - The actual log message
- Stack traces for exceptions

## 🎛️ **Configuration**

### **Development Environment**
```json
{
  "Serilog": {
    "MinimumLevel": {
      "Default": "Information",
      "Override": {
        "Microsoft": "Warning",
        "System": "Warning"
      }
    },
    "WriteTo": [
      {
        "Name": "File",
        "Args": {
          "path": "logs/wanderlust-api-.log",
          "rollingInterval": "Day",
          "retainedFileCountLimit": 7
        }
      }
    ]
  }
}
```

### **Production Environment**
```json
{
  "Serilog": {
    "MinimumLevel": {
      "Default": "Information",
      "Override": {
        "Microsoft": "Warning",
        "WanderlustApi": "Information"
      }
    },
    "WriteTo": [
      {
        "Name": "File",
        "Args": {
          "path": "logs/wanderlust-api-.log",
          "rollingInterval": "Day",
          "retainedFileCountLimit": 30
        }
      }
    ]
  }
}
```

## 🔍 **Monitoring & Troubleshooting**

### **Key Log Messages to Watch For**

#### **Successful Startup**
```
[INF] Starting Wanderlust API v3.3.0
[INF] Configuring database connection...
[INF] Database configured successfully
[INF] Now listening on: http://localhost:5000
```

#### **Database Issues**
```
[ERR] Database configuration failed
System.Exception: Unable to connect to MySQL server...
```

#### **Authentication Issues**
```
[WAR] JWT token validation failed
[ERR] Authentication failed for user...
```

#### **API Errors**
```
[ERR] API request failed: GET /api/articles
System.Exception: Object reference not set to an instance...
```

### **Common Error Patterns**

1. **Database Connection Errors**
   - Look for: `Database configuration failed`
   - Check: Connection string, database server availability

2. **Port Binding Issues**
   - Look for: `Failed to bind to address`
   - Check: Port conflicts, permissions

3. **Configuration Errors**
   - Look for: `Application start-up failed`
   - Check: appsettings.json syntax, missing values

## 📈 **Log Analysis Tips**

### **Finding Specific Issues**
```powershell
# Search for errors in today's log
Select-String -Path "logs/wanderlust-api-*.log" -Pattern "\[ERR\]"

# Find database-related issues
Select-String -Path "logs/wanderlust-api-*.log" -Pattern "Database"

# Look for authentication problems
Select-String -Path "logs/wanderlust-api-*.log" -Pattern "JWT|Authentication"
```

### **Monitoring Application Health**
```powershell
# Check if app started successfully
Select-String -Path "logs/wanderlust-api-*.log" -Pattern "Starting Wanderlust API"

# Monitor recent activity (last 50 lines)
Get-Content "logs/wanderlust-api-$(Get-Date -Format 'yyyyMMdd').log" -Tail 50
```

## 🚀 **Production Deployment**

### **Deployment Checklist**
- [ ] Published application includes Serilog.AspNetCore and Serilog.Sinks.File packages
- [ ] `logs` directory will be created automatically
- [ ] Hosting environment has write permissions for log directory
- [ ] Log retention policy is configured (30 days for production)

### **Log Management**
- **Manual Cleanup**: Old log files can be safely deleted
- **Automated Cleanup**: Consider adding a scheduled task to clean up old logs
- **Monitoring**: Set up alerts based on error frequency in logs

### **Security Considerations**
- Log files may contain sensitive information (user IDs, API keys)
- Ensure log directory is not publicly accessible via web server
- Consider encrypting log files if they contain sensitive data

## 🔧 **Customization Options**

### **Change Log Location**
In `appsettings.json`:
```json
{
  "Serilog": {
    "WriteTo": [
      {
        "Name": "File",
        "Args": {
          "path": "C:/Logs/wanderlust/api-.log"
        }
      }
    ]
  }
}
```

### **Adjust Log Detail Level**
```json
{
  "Serilog": {
    "MinimumLevel": {
      "Default": "Debug",     // More detailed logging
      "Override": {
        "WanderlustApi": "Information"  // App-specific logging level
      }
    }
  }
}
```

### **Add Additional Log Outputs**
```json
{
  "Serilog": {
    "WriteTo": [
      {
        "Name": "File",
        "Args": {
          "path": "logs/wanderlust-api-.log"
        }
      },
      {
        "Name": "File",
        "Args": {
          "path": "logs/errors-.log",
          "restrictedToMinimumLevel": "Error"
        }
      }
    ]
  }
}
```

## 📞 **Support Information**

### **Log File Analysis**
When reporting issues, include:
1. Relevant log entries from the error time
2. Full stack traces for exceptions
3. Timestamp of when the issue occurred
4. Environment (Development/Production)

### **Performance Impact**
- **Minimal**: Async logging with minimal performance impact
- **Disk Space**: Monitor log directory size, especially in production
- **File Handles**: Serilog efficiently manages file access

---

**Your application now has comprehensive logging that will help you troubleshoot issues and monitor performance on your hosted server!**
