-- Adds QA checklist template items for v1.8.48: the new site-wide
-- Picture-in-Picture hover button for videos. See
-- picture-in-picture-button.md and changelog.md, wanderlust-knowledgebase
-- repo, for the full write-up.
--
-- Run after update_qa_checklist_items_1.8.47.sql. Idempotent: skips
-- entirely if this feature's rows are already present (gated on the
-- brand-new FeatureName, which can only ever be introduced by this
-- migration). Appends after the current max SortOrder, same as the prior
-- QA-item migrations.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Picture-in-Picture Hover Button'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Content & Reading', N'Picture-in-Picture Hover Button', N'Hover over a reasonably large (80×80px or bigger) `<video>` on any site — **Expected:** a small floating button appears over the top-right of the video within a moment.', @baseSort + 1),
    (N'Content & Reading', N'Picture-in-Picture Hover Button', N'Click the button — **Expected:** the video enters native Picture-in-Picture (a separate always-on-top mini window).', @baseSort + 2),
    (N'Content & Reading', N'Picture-in-Picture Hover Button', N'Hover the same video again while it''s in PiP — **Expected:** the button''s tooltip reads "Exit picture in picture"; clicking it exits PiP.', @baseSort + 3),
    (N'Content & Reading', N'Picture-in-Picture Hover Button', N'Move the mouse from the video onto the button itself (not away) — **Expected:** the button stays visible (doesn''t flicker/hide) while the cursor is over it.', @baseSort + 4),
    (N'Content & Reading', N'Picture-in-Picture Hover Button', N'Move the mouse away from both the video and the button — **Expected:** the button hides after a brief delay (~250ms), not instantly.', @baseSort + 5),
    (N'Content & Reading', N'Picture-in-Picture Hover Button', N'Hover a very small video (well under 80×80px, e.g. a thumbnail-sized `<video>`) — **Expected:** no button appears.', @baseSort + 6),
    (N'Content & Reading', N'Picture-in-Picture Hover Button', N'On a site using client-side routing (an SPA) or infinite scroll, navigate/scroll to reveal a video that wasn''t present on initial page load — **Expected:** hovering it still shows the button, with no full-page reload needed.', @baseSort + 7),
    (N'Content & Reading', N'Picture-in-Picture Hover Button', N'Hover a `<video>` with the `disablePictureInPicture` attribute set (test page or DevTools-added attribute) — **Expected:** no button ever appears for that video.', @baseSort + 8),
    (N'Content & Reading', N'Picture-in-Picture Hover Button', N'Turn the Settings toggle off, then reload a page with video — **Expected:** no button appears on hover anywhere on the page.', @baseSort + 9),
    (N'Content & Reading', N'Picture-in-Picture Hover Button', N'Turn the toggle back on and reload — **Expected:** the button returns.', @baseSort + 10);
END
GO
