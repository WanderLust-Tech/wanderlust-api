-- Adds QA checklist items for browser v1.9.16: a speed-dial style New Tab
-- Page experience ported from the third-party Toolbar Dial browser
-- extension -- a new "Dial" NTP layout flavor, plus a dial-style tile
-- option for the existing top-sites grid (Full/Hub layouts). Also covers
-- same-version follow-ups: a fix for the dial tiles overlapping in a
-- fixed 5-column grid, a content-section reorder, and the wallpaper
-- customization consolidation (shared useWallpaper hook + WallpaperPicker
-- component, Bing/Unsplash support in every layout, a new Custom
-- uploaded-image source).
--
-- See dial-tiles.md, wallpaper-customization.md, and changelog.md (1.9.16
-- entry), wanderlust-knowledgebase repo, for the full write-ups.
--
-- Run after add_qa_checklist_items_1.9.15.sql. Idempotent: each block below
-- skips independently -- blocks touching an already-seeded FeatureName gate
-- on a distinguishing ItemText substring specific to that row (a bare
-- "As of v1.9.16:%" prefix isn't specific enough once a FeatureName has more
-- than one v1.9.16 addition), the brand-new feature blocks gate on their
-- FeatureName alone. Appends after the current max SortOrder in each case.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'NTP Layout Switching' AND ItemText LIKE N'As of v1.9.16:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'New Tab Page', N'NTP Layout Switching', N'As of v1.9.16: switch to the new "Dial" layout — **Expected:** NTP body re-renders as a speed-dial bookmark grid without errors (see the dedicated Dial Layout section below for detailed steps).', @baseSort + 1);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Dial-Style Top Sites Tiles'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'New Tab Page', N'Dial-Style Top Sites Tiles', N'In Full layout''s NTP Settings, enable "Top sites (dial)" in the Content drag-reorder list — **Expected:** A new top-sites tile section appears on the NTP (in addition to the existing static tiles), populated with real top-sites data.', @baseSort + 1),
    (N'New Tab Page', N'Dial-Style Top Sites Tiles', N'With "Top sites (dial)" enabled, switch the style picker to "Dial tiles" — **Expected:** Tiles switch from favicon-based to colorful tiles with a stylized domain name (e.g. large "GOOGLE" text) instead of a favicon.', @baseSort + 2),
    (N'New Tab Page', N'Dial-Style Top Sites Tiles', N'Compare a known brand (e.g. google.com) against an unfamiliar domain — **Expected:** The known brand gets a recognizable brand color; the unfamiliar domain gets a color too, and reloading the NTP shows the exact same color again (not a new random one each time).', @baseSort + 3),
    (N'New Tab Page', N'Dial-Style Top Sites Tiles', N'Drag the "Top sites (dial)" row to a different position in the Content list — **Expected:** Section reorders on the NTP accordingly, same as other draggable sections.', @baseSort + 4),
    (N'New Tab Page', N'Dial-Style Top Sites Tiles', N'Switch to Hub layout — **Expected:** The dynamic top-sites tile grid renders in the top bar alongside the existing static tiles, without errors.', @baseSort + 5);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Dial Layout'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'New Tab Page', N'Dial Layout', N'Switch to "Dial" layout — **Expected:** NTP renders a search bar over a wallpaper background, followed by a grid of colorful tiles for the browser''s bookmark folders and top-level bookmarks.', @baseSort + 1),
    (N'New Tab Page', N'Dial Layout', N'Click a folder tile — **Expected:** Grid updates to show that folder''s bookmarks/sub-folders; a "back" pill button with the folder''s name appears above the grid.', @baseSort + 2),
    (N'New Tab Page', N'Dial Layout', N'Click the back button — **Expected:** Returns to the previous grid level (root, or the parent folder).', @baseSort + 3),
    (N'New Tab Page', N'Dial Layout', N'Click a bookmark tile — **Expected:** Navigates to that bookmark''s URL.', @baseSort + 4),
    (N'New Tab Page', N'Dial Layout', N'Add/rename/remove a bookmark or folder in the browser''s Bookmark Manager, then revisit the Dial layout — **Expected:** Grid reflects the change (live-updated, not stale).', @baseSort + 5);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Dial-Style Top Sites Tiles' AND ItemText LIKE N'As of v1.9.16:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'New Tab Page', N'Dial-Style Top Sites Tiles', N'As of v1.9.16: with "Dial tiles" selected and enough tiles to fill multiple rows, check a narrower browser window as well as a wide one — **Expected:** Tiles are laid out in a grid sized to their actual width, with no visual overlap between adjacent tiles at any width (previously a fixed 5-column grid caused tiles to overlap once a column was narrower than a tile).', @baseSort + 1);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Dial-Style Top Sites Tiles' AND ItemText LIKE N'%directly above the static Wanderlust Pages tiles%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'New Tab Page', N'Dial-Style Top Sites Tiles', N'As of v1.9.16: on a fresh profile (or with default settings restored), enable "Top sites (dial)" in Full layout — **Expected:** The dial top-sites section appears directly above the static Wanderlust Pages tiles by default, not below them.', @baseSort + 1);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Wallpaper Customization' AND ItemText LIKE N'As of v1.9.16:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'New Tab Page', N'Wallpaper Customization', N'As of v1.9.16: switch to Focus, Glass, Hub, or Dial layout and set the wallpaper source to Bing or Unsplash from NTP Settings — **Expected:** The layout''s background actually shows a Bing/Unsplash photo (previously these layouts silently ignored anything but the Colour source and always fell back to a static random image).', @baseSort + 1),
    (N'New Tab Page', N'Wallpaper Customization', N'As of v1.9.16: switch to Full layout and adjust the blur/brightness sliders — **Expected:** The Full layout''s background responds to blur/brightness for the first time (previously unsupported there).', @baseSort + 2),
    (N'New Tab Page', N'Wallpaper Customization', N'As of v1.9.16: in the Wallpaper layout, open its own gear-icon settings panel and switch the source to "Custom" — **Expected:** An image upload control appears; after picking an image file, it becomes the background immediately and persists after reloading that NTP tab.', @baseSort + 3),
    (N'New Tab Page', N'Wallpaper Customization', N'As of v1.9.16: with a Custom image set in the Wallpaper layout, open the NTP Settings sidebar — **Expected:** No "Custom" option appears there (it''s only settable from the Wallpaper layout''s own picker); the other four sources still work normally from the sidebar.', @baseSort + 4),
    (N'New Tab Page', N'Wallpaper Customization', N'As of v1.9.16: open the NTP Settings sidebar''s wallpaper picker on each layout that shows one — **Expected:** Source buttons, topic chips, color input, and blur/brightness sliders look and behave the same as before (now backed by a shared component internally; no visual or functional regression expected).', @baseSort + 5);
END
GO
