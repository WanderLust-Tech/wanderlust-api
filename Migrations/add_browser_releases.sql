-- Migration: create BrowserReleases table
-- Stores published browser installer metadata for the Omaha 4 update endpoint.
-- Run once against the production database before deploying the Omaha controller.

IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'BrowserReleases'
)
BEGIN
    CREATE TABLE BrowserReleases (
        Id            INT           IDENTITY(1,1) PRIMARY KEY,
        AppId         NVARCHAR(64)  NOT NULL,           -- {A1B2C3D4-...} from config.h
        Version       NVARCHAR(32)  NOT NULL,           -- four-part, e.g. 1.0.1.0
        Platform      NVARCHAR(16)  NOT NULL,           -- win | linux | mac
        Arch          NVARCHAR(8)   NOT NULL,           -- x64 | x86 | arm64
        InstallerName NVARCHAR(256) NOT NULL,           -- filename served to the client
        InstallerUrl  NVARCHAR(1024) NOT NULL,          -- direct HTTPS download URL
        HashSha256    NVARCHAR(128) NOT NULL,           -- hex-encoded SHA-256 of the installer
        SizeBytes     BIGINT        NOT NULL,
        IsActive      BIT           NOT NULL DEFAULT 1, -- soft-delete / rollback flag
        CreatedAt     DATETIME2     NOT NULL DEFAULT GETUTCDATE()
    );

    CREATE NONCLUSTERED INDEX IX_BrowserReleases_Lookup
        ON BrowserReleases (AppId, Platform, Arch, IsActive, CreatedAt DESC);
END
GO

-- Seed: insert your first release once the table exists.
-- Replace the placeholder values before running.
--
-- INSERT INTO BrowserReleases
--     (AppId, Version, Platform, Arch, InstallerName, InstallerUrl, HashSha256, SizeBytes)
-- VALUES
--     ('{A1B2C3D4-E5F6-7890-ABCD-EF1234567890}', '1.0.0.0', 'win', 'x64',
--      'wanderlust-setup-1.0.0.0-win-x64.exe',
--      'https://cdn.wanderlustbrowser.com/releases/1.0.0.0/wanderlust-setup-1.0.0.0-win-x64.exe',
--      '<sha256_hex_here>',
--      <size_in_bytes>);
