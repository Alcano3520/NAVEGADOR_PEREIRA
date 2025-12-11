# Script de actualizacion - Descarga nueva version de Chromium
# Conserva el perfil del usuario

$ErrorActionPreference = "Stop"

$baseDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$chromiumDir = Join-Path $baseDir "chromium"
$chromiumBackup = Join-Path $baseDir "chromium-backup"
$profileDir = Join-Path $baseDir "profile"

Write-Host ""
Write-Host "Verificando instalacion actual..." -ForegroundColor Cyan

if (-not (Test-Path "$chromiumDir\chrome.exe")) {
    Write-Host ""
    Write-Host "ERROR: Chromium no instalado" -ForegroundColor Red
    Write-Host "Ejecuta INSTALAR.bat primero" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

# Obtener version actual
$currentVersion = "Desconocida"
if (Test-Path "$chromiumDir\chrome.exe") {
    $versionInfo = (Get-Item "$chromiumDir\chrome.exe").VersionInfo
    $currentVersion = $versionInfo.FileVersion
}

Write-Host ""
Write-Host "Version actual: $currentVersion" -ForegroundColor Yellow
Write-Host ""
Write-Host "ADVERTENCIA: Cierra el navegador antes de continuar" -ForegroundColor Red
Write-Host ""
$response = Read-Host "Continuar con la actualizacion? (y/N)"

if ($response -ne "y" -and $response -ne "Y") {
    Write-Host "Actualizacion cancelada" -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "[1/5] Haciendo backup de version actual..." -ForegroundColor Green

if (Test-Path $chromiumBackup) {
    Remove-Item $chromiumBackup -Recurse -Force
}

try {
    Copy-Item $chromiumDir $chromiumBackup -Recurse -Force
    Write-Host "      Backup creado" -ForegroundColor White
} catch {
    Write-Host "      ERROR creando backup: $_" -ForegroundColor Red
    exit 1
}

Write-Host "[2/5] Descargando nueva version (~200MB)..." -ForegroundColor Green

$url = "https://download-chromium.appspot.com/dl/Win_x64?type=snapshots"
$zipFile = Join-Path $baseDir "chromium-update.zip"

try {
    $ProgressPreference = 'Continue'
    Invoke-WebRequest -Uri $url -OutFile $zipFile -UseBasicParsing
    Write-Host "      Descarga completa" -ForegroundColor White
} catch {
    Write-Host "      ERROR descargando: $_" -ForegroundColor Red
    Write-Host "      Restaurando backup..." -ForegroundColor Yellow
    Copy-Item $chromiumBackup $chromiumDir -Recurse -Force
    exit 1
}

Write-Host "[3/5] Eliminando version anterior..." -ForegroundColor Green
Remove-Item $chromiumDir -Recurse -Force

Write-Host "[4/5] Instalando nueva version..." -ForegroundColor Green

try {
    Expand-Archive -Path $zipFile -DestinationPath $baseDir -Force

    # Mover archivos
    if (Test-Path "$baseDir\chrome-win") {
        New-Item -ItemType Directory -Force -Path $chromiumDir | Out-Null
        Get-ChildItem "$baseDir\chrome-win" | Move-Item -Destination $chromiumDir -Force
        Remove-Item "$baseDir\chrome-win" -Recurse -Force
    }

    Remove-Item $zipFile -Force
    Write-Host "      OK" -ForegroundColor White
} catch {
    Write-Host "      ERROR: $_" -ForegroundColor Red
    Write-Host "      Restaurando backup..." -ForegroundColor Yellow
    Copy-Item $chromiumBackup $chromiumDir -Recurse -Force
    exit 1
}

Write-Host "[5/5] Verificando instalacion..." -ForegroundColor Green

if (Test-Path "$chromiumDir\chrome.exe") {
    $newVersion = (Get-Item "$chromiumDir\chrome.exe").VersionInfo.FileVersion
    Write-Host "      Nueva version: $newVersion" -ForegroundColor White

    # Limpiar backup
    Remove-Item $chromiumBackup -Recurse -Force

    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Green
    Write-Host "  ACTUALIZACION EXITOSA!" -ForegroundColor Green
    Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Green
    Write-Host ""
    Write-Host "Version anterior: $currentVersion" -ForegroundColor Cyan
    Write-Host "Version nueva:    $newVersion" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Tus datos (marcadores, historial) se conservaron" -ForegroundColor Yellow
    Write-Host "en: $profileDir" -ForegroundColor Yellow
    Write-Host ""
} else {
    Write-Host "      ERROR: Instalacion fallida" -ForegroundColor Red
    Write-Host "      Restaurando backup..." -ForegroundColor Yellow
    Copy-Item $chromiumBackup $chromiumDir -Recurse -Force
}
