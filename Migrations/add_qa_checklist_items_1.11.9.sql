-- Adds QA checklist items for browser v1.11.9: the Privacy Shield bubble gets a
-- per-site ad-blocking row (toggle on/off for the exact host, "Use default" to
-- clear it), backed by the existing per-domain shields store.
-- See privacy-shield.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.8.sql. Idempotent: skips entirely if an
-- "As of v1.11.9:" item already exists for the "Privacy Shield (unified toolbar panel)"
-- FeatureName. Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Privacy Shield (unified toolbar panel)'
      AND ItemText LIKE N'As of v1.11.9:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.9: open any ordinary https website and click the shield icon — **Expected:** the bubble is taller than before and, above the seven toggles, shows an "Ad blocking on this site" row with the page''s host name; its toggle matches the global Ad Blocker switch and the text says it follows the Ad Blocker setting; nothing is cut off.', @baseSort + 1),
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.9: on a page that normally shows a non-zero "Ads blocked" count, switch the "Ad blocking on this site" toggle off — **Expected:** the row changes to "off for this site", a "Use default" link and "Reload the page to apply." appear, and the global Ad Blocker toggle is unchanged; after reloading the page the "Ads blocked" count stays at 0 and the ad-block icon does not appear in the address bar.', @baseSort + 2),
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.9: after turning ad blocking off for a site, click "Use default" and reload — **Expected:** the row goes back to following the Ad Blocker setting, the toggle matches the global switch again, and ads on that site are blocked as before.', @baseSort + 3),
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.9: switch the global Ad Blocker toggle off, then switch the per-site toggle on for one site and reload it — **Expected:** that site has its ads blocked while a different website you open still shows everything unblocked.', @baseSort + 4),
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.9: turn ad blocking off for one site and then open a different site, and also the same site under a different host name (for example www.example.com versus example.com) — **Expected:** only the exact host you changed is affected; the other site and the other host name still follow the global setting.', @baseSort + 5),
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.9: set an override for a site, close and reopen the browser, open that site and click the shield icon — **Expected:** the override is still there.', @baseSort + 6),
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.9: click the shield icon while on a chrome:// page (for example chrome://settings) and while in an incognito window — **Expected:** the "Ad blocking on this site" row is not shown; the seven toggles and the stats strip still work.', @baseSort + 7);
END
GO
