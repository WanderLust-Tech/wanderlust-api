-- Adds QA checklist items for browser v1.9.10 through v1.9.12:
--
-- v1.9.10 -- full-page screenshot capture (native single-shot resize+
--           capture, no scroll/stitch) and an optional 0/3/5/10s delay
--           before a capture fires.
-- v1.9.11 -- new chrome://screenshot-editor page (Screenshot Editor):
--           view a capture and Save/Copy it, no annotation tools yet.
-- v1.9.12 -- annotation tools added to the Screenshot Editor: shapes,
--           text captions, a real blur/pixelate redaction tool, crop,
--           and undo/redo.
--
-- See screenshot-capture.md, screenshot-editor.md, and changelog.md
-- (1.9.10-1.9.12 entries), wanderlust-knowledgebase repo, for the full
-- write-ups.
--
-- Run after add_qa_checklist_items_1.9.6_to_1.9.9.sql. Idempotent: the
-- 1.9.10 block gates on FeatureName + an ItemText LIKE prefix (Screenshot
-- & Page Capture already has older rows, so a bare FeatureName check
-- would skip the whole block); the Screenshot Editor block gates on its
-- brand-new FeatureName alone (all its rows land in this one migration,
-- covering both v1.9.11's scaffolding and v1.9.12's tools). Appends after
-- the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Screenshot & Page Capture'
      AND ItemText LIKE N'As of v1.9.10:%'
)
BEGIN
    DECLARE @baseSort1 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Screenshot & Page Capture', N'As of v1.9.10: on a real long page (ideally one with a sticky/fixed header), click "Capture full page" — **Expected:** the entire document height is captured in one image, with the header appearing once, not repeated. Also try an extremely tall page (e.g. an infinite-scroll page force-scrolled very long) — **Expected:** the capture fails cleanly (no crash) instead of attempting an unsupportable capture past the dimension ceiling.', @baseSort1 + 1),
    (N'Browser UI', N'Screenshot & Page Capture', N'As of v1.9.10: in Settings → Others → Screenshots, set the capture delay to 5 seconds, then trigger a visible-area or full-page capture and quickly open a hover menu/tooltip somewhere — **Expected:** a real ~5 second pause before the shot fires, with the hover menu visible in the resulting image.', @baseSort1 + 2);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Screenshot Editor'
)
BEGIN
    DECLARE @baseSort2 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Screenshot Editor', N'With the pref on, take a capture — **Expected:** a new foreground tab opens at `chrome://screenshot-editor/<id>` showing the exact captured image.', @baseSort2 + 1),
    (N'Browser UI', N'Screenshot Editor', N'Draw a rectangle, a filled rectangle, an ellipse, an arrow, and a freehand line — **Expected:** each renders correctly with the selected color and line width.', @baseSort2 + 2),
    (N'Browser UI', N'Screenshot Editor', N'Select the text tool and click on the image — **Expected:** a small Caption/Add/Cancel popup appears right at the click point; type a caption and press Enter (or click Add) — **Expected:** the caption is drawn onto the image at that position.', @baseSort2 + 3),
    (N'Browser UI', N'Screenshot Editor', N'Select the blur tool and drag over a region (e.g. some text) — **Expected:** that region becomes a real pixelated blur, not just painted over with a solid color — the underlying content should be genuinely illegible but not a flat color block.', @baseSort2 + 4),
    (N'Browser UI', N'Screenshot Editor', N'Select the crop tool and drag a region, then release — **Expected:** the canvas immediately resizes to just that region (no lingering full-size image).', @baseSort2 + 5),
    (N'Browser UI', N'Screenshot Editor', N'Draw a few different shapes, then click Undo repeatedly — **Expected:** each action reverses one at a time, back to the original image; click Redo — **Expected:** they reapply in the same order.', @baseSort2 + 6),
    (N'Browser UI', N'Screenshot Editor', N'Crop the image, then click Undo — **Expected:** undo does not restore the pre-crop image or any shapes drawn before the crop (a known limitation — cropping flattens and clears history).', @baseSort2 + 7),
    (N'Browser UI', N'Screenshot Editor', N'Click Copy — **Expected:** the edited image (including any annotations) is on the clipboard; paste it elsewhere to confirm.', @baseSort2 + 8),
    (N'Browser UI', N'Screenshot Editor', N'Click Save — **Expected:** a Save-As dialog appears for the edited image, regardless of the main Screenshot feature''s save-behavior pref (auto vs. prompt) — the editor''s Save button always prompts.', @baseSort2 + 9);
END
GO
