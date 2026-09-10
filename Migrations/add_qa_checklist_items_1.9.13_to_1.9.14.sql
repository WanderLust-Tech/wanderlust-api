-- Adds QA checklist items for browser v1.9.13 and v1.9.14:
--
-- v1.9.13 -- new "Reverse Image Search (TinEye)" right-click context menu
--           item on images; also fixes the chrome://mail HTML message body
--           iframe, which had failed to navigate at all (blocked
--           about:blank) since v1.9.9.
-- v1.9.14 -- two default-privacy-pref fixes found while investigating an
--           (unrelated, still-unresolved) Cloudflare Turnstile bot-
--           detection failure: Client Hints (sec-ch-ua*) were suppressed
--           entirely by default, and Do Not Track / third-party-cookie-
--           deprecation were forced on by default (stock Chromium
--           defaults both off).
--
-- See reverse-image-search.md, mail-client.md, and changelog.md
-- (1.9.13-1.9.14 entries), wanderlust-knowledgebase repo, for the full
-- write-ups.
--
-- Run after add_qa_checklist_items_1.9.10_to_1.9.12.sql. Idempotent: the
-- Reverse Image Search block gates on its brand-new FeatureName alone; the
-- Mail Client and De-Googling blocks both already have older rows, so they
-- gate on FeatureName + an ItemText LIKE prefix instead. Appends after the
-- current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Reverse Image Search (TinEye)'
)
BEGIN
    DECLARE @baseSort1 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Input & Interaction', N'Reverse Image Search (TinEye)', N'Right-click a real image on any webpage — **Expected:** "Search image with TinEye" appears in the context menu.', @baseSort1 + 1),
    (N'Input & Interaction', N'Reverse Image Search (TinEye)', N'Click it — **Expected:** a new foreground tab opens to tineye.com''s search results for that exact image, no crash.', @baseSort1 + 2),
    (N'Input & Interaction', N'Reverse Image Search (TinEye)', N'Middle-click (or Ctrl-click) the menu item if supported by your test flow, or check disposition handling generally — **Expected:** opens in a background tab rather than stealing focus, matching other "open in new tab" context menu items.', @baseSort1 + 3),
    (N'Input & Interaction', N'Reverse Image Search (TinEye)', N'Open Settings → Others, turn off "Show ''Search image with TinEye'' in the right-click menu on images" — **Expected:** right-clicking an image no longer shows the item.', @baseSort1 + 4),
    (N'Input & Interaction', N'Reverse Image Search (TinEye)', N'Right-click a `chrome://`-scheme image (e.g. on an internal page) or a CSS `background-image` (not a real `<img>`) — **Expected:** the item does not appear (same restriction as the existing "Search web for image" item).', @baseSort1 + 5);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Mail Client (IMAP)'
      AND ItemText LIKE N'As of v1.9.13:%'
)
BEGIN
    DECLARE @baseSort2 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Network & Downloads', N'Mail Client (IMAP)', N'As of v1.9.13: open an HTML message and confirm the body actually renders instead of a blank pane — **Expected:** the `chrome-untrusted://mail-body/` iframe navigates and displays the message content; previously (v1.9.9–v1.9.12) it failed to navigate at all, committing as a blocked `about:blank`.', @baseSort2 + 1);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'De-Googling & Privacy-Safe Defaults'
      AND ItemText LIKE N'As of v1.9.14:%'
)
BEGIN
    DECLARE @baseSort3 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Privacy & Security', N'De-Googling & Privacy-Safe Defaults', N'As of v1.9.14: on a fresh profile, open Settings → Privacy and check "Send a ''Do Not Track'' request" — **Expected:** off by default (previously defaulted on, sending `DNT: 1` on every request — an existing profile from before this fix needs the toggle flipped off once to clear the stale persisted value, since the new code default only applies to profiles where the pref was never explicitly written).', @baseSort3 + 1),
    (N'Privacy & Security', N'De-Googling & Privacy-Safe Defaults', N'As of v1.9.14: with DevTools Network tab open, load any page and inspect the document request''s headers — **Expected:** `sec-ch-ua`, `sec-ch-ua-mobile`, and `sec-ch-ua-platform` are all present (previously suppressed entirely, regardless of any setting).', @baseSort3 + 2);
END
GO
