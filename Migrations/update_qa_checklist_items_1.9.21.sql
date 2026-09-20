-- Brings QaChecklistTemplateItems up to date for browser v1.9.21: Reader
-- Mode Integration was fixed from a non-functional stub (faked success,
-- injected nothing) to a real dom_distiller-backed implementation. The
-- existing six checklist items described fictional pre-fix behavior (in-
-- place CSS reformatting via a working right-click menu) that was never
-- actually true, so this replaces them with five items matching the
-- corrected qa-testing-checklist.md section, rather than layering an
-- "As of v1.9.21" addition on top of items that described something that
-- never existed. See reader-mode-integration.md and changelog.md,
-- wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.9.19_to_1.9.20.sql. Idempotent: the
-- UPDATE only soft-retires rows still matching the old (fictional) text
-- and still IsActive -- a no-op on a second run -- and the INSERT block
-- is gated on an "As of v1.9.21:" item already existing for this
-- FeatureName.
--
-- Soft-retire (IsActive = 0) instead of DELETE: QaChecklistTemplateItems
-- has no ON DELETE behavior configured on the FK from QaChecklistRunItems
-- (default NO ACTION), and QaChecklistRunItems doesn't snapshot the item
-- text -- it's joined live at read time. A hard DELETE fails outright
-- (FK__QaCheckli__Templ__36470DEF) the moment any QA run has already
-- exercised one of these six items, and even if the FK were loosened,
-- historical runs would silently lose that item's text rather than just
-- being orphaned. IsActive is exactly the column the schema already
-- provides for this ("soft-retire without renumbering") and is what
-- GetTemplateItemsAsync/CreateRunAsync already filter on.
UPDATE QaChecklistTemplateItems
SET IsActive = 0
WHERE Category = N'Content & Reading'
  AND FeatureName = N'Reader Mode Integration'
  AND IsActive = 1
  AND ItemText IN (
    N'Navigate to a clearly article-style page (news article, blog post) - **Expected:** Since auto-detect is off by default, no automatic prompt appears; manually invoke the reader-mode command/context-menu item to check availability.',
    N'Right-click on the article page and select **"Enter Reader Mode"** (or trigger command 35083) - **Expected:** Brief "Distilling" state, then content is replaced with the clean reader layout (centered column, serif font, white content card).',
    N'Right-click again while in reader mode - **Expected:** Menu now offers **"Exit Reader Mode"**; selecting it returns the page to normal rendering.',
    N'Try triggering reader mode on a non-article page (e.g. a search results page, a `chrome://` page, or a page with mostly navigation/no article body) - **Expected:** Command is unavailable/greyed out, or reports "Not Available" - no distillation attempted on excluded schemes (`chrome://`, `about:`, `data:`, etc).',
    N'Trigger reader mode on a page likely to fail distillation (e.g. a very sparse or malformed page) - **Expected:** State moves to "Error" and the UI fails gracefully rather than showing broken/garbled content.',
    N'(Edge, requires a build with auto-detect flipped on) Navigate to several article pages in a row - **Expected:** Reader-mode availability is automatically flagged per page without manual triggering.'
  );

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Reader Mode Integration'
      AND ItemText LIKE N'As of v1.9.21:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Content & Reading', N'Reader Mode Integration', N'As of v1.9.21: navigate to a real article page (a news site or blog post) and click the Reader Mode toolbar button - **Expected:** the tab navigates to a chrome-distiller://... URL showing the extracted article content, not the original page reformatted in place.', @baseSort + 1),
    (N'Content & Reading', N'Reader Mode Integration', N'As of v1.9.21: with Reader Mode active, click the toolbar button again (or use its "exit" affordance) - **Expected:** the tab goes back to the original article URL (browser back-navigation), not a reload of the distilled view.', @baseSort + 2),
    (N'Content & Reading', N'Reader Mode Integration', N'As of v1.9.21: trigger Reader Mode on a chrome:// page or other excluded scheme - **Expected:** the button is unavailable; no navigation attempted.', @baseSort + 3),
    (N'Content & Reading', N'Reader Mode Integration', N'As of v1.9.21: trigger Reader Mode on a page distillation can''t meaningfully extract from (e.g. a mostly-navigation page with little article text) - **Expected:** either a low-quality distilled result or a failure state, but no browser crash and no garbled output.', @baseSort + 4),
    (N'Content & Reading', N'Reader Mode Integration', N'Confirm the context-menu "Read Mode" item is still a no-op - **Expected:** known issue, not fixed by v1.9.21; use the toolbar button.', @baseSort + 5);
END
GO
