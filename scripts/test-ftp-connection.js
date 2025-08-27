#!/usr/bin/env node

const ftp = require('basic-ftp');
require('dotenv').config();

async function testFtpConnection() {
  const client = new ftp.Client();
  client.ftp.verbose = true;
  
  const config = {
    host: process.env.API_FTP_HOST,
    user: process.env.API_FTP_USER,
    password: process.env.API_FTP_PASSWORD,
    port: process.env.API_FTP_PORT || 21,
    secure: process.env.API_FTP_SECURE === 'true',
    remotePath: process.env.API_FTP_REMOTE_PATH || '/api'
  };
  
  // Validate required configuration
  const required = ['host', 'user', 'password'];
  const missing = required.filter(key => !config[key]);
  
  if (missing.length > 0) {
    console.error(`❌ Missing required environment variables: ${missing.map(k => 'API_FTP_' + k.toUpperCase()).join(', ')}`);
    console.error('Please check your .env file.');
    process.exit(1);
  }
  
  try {
    console.log('🔌 Testing FTP connection...');
    console.log(`📡 Host: ${config.host}:${config.port}`);
    console.log(`👤 User: ${config.user}`);
    console.log(`🔒 Secure: ${config.secure ? 'Yes (FTPS)' : 'No (FTP)'}`);
    
    await client.access({
      host: config.host,
      user: config.user,
      password: config.password,
      port: config.port,
      secure: config.secure
    });
    
    console.log('✅ Connection successful!');
    
    // Test directory operations
    console.log(`📁 Testing directory access: ${config.remotePath}`);
    
    try {
      await client.ensureDir(config.remotePath);
      console.log('✅ Remote directory accessible/created');
      
      // List contents
      const list = await client.list(config.remotePath);
      console.log(`📄 Directory contents (${list.length} items):`);
      
      if (list.length === 0) {
        console.log('   (empty directory)');
      } else {
        list.slice(0, 5).forEach(item => {
          const type = item.type === 1 ? '📁' : '📄';
          const size = item.type === 1 ? '' : ` (${formatBytes(item.size)})`;
          console.log(`   ${type} ${item.name}${size}`);
        });
        
        if (list.length > 5) {
          console.log(`   ... and ${list.length - 5} more items`);
        }
      }
      
    } catch (error) {
      console.warn(`⚠️  Directory test failed: ${error.message}`);
    }
    
    // Test write permissions
    console.log('✍️  Testing write permissions...');
    try {
      const testFile = `${config.remotePath}/test-${Date.now()}.txt`;
      const testContent = 'API deployment test file';
      
      await client.uploadFrom(Buffer.from(testContent), testFile);
      console.log('✅ Write test successful');
      
      // Clean up test file
      await client.remove(testFile);
      console.log('🧹 Test file cleaned up');
      
    } catch (error) {
      console.warn(`⚠️  Write test failed: ${error.message}`);
    }
    
    console.log('\n🎉 FTP connection test completed successfully!');
    console.log('💡 You can now run: npm run deploy');
    
  } catch (error) {
    console.error('\n❌ Connection test failed:', error.message);
    console.error('\n🔧 Troubleshooting tips:');
    console.error('   • Check your FTP credentials in .env file');
    console.error('   • Verify the FTP server is accessible');
    console.error('   • Try different port (21 for FTP, 990 for FTPS)');
    console.error('   • Check if FTPS is required (set API_FTP_SECURE=true)');
    process.exit(1);
    
  } finally {
    client.close();
  }
}

function formatBytes(bytes) {
  if (bytes === 0) return '0 B';
  const k = 1024;
  const sizes = ['B', 'KB', 'MB', 'GB'];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(1)) + ' ' + sizes[i];
}

// Run if script is executed directly
if (require.main === module) {
  testFtpConnection().catch(error => {
    console.error('💥 Test crashed:', error);
    process.exit(1);
  });
}

module.exports = testFtpConnection;
