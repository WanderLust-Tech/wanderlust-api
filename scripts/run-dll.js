#!/usr/bin/env node

const { spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

class DotNetRunner {
  constructor() {
    this.dllName = 'WanderlustApi.dll';
    this.possiblePaths = [
      // Published folder profile output
      'bin/Release/net8.0/win-x64/publish',
      // Regular build output
      'bin/Release/net8.0',
      'bin/Debug/net8.0',
      // Alternative publish locations
      'bin/Release/net8.0/publish',
      'bin/publish',
      'publish'
    ];
  }

  findDll() {
    console.log('🔍 Searching for WanderlustApi.dll...');
    
    for (const searchPath of this.possiblePaths) {
      const fullPath = path.join(searchPath, this.dllName);
      const absolutePath = path.resolve(fullPath);
      
      if (fs.existsSync(fullPath)) {
        console.log(`✅ Found DLL at: ${fullPath}`);
        console.log(`📍 Absolute path: ${absolutePath}`);
        return fullPath;
      } else {
        console.log(`⏭️  Not found: ${fullPath}`);
      }
    }
    
    console.log(`❌ Could not find ${this.dllName} in any of the expected locations.`);
    console.log('💡 Try running one of these commands first:');
    console.log('   npm run build');
    console.log('   npm run publish:folder');
    console.log('   dotnet build');
    console.log('   dotnet publish');
    
    return null;
  }

  async runDll(dllPath, options = {}) {
    const {
      environment = 'Development',
      urls = 'https://localhost:7134;http://localhost:5134',
      additionalArgs = []
    } = options;

    console.log('🚀 Starting WanderlustApi...');
    console.log(`📂 DLL: ${dllPath}`);
    console.log(`🌍 Environment: ${environment}`);
    console.log(`🌐 URLs: ${urls}`);
    
    const env = {
      ...process.env,
      ASPNETCORE_ENVIRONMENT: environment,
      ASPNETCORE_URLS: urls
    };

    const args = [dllPath, ...additionalArgs];
    
    console.log(`🔨 Command: dotnet ${args.join(' ')}`);
    console.log('📊 Environment Variables:');
    console.log(`   ASPNETCORE_ENVIRONMENT=${environment}`);
    console.log(`   ASPNETCORE_URLS=${urls}`);
    console.log('');
    console.log('🎯 Starting server...');
    console.log('─'.repeat(50));

    const process = spawn('dotnet', args, {
      env,
      stdio: 'inherit',
      shell: true
    });

    process.on('error', (err) => {
      console.error('❌ Failed to start process:', err.message);
      process.exit(1);
    });

    process.on('exit', (code) => {
      if (code === 0) {
        console.log('✅ Application exited successfully');
      } else {
        console.log(`❌ Application exited with code: ${code}`);
      }
    });

    // Handle Ctrl+C gracefully
    process.on('SIGINT', () => {
      console.log('\n🛑 Shutting down gracefully...');
      process.kill();
    });

    return process;
  }

  showHelp() {
    console.log(`
🚀 WanderlustApi DLL Runner

Usage:
  node scripts/run-dll.js [options]

Options:
  --env <environment>     Set ASPNETCORE_ENVIRONMENT (Development, Production, Staging)
  --urls <urls>          Set ASPNETCORE_URLS (default: https://localhost:7134;http://localhost:5134)
  --path <path>          Specify custom DLL path
  --help                 Show this help message

Examples:
  node scripts/run-dll.js
  node scripts/run-dll.js --env Production
  node scripts/run-dll.js --env Development --urls "http://localhost:5000"
  node scripts/run-dll.js --path "custom/path/WanderlustApi.dll"

NPM Scripts (easier to use):
  npm run start:published         # Run published DLL (Development)
  npm run start:production        # Run published DLL (Production)
  npm run start:staging           # Run published DLL (Staging)
  npm run start:published-urls    # Run with custom URLs
`);
  }

  parseArgs() {
    const args = process.argv.slice(2);
    const options = {
      environment: 'Development',
      urls: 'https://localhost:7134;http://localhost:5134',
      customPath: null,
      help: false
    };

    for (let i = 0; i < args.length; i++) {
      switch (args[i]) {
        case '--env':
          options.environment = args[++i];
          break;
        case '--urls':
          options.urls = args[++i];
          break;
        case '--path':
          options.customPath = args[++i];
          break;
        case '--help':
        case '-h':
          options.help = true;
          break;
        default:
          console.log(`❌ Unknown option: ${args[i]}`);
          options.help = true;
          break;
      }
    }

    return options;
  }

  async run() {
    const options = this.parseArgs();

    if (options.help) {
      this.showHelp();
      return;
    }

    let dllPath;
    
    if (options.customPath) {
      if (fs.existsSync(options.customPath)) {
        dllPath = options.customPath;
        console.log(`✅ Using custom DLL path: ${dllPath}`);
      } else {
        console.log(`❌ Custom DLL path not found: ${options.customPath}`);
        return;
      }
    } else {
      dllPath = this.findDll();
      if (!dllPath) {
        return;
      }
    }

    await this.runDll(dllPath, {
      environment: options.environment,
      urls: options.urls
    });
  }
}

// Run if called directly
if (require.main === module) {
  const runner = new DotNetRunner();
  runner.run().catch(err => {
    console.error('💥 Fatal error:', err);
    process.exit(1);
  });
}

module.exports = DotNetRunner;
