-- Adds QA checklist items for browser v1.8.55-1.8.57:
--   1.8.55 -- fixes a clipboard-copy crash in Screenshot / Page Capture's
--             region mode on non-full-width crops (extractSubset()
--             stride mismatch vs. the Windows clipboard writer)
--   1.8.56 -- Mail Client (IMAP) foundation: Settings account
--             management (add/remove IMAP accounts, verified against
--             the real server), no inbox UI yet
--   1.8.57 -- Mail Client phase 2: structured FETCH parsing + SQLite
--             message store -- storage layer only, not wired to any
--             user-visible flow, so no additional manual QA item
-- See mail-client.md and changelog.md, wanderlust-knowledgebase repo,
-- for the full write-ups.
--
-- Run after add_qa_checklist_items_1.8.53_to_1.8.54.sql. Idempotent:
-- skips entirely if the brand-new "Mail Client (IMAP)" FeatureName is
-- already present. Appends after the current max SortOrder, same as
-- the prior QA-item migrations.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Mail Client (IMAP)'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    -- v1.8.55: screenshot region-crop clipboard crash fix
    (N'Browser UI', N'Screenshot & Page Capture', N'As of v1.8.55: drag a region that is narrower than the full visible viewport (i.e. not full-width), then either let it auto-copy to clipboard or paste after — **Expected:** no crash, and pasting elsewhere produces exactly the cropped region, not garbled/corrupted image data (previously any non-full-width crop crashed on copy due to a stride mismatch).', @baseSort + 1),
    -- v1.8.56-1.8.57: Mail Client (IMAP) foundation
    (N'Network & Downloads', N'Mail Client (IMAP)', N'Open Settings -> Mail accounts, and add a real IMAP account (valid host/port/username/password) — **Expected:** the Add action blocks briefly (real server round-trip), then the account appears in the list with no password visible anywhere in the UI.', @baseSort + 2),
    (N'Network & Downloads', N'Mail Client (IMAP)', N'Add an account with a wrong password or an unreachable host — **Expected:** a visible error is shown and the account is NOT saved (verified-before-persisted, not saved-then-validated).', @baseSort + 3),
    (N'Network & Downloads', N'Mail Client (IMAP)', N'Remove an account — **Expected:** it disappears from the list immediately.', @baseSort + 4),
    (N'Network & Downloads', N'Mail Client (IMAP)', N'Restart the browser after adding an account — **Expected:** the account persists across restart.', @baseSort + 5),
    (N'Network & Downloads', N'Mail Client (IMAP)', N'With DevTools/network inspection open on the Settings page while adding an account — **Expected:** the plaintext password is not observable in any customMail* WebUI message payload sent back to the renderer (only the backend should ever see it; it''s OSCrypt-encrypted at rest in the custom.mail.accounts pref).', @baseSort + 6);
END
GO
