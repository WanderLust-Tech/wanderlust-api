-- Adds QA checklist items for browser v1.9.3 through v1.9.5:
--
-- v1.9.3 -- undocked sidebar's WebContents visibly resized itself while
--           being dragged at a fractional DPI scale (e.g. 125%) -- the
--           drag handler re-measured window size from screen coordinates
--           on every mouse-move, and DPI rounding drift in that
--           round-trip read as spurious size changes.
-- v1.9.4 -- new feature: a toggle on chrome://chrome-urls to unlock
--           Chromium's internal-only debugging pages (memory-internals,
--           discards, local-state, etc.), previously unreachable in this
--           fork since chrome://chrome-urls had no message handler to
--           flip the enabling pref.
-- v1.9.5 -- fixed a crash on closing the browser window -- the
--           on-minimize working-set-trim's IsMinimized() check could run
--           reentrantly while the window's native widget was being torn
--           down.
--
-- See sidebar.md, internal-debugging-pages.md, browser-tools.md, and
-- changelog.md (1.9.3/1.9.4/1.9.5 entries), wanderlust-knowledgebase repo,
-- for the full write-ups.
--
-- Run after add_qa_checklist_items_1.9.1_to_1.9.2.sql. Idempotent: skips
-- each version's items independently -- the 1.9.4 block gates on the
-- brand-new "Internal Debugging Pages" FeatureName, the 1.9.3/1.9.5
-- blocks gate on their existing FeatureName + an ItemText LIKE prefix
-- (a bare FeatureName check would skip the whole block, since both
-- features already have older rows). Appends after the current max
-- SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Sidebar'
      AND ItemText LIKE N'As of v1.9.3:%'
)
BEGIN
    DECLARE @baseSort1 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Sidebar', N'As of v1.9.3: undock the sidebar and, at a fractional display scale (e.g. Windows set to 125%), slowly drag the floating widget by its title/drag area — **Expected:** the sidebar''s WebContents stays a stable size throughout the drag, with no visible flicker/reflow of its contents (previously the drag handler re-measured the window''s size from screen coordinates on every mouse-move, and DPI rounding drift in that round-trip read as tiny spurious size changes).', @baseSort1 + 1);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Internal Debugging Pages'
)
BEGIN
    DECLARE @baseSort2 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Custom WebUI', N'Internal Debugging Pages', N'As of v1.9.4: navigate to a gated internal page, e.g. `chrome://memory-internals`, before enabling anything — **Expected:** redirected to the `chrome://internal-debug-pages-disabled` interstitial, with a link back to `chrome://chrome-urls`.', @baseSort2 + 1),
    (N'Custom WebUI', N'Internal Debugging Pages', N'As of v1.9.4: on `chrome://chrome-urls`, find the **Internal Debugging Page URLs** section and click **Enable internal debugging pages** — **Expected:** no restart prompt; the section immediately becomes a list of clickable links (memory-internals, discards, local-state, etc.), and following the interstitial''s link now lands directly on the target page instead of the interstitial.', @baseSort2 + 2),
    (N'Custom WebUI', N'Internal Debugging Pages', N'As of v1.9.4: click through a few of the now-enabled links — **Expected:** each internal page loads normally (not the disabled interstitial).', @baseSort2 + 3),
    (N'Custom WebUI', N'Internal Debugging Pages', N'As of v1.9.4: restart the browser after enabling — **Expected:** the setting persists (it''s a local-state pref, not per-session).', @baseSort2 + 4);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Browser Tools (app menu utilities)'
      AND ItemText LIKE N'As of v1.9.5:%'
)
BEGIN
    DECLARE @baseSort3 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Browser Tools (app menu utilities)', N'As of v1.9.5: close the browser window normally (title bar ✕ or app menu → Exit) — **Expected:** the browser closes cleanly with no crash (previously, tearing down the window''s native widget fired a final visibility-change notification that reentered the working-set trim''s `IsMinimized()` check while the native widget was mid-teardown, crashing on close).', @baseSort3 + 1);
END
GO
