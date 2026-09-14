-- Adds QA checklist items for browser v1.9.19-1.9.20:
--   1.9.19 -- SmartBlock-style compat shims for blocked trackers (Facebook
--             SDK, Google Analytics/Tag Manager, comScore) so page code
--             referencing their globals doesn't throw after a block
--   1.9.20 -- local password breach-alert correlation against the public
--             Have I Been Pwned dataset, entirely on-device
-- See ad-blocker.md and password-manager-view-edit-checkup.md (both in
-- wanderlust-knowledgebase) for the full write-ups.
--
-- Run after add_qa_checklist_items_1.9.18.sql. Idempotent: skips each
-- insert independently if an "As of v1.9.19:"/"As of v1.9.20:" item
-- already exists for that FeatureName. Appends after the current max
-- SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Ad Blocker'
      AND ItemText LIKE N'As of v1.9.19:%'
)
BEGIN
    DECLARE @baseSort1 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Privacy & Security', N'Ad Blocker', N'As of v1.9.19: visit a page embedding the Facebook SDK, Google Analytics/Tag Manager, or comScore (e.g. a page with a Like button, or `gtag`/`ga` calls in a click handler) with the ad blocker on - **Expected:** the tracker''s script is blocked as before, but interacting with the page afterward (clicking the Like button, triggering an event-tracking call) does not throw a JavaScript console error - `window.FB`/`window.ga`/`window.gtag`/`window.COMSCORE` exist as harmless stubs instead of being undefined.', @baseSort1 + 1);
END

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Password Manager - Checkup (weak/reused + leak check)'
      AND ItemText LIKE N'As of v1.9.20:%'
)
BEGIN
    DECLARE @baseSort2 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Settings & Configuration', N'Password Manager - Checkup (weak/reused + leak check)', N'As of v1.9.20: save a credential for a domain known to be in the Have I Been Pwned breach dataset (e.g. `adobe.com`) with the saved-password date set earlier than that domain''s most recent known breach - **Expected:** it appears under "Potentially exposed" with the breach name and date shown; the caption text clearly distinguishes this from a confirmed leak (does not say the password was leaked, only that the site was breached after the password was last set).', @baseSort2 + 1),
    (N'Settings & Configuration', N'Password Manager - Checkup (weak/reused + leak check)', N'As of v1.9.20: change that same credential''s password (so date_password_modified is now after the breach date) and re-run the checkup - **Expected:** it no longer appears under "Potentially exposed".', @baseSort2 + 2),
    (N'Settings & Configuration', N'Password Manager - Checkup (weak/reused + leak check)', N'As of v1.9.20: with no network access, restart the browser and open the checkup section (after at least one prior successful breach-data fetch) - **Expected:** breach correlation still works from the on-disk cache (WanderLustBreachCache.json in the user-data directory) - confirms the check itself makes no network call at checkup time, only the periodic background refresh does.', @baseSort2 + 3);
END
GO
