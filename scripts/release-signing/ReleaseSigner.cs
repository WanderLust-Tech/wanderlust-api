// ReleaseSigner -- signs and verifies WanderLust release manifests.
//
// Why: the updater (custom-omaha-client) runs whatever installer the update
// server points it at, as SYSTEM for a machine-wide install. The server, its
// database and its admin accounts are therefore all trusted with code execution
// on every install -- unless the client verifies something the server cannot
// forge. This tool produces that something: an ECDSA P-256 signature, made with
// a private key that never goes near the server, over exactly the fields that
// decide what the client will run. The client embeds the PUBLIC key and refuses
// any release whose signature does not verify.
//
// Run with the .NET 10 SDK (file-based app, nothing to build):
//
//   dotnet run ReleaseSigner.cs -- keygen   <key.pem>
//   dotnet run ReleaseSigner.cs -- pubkey   <key.pem>
//   dotnet run ReleaseSigner.cs -- sign     <key.pem> --app-id {GUID} --platform win --arch x64 \
//                                           --version 1.11.15.0 --installer <file>
//   dotnet run ReleaseSigner.cs -- sign     <key.pem> --app-id ... --version ... \
//                                           --sha256 <64 hex> --size <bytes>
//   dotnet run ReleaseSigner.cs -- verify   --pub <base64> --signature <keyId:base64> \
//                                           --app-id ... --platform ... --arch ... --version ... \
//                                           --sha256 <64 hex> --size <bytes>
//
// The private key file is a passphrase-encrypted PKCS#8 PEM (AES-256, PBKDF2-
// SHA256, 600k iterations): openssl can read it. The passphrase comes from the
// RELEASE_SIGNING_PASSPHRASE environment variable, or is prompted for. KEEP THE
// KEY OFF THE SERVER, OFF THE REPOSITORIES AND BACKED UP OFFLINE -- losing it means
// rotating the client's embedded key, which only reaches users with a new client.
//
// WIRE FORMAT -- keep identical to custom-omaha-client/src/signature_verifier.cc
// and wanderlust-api Services/ReleaseSignature.cs:
//
//   message   = UTF-8 of the following lines, each terminated by "\n":
//                 wanderlust-update-v1
//                 <appId, lower-case, with braces>
//                 <platform: win|linux|mac>
//                 <arch: x64|x86|arm64>
//                 <version: four decimal integers joined by '.', no leading zeros>
//                 <installer SHA-256, lower-case hex>
//                 <installer size in bytes, decimal>
//   signature = ECDSA P-256 over SHA-256(message), 64 bytes r||s (IEEE P1363)
//   public key= 64 bytes X||Y (big-endian), base64
//   keyId     = first 8 bytes of SHA-256(public key bytes), 16 lower-case hex chars
//   string    = "<keyId>:<base64 signature>"   (this is what is stored/served)

using System.Security.Cryptography;
using System.Text;

const string Domain = "wanderlust-update-v1";

if (args.Length == 0) return Usage();

try
{
    switch (args[0])
    {
        case "keygen": return KeyGen(args);
        case "pubkey": return PubKey(args);
        case "sign": return Sign(args);
        case "verify": return Verify(args);
        default: return Usage();
    }
}
catch (Exception e) when (e is ArgumentException or CryptographicException or FormatException or IOException)
{
    Console.Error.WriteLine("error: " + e.Message);
    return 1;
}

static int Usage()
{
    Console.Error.WriteLine("usage: ReleaseSigner keygen <key.pem> | pubkey <key.pem> | sign <key.pem> [options] | verify [options]");
    Console.Error.WriteLine("see the header comment of ReleaseSigner.cs");
    return 2;
}

int KeyGen(string[] a)
{
    if (a.Length != 2) return Usage();
    if (File.Exists(a[1])) throw new IOException($"{a[1]} already exists; refusing to overwrite a signing key.");

    var pass = Passphrase(confirm: true);
    using var key = ECDsa.Create(ECCurve.NamedCurves.nistP256);
    var pem = key.ExportEncryptedPkcs8PrivateKeyPem(pass, new PbeParameters(
        PbeEncryptionAlgorithm.Aes256Cbc, HashAlgorithmName.SHA256, 600_000));
    File.WriteAllText(a[1], pem);

    var pub = PublicKeyBytes(key);
    Console.WriteLine($"wrote {a[1]}  (encrypted; back it up OFFLINE and never commit it)");
    Console.WriteLine($"public key : {Convert.ToBase64String(pub)}");
    Console.WriteLine($"key id     : {KeyId(pub)}");
    Console.WriteLine("Embed the public key in the client build (omaha_signing_public_keys) and, optionally, in the server config (Releases:SigningPublicKeys).");
    return 0;
}

int PubKey(string[] a)
{
    if (a.Length != 2) return Usage();
    using var key = LoadKey(a[1]);
    var pub = PublicKeyBytes(key);
    Console.WriteLine($"public key : {Convert.ToBase64String(pub)}");
    Console.WriteLine($"key id     : {KeyId(pub)}");
    return 0;
}

int Sign(string[] a)
{
    if (a.Length < 2) return Usage();
    var o = Options(a.Skip(2));
    var (appId, platform, arch, version) = Common(o);

    string sha256; long size;
    if (o.TryGetValue("installer", out var path))
    {
        using var fs = File.OpenRead(path);
        size = fs.Length;
        sha256 = Convert.ToHexString(SHA256.HashData(fs)).ToLowerInvariant();
    }
    else
    {
        sha256 = Need(o, "sha256").ToLowerInvariant();
        size = long.Parse(Need(o, "size"));
    }

    using var key = LoadKey(a[1]);
    var pub = PublicKeyBytes(key);
    var msg = Message(appId, platform, arch, version, sha256, size);
    var sig = key.SignData(msg, HashAlgorithmName.SHA256);   // P1363 r||s by default
    var signature = $"{KeyId(pub)}:{Convert.ToBase64String(sig)}";

    // One machine-readable line for scripts, then the human summary.
    Console.WriteLine(
        $"{{\"sha256\":\"{sha256}\",\"size\":{size},\"signature\":\"{signature}\"}}");
    Console.Error.WriteLine($"signed {appId} {platform}/{arch} {version}  sha256={sha256}  size={size}");
    return 0;
}

int Verify(string[] a)
{
    var o = Options(a.Skip(1));
    var (appId, platform, arch, version) = Common(o);
    var pub = Convert.FromBase64String(Need(o, "pub"));
    var signature = Need(o, "signature");
    var parts = signature.Split(':');
    if (parts.Length != 2) throw new FormatException("signature must be <keyId>:<base64>");
    if (parts[0] != KeyId(pub)) { Console.WriteLine("INVALID: signature key id does not match --pub"); return 1; }

    using var key = ECDsa.Create(new ECParameters
    {
        Curve = ECCurve.NamedCurves.nistP256,
        Q = new ECPoint { X = pub[..32], Y = pub[32..] },
    });
    var msg = Message(appId, platform, arch, version, Need(o, "sha256").ToLowerInvariant(), long.Parse(Need(o, "size")));
    var ok = key.VerifyData(msg, Convert.FromBase64String(parts[1]), HashAlgorithmName.SHA256);
    Console.WriteLine(ok ? "VALID" : "INVALID");
    return ok ? 0 : 1;
}

static byte[] Message(string appId, string platform, string arch, string version, string sha256, long size)
{
    if (string.IsNullOrWhiteSpace(appId) || appId[0] != '{') throw new ArgumentException("app id must be a GUID in braces");
    if (platform is not ("win" or "linux" or "mac")) throw new ArgumentException("platform must be win, linux or mac");
    if (arch is not ("x64" or "x86" or "arm64")) throw new ArgumentException("arch must be x64, x86 or arm64");
    if (sha256.Length != 64 || !sha256.All(Uri.IsHexDigit)) throw new ArgumentException("sha256 must be 64 hex characters");
    if (size <= 0) throw new ArgumentException("size must be positive");
    return Encoding.UTF8.GetBytes(
        $"{Domain}\n{appId.ToLowerInvariant()}\n{platform}\n{arch}\n{CanonicalVersion(version)}\n{sha256}\n{size}\n");
}

static string CanonicalVersion(string v)
{
    var parts = v.Split('.');
    if (parts.Length != 4) throw new ArgumentException("version must have four parts, e.g. 1.11.15.0");
    return string.Join('.', parts.Select(p =>
        int.TryParse(p, System.Globalization.NumberStyles.None, null, out var n)
            ? n.ToString()
            : throw new ArgumentException("version parts must be non-negative integers")));
}

static byte[] PublicKeyBytes(ECDsa key)
{
    var q = key.ExportParameters(false).Q;
    return [.. q.X!, .. q.Y!];
}

static string KeyId(byte[] pub) => Convert.ToHexString(SHA256.HashData(pub)[..8]).ToLowerInvariant();

static ECDsa LoadKey(string path)
{
    var key = ECDsa.Create();
    key.ImportFromEncryptedPem(File.ReadAllText(path), Passphrase(confirm: false));
    if (key.KeySize != 256) throw new CryptographicException("the signing key must be ECDSA P-256");
    return key;
}

static string Passphrase(bool confirm)
{
    var env = Environment.GetEnvironmentVariable("RELEASE_SIGNING_PASSPHRASE");
    if (!string.IsNullOrEmpty(env)) return env;

    var first = ReadSecret("passphrase: ");
    if (first.Length < 12 && confirm) throw new ArgumentException("use a passphrase of at least 12 characters");
    if (confirm && ReadSecret("again     : ") != first) throw new ArgumentException("passphrases do not match");
    return first;
}

static string ReadSecret(string prompt)
{
    Console.Error.Write(prompt);
    var sb = new StringBuilder();
    while (true)
    {
        var k = Console.ReadKey(intercept: true);
        if (k.Key == ConsoleKey.Enter) break;
        if (k.Key == ConsoleKey.Backspace) { if (sb.Length > 0) sb.Length--; }
        else if (!char.IsControl(k.KeyChar)) sb.Append(k.KeyChar);
    }
    Console.Error.WriteLine();
    return sb.ToString();
}

static Dictionary<string, string> Options(IEnumerable<string> a)
{
    var d = new Dictionary<string, string>();
    var list = a.ToList();
    for (int i = 0; i < list.Count; i++)
    {
        if (!list[i].StartsWith("--") || i + 1 >= list.Count) throw new ArgumentException($"bad option near '{list[i]}'");
        d[list[i][2..]] = list[++i];
    }
    return d;
}

static string Need(Dictionary<string, string> o, string k) =>
    o.TryGetValue(k, out var v) ? v : throw new ArgumentException($"missing --{k}");

static (string appId, string platform, string arch, string version) Common(Dictionary<string, string> o) =>
    (Need(o, "app-id"), o.GetValueOrDefault("platform", "win"), o.GetValueOrDefault("arch", "x64"), Need(o, "version"));
