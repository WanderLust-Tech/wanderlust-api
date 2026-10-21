using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

namespace WanderlustApi.Services
{
    /// <summary>
    /// The release-manifest signature scheme. The update client refuses any release
    /// it cannot verify against a public key built into it, so a compromised server,
    /// database or admin account cannot ship code by itself.
    ///
    /// WIRE FORMAT -- keep identical to custom-omaha-client/src/signature_verifier.cc
    /// and scripts/release-signing/ReleaseSigner.cs:
    ///   message   = lines, each ending "\n": wanderlust-update-v1, app id (lower-case,
    ///               with braces), platform, arch, version (four decimal integers),
    ///               installer SHA-256 (lower-case hex), installer size (decimal)
    ///   signature = ECDSA P-256 over SHA-256(message), 64 bytes r||s, base64
    ///   public key= 64 bytes X||Y, base64;  key id = first 8 bytes of SHA-256(key), hex
    ///   stored/served as "&lt;key id&gt;:&lt;base64 signature&gt;"
    /// The server only ever holds PUBLIC keys (optionally, to reject a bad signature at
    /// publish time); the private key stays offline.
    /// </summary>
    public static class ReleaseSignature
    {
        public static readonly Regex Format = new(
            @"^[0-9a-f]{16}:[A-Za-z0-9+/]{86}==$", RegexOptions.Compiled);

        public static byte[] Message(string appId, string platform, string arch, string version,
                                     string sha256, long size)
        {
            var parts = version.Split('.');
            var canonicalVersion = string.Join('.', parts.Select(p => int.Parse(p).ToString()));
            return Encoding.UTF8.GetBytes(
                $"wanderlust-update-v1\n{appId.ToLowerInvariant()}\n{platform}\n{arch}\n" +
                $"{canonicalVersion}\n{sha256.ToLowerInvariant()}\n{size}\n");
        }

        public static string KeyId(byte[] publicKeyXY) =>
            Convert.ToHexString(SHA256.HashData(publicKeyXY)[..8]).ToLowerInvariant();

        /// <summary>
        /// True if <paramref name="signature"/> verifies over <paramref name="message"/> with the
        /// configured key whose id it names. <paramref name="error"/> says why not.
        /// </summary>
        public static bool TryVerify(string signature, byte[] message,
                                     IEnumerable<string> publicKeysBase64, out string error)
        {
            error = "";
            if (!Format.IsMatch(signature)) { error = "the signature is not in <key id>:<base64> form"; return false; }

            var colon = signature.IndexOf(':');
            var keyId = signature[..colon];
            byte[] sig;
            try { sig = Convert.FromBase64String(signature[(colon + 1)..]); }
            catch (FormatException) { error = "the signature is not valid base64"; return false; }
            if (sig.Length != 64) { error = "the signature must be 64 bytes"; return false; }

            foreach (var keyB64 in publicKeysBase64)
            {
                byte[] xy;
                try { xy = Convert.FromBase64String(keyB64); }
                catch (FormatException) { continue; }
                if (xy.Length != 64 || KeyId(xy) != keyId) continue;

                try
                {
                    using var key = ECDsa.Create(new ECParameters
                    {
                        Curve = ECCurve.NamedCurves.nistP256,
                        Q = new ECPoint { X = xy[..32], Y = xy[32..] },
                    });
                    if (key.VerifyData(message, sig, HashAlgorithmName.SHA256)) return true;
                    error = "the signature does not match the release fields";
                    return false;
                }
                catch (CryptographicException)
                {
                    error = "a configured signing public key is not a valid P-256 point";
                    return false;
                }
            }

            error = $"the signature was made with an unknown key (id {keyId})";
            return false;
        }
    }
}
