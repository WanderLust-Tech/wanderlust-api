-- Migration: create FeedbackEntries table
-- Backs the custom-browser fork's chrome://feedback page. Anonymous
-- submission (no wanderlust-api sign-in required); admin-only read via
-- FeedbackController's GET endpoint. Run once against the production
-- database before deploying FeedbackController.

IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'FeedbackEntries'
)
BEGIN
    CREATE TABLE FeedbackEntries (
        Id           INT           IDENTITY(1,1) PRIMARY KEY,
        Description  NVARCHAR(MAX) NOT NULL,
        Url          NVARCHAR(512) NOT NULL DEFAULT '',
        SystemInfo   NVARCHAR(512) NOT NULL DEFAULT '',
        ContactEmail NVARCHAR(256) NULL,          -- optional, user-typed
        IsResolved   BIT           NOT NULL DEFAULT 0,
        CreatedAt    DATETIME2     NOT NULL DEFAULT GETUTCDATE()
    );

    CREATE NONCLUSTERED INDEX IX_FeedbackEntries_Triage
        ON FeedbackEntries (IsResolved, CreatedAt DESC);
END
GO
