# VeraCrypt Container Setup - Quick Guide
# Create encrypted container WITHOUT needing USB stick
# Run after opening VeraCrypt

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "VeraCrypt Encrypted Container Setup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "STEP-BY-STEP INSTRUCTIONS:" -ForegroundColor Yellow
Write-Host ""

Write-Host "1. Open VeraCrypt application" -ForegroundColor Cyan
Write-Host "   (Should already be installed)" -ForegroundColor Gray
Write-Host ""

Write-Host "2. Click 'Create Volume' button" -ForegroundColor Cyan
Write-Host ""

Write-Host "3. Select: 'Create an encrypted file container'" -ForegroundColor Cyan
Write-Host "   (NOT 'Encrypt a non-system partition' - that requires USB)" -ForegroundColor Gray
Write-Host "   Click Next" -ForegroundColor Gray
Write-Host ""

Write-Host "4. Select: 'Standard VeraCrypt volume'" -ForegroundColor Cyan
Write-Host "   Click Next" -ForegroundColor Gray
Write-Host ""

Write-Host "5. Volume Location:" -ForegroundColor Cyan
Write-Host "   Click 'Select File...'" -ForegroundColor Gray
Write-Host "   Navigate to: C:\" -ForegroundColor Gray
Write-Host "   File name: BarberX-Vault.hc" -ForegroundColor Yellow
Write-Host "   Click Save, then Next" -ForegroundColor Gray
Write-Host ""

Write-Host "6. Encryption Options:" -ForegroundColor Cyan
Write-Host "   Encryption Algorithm: AES" -ForegroundColor Yellow
Write-Host "   Hash Algorithm: SHA-512" -ForegroundColor Yellow
Write-Host "   Click Next" -ForegroundColor Gray
Write-Host ""

Write-Host "7. Volume Size:" -ForegroundColor Cyan
Write-Host "   Enter: 500" -ForegroundColor Yellow
Write-Host "   Select: MB (megabytes)" -ForegroundColor Yellow
Write-Host "   Click Next" -ForegroundColor Gray
Write-Host ""

Write-Host "8. Volume Password:" -ForegroundColor Cyan
Write-Host "   Enter a STRONG password (20+ characters)" -ForegroundColor Yellow
Write-Host "   Example: BarberX-2026-SecureVault!Justice#Legal" -ForegroundColor Gray
Write-Host "   Re-enter to confirm" -ForegroundColor Gray
Write-Host "   Click Next" -ForegroundColor Gray
Write-Host ""

Write-Host "9. Large Files:" -ForegroundColor Cyan
Write-Host "   Select: 'I will not store files larger than 4 GB'" -ForegroundColor Yellow
Write-Host "   Click Next" -ForegroundColor Gray
Write-Host ""

Write-Host "10. Volume Format:" -ForegroundColor Cyan
Write-Host "    Filesystem: NTFS" -ForegroundColor Yellow
Write-Host "    Move mouse randomly in the window for 30 seconds" -ForegroundColor Yellow
Write-Host "    (This generates encryption keys)" -ForegroundColor Gray
Write-Host "    Click Format" -ForegroundColor Gray
Write-Host ""

Write-Host "11. Wait for formatting (30-60 seconds)" -ForegroundColor Cyan
Write-Host ""

Write-Host "12. Click OK when done" -ForegroundColor Cyan
Write-Host "    Click Exit" -ForegroundColor Gray
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Container Created! Now Mount It:" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "MOUNTING THE CONTAINER:" -ForegroundColor Yellow
Write-Host ""

Write-Host "1. In VeraCrypt main window:" -ForegroundColor Cyan
Write-Host "   Click 'Select File...'" -ForegroundColor Gray
Write-Host "   Navigate to: C:\BarberX-Vault.hc" -ForegroundColor Gray
Write-Host "   Click Open" -ForegroundColor Gray
Write-Host ""

Write-Host "2. Select a drive letter (e.g., Z:)" -ForegroundColor Cyan
Write-Host "   Click from the list on the left" -ForegroundColor Gray
Write-Host ""

Write-Host "3. Click 'Mount' button" -ForegroundColor Cyan
Write-Host ""

Write-Host "4. Enter your password" -ForegroundColor Cyan
Write-Host "   Click OK" -ForegroundColor Gray
Write-Host ""

Write-Host "5. Drive Z: should now appear in Windows Explorer" -ForegroundColor Cyan
Write-Host "   (Encrypted drive, ready to use)" -ForegroundColor Gray
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Now Run This PowerShell Script:" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "After mounting Z: drive, run:" -ForegroundColor Gray
Write-Host ".\scripts\move-to-encrypted-vault.ps1" -ForegroundColor Cyan
Write-Host ""
Write-Host "This will copy your files to the encrypted drive." -ForegroundColor Gray
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Summary:" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Container File: C:\BarberX-Vault.hc (500 MB)" -ForegroundColor Gray
Write-Host "  Encryption: AES-256 + SHA-512" -ForegroundColor Gray
Write-Host "  Mounted As: Z: drive (when unlocked)" -ForegroundColor Gray
Write-Host "  Password: [Your 20+ character password]" -ForegroundColor Gray
Write-Host ""
Write-Host "NO USB STICK REQUIRED for containers!" -ForegroundColor Green
Write-Host ""
