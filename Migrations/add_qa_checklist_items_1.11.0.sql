-- Adds QA checklist items for browser v1.11.0: a new "Bottom Bar" section
-- covering the persistent bottom-docked container (hosts the download shelf,
-- Privacy Shield button, and Mail toolbar button), plus a regression check
-- for a Chromium 144 rebase bug where the bar was left unpositioned entirely.
-- See chromium-143-to-144-migration.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.9.23.sql. Idempotent: skips entirely
-- if the "Bottom Bar" FeatureName already has rows. Appends after the
-- current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Bottom Bar'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Bottom Bar', N'Open a normal (tabbed) browser window and trigger any bottombar-hosted feature (start a download, or open the Privacy Shield bubble) — **Expected:** the bar renders flush against the bottom edge of the window, full width, with no gap or overlap against the page content above it.', @baseSort + 1),
    (N'Browser UI', N'Bottom Bar', N'Resize the window (both wider/narrower and shorter/taller) — **Expected:** the bar stays pinned to the bottom edge and spans the full width at every size.', @baseSort + 2),
    (N'Browser UI', N'Bottom Bar', N'As of v1.11.0: open a normal browser window on a fresh build after a Chromium rebase — **Expected:** the bar is positioned at the bottom of the window, not floating elsewhere or overlapping other UI (a rebase that flips features::kTabbedBrowserUseNewLayout on by default previously left the bar completely unpositioned, since its layout code only existed in the layout implementation that flag bypasses).', @baseSort + 3);
END
GO
