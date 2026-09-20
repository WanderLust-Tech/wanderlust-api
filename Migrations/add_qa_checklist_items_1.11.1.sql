-- Adds QA checklist items for browser v1.11.1: regression checks for
-- Sidebar, Vertical Tabs, and Split View all going completely unlaid-out
-- on Chromium 144 builds (same features::kTabbedBrowserUseNewLayout root
-- cause as the Bottom Bar regression already covered by v1.11.0's item).
-- See chromium-143-to-144-migration.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.0.sql. Idempotent: each INSERT is
-- gated on an "As of v1.11.1:" item already existing for that FeatureName.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Sidebar'
      AND ItemText LIKE N'As of v1.11.1:%'
)
BEGIN
    DECLARE @baseSort1 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Sidebar', N'As of v1.11.1: open a normal browser window on a fresh build after a Chromium rebase and dock the sidebar on both the left and right edges — **Expected:** the sidebar appears at the configured edge with the content area sized correctly beside it, in both positions (a rebase that flips features::kTabbedBrowserUseNewLayout on by default previously left the sidebar completely unlaid-out/invisible, since its layout code — shared with Vertical Tabs and Split View — only existed in the layout implementation that flag bypasses).', @baseSort1 + 1);
END

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Vertical Tabs'
      AND ItemText LIKE N'As of v1.11.1:%'
)
BEGIN
    DECLARE @baseSort2 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Vertical Tabs', N'As of v1.11.1: enable vertical tabs on a fresh build after a Chromium rebase, on both the left and right edge settings — **Expected:** the vertical tab column appears and sizes the content area correctly beside it in both positions (a rebase that flips features::kTabbedBrowserUseNewLayout on by default previously left it completely unlaid-out, since its layout code — shared with Sidebar and Split View — only existed in the layout implementation that flag bypasses).', @baseSort2 + 1);
END

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Split View'
      AND ItemText LIKE N'As of v1.11.1:%'
)
BEGIN
    DECLARE @baseSort3 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Split View', N'As of v1.11.1: on a fresh build after a Chromium rebase, open split view and drag the divider — **Expected:** the split panel appears and the divider drags/resizes both panes normally (a rebase that flips features::kTabbedBrowserUseNewLayout on by default previously left split view completely unlaid-out, since its layout code — shared with Sidebar and Vertical Tabs — only existed in the layout implementation that flag bypasses).', @baseSort3 + 1);
END
GO
