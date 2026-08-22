-- Brings QaChecklistTemplateItems up to date for browser v1.8.49: ping/beacon
-- blocking, plus the resulting 7th toggle / 5th stat cell in the Privacy
-- Shield bubble. See security-privacy-features.md, privacy-shield.md, and
-- changelog.md, wanderlust-knowledgebase repo, for the full write-up.
--
-- Run after add_qa_checklist_items_1.8.48.sql. Idempotent: the UPDATE only
-- fires if the row still has its old (six-toggle/four-stat) text, and the
-- INSERT block is gated on the brand-new "Ping/Beacon Blocking" FeatureName.

UPDATE QaChecklistTemplateItems
SET ItemText = N'Click the shield icon — **Expected:** as of v1.8.49, bubble opens showing seven toggle rows and a 5-cell stats strip (Ads blocked / Params stripped / Referrers stripped / Pings blocked / Trackers on page) — previously six toggles and four stats.'
WHERE Category = N'Privacy & Security'
  AND FeatureName = N'Privacy Shield (unified toolbar panel)'
  AND ItemText = N'Click the shield icon — **Expected:** bubble opens showing six toggle rows and a 4-cell stats strip (Ads blocked / Params stripped / Referrers stripped / Trackers on page).';

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Ping/Beacon Blocking'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Privacy & Security', N'Ping/Beacon Blocking', N'Enable "Block Ping/Beacon" with an empty exceptions list, then visit a page that fires `navigator.sendBeacon(...)` (or run `navigator.sendBeacon(''https://example.com/x'', ''y'')` in DevTools console on any page) — **Expected:** DevTools → Network shows the beacon request blocked (`(blocked:other)`).', @baseSort + 1),
    (N'Privacy & Security', N'Ping/Beacon Blocking', N'Add the destination host to the exceptions list and repeat — **Expected:** the beacon request now succeeds for that host only.', @baseSort + 2),
    (N'Privacy & Security', N'Ping/Beacon Blocking', N'With the feature enabled, open the Privacy Shield bubble and trigger a blocked ping/beacon — **Expected:** the "Pings blocked" stat increments live for the current tab.', @baseSort + 3),
    (N'Privacy & Security', N'Ping/Beacon Blocking', N'Add a per-domain override for one site (via whatever per-domain shields UI is exposed) that flips this feature opposite to the global toggle — **Expected:** that site''s ping/beacon requests behave per the override, not the global setting.', @baseSort + 4),
    (N'Privacy & Security', N'Ping/Beacon Blocking', N'Disable the feature globally — **Expected:** `<a ping>`/`sendBeacon()` requests succeed normally everywhere (except any per-domain override still forcing them blocked).', @baseSort + 5);
END
GO
