-- Adds a QA checklist item for browser v1.11.4: a regression check for the
-- Tab Strip Logo going missing from the top-left corner after the
-- Chromium 144 rebase moved this fork's layout code to
-- BrowserViewTabbedLayoutImpl.
-- See qa-testing-checklist.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.3.sql. Idempotent: skips entirely
-- if an "As of v1.11.4:" item already exists for the "Tab Strip Logo"
-- FeatureName. Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Tab Strip Logo'
      AND ItemText LIKE N'As of v1.11.4:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Tab Strip Logo', N'As of v1.11.4: on a fresh build after a Chromium rebase, open a normal browser window with the horizontal tab strip showing — **Expected:** the logo appears at the top-left corner as always (a rebase that switched this fork''s layout code to `BrowserViewTabbedLayoutImpl` previously left the logo un-laid-out and effectively invisible, since it was parented to a container whose coordinate space no longer covered the tab strip''s row).', @baseSort + 1);
END
GO
