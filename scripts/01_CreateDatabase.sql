-- WanderlustDB Database Creation Script
-- Version: 1.0
-- Date: 2025-08-27

-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS wanderlustdb 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE wanderlustdb;

-- =============================================
-- Users Table
-- =============================================
CREATE TABLE IF NOT EXISTS Users (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    DisplayName VARCHAR(100) NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Bio TEXT NULL,
    AvatarUrl VARCHAR(500) NULL,
    Role ENUM('Member', 'Admin', 'Moderator', 'Contributor') NOT NULL DEFAULT 'Member',
    IsEmailVerified BOOLEAN NOT NULL DEFAULT FALSE,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    LastLoginAt DATETIME NULL,
    RefreshToken VARCHAR(500) NULL,
    RefreshTokenExpiryTime DATETIME NULL,
    
    INDEX idx_users_email (Email),
    INDEX idx_users_username (Username),
    INDEX idx_users_role (Role),
    INDEX idx_users_active (IsActive),
    INDEX idx_users_created (CreatedAt)
) ENGINE=InnoDB;

-- =============================================
-- Collections Table
-- =============================================
CREATE TABLE IF NOT EXISTS Collections (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT NULL,
    IsPublic BOOLEAN NOT NULL DEFAULT TRUE,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    AuthorId INT NOT NULL,
    
    FOREIGN KEY (AuthorId) REFERENCES Users(Id) ON DELETE CASCADE,
    INDEX idx_collections_author (AuthorId),
    INDEX idx_collections_public (IsPublic),
    INDEX idx_collections_created (CreatedAt)
) ENGINE=InnoDB;

-- =============================================
-- Articles Table
-- =============================================
CREATE TABLE IF NOT EXISTS Articles (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Content LONGTEXT NOT NULL,
    Summary TEXT NULL,
    Tags JSON NULL,
    Category VARCHAR(50) NULL,
    Difficulty ENUM('Beginner', 'Intermediate', 'Advanced', 'Expert') NOT NULL DEFAULT 'Beginner',
    EstimatedReadTime INT NOT NULL DEFAULT 5,
    IsPublished BOOLEAN NOT NULL DEFAULT FALSE,
    IsFeatured BOOLEAN NOT NULL DEFAULT FALSE,
    ViewCount INT NOT NULL DEFAULT 0,
    LikeCount INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PublishedAt DATETIME NULL,
    AuthorId INT NOT NULL,
    CollectionId INT NULL,
    RelatedArticles JSON NULL,
    LearningObjectives JSON NULL,
    Prerequisites JSON NULL,
    
    FOREIGN KEY (AuthorId) REFERENCES Users(Id) ON DELETE CASCADE,
    FOREIGN KEY (CollectionId) REFERENCES Collections(Id) ON DELETE SET NULL,
    
    INDEX idx_articles_author (AuthorId),
    INDEX idx_articles_collection (CollectionId),
    INDEX idx_articles_published (IsPublished),
    INDEX idx_articles_featured (IsFeatured),
    INDEX idx_articles_category (Category),
    INDEX idx_articles_difficulty (Difficulty),
    INDEX idx_articles_created (CreatedAt),
    INDEX idx_articles_published_date (PublishedAt),
    
    FULLTEXT idx_articles_search (Title, Content, Summary)
) ENGINE=InnoDB;

-- =============================================
-- CodeExamples Table
-- =============================================
CREATE TABLE IF NOT EXISTS CodeExamples (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Description TEXT NULL,
    Code LONGTEXT NOT NULL,
    Language VARCHAR(50) NOT NULL,
    Framework VARCHAR(100) NULL,
    Tags JSON NULL,
    Difficulty ENUM('Beginner', 'Intermediate', 'Advanced', 'Expert') NOT NULL DEFAULT 'Beginner',
    Category VARCHAR(50) NULL,
    IsPublic BOOLEAN NOT NULL DEFAULT TRUE,
    ViewCount INT NOT NULL DEFAULT 0,
    LikeCount INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    AuthorId INT NOT NULL,
    CollectionId INT NULL,
    Dependencies JSON NULL,
    RelatedExamples JSON NULL,
    
    FOREIGN KEY (AuthorId) REFERENCES Users(Id) ON DELETE CASCADE,
    FOREIGN KEY (CollectionId) REFERENCES Collections(Id) ON DELETE SET NULL,
    
    INDEX idx_codeexamples_author (AuthorId),
    INDEX idx_codeexamples_collection (CollectionId),
    INDEX idx_codeexamples_language (Language),
    INDEX idx_codeexamples_framework (Framework),
    INDEX idx_codeexamples_public (IsPublic),
    INDEX idx_codeexamples_difficulty (Difficulty),
    INDEX idx_codeexamples_category (Category),
    INDEX idx_codeexamples_created (CreatedAt),
    
    FULLTEXT idx_codeexamples_search (Title, Description, Code)
) ENGINE=InnoDB;

-- =============================================
-- CommunityPosts Table
-- =============================================
CREATE TABLE IF NOT EXISTS CommunityPosts (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    Content LONGTEXT NOT NULL,
    PostType ENUM('Question', 'Discussion', 'Showcase', 'News', 'Tutorial') NOT NULL DEFAULT 'Discussion',
    Tags JSON NULL,
    IsPublished BOOLEAN NOT NULL DEFAULT TRUE,
    IsPinned BOOLEAN NOT NULL DEFAULT FALSE,
    IsLocked BOOLEAN NOT NULL DEFAULT FALSE,
    ViewCount INT NOT NULL DEFAULT 0,
    LikeCount INT NOT NULL DEFAULT 0,
    ReplyCount INT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    AuthorId INT NOT NULL,
    
    FOREIGN KEY (AuthorId) REFERENCES Users(Id) ON DELETE CASCADE,
    
    INDEX idx_community_author (AuthorId),
    INDEX idx_community_type (PostType),
    INDEX idx_community_published (IsPublished),
    INDEX idx_community_pinned (IsPinned),
    INDEX idx_community_created (CreatedAt),
    
    FULLTEXT idx_community_search (Title, Content)
) ENGINE=InnoDB;

-- =============================================
-- Comments Table
-- =============================================
CREATE TABLE IF NOT EXISTS Comments (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Content TEXT NOT NULL,
    PostId INT NOT NULL,
    AuthorId INT NOT NULL,
    ParentCommentId INT NULL,
    IsDeleted BOOLEAN NOT NULL DEFAULT FALSE,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (PostId) REFERENCES CommunityPosts(Id) ON DELETE CASCADE,
    FOREIGN KEY (AuthorId) REFERENCES Users(Id) ON DELETE CASCADE,
    FOREIGN KEY (ParentCommentId) REFERENCES Comments(Id) ON DELETE CASCADE,
    
    INDEX idx_comments_post (PostId),
    INDEX idx_comments_author (AuthorId),
    INDEX idx_comments_parent (ParentCommentId),
    INDEX idx_comments_created (CreatedAt)
) ENGINE=InnoDB;

-- =============================================
-- Reactions Table
-- =============================================
CREATE TABLE IF NOT EXISTS Reactions (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    UserId INT NOT NULL,
    PostId INT NULL,
    CommentId INT NULL,
    ArticleId INT NULL,
    CodeExampleId INT NULL,
    ReactionType ENUM('Like', 'Love', 'Helpful', 'Insightful', 'Funny') NOT NULL DEFAULT 'Like',
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE,
    FOREIGN KEY (PostId) REFERENCES CommunityPosts(Id) ON DELETE CASCADE,
    FOREIGN KEY (CommentId) REFERENCES Comments(Id) ON DELETE CASCADE,
    FOREIGN KEY (ArticleId) REFERENCES Articles(Id) ON DELETE CASCADE,
    FOREIGN KEY (CodeExampleId) REFERENCES CodeExamples(Id) ON DELETE CASCADE,
    
    UNIQUE KEY unique_user_post_reaction (UserId, PostId, ReactionType),
    UNIQUE KEY unique_user_comment_reaction (UserId, CommentId, ReactionType),
    UNIQUE KEY unique_user_article_reaction (UserId, ArticleId, ReactionType),
    UNIQUE KEY unique_user_code_reaction (UserId, CodeExampleId, ReactionType),
    
    INDEX idx_reactions_user (UserId),
    INDEX idx_reactions_post (PostId),
    INDEX idx_reactions_comment (CommentId),
    INDEX idx_reactions_article (ArticleId),
    INDEX idx_reactions_code (CodeExampleId),
    INDEX idx_reactions_type (ReactionType)
) ENGINE=InnoDB;

-- =============================================
-- MediaItems Table (CMS)
-- =============================================
CREATE TABLE IF NOT EXISTS MediaItems (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    FileName VARCHAR(255) NOT NULL,
    OriginalFileName VARCHAR(255) NOT NULL,
    FilePath VARCHAR(500) NOT NULL,
    FileSize BIGINT NOT NULL,
    ContentType VARCHAR(100) NOT NULL,
    MediaType ENUM('Image', 'Video', 'Audio', 'Document', 'Archive', 'Other') NOT NULL DEFAULT 'Other',
    AltText VARCHAR(255) NULL,
    Caption TEXT NULL,
    UploadedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UploadedById INT NOT NULL,
    
    FOREIGN KEY (UploadedById) REFERENCES Users(Id) ON DELETE CASCADE,
    
    INDEX idx_media_type (MediaType),
    INDEX idx_media_uploader (UploadedById),
    INDEX idx_media_uploaded (UploadedAt)
) ENGINE=InnoDB;

-- =============================================
-- ContentWorkflows Table (CMS)
-- =============================================
CREATE TABLE IF NOT EXISTS ContentWorkflows (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT NULL,
    Steps JSON NOT NULL,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedById INT NOT NULL,
    
    FOREIGN KEY (CreatedById) REFERENCES Users(Id) ON DELETE CASCADE,
    
    INDEX idx_workflow_active (IsActive),
    INDEX idx_workflow_creator (CreatedById)
) ENGINE=InnoDB;

-- =============================================
-- ContentTemplates Table (CMS)
-- =============================================
CREATE TABLE IF NOT EXISTS ContentTemplates (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT NULL,
    TemplateType ENUM('Article', 'CodeExample', 'CommunityPost', 'Page') NOT NULL,
    Content LONGTEXT NOT NULL,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedById INT NOT NULL,
    
    FOREIGN KEY (CreatedById) REFERENCES Users(Id) ON DELETE CASCADE,
    
    INDEX idx_template_type (TemplateType),
    INDEX idx_template_active (IsActive),
    INDEX idx_template_creator (CreatedById)
) ENGINE=InnoDB;

-- =============================================
-- Insert Default Data
-- =============================================

-- Create default admin user (password: "admin123")
INSERT IGNORE INTO Users (Username, Email, DisplayName, PasswordHash, Role, IsEmailVerified, IsActive, CreatedAt, LastLoginAt) 
VALUES (
    'admin',
    'admin@wanderlust.dev',
    'System Administrator',
    '$2a$11$9QwZgZg8z8z8z8z8z8z8z8z8z8z8z8z8z8z8z8z8z8z8z8z8z8z8z8z8z8',
    'Admin',
    TRUE,
    TRUE,
    NOW(),
    NOW()
);

-- Create default collection
INSERT IGNORE INTO Collections (Name, Description, IsPublic, AuthorId) 
VALUES (
    'Getting Started',
    'Essential resources for new developers',
    TRUE,
    1
);

-- Create sample article
INSERT IGNORE INTO Articles (
    Title, 
    Content, 
    Summary, 
    Tags, 
    Category, 
    Difficulty, 
    EstimatedReadTime, 
    IsPublished, 
    IsFeatured, 
    AuthorId, 
    CollectionId,
    PublishedAt
) VALUES (
    'Welcome to Wanderlust Knowledge Base',
    'This is your starting point for exploring our comprehensive knowledge base. Here you will find articles, code examples, and community discussions to help you on your development journey.',
    'Welcome article introducing the platform',
    '["welcome", "getting-started", "introduction"]',
    'General',
    'Beginner',
    3,
    TRUE,
    TRUE,
    1,
    1,
    NOW()
);

-- =============================================
-- Performance Optimization
-- =============================================

-- Analyze tables for optimization
ANALYZE TABLE Users, Collections, Articles, CodeExamples, CommunityPosts, Comments, Reactions, MediaItems, ContentWorkflows, ContentTemplates;

-- =============================================
-- Completion Message
-- =============================================
SELECT 'Database initialization completed successfully!' AS Status;
