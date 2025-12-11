# Script de instalacion - Descarga Chromium portable

$ErrorActionPreference = "Stop"

$baseDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$chromiumDir = Join-Path $baseDir "chromium"
$configDir = Join-Path $baseDir "config"
$profileDir = Join-Path $baseDir "profile"

Write-Host ""
Write-Host "Directorio base: $baseDir" -ForegroundColor Cyan
Write-Host ""

# Verificar si ya existe
if (Test-Path "$chromiumDir\chrome.exe") {
    Write-Host "Chromium ya esta instalado!" -ForegroundColor Green
    Write-Host "Si quieres actualizar, ejecuta ACTUALIZAR.bat" -ForegroundColor Yellow
    exit 0
}

Write-Host "[1/4] Creando directorios..." -ForegroundColor Green
New-Item -ItemType Directory -Force -Path $chromiumDir | Out-Null
New-Item -ItemType Directory -Force -Path $profileDir | Out-Null
Write-Host "      OK" -ForegroundColor White

Write-Host "[2/4] Descargando Chromium (~200MB)..." -ForegroundColor Green
Write-Host "      Esto puede tomar 2-5 minutos..." -ForegroundColor Yellow

$url = "https://download-chromium.appspot.com/dl/Win_x64?type=snapshots"
$zipFile = Join-Path $baseDir "chromium-temp.zip"

try {
    $ProgressPreference = 'Continue'
    Invoke-WebRequest -Uri $url -OutFile $zipFile -UseBasicParsing
    Write-Host "      Descarga completa" -ForegroundColor White
} catch {
    Write-Host "      ERROR: $_" -ForegroundColor Red
    exit 1
}

Write-Host "[3/4] Extrayendo archivos..." -ForegroundColor Green
try {
    Expand-Archive -Path $zipFile -DestinationPath $baseDir -Force

    # Mover archivos de chrome-win a chromium
    if (Test-Path "$baseDir\chrome-win") {
        Get-ChildItem "$baseDir\chrome-win" | Move-Item -Destination $chromiumDir -Force
        Remove-Item "$baseDir\chrome-win" -Recurse -Force
    }

    Remove-Item $zipFile -Force
    Write-Host "      OK" -ForegroundColor White
} catch {
    Write-Host "      ERROR: $_" -ForegroundColor Red
    exit 1
}

Write-Host "[4/4] Aplicando configuraciones de privacidad..." -ForegroundColor Green

# Copiar preferencias
$prefsSource = Join-Path $configDir "preferences.json"
$prefsTarget = Join-Path $profileDir "Default\Preferences"

New-Item -ItemType Directory -Force -Path (Join-Path $profileDir "Default") | Out-Null

if (Test-Path $prefsSource) {
    Copy-Item $prefsSource $prefsTarget -Force
    Write-Host "      Preferencias aplicadas" -ForegroundColor White
}

Write-Host ""
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "  INSTALACION COMPLETADA!" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Green
Write-Host ""
Write-Host "Ejecutable: $chromiumDir\chrome.exe" -ForegroundColor Cyan
Write-Host "Perfil: $profileDir" -ForegroundColor Cyan
Write-Host ""
Write-Host "Para abrir el navegador, ejecuta: Pereira.bat" -ForegroundColor Yellow
Write-Host ""
