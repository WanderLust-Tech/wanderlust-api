# Migration Changelog

## Version 4.0.0 - SQL Server Migration (January 2025)

### 🚀 Major Changes

#### Database Migration: MySQL → Microsoft SQL Server
- **Removed**: Entity Framework Core with MySQL
- **Added**: Dapper micro-ORM with SQL Server
- **Benefits**: Better performance, more control over SQL, improved hosting compatibility

#### Data Access Layer Refactor
- **Connection Factory**: New `SqlServerConnectionFactory` using `Microsoft.Data.SqlClient`
- **Repository Pattern**: Updated all repositories to use Dapper
- **SQL Syntax**: Migrated from MySQL to T-SQL syntax
  - `LAST_INSERT_ID()` → `SCOPE_IDENTITY()`
  - Updated data types and constraints for SQL Server compatibility

#### Enhanced Error Handling & Logging
- **Custom API Responses**: Added `ApiResponse<T>` wrapper for all endpoints
- **Global Exception Handling**: Centralized error processing with detailed logging
- **Validation Filters**: Automatic model validation with structured responses
- **Stdout Logging**: Added `web.config` for production error diagnosis
- **Enhanced Startup Logging**: Detailed application initialization diagnostics

### 📦 Package Changes

#### Removed Packages
```xml
<PackageReference Include="Pomelo.EntityFrameworkCore.MySql" Version="8.0.2" />
<PackageReference Include="MySqlConnector" Version="2.3.5" />
<PackageReference Include="Microsoft.EntityFrameworkCore.Tools" Version="8.0.8" />
<PackageReference Include="Microsoft.EntityFrameworkCore.Design" Version="8.0.8" />
```

#### Added Packages
```xml
<PackageReference Include="Microsoft.Data.SqlClient" Version="5.1.2" />
<PackageReference Include="Dapper" Version="2.1.35" />
```

### 🗄️ Database Schema Changes

#### New SQL Server Schema
- **File**: `Scripts/01_CreateDatabase_SqlServer.sql`
- **Tables**: Users, Articles, CodeExamples, Collections, CommunityPosts, Comments, UserRoles, MediaFiles, ContentTemplates, Analytics
- **Data Types**: Updated for SQL Server compatibility
- **Sample Data**: Comprehensive seed data for testing

#### Legacy MySQL Schema
- **File**: `Scripts/01_CreateDatabase.sql` (preserved for reference)
- **Status**: No longer used but kept for migration reference

### 🔧 Configuration Updates

#### Connection Strings
```json
// Before (MySQL)
"DefaultConnection": "Server=localhost;Port=3306;Database=wanderlust_dev;Uid=username;Pwd=password;"

// After (SQL Server)
"DefaultConnection": "Server=localhost;Database=WanderlustDB;User Id=username;Password=password;TrustServerCertificate=true;Encrypt=true;"
```

#### Web.config (New)
```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <system.webServer>
    <aspNetCore processPath="dotnet" 
                arguments=".\WanderlustApi.dll" 
                stdoutLogEnabled="true" 
                stdoutLogFile=".\logs\stdout" 
                hostingModel="inprocess" />
  </system.webServer>
</configuration>
```

### 🔧 Code Changes

#### Program.cs Updates
- **Connection Factory**: Switched to `SqlServerConnectionFactory`
- **Enhanced Logging**: Added startup diagnostics and exception handling
- **Error Handling**: Registered global exception middleware and response filters

#### Repository Updates
- **UserRepository**: Updated to use Dapper and SQL Server syntax
- **CodeExampleRepository**: Migrated to Dapper with T-SQL queries
- **Connection Management**: Async connection handling with proper disposal

#### New Files Added
- `Data/DbConnectionFactory.cs` - SQL Server connection factory
- `Filters/ApiResponseFilter.cs` - Global response wrapper
- `Filters/GlobalExceptionMiddleware.cs` - Centralized error handling
- `Filters/ModelValidationFilter.cs` - Automatic validation
- `Models/ApiResponse.cs` - Standardized response format
- `Models/ApiError.cs` - Structured error information
- `Models/ApiErrorCodes.cs` - Error code constants
- `web.config` - IIS deployment configuration

### 🧪 Testing & Validation

#### Build Verification
- ✅ Clean build with no warnings
- ✅ All package references resolved
- ✅ No compilation errors

#### Database Testing
- ✅ SQL Server schema script validated
- ✅ Sample data insertion verified
- ✅ Repository queries tested with T-SQL syntax

### 🚀 Deployment Improvements

#### Production Ready Features
- **Stdout Logging**: Enables error diagnosis on hosted servers
- **Enhanced Error Handling**: Prevents information leakage while providing useful debugging
- **Connection Pooling**: Optimized database connections for better performance
- **Manual Schema Control**: No dependency on EF migrations for deployment

#### Hosting Compatibility
- **IIS Ready**: Configured web.config for IIS deployment
- **Cloud Ready**: Compatible with Azure SQL and other cloud SQL Server instances
- **Docker Ready**: Can be containerized with SQL Server

### 🎯 Performance Improvements

#### Database Performance
- **Dapper**: Faster query execution compared to EF Core
- **Direct SQL**: Optimized queries without ORM overhead
- **Connection Efficiency**: Better connection pooling and management

#### Error Handling Performance
- **Structured Logging**: More efficient log processing
- **Response Caching**: Improved API response times
- **Validation Efficiency**: Faster model validation pipeline

### 📖 Documentation Updates

#### README.md
- Updated technology stack section
- New SQL Server setup instructions
- Enhanced deployment documentation
- Added troubleshooting section for production errors

#### API Documentation
- Swagger documentation remains unchanged
- All existing endpoints maintain compatibility
- Response format enhanced with metadata

### 🔄 Migration Steps (for existing deployments)

1. **Backup MySQL Data** (if migrating from existing MySQL setup)
2. **Install SQL Server** (2019+ or SQL Server Express)
3. **Execute Schema Script**: Run `Scripts/01_CreateDatabase_SqlServer.sql`
4. **Update Connection Strings**: Configure `appsettings.Production.json`
5. **Deploy New Version**: Use updated build artifacts
6. **Verify Logging**: Check stdout logs in `logs/` folder if issues occur

### 🎉 Benefits of This Migration

- **Better Hosting Compatibility**: Resolves 500.30 errors on shared hosting
- **Improved Performance**: Dapper provides faster database operations
- **Enhanced Debugging**: Stdout logging enables production troubleshooting
- **Enterprise Ready**: SQL Server provides better scalability and enterprise features
- **Simplified Deployment**: No EF migrations required, manual schema control
- **Better Error Handling**: Comprehensive error management and logging
