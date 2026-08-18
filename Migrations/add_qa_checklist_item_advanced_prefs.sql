-- Adds QA checklist template items for the new chrome://advanced-prefs page
-- (moved off chrome://settings/advanced-prefs in v1.8.31 -- see
-- qa-testing-checklist.md's "Advanced Preferences (chrome://advanced-prefs)"
-- section under Custom WebUI).
--
-- Run after add_qa_checklist.sql / seed_qa_checklist_template_items.sql have
-- already been applied. Idempotent: skips entirely if a row for this feature
-- already exists, so re-running this file is safe. Appends after the current
-- max SortOrder rather than reusing the doc's in-between position (605 was
-- the last seeded row) -- per QaChecklistTemplateItems' own design, new items
-- are appended, not interleaved/renumbered.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Advanced Preferences (chrome://advanced-prefs)'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Custom WebUI', N'Advanced Preferences (chrome://advanced-prefs)', N'Navigate directly to `chrome://advanced-prefs` — **Expected:** page loads with the full preference table (key/type/value/status columns).', @baseSort + 1),
    (N'Custom WebUI', N'Advanced Preferences (chrome://advanced-prefs)', N'Open `chrome://settings` and look through the nav — **Expected:** no "Advanced preferences" entry appears anywhere in the Settings UI.', @baseSort + 2),
    (N'Custom WebUI', N'Advanced Preferences (chrome://advanced-prefs)', N'Type `settings: advanced` in the omnibox — **Expected:** no quick-action suggestion for it appears (it''s no longer part of the Settings route table).', @baseSort + 3),
    (N'Custom WebUI', N'Advanced Preferences (chrome://advanced-prefs)', N'Type a filter term into the search box — **Expected:** table narrows to matching preference keys live.', @baseSort + 4),
    (N'Custom WebUI', N'Advanced Preferences (chrome://advanced-prefs)', N'Toggle a boolean pref''s checkbox — **Expected:** value flips immediately and the row highlights as "modified".', @baseSort + 5),
    (N'Custom WebUI', N'Advanced Preferences (chrome://advanced-prefs)', N'Click a string/number value to edit it, change it, press Enter — **Expected:** new value saves and the row shows "modified".', @baseSort + 6),
    (N'Custom WebUI', N'Advanced Preferences (chrome://advanced-prefs)', N'Click the reset (↺) icon on a modified pref — **Expected:** value reverts to default and the row''s status returns to "default".', @baseSort + 7),
    (N'Custom WebUI', N'Advanced Preferences (chrome://advanced-prefs)', N'Restart the browser after modifying a pref here — **Expected:** the change persists (this is real `PrefService` access, not a mock).', @baseSort + 8);
END
GO
