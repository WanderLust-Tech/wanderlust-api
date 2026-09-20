-- Adds a QA checklist item for browser v1.11.2: a regression check for a
-- black gap in the top-right corner of the window whenever Vertical Tabs
-- is on -- a follow-up to v1.11.1's Sidebar/Vertical-Tabs/Split-View
-- layout port, same Chromium 144 rebase.
-- See chromium-143-to-144-migration.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.1.sql. Idempotent: skips entirely
-- if an "As of v1.11.2:" item already exists for the "Vertical Tabs"
-- FeatureName. Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Vertical Tabs'
      AND ItemText LIKE N'As of v1.11.2:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Vertical Tabs', N'As of v1.11.2: with vertical tabs enabled, look at the top-right corner of the window near the caption buttons (minimize/maximize/close) — **Expected:** no black/unpainted gap between the toolbar and the window''s right edge (previously the toolbar was narrowed to reserve caption-button room it didn''t need there, since this fork''s frame draws captions in their own row above the toolbar rather than inline with it).', @baseSort + 1);
END
GO
