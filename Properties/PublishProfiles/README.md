# WanderlustApi Publishing Profiles

This directory contains publishing profiles for deploying the WanderlustApi to various environments and platforms.

## 📁 Available Publishing Profiles

### 1. **FolderProfile.pubxml** - File System Deployment
- **Use Case**: Create deployment package for manual upload
- **Target**: Local folder (`bin\Release\net8.0\publish`)
- **Features**: 
  - Optimized for production
  - ReadyToRun compilation
  - Excludes development files
  - Creates deployment info file

**Usage:**
```bash
# Using dotnet CLI
dotnet publish --configuration Release /p:PublishProfile=FolderProfile

# Using PowerShell helper
.\publish.ps1 -Profile FolderProfile
```

### 2. **Local-IIS.pubxml** - Local IIS Deployment
- **Use Case**: Deploy to local IIS for testing
- **Target**: `C:\inetpub\wwwroot\WanderlustApi`
- **Features**:
  - Optimized for local development
  - Automatically creates web.config
  - ReadyToRun compilation

**Prerequisites:**
- IIS installed and enabled
- ASP.NET Core Hosting Bundle installed
- Run as Administrator

**Usage:**
```bash
# Using dotnet CLI (run as Administrator)
dotnet publish --configuration Release /p:PublishProfile=Local-IIS

# Using PowerShell helper (run as Administrator)
.\publish.ps1 -Profile Local-IIS
```

### 3. **FTP-Production.pubxml** - FTP Deployment
- **Use Case**: Deploy to production server via FTP
- **Target**: Configured FTP server
- **Features**:
  - Production optimized
  - Excludes development files
  - Passive FTP mode

**Setup Required:**
1. Copy `FTP-Production.pubxml.user.template` to `FTP-Production.pubxml.user`
2. Update FTP credentials in the `.user` file
3. Update server details in the main `.pubxml` file

**Usage:**
```bash
# Using dotnet CLI
dotnet publish --configuration Release /p:PublishProfile=FTP-Production

# Using PowerShell helper
.\publish.ps1 -Profile FTP-Production
```

### 4. **WebDeploy-Production.pubxml** - Web Deploy
- **Use Case**: Deploy to IIS server with Web Deploy
- **Target**: Remote IIS server with Web Deploy
- **Features**:
  - Incremental deployment
  - Automatic backup
  - App offline during deployment
  - Production optimized

**Prerequisites:**
- Web Deploy installed on target server
- Web Management Service enabled
- Proper firewall configuration (port 8172)

**Setup Required:**
1. Update server details in the `.pubxml` file
2. Set credentials in environment variables or `.user` file

**Usage:**
```bash
# Using dotnet CLI
dotnet publish --configuration Release /p:PublishProfile=WebDeploy-Production

# Using PowerShell helper
.\publish.ps1 -Profile WebDeploy-Production
```

## 🔧 Configuration

### Environment Variables
You can use environment variables for sensitive information:

```bash
# For FTP deployment
set FtpUsername=your-username
set FtpPassword=your-password

# For Web Deploy
set WebDeployUsername=your-username
set WebDeployPassword=your-password
```

### Credential Files (.pubxml.user)
Create `.pubxml.user` files for storing sensitive credentials:

```xml
<?xml version="1.0" encoding="utf-8"?>
<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
  <PropertyGroup>
    <FtpUsername>your-ftp-username</FtpUsername>
    <FtpPassword>your-ftp-password</FtpPassword>
  </PropertyGroup>
</Project>
```

**Important:** `.pubxml.user` files are excluded from version control to keep credentials secure.

## 🚀 Using the PowerShell Helper Script

The `publish.ps1` script provides an easy way to publish with validation and helpful output:

```powershell
# Basic usage
.\publish.ps1 -Profile FolderProfile

# With verbose output
.\publish.ps1 -Profile FTP-Production -Verbose

# Specific configuration
.\publish.ps1 -Profile Local-IIS -Configuration Debug
```

## 🔍 Troubleshooting

### Common Issues

1. **"Project file not found"**
   - Ensure you're running from the API project directory
   - Check that `WanderlustApi.csproj` exists

2. **"Publishing profile not found"**
   - Verify the profile name is correct
   - Check that the `.pubxml` file exists in `Properties/PublishProfiles/`

3. **FTP connection issues**
   - Verify FTP credentials and server details
   - Check firewall settings
   - Ensure passive mode is supported

4. **IIS deployment permission errors**
   - Run PowerShell/Command Prompt as Administrator
   - Verify IIS and ASP.NET Core hosting bundle are installed

5. **Web Deploy connection issues**
   - Verify Web Deploy is installed on target server
   - Check Web Management Service is running
   - Verify port 8172 is open in firewall

### Validation Steps

After deployment, verify:

1. **File Deployment**: Check that all required files are present
2. **Web.config**: Verify web.config is created and valid
3. **Dependencies**: Ensure all .NET runtime dependencies are available
4. **Environment**: Check that environment variables are set correctly
5. **Database**: Verify database connection strings and migrations

## 📚 Additional Resources

- [ASP.NET Core Deployment Documentation](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/)
- [Publishing Profiles Documentation](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/visual-studio-publish-profiles)
- [IIS Hosting Documentation](https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/iis/)
- [Web Deploy Documentation](https://docs.microsoft.com/en-us/iis/publish/using-web-deploy/)

## 🔐 Security Notes

- Never commit `.pubxml.user` files to version control
- Use environment variables for credentials in CI/CD pipelines
- Regularly rotate deployment credentials
- Enable HTTPS for all production deployments
- Review and limit deployment account permissions
