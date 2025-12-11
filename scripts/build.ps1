# PowerShell script de compilación para Windows
# Navegador Pereira - Build System

param(
    [string]$BuildType = "Release",
    [int]$Jobs = 0
)

$ErrorActionPreference = "Stop"

$CHROMIUM_DIR = "chromium\src"
$OUTPUT_DIR = "out\$BuildType"

if ($Jobs -eq 0) {
    $Jobs = (Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors
}

Write-Host "=== Navegador Pereira - Build System ===" -ForegroundColor Blue

# Verificar directorio
if (-not (Test-Path $CHROMIUM_DIR)) {
    Write-Host "Error: Directorio Chromium no encontrado" -ForegroundColor Red
    Write-Host "Ejecuta primero: .\scripts\sync-chromium.ps1"
    exit 1
}

Set-Location $CHROMIUM_DIR

Write-Host "[1/5] Aplicando configuraciones de privacidad..." -ForegroundColor Green

# Crear directorios de configuración
New-Item -ItemType Directory -Force -Path "build\config" | Out-Null

# Copiar configuraciones
Copy-Item "..\..\configs\privacy\disable-google-services.gn" "build\config\privacy.gn"
Copy-Item "..\..\configs\performance\optimization.gn" "build\config\performance.gn"

Write-Host "[2/5] Generando archivos GN..." -ForegroundColor Green

# Crear directorio de salida
New-Item -ItemType Directory -Force -Path $OUTPUT_DIR | Out-Null

# Crear args.gn
$argsContent = @"
# Navegador Pereira - Build Configuration
# Auto-generado por scripts/build.ps1

# === IMPORTAR CONFIGURACIONES ===
import("//build/config/privacy.gn")
import("//build/config/performance.gn")

# === BUILD TYPE ===
is_debug = false
is_official_build = true
is_component_build = false

# === COMPILADOR ===
use_thin_lto = true
chrome_pgo_phase = 0
symbol_level = 0

# === VISUAL STUDIO ===
visual_studio_version = "2022"
use_lld = true
win_linker_timing = true

# === OPTIMIZACIONES ===
optimize_webui = true
enable_nacl = false
remove_webcore_debug_symbols = true
exclude_unwind_tables = true

# === PRIVACIDAD ===
enable_google_now = false
enable_hangout_services_extension = false
enable_one_click_signin = false
safe_browsing_mode = 0
enable_reporting = false
use_official_google_api_keys = false
google_api_key = ""
google_default_client_id = ""
google_default_client_secret = ""

# === BRANDING ===
is_chrome_branded = false
chrome_product_full_name = "Navegador Pereira"
chrome_product_short_name = "Pereira"

# === FEATURES ===
enable_extensions = true
enable_pdf = true
enable_print_preview = true
enable_widevine = true
proprietary_codecs = true
ffmpeg_branding = "Chrome"

# === MEDIA ===
enable_av1_decoder = true
enable_dav1d_decoder = true

# === NETWORK ===
enable_quic = true

# === V8 ===
v8_enable_lazy_source_positions = true
v8_enable_fast_mksnapshot = true

# === WINDOWS SPECIFIC ===
target_cpu = "x64"
is_win_fastlink = false
"@

Set-Content -Path "$OUTPUT_DIR\args.gn" -Value $argsContent

Write-Host "[3/5] Ejecutando gn gen..." -ForegroundColor Green
& gn gen $OUTPUT_DIR

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error en gn gen" -ForegroundColor Red
    exit 1
}

Write-Host "[4/5] Compilando Chromium (esto tomará 1-4 horas)..." -ForegroundColor Green
Write-Host "Usando $Jobs cores de CPU" -ForegroundColor Yellow

$startTime = Get-Date

& ninja -C $OUTPUT_DIR chrome -j $Jobs

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error en compilación" -ForegroundColor Red
    exit 1
}

$endTime = Get-Date
$duration = $endTime - $startTime

Write-Host "[5/5] Aplicando parches post-build..." -ForegroundColor Green

# Copiar preferencias
New-Item -ItemType Directory -Force -Path "$OUTPUT_DIR\initial_preferences" | Out-Null
Copy-Item "..\..\configs\privacy\default-preferences.json" "$OUTPUT_DIR\initial_preferences\master_preferences"

# Copiar lista de dominios bloqueados
Copy-Item "..\..\configs\privacy\blocked-domains.txt" "$OUTPUT_DIR\"

Write-Host "========================================" -ForegroundColor Green
Write-Host "✓ Build completado exitosamente" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Binario: $OUTPUT_DIR\chrome.exe" -ForegroundColor Blue
Write-Host "Tiempo de compilación: $($duration.ToString('hh\:mm\:ss'))" -ForegroundColor Cyan
Write-Host ""
Write-Host "Para ejecutar:" -ForegroundColor Yellow
Write-Host "  cd $CHROMIUM_DIR"
Write-Host "  .\$OUTPUT_DIR\chrome.exe"
Write-Host ""
Write-Host "Para crear instalador:" -ForegroundColor Yellow
Write-Host "  .\scripts\package.ps1"
