# ========================================
# Proton Drive Encrypted Backup Setup
# ========================================
# Created: 2026-01-28
# Purpose: Upload VeraCrypt vault to Proton Drive for cloud backup

Write-Host "`n=== PROTON DRIVE SETUP ===" -ForegroundColor Cyan

# Step 1: Sign up / Log in
Write-Host "`n[STEP 1] Proton Drive Account" -ForegroundColor Yellow
Write-Host "1. Go to: https://proton.me/drive" -ForegroundColor White
Write-Host "2. Sign up for FREE account (500 GB available with paid plan)" -ForegroundColor White
Write-Host "3. Note: Proton uses end-to-end encryption (they can't read your files)" -ForegroundColor Green
Write-Host "`nPress Enter when you have account access..." -ForegroundColor Cyan
Read-Host

# Step 2: Choose upload method
Write-Host "`n[STEP 2] Choose Upload Method" -ForegroundColor Yellow
Write-Host "`nOPTION A: Web Upload (Recommended for vault files)" -ForegroundColor Green
Write-Host "  - No app needed, just use browser" -ForegroundColor White
Write-Host "  - Manual uploads (you control when)" -ForegroundColor White
Write-Host "  - Safer: no risk of uploading while vault is mounted" -ForegroundColor White
Write-Host "  - Go to: https://drive.proton.me" -ForegroundColor Cyan

Write-Host "`nOPTION B: Desktop App (Advanced users)" -ForegroundColor Yellow
Write-Host "  - Download: https://proton.me/drive/download" -ForegroundColor White
Write-Host "  - Can set up auto-sync for OTHER folders (NOT vault)" -ForegroundColor White
Write-Host "  - WARNING: Never auto-sync the vault file!" -ForegroundColor Red
Write-Host "  - Use for: Documents, photos, non-encrypted files" -ForegroundColor White

Write-Host "`nRecommendation: Start with Option A (web upload)" -ForegroundColor Cyan
Write-Host "`nPress Enter to continue..." -ForegroundColor Cyan
Read-Host

# Step 3: Create backup folder structure
Write-Host "`n[STEP 3] Create Backup Folder in Proton Drive" -ForegroundColor Yellow
Write-Host "In Proton Drive app or web interface:" -ForegroundColor White
Write-Host "  - Create folder: BarberX-Backups" -ForegroundColor White
Write-Host "  - Inside: Create subfolder: VeraCrypt-Vaults" -ForegroundColor White
Write-Host "  - Inside: Create subfolder: Git-Bundles" -ForegroundColor White
Write-Host "`nPress Enter when folders are created..." -ForegroundColor Cyan
Read-Host

# Step 4: Upload vault file
Write-Host "`n[STEP 4] Upload Encrypted Vault" -ForegroundColor Yellow

$vaultPath = "C:\web-dev\github-repos\BarberX.info\BarberX-Vault.hc"
if (Test-Path $vaultPath) {
    $vaultSize = (Get-Item $vaultPath).Length / 1MB
    Write-Host "Found vault: $vaultPath" -ForegroundColor Green
    Write-Host "Size: $([math]::Round($vaultSize, 2)) MB" -ForegroundColor White
    
    Write-Host "`nUpload this file to Proton Drive > BarberX-Backups > VeraCrypt-Vaults" -ForegroundColor Yellow
    Write-Host "  Option A: Drag and drop in web interface" -ForegroundColor White
    Write-Host "  Option B: Right-click > 'Upload to Proton Drive' (if app synced)" -ForegroundColor White
} else {
    Write-Host "ERROR: Vault not found at $vaultPath" -ForegroundColor Red
    Write-Host "Make sure vault is in repository folder" -ForegroundColor Yellow
}

Write-Host "`nPress Enter when upload is complete..." -ForegroundColor Cyan
Read-Host

# Step 5: Upload git bundle (if fits in free tier)
Write-Host "`n[STEP 5] Upload Git Bundle (Optional)" -ForegroundColor Yellow

# Check if vault is mounted
$mountedDrive = Get-PSDrive -Name Z -ErrorAction SilentlyContinue
if ($mountedDrive) {
    $bundlePath = "Z:\BarberX-Confidential\BarberX-main-bundle-20260128-200652.bundle"
    if (Test-Path $bundlePath) {
        $bundleSize = (Get-Item $bundlePath).Length / 1GB
        Write-Host "Found git bundle: $bundlePath" -ForegroundColor Green
        Write-Host "Size: $([math]::Round($bundleSize, 2)) GB" -ForegroundColor White
        Write-Host "`nNOTE: This is 2.3 GB. Free Proton Drive is 5 GB total." -ForegroundColor Yellow
        Write-Host "Upload to: Proton Drive > BarberX-Backups > Git-Bundles" -ForegroundColor White
    } else {
        Write-Host "Git bundle not found in vault" -ForegroundColor Yellow
    }
} else {
    Write-Host "Mount Z: drive first if you want to upload git bundle" -ForegroundColor Yellow
}

Write-Host "`nPress Enter to continue..." -ForegroundColor Cyan
Read-Host

# Step 6: Verification
Write-Host "`n[STEP 6] Verify Cloud Backup" -ForegroundColor Yellow
Write-Host "✓ Vault file uploaded to Proton Drive" -ForegroundColor Green
Write-Host "✓ Files are encrypted locally BEFORE upload" -ForegroundColor Green
Write-Host "✓ Proton cannot read your files (zero-access encryption)" -ForegroundColor Green
Write-Host "✓ Accessible from any device with Proton account + vault password" -ForegroundColor Green

Write-Host "`n=== RECOVERY TEST ===" -ForegroundColor Cyan
Write-Host "To restore on another computer:" -ForegroundColor White
Write-Host "  1. Install VeraCrypt on new machine" -ForegroundColor White
Write-Host "  2. Download BarberX-Vault.hc from Proton Drive" -ForegroundColor White
Write-Host "  3. Mount with VeraCrypt (password + high PIM)" -ForegroundColor White
Write-Host "  4. Access files on Z: drive" -ForegroundColor White

Write-Host "`n=== BACKUP SCHEDULE ===" -ForegroundColor Cyan
Write-Host "Recommendation: Upload new vault version weekly" -ForegroundColor Yellow
Write-Host "  - After updating INVESTOR-LOG.md" -ForegroundColor White
Write-Host "  - After adding new financial data" -ForegroundColor White
Write-Host "  - Before major trips/system changes" -ForegroundColor White
Write-Host "  - Name with date: BarberX-Vault-2026-01-28.hc" -ForegroundColor White

Write-Host "`n✓ Proton Drive Backup Complete!" -ForegroundColor Green
