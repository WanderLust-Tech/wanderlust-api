-- Adds a QA checklist item for browser v1.9.18: enabling Website
-- Restrictions (Parental Controls) now also forces Secure DNS off, so
-- DNS-over-HTTPS can't resolve around the restriction.
-- See parental-controls.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.9.16.sql. Idempotent: skips entirely
-- if an "As of v1.9.18:" item already exists for the "Parental Controls
-- (PIN Lock & Website Restrictions)" FeatureName. Appends after the
-- current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Parental Controls (PIN Lock & Website Restrictions)'
      AND ItemText LIKE N'As of v1.9.18:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Privacy & Security', N'Parental Controls (PIN Lock & Website Restrictions)', N'As of v1.9.18: with Website Restrictions in blocklist or allowlist mode (not "Off"), open chrome://settings/security and check the Secure DNS setting — **Expected:** Secure DNS is off and shows "This setting is disabled because parental controls are on"; switching restriction mode back to "Off" re-enables the normal Secure DNS controls without restarting the browser.', @baseSort + 1);
END
GO
