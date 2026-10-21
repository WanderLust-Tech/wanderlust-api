-- Adds QA checklist items for browser v1.11.15: PIN gate on chrome://downloads Remove /
-- Clear all and a working PIN prompt on the history and sidebar pages; Connection
-- Control, Content Policy, ping/beacon blocking, referrer stripping, the tracking
-- dashboard feed and per-site UA overrides now apply to a page's own subresources;
-- a Frames-only Content Policy rule blocks top-level visits; and starting the
-- browser with a URL no longer crashes.
-- See parental-controls, content-policy-chain, privacy-guard, tracking-dashboard
-- and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.14.sql. Idempotent: skips entirely if an
-- "As of v1.11.15:" item already exists for the Parental Controls FeatureName.
-- Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Parental Controls (PIN Lock & Website Restrictions)'
      AND ItemText LIKE N'As of v1.11.15:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'As of v1.11.15: set a PIN, switch Parental Controls on and press "Lock now", then open `chrome://downloads` (with at least one download listed) and click "Clear all" — **Expected:** nothing is removed and a PIN prompt appears; a wrong PIN shows an error, the right PIN closes the prompt and the "Clear all" then runs by itself (the list empties) without a second click. Before this version "Clear all" worked without any PIN.', @baseSort + 1),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'As of v1.11.15: while still locked, click "Remove" on a single download in `chrome://downloads` — **Expected:** the same PIN prompt; the entry stays listed until the correct PIN is entered, and Cancel leaves it in place.', @baseSort + 2),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'As of v1.11.15: while locked, delete an entry on `chrome://history` and again in the sidebar''s History panel, and enter the correct PIN in the prompt — **Expected:** the prompt accepts the PIN (before this version it never answered, so the history prompt could not be unlocked) and the deletion then goes through.', @baseSort + 3),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'As of v1.11.15 (by design): while locked, delete a bookmark (bookmarks page or sidebar) — **Expected:** it is deleted without a PIN prompt; only history, download-history erasure and the protected settings are PIN-gated.', @baseSort + 4),
    (N'Privacy & Security', N'Connection Control', N'As of v1.11.15: with a rule that denies the private network, open an `http://` page such as `http://neverssl.com`, and in the DevTools console run `new Image().src = ''http://192.168.0.1/x.png''` — **Expected:** the request appears in DevTools → Network as blocked (`ERR_BLOCKED_BY_CLIENT`); before this version only navigating to the address directly was blocked, not a page''s own images, scripts and `fetch()` calls.', @baseSort + 5),
    (N'Privacy & Security', N'Referrer Control', N'As of v1.11.15: with referrer stripping on, open a news page, then DevTools → Network and click a third-party image or script — **Expected:** its request headers have no `Referer` (before this version a page''s own subresource requests still sent one; only navigations were stripped).', @baseSort + 6),
    (N'Privacy & Security', N'Ping/Beacon Blocking', N'As of v1.11.15: with ping/beacon blocking on, in the DevTools console of any page run `navigator.sendBeacon(''https://example.com/x'', ''a'')` — **Expected:** DevTools → Network shows the request as blocked (`ERR_BLOCKED_BY_CLIENT`) instead of being sent; before this version the beacon went out.', @baseSort + 7),
    (N'Privacy & Security', N'Tracking Relationship Dashboard', N'As of v1.11.15: browse a news page that loads third-party content, then open `chrome://tracking-dashboard` — **Expected:** the third-party hosts that page contacted are listed under the page''s site (before this version a page''s own third-party scripts and images were not recorded).', @baseSort + 8),
    (N'Privacy & Security', N'Content Policy Chain', N'As of v1.11.15: turn Content Policy on and add a block rule for `upload.wikimedia.org` with only "Images" ticked, then open `https://en.wikipedia.org/wiki/Cat` — **Expected:** the article text loads but its images from that host do not (before this version a rule never blocked a page''s own images, scripts or `fetch()`/XHR calls).', @baseSort + 9),
    (N'Privacy & Security', N'Content Policy Chain', N'As of v1.11.15: replace that rule with a block rule for `example.com` with only "Frames" ticked, then type `example.com` in the address bar — **Expected:** the "is blocked" error page appears (before this version a Frames-only rule blocked iframes but not a direct visit).', @baseSort + 10),
    (N'Privacy & Security', N'User-Agent Overrides', N'As of v1.11.15: add an override for a site (for example `*.example.com` with a recognisable UA string), open a page on it, and in DevTools → Network click an image or script served from that same host — **Expected:** its `User-Agent` request header is the override (before this version only the page''s own navigation used it).', @baseSort + 11),
    (N'Installer & Auto-Update', N'Launch With a URL (Command Line / Default Browser)', N'As of v1.11.15: quit Wanderlust completely (no `Wanderlust.exe` left in Task Manager), then run `"<install folder>\Wanderlust.exe" https://example.com` from a command prompt — **Expected:** the browser starts and opens example.com. Before this version it exited immediately (illegal-instruction crash) whenever it was started with a URL and no instance was running.', @baseSort + 12),
    (N'Installer & Auto-Update', N'Launch With a URL (Command Line / Default Browser)', N'As of v1.11.15: with Wanderlust set as the default browser and not running, click an `http(s)` link in another app (for example in an email or a `.url` shortcut) — **Expected:** the browser starts and opens that link.', @baseSort + 13);
END
GO
