-- WanderlustDB SQL Server Database Creation Script
-- Version: 1.0
-- Date: 2025-08-27
-- Database: SQL Server 2019+

-- Note: Run this script in the context of your target database
-- The database should already exist

-- IMPORTANT: Foreign Key Constraints use ON DELETE NO ACTION
-- to avoid multiple cascade paths that SQL Server doesn't allow.
-- Manual cleanup will be required when deleting Users or Collections.

-- =============================================
-- Users Table
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Users' AND xtype='U')
CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    DisplayName NVARCHAR(100) NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    Bio NTEXT NULL,
    AvatarUrl NVARCHAR(500) NULL,
    Role NVARCHAR(20) NOT NULL DEFAULT 'Member' CHECK (Role IN ('Member', 'Admin', 'Moderator', 'Contributor')),
    IsEmailVerified BIT NOT NULL DEFAULT 0,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    LastLoginAt DATETIME2 NULL,
    RefreshToken NVARCHAR(500) NULL,
    RefreshTokenExpiryTime DATETIME2 NULL
);

-- Create indexes for Users table
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_Email')
CREATE INDEX IX_Users_Email ON Users(Email);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_Username')
CREATE INDEX IX_Users_Username ON Users(Username);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_Role')
CREATE INDEX IX_Users_Role ON Users(Role);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_Active')
CREATE INDEX IX_Users_Active ON Users(IsActive);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Users_Created')
CREATE INDEX IX_Users_Created ON Users(CreatedAt);

-- =============================================
-- Collections Table
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Collections' AND xtype='U')
CREATE TABLE Collections (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NTEXT NULL,
    IsPublic BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    AuthorId INT NOT NULL,
    
    CONSTRAINT FK_Collections_AuthorId FOREIGN KEY (AuthorId) REFERENCES Users(Id) ON DELETE NO ACTION
);

-- Create indexes for Collections table
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Collections_Author')
CREATE INDEX IX_Collections_Author ON Collections(AuthorId);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Collections_Public')
CREATE INDEX IX_Collections_Public ON Collections(IsPublic);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Collections_Created')
CREATE INDEX IX_Collections_Created ON Collections(CreatedAt);

-- =============================================
-- Articles Table
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Articles' AND xtype='U')
CREATE TABLE Articles (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Content NTEXT NOT NULL,
    Summary NTEXT NULL,
    Tags NVARCHAR(MAX) NULL, -- JSON string
    Category NVARCHAR(50) NULL,
    Difficulty NVARCHAR(20) NOT NULL DEFAULT 'Beginner' CHECK (Difficulty IN ('Beginner', 'Intermediate', 'Advanced', 'Expert')),
    EstimatedReadTime INT NOT NULL DEFAULT 5,
    IsPublished BIT NOT NULL DEFAULT 0,
    IsFeatured BIT NOT NULL DEFAULT 0,
    ViewCount INT NOT NULL DEFAULT 0,
    LikeCount INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    PublishedAt DATETIME2 NULL,
    AuthorId INT NOT NULL,
    CollectionId INT NULL,
    RelatedArticles NVARCHAR(MAX) NULL, -- JSON string
    LearningObjectives NVARCHAR(MAX) NULL, -- JSON string
    Prerequisites NVARCHAR(MAX) NULL, -- JSON string
    
    CONSTRAINT FK_Articles_AuthorId FOREIGN KEY (AuthorId) REFERENCES Users(Id) ON DELETE NO ACTION,
    CONSTRAINT FK_Articles_CollectionId FOREIGN KEY (CollectionId) REFERENCES Collections(Id) ON DELETE NO ACTION
);

-- Create indexes for Articles table
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Articles_Author')
CREATE INDEX IX_Articles_Author ON Articles(AuthorId);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Articles_Collection')
CREATE INDEX IX_Articles_Collection ON Articles(CollectionId);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Articles_Published')
CREATE INDEX IX_Articles_Published ON Articles(IsPublished);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Articles_Featured')
CREATE INDEX IX_Articles_Featured ON Articles(IsFeatured);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Articles_Category')
CREATE INDEX IX_Articles_Category ON Articles(Category);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Articles_Difficulty')
CREATE INDEX IX_Articles_Difficulty ON Articles(Difficulty);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Articles_Created')
CREATE INDEX IX_Articles_Created ON Articles(CreatedAt);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Articles_PublishedDate')
CREATE INDEX IX_Articles_PublishedDate ON Articles(PublishedAt);

-- =============================================
-- CodeExamples Table
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='CodeExamples' AND xtype='U')
CREATE TABLE CodeExamples (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Description NTEXT NULL,
    Code NTEXT NOT NULL,
    Language NVARCHAR(50) NOT NULL,
    Framework NVARCHAR(100) NULL,
    Tags NVARCHAR(MAX) NULL, -- JSON string
    Difficulty NVARCHAR(20) NOT NULL DEFAULT 'Beginner' CHECK (Difficulty IN ('Beginner', 'Intermediate', 'Advanced', 'Expert')),
    Category NVARCHAR(50) NULL,
    IsPublic BIT NOT NULL DEFAULT 1,
    ViewCount INT NOT NULL DEFAULT 0,
    LikeCount INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    AuthorId INT NOT NULL,
    CollectionId INT NULL,
    Dependencies NVARCHAR(MAX) NULL, -- JSON string
    RelatedExamples NVARCHAR(MAX) NULL, -- JSON string
    
    CONSTRAINT FK_CodeExamples_AuthorId FOREIGN KEY (AuthorId) REFERENCES Users(Id) ON DELETE NO ACTION,
    CONSTRAINT FK_CodeExamples_CollectionId FOREIGN KEY (CollectionId) REFERENCES Collections(Id) ON DELETE NO ACTION
);

-- Create indexes for CodeExamples table
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CodeExamples_Author')
CREATE INDEX IX_CodeExamples_Author ON CodeExamples(AuthorId);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CodeExamples_Collection')
CREATE INDEX IX_CodeExamples_Collection ON CodeExamples(CollectionId);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CodeExamples_Language')
CREATE INDEX IX_CodeExamples_Language ON CodeExamples(Language);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CodeExamples_Framework')
CREATE INDEX IX_CodeExamples_Framework ON CodeExamples(Framework);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CodeExamples_Public')
CREATE INDEX IX_CodeExamples_Public ON CodeExamples(IsPublic);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CodeExamples_Difficulty')
CREATE INDEX IX_CodeExamples_Difficulty ON CodeExamples(Difficulty);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CodeExamples_Category')
CREATE INDEX IX_CodeExamples_Category ON CodeExamples(Category);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CodeExamples_Created')
CREATE INDEX IX_CodeExamples_Created ON CodeExamples(CreatedAt);

-- =============================================
-- CommunityPosts Table
-- =============================================
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='CommunityPosts' AND xtype='U')
CREATE TABLE CommunityPosts (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Content NTEXT NOT NULL,
    PostType NVARCHAR(20) NOT NULL DEFAULT 'Discussion' CHECK (PostType IN ('Question', 'Discussion', 'Showcase', 'News', 'Tutorial')),
    Tags NVARCHAR(MAX) NULL, -- JSON string
    IsPublished BIT NOT NULL DEFAULT 1,
    IsPinned BIT NOT NULL DEFAULT 0,
    IsLocked BIT NOT NULL DEFAULT 0,
    ViewCount INT NOT NULL DEFAULT 0,
    LikeCount INT NOT NULL DEFAULT 0,
    ReplyCount INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    AuthorId INT NOT NULL,
    
    CONSTRAINT FK_CommunityPosts_AuthorId FOREIGN KEY (AuthorId) REFERENCES Users(Id) ON DELETE NO ACTION
);

-- Create indexes for CommunityPosts table
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CommunityPosts_Author')
CREATE INDEX IX_CommunityPosts_Author ON CommunityPosts(AuthorId);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CommunityPosts_Type')
CREATE INDEX IX_CommunityPosts_Type ON CommunityPosts(PostType);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CommunityPosts_Published')
CREATE INDEX IX_CommunityPosts_Published ON CommunityPosts(IsPublished);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CommunityPosts_Pinned')
CREATE INDEX IX_CommunityPosts_Pinned ON CommunityPosts(IsPinned);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_CommunityPosts_Created')
CREATE INDEX IX_CommunityPosts_Created ON CommunityPosts(CreatedAt);

-- =============================================
-- Sample Data
-- =============================================

-- Insert sample admin user (password: admin123)
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'admin@wanderlust.dev')
INSERT INTO Users (Username, Email, DisplayName, PasswordHash, Role, IsEmailVerified, IsActive, Bio)
VALUES (
    'admin',
    'admin@wanderlust.dev',
    'System Administrator',
    '$2a$11$8Mg6lK7PZXhOGdWfHf9JeOKZ7mFQEG9pGqr7A2LhO2kZeO2.9q8Wa', -- admin123
    'Admin',
    1,
    1,
    'System administrator account for Wanderlust API'
);

-- Insert sample regular user (password: user123)
IF NOT EXISTS (SELECT 1 FROM Users WHERE Email = 'user@wanderlust.dev')
INSERT INTO Users (Username, Email, DisplayName, PasswordHash, Role, IsEmailVerified, IsActive, Bio)
VALUES (
    'developer',
    'user@wanderlust.dev',
    'Sample Developer',
    '$2a$11$LtKtQ9vL4bJ7XzWF8Q2YUO7K3mP9nT5xB1sN6eRzV2qH4yY8jT7Ca', -- user123
    'Member',
    1,
    1,
    'Sample developer account for testing'
);

-- Insert sample code examples
DECLARE @UserId INT = (SELECT Id FROM Users WHERE Email = 'admin@wanderlust.dev');

IF NOT EXISTS (SELECT 1 FROM CodeExamples WHERE Title = 'Hello World in C#')
INSERT INTO CodeExamples (Title, Description, Code, Language, Framework, Difficulty, Category, AuthorId, IsPublic)
VALUES (
    'Hello World in C#',
    'A simple Hello World example in C# demonstrating basic console output.',
    'using System;

namespace HelloWorld
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");
            Console.ReadLine();
        }
    }
}',
    'C#',
    '.NET',
    'Beginner',
    'Getting Started',
    @UserId,
    1
);

IF NOT EXISTS (SELECT 1 FROM CodeExamples WHERE Title = 'REST API with ASP.NET Core')
INSERT INTO CodeExamples (Title, Description, Code, Language, Framework, Difficulty, Category, AuthorId, IsPublic)
VALUES (
    'REST API with ASP.NET Core',
    'Basic REST API controller example using ASP.NET Core.',
    'using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api/[controller]")]
public class ProductsController : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Product>>> GetProducts()
    {
        var products = new List<Product>
        {
            new Product { Id = 1, Name = "Laptop", Price = 999.99m },
            new Product { Id = 2, Name = "Mouse", Price = 29.99m }
        };
        
        return Ok(products);
    }
    
    [HttpGet("{id}")]
    public async Task<ActionResult<Product>> GetProduct(int id)
    {
        // Implementation here
        return NotFound();
    }
}

public class Product
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public decimal Price { get; set; }
}',
    'C#',
    'ASP.NET Core',
    'Intermediate',
    'Web API',
    @UserId,
    1
);

PRINT 'Wanderlust SQL Server database schema created successfully!';
PRINT 'Tables created: Users, Collections, Articles, CodeExamples, CommunityPosts';
PRINT 'Sample data inserted: 2 users, 2 code examples';
PRINT 'Ready for use with Dapper and ASP.NET Core!';
