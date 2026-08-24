-- Adds QA checklist regression items for browser v1.8.53-1.8.54:
--   1.8.53 -- SidebarAppRegistryFactory wasn't registered alongside its
--             sibling sidebar factories at startup, risking a fatal
--             DCHECK if something constructed it lazily post-startup
--   1.8.54 -- fixes a use-after-free in Screenshot / Page Capture's
--             region mode (dangling WebContents/NativeWindow across
--             an open-ended drag), plus a missing accessible name on
--             the region-select overlay that could trip a Debug-build
--             accessibility assertion
-- See changelog.md, wanderlust-knowledgebase repo, for the full
-- write-ups. Both items are appended to their existing FeatureName
-- rows (Sidebar Apps, Screenshot & Page Capture) rather than creating
-- new features, since these are fixes, not new functionality.
--
-- Run after add_qa_checklist_items_1.8.52.sql. Idempotent: skips
-- entirely if the v1.8.54 item is already present. Appends after the
-- current max SortOrder, same as the prior QA-item migrations.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Screenshot & Page Capture'
      AND ItemText LIKE N'As of v1.8.54:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    -- v1.8.53: SidebarAppRegistryFactory startup-registration fix
    (N'Browser UI', N'Sidebar Apps', N'As of v1.8.53: launch the browser fresh and immediately (before doing anything else) right-click a .lnk shortcut -> "Add to Wanderlust Sidebar" — **Expected:** works without crashing (previously SidebarAppRegistryFactory wasn''t registered at startup alongside its sibling sidebar factories, so being the first thing to construct it post-startup could trip a fatal DCHECK).', @baseSort + 1),
    -- v1.8.54: region-capture dangling-pointer + accessibility fix
    (N'Browser UI', N'Screenshot & Page Capture', N'As of v1.8.54: start a region-capture drag, then close the tab (or the whole browser window) before releasing the mouse — **Expected:** no crash; the overlay/selection is simply abandoned. Repeat but navigate the tab to a different page mid-drag instead of closing it — **Expected:** same, no crash.', @baseSort + 2),
    (N'Browser UI', N'Screenshot & Page Capture', N'As of v1.8.54: with a screen reader running (e.g. Narrator), trigger "Capture region…" — **Expected:** the overlay announces an accessible name/role when it gains focus, and the browser doesn''t crash on an accessibility paint-check assertion (Debug builds only).', @baseSort + 3);
END
GO
