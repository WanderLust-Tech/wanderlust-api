-- Adds QA checklist items for browser v1.11.12: Workspaces are now listed
-- after a browser restart (the workspace service starts with the profile; the
-- settings page and the vertical tab bar menu read it without creating it, so
-- they used to show nothing until a workspace was created or edited).
-- See changelog.md and qa-testing-checklist.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.11.sql. Idempotent: skips entirely if an
-- "As of v1.11.12:" item already exists for the "Workspaces (Spaces)" FeatureName.
-- Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Workspaces (Spaces)'
      AND ItemText LIKE N'As of v1.11.12:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Workspaces (Spaces)', N'As of v1.11.12: in `chrome://settings/workspaces` create two workspaces, then fully quit and restart the browser and open `chrome://settings/workspaces` again — **Expected:** both workspaces are listed straight away, without having to create or edit one first.', @baseSort + 1),
    (N'Browser UI', N'Workspaces (Spaces)', N'As of v1.11.12: after that restart, right-click empty vertical-tab-bar space — **Expected:** the "Switch workspace ▸" submenu is present, lists both workspaces, and the one that was active before the restart has the checkmark.', @baseSort + 2);
END
GO
