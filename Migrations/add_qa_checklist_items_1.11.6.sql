-- Adds QA checklist items for browser v1.11.6: the new Domain Mirror feature,
-- Smart Proxy Routing PAC validation + Ask mode ("can't reach this site, use
-- your proxy?" bar), and the Windows taskbar unread badge / flash for the
-- Mail client.
-- See domain-mirror.md, smart-proxy-routing.md, mail-client.md and
-- changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.5.sql. Idempotent: the Domain Mirror
-- block is skipped if that FeatureName already exists; the Smart Proxy Routing
-- and Mail Client blocks are each skipped if an "As of v1.11.6:" item already
-- exists for their FeatureName. Each block appends after the current max
-- SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Domain Mirror'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Privacy & Security', N'Domain Mirror', N'Open Settings → Privacy and security → Domain Mirror, click **+ Add redirect**, enter `example.com` → `example.org` and Save — **Expected:** the rule appears in the list immediately, no restart needed.', @baseSort + 1),
    (N'Privacy & Security', N'Domain Mirror', N'Open `https://www.example.com/some/path?q=1` — **Expected:** the tab lands on `https://www.example.org/some/path?q=1` (subdomain, path and query are carried over) and a bar reads "Redirected www.example.com to www.example.org." with **Open original** and **Dismiss** buttons.', @baseSort + 2),
    (N'Privacy & Security', N'Domain Mirror', N'Click **Open original** — **Expected:** the original `www.example.com` page loads, and opening it again during the same browser session is no longer redirected. Restart the browser and open it once more — **Expected:** the redirect applies again.', @baseSort + 3),
    (N'Privacy & Security', N'Domain Mirror', N'Open `https://notexample.com/` — **Expected:** not redirected (matching is on whole domain labels, not a text suffix).', @baseSort + 4),
    (N'Privacy & Security', N'Domain Mirror', N'Switch a rule''s toggle off — **Expected:** `example.com` is no longer redirected. Switch it back on — **Expected:** redirecting resumes.', @baseSort + 5),
    (N'Privacy & Security', N'Domain Mirror', N'Turn off **Tell me when a page was redirected**, then repeat the `www.example.com` visit — **Expected:** the redirect still happens but no bar appears.', @baseSort + 6),
    (N'Privacy & Security', N'Domain Mirror', N'Try adding invalid rules: a source of `localhost`; a destination of `https://example.org/x`; the loop `a.test` → `a.test`; and the chain `a.test` → `b.test` followed by `b.test` → `c.test` — **Expected:** each is rejected with a red message above the list and nothing is saved.', @baseSort + 7),
    (N'Privacy & Security', N'Domain Mirror', N'Open `https://example.com` in an Incognito window — **Expected:** the same redirect applies.', @baseSort + 8);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Smart Proxy Routing'
      AND ItemText LIKE N'As of v1.11.6:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Network & Downloads', N'Smart Proxy Routing', N'As of v1.11.6: add a rule whose pattern contains a double quote, e.g. `bad"host` — **Expected:** it is rejected with a red message and not saved, and browsing keeps working (previously a script-breaking rule could block every page).', @baseSort + 1),
    (N'Network & Downloads', N'Smart Proxy Routing', N'As of v1.11.6: add a rule `*.httpbin.org` with the proxy typed as plain `127.0.0.1:8888` (no `PROXY` prefix) and turn routing on — **Expected:** it is accepted, `chrome://net-internals/#proxy` shows `return "PROXY 127.0.0.1:8888"` for that pattern, and traffic to the domain goes through the proxy (a bare `host:port` previously went direct without any error).', @baseSort + 2),
    (N'Network & Downloads', N'Smart Proxy Routing', N'As of v1.11.6: edit a rule''s proxy to `HTTP 127.0.0.1:8888` — **Expected:** it is accepted and appears in the generated PAC as `PROXY 127.0.0.1:8888`.', @baseSort + 3),
    (N'Network & Downloads', N'Smart Proxy Routing', N'As of v1.11.6: add a rule `*.example.com` with a working proxy and set **When to use the proxy** to *Ask me when a matching site can''t be reached*, with routing on — **Expected:** the PAC at `chrome://net-internals/#proxy` has no clause for that rule, and the status bubble''s active-rule count does not include it.', @baseSort + 4),
    (N'Network & Downloads', N'Smart Proxy Routing', N'As of v1.11.6: with that ask-mode rule in place, open `https://does-not-exist.example.com/` (a name that does not resolve) — **Expected:** the error page appears together with a bar "Can''t connect to does-not-exist.example.com. Try again through your proxy?" with **Use proxy** and **Not now** buttons.', @baseSort + 5),
    (N'Network & Downloads', N'Smart Proxy Routing', N'As of v1.11.6: click **Use proxy** — **Expected:** the page reloads after a moment, and the PAC now contains a temporary clause for `example.com` and its subdomains.', @baseSort + 6),
    (N'Network & Downloads', N'Smart Proxy Routing', N'As of v1.11.6: close the tab where you clicked **Use proxy** — **Expected:** the temporary `example.com` clause disappears from the PAC (the permission only lasts while that tab is open).', @baseSort + 7),
    (N'Network & Downloads', N'Smart Proxy Routing', N'As of v1.11.6: repeat the unreachable-site visit with routing switched off, and again in an Incognito window — **Expected:** no proxy bar appears in either case.', @baseSort + 8);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Mail Client (IMAP)'
      AND ItemText LIKE N'As of v1.11.6:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Network & Downloads', N'Mail Client (IMAP)', N'As of v1.11.6 (Windows): with unread mail in a configured account, look at the browser''s taskbar button — **Expected:** a numeric badge shows the total unread count (shown as 99+ above 99). It updates after a sync or after reading messages in `chrome://mail`, and disappears when the count reaches 0.', @baseSort + 1),
    (N'Network & Downloads', N'Mail Client (IMAP)', N'As of v1.11.6 (Windows): in Settings → Mail accounts → Taskbar, turn off **Show unread count on the taskbar icon** — **Expected:** the badge clears immediately; turning it back on restores it.', @baseSort + 2),
    (N'Network & Downloads', N'Mail Client (IMAP)', N'As of v1.11.6 (Windows): turn on **Flash the taskbar icon on new mail**, switch to another application, then send a message to the account — **Expected:** after the next sync the browser''s taskbar button flashes until you bring the window to the foreground. With the toggle off (the default) it does not flash.', @baseSort + 3);
END
GO
