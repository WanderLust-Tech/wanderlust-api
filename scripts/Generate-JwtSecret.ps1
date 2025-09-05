# Generate JWT Secret Key
# This script generates a cryptographically secure 256-bit key for JWT signing

Write-Host "Generating 256-bit JWT Secret Key..." -ForegroundColor Green

# Generate 32 random bytes (256 bits)
$bytes = New-Object byte[] 32
[System.Security.Cryptography.RandomNumberGenerator]::Create().GetBytes($bytes)

# Convert to Base64 string
$jwtSecret = [Convert]::ToBase64String($bytes)

Write-Host ""
Write-Host "Your JWT Secret Key:" -ForegroundColor Yellow
Write-Host $jwtSecret -ForegroundColor White
Write-Host ""
Write-Host "Add this to your GitHub Secrets as 'JWT_SECRET_KEY'" -ForegroundColor Cyan
Write-Host ""

# Also display some info
Write-Host "Key Information:" -ForegroundColor Green
Write-Host "- Length: $($jwtSecret.Length) characters" -ForegroundColor Gray
Write-Host "- Bytes: 32 bytes (256 bits)" -ForegroundColor Gray
Write-Host "- Format: Base64" -ForegroundColor Gray
Write-Host ""
Write-Host "Security Note: Keep this key secret and secure!" -ForegroundColor Red
