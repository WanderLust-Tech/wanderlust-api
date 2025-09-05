# PowerShell script to replace configuration placeholders with environment variables
# This script is IONOS-compatible as it runs during build, not at runtime

param(
    [string]$ConfigFile = "Configuration\GeneratedConfiguration.cs"
)

Write-Host "Replacing configuration placeholders with build-time values..." -ForegroundColor Green

# Get environment variables with fallbacks
$connectionString = if ($env:BUILD_CONNECTION_STRING) { $env:BUILD_CONNECTION_STRING } else { "Data Source=localhost;Initial Catalog=WanderlustDb;Integrated Security=true;" }
$jwtSecret = if ($env:BUILD_JWT_SECRET_KEY) { $env:BUILD_JWT_SECRET_KEY } else { "DEFAULT_DEVELOPMENT_JWT_SECRET_REPLACE_IN_PRODUCTION" }
$jwtIssuer = if ($env:BUILD_JWT_ISSUER) { $env:BUILD_JWT_ISSUER } else { "WanderlustApi" }
$jwtAudience = if ($env:BUILD_JWT_AUDIENCE) { $env:BUILD_JWT_AUDIENCE } else { "WanderlustClient" }
$jwtExpiration = if ($env:BUILD_JWT_EXPIRATION_MINUTES) { $env:BUILD_JWT_EXPIRATION_MINUTES } else { "60" }
$jwtRefreshExpiration = if ($env:BUILD_JWT_REFRESH_EXPIRATION_DAYS) { $env:BUILD_JWT_REFRESH_EXPIRATION_DAYS } else { "7" }
$frontendUrl = if ($env:BUILD_FRONTEND_URL) { $env:BUILD_FRONTEND_URL } else { "http://localhost:3000" }

Write-Host "Using configuration values:" -ForegroundColor Yellow
Write-Host "- Connection String: $(if ($env:BUILD_CONNECTION_STRING) { "***FROM_ENV***" } else { "localhost" })" -ForegroundColor Gray
Write-Host "- JWT Secret: $(if ($env:BUILD_JWT_SECRET_KEY) { "***FROM_ENV***" } else { "development" })" -ForegroundColor Gray
Write-Host "- Frontend URL: $frontendUrl" -ForegroundColor Gray

# Read the file content
$content = Get-Content $ConfigFile -Raw

# Replace placeholders
$content = $content -replace 'BUILD_TIME_CONNECTION_STRING_PLACEHOLDER', $connectionString
$content = $content -replace 'BUILD_TIME_JWT_SECRET_PLACEHOLDER', $jwtSecret
$content = $content -replace 'BUILD_TIME_JWT_ISSUER_PLACEHOLDER', $jwtIssuer
$content = $content -replace 'BUILD_TIME_JWT_AUDIENCE_PLACEHOLDER', $jwtAudience
$content = $content -replace 'BUILD_TIME_JWT_EXPIRATION_MINUTES_PLACEHOLDER', $jwtExpiration
$content = $content -replace 'BUILD_TIME_JWT_REFRESH_EXPIRATION_DAYS_PLACEHOLDER', $jwtRefreshExpiration
$content = $content -replace 'BUILD_TIME_FRONTEND_URL_PLACEHOLDER', $frontendUrl

# Write the updated content back
Set-Content $ConfigFile -Value $content -NoNewline

Write-Host "Configuration placeholders replaced successfully!" -ForegroundColor Green
