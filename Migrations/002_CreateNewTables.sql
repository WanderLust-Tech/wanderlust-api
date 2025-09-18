-- Create new tables for enhanced user features
-- Date: 2025-08-28
-- Description: Creates UserBadges, UserPreferences, and DiscussionCategories tables

-- Create UserBadges table
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'UserBadges')
BEGIN
    CREATE TABLE UserBadges (
        Id NVARCHAR(50) PRIMARY KEY DEFAULT NEWID(),
        Name NVARCHAR(100) NOT NULL,
        Description NVARCHAR(500) NULL,
        Icon NVARCHAR(100) NULL,
        Color NVARCHAR(20) NULL,
        EarnedDate DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
        Category NVARCHAR(20) NOT NULL, -- 'Contribution', 'Learning', 'Community', 'Achievement'
        UserId INT NOT NULL,
        
        CONSTRAINT FK_UserBadges_Users FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE
    );
    
    CREATE NONCLUSTERED INDEX IX_UserBadges_UserId ON UserBadges(UserId);
    CREATE NONCLUSTERED INDEX IX_UserBadges_Category ON UserBadges(Category);
    CREATE NONCLUSTERED INDEX IX_UserBadges_EarnedDate ON UserBadges(EarnedDate);
    
    PRINT 'Created UserBadges table';
END

-- Create UserPreferences table
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'UserPreferences')
BEGIN
    CREATE TABLE UserPreferences (
        Id NVARCHAR(50) PRIMARY KEY DEFAULT NEWID(),
        EmailNotifications BIT NOT NULL DEFAULT 1,
        PushNotifications BIT NOT NULL DEFAULT 1,
        ThemePreference NVARCHAR(20) NOT NULL DEFAULT 'system',
        Language NVARCHAR(10) NOT NULL DEFAULT 'en',
        Timezone NVARCHAR(50) NOT NULL DEFAULT 'UTC',
        DiscussionSort NVARCHAR(20) NOT NULL DEFAULT 'newest',
        AutoSubscribe BIT NOT NULL DEFAULT 0,
        UserId INT NOT NULL UNIQUE,
        
        CONSTRAINT FK_UserPreferences_Users FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE
    );
    
    CREATE UNIQUE NONCLUSTERED INDEX IX_UserPreferences_UserId ON UserPreferences(UserId);
    
    PRINT 'Created UserPreferences table';
END

-- Create DiscussionCategories table
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DiscussionCategories')
BEGIN
    CREATE TABLE DiscussionCategories (
        Id NVARCHAR(50) PRIMARY KEY DEFAULT NEWID(),
        Name NVARCHAR(100) NOT NULL,
        Description NVARCHAR(500) NULL,
        Color NVARCHAR(20) NULL,
        Icon NVARCHAR(50) NULL,
        ParentId NVARCHAR(50) NULL,
        Moderators NVARCHAR(MAX) NULL, -- JSON array of moderator IDs
        IsPrivate BIT NOT NULL DEFAULT 0,
        RequireApproval BIT NOT NULL DEFAULT 0,
        CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
        
        CONSTRAINT FK_DiscussionCategories_Parent FOREIGN KEY (ParentId) REFERENCES DiscussionCategories(Id)
    );
    
    CREATE NONCLUSTERED INDEX IX_DiscussionCategories_ParentId ON DiscussionCategories(ParentId) WHERE ParentId IS NOT NULL;
    CREATE NONCLUSTERED INDEX IX_DiscussionCategories_Name ON DiscussionCategories(Name);
    CREATE NONCLUSTERED INDEX IX_DiscussionCategories_IsPrivate ON DiscussionCategories(IsPrivate) WHERE IsPrivate = 1;
    
    PRINT 'Created DiscussionCategories table';
END

-- Insert some default discussion categories
IF NOT EXISTS (SELECT * FROM DiscussionCategories WHERE Name = 'General Discussion')
BEGIN
    INSERT INTO DiscussionCategories (Name, Description, Color, Icon) VALUES
    ('General Discussion', 'General topics and discussions', '#3B82F6', 'chat'),
    ('Getting Started', 'Help for newcomers and beginners', '#10B981', 'help'),
    ('Development', 'Development-related discussions', '#8B5CF6', 'code'),
    ('Bug Reports', 'Report bugs and issues', '#EF4444', 'bug'),
    ('Feature Requests', 'Request new features', '#F59E0B', 'lightbulb'),
    ('Announcements', 'Official announcements', '#6366F1', 'megaphone');
    
    PRINT 'Inserted default discussion categories';
END

-- Insert default user preferences for existing users
INSERT INTO UserPreferences (UserId)
SELECT Id FROM Users u 
WHERE NOT EXISTS (
    SELECT 1 FROM UserPreferences up WHERE up.UserId = u.Id
);

CREATE TABLE Comments (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Content NVARCHAR(MAX) NOT NULL,
    AuthorId INT NOT NULL,
    ParentId INT NULL, -- For nested replies
    ArticleId INT NULL, -- For article comments
    DiscussionId INT NULL, -- For discussion comments
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 NULL,
    IsEdited BIT DEFAULT 0,
    LikeCount INT DEFAULT 0,
    DislikeCount INT DEFAULT 0,
    IsApproved BIT DEFAULT 1,
    IsFlagged BIT DEFAULT 0,
    Mentions NVARCHAR(MAX) NULL, -- JSON array
    FOREIGN KEY (AuthorId) REFERENCES Users(Id),
    FOREIGN KEY (ParentId) REFERENCES Comments(Id),
    FOREIGN KEY (ArticleId) REFERENCES Articles(Id),
    FOREIGN KEY (DiscussionId) REFERENCES CommunityPosts(Id)
);

CREATE TABLE Reactions (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Type NVARCHAR(20) NOT NULL, -- 'like', 'love', 'laugh', 'wow', 'sad', 'angry'
    Emoji NVARCHAR(10) NOT NULL,
    UserId INT NOT NULL,
    CommentId INT NULL,
    PostId INT NULL,
    ArticleId INT NULL,
    Timestamp DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    FOREIGN KEY (UserId) REFERENCES Users(Id),
    FOREIGN KEY (CommentId) REFERENCES Comments(Id),
    FOREIGN KEY (PostId) REFERENCES CommunityPosts(Id),
    FOREIGN KEY (ArticleId) REFERENCES Articles(Id)
);

CREATE TABLE Notifications (
    Id NVARCHAR(50) PRIMARY KEY DEFAULT NEWID(),
    UserId INT NOT NULL,
    Type NVARCHAR(50) NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    Message NVARCHAR(500) NOT NULL,
    Data NVARCHAR(MAX) NULL, -- JSON
    IsRead BIT DEFAULT 0,
    CreatedAt DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ExpiresAt DATETIME2 NULL,
    ActionUrl NVARCHAR(500) NULL,
    Priority NVARCHAR(20) DEFAULT 'medium',
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);

PRINT 'Migration completed: Created new tables for enhanced user features';
