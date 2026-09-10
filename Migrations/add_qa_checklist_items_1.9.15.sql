-- Adds QA checklist items for browser v1.9.15: new "Menu Backdrop Material
-- (Windows 11 Acrylic)" Settings toggle that applies the DWM "transient
-- window" backdrop material to the browser's own popup context menus.
--
-- See menu-backdrop-material.md and changelog.md (1.9.15 entry),
-- wanderlust-knowledgebase repo, for the full write-up.
--
-- Run after add_qa_checklist_items_1.9.13_to_1.9.14.sql. Idempotent: skips
-- entirely if the brand-new "Menu Backdrop Material (Windows 11 Acrylic)"
-- FeatureName is already present. Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Menu Backdrop Material (Windows 11 Acrylic)'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Menu Backdrop Material (Windows 11 Acrylic)', N'On Windows 11 22H2+, turn the toggle on in Settings → Appearance, then right-click a page — **Expected:** the context menu shows a translucent/blurred background instead of a flat solid color.', @baseSort + 1),
    (N'Browser UI', N'Menu Backdrop Material (Windows 11 Acrylic)', N'Turn the toggle off, right-click a page again — **Expected:** the menu returns to its normal fully-opaque background.', @baseSort + 2),
    (N'Browser UI', N'Menu Backdrop Material (Windows 11 Acrylic)', N'Try both light and dark theme with the toggle on — **Expected:** the translucent effect is visible and legible in both (text remains readable against the blurred backdrop).', @baseSort + 3),
    (N'Browser UI', N'Menu Backdrop Material (Windows 11 Acrylic)', N'Open a submenu (e.g. hover a menu item with an arrow) — **Expected:** the submenu also shows the translucent effect, not just the top-level menu.', @baseSort + 4),
    (N'Browser UI', N'Menu Backdrop Material (Windows 11 Acrylic)', N'On Windows 10 (or any pre-22H2 Windows 11 build) with the toggle on — **Expected:** no crash; menus render normally (fully opaque), since the underlying DWM API isn''t available.', @baseSort + 5),
    (N'Browser UI', N'Menu Backdrop Material (Windows 11 Acrylic)', N'On macOS/Linux, confirm the Settings toggle is still present and can be switched on/off — **Expected:** no crash or visible effect either way (Windows-only feature).', @baseSort + 6);
END
GO
