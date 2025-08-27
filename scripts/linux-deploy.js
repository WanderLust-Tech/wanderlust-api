#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const { exec } = require('child_process');
const util = require('util');
const execAsync = util.promisify(exec);

class LinuxDeploymentManager {
  constructor() {
    this.profiles = {
      'self-contained': {
        profile: 'Linux-Server',
        path: 'bin/Release/net8.0/linux-x64/publish',
        description: 'Self-contained deployment (includes .NET runtime)'
      },
      'framework-dependent': {
        profile: 'Linux-Server-FDD',
        path: 'bin/Release/net8.0/linux-x64/publish-fdd',
        description: 'Framework-dependent deployment (requires .NET runtime on server)'
      },
      'docker': {
        profile: 'Linux-Docker',
        path: 'bin/Release/net8.0/linux-x64/publish-docker',
        description: 'Docker containerized deployment'
      }
    };
  }

  showHelp() {
    console.log(`
🐧 WanderlustApi Linux Deployment Helper

Usage:
  node scripts/linux-deploy.js [command] [options]

Commands:
  build <type>           Build deployment package
  deploy <type> <server> Deploy to Linux server via SCP
  docker <action>        Docker operations
  help                   Show this help

Deployment Types:
  self-contained         Self-contained deployment (larger, no runtime needed)
  framework-dependent    Framework-dependent deployment (smaller, runtime required)
  docker                 Docker containerized deployment

Examples:
  node scripts/linux-deploy.js build self-contained
  node scripts/linux-deploy.js build framework-dependent
  node scripts/linux-deploy.js build docker
  node scripts/linux-deploy.js deploy self-contained user@server:/opt/wanderlust-api
  node scripts/linux-deploy.js docker build
  node scripts/linux-deploy.js docker run

NPM Scripts (recommended):
  npm run publish:linux          # Self-contained
  npm run publish:linux-fdd      # Framework-dependent  
  npm run publish:docker         # Docker
`);
  }

  async buildDeployment(type) {
    if (!this.profiles[type]) {
      console.error(`❌ Unknown deployment type: ${type}`);
      console.log('Available types:', Object.keys(this.profiles).join(', '));
      return;
    }

    const profile = this.profiles[type];
    console.log(`🔨 Building ${type} deployment...`);
    console.log(`📋 Profile: ${profile.profile}`);
    console.log(`📁 Output: ${profile.path}`);
    console.log(`📖 Description: ${profile.description}`);
    console.log('');

    try {
      const command = `dotnet publish --configuration Release /p:PublishProfile=${profile.profile}`;
      console.log(`🚀 Running: ${command}`);
      
      const { stdout, stderr } = await execAsync(command);
      
      if (stderr && !stderr.includes('warning')) {
        console.error('❌ Build failed:', stderr);
        return;
      }

      console.log('✅ Build completed successfully!');
      
      // Verify output
      if (fs.existsSync(profile.path)) {
        const files = fs.readdirSync(profile.path);
        console.log(`📦 Generated ${files.length} files in ${profile.path}`);
        
        // Show deployment info if it exists
        const infoPath = path.join(profile.path, 'deployment-info.txt');
        if (fs.existsSync(infoPath)) {
          console.log('\n📋 Deployment Instructions:');
          console.log('─'.repeat(50));
          const info = fs.readFileSync(infoPath, 'utf8');
          console.log(info);
        }
      } else {
        console.error(`❌ Output directory not found: ${profile.path}`);
      }

    } catch (error) {
      console.error('❌ Build failed:', error.message);
    }
  }

  async deployToServer(type, server) {
    if (!this.profiles[type]) {
      console.error(`❌ Unknown deployment type: ${type}`);
      return;
    }

    const profile = this.profiles[type];
    
    if (!fs.existsSync(profile.path)) {
      console.error(`❌ Deployment package not found: ${profile.path}`);
      console.log(`💡 Run: node scripts/linux-deploy.js build ${type}`);
      return;
    }

    console.log(`🚀 Deploying ${type} to ${server}...`);
    
    try {
      // Create remote directory
      const serverParts = server.split(':');
      const sshTarget = serverParts[0];
      const remotePath = serverParts[1] || '/opt/wanderlust-api';

      console.log(`📂 Creating remote directory: ${remotePath}`);
      await execAsync(`ssh ${sshTarget} "mkdir -p ${remotePath}"`);

      // Copy files via SCP
      console.log(`📤 Copying files to ${server}...`);
      await execAsync(`scp -r ${profile.path}/* ${server}/`);

      // Set permissions for executable
      if (type === 'self-contained') {
        console.log(`🔧 Setting executable permissions...`);
        await execAsync(`ssh ${sshTarget} "chmod +x ${remotePath}/WanderlustApi"`);
      }

      console.log('✅ Deployment completed successfully!');
      console.log('\n📋 Next steps on the server:');
      
      if (type === 'self-contained') {
        console.log(`  ssh ${sshTarget}`);
        console.log(`  cd ${remotePath}`);
        console.log(`  export ASPNETCORE_ENVIRONMENT=Production`);
        console.log(`  export ASPNETCORE_URLS=http://+:5000`);
        console.log(`  ./WanderlustApi`);
      } else if (type === 'framework-dependent') {
        console.log(`  ssh ${sshTarget}`);
        console.log(`  # Install .NET 8 runtime if not already installed`);
        console.log(`  cd ${remotePath}`);
        console.log(`  export ASPNETCORE_ENVIRONMENT=Production`);
        console.log(`  export ASPNETCORE_URLS=http://+:5000`);
        console.log(`  dotnet WanderlustApi.dll`);
      }

    } catch (error) {
      console.error('❌ Deployment failed:', error.message);
      console.log('\n💡 Make sure you have SSH access to the server and SCP is available');
    }
  }

  async dockerOperations(action) {
    const dockerPath = this.profiles.docker.path;
    
    switch (action) {
      case 'build':
        if (!fs.existsSync(dockerPath)) {
          console.log('🔨 Building Docker deployment package first...');
          await this.buildDeployment('docker');
        }
        
        console.log('🐳 Building Docker image...');
        try {
          await execAsync(`docker build -t wanderlust-api ${dockerPath}`);
          console.log('✅ Docker image built successfully!');
          console.log('🚀 To run: docker run -p 5000:80 wanderlust-api');
        } catch (error) {
          console.error('❌ Docker build failed:', error.message);
        }
        break;

      case 'run':
        console.log('🚀 Running Docker container...');
        try {
          await execAsync('docker run -d -p 5000:80 --name wanderlust-api-container wanderlust-api');
          console.log('✅ Container started successfully!');
          console.log('🌐 API should be available at: http://localhost:5000');
          console.log('📊 To view logs: docker logs wanderlust-api-container');
          console.log('🛑 To stop: docker stop wanderlust-api-container');
        } catch (error) {
          console.error('❌ Failed to run container:', error.message);
        }
        break;

      case 'compose':
        if (!fs.existsSync(dockerPath)) {
          await this.buildDeployment('docker');
        }
        
        console.log('🐳 Starting with Docker Compose...');
        try {
          await execAsync(`docker-compose -f ${dockerPath}/docker-compose.yml up -d`);
          console.log('✅ Services started with Docker Compose!');
        } catch (error) {
          console.error('❌ Docker Compose failed:', error.message);
        }
        break;

      default:
        console.log('Available Docker actions: build, run, compose');
        break;
    }
  }

  async run() {
    const args = process.argv.slice(2);
    
    if (args.length === 0 || args[0] === 'help') {
      this.showHelp();
      return;
    }

    const command = args[0];
    
    switch (command) {
      case 'build':
        const buildType = args[1];
        if (!buildType) {
          console.error('❌ Please specify deployment type');
          console.log('Available types:', Object.keys(this.profiles).join(', '));
          return;
        }
        await this.buildDeployment(buildType);
        break;

      case 'deploy':
        const deployType = args[1];
        const server = args[2];
        if (!deployType || !server) {
          console.error('❌ Please specify deployment type and server');
          console.log('Usage: node scripts/linux-deploy.js deploy <type> <user@server:/path>');
          return;
        }
        await this.deployToServer(deployType, server);
        break;

      case 'docker':
        const dockerAction = args[1] || 'build';
        await this.dockerOperations(dockerAction);
        break;

      default:
        console.error(`❌ Unknown command: ${command}`);
        this.showHelp();
        break;
    }
  }
}

// Run if called directly
if (require.main === module) {
  const deployer = new LinuxDeploymentManager();
  deployer.run().catch(err => {
    console.error('💥 Fatal error:', err);
    process.exit(1);
  });
}

module.exports = LinuxDeploymentManager;
