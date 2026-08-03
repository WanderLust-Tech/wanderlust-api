# Add-WhatsNewEntries.ps1
# Inserts one or more chrome://whats-new changelog entries for a release
# into the WhatsNewEntries table (see Migrations/add_whats_new_entries.sql).
# Reads the DB connection string straight out of the real appsettings.*.json
# used by the API itself, so there's nothing to configure separately here.
#
# Usage (bulk, from a JSON file of {title, body} entries):
#   .\Add-WhatsNewEntries.ps1 -Version 1.7.35 -EntriesFile .\scripts\whats-new\1.7.35.json
#
# Usage (single entry, no file needed):
#   .\Add-WhatsNewEntries.ps1 -Version 1.7.35 -Title "New thing" -Body "What it does."
#
# Add -DryRun to print what would be inserted without touching the database.
# Add -Environment Development to insert into the dev DB instead of Production.

param(
    [Parameter(Mandatory = $true)]
    [string]$Version,

    [string]$EntriesFile,

    [string]$Title,

    [string]$Body,

    # custom_windows_app_guid from custom-browser/src/custom/custom_browser_config.gni --
    # the one app this fork currently ships, so this is a safe default.
    [string]$AppId = "{8A69D345-D564-463c-AFF1-A69D9E530F96}",

    [ValidateSet("Development", "Production")]
    [string]$Environment = "Production",

    [switch]$DryRun,

    [switch]$Force
)

$ErrorActionPreference = "Stop"

# --- Gather the entries to insert ---------------------------------------

$entries = @()

if ($EntriesFile) {
    if (-not (Test-Path $EntriesFile)) {
        Write-Host "Entries file not found: $EntriesFile" -ForegroundColor Red
        exit 1
    }
    $parsed = Get-Content $EntriesFile -Raw | ConvertFrom-Json
    foreach ($e in $parsed) {
        if (-not $e.title -or -not $e.body) {
            Write-Host "Every entry in $EntriesFile needs both 'title' and 'body'." -ForegroundColor Red
            exit 1
        }
        $entries += [PSCustomObject]@{ Title = $e.title; Body = $e.body }
    }
}

if ($Title -or $Body) {
    if (-not $Title -or -not $Body) {
        Write-Host "-Title and -Body must both be supplied together." -ForegroundColor Red
        exit 1
    }
    $entries += [PSCustomObject]@{ Title = $Title; Body = $Body }
}

if ($entries.Count -eq 0) {
    Write-Host "Nothing to insert -- pass -EntriesFile <path.json>, or -Title/-Body for a single entry." -ForegroundColor Red
    exit 1
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
Write-Host "Version: $Version   AppId: $AppId" -ForegroundColor Gray
Write-Host ""
foreach ($e in $entries) {
    Write-Host "- $($e.Title)" -ForegroundColor Yellow
    Write-Host "  $($e.Body)" -ForegroundColor Gray
}
Write-Host ""

if ($DryRun) {
    Write-Host "(dry run -- nothing inserted)" -ForegroundColor Cyan
    exit 0
}

if (-not $Force) {
    $confirmation = Read-Host "Insert $($entries.Count) entr$(if ($entries.Count -eq 1) {'y'} else {'ies'}) into $Environment? (y/N)"
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
    foreach ($e in $entries) {
        $command = $connection.CreateCommand()
        $command.CommandText = @"
INSERT INTO WhatsNewEntries (AppId, Version, Title, Body)
OUTPUT INSERTED.Id
VALUES (@AppId, @Version, @Title, @Body);
"@
        [void]$command.Parameters.AddWithValue("@AppId", $AppId)
        [void]$command.Parameters.AddWithValue("@Version", $Version)
        [void]$command.Parameters.AddWithValue("@Title", $e.Title)
        [void]$command.Parameters.AddWithValue("@Body", $e.Body)
        $newId = $command.ExecuteScalar()
        Write-Host "Inserted Id $newId : $($e.Title)" -ForegroundColor Green
    }
}
finally {
    $connection.Close()
}

Write-Host ""
Write-Host "Done." -ForegroundColor Green
