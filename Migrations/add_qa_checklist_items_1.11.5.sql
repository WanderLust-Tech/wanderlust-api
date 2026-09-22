-- Adds QA checklist items for browser v1.11.5: two Picture-in-Picture
-- Hover Button fixes -- the floating button disappearing before the
-- user's cursor reached it (hide-timer started too early by a site's own
-- overlay controls occluding the <video> element), and a real
-- "Cannot read properties of null (reading 'appendChild')" crash from
-- document.documentElement transiently being null around navigation
-- commit.
-- See picture-in-picture-button.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.4.sql. Idempotent: skips entirely
-- if an "As of v1.11.5:" item already exists for the "Picture-in-Picture
-- Hover Button" FeatureName. Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Picture-in-Picture Hover Button'
      AND ItemText LIKE N'As of v1.11.5:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Browser UI', N'Picture-in-Picture Hover Button', N'As of v1.11.5: hover a video on a site with its own player controls overlaid near the video''s top-right corner (e.g. a settings/fullscreen icon in roughly the same spot this button appears), then move the cursor from the video toward the button, passing over that overlay along the way — **Expected:** the button stays visible the whole time and doesn''t disappear before the cursor reaches it (previously the button''s hide-timer was started by the video''s own `mouseleave` firing the instant the cursor crossed onto the site''s overlay, even though it never visually left the video).', @baseSort + 1),
    (N'Browser UI', N'Picture-in-Picture Hover Button', N'As of v1.11.5: browse normally across several page navigations with DevTools console open — **Expected:** no `Cannot read properties of null (reading ''appendChild'')` error appears (previously `document.documentElement` could transiently be null right around when a navigation committed, crashing the button''s setup script).', @baseSort + 2);
END
GO
