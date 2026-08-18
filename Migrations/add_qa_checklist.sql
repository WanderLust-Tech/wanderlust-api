-- Migration: create QA checklist tables
-- Tracks per-version progress through the manual QA testing checklist
-- (qa-testing-checklist.md, wanderlust-knowledgebase repo) via the admin
-- "QA Checklist" page. Three tables:
--   QaChecklistTemplateItems -- the stable master list ("what to check"),
--     seeded once from the current doc content (see
--     seed_qa_checklist_template_items.sql) and edited independently of
--     any specific run.
--   QaChecklistRuns -- one row per version's checklist run. Keyed by
--     (AppId, Version), not a BrowserReleases.Id FK -- same reasoning as
--     WhatsNewEntries (see add_whats_new_entries.sql): a single logical
--     version spans multiple BrowserReleases rows (one per platform/arch),
--     so there's no single row to anchor a FK to.
--   QaChecklistRunItems -- one row per (run, template item), bulk-created
--     when a run starts. Splitting "what to check" from "did we check it
--     this run" means old runs keep their own completion history even if
--     template items are edited/added/retired later.
-- Run once against the production database before deploying the
-- QaChecklistController.

IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'QaChecklistTemplateItems'
)
BEGIN
    CREATE TABLE QaChecklistTemplateItems (
        Id          INT            IDENTITY(1,1) PRIMARY KEY,
        Category    NVARCHAR(64)   NOT NULL,           -- "## " header, e.g. "Browser UI"
        FeatureName NVARCHAR(128)  NOT NULL,           -- "### " header, e.g. "Vertical Tabs"
        ItemText    NVARCHAR(2000) NOT NULL,           -- the checklist line itself
        SortOrder   INT            NOT NULL,           -- preserves doc order
        IsActive    BIT            NOT NULL DEFAULT 1, -- soft-retire without renumbering
        CreatedAt   DATETIME2      NOT NULL DEFAULT GETUTCDATE()
    );

    CREATE NONCLUSTERED INDEX IX_QaChecklistTemplateItems_Sort
        ON QaChecklistTemplateItems (IsActive, SortOrder);
END
GO

-- Widen ItemText for installs that already ran this migration when the
-- column was NVARCHAR(1024) -- some checklist items exceed that length.
-- Safe/idempotent to re-run (no-op once already 2000).
ALTER TABLE QaChecklistTemplateItems ALTER COLUMN ItemText NVARCHAR(2000) NOT NULL;
GO

IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'QaChecklistRuns'
)
BEGIN
    CREATE TABLE QaChecklistRuns (
        Id        INT           IDENTITY(1,1) PRIMARY KEY,
        AppId     NVARCHAR(64)  NOT NULL,
        Version   NVARCHAR(32)  NOT NULL,
        CreatedAt DATETIME2     NOT NULL DEFAULT GETUTCDATE(),
        CreatedBy NVARCHAR(128) NULL
    );

    CREATE NONCLUSTERED INDEX IX_QaChecklistRuns_Lookup
        ON QaChecklistRuns (AppId, Version, CreatedAt DESC);
END
GO

IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME = 'QaChecklistRunItems'
)
BEGIN
    CREATE TABLE QaChecklistRunItems (
        Id             INT            IDENTITY(1,1) PRIMARY KEY,
        RunId          INT            NOT NULL FOREIGN KEY REFERENCES QaChecklistRuns(Id),
        TemplateItemId INT            NOT NULL FOREIGN KEY REFERENCES QaChecklistTemplateItems(Id),
        IsComplete     BIT            NOT NULL DEFAULT 0,
        CompletedBy    NVARCHAR(128)  NULL,
        CompletedAt    DATETIME2      NULL,
        Notes          NVARCHAR(1024) NULL
    );

    CREATE NONCLUSTERED INDEX IX_QaChecklistRunItems_Run
        ON QaChecklistRunItems (RunId);
END
GO

-- Seed: see seed_qa_checklist_template_items.sql for the real ~605-item
-- import from qa-testing-checklist.md's current content. Run that file
-- once, after this one, before creating any checklist runs.
