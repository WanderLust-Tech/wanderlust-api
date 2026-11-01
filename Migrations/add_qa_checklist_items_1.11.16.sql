-- Adds QA checklist items for browser v1.11.16: the updater (custom-omaha-client 1.3.0.0)
-- verifies a release signature before downloading anything.
-- See omaha-update-client.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.15.sql. Idempotent: skips entirely if an
-- "As of v1.11.16:" item already exists for the "Background Updater Self-Install" FeatureName.
-- Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Background Updater Self-Install'
      AND ItemText LIKE N'As of v1.11.16:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Installer & Auto-Update', N'Background Updater Self-Install', N'As of v1.11.16: on a test machine, from a command prompt run `omaha_client --client-version` — **Expected:** `{"status":"ok","client_version":"1.3.0.0"}`.', @baseSort + 1),
    (N'Installer & Auto-Update', N'Background Updater Self-Install', N'As of v1.11.16: on a test machine where a newer, **signed** release is published, run `omaha_client --update --version 1.0.0.0 --download-dir %TEMP%\updtest` and read the log lines it prints — **Expected:** a `Manifest signature verified for <version>` line appears **before** `Downloading …`, then `Hash verified OK`, and the update installs. If instead you see `Refusing update …: the manifest is not signed` or `signature check failed`, the published release row has no valid signature (sign it with `ReleaseSigner.cs` and set `BrowserReleases.Signature`).', @baseSort + 2),
    (N'Installer & Auto-Update', N'Background Updater Self-Install', N'As of v1.11.16: after a refused update (unsigned or badly signed release) — **Expected:** nothing was downloaded (no installer file appears in the download folder) and the command reports an error such as `the update is not signed -- refusing to install an unverified update`.', @baseSort + 3);
END
GO
