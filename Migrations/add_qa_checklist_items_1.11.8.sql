-- Adds QA checklist items for browser v1.11.8: a new setting chooses what happens
-- when a .torrent file finishes downloading -- add it to the built-in client
-- (the unchanged default), ask with an infobar, open it with the default
-- application, or just keep the file -- plus an option to stop the tab being
-- sent to chrome://bittorrent after an add.
-- See bittorrent-client.md and changelog.md, wanderlust-knowledgebase repo.
--
-- Run after add_qa_checklist_items_1.11.7.sql. Idempotent: skips entirely if an
-- "As of v1.11.8:" item already exists for the "Integrated BitTorrent Client"
-- FeatureName. Appends after the current max SortOrder.

IF NOT EXISTS (
    SELECT 1 FROM QaChecklistTemplateItems
    WHERE FeatureName = N'Integrated BitTorrent Client'
      AND ItemText LIKE N'As of v1.11.8:%'
)
BEGIN
    DECLARE @baseSort INT = (SELECT ISNULL(MAX(SortOrder), 0) FROM QaChecklistTemplateItems);

    INSERT INTO QaChecklistTemplateItems (Category, FeatureName, ItemText, SortOrder)
    VALUES
    (N'Network & Downloads', N'Integrated BitTorrent Client', N'As of v1.11.8: open Settings → BitTorrent — **Expected:** a section "When a .torrent file finishes downloading" with the action set to **Add to the built-in client** and **Switch to the BitTorrent page after adding** switched on (the defaults). Download a .torrent file from a web page — **Expected:** exactly what happened before this release: the torrent appears in `chrome://bittorrent`, the file disappears from the downloads list and from disk, and the tab you downloaded it from is taken to `chrome://bittorrent`.', @baseSort + 1),
    (N'Network & Downloads', N'Integrated BitTorrent Client', N'As of v1.11.8: switch off **Switch to the BitTorrent page after adding** and download a .torrent file — **Expected:** the torrent is still added (and the file is still removed from the downloads list and deleted), but the tab stays on the page you were reading.', @baseSort + 2),
    (N'Network & Downloads', N'Integrated BitTorrent Client', N'As of v1.11.8: set the action to **Ask me each time** and download a .torrent file — **Expected:** a bar appears in the tab reading Torrent file "<name>.torrent" downloaded. with **Add to BitTorrent** and **Keep file** buttons and an **Open with default app** link. The file is still in the downloads list and on disk, and nothing has been added to `chrome://bittorrent` yet.', @baseSort + 3),
    (N'Network & Downloads', N'Integrated BitTorrent Client', N'As of v1.11.8: with that bar showing, click **Add to BitTorrent** — **Expected:** the torrent is added, the file disappears from the downloads list and from disk, and the tab goes to `chrome://bittorrent` (unless the switch-to-page option is off).', @baseSort + 4),
    (N'Network & Downloads', N'Integrated BitTorrent Client', N'As of v1.11.8: repeat the Ask download and click **Keep file** (or the bar''s close button) — **Expected:** nothing is added; the .torrent file stays in the downloads list and on disk.', @baseSort + 5),
    (N'Network & Downloads', N'Integrated BitTorrent Client', N'As of v1.11.8: repeat the Ask download and click **Open with default app** — **Expected:** the operating system opens the file in its default application, and the file stays in the downloads list and on disk. (If Wanderlust is itself the default application for .torrent files — Settings → BitTorrent → File association — the file comes straight back and is added anyway.)', @baseSort + 6),
    (N'Network & Downloads', N'Integrated BitTorrent Client', N'As of v1.11.8: repeat the Ask download and, with the bar showing, navigate the tab to another page — **Expected:** the bar stays until you answer it. Closing the tab instead counts as Keep: nothing is added or deleted.', @baseSort + 7),
    (N'Network & Downloads', N'Integrated BitTorrent Client', N'As of v1.11.8: repeat the Ask download and, with the bar showing, delete the .torrent file from your downloads folder (or remove it from the downloads list), then click **Add to BitTorrent** — **Expected:** nothing is added, and there is no error or crash.', @baseSort + 8),
    (N'Network & Downloads', N'Integrated BitTorrent Client', N'As of v1.11.8: set the action to **Open with the default application** and download a .torrent file — **Expected:** the operating system opens it and the file is left in the downloads list and on disk. Set it to **Just keep the file (do nothing)** and download another — **Expected:** an ordinary download: no bar, nothing added, the file stays.', @baseSort + 9),
    (N'Network & Downloads', N'Integrated BitTorrent Client', N'As of v1.11.8: switch off **Enable integrated BitTorrent client** and download a .torrent file with each of the four actions in turn — **Expected:** every time it is an ordinary download that is never touched: no bar, nothing added, the file is not deleted.', @baseSort + 10);
END
GO
