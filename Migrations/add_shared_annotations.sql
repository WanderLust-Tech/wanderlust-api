-- Migration: create SharedAnnotations table
-- Backs the custom-browser fork's Page Notes "shared annotations" feature
-- (custom/browser/page_notes/page_notes_backend_client.h) -- public,
-- per-URL notes attributed to a wanderlust-api user. UserId/UserName
-- come from a wanderlust-api JWT, itself obtained either via normal
-- login or the external-login (Google/Microsoft) exchange in
-- AuthController -- this table has no dependency on which path was used.
-- Run once against the production database before deploying
-- SharedAnnotationsController.

IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'SharedAnnotations'
)
BEGIN
    CREATE TABLE SharedAnnotations (
        Id        INT           IDENTITY(1,1) PRIMARY KEY,
        Url       NVARCHAR(512) NOT NULL,           -- normalized host+path
        Text      NVARCHAR(MAX) NOT NULL,
        UserId    INT           NOT NULL,
        UserName  NVARCHAR(100) NOT NULL,           -- denormalized display name
        IsActive  BIT           NOT NULL DEFAULT 1, -- soft-delete flag
        CreatedAt DATETIME2     NOT NULL DEFAULT GETUTCDATE()
    );

    CREATE NONCLUSTERED INDEX IX_SharedAnnotations_Lookup
        ON SharedAnnotations (Url, IsActive, CreatedAt DESC);
END
GO
