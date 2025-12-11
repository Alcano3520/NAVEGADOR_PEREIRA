# DEMO SIMPLE - Descarga y ejecuta Chromium
# Version simplificada sin interaccion

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "  DESCARGANDO CHROMIUM PORTABLE" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# Crear directorio
$demoDir = "$env:USERPROFILE\Desktop\chromium-demo"
Write-Host "Ubicacion: $demoDir" -ForegroundColor Yellow

if (Test-Path $demoDir) {
    Write-Host "Directorio ya existe, usando version existente..." -ForegroundColor Green
} else {
    New-Item -ItemType Directory -Force -Path $demoDir | Out-Null
    Write-Host "Directorio creado" -ForegroundColor Green
}

Set-Location $demoDir

# Verificar si ya esta descargado
$chromePath = "$demoDir\chrome-win\chrome.exe"

if (Test-Path $chromePath) {
    Write-Host ""
    Write-Host "Chromium ya descargado!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "Descargando Chromium (~200MB)..." -ForegroundColor Yellow
    Write-Host "Esto puede tomar 2-5 minutos..." -ForegroundColor Yellow
    Write-Host ""

    $url = "https://download-chromium.appspot.com/dl/Win_x64?type=snapshots"
    $zipFile = "$demoDir\chromium.zip"

    try {
        # Descargar
        Invoke-WebRequest -Uri $url -OutFile $zipFile -UseBasicParsing

        Write-Host "Descarga completa! Extrayendo..." -ForegroundColor Green
        Expand-Archive -Path $zipFile -DestinationPath $demoDir -Force

        Remove-Item $zipFile -Force
        Write-Host "Listo!" -ForegroundColor Green

    } catch {
        Write-Host "ERROR al descargar: $_" -ForegroundColor Red
        Write-Host ""
        Write-Host "Presiona ENTER para cerrar..." -ForegroundColor Yellow
        Read-Host
        exit 1
    }
}

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "  EJECUTANDO CHROMIUM" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Configuraciones de privacidad aplicadas:" -ForegroundColor Green
Write-Host "  - Sin telemetria" -ForegroundColor White
Write-Host "  - Sin sincronizacion Google" -ForegroundColor White
Write-Host "  - Modo incognito" -ForegroundColor White
Write-Host "  - Sin servicios en segundo plano" -ForegroundColor White
Write-Host ""
Write-Host "NOTA: Esta es una DEMO. Tu navegador compilado" -ForegroundColor Yellow
Write-Host "      tendra estas configs en el codigo, no solo flags." -ForegroundColor Yellow
Write-Host ""
Write-Host "Abriendo navegador..." -ForegroundColor Green
Write-Host ""

Start-Sleep -Seconds 1

# Ejecutar Chromium
if (Test-Path $chromePath) {
    Start-Process $chromePath -ArgumentList "--disable-background-networking","--disable-sync","--disable-features=MediaRouter","--no-default-browser-check","--no-first-run","--disable-default-apps","--incognito"

    Write-Host "Chromium ejecutado!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Archivos guardados en:" -ForegroundColor Cyan
    Write-Host "  $demoDir" -ForegroundColor White
    Write-Host ""
    Write-Host "Para ejecutarlo de nuevo, abre:" -ForegroundColor Cyan
    Write-Host "  $chromePath" -ForegroundColor White
} else {
    Write-Host "ERROR: No se encontro chrome.exe" -ForegroundColor Red
    Write-Host "Ruta buscada: $chromePath" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Presiona ENTER para cerrar esta ventana..." -ForegroundColor Yellow
Read-Host
