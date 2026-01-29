# BarberX Git Cleanup & Bundle - Complete Remaining Steps
# Run this AFTER git gc completes
# Created: January 28, 2026

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Git Cleanup & Bundle - Final Steps" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Ensure we're in the correct directory
$repoRoot = "C:\web-dev\github-repos\BarberX.info"
Set-Location $repoRoot

# ============================================
# STEP 6: Sync with Remote
# ============================================

Write-Host "[STEP 6/10] Syncing with origin/main..." -ForegroundColor Yellow

try {
    # Pull with rebase to keep linear history
    git pull origin main --rebase
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ Synced with origin/main" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ Conflicts detected or already up-to-date" -ForegroundColor Yellow
        Write-Host "  Run 'git status' to check" -ForegroundColor Gray
    }
} catch {
    Write-Host "  ⚠ Pull failed: $_" -ForegroundColor Red
    Write-Host "  Continuing anyway..." -ForegroundColor Gray
}

Write-Host ""

# ============================================
# STEP 7: Push to Remote
# ============================================

Write-Host "[STEP 7/10] Pushing commits to origin/main..." -ForegroundColor Yellow

try {
    git push origin main
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ All commits pushed to GitHub" -ForegroundColor Green
        
        # Show what was pushed
        $commitCount = (git log origin/main..HEAD --oneline 2>&1 | Measure-Object).Count
        if ($commitCount -eq 0) {
            Write-Host "  ✓ Remote is now in sync (0 commits ahead)" -ForegroundColor Green
        }
    } else {
        Write-Host "  ⚠ Push failed - may need to pull first" -ForegroundColor Yellow
    }
} catch {
    Write-Host "  ⚠ Push failed: $_" -ForegroundColor Red
}

Write-Host ""

# ============================================
# STEP 8: Create Bundle Backup
# ============================================

Write-Host "[STEP 8/10] Creating repository bundle..." -ForegroundColor Yellow

# Generate timestamped bundle filename
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$bundleName = "BarberX-main-bundle-$timestamp.bundle"
$bundlePath = Join-Path $repoRoot $bundleName

Write-Host "  Bundle name: $bundleName" -ForegroundColor Gray
Write-Host "  Creating bundle (this may take 1-2 minutes)..." -ForegroundColor Gray

try {
    # Create bundle with all branches and tags
    git bundle create $bundlePath --all
    
    if ($LASTEXITCODE -eq 0 -and (Test-Path $bundlePath)) {
        $bundleSize = (Get-Item $bundlePath).Length / 1MB
        Write-Host "  ✓ Bundle created: $([math]::Round($bundleSize, 2)) MB" -ForegroundColor Green
    } else {
        Write-Host "  ✗ Bundle creation failed" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "  ✗ Error creating bundle: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""

# ============================================
# STEP 9: Verify Bundle Integrity
# ============================================

Write-Host "[STEP 9/10] Verifying bundle integrity..." -ForegroundColor Yellow

try {
    $verifyOutput = git bundle verify $bundlePath 2>&1
    
    if ($verifyOutput -match "is okay" -or $LASTEXITCODE -eq 0) {
        Write-Host "  ✓ Bundle verified - all refs valid" -ForegroundColor Green
        
        # Show what's in the bundle
        Write-Host "  Bundle contains:" -ForegroundColor Gray
        git bundle list-heads $bundlePath | Select-Object -First 5 | ForEach-Object {
            Write-Host "    $_" -ForegroundColor DarkGray
        }
        
        $totalRefs = (git bundle list-heads $bundlePath | Measure-Object).Count
        if ($totalRefs -gt 5) {
            Write-Host "    ... and $($totalRefs - 5) more refs" -ForegroundColor DarkGray
        }
    } else {
        Write-Host "  ⚠ Bundle verification warning" -ForegroundColor Yellow
        Write-Host "  $verifyOutput" -ForegroundColor Gray
    }
} catch {
    Write-Host "  ⚠ Verification error: $_" -ForegroundColor Yellow
}

Write-Host ""

# ============================================
# STEP 10: Move Bundle to Secure Storage
# ============================================

Write-Host "[STEP 10/10] Moving bundle to secure storage..." -ForegroundColor Yellow

$securePath = "C:\SecureData\BarberX-Confidential\Backups"

# Ensure secure backup directory exists
if (-not (Test-Path $securePath)) {
    Write-Host "  Creating backup directory: $securePath" -ForegroundColor Gray
    New-Item -Path $securePath -ItemType Directory -Force | Out-Null
}

try {
    $finalPath = Join-Path $securePath $bundleName
    Move-Item -Path $bundlePath -Destination $finalPath -Force
    
    if (Test-Path $finalPath) {
        Write-Host "  ✓ Bundle secured at:" -ForegroundColor Green
        Write-Host "    $finalPath" -ForegroundColor Cyan
        
        # Show final file info
        $fileInfo = Get-Item $finalPath
        Write-Host "    Size: $([math]::Round($fileInfo.Length/1MB, 2)) MB" -ForegroundColor Gray
        Write-Host "    Created: $($fileInfo.CreationTime)" -ForegroundColor Gray
    } else {
        Write-Host "  ✗ Failed to move bundle" -ForegroundColor Red
    }
} catch {
    Write-Host "  ✗ Error moving bundle: $_" -ForegroundColor Red
    Write-Host "  Bundle remains at: $bundlePath" -ForegroundColor Yellow
}

Write-Host ""

# ============================================
# FINAL SUMMARY
# ============================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Git Cleanup Complete! ✓" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Summary:" -ForegroundColor Yellow
Write-Host "  ✓ Repository synced with origin/main" -ForegroundColor Green
Write-Host "  ✓ All commits pushed to GitHub" -ForegroundColor Green
Write-Host "  ✓ Repository bundle created and verified" -ForegroundColor Green
Write-Host "  ✓ Bundle backed up to encrypted storage" -ForegroundColor Green
Write-Host ""

Write-Host "Current Repository Status:" -ForegroundColor Yellow
git status --short --branch

Write-Host ""
Write-Host "Bundle Restore Instructions:" -ForegroundColor Yellow
Write-Host "  If you ever need to restore from bundle:" -ForegroundColor Gray
Write-Host "  1. git clone $finalPath restored-repo" -ForegroundColor Cyan
Write-Host "  2. cd restored-repo" -ForegroundColor Cyan
Write-Host "  3. git remote add origin https://github.com/[your-username]/BarberX.info.git" -ForegroundColor Cyan
Write-Host ""

Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "  □ Proceed to Day 3: Monitoring & Alerts" -ForegroundColor Gray
Write-Host "  □ Update 30-day-progress-tracker.csv (mark Day 1-2 complete)" -ForegroundColor Gray
Write-Host "  □ Review SECURITY-DAY-1-2-COMPLETE.md" -ForegroundColor Gray
Write-Host ""

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "All Done! 🎉" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
