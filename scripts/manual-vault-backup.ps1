# ========================================
# Manual Vault Backup to Proton Drive
# ========================================
# Run this weekly after updating confidential files

Write-Host "`n=== WEEKLY VAULT BACKUP ===" -ForegroundColor Cyan

# Step 1: Check if vault is mounted (should be dismounted before backup)
$vaultMounted = Get-PSDrive -Name Z -ErrorAction SilentlyContinue

if ($vaultMounted) {
    Write-Host "`n⚠️  WARNING: Z: drive is mounted!" -ForegroundColor Red
    Write-Host "You should dismount the vault before backing up." -ForegroundColor Yellow
    Write-Host "`nDo you want to:" -ForegroundColor White
    Write-Host "  1. Dismount now and continue backup" -ForegroundColor White
    Write-Host "  2. Cancel backup (I'll dismount manually)" -ForegroundColor White
    
    $choice = Read-Host "`nEnter choice (1 or 2)"
    
    if ($choice -eq "1") {
        Write-Host "`nDismounting Z: drive..." -ForegroundColor Yellow
        Write-Host "Go to VeraCrypt > Select Z: > Click 'Dismount'" -ForegroundColor White
        Write-Host "Press Enter when dismounted..." -ForegroundColor Cyan
        Read-Host
    } else {
        Write-Host "`nBackup cancelled. Dismount Z: first, then run this script again." -ForegroundColor Red
        exit
    }
}

# Step 2: Create timestamped backup name
$timestamp = Get-Date -Format "yyyy-MM-dd"
$vaultPath = "C:\web-dev\github-repos\BarberX.info\BarberX-Vault.hc"
$backupName = "BarberX-Vault-$timestamp.hc"

if (-not (Test-Path $vaultPath)) {
    Write-Host "`n❌ ERROR: Vault file not found at $vaultPath" -ForegroundColor Red
    exit
}

$vaultSize = (Get-Item $vaultPath).Length / 1GB
Write-Host "`n✓ Found vault file" -ForegroundColor Green
Write-Host "  Location: $vaultPath" -ForegroundColor White
Write-Host "  Size: $([math]::Round($vaultSize, 2)) GB" -ForegroundColor White
Write-Host "  Backup name: $backupName" -ForegroundColor Cyan

# Step 3: Upload instructions
Write-Host "`n=== UPLOAD TO PROTON DRIVE ===" -ForegroundColor Yellow
Write-Host "`n1. Open browser: https://drive.proton.me" -ForegroundColor White
Write-Host "2. Navigate to: BarberX-Backups > VeraCrypt-Vaults" -ForegroundColor White
Write-Host "3. Click 'Upload' button (or drag and drop)" -ForegroundColor White
Write-Host "4. Select file: $vaultPath" -ForegroundColor Cyan
Write-Host "5. Rename to: $backupName" -ForegroundColor Cyan
Write-Host "   (This keeps multiple versions organized by date)" -ForegroundColor Gray

Write-Host "`n⏱️  Upload will take ~5-10 minutes (depending on internet speed)" -ForegroundColor Yellow

Write-Host "`nPress Enter when upload is complete..." -ForegroundColor Cyan
Read-Host

# Step 4: Verify backup
Write-Host "`n=== VERIFY BACKUP ===" -ForegroundColor Yellow
Write-Host "In Proton Drive web interface:" -ForegroundColor White
Write-Host "  ✓ Confirm file appears: $backupName" -ForegroundColor White
Write-Host "  ✓ Check file size: ~$([math]::Round($vaultSize, 2)) GB" -ForegroundColor White
Write-Host "  ✓ Note upload date: $(Get-Date -Format 'yyyy-MM-dd HH:mm')" -ForegroundColor White

Write-Host "`nPress Enter after verification..." -ForegroundColor Cyan
Read-Host

# Step 5: Cleanup old versions (optional)
Write-Host "`n=== CLEANUP OLD BACKUPS (OPTIONAL) ===" -ForegroundColor Yellow
Write-Host "If you have multiple backup versions in Proton Drive:" -ForegroundColor White
Write-Host "  - Keep the last 3-4 weekly backups" -ForegroundColor White
Write-Host "  - Delete older versions to save space" -ForegroundColor White
Write-Host "  - Example: Keep Jan 28, Jan 21, Jan 14, Jan 7" -ForegroundColor Gray

Write-Host "`nDid you delete old backups? (y/n)" -ForegroundColor Cyan
$cleanup = Read-Host

# Step 6: Log backup completion
$logPath = "C:\web-dev\github-repos\BarberX.info\BACKUP-LOG.txt"
$logEntry = "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') - Vault backed up to Proton Drive as $backupName"

Add-Content -Path $logPath -Value $logEntry

Write-Host "`n✓ Backup logged to: BACKUP-LOG.txt" -ForegroundColor Green

# Step 7: Summary
Write-Host "`n=== BACKUP COMPLETE ===" -ForegroundColor Green
Write-Host "✓ Vault uploaded to Proton Drive" -ForegroundColor White
Write-Host "✓ Backup name: $backupName" -ForegroundColor White
Write-Host "✓ Size: $([math]::Round($vaultSize, 2)) GB" -ForegroundColor White
Write-Host "✓ Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm')" -ForegroundColor White

Write-Host "`n📅 Next backup: $(Get-Date).AddDays(7).ToString('yyyy-MM-dd')" -ForegroundColor Cyan
Write-Host "   (Set calendar reminder for next week)" -ForegroundColor Gray

Write-Host "`n=== NEXT STEPS ===" -ForegroundColor Yellow
Write-Host "1. You can remount Z: drive now if needed" -ForegroundColor White
Write-Host "2. Add calendar reminder for next weekly backup" -ForegroundColor White
Write-Host "3. Test recovery: Download + mount on another device" -ForegroundColor White

Write-Host "`n✅ Weekly backup complete!" -ForegroundColor Green
