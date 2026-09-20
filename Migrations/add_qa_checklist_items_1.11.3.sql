-- Corrects/adds the QA checklist item for browser v1.11.2's vertical-tabs
-- top-right-corner-gap fix: that fix turned out not to work (it checked
-- upstream's unused kVerticalTabs/GetTabStripType() signal instead of this
-- fork's own vertical-tab-bar visibility), and the real fix shipped in
-- v1.11.3 instead. See changelog.md's 1.11.3 and 1.11.2 entries,
-- wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.2.sql. Idempotent, and handles both
-- possible starting states:
--   1. add_qa_checklist_items_1.11.2.sql already ran against this DB -->
--      the existing "As of v1.11.2:" row for Vertical Tabs is UPDATEd in
--      place to the corrected "As of v1.11.3:" wording (same SortOrder).
--   2. It never ran (this DB is catching up straight to 1.11.3) --> a new
--      row is INSERTed instead, appended after the current max SortOrder.
-- Either way, running this migration twice is a no-op the second time.

IF EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Vertical Tabs'
      AND ItemText LIKE N'As of v1.11.2:%'
)
BEGIN
    UPDATE QaChecklistTemplateItems
    SET ItemText = N'As of v1.11.3: with vertical tabs enabled, look at the top-right corner of the window near the caption buttons (minimize/maximize/close) — **Expected:** no black/unpainted gap between the toolbar and the window''s right edge (previously the toolbar was narrowed to reserve caption-button room it didn''t need there, since this fork''s frame draws captions in their own row above the toolbar rather than inline with it; a same-day v1.11.2 attempt at this fix checked the wrong condition and had no effect — see changelog for both entries).'
    WHERE FeatureName = N'Vertical Tabs'
      AND ItemText LIKE N'As of v1.11.2:%';
END
ELSE IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Vertical Tabs'
      AND ItemText LIKE N'As of v1.11.3:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Vertical Tabs', N'As of v1.11.3: with vertical tabs enabled, look at the top-right corner of the window near the caption buttons (minimize/maximize/close) — **Expected:** no black/unpainted gap between the toolbar and the window''s right edge (previously the toolbar was narrowed to reserve caption-button room it didn''t need there, since this fork''s frame draws captions in their own row above the toolbar rather than inline with it; a same-day v1.11.2 attempt at this fix checked the wrong condition and had no effect — see changelog for both entries).', @baseSort + 1);
END
GO
