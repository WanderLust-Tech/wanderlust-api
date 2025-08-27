#!/usr/bin/env node

const ftp = require('basic-ftp');
const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');
const util = require('util');
const execAsync = util.promisify(exec);
require('dotenv').config();

class ApiDeploymentManager {
  constructor() {
    this.client = new ftp.Client();
    this.client.ftp.verbose = true;
    
    // Configuration from environment variables
    this.config = {
      host: process.env.FTP_HOST,
      user: process.env.FTP_USER,
      password: process.env.FTP_PASSWORD,
      port: process.env.FTP_PORT || 21,
      secure: process.env.FTP_SECURE === 'true',
      remotePath: process.env.API_FTP_REMOTE_PATH || '/',
      localPath: process.env.API_LOCAL_BUILD_PATH || './bin/Release/net8.0/publish',
      projectFile: process.env.API_PROJECT_FILE || './WanderlustApi.csproj',
      configuration: process.env.BUILD_CONFIGURATION || 'Release',
      // GitHub Actions compatibility
      isGitHubActions: process.env.GITHUB_ACTIONS === 'true',
      clearRemote: process.env.CLEAR_REMOTE === 'true'
    };
    
    // Check if this deployment was triggered by project file changes
    this.projectChanged = this.checkProjectChanges();
    
    // Validate required configuration
    this.validateConfig();
  }
  
  checkProjectChanges() {
    // Check if running in GitHub Actions and if project files were changed
    if (process.env.GITHUB_ACTIONS) {
      const eventPath = process.env.GITHUB_EVENT_PATH;
      if (eventPath && fs.existsSync(eventPath)) {
        try {
          const event = JSON.parse(fs.readFileSync(eventPath, 'utf8'));
          const changedFiles = event.commits?.flatMap(commit => 
            [...(commit.added || []), ...(commit.modified || []), ...(commit.removed || [])]
          ) || [];
          
          return changedFiles.some(file => 
            file.endsWith('.csproj') || 
            file.endsWith('.cs') || 
            file.includes('appsettings') ||
            file.includes('Program.cs')
          );
        } catch (error) {
          console.log('ℹ️  Could not detect project changes from GitHub event');
        }
      }
    }
    
    // Check if project files were recently modified (local deployment)
    try {
      const projectFiles = [
        this.config.projectFile,
        'Program.cs',
        'appsettings.json',
        'appsettings.Production.json'
      ];
      
      const oneHour = 60 * 60 * 1000;
      
      return projectFiles.some(file => {
        try {
          const stat = fs.statSync(file);
          const timeDiff = Date.now() - stat.mtime.getTime();
          return timeDiff < oneHour;
        } catch {
          return false;
        }
      });
    } catch (error) {
      return false;
    }
  }
  
  validateConfig() {
    const required = ['host', 'user', 'password'];
    const missing = required.filter(key => !this.config[key]);
    
    if (missing.length > 0) {
      console.error(`❌ Missing required environment variables: ${missing.map(k => 'API_FTP_' + k.toUpperCase()).join(', ')}`);
      console.error('Please check your .env file or environment variables.');
      process.exit(1);
    }
    
    if (!fs.existsSync(this.config.projectFile)) {
      console.error(`❌ Project file not found: ${this.config.projectFile}`);
      console.error('Please ensure you are in the correct directory.');
      process.exit(1);
    }
  }

  async buildProject() {
    console.log('🔨 Building .NET API project...');
    
    try {
      // Clean previous builds
      console.log('🧹 Cleaning previous builds...');
      await execAsync(`dotnet clean "${this.config.projectFile}"`);
      
      // Restore dependencies
      console.log('📦 Restoring dependencies...');
      await execAsync(`dotnet restore "${this.config.projectFile}"`);
      
      // Build and publish the project
      console.log(`🔨 Building project in ${this.config.configuration} mode...`);
      const publishCommand = `dotnet publish "${this.config.projectFile}" -c ${this.config.configuration} -o "${this.config.localPath}" --self-contained false --verbosity minimal`;
      
      const { stdout, stderr } = await execAsync(publishCommand);
      
      if (stderr && !stderr.includes('warning')) {
        console.error('❌ Build failed:', stderr);
        throw new Error('Build failed');
      }
      
      console.log('✅ Build completed successfully!');
      
      // Verify build output exists
      if (!fs.existsSync(this.config.localPath)) {
        throw new Error(`Build output directory not found: ${this.config.localPath}`);
      }
      
      // List build artifacts
      const files = fs.readdirSync(this.config.localPath);
      console.log(`📁 Build artifacts (${files.length} files):`);
      files.slice(0, 10).forEach(file => console.log(`   ${file}`));
      if (files.length > 10) {
        console.log(`   ... and ${files.length - 10} more files`);
      }
      
    } catch (error) {
      console.error('❌ Build failed:', error.message);
      throw error;
    }
  }

  async connect() {
    try {
      console.log(`🔌 Connecting to API FTP server ${this.config.host}...`);
      await this.client.access({
        host: this.config.host,
        user: this.config.user,
        password: this.config.password,
        port: this.config.port,
        secure: this.config.secure
      });
      console.log('✅ Connected successfully!');
    } catch (error) {
      console.error('❌ Connection failed:', error.message);
      throw error;
    }
  }

  async backupExistingDeployment() {
    try {
      const timestamp = new Date().toISOString().split('T')[0];
      const backupDir = `${this.config.remotePath}_backup_${timestamp}`.replace('//', '/');
      console.log(`💾 Creating backup: ${backupDir}`);
      
      // Check if the remote directory exists
      try {
        await this.client.cd(this.config.remotePath);
        // Directory exists, check if we can create backups
        await this.client.cd('/');
        
        try {
          await this.client.rename(this.config.remotePath, backupDir);
          console.log('✅ Backup created successfully!');
        } catch (renameError) {
          console.log('ℹ️  Cannot create backup (insufficient permissions), clearing directory instead...');
          // If we can't rename (backup), just clear the contents
          await this.clearRemoteDirectory();
        }
      } catch (error) {
        // Directory doesn't exist, no backup needed
        console.log('ℹ️  No existing deployment to backup');
      }
    } catch (error) {
      console.warn('⚠️  Backup failed (continuing anyway):', error.message);
    }
  }

  async clearRemoteDirectory() {
    try {
      console.log('🧹 Clearing remote directory...');
      
      // Navigate to target directory
      try {
        await this.client.cd(this.config.remotePath);
      } catch (error) {
        console.log(`ℹ️  Target directory ${this.config.remotePath} doesn't exist, skipping clear`);
        return;
      }
      
      // Clear directory contents
      try {
        await this.client.clearWorkingDir();
        console.log('✅ Remote directory cleared');
      } catch (error) {
        console.warn('⚠️  Could not clear directory automatically, trying manual cleanup...');
        // Manual cleanup if clearWorkingDir fails
        try {
          const list = await this.client.list();
          for (const item of list) {
            try {
              if (item.isDirectory) {
                await this.client.removeDir(item.name);
              } else {
                await this.client.remove(item.name);
              }
            } catch (removeError) {
              console.warn(`⚠️  Could not remove ${item.name}:`, removeError.message);
            }
          }
        } catch (listError) {
          console.warn('⚠️  Manual cleanup failed:', listError.message);
        }
      }
    } catch (error) {
      console.warn('⚠️  Failed to clear remote directory:', error.message);
    }
  }

  async uploadDirectory(localDir, remoteDir) {
    try {
      console.log(`📁 Creating remote directory: ${remoteDir}`);
      
      // Try to create the directory, but handle permission errors gracefully
      try {
        await this.client.ensureDir(remoteDir);
      } catch (error) {
        if (error.message.includes('550') && error.message.includes('Access is denied')) {
          console.log(`ℹ️  Directory creation not allowed, trying to navigate to existing directory...`);
          
          // Try to change to the directory - it might already exist
          try {
            await this.client.cd(remoteDir);
            console.log(`✅ Using existing directory: ${remoteDir}`);
          } catch (cdError) {
            console.log(`⚠️  Directory ${remoteDir} doesn't exist and can't be created.`);
            console.log(`ℹ️  Attempting to deploy to root directory instead...`);
            remoteDir = '/'; // Deploy to root if subdirectory can't be created
            await this.client.cd('/');
          }
        } else {
          throw error; // Re-throw if it's a different error
        }
      }
      
      console.log(`📤 Uploading from ${localDir} to ${remoteDir}`);
      
      const files = fs.readdirSync(localDir);
      let uploadedCount = 0;
      
      for (const file of files) {
        const localFile = path.join(localDir, file);
        const remoteFile = `${remoteDir}/${file}`;
        const stat = fs.statSync(localFile);
        
        if (stat.isDirectory()) {
          await this.uploadDirectory(localFile, remoteFile);
        } else {
          // Skip certain files that shouldn't be deployed
          if (this.shouldSkipFile(file)) {
            console.log(`⏭️  Skipping: ${file}`);
            continue;
          }
          
          console.log(`📄 Uploading: ${file} (${this.formatBytes(stat.size)})`);
          await this.client.uploadFrom(localFile, remoteFile);
          uploadedCount++;
        }
      }
      
      console.log(`✅ Uploaded ${uploadedCount} files from ${path.basename(localDir)}`);
      
    } catch (error) {
      console.error(`❌ Upload failed for ${localDir}:`, error.message);
      throw error;
    }
  }

  shouldSkipFile(filename) {
    const skipPatterns = [
      /\.pdb$/,           // Debug symbols
      /\.xml$/,           // Documentation files
      /\.dev\.json$/,     // Development settings
      /web\.config$/,     // IIS config (we'll create our own)
      /\.log$/,           // Log files
      /\.tmp$/,           // Temporary files
    ];
    
    return skipPatterns.some(pattern => pattern.test(filename));
  }

  async createWebConfig() {
    const webConfigContent = `<?xml version="1.0" encoding="utf-8"?>
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
          <environmentVariable name="ASPNETCORE_URLS" value="http://+:80" />
        </environmentVariables>
      </aspNetCore>
      <security>
        <requestFiltering>
          <requestLimits maxAllowedContentLength="52428800" />
        </requestFiltering>
      </security>
      <httpErrors errorMode="Detailed" />
      <defaultDocument>
        <files>
          <clear />
        </files>
      </defaultDocument>
    </system.webServer>
  </location>
</configuration>`;

    const webConfigPath = path.join(this.config.localPath, 'web.config');
    fs.writeFileSync(webConfigPath, webConfigContent);
    console.log('✅ Created web.config for IIS deployment');
  }

  async validateDeployment() {
    try {
      console.log('🔍 Validating deployment...');
      
      // Check if main DLL exists
      const mainDll = 'WanderlustApi.dll';
      await this.client.cd(this.config.remotePath);
      
      try {
        const list = await this.client.list();
        const hasMainDll = list.some(item => item.name === mainDll);
        
        if (!hasMainDll) {
          throw new Error(`Main application file ${mainDll} not found in deployment`);
        }
        
        console.log('✅ Deployment validation passed!');
        
        // List deployed files
        console.log('📁 Deployed files:');
        list.slice(0, 10).forEach(item => {
          const size = item.type === 1 ? '' : ` (${this.formatBytes(item.size)})`;
          console.log(`   ${item.name}${size}`);
        });
        
        if (list.length > 10) {
          console.log(`   ... and ${list.length - 10} more files`);
        }
        
      } catch (error) {
        throw new Error(`Validation failed: ${error.message}`);
      }
      
    } catch (error) {
      console.error('❌ Deployment validation failed:', error.message);
      throw error;
    }
  }

  formatBytes(bytes) {
    if (bytes === 0) return '0 B';
    const k = 1024;
    const sizes = ['B', 'KB', 'MB', 'GB'];
    const i = Math.floor(Math.log(bytes) / Math.log(k));
    return parseFloat((bytes / Math.pow(k, i)).toFixed(1)) + ' ' + sizes[i];
  }

  async disconnect() {
    try {
      this.client.close();
      console.log('🔌 Disconnected from FTP server');
    } catch (error) {
      console.warn('⚠️  Error during disconnect:', error.message);
    }
  }

  async deploy() {
    const startTime = Date.now();
    
    try {
      console.log('🚀 Starting API deployment...');
      console.log(`📂 Project: ${this.config.projectFile}`);
      console.log(`🎯 Target: ${this.config.host}${this.config.remotePath}`);
      console.log(`⚙️  Configuration: ${this.config.configuration}`);
      
      if (this.projectChanged) {
        console.log('✨ Project files changed - full deployment');
      } else {
        console.log('ℹ️  No recent changes detected - deploying anyway');
      }
      
      // Step 1: Build the project (skip in GitHub Actions if already built)
      if (!this.config.isGitHubActions || !fs.existsSync(this.config.localPath)) {
        await this.buildProject();
      } else {
        console.log('ℹ️  Skipping build - using pre-built artifacts from GitHub Actions');
      }
      
      // Step 2: Create web.config for IIS (if not already exists)
      if (!fs.existsSync(path.join(this.config.localPath, 'web.config'))) {
        await this.createWebConfig();
      }
      
      // Step 3: Connect to FTP
      await this.connect();
      
      // Step 4: Backup existing deployment
      // await this.backupExistingDeployment();
      
      // Step 5: Clear remote directory if requested
      await this.clearRemoteDirectory();
      
      // Step 6: Upload files
      await this.uploadDirectory(this.config.localPath, this.config.remotePath);
      
      // Step 7: Validate deployment
      await this.validateDeployment();
      
      const duration = ((Date.now() - startTime) / 1000).toFixed(1);
      console.log(`\n🎉 API deployment completed successfully in ${duration}s!`);
      console.log(`🌐 API should be accessible at: https://${this.config.host}${this.config.remotePath}`);
      
    } catch (error) {
      console.error('\n❌ Deployment failed:', error.message);
      process.exit(1);
    } finally {
      await this.disconnect();
    }
  }
}

// Run deployment if script is executed directly
if (require.main === module) {
  const deployer = new ApiDeploymentManager();
  deployer.deploy().catch(error => {
    console.error('💥 Deployment crashed:', error);
    process.exit(1);
  });
}

module.exports = ApiDeploymentManager;
