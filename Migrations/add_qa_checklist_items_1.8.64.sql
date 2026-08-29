-- Adds QA checklist items for browser v1.8.64: fixes the undocked sidebar
-- being effectively unusable when snapped to the top or bottom screen edge.
-- Two independent bugs: (1) the floating widget's peek strip never actually
-- reached its intended 4px height (Windows enforced a size floor tied to
-- the window having been created WS_OVERLAPPED, fixed by switching to
-- TYPE_WINDOW_FRAMELESS / WS_POPUP), and (2) the pane-button strip only
-- knew how to lay out a vertical column, so on the wide-short top/bottom
-- ribbon the buttons overflowed and none were visible.
-- See sidebar.md ("Why TYPE_WINDOW_FRAMELESS, not TYPE_WINDOW") and
-- changelog.md, wanderlust-knowledgebase repo, for the full write-up.
--
-- Run after add_qa_checklist_items_1.8.61_to_1.8.63.sql. Idempotent: skips
-- entirely if a v1.8.64 Sidebar item is already present. Appends after the
-- current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Sidebar'
      AND ItemText LIKE N'As of v1.8.64:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Sidebar', N'As of v1.8.64: snap the undocked widget to the top or bottom screen edge (not left/right), while collapsed — **Expected:** the pane-button icons render in a horizontal row and are all visible/clickable (previously they stacked in a vertical column that overflowed the short top/bottom strip, so no icons were visible at all).', @baseSort + 1),
    (N'Browser UI', N'Sidebar', N'As of v1.8.64: with the widget snapped top or bottom, leave it idle to auto-hide, then compare the peek strip''s height against the docked pane-button strip''s thickness — **Expected:** peek strip is genuinely ~4px tall, matching the left/right peek strip''s width (previously it settled around ~36px tall — a fat grey bar — regardless of the v1.8.61 fix, which only reliably applied to the left/right, width-based case).', @baseSort + 2),
    (N'Browser UI', N'Sidebar', N'As of v1.8.64: with the widget snapped top or bottom, expand it (not collapsed) — **Expected:** the pane strip sits as a band hugging the actual snapped edge (top strip at the top, bottom strip at the bottom), with the web content filling the rest.', @baseSort + 3);
END
GO
