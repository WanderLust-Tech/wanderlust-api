-- Adds QA checklist items for browser v1.9.6 through v1.9.9:
--
-- v1.9.6 -- fixed a Trusted Types crash in the RSS reader and sidebar RSS
--           panel that left item summaries blank (stripHtml() calling
--           DOMParser.parseFromString() directly, itself a Trusted Types
--           sink), plus a separate img-src CSP gap blocking Magazine/Full
--           view thumbnails entirely.
-- v1.9.7, v1.9.8 -- two chrome://mail CSP gaps found and fixed
--           (img-src, then child-src) while debugging the message body
--           iframe -- necessary but not sufficient; the iframe still
--           doesn't render as of v1.9.9, so no new checklist item for
--           either (nothing new for a tester to verify yet -- see
--           mail-client.md's "Current status" for the ongoing issue).
-- v1.9.9 -- fixed the picture-in-picture hover button crashing on every
--           single WebUI page load (unrelated to mail/RSS -- it injects
--           into every page's primary main frame unconditionally).
--
-- See sidebar.md, picture-in-picture-button.md, mail-client.md, and
-- changelog.md (1.9.6-1.9.9 entries), wanderlust-knowledgebase repo, for
-- the full write-ups.
--
-- Run after add_qa_checklist_items_1.9.3_to_1.9.5.sql. Idempotent: skips
-- each version's items independently via FeatureName + an ItemText LIKE
-- prefix (all three features already have older rows, so a bare
-- FeatureName check would skip the whole block). Appends after the
-- current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'RSS Reader'
      AND ItemText LIKE N'As of v1.9.6:%'
)
BEGIN
    DECLARE @baseSort1 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Content & Reading', N'RSS Reader', N'As of v1.9.6: switch to Magazine or Full view on a feed whose items have HTML descriptions — **Expected:** item summaries render as plain text (not blank), and a thumbnail appears when the description embeds an inline `<img>` pointing at an external host (previously `stripHtml()`''s `DOMParser.parseFromString()` call silently threw under this WebUI''s Trusted Types CSP, leaving summaries blank; separately, thumbnails were blocked outright by the default `img-src` CSP not allowing external image hosts).', @baseSort1 + 1);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Sidebar - RSS panel (chrome://sidebar/rss)'
      AND ItemText LIKE N'As of v1.9.6:%'
)
BEGIN
    DECLARE @baseSort2 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Custom WebUI', N'Sidebar - RSS panel (chrome://sidebar/rss)', N'As of v1.9.6: open the sidebar''s RSS panel on a feed whose items have HTML descriptions — **Expected:** the 2-line item summary renders as plain text, not blank (previously `stripHtml()`''s `DOMParser.parseFromString()` call silently threw under this WebUI''s Trusted Types CSP).', @baseSort2 + 1);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Picture-in-Picture Hover Button'
      AND ItemText LIKE N'As of v1.9.9:%'
)
BEGIN
    DECLARE @baseSort3 INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Content & Reading', N'Picture-in-Picture Hover Button', N'As of v1.9.9: open any `chrome://` or `chrome-untrusted://` page (e.g. `chrome://reader`, `chrome://mail`) with DevTools console open — **Expected:** no "Failed to set the ''innerHTML'' property ... TrustedHTML" error appears (previously this feature injected its button-setup script into every page''s primary main frame unconditionally, including WebUI pages with no video to attach to, crashing under their Trusted Types CSP every time).', @baseSort3 + 1);
END
GO
