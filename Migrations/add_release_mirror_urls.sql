-- Migration: optional mirror download URLs for a browser release.
-- MirrorUrls holds a JSON array of https URLs (at most 5), e.g.
--   ["https://cdn.example.com/releases/1.2.0.0/setup.exe"]
-- NULL (every existing row) means "no mirrors": the Omaha response then carries
-- just InstallerUrl in packages[0].urls, exactly as before. The update client
-- tries InstallerUrl first and falls back to the mirrors in order. The signed
-- manifest pins the installer's hash and size, so a mirror cannot serve
-- different bytes. Publish them via POST /api/releases ("mirrorUrls").
--
-- Run this BEFORE deploying the API build that SELECTs the column.

IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'BrowserReleases' AND COLUMN_NAME = 'MirrorUrls'
)
BEGIN
    ALTER TABLE BrowserReleases ADD MirrorUrls NVARCHAR(MAX) NULL;
END
GO
