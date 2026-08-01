-- Migration: create WhatsNewEntries table
-- Stores human-readable "what's new" changelog entries, decoupled from
-- BrowserReleases (which is pure Omaha installer metadata with no
-- title/body field and one row per platform/arch per version -- not
-- suitable for changelog display without duplication).
-- Run once against the production database before deploying the
-- WhatsNewController.

IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'WhatsNewEntries'
)
BEGIN
    CREATE TABLE WhatsNewEntries (
        Id          INT           IDENTITY(1,1) PRIMARY KEY,
        AppId       NVARCHAR(64)  NOT NULL,           -- {A1B2C3D4-...} from config.h
        Version     NVARCHAR(32)  NOT NULL,           -- the release this entry announces
        Title       NVARCHAR(256) NOT NULL,
        Body        NVARCHAR(MAX) NOT NULL,
        IsActive    BIT           NOT NULL DEFAULT 1, -- soft-delete / rollback flag
        PublishedAt DATETIME2     NOT NULL DEFAULT GETUTCDATE()
    );

    CREATE NONCLUSTERED INDEX IX_WhatsNewEntries_Lookup
        ON WhatsNewEntries (AppId, IsActive, PublishedAt DESC);
END
GO

-- Seed: insert your first entry once the table exists.
-- Replace the placeholder values before running.
--
-- INSERT INTO WhatsNewEntries
--     (AppId, Version, Title, Body)
-- VALUES
--     ('{A1B2C3D4-E5F6-7890-ABCD-EF1234567890}', '1.7.31',
--      'Floating undocked sidebar',
--      'Right-click the sidebar and choose Undock to pop it into its own window. Snaps to the screen edge, auto-hides when idle.');
