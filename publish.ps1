#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Publishing helper script for WanderlustApi
.DESCRIPTION
    This script helps publish the WanderlustApi to various targets using the publishing profiles.
.PARAMETER Profile
    The publishing profile to use (FTP-Production, Local-IIS, FolderProfile, WebDeploy-Production)
.PARAMETER Configuration
    Build configuration (Debug, Release). Default is Release.
.PARAMETER Verbose
    Show detailed output
.EXAMPLE
    .\publish.ps1 -Profile "FolderProfile"
    .\publish.ps1 -Profile "FTP-Production" -Configuration Release -Verbose
#>

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("FTP-Production", "Local-IIS", "FolderProfile", "WebDeploy-Production")]
    [string]$Profile,
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("Debug", "Release")]
    [string]$Configuration = "Release",
    
    [switch]$Verbose
)

# Set error handling
$ErrorActionPreference = "Stop"

# Colors for output
$Red = [System.ConsoleColor]::Red
$Green = [System.ConsoleColor]::Green
$Yellow = [System.ConsoleColor]::Yellow
$Blue = [System.ConsoleColor]::Blue

function Write-ColorOutput {
    param([string]$Message, [System.ConsoleColor]$Color = [System.ConsoleColor]::White)
    $host.UI.RawUI.ForegroundColor = $Color
    Write-Output $Message
    $host.UI.RawUI.ForegroundColor = [System.ConsoleColor]::White
}

function Test-Prerequisites {
    Write-ColorOutput "🔍 Checking prerequisites..." $Blue
    
    # Check if .NET SDK is installed
    try {
        $dotnetVersion = dotnet --version
        Write-ColorOutput "✅ .NET SDK version: $dotnetVersion" $Green
    } catch {
        Write-ColorOutput "❌ .NET SDK not found. Please install .NET 8 SDK." $Red
        exit 1
    }
    
    # Check if project file exists
    if (-not (Test-Path "WanderlustApi.csproj")) {
        Write-ColorOutput "❌ WanderlustApi.csproj not found in current directory." $Red
        Write-ColorOutput "   Current directory: $(Get-Location)" $Yellow
        exit 1
    }
    
    # Check if publish profile exists
    $profilePath = "Properties\PublishProfiles\$Profile.pubxml"
    if (-not (Test-Path $profilePath)) {
        Write-ColorOutput "❌ Publishing profile not found: $profilePath" $Red
        Write-ColorOutput "Available profiles:" $Yellow
        Get-ChildItem "Properties\PublishProfiles\*.pubxml" | ForEach-Object { 
            Write-ColorOutput "   - $($_.BaseName)" $Yellow
        }
        exit 1
    }
    
    Write-ColorOutput "✅ Prerequisites check passed" $Green
}

function Invoke-Publish {
    Write-ColorOutput "🚀 Starting publish process..." $Blue
    Write-ColorOutput "📋 Profile: $Profile" $Blue
    Write-ColorOutput "⚙️  Configuration: $Configuration" $Blue
    
    $publishArgs = @(
        "publish"
        "WanderlustApi.csproj"
        "--configuration", $Configuration
        "--verbosity", $(if ($Verbose) { "detailed" } else { "minimal" })
        "/p:PublishProfile=$Profile"
    )
    
    if ($Profile -eq "Local-IIS") {
        Write-ColorOutput "⚠️  Local IIS deployment may require administrator privileges" $Yellow
    }
    
    try {
        Write-ColorOutput "🔨 Running: dotnet $($publishArgs -join ' ')" $Blue
        & dotnet @publishArgs
        
        if ($LASTEXITCODE -eq 0) {
            Write-ColorOutput "🎉 Publish completed successfully!" $Green
            
            # Post-publish information
            switch ($Profile) {
                "FolderProfile" {
                    $outputPath = "bin\$Configuration\net8.0\publish"
                    Write-ColorOutput "📁 Files published to: $outputPath" $Green
                    if (Test-Path $outputPath) {
                        $fileCount = (Get-ChildItem $outputPath -Recurse -File).Count
                        Write-ColorOutput "📄 Total files: $fileCount" $Green
                    }
                }
                "Local-IIS" {
                    Write-ColorOutput "🌐 Application should be available at: http://localhost/WanderlustApi" $Green
                }
                "FTP-Production" {
                    Write-ColorOutput "🌐 Check your FTP server for the deployed files" $Green
                }
                "WebDeploy-Production" {
                    Write-ColorOutput "🌐 Application deployed via Web Deploy" $Green
                }
            }
        } else {
            Write-ColorOutput "❌ Publish failed with exit code: $LASTEXITCODE" $Red
            exit $LASTEXITCODE
        }
    } catch {
        Write-ColorOutput "❌ Publish failed: $($_.Exception.Message)" $Red
        exit 1
    }
}

function Show-Help {
    Write-ColorOutput @"
🚀 WanderlustApi Publishing Helper

Available Publishing Profiles:
  📁 FolderProfile      - Publish to local folder for manual deployment
  🖥️  Local-IIS         - Deploy to local IIS for testing
  📤 FTP-Production     - Deploy via FTP to production server
  🌐 WebDeploy-Production - Deploy via Web Deploy to production server

Usage Examples:
  .\publish.ps1 -Profile FolderProfile
  .\publish.ps1 -Profile Local-IIS -Verbose
  .\publish.ps1 -Profile FTP-Production -Configuration Release

Before using FTP or WebDeploy profiles, update the credentials in:
  Properties\PublishProfiles\*.pubxml.user
"@ $Blue
}

# Main execution
try {
    Write-ColorOutput "🏗️  WanderlustApi Publishing Tool" $Blue
    Write-ColorOutput "=" * 50 $Blue
    
    Test-Prerequisites
    Invoke-Publish
    
} catch {
    Write-ColorOutput "💥 An unexpected error occurred: $($_.Exception.Message)" $Red
    exit 1
}
