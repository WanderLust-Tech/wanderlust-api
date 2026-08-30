-- Adds QA checklist items for browser v1.9.1 and v1.9.2, two fixes found
-- while verifying the v1.9.0 Chromium 142 rebase:
--
-- v1.9.1: the sidebar's content area was undersized/mis-offset by a new
-- main_container_ wrapping view Chromium 142 introduced (upstream's own
-- addition) that the rebase didn't fully adapt the sidebar retrofit to --
-- three symptoms, one root cause: the sidebar didn't reach the bottom of
-- the window, custom WebUI pages showed a black gap at the top, and
-- main_container_ sat on top of the sidebar in hit-testing order,
-- swallowing clicks meant for it.
--
-- v1.9.2: a DCHECK crash resolving a .lnk shortcut's target for "Add to
-- Wanderlust Sidebar" -- the resolve step did blocking shell/COM I/O
-- directly on the UI thread in both the already-running-instance and
-- cold-start launch paths.
--
-- See sidebar.md, sidebar-apps.md, and changelog.md (1.9.1/1.9.2 entries),
-- wanderlust-knowledgebase repo, for the full write-ups.
--
-- Run after add_qa_checklist_items_1.8.64.sql. Idempotent: skips each
-- version's items independently if a matching FeatureName + ItemText
-- prefix is already present. Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Sidebar'
      AND ItemText LIKE N'As of v1.9.1:%'
)
BEGIN
    DECLARE @baseSort1 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Sidebar', N'As of v1.9.1: dock the sidebar, expand it, and open a WebUI panel (e.g. NTP Settings) or a pinned Web Panel — **Expected:** the sidebar''s content fills the full height of the window with no gap at the bottom, the page renders from the very top with no black band above it, and the pane-strip icons respond to clicks normally (previously the Chromium 142 rebase''s new `main_container_` wrapping view undersized the sidebar''s content area, mis-offset it vertically, and sat on top of it in z-order, silently swallowing clicks meant for the sidebar).', @baseSort1 + 1);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Sidebar Apps'
      AND ItemText LIKE N'As of v1.9.2:%'
)
BEGIN
    DECLARE @baseSort2 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Sidebar Apps', N'As of v1.9.2: right-click a `.lnk` shortcut → "Add to Wanderlust Sidebar" both while the browser is already running and from a cold start (browser fully closed) — **Expected:** works without crashing in either case (previously resolving the shortcut''s target did blocking shell/COM I/O directly on the UI thread, tripping a fatal DCHECK in debug builds).', @baseSort2 + 1);
END
GO
