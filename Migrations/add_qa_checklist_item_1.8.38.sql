-- Adds QA checklist template items for the v1.8.38 fix: the "Add to
-- Wanderlust Sidebar" .lnk shell verb used space-separated switch syntax,
-- so AddApp() silently never ran (see qa-testing-checklist.md's "Sidebar
-- Apps" section and changelog.md's 1.8.38 entry, wanderlust-knowledgebase
-- repo, for the full write-up).
--
-- Run after add_qa_checklist_items_1.8.32_to_1.8.37.sql. Idempotent: skips
-- entirely if these rows are already present (gated on the more distinctive
-- of the two ItemTexts). Appends after the current max SortOrder rather
-- than interleaving/renumbering, same as the prior QA-item migrations.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE Category = N'Browser UI'
      AND FeatureName = N'Sidebar Apps'
      AND ItemText LIKE N'As of v1.8.38:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Sidebar Apps', N'As of v1.8.38: repeat "Click it while the browser is already running" and "Repeat... with the browser fully closed" above — **Expected:** both now actually work end to end (previously the registered shell verb used space-separated switch syntax that Chromium''s command-line parser couldn''t pair with its value, so `AddApp()` silently never ran — clicking while running did nothing, and on cold start the `.lnk` path opened/downloaded as a normal file argument instead of being pinned).', @baseSort + 1),
    (N'Browser UI', N'Sidebar Apps', N'On an install that already had the old broken verb registered, just relaunch the browser (no reinstall, no manual registry edit) — **Expected:** the self-heal check on launch (`EnsureSidebarAppsContextMenuRegistered()`) detects and corrects the stale registry command automatically.', @baseSort + 2);
END
GO
