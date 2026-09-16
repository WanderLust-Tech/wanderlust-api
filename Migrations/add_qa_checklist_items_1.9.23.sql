-- Adds QA checklist items for browser v1.9.23: an enlarged certificate-selector
-- dialog (500x150 -> 800x300) with a new Validity column, ported from a
-- Chromium-Gost feature review.
-- See changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.9.22.sql. Idempotent: skips entirely
-- if the "Certificate Selector Dialog" FeatureName already has rows. Appends
-- after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Certificate Selector Dialog'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Privacy & Security', N'Certificate Selector Dialog', N'Navigate to a site configured to request a client certificate (or trigger via a corporate/test mTLS endpoint) — **Expected:** the certificate selector dialog appears sized approximately 800x300, not the stock 500x150.', @baseSort + 1),
    (N'Privacy & Security', N'Certificate Selector Dialog', N'Check the dialog''s certificate list columns — **Expected:** a "Validity" column is present alongside the existing subject/issuer columns, showing each certificate''s validity period.', @baseSort + 2);
END
GO
