-- Adds/updates QA checklist items for browser v1.8.61-1.8.63:
--   1.8.61 -- fixes the undocked sidebar's auto-hide peek strip being
--             stuck at ~37px instead of 4px (leftover WS_CAPTION/
--             WS_SYSMENU window styles), plus two related bugs: the
--             widget could get stuck permanently "engaged", and
--             reveal-on-hover could pick the wrong monitor
--   1.8.62 -- a never-visited Web Panels pin now falls back to fetching
--             a real favicon from Google's favicon service instead of
--             always showing the generic globe icon
--   1.8.63 -- Settings -> Sidebar's Web Panels list now updates live
--             when a panel is unpinned from the sidebar itself, not
--             just when removed from Settings
-- See changelog.md, wanderlust-knowledgebase repo, for the full write-ups.
--
-- Run after add_qa_checklist_items_1.8.60.sql. Idempotent: the UPDATE only
-- fires if the row still has its old (network-fetch-not-attempted) text,
-- and the INSERT block is gated on the v1.8.61 peek-strip item not already
-- being present.

UPDATE QaChecklistTemplateItems
SET ItemText = N'As of v1.8.62: pin a site you''ve never visited before (no favicon in local history/bookmarks) — **Expected:** the pane-strip button still shows a real favicon, fetched from Google''s favicon service as a fallback and resized to match the normal 16x16 size (previously it fell back to the generic globe icon with no network fetch attempted).'
WHERE Category = N'Browser UI'
  AND FeatureName = N'Sidebar'
  AND ItemText = N'Pin a site you''ve never visited before — **Expected:** button falls back to the generic globe icon (nothing to resolve in the local favicon DB — no network fetch is attempted).';

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Sidebar'
      AND ItemText LIKE N'As of v1.8.61:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    -- v1.8.61: undocked sidebar peek-strip width + related auto-hide/reveal bugs
    (N'Browser UI', N'Sidebar', N'As of v1.8.61: leave the undocked widget idle to auto-hide, then compare the peek strip''s width against the docked pane-button strip — **Expected:** peek strip is genuinely ~4px wide (previously Windows silently enforced a much wider ~37px minimum because leftover caption/system-menu window styles weren''t stripped from the frameless widget''s native window).', @baseSort + 1),
    (N'Browser UI', N'Sidebar', N'As of v1.8.61: drag the undocked widget to reposition it, then leave it idle — **Expected:** it still auto-hides normally afterward (previously the drag''s raw window-activation event could permanently stick it "engaged"/never auto-hiding).', @baseSort + 2),
    (N'Browser UI', N'Sidebar', N'As of v1.8.61: on a multi-monitor setup, move the undocked widget near an edge on a non-primary monitor, let it auto-hide, then hover to reveal it — **Expected:** it reveals on the same monitor it was snapped to (previously reveal-on-hover could re-match against the wrong monitor).', @baseSort + 3),
    -- v1.8.63: Settings Web Panels list live-updates on sidebar-driven unpin
    (N'Browser UI', N'Sidebar', N'As of v1.8.63: with Settings → Sidebar open and showing the Web Panels list, right-click a pinned Web Panel button in the sidebar itself → "Unpin from Sidebar" — **Expected:** the open Settings page''s Web Panels list updates immediately to remove it, with no manual page refresh needed.', @baseSort + 4);
END
GO
