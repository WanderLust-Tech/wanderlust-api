-- Adds QA checklist items for browser v1.11.17: the Instagram Downloader's Save fallback and
-- like-status check ask Instagram's media-info endpoint (the GraphQL request they used had
-- started returning a web page instead of data), and failures now say what came back.
-- See instagram-downloader.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.16.sql. Idempotent: skips entirely if an
-- "As of v1.11.17:" item already exists for the "Instagram Downloader" FeatureName.
-- Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Instagram Downloader'
      AND ItemText LIKE N'As of v1.11.17:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Network & Downloads', N'Instagram Downloader', N'As of v1.11.17: while logged in to Instagram, open a post or reel directly in a new tab and click Save straight away, before scrolling or interacting — **Expected:** the media downloads. In DevTools → Console on that tab, `[WL-IG] media info request: GET https://www.instagram.com/api/v1/media/<number>/info/` followed by `media info response status: 200` appear; this is the path that asks Instagram''s data service for the post, which had stopped working (it answered with a web page instead of data).', @baseSort + 1),
    (N'Network & Downloads', N'Instagram Downloader', N'As of v1.11.17: open a post you have not opened before while the like-status badge setting is on, then open DevTools → Console on that tab — **Expected:** the same `[WL-IG] media info request` and `media info response status: 200` lines appear, and no `Unexpected token ''<''` error.', @baseSort + 2),
    (N'Network & Downloads', N'Instagram Downloader', N'As of v1.11.17: log out of Instagram in that window, open a post and click Save — **Expected:** either the media downloads (a public post can still be read from its page) or an alert that says why it failed (for example `Instagram rejected the request (login_required)`), never a raw JSON parse error; the console shows what came back under `[WL-IG]`.', @baseSort + 3);
END
GO
