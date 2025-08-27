# Wanderlust API 🚀

A comprehensive, enterprise-grade .NET 8 Web API backend for the Wanderlust Knowledge Base platform, providing robust data management, real-time communication, and advanced content management services for the Chromium development learning platform.

## 🌟 Current Version: 3.3.0

**Latest Update**: Added comprehensive real-time communication features with SignalR, enterprise-grade security, CMS functionality, and complete CI/CD deployment system.

## 🚀 Features Overview

### 🔐 **Authentication & Security**
- **JWT Authentication** - Secure token-based authentication with refresh tokens
- **Role-Based Authorization** - Member, Contributor, Moderator, Admin roles
- **Enterprise Security Headers** - Complete OWASP security implementation
- **Rate Limiting** - Intelligent rate limiting with user-specific quotas
- **Input Validation** - SQL injection, XSS, and command injection protection
- **HTTPS Enforcement** - Production-ready SSL/TLS with HSTS

### 📊 **Content Management System (CMS)**
- **Content Management** - Full CRUD operations for articles and media
- **Media Library** - File upload, storage, and management system
- **Content Templates** - Reusable content templates and workflows
- **Publishing Workflows** - Draft, review, and publish content lifecycle
- **Content Analytics** - Comprehensive content performance metrics

### 💬 **Real-Time Communication**
- **SignalR Integration** - Live updates for community features
- **Real-Time Notifications** - Instant updates for posts, comments, reactions
- **Typing Indicators** - Live typing feedback in discussions
- **User Presence** - Online/offline status and activity tracking
- **Group Management** - Join/leave specific discussions and categories

### 🔄 **Content Synchronization**
- **Markdown-to-Database Sync** - Bidirectional content synchronization
- **Intelligent Conflict Resolution** - Smart handling of file vs database conflicts
- **Bulk Operations** - Mass content import/export capabilities
- **Content Validation** - Pre-sync validation with detailed reporting

### 🛡️ **Error Handling & Resilience**
- **Comprehensive Error Handling** - Categorized error management system
- **Offline Support** - Graceful degradation and automatic recovery
- **Loading States** - Professional progress tracking and user feedback
- **Circuit Breaker Patterns** - Smart failure detection and recovery

### 📝 **Logging & Monitoring**
- **Serilog File Logging** - Structured logging to daily rolling files
- **Performance Monitoring** - Request/response time tracking
- **Security Audit Logging** - Authentication and authorization events
- **Health Checks** - Comprehensive API health monitoring

### 🚀 **Deployment & DevOps**
- **GitHub Actions CI/CD** - Automated build, test, and deployment
- **Multiple Publishing Profiles** - Windows, Linux, Docker deployments
- **FTP Deployment** - Automated FTP deployment with backup systems
- **Environment-Specific Configurations** - Development, staging, production

## 🏗️ Architecture

### Technology Stack
- **.NET 8** - Latest LTS version with improved performance
- **Entity Framework Core** - Modern ORM with MySQL support
- **SignalR** - Real-time web communication
- **Serilog** - Structured logging framework
- **JWT** - JSON Web Token authentication
- **MySQL** - Primary database with full-text search
- **Redis** (Optional) - Caching and session storage

### Project Structure
```
WanderlustApi/
├── Controllers/           # API endpoints and request handling
│   ├── ArticlesController.cs
│   ├── CodeExamplesController.cs
│   ├── CmsController.cs
│   ├── AuthController.cs
│   └── MediaController.cs
├── Models/               # Data models and DTOs
│   ├── Article.cs
│   ├── CodeExample.cs
│   ├── CmsModels.cs
│   └── AuthModels.cs
├── Data/                 # Database context and configurations
│   └── WanderlustDbContext.cs
├── Services/             # Business logic and services
├── Migrations/           # Database migration files
├── Properties/           # Configuration and publishing profiles
│   ├── launchSettings.json
│   └── PublishProfiles/
├── scripts/              # Deployment and utility scripts
└── bin/Debug/net8.0/     # Compiled application
```

## 🚀 Quick Start

### Prerequisites
- **.NET 8 SDK** or later
- **MySQL Server** (8.0+)
- **Node.js** (18+) for npm scripts
- **Git** for version control

### 1. Clone & Setup
```powershell
git clone <repository-url>
cd wanderlust-platform/api
dotnet restore
```

### 2. Database Configuration
Update connection string in `appsettings.json`:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Database=wanderlust_db;User=root;Password=your_password;"
  }
}
```

### 3. Database Migration
```powershell
dotnet ef database update
```

### 4. Run Development Server
```powershell
dotnet run
```

The API will be available at:
- **HTTP**: `http://localhost:5000`
- **HTTPS**: `https://localhost:5001`
- **Swagger UI**: `https://localhost:5001/swagger`

## 🛠️ Development Workflow

### NPM Scripts (package.json)
```bash
npm run build          # Build the project
npm run publish        # Publish for production
npm run publish:iis    # Publish for IIS deployment
npm run publish:linux  # Publish for Linux deployment
npm run publish:docker # Publish for Docker
npm run publish:ftp    # Publish and deploy via FTP
npm run run            # Run the published DLL
npm run deploy         # Deploy to configured environment
npm run clean          # Clean build artifacts
```

### Database Operations
```powershell
# Create migration
dotnet ef migrations add MigrationName

# Update database
dotnet ef database update

# Remove migration
dotnet ef migrations remove

# Generate SQL script
dotnet ef migrations script
```

### Publishing Profiles

#### Available Profiles
- **IIS Deployment** - Windows Server with IIS
- **Linux Deployment** - Ubuntu/CentOS with systemd
- **Docker Deployment** - Containerized deployment
- **FTP Deployment** - Automated FTP with backup

See [Publishing Profiles Documentation](Properties/PublishProfiles/README.md) for detailed configuration.

## 🔧 Configuration

### Environment Variables
```bash
# Database
CONNECTION_STRING=Server=localhost;Database=wanderlust_db;User=root;Password=***

# JWT Configuration
JWT_SECRET=your-super-secret-jwt-key-here
JWT_ISSUER=WanderlustAPI
JWT_AUDIENCE=WanderlustClients

# File Upload
MAX_FILE_SIZE=10485760  # 10MB
UPLOAD_PATH=./uploads

# SignalR
SIGNALR_ENABLED=true
REDIS_CONNECTION=localhost:6379  # Optional for scaling

# Logging
LOG_LEVEL=Information
LOG_FILE_PATH=./logs/wanderlust-api-.log
```

### Security Configuration
```json
{
  "Security": {
    "RequireHttps": true,
    "EnableRateLimiting": true,
    "RateLimitRequests": 100,
    "RateLimitWindow": "00:01:00",
    "JwtExpirationMinutes": 60,
    "RefreshTokenExpirationDays": 7
  }
}
```

## 🚀 API Documentation

### Core Endpoints

#### Authentication
```
POST /api/auth/login          # User login
POST /api/auth/register       # User registration
POST /api/auth/refresh        # Refresh JWT token
POST /api/auth/logout         # User logout
```

#### Content Management
```
GET    /api/articles          # Get all articles
GET    /api/articles/{id}     # Get specific article
POST   /api/articles          # Create new article
PUT    /api/articles/{id}     # Update article
DELETE /api/articles/{id}     # Delete article

GET    /api/codeexamples      # Get code examples
POST   /api/codeexamples      # Create code example
PUT    /api/codeexamples/{id} # Update code example
DELETE /api/codeexamples/{id} # Delete code example
```

#### CMS Operations
```
GET    /api/cms/content       # Get all content
POST   /api/cms/content       # Create content
PUT    /api/cms/content/{id}  # Update content
DELETE /api/cms/content/{id}  # Delete content

POST   /api/cms/media         # Upload media
GET    /api/cms/media         # Get media list
DELETE /api/cms/media/{id}    # Delete media
```

#### Real-Time Features (SignalR)
```
/hubs/community              # Community discussions hub
  - JoinGroup(groupName)     # Join discussion group
  - LeaveGroup(groupName)    # Leave discussion group
  - SendMessage(message)     # Send message to group
  - TypingIndicator(isTyping) # Show typing status
```

### Response Format
All API responses follow this structure:
```json
{
  "success": true,
  "data": { ... },
  "message": "Operation completed successfully",
  "timestamp": "2024-01-15T10:30:00Z"
}
```

### Error Handling
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input data",
    "details": ["Title is required", "Content cannot be empty"]
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

## 🔒 Security Features

### Authentication Flow
1. **Login** - User provides credentials
2. **JWT Generation** - Server generates access + refresh tokens
3. **Token Usage** - Client includes JWT in Authorization header
4. **Token Refresh** - Use refresh token to get new access token
5. **Logout** - Invalidate tokens on server

### Authorization Levels
- **Anonymous** - Public content access
- **Member** - Basic authenticated features
- **Contributor** - Content creation and editing
- **Moderator** - Content moderation and user management
- **Admin** - Full system administration

### Security Headers
```
Strict-Transport-Security: max-age=31536000; includeSubDomains
X-Content-Type-Options: nosniff
X-Frame-Options: DENY
X-XSS-Protection: 1; mode=block
Content-Security-Policy: default-src 'self'
```

## 📊 Logging & Monitoring

### Log Files
- **Location**: `./logs/` directory
- **Format**: JSON structured logging
- **Rotation**: Daily files with retention policy
- **Files**:
  - `wanderlust-api-YYYYMMDD.log` - Application logs
  - `wanderlust-api-errors-YYYYMMDD.log` - Error logs only

### Log Levels
- **Verbose** - Detailed diagnostic information
- **Debug** - Debugging information
- **Information** - General application flow
- **Warning** - Potentially harmful situations
- **Error** - Error events that might still allow the app to continue
- **Fatal** - Very severe error events that might cause the app to terminate

### Monitoring Endpoints
```
GET /health              # Basic health check
GET /health/detailed     # Detailed health information
GET /metrics             # Application metrics (if enabled)
```

## 🚀 Deployment Guide

### Development Deployment
```powershell
# Quick development setup
dotnet run --environment Development
```

### Production Deployment

#### Option 1: IIS Deployment
```powershell
npm run publish:iis
# Copy published files to IIS wwwroot
# Configure IIS application pool for .NET 8
```

#### Option 2: Linux Deployment
```powershell
npm run publish:linux
# Transfer files to Linux server
# Configure systemd service
# Set up reverse proxy (nginx/apache)
```

#### Option 3: Docker Deployment
```powershell
npm run publish:docker
docker build -t wanderlust-api .
docker run -p 8080:8080 wanderlust-api
```

#### Option 4: FTP Deployment
```powershell
# Configure FTP settings in deploy.js
npm run publish:ftp
```

### Environment-Specific Configurations
- **Development**: `appsettings.Development.json`
- **Production**: `appsettings.Production.json`
- **Docker**: Environment variables in container

## 🧪 Testing

### Running Tests
```powershell
dotnet test                    # Run all tests
dotnet test --logger trx       # Generate test results
dotnet test --collect:"XPlat Code Coverage"  # Code coverage
```

### Test Categories
- **Unit Tests** - Individual component testing
- **Integration Tests** - API endpoint testing
- **Security Tests** - Authentication and authorization
- **Performance Tests** - Load and stress testing

## 🤝 Contributing

### Development Setup
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and ensure they pass
5. Update documentation if needed
6. Submit a pull request

### Code Standards
- Follow .NET coding conventions
- Use meaningful variable and method names
- Add XML documentation for public APIs
- Include unit tests for new features
- Update README for significant changes

### Pull Request Process
1. Ensure all tests pass
2. Update documentation
3. Add/update API documentation
4. Request review from maintainers
5. Address feedback promptly

## 📋 Troubleshooting

### Common Issues

#### Database Connection Issues
```
Error: Unable to connect to MySQL
Solution: Check connection string, MySQL service status
```

#### Migration Errors
```
Error: Migration failed
Solution: Check database permissions, existing schema conflicts
```

#### JWT Token Issues
```
Error: Unauthorized (401)
Solution: Check token expiration, JWT secret configuration
```

#### File Upload Issues
```
Error: File upload failed
Solution: Check file size limits, upload directory permissions
```

### Debug Mode
```powershell
# Run with verbose logging
dotnet run --environment Development --verbosity detailed
```

### Health Checks
```bash
curl https://localhost:5001/health
curl https://localhost:5001/health/detailed
```

## 📚 Additional Documentation

- **[Publishing Profiles Guide](Properties/PublishProfiles/README.md)** - Detailed deployment configurations
- **[API Reference](https://localhost:5001/swagger)** - Interactive API documentation
- **[Database Schema](docs/database-schema.md)** - Complete database documentation
- **[Security Guide](docs/security.md)** - Security implementation details
- **[Deployment Checklist](docs/deployment-checklist.md)** - Pre-deployment verification

## 🔄 Changelog

### Version 3.3.0 (Current)
- ✅ Added comprehensive CMS functionality
- ✅ Implemented SignalR real-time communication
- ✅ Enhanced security with JWT and rate limiting
- ✅ Added Serilog file logging system
- ✅ Created multiple publishing profiles
- ✅ Added npm scripts for deployment automation
- ✅ Implemented health checks and monitoring

### Version 3.2.0
- ✅ Enhanced authentication system
- ✅ Added media management capabilities
- ✅ Improved error handling and validation

### Version 3.1.0
- ✅ Added community features
- ✅ Implemented user roles and permissions
- ✅ Enhanced API documentation

### Version 3.0.0
- ✅ Major architecture refactor
- ✅ Upgraded to .NET 8
- ✅ Added Entity Framework Core
- ✅ Implemented modern API patterns

## 📞 Support

### Getting Help
- **Documentation**: Check this README and linked guides
- **Issues**: Create GitHub issues for bugs or feature requests
- **Discussions**: Use GitHub Discussions for questions
- **Security**: Report security issues via private channels

### Contact Information
- **Project Repository**: [GitHub Repository URL]
- **Documentation Site**: [Documentation URL]
- **Support Email**: [Support Email]

---

## 🎯 Quick Reference

### Essential Commands
```powershell
# Development
dotnet run
dotnet watch run

# Database
dotnet ef database update
dotnet ef migrations add NewMigration

# Publishing
npm run publish
npm run publish:iis
npm run publish:linux

# Deployment
npm run deploy
npm run publish:ftp
```

### Key URLs
- **API Base**: `https://localhost:5001/api`
- **Swagger**: `https://localhost:5001/swagger`
- **Health Check**: `https://localhost:5001/health`
- **SignalR Hub**: `https://localhost:5001/hubs/community`

### Configuration Files
- `appsettings.json` - Main configuration
- `appsettings.Development.json` - Development overrides
- `appsettings.Production.json` - Production overrides
- `package.json` - NPM scripts and dependencies

---

**Made with ❤️ for the Chromium Development Community**

*This API serves as the backbone for the Wanderlust Knowledge Base, empowering developers worldwide to learn, share, and grow together in the Chromium ecosystem.*

### Controllers
- **ArticlesController** - Knowledge base article management
- **CodeExamplesController** - Interactive code examples and snippets
- **CommunityController** - Community posts and discussions
- **CollectionsController** - Content collection management
- **HealthController** - API health monitoring

### Models
- **Article** - Knowledge base articles with metadata
- **CodeExample** - Interactive code examples with execution support
- **CommunityPost** - Community discussions and posts
- **Collection** - Curated content collections

### Database
- **MySQL** - Primary database with Entity Framework Core
- **Migrations** - Version-controlled schema management
- **JSON Fields** - Support for complex data types (tags, metadata)

## 🛠️ Technology Stack

- **.NET 8** - Latest .NET framework
- **ASP.NET Core Web API** - RESTful API framework
- **Entity Framework Core 8** - Modern ORM
- **MySQL** - Relational database
- **Pomelo.EntityFrameworkCore.MySql** - MySQL provider
- **Swashbuckle.AspNetCore** - Swagger/OpenAPI documentation

## 📋 Prerequisites

- [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
- [MySQL Server 8.0+](https://dev.mysql.com/downloads/mysql/)
- [Git](https://git-scm.com/)

## 🚦 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/WanderLust-Tech/wanderlust-api.git
cd wanderlust-api
```

### 2. Configure Database

Update the connection string in `appsettings.Development.json`:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Port=3306;Database=wanderlust_dev;Uid=your_username;Pwd=your_password;"
  }
}
```

### 3. Install Dependencies

```bash
dotnet restore
```

### 4. Apply Database Migrations

```bash
dotnet ef database update
```

### 5. Run the Application

```bash
dotnet run
```

The API will be available at:
- **HTTP**: http://localhost:5070
- **Swagger UI**: http://localhost:5070/swagger

## 📚 API Endpoints

### Articles
- `GET /api/articles` - Get all articles
- `GET /api/articles/{id}` - Get article by ID
- `GET /api/articles/by-path/{path}` - Get article by path
- `GET /api/articles/category/{category}` - Get articles by category
- `POST /api/articles` - Create new article
- `PUT /api/articles/{id}` - Update article
- `DELETE /api/articles/{id}` - Delete article

### Code Examples
- `GET /api/codeexamples` - Get all code examples
- `GET /api/codeexamples/{id}` - Get code example by ID
- `POST /api/codeexamples` - Create new code example
- `PUT /api/codeexamples/{id}` - Update code example
- `DELETE /api/codeexamples/{id}` - Delete code example

### Community
- `GET /api/community/posts` - Get all community posts
- `GET /api/community/posts/{id}` - Get community post by ID
- `GET /api/community/posts/type/{type}` - Get posts by type
- `POST /api/community/posts` - Create new community post
- `PUT /api/community/posts/{id}` - Update community post
- `DELETE /api/community/posts/{id}` - Delete community post

### Collections
- `GET /api/collections` - Get all collections
- `GET /api/collections/{id}` - Get collection by ID
- `POST /api/collections` - Create new collection
- `PUT /api/collections/{id}` - Update collection
- `DELETE /api/collections/{id}` - Delete collection

### Health
- `GET /api/health` - API health check

## 🗄️ Database Schema

### Articles Table
- `Id` (int, PK) - Primary key
- `Title` (varchar) - Article title
- `Content` (longtext) - Article content
- `Category` (varchar) - Content category
- `Path` (varchar) - URL path
- `Tags` (json) - Article tags
- `Description` (text) - Article description
- `ReadingTimeMinutes` (int) - Estimated reading time
- `IsPublished` (bool) - Publication status
- `CreatedAt` (datetime) - Creation timestamp
- `UpdatedAt` (datetime) - Last update timestamp

### CodeExamples Table
- `Id` (varchar, PK) - Primary key
- `Title` (varchar) - Example title
- `Description` (text) - Example description
- `Code` (longtext) - Source code
- `Language` (enum) - Programming language
- `Category` (enum) - Example category
- `Difficulty` (enum) - Difficulty level
- `Tags` (json) - Example tags
- `Author` (varchar) - Author name
- `DateCreated` (datetime) - Creation date
- `DateUpdated` (datetime) - Last update date

## 🔧 Development

### Adding New Migrations

```bash
dotnet ef migrations add YourMigrationName
dotnet ef database update
```

### Building for Production

```bash
dotnet publish -c Release -o ./publish
```

### Running Tests

```bash
dotnet test
```

## 📝 Configuration

### Environment Variables

Create an `appsettings.Production.json` for production settings:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Your production connection string"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Warning",
      "Microsoft.AspNetCore": "Warning"
    }
  }
}
```

### CORS Configuration

CORS is configured in `Program.cs` to allow requests from the frontend:

```csharp
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowFrontend",
        builder =>
        {
            builder.WithOrigins("http://localhost:5173", "https://localhost:5173")
                   .AllowAnyHeader()
                   .AllowAnyMethod();
        });
});
```

## 🚀 Deployment

### Docker Deployment

Create a `Dockerfile`:

```dockerfile
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY ./publish .
ENTRYPOINT ["dotnet", "WanderlustApi.dll"]
```

### Azure App Service

1. Publish the application
2. Create an Azure App Service
3. Configure connection strings in Application Settings
4. Deploy using Visual Studio or Azure CLI

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Related Projects

- [Wanderlust Knowledge Base (Frontend)](https://github.com/WanderLust-Tech/wanderlust-knowledgebase) - React/TypeScript frontend
- [Wanderlust Platform Documentation](https://github.com/WanderLust-Tech/wanderlust-docs) - Platform documentation

## 📞 Support

For support and questions:
- Create an [Issue](https://github.com/WanderLust-Tech/wanderlust-api/issues)
- Check the [Documentation](https://github.com/WanderLust-Tech/wanderlust-knowledgebase)
- Visit our [Community Discussions](https://github.com/WanderLust-Tech/wanderlust-api/discussions)

---

**Built with ❤️ for the Chromium development community**
