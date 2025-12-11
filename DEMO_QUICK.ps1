# DEMO RAPIDA - Prueba Chromium sin compilar (5 minutos)

Write-Host ""
Write-Host "╔═══════════════════════════════════════════════════╗" -ForegroundColor Blue
Write-Host "║  DEMO RAPIDA - Chromium Sin Google Services      ║" -ForegroundColor Blue
Write-Host "║  (Esto NO incluye tus configs personalizadas)    ║" -ForegroundColor Blue
Write-Host "╚═══════════════════════════════════════════════════╝" -ForegroundColor Blue
Write-Host ""

Write-Host "Esto descargara Chromium pre-compilado (~200MB)" -ForegroundColor Yellow
Write-Host "y lo ejecutara con flags de privacidad basicos." -ForegroundColor Yellow
Write-Host ""

$response = Read-Host "Continuar? (y/N)"
if ($response -ne "y" -and $response -ne "Y") {
    Write-Host "Cancelado" -ForegroundColor Red
    exit
}

# Crear directorio temporal
$demoDir = "$env:TEMP\chromium-demo"
New-Item -ItemType Directory -Force -Path $demoDir | Out-Null
Set-Location $demoDir

Write-Host ""
Write-Host "[1/3] Descargando Chromium (~200MB)..." -ForegroundColor Green

# Descargar ultima snapshot
$url = "https://download-chromium.appspot.com/dl/Win_x64?type=snapshots"
$zipFile = "$demoDir\chromium.zip"

try {
    # Mostrar progreso
    $ProgressPreference = 'Continue'
    Invoke-WebRequest -Uri $url -OutFile $zipFile -UseBasicParsing

    Write-Host "[2/3] Extrayendo..." -ForegroundColor Green
    Expand-Archive -Path $zipFile -DestinationPath $demoDir -Force

    Write-Host "[3/3] Ejecutando Chromium con flags de privacidad..." -ForegroundColor Green
    Write-Host ""
    Write-Host "Flags aplicados:" -ForegroundColor Cyan
    Write-Host "  --disable-background-networking (sin telemetria)" -ForegroundColor White
    Write-Host "  --disable-sync (sin sincronizacion Google)" -ForegroundColor White
    Write-Host "  --disable-features=MediaRouter (sin Cast)" -ForegroundColor White
    Write-Host "  --no-default-browser-check" -ForegroundColor White
    Write-Host "  --incognito (modo privado)" -ForegroundColor White

    Write-Host ""
    Write-Host "Chromium se abrira en unos segundos..." -ForegroundColor Green
    Write-Host ""
    Write-Host "Esto es solo una DEMO. Tu navegador personalizado tendra:" -ForegroundColor Yellow
    Write-Host "  - Configuraciones hardcodeadas (no solo flags)" -ForegroundColor Green
    Write-Host "  - Dominios bloqueados permanentemente" -ForegroundColor Green
    Write-Host "  - Sin APIs de Google compiladas" -ForegroundColor Green
    Write-Host "  - Optimizaciones de rendimiento" -ForegroundColor Green

    Start-Sleep -Seconds 2

    # Ejecutar con flags de privacidad
    $chromePath = "$demoDir\chrome-win\chrome.exe"

    if (Test-Path $chromePath) {
        & $chromePath --disable-background-networking --disable-sync --disable-features=MediaRouter --no-default-browser-check --no-first-run --disable-default-apps --incognito
    } else {
        Write-Host "Error: No se encontro chrome.exe en la ubicacion esperada" -ForegroundColor Red
    }

} catch {
    Write-Host "Error: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Puedes descargar manualmente desde:" -ForegroundColor Yellow
    Write-Host "https://www.chromium.org/getting-involved/download-chromium/" -ForegroundColor White
}

Write-Host ""
Write-Host "Listo para compilar TU navegador completo?" -ForegroundColor Cyan
Write-Host "Ejecuta: .\CHECK_REQUIREMENTS.ps1" -ForegroundColor White
Write-Host ""
