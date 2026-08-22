-- Brings QaChecklistTemplateItems up to date through browser v1.8.45 (see
-- qa-testing-checklist.md and changelog.md, wanderlust-knowledgebase repo,
-- for the full write-ups). Two parts:
--
--   1. UPDATEs — corrects two Fleet Smoke Test rows that overclaimed real
--      functionality for chrome://certificate-manager and chrome://tab-search;
--      both are confirmed stubs (static placeholder content, no backend).
--   2. INSERTs — new coverage for: real chrome://history/chrome://bookmarks
--      backends + their v1.8.41 viewport fix (1.8.40/1.8.41), a new
--      Parental Controls PIN Lock & Website Restrictions section
--      (1.8.42-1.8.44), the sidebar icon rail theme-color fix (1.8.45), and
--      a v1.8.39 dark/light-mode contrast sweep spot-check.
--
-- Run after add_qa_checklist_item_1.8.38.sql. Idempotent: the UPDATEs only
-- fire if the row still has its old (stale) text, and the INSERT block is
-- gated on the brand-new "Parental Controls (PIN Lock & Website Restrictions)"
-- FeatureName, since that can only ever be introduced by this migration.

-- === Part 1: corrections ===

UPDATE QaChecklistTemplateItems
SET ItemText = N'`chrome://certificate-manager` — **Expected (as of this writing, still a stub):** the page loads a static placeholder card reading roughly "not wired up yet," directing you to the OS certificate store — **no real certificate list loads**. If a real list ever does load, this line needs updating to describe the working feature.'
WHERE Category = N'Custom WebUI'
  AND FeatureName = N'Custom WebUI Pages — Fleet Smoke Test'
  AND ItemText = N'`chrome://certificate-manager` — **Expected:** certificate list loads.';

UPDATE QaChecklistTemplateItems
SET ItemText = N'`chrome://tab-search` — **Expected (as of this writing, still a stub):** the toolbar button opens the bubble correctly (real top-chrome surface, no crash), but the search input is disabled and shows "not wired up yet" — **no real tab list, no search.** If real search ever ships, this line needs updating.'
WHERE Category = N'Custom WebUI'
  AND FeatureName = N'Custom WebUI Pages — Fleet Smoke Test'
  AND ItemText = N'`chrome://tab-search` — **Expected:** loads and searches open tabs.';

-- === Part 2: new coverage ===

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Parental Controls (PIN Lock & Website Restrictions)'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    -- v1.8.40/1.8.41: real chrome://history / chrome://bookmarks backends + viewport fix
    (N'Custom WebUI', N'Custom WebUI Pages — Fleet Smoke Test', N'As of v1.8.40: on `chrome://history`, search by a title/URL term, then filter by date range and by a specific host — **Expected:** each filter narrows results live (real `HistoryService`-backed query, not a static list); select several rows and batch-delete — **Expected:** they disappear immediately and the page updates live without a manual reload.', @baseSort + 1),
    (N'Custom WebUI', N'Custom WebUI Pages — Fleet Smoke Test', N'As of v1.8.40: on `chrome://bookmarks`, add a folder and a bookmark, rename each, then drag a bookmark into a different folder and reorder it within that folder — **Expected:** the tree reflects every change immediately (real `BookmarkModel` CRUD + drag-and-drop, not a static tree); rapid multi-node changes (e.g. a drag touching several nodes) collapse into a single UI update rather than flickering per node.', @baseSort + 2),
    (N'Custom WebUI', N'Custom WebUI Pages — Fleet Smoke Test', N'As of v1.8.41: open either page in dark mode at a narrow-ish window width — **Expected:** the background fills the full viewport edge-to-edge, no white/light bars in the margins outside the centered content column (previously the background color was applied to the same element as the centering classes, so the margins fell through to the unstyled body).', @baseSort + 3),
    -- v1.8.39: dark/light-mode contrast sweep
    (N'Custom WebUI', N'Custom WebUI Pages — Fleet Smoke Test', N'As of v1.8.39: in dark mode, spot-check `chrome://history`, `chrome://bookmarks`, `chrome://certificate-manager`, `chrome://chrome-urls`, `chrome://tab-search`, and `chrome://print` — **Expected:** all render with a proper dark background (no white-text-on-white-page); also check several `chrome://settings` sub-pages and `chrome://password-manager` for illegible dark-on-dark secondary/body text or an unstyled `<h2>` page title — none should appear (a full sweep across ~30+ files fixed exactly this pattern in one pass).', @baseSort + 4),
    (N'Custom WebUI', N'Custom WebUI Pages — Fleet Smoke Test', N'As of v1.8.39: check the Profile menu''s Account page (`AccountPage.tsx`) in **light** mode, and the sidebar''s Notes panel in both light and dark mode — **Expected:** Account page text is legible in light mode (it was previously written dark-theme-only and washed out); Notes panel text isn''t too light for light mode *and* too dark for dark mode at the same time (a previously fully-inverted color pairing).', @baseSort + 5),
    -- v1.8.45: sidebar icon rail theme colors
    (N'Browser UI', N'Sidebar', N'As of v1.8.45: switch between a couple of different browser themes (or light/dark mode) and look at the Bookmarks, History, RSS, Page Notes, both Settings, and Expand/Collapse icons in the pane strip — **Expected:** all of them recolor to match the active theme, consistent with the Agent/Recently-Closed/Dock-toggle icons in the same strip (previously these six were hardcoded flat-color raster PNGs that never recolored and visually stood out). Also confirm Page Notes shows its own distinct icon, not History''s icon reused.', @baseSort + 6),
    -- v1.8.42-1.8.44: Parental Controls PIN Lock & Website Restrictions
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'Open Settings → Parental Controls and set a PIN — **Expected:** the feature enables and unlocks immediately (you already know the PIN you just set).', @baseSort + 7),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'With Parental Controls enabled, wait past 10 minutes of inactivity (or restart the browser, which always starts locked), then try to delete a history entry on `chrome://history` — **Expected:** the delete is blocked and a PIN prompt appears instead of the entry disappearing.', @baseSort + 8),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'Enter the correct PIN — **Expected:** the entry deletes, and further history deletes and the "Clear browsing data on exit" toggle group work without re-prompting for the next 10 minutes of activity.', @baseSort + 9),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'Try deleting an entry from the sidebar''s History panel while locked — **Expected:** same PIN gate as `chrome://history` (independent gate, same behavior).', @baseSort + 10),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'Try toggling "Clear browsing data on exit" in Settings while locked — **Expected:** also PIN-gated.', @baseSort + 11),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'Click "Change PIN" and enter the current PIN plus a new one — **Expected:** succeeds; the old PIN no longer works, the new one does.', @baseSort + 12),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'Click "Forgot PIN?" — **Expected:** a real OS-level reauth prompt (Windows Hello or platform equivalent) appears; on success, you can set a brand-new PIN without knowing the old one.', @baseSort + 13),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'Turn Parental Controls off (requires the current PIN) — **Expected:** all gates stop applying; history deletes and the clear-on-exit toggle work with no PIN prompt.', @baseSort + 14),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'As of v1.8.43: with Parental Controls enabled, add a domain to the blocklist (e.g. `example.com`) and navigate to it — **Expected:** the top-level navigation is blocked (`ERR_BLOCKED_BY_CLIENT`); a subdomain (`www.example.com`) is blocked too, but an unrelated site loads normally.', @baseSort + 15),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'Switch to allowlist mode with one domain listed, then visit that domain and a different one — **Expected:** the listed domain loads, the other is blocked.', @baseSort + 16),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'Enable "Force SafeSearch" and search on Google or Bing — **Expected:** results are filtered (`safe=active`/`ssui=on` present on the request).', @baseSort + 17),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'Enable "YouTube Restricted Mode" (Moderate or Strict) and browse YouTube — **Expected:** restricted-mode behavior applies.', @baseSort + 18),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'As of v1.8.44: with a blocklist/allowlist configured, disable Parental Controls entirely (current PIN required) — **Expected:** previously-blocked sites now load normally — this used to silently keep enforcing the domain list even after the whole feature was turned off.', @baseSort + 19),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'Re-enable Parental Controls with a new PIN after having disabled it with a domain list configured — **Expected:** restriction mode comes back as "Off," not silently re-armed with the old list (disabling resets the mode).', @baseSort + 20);
END
GO
