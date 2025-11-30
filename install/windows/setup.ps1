# Windows Setup Script
# Run this in PowerShell as Administrator

Write-Host "→ Starting Windows setup..." -ForegroundColor Cyan

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "✗ Please run this script as Administrator" -ForegroundColor Red
    exit 1
}

# Install winget if not present (comes with Windows 11 by default)
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "→ Installing winget..." -ForegroundColor Yellow
    # winget should be pre-installed on Windows 11, manual installation needed for Windows 10
    Write-Host "Please install App Installer from the Microsoft Store to get winget" -ForegroundColor Yellow
    exit 1
}

# Install packages from winget-packages.txt
Write-Host "→ Installing Windows packages via winget..." -ForegroundColor Cyan
$packagesFile = Join-Path $PSScriptRoot "winget-packages.txt"
if (Test-Path $packagesFile) {
    Get-Content $packagesFile | Where-Object { $_ -notmatch '^\s*#' -and $_ -match '\S' } | ForEach-Object {
        Write-Host "  Installing: $_" -ForegroundColor Green
        winget install --id $_ --silent --accept-package-agreements --accept-source-agreements
    }
}

# Enable WSL2
Write-Host "→ Checking WSL2..." -ForegroundColor Cyan
if (-not (Get-Command wsl -ErrorAction SilentlyContinue)) {
    Write-Host "  Installing WSL2..." -ForegroundColor Yellow
    wsl --install --no-distribution
    Write-Host "  Please reboot and run this script again after reboot" -ForegroundColor Yellow
    exit 0
} else {
    Write-Host "  WSL2 already installed" -ForegroundColor Green
}

# Install Ubuntu in WSL2 (or your preferred distro)
Write-Host "→ Checking for WSL Ubuntu distribution..." -ForegroundColor Cyan
$distros = wsl --list --quiet
if ($distros -notcontains "Ubuntu") {
    Write-Host "  Installing Ubuntu in WSL2..." -ForegroundColor Yellow
    wsl --install --distribution Ubuntu
}

Write-Host "✓ Windows setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Open WSL2 (Ubuntu) from Windows Terminal" -ForegroundColor White
Write-Host "2. Clone this repo inside WSL2: git clone <your-repo>" -ForegroundColor White
Write-Host "3. Run 'make' inside WSL2 to set up your Linux environment" -ForegroundColor White
