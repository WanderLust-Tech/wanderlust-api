-- Adds QA checklist items for browser v1.11.10: the Privacy Shield bubble gets
-- persisted all-time totals (ads blocked, params stripped, referrers stripped,
-- pings blocked) with a Reset link, mirrored as a one-line widget on the Focus
-- and Glass New Tab Page layouts; also checks the per-site row separator fixed
-- after v1.11.9.
-- See privacy-shield.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.9.sql. Idempotent: skips entirely if an
-- "As of v1.11.10:" item already exists for the "Privacy Shield (unified toolbar panel)"
-- FeatureName. Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Privacy Shield (unified toolbar panel)'
      AND ItemText LIKE N'As of v1.11.10:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.10: on a page where the per-site "Ad blocking on this site" row is shown, read its second line — **Expected:** it reads the host name, then a proper middle dot, then the status (for example "example.com · follows the Ad Blocker setting"), with no stray or garbled character.', @baseSort + 1),
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.10: on a profile where nothing has been blocked yet (or right after Reset), open the Privacy Shield bubble — **Expected:** below the per-tab stats strip an "All time" strip reads "nothing counted yet" with four zero counters (Ads blocked, Params stripped, Referrers, Pings blocked) and no Reset link; the bubble is taller than in v1.11.9 and nothing is cut off.', @baseSort + 2),
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.10: browse a page where the bubble''s per-tab "Ads blocked" count is non-zero, then reopen the bubble — **Expected:** the "All time" strip now reads "since" followed by today''s date, shows an Ads blocked total at least as large as the per-tab count, and a Reset link appears.', @baseSort + 3),
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.10: with a non-zero All time total, navigate to a different page and reopen the bubble — **Expected:** the per-tab strip starts again from its new page''s counts while the All time totals keep their value and only grow.', @baseSort + 4),
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.10: note the All time Ads blocked total, close and reopen the browser, then reopen the bubble — **Expected:** the totals are unchanged.', @baseSort + 5),
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.10: note the All time totals, open an incognito window, browse a page that has ads and trackers, then reopen the bubble in a normal window — **Expected:** the All time totals have not changed (private browsing is never counted).', @baseSort + 6),
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.10: click Reset in the All time strip — **Expected:** all four totals return to 0, the strip reads "nothing counted yet" and the Reset link disappears; browsing a page with ads afterwards starts counting again with a new "since" date.', @baseSort + 7),
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.10: in a build that includes the updated New Tab Page bundle, switch the layout to Focus or Glass (New Tab settings in the sidebar), make sure something has been blocked, and open a new tab — **Expected:** a quiet line under the weather reads "N blocked · since <date>" with a shield icon, and hovering it shows the four-way breakdown and a note that it is local to this device and excludes private windows.', @baseSort + 8),
    (N'Privacy & Security', N'Privacy Shield (unified toolbar panel)', N'As of v1.11.10: with that line showing, turn off "Show blocked-ads total" in the sidebar New Tab settings — **Expected:** the line disappears from the open new tab; turning it back on brings it back. The line never appears in the other layouts and does not appear at all while nothing has been counted.', @baseSort + 9);
END
GO
