-- Adds QA checklist items for browser v1.9.22: Minimal Browsing Mode, a new
-- Settings toggle that permanently hides the toolbar and bookmark bar while
-- keeping the tab strip visible.
-- See minimal-browsing-mode.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after update_qa_checklist_items_1.9.21.sql. Idempotent: skips entirely
-- if the "Minimal Browsing Mode" FeatureName already has rows. Appends after
-- the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Minimal Browsing Mode'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Minimal Browsing Mode', N'Turn on "Minimal browsing mode" in Settings → Appearance → Layout — **Expected:** the toolbar (address bar, back/forward, extensions) and bookmark bar disappear immediately with no restart needed; the tab strip stays visible and usable.', @baseSort + 1),
    (N'Browser UI', N'Minimal Browsing Mode', N'With the toggle on, move the cursor to the top of the window — **Expected:** nothing reappears (unlike Zen Mode, there is no hover-to-reveal).', @baseSort + 2),
    (N'Browser UI', N'Minimal Browsing Mode', N'With the toggle on, open a new tab / switch between tabs — **Expected:** the tab strip continues to work normally; toolbar and bookmark bar remain hidden.', @baseSort + 3),
    (N'Browser UI', N'Minimal Browsing Mode', N'Turn the toggle off again — **Expected:** the toolbar and bookmark bar (if previously shown) reappear immediately.', @baseSort + 4),
    (N'Browser UI', N'Minimal Browsing Mode', N'Enable both "Minimal browsing mode" and "Zen mode" together — **Expected:** no crash; toolbar/bookmark bar stay hidden (an untested combination, but it shouldn''t produce a broken layout).', @baseSort + 5),
    (N'Browser UI', N'Minimal Browsing Mode', N'Enable "Compact layout" together with "Minimal browsing mode" — **Expected:** no crash; toolbar remains hidden regardless of the compact-row layout.', @baseSort + 6);
END
GO
