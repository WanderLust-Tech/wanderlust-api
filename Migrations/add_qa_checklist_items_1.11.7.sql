-- Adds QA checklist items for browser v1.11.7: the Mail client now runs one
-- extra sync shortly after the machine resumes from sleep or the network comes
-- back after being down, rate-limited so a flapping connection cannot cause a
-- burst of IMAP logins.
-- See mail-client.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.6.sql. Idempotent: skips entirely if
-- an "As of v1.11.7:" item already exists for the "Mail Client (IMAP)"
-- FeatureName. Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Mail Client (IMAP)'
      AND ItemText LIKE N'As of v1.11.7:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Network & Downloads', N'Mail Client (IMAP)', N'As of v1.11.7: with a mail account configured, put the computer to sleep for longer than the sync interval (default 5 minutes), send a message to the account while it sleeps, then wake it — **Expected:** within roughly 15–20 seconds of waking, the mail toolbar badge and/or the desktop notification update on their own, without clicking **Sync now** and without waiting for the next poll.', @baseSort + 1),
    (N'Network & Downloads', N'Mail Client (IMAP)', N'As of v1.11.7: turn the network off (for example disable Wi-Fi), wait for at least one poll interval to pass, send a message to the account from elsewhere, then turn the network back on — **Expected:** the new mail shows up roughly 10–20 seconds after the connection returns, even if the poll that ran while offline failed (a sweep that failed offline does not delay the catch-up sync).', @baseSort + 2),
    (N'Network & Downloads', N'Mail Client (IMAP)', N'As of v1.11.7: with a mail account configured, switch the network off and on five or more times within a minute — **Expected:** no burst of logins; at most one extra sync runs in any three-minute window (check the mail server''s connection/IMAP log if you have access). The regular poll timer keeps running as before.', @baseSort + 3);
END
GO
