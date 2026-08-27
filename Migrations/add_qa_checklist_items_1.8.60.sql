-- Adds QA checklist items for browser v1.8.60: chrome://chrome-urls and
-- chrome://terms used the wrong light-mode background color.
-- See changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.8.59.sql. Idempotent: skips entirely
-- if a row with this ItemText prefix is already present. Appends after the
-- current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Custom WebUI Pages — Fleet Smoke Test'
    AND ItemText LIKE N'As of v1.8.60:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Custom WebUI', N'Custom WebUI Pages — Fleet Smoke Test', N'As of v1.8.60: in **light** mode, compare `chrome://chrome-urls` and `chrome://terms` against `chrome://whats-new` or `chrome://intro` — **Expected:** all render the same off-white background (previously `chrome-urls` and `terms` used a slightly different pure-white background instead of the shared `bg-lightPrimary` token).', @baseSort + 1);
END
GO
