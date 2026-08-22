-- Brings QaChecklistTemplateItems up to date for browser v1.8.47: Site
-- Injection rule edits now hot-reload after Save/Delete instead of
-- requiring a browser restart. See qa-testing-checklist.md and
-- changelog.md, wanderlust-knowledgebase repo, for the full write-up.
--
-- Run after add_qa_checklist_items_1.8.46.sql. Idempotent: the UPDATEs
-- only fire if the row still has its old (restart-era) text, and the
-- INSERT is gated on that same new row not already existing.

-- === Corrections: drop restart requirements ===

UPDATE QaChecklistTemplateItems
SET ItemText = N'Open Settings → Security & Privacy → Site injection, add a global rule (address `*`, type CSS, inject "On navigation") with content `body::before{display:none}`.'
WHERE Category = N'Privacy & Security'
  AND FeatureName = N'Site Injection'
  AND ItemText = N'Open Settings → Security & Privacy → Site injection, add a global rule (address `*`, type CSS, inject "On navigation") with content `body::before{display:none}`, restart the browser.';

UPDATE QaChecklistTemplateItems
SET ItemText = N'As of v1.8.47: without restarting, navigate to any page — **Expected:** the injected stylesheet is present (inspect `<head>` for a `<style>` tag matching the content) and takes visible effect immediately on commit (before first paint) — previously this required a full browser restart first.'
WHERE Category = N'Privacy & Security'
  AND FeatureName = N'Site Injection'
  AND ItemText = N'Visit any page — **Expected:** the injected stylesheet is present (inspect `<head>` for a `<style>` tag matching the content) and takes visible effect immediately on commit (before first paint).';

UPDATE QaChecklistTemplateItems
SET ItemText = N'Add a domain-wildcard rule (`*.github.com`, CSS, "On navigation") and, without restarting, visit github.com and a subdomain — **Expected:** both match and get the injected CSS; a non-matching domain does not.'
WHERE Category = N'Privacy & Security'
  AND FeatureName = N'Site Injection'
  AND ItemText = N'Add a domain-wildcard rule (`*.github.com`, CSS, "On navigation") and, after restarting, visit github.com and a subdomain — **Expected:** both match and get the injected CSS; a non-matching domain does not.';

UPDATE QaChecklistTemplateItems
SET ItemText = N'Edit an existing rule''s content and re-save — **Expected:** the settings page reflects the change immediately, and as of v1.8.47 the target page also picks it up on its next navigation (reload the tab) — no restart needed on either side anymore.'
WHERE Category = N'Privacy & Security'
  AND FeatureName = N'Site Injection'
  AND ItemText = N'Edit an existing rule''s content and re-save — **Expected:** the settings page reflects the change immediately (no restart needed to see it in the list), but the target page still needs a restart to pick it up.';

UPDATE QaChecklistTemplateItems
SET ItemText = N'Delete a rule that shares its payload file with another rule (e.g. two rules both pointing at the same generated file) — **Expected:** the shared file is preserved for the remaining rule, not deleted, and the remaining rule''s injection still works on the next navigation.'
WHERE Category = N'Privacy & Security'
  AND FeatureName = N'Site Injection'
  AND ItemText = N'Delete a rule that shares its payload file with another rule (e.g. two rules both pointing at the same generated file) — **Expected:** the shared file is preserved for the remaining rule, not deleted.';

-- === New coverage: hot-reload doesn't retroactively re-inject ===

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE Category = N'Privacy & Security'
      AND FeatureName = N'Site Injection'
      AND ItemText LIKE N'With a page already open (not reloaded)%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Privacy & Security', N'Site Injection', N'With a page already open (not reloaded) when a rule affecting it is edited, do *not* reload it — **Expected:** the already-rendered page keeps its old injected content until you actually navigate/reload it; the hot-reload swaps in the new rule set for future navigations, it doesn''t retroactively re-inject into a currently-loaded DOM.', @baseSort + 1);
END
GO
