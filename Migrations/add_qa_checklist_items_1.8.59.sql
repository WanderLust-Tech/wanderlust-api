-- Adds QA checklist items for browser v1.8.59: fixed the tab strip's
-- product logo, which tiled into a visible 2x2 grid on HiDPI displays
-- (duplicate, never-actually-2x default_200_percent logo assets) and
-- went stale-sized depending on when the window's tab strip height
-- settled after launch (BrowserView::Init() sized it once and never
-- revisited it). This is the first QA checklist coverage for this
-- baseline branding element -- it predates the fork's versioned era and
-- never had its own section before.
-- See changelog.md, wanderlust-knowledgebase repo, for the full write-up.
--
-- Run after add_qa_checklist_items_1.8.58.sql. Idempotent: skips
-- entirely if the "Tab Strip Logo" FeatureName already exists (brand-new
-- feature name, so a bare FeatureName check is sufficient). Appends
-- after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Tab Strip Logo'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Tab Strip Logo', N'Look at the logo at 100% display scaling — **Expected:** renders crisp and fully visible, roughly square, sized to the tab strip''s height.', @baseSort + 1),
    (N'Browser UI', N'Tab Strip Logo', N'Switch the display to a HiDPI scale factor (e.g. Windows display scaling at 200%) and relaunch/move the browser window onto that display — **Expected:** logo still renders as a single crisp icon, not tiled into a repeating grid and not blurry.', @baseSort + 2),
    (N'Browser UI', N'Tab Strip Logo', N'Resize the browser window and try both compact/comfortable density settings if available — **Expected:** logo stays proportionally sized to the tab strip''s current height in every case, never clipped or oversized.', @baseSort + 3),
    (N'Browser UI', N'Tab Strip Logo', N'As of v1.8.59: repeat the HiDPI check above — **Expected:** logo no longer tiles into a visible 2x2 grid (previously the `default_200_percent` logo assets were duplicates of the 100% versions, so a HiDPI compositor sampled a 1x texture into a 2x quad) and no longer goes stale-sized depending on when the window''s tab strip height settled after launch.', @baseSort + 4);
END
GO
