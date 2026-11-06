using System.Text.RegularExpressions;
using WanderlustApi.Controllers;

namespace WanderlustApi.Services
{
    /// <summary>
    /// Validates a "publish a release" request before it is written to
    /// BrowserReleases. The row it creates is what every install's updater is
    /// told to download and run, so the fields are checked strictly rather than
    /// stored as given: a malformed or hostile value must be rejected here, not
    /// discovered by a client.
    /// </summary>
    public static class ReleaseRequestValidator
    {
        // Hosts an installer may be served from when Releases:AllowedInstallerHosts
        // is not configured: this API's own /releases/ static route (see
        // UPDATE_PROTOCOL.md, "Installer Hosting"). Add a CDN host in config
        // before publishing a release that points at it.
        public static readonly string[] DefaultAllowedInstallerHosts = { "api.wander-lust.tech" };

        public const long MaxInstallerBytes = 2L * 1024 * 1024 * 1024;

        private static readonly string[] Platforms = { "win", "linux", "mac" };
        private static readonly string[] Architectures = { "x64", "x86", "arm64" };

        // "{8A69D345-D564-463c-AFF1-A69D9E530F96}"
        private static readonly Regex AppIdPattern = new(
            @"^\{[0-9A-Fa-f]{8}(-[0-9A-Fa-f]{4}){3}-[0-9A-Fa-f]{12}\}$", RegexOptions.Compiled);

        private static readonly Regex Sha256Pattern = new(
            @"^[0-9A-Fa-f]{64}$", RegexOptions.Compiled);

        // A bare file name: no path separators, no leading dot.
        private static readonly Regex FileNamePattern = new(
            @"^[A-Za-z0-9][A-Za-z0-9._-]{0,127}$", RegexOptions.Compiled);

        /// <summary>
        /// Signing policy for a publish request. <paramref name="Required"/>: a release without a
        /// signature is rejected (the update client would refuse it anyway).
        /// <paramref name="PublicKeys"/>: when present, the signature is verified cryptographically
        /// here too, so a wrong key or a signature over different fields is caught at publish time.
        /// </summary>
        public sealed record SigningPolicy(bool Required, IReadOnlyCollection<string> PublicKeys);

        /// <summary>Returns one message per problem; empty means the request is acceptable.</summary>
        public static IReadOnlyList<string> Validate(
            CreateReleaseRequest req,
            IReadOnlyCollection<string> allowedInstallerHosts,
            SigningPolicy signing)
        {
            var errors = new List<string>();

            if (string.IsNullOrWhiteSpace(req.AppId) || !AppIdPattern.IsMatch(req.AppId))
                errors.Add("appId must be a GUID in braces, e.g. {8A69D345-D564-463c-AFF1-A69D9E530F96}.");

            // Four numeric parts, because the update check compares System.Version
            // values and every published release uses the quad form.
            if (string.IsNullOrWhiteSpace(req.Version)
                || req.Version.Split('.').Length != 4
                || !Version.TryParse(req.Version, out _))
                errors.Add("version must be four numeric parts, e.g. 1.11.15.0.");

            if (!Platforms.Contains(req.Platform))
                errors.Add($"platform must be one of: {string.Join(", ", Platforms)}.");

            if (!Architectures.Contains(req.Arch))
                errors.Add($"arch must be one of: {string.Join(", ", Architectures)}.");

            if (string.IsNullOrWhiteSpace(req.InstallerName) || !FileNamePattern.IsMatch(req.InstallerName))
                errors.Add("installerName must be a plain file name (letters, digits, '.', '_', '-').");

            if (!IsAllowedInstallerUrl(req.InstallerUrl, allowedInstallerHosts))
                errors.Add("installerUrl must be an https:// URL, without credentials, on an allowed installer host ("
                    + string.Join(", ", allowedInstallerHosts) + ").");

            if (string.IsNullOrWhiteSpace(req.HashSha256) || !Sha256Pattern.IsMatch(req.HashSha256))
                errors.Add("hashSha256 must be 64 hexadecimal characters.");

            if (req.SizeBytes <= 0 || req.SizeBytes > MaxInstallerBytes)
                errors.Add($"sizeBytes must be between 1 and {MaxInstallerBytes}.");

            if (req.RolloutWeight < 0 || req.RolloutWeight > 100)
                errors.Add("rolloutWeight must be between 0 and 100.");

            if (req.ExperimentName is { Length: > 100 })
                errors.Add("experimentName must be at most 100 characters.");

            ValidateMirrorUrls(req, errors);

            ValidateSignature(req, signing, errors);

            return errors;
        }

        public const int MaxMirrorUrls = 5;
        public const int MaxUrlLength = 1024;

        // Mirrors may live on any host (that is the point of a mirror): the signed hash
        // and size pin the file, so a mirror cannot serve different bytes. They still
        // have to be plain https URLs without credentials.
        private static void ValidateMirrorUrls(CreateReleaseRequest req, List<string> errors)
        {
            if (req.MirrorUrls == null || req.MirrorUrls.Length == 0) return;

            if (req.MirrorUrls.Length > MaxMirrorUrls)
            {
                errors.Add($"mirrorUrls must contain at most {MaxMirrorUrls} URLs.");
                return;
            }

            var seen = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            if (!string.IsNullOrWhiteSpace(req.InstallerUrl)) seen.Add(req.InstallerUrl);

            foreach (var url in req.MirrorUrls)
            {
                if (string.IsNullOrWhiteSpace(url)
                    || url.Length > MaxUrlLength
                    || !Uri.TryCreate(url, UriKind.Absolute, out var uri)
                    || uri.Scheme != Uri.UriSchemeHttps
                    || !string.IsNullOrEmpty(uri.UserInfo))
                {
                    errors.Add($"each mirrorUrls entry must be an https:// URL of at most {MaxUrlLength} "
                        + "characters, without credentials.");
                    return;
                }

                if (!seen.Add(url))
                {
                    errors.Add("mirrorUrls must not repeat installerUrl or another mirror.");
                    return;
                }
            }
        }

        private static void ValidateSignature(CreateReleaseRequest req, SigningPolicy signing, List<string> errors)
        {
            if (string.IsNullOrEmpty(req.Signature))
            {
                if (signing.Required)
                    errors.Add("signature is required: sign the release with scripts/release-signing/ReleaseSigner.cs "
                        + "(the update client refuses an unsigned release).");
                return;
            }

            if (!ReleaseSignature.Format.IsMatch(req.Signature))
            {
                errors.Add("signature must be \"<16 hex key id>:<base64 of 64 bytes>\".");
                return;
            }

            // Verify only when the other fields are themselves sound: the message is built from them.
            if (signing.PublicKeys.Count == 0 || errors.Count > 0) return;
            var message = ReleaseSignature.Message(
                req.AppId, req.Platform, req.Arch, req.Version, req.HashSha256, req.SizeBytes);
            if (!ReleaseSignature.TryVerify(req.Signature, message, signing.PublicKeys, out var why))
                errors.Add("signature check failed: " + why + ".");
        }

        private static bool IsAllowedInstallerUrl(string? url, IReadOnlyCollection<string> allowedHosts)
        {
            if (string.IsNullOrWhiteSpace(url)
                || !Uri.TryCreate(url, UriKind.Absolute, out var uri))
                return false;

            return uri.Scheme == Uri.UriSchemeHttps
                && string.IsNullOrEmpty(uri.UserInfo)
                && allowedHosts.Any(h => string.Equals(h, uri.IdnHost, StringComparison.OrdinalIgnoreCase));
        }
    }
}
