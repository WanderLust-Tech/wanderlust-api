# API Deployment Guide

This document explains how to deploy the Wanderlust .NET API using the automated FTP deployment system.

## Overview

The API deployment system provides automated building and FTP deployment of the .NET API, matching the same workflow used by the frontend. It includes:

- **Automated .NET builds** with dependency restoration
- **FTP deployment** with backup and validation
- **IIS configuration** with automatic web.config generation
- **Environment detection** for GitHub Actions and local deployment
- **Security features** including file filtering and validation

## Quick Start

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Configure environment:**
   ```bash
   cp .env.example .env
   # Edit .env with your FTP credentials
   ```

3. **Test connection:**
   ```bash
   npm run test-connection
   ```

4. **Deploy:**
   ```bash
   npm run deploy
   ```

## Environment Configuration

Create a `.env` file in the API root directory with your deployment settings:

### Required Variables

```env
# FTP Server Configuration
API_FTP_HOST=your-ftp-host.com
API_FTP_USER=your-ftp-username
API_FTP_PASSWORD=your-ftp-password
```

### Optional Variables

```env
# FTP Configuration
API_FTP_PORT=21                              # Default: 21
API_FTP_SECURE=false                         # Default: false (use true for FTPS)
API_FTP_REMOTE_PATH=/api                     # Default: /api

# Build Configuration
BUILD_CONFIGURATION=Release                   # Default: Release
API_LOCAL_BUILD_PATH=./bin/Release/net8.0/publish
API_PROJECT_FILE=./WanderlustApi.csproj
```

## Available Commands

### Deployment Commands

- `npm run deploy` - Full deployment (build + upload)
- `npm run deploy:dev` - Deploy debug build
- `npm run deploy:prod` - Deploy release build (default)

### Build Commands

- `npm run build` - Build the API (debug)
- `npm run build:release` - Build the API (release)
- `npm run publish` - Build and publish to local directory

### Testing Commands

- `npm run test-connection` - Test FTP connection and permissions

## Deployment Process

The deployment script follows these steps:

### 1. Project Analysis
- Detects if project files have changed recently
- Validates environment configuration
- Checks for required files and directories

### 2. .NET Build Process
```bash
dotnet clean WanderlustApi.csproj
dotnet restore WanderlustApi.csproj
dotnet publish WanderlustApi.csproj -c Release -o ./bin/Release/net8.0/publish
```

### 3. IIS Configuration
- Automatically generates `web.config` for IIS deployment
- Configures ASP.NET Core hosting with production settings
- Sets up error handling and request filtering

### 4. FTP Deployment
- Creates backup of existing deployment
- Uploads all build artifacts to remote server
- Validates deployment by checking for main DLL
- Provides deployment summary and file listing

## File Filtering

The deployment script automatically excludes certain files that shouldn't be deployed:

- **Debug symbols** (*.pdb)
- **Documentation files** (*.xml)
- **Development settings** (*.dev.json)
- **Log files** (*.log)
- **Temporary files** (*.tmp)

## Deployment Validation

After deployment, the script validates:

- ✅ Main application DLL exists (`WanderlustApi.dll`)
- ✅ Required configuration files are present
- ✅ File upload completed successfully
- ✅ Remote directory structure is correct

## IIS Configuration

The deployment automatically creates a `web.config` file optimized for production:

```xml
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <location path="." inheritInChildApplications="false">
    <system.webServer>
      <handlers>
        <add name="aspNetCore" path="*" verb="*" modules="AspNetCoreModuleV2" resourceType="Unspecified" />
      </handlers>
      <aspNetCore processPath="dotnet" 
                  arguments=".\\WanderlustApi.dll" 
                  stdoutLogEnabled="false" 
                  stdoutLogFile=".\\logs\\stdout" 
                  hostingModel="inprocess">
        <environmentVariables>
          <environmentVariable name="ASPNETCORE_ENVIRONMENT" value="Production" />
        </environmentVariables>
      </aspNetCore>
    </system.webServer>
  </location>
</configuration>
```

## GitHub Actions Integration

The deployment script automatically detects GitHub Actions environment and can analyze commit changes to determine if deployment is needed. Set these variables in your GitHub repository secrets:

```env
API_FTP_HOST
API_FTP_USER
API_FTP_PASSWORD
API_FTP_REMOTE_PATH
```

Example GitHub Actions workflow:

```yaml
name: Deploy API
on:
  push:
    branches: [main]
    paths: ['api/**']

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup .NET
        uses: actions/setup-dotnet@v3
        with:
          dotnet-version: '8.0.x'
          
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          
      - name: Install deployment dependencies
        run: npm install
        working-directory: ./api
        
      - name: Deploy API
        env:
          API_FTP_HOST: ${{ secrets.API_FTP_HOST }}
          API_FTP_USER: ${{ secrets.API_FTP_USER }}
          API_FTP_PASSWORD: ${{ secrets.API_FTP_PASSWORD }}
          API_FTP_REMOTE_PATH: ${{ secrets.API_FTP_REMOTE_PATH }}
        run: npm run deploy
        working-directory: ./api
```

## Troubleshooting

### Connection Issues

**Problem:** FTP connection fails
```bash
npm run test-connection
```

**Solutions:**
- Verify FTP credentials in `.env`
- Check if server requires FTPS (`API_FTP_SECURE=true`)
- Try different ports (21 for FTP, 990 for FTPS)
- Ensure firewall allows FTP connections

### Build Issues

**Problem:** .NET build fails
- Ensure .NET 8 SDK is installed
- Check project file path is correct
- Verify all dependencies are available
- Run `dotnet restore` manually to check for issues

**Problem:** Missing dependencies
```bash
npm install
```

### Deployment Issues

**Problem:** Upload fails with permissions
- Check FTP user has write permissions
- Verify remote directory path exists
- Ensure sufficient disk space on server

**Problem:** Application doesn't start after deployment
- Check `appsettings.Production.json` configuration
- Verify database connection strings
- Check IIS/hosting environment logs
- Ensure all required dependencies are deployed

## Security Considerations

The deployment script includes several security features:

- ✅ **Environment isolation** - Separate configurations for dev/prod
- ✅ **File filtering** - Excludes debug symbols and sensitive files
- ✅ **Backup creation** - Automatic backup before deployment
- ✅ **Validation checks** - Ensures deployment integrity
- ✅ **Secure FTP** - Supports FTPS for encrypted transfers

## Monitoring and Maintenance

### Log Files

Application logs are configured to write to:
- **IIS logs:** `logs/stdout` (configured in web.config)
- **Application logs:** As configured in `appsettings.Production.json`

### Backup Management

The deployment script creates timestamped backups:
- Format: `/api_backup_YYYY-MM-DD`
- Manual cleanup may be required to manage disk space

### Performance Monitoring

After deployment, monitor:
- API response times
- Error rates in application logs
- Server resource utilization
- Database connection health

## Advanced Configuration

### Custom Build Targets

You can customize the build process by modifying the `dotnet publish` command in the deployment script:

```javascript
const publishCommand = `dotnet publish "${this.config.projectFile}" 
  -c ${this.config.configuration} 
  -o "${this.config.localPath}" 
  --self-contained false 
  --runtime win-x64  // Add specific runtime
  --verbosity minimal`;
```

### Multiple Environment Deployment

For multiple environments, create separate `.env` files:

- `.env.staging`
- `.env.production`

Load specific environment:
```bash
cp .env.staging .env && npm run deploy
```

### Custom Remote Paths

Deploy to different remote paths for different environments:

```env
# Staging
API_FTP_REMOTE_PATH=/api-staging

# Production
API_FTP_REMOTE_PATH=/api
```

This comprehensive deployment system ensures reliable, automated deployment of the Wanderlust API while maintaining security and providing extensive validation and monitoring capabilities.
