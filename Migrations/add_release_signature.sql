-- Migration: add the release-manifest signature to BrowserReleases.
--
-- The update client (custom-omaha-client) refuses any release whose manifest is
-- not signed with the offline release key, so the signature is stored with the
-- release and served in the Omaha response. Format: "<16 hex key id>:<base64 of
-- the 64-byte ECDSA P-256 signature>" -- see UPDATE_PROTOCOL.md, "Release
-- signing", and scripts/release-signing/ReleaseSigner.cs.
--
-- RUN THIS BEFORE DEPLOYING the API version that reads the column: the release
-- queries select it by name, so code without the column (or the column without
-- code) is the only ordering that can break /v4/update. Nullable and additive,
-- so existing rows and the previous API version are unaffected.
--
-- Existing rows stay NULL, i.e. unsigned. A client that requires signatures will
-- not install them; sign a release with ReleaseSigner.cs and set it with:
--   UPDATE BrowserReleases SET Signature = N'<keyId>:<base64>' WHERE Id = <id>;

IF NOT EXISTS (
    SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'BrowserReleases' AND COLUMN_NAME = 'Signature'
)
BEGIN
    ALTER TABLE BrowserReleases ADD Signature NVARCHAR(200) NULL;
END
GO
