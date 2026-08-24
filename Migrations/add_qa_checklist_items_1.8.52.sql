-- Adds QA checklist template items for browser v1.8.52:
--   Screenshot / Page Capture -- toolbar button for visible-area and
--   drag-to-select region capture, with Save-As/auto-save/clipboard
--   output. Full-page capture and the right-click context-menu entry
--   are follow-up commits, not covered here.
-- See screenshot-capture.md and changelog.md, wanderlust-knowledgebase
-- repo, for the full write-up.
--
-- Run after add_qa_checklist_items_1.8.50_to_1.8.51.sql. Idempotent:
-- skips entirely if these rows are already present (gated on the
-- brand-new "Screenshot & Page Capture" FeatureName). Appends after
-- the current max SortOrder, same as the prior QA-item migrations.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Screenshot & Page Capture'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    -- v1.8.52: Screenshot & Page Capture (Browser UI)
    (N'Browser UI', N'Screenshot & Page Capture', N'Click the toolbar screenshot button — **Expected:** a dropdown appears with "Capture visible area" and "Capture region…".', @baseSort + 1),
    (N'Browser UI', N'Screenshot & Page Capture', N'On a page taller than the viewport, click "Capture visible area" — **Expected:** a Save-As dialog appears (default behavior); the resulting PNG contains only what was visible on screen, not the full scrollable page.', @baseSort + 2),
    (N'Browser UI', N'Screenshot & Page Capture', N'On a HiDPI display (scale factor > 100%), repeat the visible-area capture — **Expected:** the saved image is sharp, not blurry/upscaled — its pixel dimensions should be larger than the viewport''s DIP size by the scale factor.', @baseSort + 3),
    (N'Browser UI', N'Screenshot & Page Capture', N'Click "Capture region…" — **Expected:** the page dims under a translucent overlay; dragging draws a clear rectangle with a visible border that tracks the cursor.', @baseSort + 4),
    (N'Browser UI', N'Screenshot & Page Capture', N'Complete a region drag and release — **Expected:** only the dragged rectangle is captured (verify the saved/copied image''s dimensions roughly match the dragged area, not the full viewport).', @baseSort + 5),
    (N'Browser UI', N'Screenshot & Page Capture', N'Start a region drag, then press Escape before releasing — **Expected:** the overlay closes and nothing is captured.', @baseSort + 6),
    (N'Browser UI', N'Screenshot & Page Capture', N'In Settings → Others → Screenshots, switch save behavior to "Save automatically," then capture again — **Expected:** no Save-As dialog appears; the file is written directly (default location is the profile''s Downloads folder unless an auto-save folder is configured).', @baseSort + 7),
    (N'Browser UI', N'Screenshot & Page Capture', N'With "copy to clipboard" enabled (default), capture either mode, then paste (Ctrl+V) into an image editor — **Expected:** the pasted image matches the capture.', @baseSort + 8),
    (N'Browser UI', N'Screenshot & Page Capture', N'Disable "copy to clipboard" in Settings, capture again, then try pasting — **Expected:** nothing new is on the clipboard from that capture.', @baseSort + 9),
    (N'Browser UI', N'Screenshot & Page Capture', N'Disable the toolbar button''s visibility via its pref (toolbar.show_screenshot_button, no Settings UI yet -- edit Preferences directly with the browser closed) — **Expected:** the button no longer appears in the toolbar.', @baseSort + 10);
END
GO
