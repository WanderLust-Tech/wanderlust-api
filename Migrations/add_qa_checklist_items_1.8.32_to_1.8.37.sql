-- Adds QA checklist template items covering the browser changes shipped in
-- v1.8.32 through v1.8.37 (see qa-testing-checklist.md and changelog.md,
-- wanderlust-knowledgebase repo, for the full write-ups):
--   1.8.32 -- chrome://terms dark mode fix + chrome://credits CSP fix
--   1.8.33 -- new chrome://settings/manageProfile page
--   1.8.34 -- RSS reader search made case-/accent-insensitive
--   1.8.35 -- Web Panels real favicons + unpin from sidebar
--   1.8.36 -- Sidebar Apps: pinned app now shows its real icon
--   1.8.37 -- on-demand "Check for updates" now actually downloads/installs
--
-- Run after seed_qa_checklist_template_items.sql and
-- add_qa_checklist_item_advanced_prefs.sql. Idempotent: skips entirely if
-- this file's rows are already present (gated on the brand-new "Manage
-- Profile" FeatureName, since that one can only ever be introduced by this
-- migration). Appends after the current max SortOrder rather than
-- interleaving/renumbering, same as add_qa_checklist_item_advanced_prefs.sql.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Manage Profile (chrome://settings/manageProfile)'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    -- 1.8.35: Web Panels favicons + unpin (Browser UI / Sidebar)
    (N'Browser UI', N'Sidebar', N'As of v1.8.35: pin a site under Web Panels that you''ve visited before (has a favicon in local history/bookmarks) — **Expected:** the pane-strip button shows that site''s real favicon instead of the generic globe icon.', @baseSort + 1),
    (N'Browser UI', N'Sidebar', N'Pin a site you''ve never visited before — **Expected:** button falls back to the generic globe icon (nothing to resolve in the local favicon DB — no network fetch is attempted).', @baseSort + 2),
    (N'Browser UI', N'Sidebar', N'As of v1.8.35: right-click a pinned Web Panel button → "Unpin from Sidebar" — **Expected:** the button disappears immediately from the sidebar itself (previously only removable via Settings → Sidebar → Web Panels).', @baseSort + 3),
    -- 1.8.36: Sidebar Apps real icon (Browser UI / Sidebar Apps)
    (N'Browser UI', N'Sidebar Apps', N'As of v1.8.36: check the pinned app''s icon in the sidebar — **Expected:** shows the actual application''s real icon (resolved via `SHGetFileInfo`), not a generic/placeholder icon.', @baseSort + 4),
    -- 1.8.34: RSS reader case-insensitive search (Content & Reading + Custom WebUI dup)
    (N'Content & Reading', N'RSS Reader', N'As of v1.8.34: search using different letter-case than the article title (e.g. a lowercase query for an uppercase-heavy title), or an accented variant of a word in the title — **Expected:** matching articles still appear (search is case- and accent-insensitive, not an exact-case substring match).', @baseSort + 5),
    (N'Custom WebUI', N'RSS Reader (chrome://reader)', N'As of v1.8.34: search using different letter-case than the article title (e.g. a lowercase query for an uppercase-heavy title), or an accented variant of a word in the title — **Expected:** matching articles still appear (search is case- and accent-insensitive, not an exact-case substring match).', @baseSort + 6),
    -- 1.8.32: chrome://terms dark mode + chrome://credits CSP (Custom WebUI / Fleet Smoke Test)
    (N'Custom WebUI', N'Custom WebUI Pages — Fleet Smoke Test', N'As of v1.8.32: switch to dark mode (OS or browser theme), then open `chrome://terms` — **Expected:** text renders light-on-dark, not white-on-white (the page previously had no background color set, so `dark:text-white` rendered invisibly on the default white canvas).', @baseSort + 7),
    (N'Custom WebUI', N'Custom WebUI Pages — Fleet Smoke Test', N'As of v1.8.32: open `chrome://credits` — **Expected:** the embedded license-text iframe (`full.html`) actually renders inside the page instead of being blocked (previously the shell''s CSP inherited Chromium''s default `child-src ''none''`, blocking the iframe before `frame-ancestors` was even consulted).', @baseSort + 8),
    -- 1.8.33: new Manage Profile page (Settings & Configuration)
    (N'Settings & Configuration', N'Manage Profile (chrome://settings/manageProfile)', N'Click the profile-menu "Edit" pencil (avatar icon → pencil) — **Expected:** navigates to `chrome://settings/manageProfile` and loads real avatar/name/theme-color controls (previously unrecognized by the Settings router, silently falling back to the "You and Wanderlust" page).', @baseSort + 9),
    (N'Settings & Configuration', N'Manage Profile (chrome://settings/manageProfile)', N'From the app menu (⋮), click "Customize profile" — **Expected:** lands on the same `manageProfile` page.', @baseSort + 10),
    (N'Settings & Configuration', N'Manage Profile (chrome://settings/manageProfile)', N'From the profile picker, click a profile card''s "Edit" option — **Expected:** lands on the same `manageProfile` page for that profile.', @baseSort + 11),
    (N'Settings & Configuration', N'Manage Profile (chrome://settings/manageProfile)', N'Change the avatar, name, or theme color on this page — **Expected:** change saves in place immediately (no Skip/Done buttons or redirect back to the profile picker — that flow is specific to the first-run `chrome://profile-customization` wizard, not this page).', @baseSort + 12),
    (N'Settings & Configuration', N'Manage Profile (chrome://settings/manageProfile)', N'Navigate directly to `chrome://settings/manageProfile` via the omnibox — **Expected:** loads normally even though it''s not reachable from the Settings left-nav.', @baseSort + 13),
    -- 1.8.37: on-demand update check now downloads/installs (Installer & Auto-Update)
    (N'Installer & Auto-Update', N'About Page — Check for Updates', N'As of v1.8.37: with an update available, let the check proceed all the way through — **Expected:** it actually downloads and installs (previously, the check would report an update was available but never call `DownloadUpdate()` — the button could only ever report availability; an update would only actually get applied by the independent background Scheduled Task/Service on its own schedule, regardless of this button).', @baseSort + 14);
END
GO
