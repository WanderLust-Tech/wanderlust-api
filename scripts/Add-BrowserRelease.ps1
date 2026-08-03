# Add-BrowserRelease.ps1
# Inserts a new row into BrowserReleases (see Migrations/add_browser_releases.sql) --
# the installer metadata the Omaha 4 /v4/update endpoint serves to custom-omaha-client.
# Reads the DB connection string straight out of the real appsettings.*.json used by
# the API itself, so there's nothing to configure separately here.
#
# Usage (hash/size computed automatically from a local installer file):
#   .\Add-BrowserRelease.ps1 -Version 1.7.35.0 -InstallerPath C:\code\custom-browser\src\out\Release\mini_installer.exe
#
# Usage (hash/size supplied explicitly, e.g. the file was hashed elsewhere):
#   .\Add-BrowserRelease.ps1 -Version 1.7.35.0 -HashSha256 <hex> -SizeBytes <n>
#
# -InstallerName/-InstallerUrl default to the "wanderlust-setup-<version>-<platform>-<arch>.exe"
# convention served from this API's own /releases/ static route (see UPDATE_PROTOCOL.md,
# "Installer Hosting" -- Option B). Override -InstallerUrl if hosting on a CDN instead.
#
# Add -DryRun to print what would be inserted without touching the database.
# Add -Environment Development to insert into the dev DB instead of Production.
# The row is created with IsActive = 1, so it's live as soon as it's inserted --
# make sure the installer file itself is already uploaded to wherever InstallerUrl
# points before running this for real.

param(
    [Parameter(Mandatory = $true)]
    [string]$Version,

    [string]$Platform = "win",

    [string]$Arch = "x64",

    [string]$InstallerPath,

    [string]$HashSha256,

    [long]$SizeBytes,

    [string]$InstallerName,

    [string]$InstallerUrl,

    # custom_windows_app_guid from custom-browser/src/custom/custom_browser_config.gni --
    # the one app this fork currently ships, so this is a safe default.
    [string]$AppId = "{8A69D345-D564-463c-AFF1-A69D9E530F96}",

    [ValidateSet("Development", "Production")]
    [string]$Environment = "Production",

    [switch]$DryRun,

    [switch]$Force
)

$ErrorActionPreference = "Stop"

# --- Resolve hash/size, either from the file or from explicit params ----

if ($InstallerPath) {
    if (-not (Test-Path $InstallerPath)) {
        Write-Host "InstallerPath not found: $InstallerPath" -ForegroundColor Red
        exit 1
    }
    if (-not $HashSha256) {
        $HashSha256 = (Get-FileHash -Path $InstallerPath -Algorithm SHA256).Hash.ToLower()
    }
    if (-not $SizeBytes) {
        $SizeBytes = (Get-Item $InstallerPath).Length
    }
}

if (-not $HashSha256 -or -not $SizeBytes) {
    Write-Host "Need either -InstallerPath, or both -HashSha256 and -SizeBytes." -ForegroundColor Red
    exit 1
}

if (-not $InstallerName) {
    $InstallerName = "wanderlust-setup-$Version-$Platform-$Arch.exe"
}

if (-not $InstallerUrl) {
    $InstallerUrl = "https://api.wander-lust.tech/releases/$InstallerName"
}

# --- Resolve the connection string from the real app config -------------

$repoRoot = Split-Path -Parent $PSScriptRoot
$settingsFile = Join-Path $repoRoot "appsettings.$Environment.json"
if (-not (Test-Path $settingsFile)) {
    $settingsFile = Join-Path $repoRoot "appsettings.json"
}

# appsettings*.json in this repo are UTF-16 (BOM) -- Get-Content's default
# encoding mangles them, so this must be read explicitly as Unicode.
$settingsJson = Get-Content $settingsFile -Raw -Encoding Unicode | ConvertFrom-Json
$connectionString = $settingsJson.ConnectionStrings.DefaultConnection
if (-not $connectionString) {
    Write-Host "No ConnectionStrings.DefaultConnection found in $settingsFile" -ForegroundColor Red
    exit 1
}

$maskedConnection = $connectionString -replace 'Password=[^;]*', 'Password=***'

Write-Host "Target: $Environment ($settingsFile)" -ForegroundColor Cyan
Write-Host "Server: $maskedConnection" -ForegroundColor Gray
Write-Host ""
Write-Host "AppId:          $AppId" -ForegroundColor Gray
Write-Host "Version:        $Version" -ForegroundColor Yellow
Write-Host "Platform/Arch:  $Platform / $Arch" -ForegroundColor Gray
Write-Host "InstallerName:  $InstallerName" -ForegroundColor Gray
Write-Host "InstallerUrl:   $InstallerUrl" -ForegroundColor Gray
Write-Host "HashSha256:     $HashSha256" -ForegroundColor Gray
Write-Host "SizeBytes:      $SizeBytes" -ForegroundColor Gray
Write-Host ""

if ($DryRun) {
    Write-Host "(dry run -- nothing inserted)" -ForegroundColor Cyan
    exit 0
}

if (-not $Force) {
    $confirmation = Read-Host "Insert this release into $Environment, live immediately (IsActive=1)? (y/N)"
    if ($confirmation -ne "y" -and $confirmation -ne "Y") {
        Write-Host "Aborted." -ForegroundColor Yellow
        exit 0
    }
}

# --- Insert ---------------------------------------------------------------

Add-Type -AssemblyName "System.Data" -ErrorAction SilentlyContinue

$connection = New-Object System.Data.SqlClient.SqlConnection $connectionString
try {
    $connection.Open()
    $command = $connection.CreateCommand()
    $command.CommandText = @"
INSERT INTO BrowserReleases
    (AppId, Version, Platform, Arch, InstallerName, InstallerUrl, HashSha256, SizeBytes)
OUTPUT INSERTED.Id
VALUES
    (@AppId, @Version, @Platform, @Arch, @InstallerName, @InstallerUrl, @HashSha256, @SizeBytes);
"@
    [void]$command.Parameters.AddWithValue("@AppId", $AppId)
    [void]$command.Parameters.AddWithValue("@Version", $Version)
    [void]$command.Parameters.AddWithValue("@Platform", $Platform)
    [void]$command.Parameters.AddWithValue("@Arch", $Arch)
    [void]$command.Parameters.AddWithValue("@InstallerName", $InstallerName)
    [void]$command.Parameters.AddWithValue("@InstallerUrl", $InstallerUrl)
    [void]$command.Parameters.AddWithValue("@HashSha256", $HashSha256)
    [void]$command.Parameters.AddWithValue("@SizeBytes", $SizeBytes)
    $newId = $command.ExecuteScalar()
    Write-Host "Inserted Id $newId : $Version ($Platform/$Arch)" -ForegroundColor Green
}
finally {
    $connection.Close()
}

Write-Host ""
Write-Host "Done." -ForegroundColor Green
