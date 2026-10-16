-- Adds QA checklist items for browser v1.11.11: Website Restrictions (Parental
-- Controls), Connection Control and Content Policy Chain now also apply to HTTP
-- redirect targets, apply from the first request after a browser start, and (for
-- Website Restrictions) apply in incognito windows.
-- See parental-controls.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.10.sql. Idempotent: each block skips
-- itself if an "As of v1.11.11:" item already exists for its FeatureName.
-- Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Parental Controls (PIN Lock & Website Restrictions)'
      AND ItemText LIKE N'As of v1.11.11:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'As of v1.11.11: with Website Restrictions on and a site in the blocklist, quit the browser completely, start it again and — before opening Settings — type the blocked site''s address — **Expected:** the "is blocked" error page appears straight away (ERR_BLOCKED_BY_CLIENT); restrictions no longer wait for the Parental Controls page to be opened after a restart.', @baseSort + 1),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'As of v1.11.11: with Website Restrictions on, follow a link or redirect from an allowed site to a blocklisted site (for example a link shortener, or a page that answers with an HTTP redirect) — **Expected:** the error page names the blocklisted host instead of loading it; in allowlist mode a redirect from an allowlisted site to a site that is not on the list is blocked in the same way.', @baseSort + 2),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'As of v1.11.11: with Website Restrictions on, open an incognito window and visit a blocklisted site, both by typing it and through a redirect from an allowed site — **Expected:** blocked exactly as in a normal window.', @baseSort + 3),
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'As of v1.11.11: with a PIN set, open Settings → Parental Controls from an incognito window — **Expected:** it shows the same enabled/locked state as a normal window and the same PIN unlocks it.', @baseSort + 4);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Connection Control'
      AND ItemText LIKE N'As of v1.11.11:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Privacy & Security', N'Connection Control', N'As of v1.11.11: with a deny rule for the private network enabled, open a public page that redirects (HTTP redirect) to a private address such as http://192.168.1.1 or http://127.0.0.1 — **Expected:** blocked with ERR_BLOCKED_BY_CLIENT, the same as typing that address; an image on a public page whose URL redirects to a private address is not fetched.', @baseSort + 1);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Content Policy Chain'
      AND ItemText LIKE N'As of v1.11.11:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Privacy & Security', N'Content Policy Chain', N'As of v1.11.11: with a rule blocking scripts from one host, load a page whose script URL on an allowed host redirects to the blocked host — **Expected:** the script is blocked; after fully restarting the browser the rules also apply from the first page load without opening Settings.', @baseSort + 1);
END
GO
