-- Adds QA checklist items for browser v1.11.16: the Instagram Downloader's Save fallback and
-- like-status check use Instagram's current data request again (it had started returning a
-- web page instead of data), and failures now say what came back.
-- See instagram-downloader.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.15.sql. Idempotent: skips entirely if an
-- "As of v1.11.16:" item already exists for the "Instagram Downloader" FeatureName.
-- Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Instagram Downloader'
      AND ItemText LIKE N'As of v1.11.16:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Network & Downloads', N'Instagram Downloader', N'As of v1.11.16: while logged in to Instagram, open a post or reel directly in a new tab and click Save straight away, before scrolling or interacting — **Expected:** the media downloads; this is the path that asks Instagram''s data service for the post, which had stopped working (it answered with a web page instead of data).', @baseSort + 1),
    (N'Network & Downloads', N'Instagram Downloader', N'As of v1.11.16: open a post you have not opened before while the like-status badge setting is on, then open DevTools → Console on that tab — **Expected:** `[WL-IG] fallback request: POST /graphql/query …` and `[WL-IG] fallback response status: 200` lines appear, and no `Unexpected token ''<''` error.', @baseSort + 2),
    (N'Network & Downloads', N'Instagram Downloader', N'As of v1.11.16: log out of Instagram in that window, open a post and click Save — **Expected:** an alert that says why it failed (for example that you are not logged in, or that Instagram returned a web page instead of data) rather than a raw JSON parse error, and the console shows a `[WL-IG] fallback got a non-JSON response` line with the HTTP status and the start of the reply.', @baseSort + 3);
END
GO
