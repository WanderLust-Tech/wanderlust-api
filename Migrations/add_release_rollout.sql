-- Migration: add staged-rollout / A-B experiment support to BrowserReleases
-- RolloutWeight defaults to 100, so every existing row keeps today's
-- "always wins" behavior unless an admin explicitly narrows it. Multiple
-- active rows can target the same (AppId, Platform, Arch) simultaneously --
-- see OmahaController/IReleaseRolloutSelector for how one is chosen per
-- client.

IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'BrowserReleases' AND COLUMN_NAME = 'RolloutWeight'
)
BEGIN
    ALTER TABLE BrowserReleases ADD RolloutWeight INT NOT NULL DEFAULT 100;
END
GO

IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'BrowserReleases' AND COLUMN_NAME = 'ExperimentName'
)
BEGIN
    ALTER TABLE BrowserReleases ADD ExperimentName NVARCHAR(128) NULL;
END
GO

-- Example: stage a new version out to 20% of installs, leaving the
-- previous release (already at its default RolloutWeight=100) to cover
-- the remaining 80% automatically -- no change needed to the existing row.
--
-- INSERT INTO BrowserReleases
--     (AppId, Version, Platform, Arch, InstallerName, InstallerUrl, HashSha256, SizeBytes, RolloutWeight, ExperimentName)
-- VALUES
--     ('{A1B2C3D4-E5F6-7890-ABCD-EF1234567890}', '1.1.0.0', 'win', 'x64',
--      'wanderlust-setup-1.1.0.0-win-x64.exe',
--      'https://cdn.wanderlustbrowser.com/releases/1.1.0.0/wanderlust-setup-1.1.0.0-win-x64.exe',
--      '<sha256_hex_here>', <size_in_bytes>, 20, 'stage-1.1.0.0');
