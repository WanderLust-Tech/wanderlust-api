-- Adds QA checklist items for browser v1.11.14: the Ad Blocker now blocks a page's
-- own subresources (scripts, images, stylesheets, fetch/XHR) and not only
-- navigations; the engine is parsed off the UI thread (no start-up freeze);
-- blocked ad frames are blank instead of the grey error page; and blocked
-- subresources get a neutral successful response so a page cannot tell it was
-- blocked (hidden pref custom.ad_block_neutral_responses).
-- See ad-blocker.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.12.sql. Idempotent: skips entirely if an
-- "As of v1.11.14:" item already exists for the "Ad Blocker" FeatureName.
-- Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Ad Blocker'
      AND ItemText LIKE N'As of v1.11.14:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Privacy & Security', N'Ad Blocker', N'As of v1.11.14: load an ad-heavy news page (for example `https://www.bbc.com/news` or `https://edition.cnn.com`) with the ad blocker on and open DevTools → Network — **Expected:** third-party ad/analytics scripts, `fetch`/XHR calls and images are no longer fetched (previously only iframes and pop-ups were blocked), the omnibox ad-block badge lists many more blocked hosts, and the page still loads and renders normally. Blocked scripts, `fetch`/XHR, stylesheets and images appear as ordinary 200 responses with an empty or `{}` body (not `(blocked:other)`); fonts, media and page navigations still show `(blocked:other)`.', @baseSort + 1),
    (N'Privacy & Security', N'Ad Blocker', N'As of v1.11.14: on that page, open the Privacy Shield bubble — **Expected:** the "Ads blocked" count for the page and the "All time" ads-blocked total both increase by roughly the number of blocked requests (before this version they counted almost nothing).', @baseSort + 2),
    (N'Privacy & Security', N'Ad Blocker', N'As of v1.11.14: quit the browser completely, start it, and immediately use the window (open a menu, switch tabs, open a page) — **Expected:** the browser stays responsive right after launch (no ~2-second freeze), and a page opened straight away still has its ads blocked.', @baseSort + 3),
    (N'Privacy & Security', N'Ad Blocker', N'As of v1.11.14: open a page that embeds an ad iframe (for example a news article with a banner slot) — **Expected:** the ad frame is a blank area, not Chromium''s grey "sad face" error page; a blocked image shows nothing, not a broken-image icon.', @baseSort + 4),
    (N'Privacy & Security', N'Ad Blocker', N'As of v1.11.14: in Privacy Shield, switch ad blocking off for one site only (the per-site row) and reload it — **Expected:** that site''s ad scripts and images load normally, while a different site is still blocked.', @baseSort + 5),
    (N'Privacy & Security', N'Ad Blocker', N'As of v1.11.14: in DevTools → Console on an ad-heavy news page with the blocker on — **Expected:** no wall of new red errors (a handful of the site''s own tracker complaints at most), and no "Unexpected end of JSON input" errors on `nytimes.com`.', @baseSort + 6),
    (N'Privacy & Security', N'Ad Blocker', N'As of v1.11.14: close the browser, set `"custom": {"ad_block_neutral_responses": false}` in the profile''s `Preferences` file, restart and reload an ad-heavy page — **Expected:** blocked scripts, `fetch`/XHR, stylesheets and images now show `(blocked:other)` in DevTools again (plain errors instead of empty 200s).', @baseSort + 7);
END
GO
