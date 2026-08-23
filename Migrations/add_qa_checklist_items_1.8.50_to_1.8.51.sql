-- Adds QA checklist template items for browser v1.8.50-1.8.51:
--   1.8.50 -- browser-data importer surfaced as its own Settings page
--   1.8.51 -- quit-application confirmation + newly-exposed tab-close
--             confirmation toggle
-- See close-confirmation.md, intro-wizard.md, and changelog.md,
-- wanderlust-knowledgebase repo, for the full write-ups.
--
-- Run after update_qa_checklist_items_1.8.49.sql. Idempotent: skips
-- entirely if these rows are already present (gated on the brand-new
-- "Close & Quit Confirmation" FeatureName). Appends after the current
-- max SortOrder, same as the prior QA-item migrations.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Close & Quit Confirmation'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    -- v1.8.51: Close & Quit Confirmation (Browser UI)
    (N'Browser UI', N'Close & Quit Confirmation', N'Enable "Confirm before quitting the browser," then close your only open window (or use the app menu''s Exit command) — **Expected:** a "Quit WanderLust" dialog appears asking "This will close all windows and tabs. Are you sure you want to quit?" with OK/Cancel and a "Do not ask next time" checkbox.', @baseSort + 1),
    (N'Browser UI', N'Close & Quit Confirmation', N'Click Cancel — **Expected:** the browser stays open, nothing closes.', @baseSort + 2),
    (N'Browser UI', N'Close & Quit Confirmation', N'Repeat and click OK — **Expected:** the browser quits normally.', @baseSort + 3),
    (N'Browser UI', N'Close & Quit Confirmation', N'Repeat once more, but check "Do not ask next time" before confirming — **Expected:** the browser quits, and the Settings toggle is now off — quitting again doesn''t prompt.', @baseSort + 4),
    (N'Browser UI', N'Close & Quit Confirmation', N'With "Confirm before quitting" enabled, open a second browser window, then close just one of the two windows — **Expected:** no prompt (the app isn''t quitting — another window remains open).', @baseSort + 5),
    (N'Browser UI', N'Close & Quit Confirmation', N'Enable "Confirm before closing a window with multiple tabs," open 2+ tabs in a window, then close the window (not via the app quitting) — **Expected:** a confirmation dialog appears before the window actually closes.', @baseSort + 6),
    (N'Browser UI', N'Close & Quit Confirmation', N'With only one tab open, close the window — **Expected:** no prompt (the pref only applies at 2+ tabs).', @baseSort + 7),
    (N'Browser UI', N'Close & Quit Confirmation', N'With both toggles enabled, close the last window with multiple tabs open (an action that both closes a multi-tab window *and* quits the app) — **Expected:** per the implementation comment, the two dialogs are checked in a fixed order (quit check before tab-close check) specifically so they don''t appear stacked/overlapping on top of each other — confirm what you actually observe (e.g. quit dialog only, or quit dialog followed by a separate tab-close dialog) and note it, since this exact sequencing hasn''t been manually verified end-to-end yet.', @baseSort + 8),
    -- v1.8.50: Import Browser Data (Settings & Configuration)
    (N'Settings & Configuration', N'Import Browser Data (Settings)', N'Open Settings and look at the left-nav — **Expected:** an "Import browser data" entry is present (previously the only way to reach this importer was the first-run wizard).', @baseSort + 9),
    (N'Settings & Configuration', N'Import Browser Data (Settings)', N'Click into it — **Expected:** the same source-detection/selection UI as the first-run wizard''s import step loads (detected browsers with per-item checkboxes for bookmarks/history/passwords/etc., plus a Bookmarks HTML File option).', @baseSort + 10),
    (N'Settings & Configuration', N'Import Browser Data (Settings)', N'Run an import from this page (e.g. a Bookmarks HTML File) — **Expected:** it completes the same way it would from `chrome://intro` — same progress states, same success/failure signaling.', @baseSort + 11),
    (N'Settings & Configuration', N'Import Browser Data (Settings)', N'Run the import a second time later, well after first-run — **Expected:** works identically; there''s no "only during first run" restriction on this entry point.', @baseSort + 12);
END
GO
