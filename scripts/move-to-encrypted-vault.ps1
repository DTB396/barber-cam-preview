# Move Files to Encrypted VeraCrypt Container
# Run AFTER mounting VeraCrypt container as Z: drive
# Created: January 28, 2026

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Move Files to Encrypted Vault" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Z: drive is mounted
if (-not (Test-Path "Z:\")) {
    Write-Host "✗ ERROR: Z: drive not found!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please mount your VeraCrypt container first:" -ForegroundColor Yellow
    Write-Host "  1. Open VeraCrypt" -ForegroundColor Gray
    Write-Host "  2. Select File: C:\web-dev\github-repos\BarberX.info\BarberX-Vault.hc" -ForegroundColor Gray
    Write-Host "  3. Select drive letter: Z" -ForegroundColor Gray
    Write-Host "  4. Click Mount" -ForegroundColor Gray
    Write-Host "  5. Enter password + PIM value" -ForegroundColor Gray
    Write-Host ""
    exit 1
}

Write-Host "✓ Z: drive mounted and ready" -ForegroundColor Green
Write-Host ""

# Source and destination paths
$sourcePath = "C:\SecureData\BarberX-Confidential"
$destPath = "Z:\BarberX-Confidential"

# Check if source exists
if (-not (Test-Path $sourcePath)) {
    Write-Host "✗ ERROR: Source folder not found: $sourcePath" -ForegroundColor Red
    exit 1
}

# Copy files to encrypted drive
Write-Host "[STEP 1/4] Copying files to encrypted drive..." -ForegroundColor Yellow
Write-Host "  Source: $sourcePath" -ForegroundColor Gray
Write-Host "  Destination: $destPath" -ForegroundColor Gray
Write-Host ""

try {
    Copy-Item -Path $sourcePath -Destination "Z:\" -Recurse -Force
    Write-Host "  ✓ Files copied successfully" -ForegroundColor Green
} catch {
    Write-Host "  ✗ Copy failed: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Verify files were copied
Write-Host "[STEP 2/4] Verifying encrypted copy..." -ForegroundColor Yellow

$encryptedFiles = @(
    "Z:\BarberX-Confidential\Financial-Data\INVESTOR-LOG.md",
    "Z:\BarberX-Confidential\Financial-Data\BarberX_Worst_Case_Cost_Model.xlsx",
    "Z:\BarberX-Confidential\Customer-Data-Exports\founding_member_signups.csv",
    "Z:\BarberX-Confidential\Backups\barberx_FRESH-20260128.db"
)

$allFilesPresent = $true

foreach ($file in $encryptedFiles) {
    if (Test-Path $file) {
        $fileName = Split-Path $file -Leaf
        Write-Host "  ✓ $fileName" -ForegroundColor Green
    } else {
        $fileName = Split-Path $file -Leaf
        Write-Host "  ✗ Missing: $fileName" -ForegroundColor Red
        $allFilesPresent = $false
    }
}

if (-not $allFilesPresent) {
    Write-Host ""
    Write-Host "✗ Some files missing - DO NOT delete originals yet!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "✓ All critical files verified in encrypted vault" -ForegroundColor Green
Write-Host ""

# Show what's in the encrypted drive
Write-Host "[STEP 3/4] Encrypted vault contents:" -ForegroundColor Yellow
Get-ChildItem "Z:\BarberX-Confidential" -Recurse -File | Select-Object FullName, @{Name='SizeKB';Expression={[math]::Round($_.Length/1KB,2)}} | Format-Table -AutoSize

Write-Host ""

# Confirm before deletion
Write-Host "[STEP 4/4] Delete unencrypted originals?" -ForegroundColor Yellow
Write-Host ""
Write-Host "⚠️  WARNING: This will permanently delete:" -ForegroundColor Red
Write-Host "  $sourcePath" -ForegroundColor Gray
Write-Host ""
Write-Host "Your files will ONLY exist in the encrypted Z: drive." -ForegroundColor Yellow
Write-Host ""
$confirmation = Read-Host "Type 'YES' to confirm deletion (or anything else to skip)"

if ($confirmation -eq "YES") {
    Write-Host ""
    Write-Host "Deleting unencrypted originals..." -ForegroundColor Yellow
    
    try {
        Remove-Item -Path $sourcePath -Recurse -Force
        Write-Host "✓ Unencrypted files deleted" -ForegroundColor Green
    } catch {
        Write-Host "✗ Deletion failed: $_" -ForegroundColor Red
        Write-Host "You can manually delete: $sourcePath" -ForegroundColor Yellow
    }
} else {
    Write-Host ""
    Write-Host "Skipped deletion - originals remain at:" -ForegroundColor Yellow
    Write-Host "$sourcePath" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Delete manually when ready:" -ForegroundColor Yellow
    Write-Host "Remove-Item -Recurse -Force '$sourcePath'" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Encryption Complete! ✓" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Your confidential files are now encrypted:" -ForegroundColor Yellow
Write-Host "  Container: C:\BarberX-Vault.hc (500 MB AES-256 encrypted)" -ForegroundColor Gray
Write-Host "  Mounted as: Z: drive (when unlocked)" -ForegroundColor Gray
Write-Host "  Access: Enter password in VeraCrypt to mount" -ForegroundColor Gray
Write-Host ""

Write-Host "Important Reminders:" -ForegroundColor Yellow
Write-Host "  1. NEVER forget your password (cannot be recovered)" -ForegroundColor Red
Write-Host "  2. Store password in Bitwarden (Day 4-5 task)" -ForegroundColor Gray
Write-Host "  3. Unmount Z: when done: VeraCrypt → Select Z: → Dismount" -ForegroundColor Gray
Write-Host "  4. Files only accessible when Z: is mounted" -ForegroundColor Gray
Write-Host ""

Write-Host "To unmount now:" -ForegroundColor Yellow
Write-Host "  Open VeraCrypt → Select Z: → Click Dismount" -ForegroundColor Cyan
Write-Host ""
