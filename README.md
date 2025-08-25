# Wanderlust API

A comprehensive .NET 8 Web API backend for the Wanderlust Knowledge Base platform, providing robust data management and services for the Chromium development learning platform.

## 🚀 Features

- **RESTful API** - Complete CRUD operations for all entities
- **Entity Framework Core** - Modern ORM with MySQL database support
- **Swagger/OpenAPI** - Auto-generated API documentation
- **CORS Support** - Configured for frontend integration
- **Clean Architecture** - Organized controllers, models, and data layers
- **Database Migrations** - Version-controlled database schema changes

## 🏗️ Architecture

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
