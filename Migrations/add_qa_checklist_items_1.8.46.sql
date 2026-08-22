-- Adds QA checklist template items for v1.8.46: right-click context menus
-- for bookmarks on both chrome://bookmarks and the sidebar's Bookmarks
-- panel, the latter reaching full CRUD parity (it was previously
-- read-only). See qa-testing-checklist.md and changelog.md,
-- wanderlust-knowledgebase repo, for the full write-up.
--
-- Run after update_qa_checklist_items_1.8.39_to_1.8.45.sql. Idempotent:
-- skips entirely if these rows are already present (gated on the more
-- distinctive of the sidebar-panel ItemTexts). Appends after the current
-- max SortOrder, same as the prior QA-item migrations.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE Category = N'Custom WebUI'
      AND FeatureName = N'Sidebar — Bookmarks panel (chrome://sidebar/bookmarks)'
      AND ItemText LIKE N'As of v1.8.46:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    -- Sidebar Bookmarks panel — new context menu / CRUD parity
    (N'Custom WebUI', N'Sidebar — Bookmarks panel (chrome://sidebar/bookmarks)', N'As of v1.8.46: right-click a bookmark in this panel — **Expected:** a context menu appears with Open / Open in new tab / Open in new window / Copy URL / Add bookmark or folder here / Edit… / Move to folder… / Delete — this panel previously had no context menu at all.', @baseSort + 1),
    (N'Custom WebUI', N'Sidebar — Bookmarks panel (chrome://sidebar/bookmarks)', N'Use **Open in new tab** and **Open in new window** — **Expected:** each opens with the correct disposition (background/foreground tab, or a new window) via the same `bookmarkOpenUrl` message `chrome://bookmarks` uses.', @baseSort + 2),
    (N'Custom WebUI', N'Sidebar — Bookmarks panel (chrome://sidebar/bookmarks)', N'Use **Move to folder…** to move a bookmark — **Expected:** a folder picker appears and the move applies immediately; note this panel doesn''t get drag-and-drop reordering in this pass, only the picker.', @baseSort + 3),
    (N'Custom WebUI', N'Sidebar — Bookmarks panel (chrome://sidebar/bookmarks)', N'Use **Delete** on a bookmark added from this panel — **Expected:** it disappears from both this panel and `chrome://bookmarks` immediately.', @baseSort + 4),
    -- chrome://bookmarks — new context menu
    (N'Custom WebUI', N'Custom WebUI Pages — Fleet Smoke Test', N'As of v1.8.46: right-click a bookmark on `chrome://bookmarks` — **Expected:** a context menu appears (previously there wasn''t one) with Open / Open in new tab / Open in new window / Copy URL / Add bookmark or folder here / Edit… / Move to folder… / Delete.', @baseSort + 5),
    (N'Custom WebUI', N'Custom WebUI Pages — Fleet Smoke Test', N'Use **Copy URL**, then paste — **Expected:** clipboard contains that bookmark''s URL.', @baseSort + 6),
    (N'Custom WebUI', N'Custom WebUI Pages — Fleet Smoke Test', N'Use **Add bookmark or folder here** from a right-click on a folder — **Expected:** a new bookmark/folder is created inside that folder.', @baseSort + 7),
    (N'Custom WebUI', N'Custom WebUI Pages — Fleet Smoke Test', N'Use **Edit…** on a bookmark — **Expected:** opens an editor for its title/URL; saving updates the tree immediately.', @baseSort + 8),
    (N'Custom WebUI', N'Custom WebUI Pages — Fleet Smoke Test', N'Use **Move to folder…** — **Expected:** a folder picker appears; confirming moves the bookmark, reflected immediately in the tree.', @baseSort + 9);
END
GO
