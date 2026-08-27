-- Adds QA checklist items for browser v1.8.58: Mail Client (IMAP) phases
-- 3-5 -- background sync, a chrome://mail inbox WebUI, and message body
-- reading -- plus a bundled ad-blocker fix (filter-list fetch response
-- cap exceeded the network loader's own hard limit).
-- See mail-client.md and changelog.md, wanderlust-knowledgebase repo,
-- for the full write-ups.
--
-- Run after add_qa_checklist_items_1.8.55_to_1.8.57.sql. Idempotent:
-- skips entirely if an "As of v1.8.58:" item already exists for the
-- "Mail Client (IMAP)" FeatureName (a bare FeatureName check would skip
-- the whole migration, since that feature already has rows from the
-- 1.8.56-1.8.57 migration). Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Mail Client (IMAP)'
      AND ItemText LIKE N'As of v1.8.58:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    -- v1.8.58: Mail Client (IMAP) phases 3-5 (background sync, chrome://mail, body reading)
    (N'Network & Downloads', N'Mail Client (IMAP)', N'As of v1.8.58: leave the browser running with a mail account configured, and send a new message to that account from elsewhere — **Expected:** within one sync interval (`custom.mail.sync_interval_seconds`, default 300s) a desktop notification appears and the mail toolbar button''s unread-count badge updates, with no manual action taken.', @baseSort + 1),
    (N'Network & Downloads', N'Mail Client (IMAP)', N'As of v1.8.58: open `chrome://mail` — **Expected:** a combined inbox across every configured account loads, newest messages first, capped at 200 total. Click "Sync now" — **Expected:** an immediate sync sweep runs and any new mail appears without waiting for the timer.', @baseSort + 2),
    (N'Network & Downloads', N'Mail Client (IMAP)', N'As of v1.8.58: click a message in `chrome://mail` — **Expected:** it opens promptly (not blocked on a sync in progress, even if one is currently running) and is marked read; click "Mark as unread" — **Expected:** it reverts to unread in the list.', @baseSort + 3),
    (N'Network & Downloads', N'Mail Client (IMAP)', N'As of v1.8.58: open a plain-text message — **Expected:** the body renders directly and is readable.', @baseSort + 4),
    (N'Network & Downloads', N'Mail Client (IMAP)', N'As of v1.8.58: open an HTML message — **Expected:** the body renders inside the message pane with remote images blocked by default and a "Load images" button that reveals them on click. **Note:** this path is still being debugged as of v1.8.58 — if it doesn''t render, that''s a known open issue, not a new regression to file (check [Mail Client (IMAP)](mail-client) for current status before reporting).', @baseSort + 5),
    -- v1.8.58: bundled ad-blocker fix (filter-list fetch response cap)
    (N'Privacy & Security', N'Filter list auto-refresh (Ad Blocker + URL Purify)', N'As of v1.8.58: force a background refresh of the EasyList/EasyPrivacy filter list (see the Ad Blocker section above for how) — **Expected:** the fetch completes and hot-swaps normally with no browser crash, even though the response is a large file (the response-size cap previously exceeded the network loader''s own hard limit, which could crash the updater).', @baseSort + 6);
END
GO
