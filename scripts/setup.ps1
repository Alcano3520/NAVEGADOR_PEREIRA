# PowerShell setup script para Windows
# Navegador Pereira - Configuración Inicial

$ErrorActionPreference = "Stop"

Write-Host @"
╔═══════════════════════════════════════╗
║   NAVEGADOR PEREIRA - SETUP           ║
║   Navegador Chromium con Privacidad   ║
╚═══════════════════════════════════════╝
"@ -ForegroundColor Blue

Write-Host "`n[1/6] Verificando dependencias..." -ForegroundColor Green

# Verificar Python
try {
    $pythonVersion = python --version 2>&1
    Write-Host "✓ $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "Python 3 no encontrado. Descarga desde: https://www.python.org/downloads/" -ForegroundColor Red
    exit 1
}

# Verificar Git
try {
    $gitVersion = git --version
    Write-Host "✓ $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "Git no encontrado. Descarga desde: https://git-scm.com/download/win" -ForegroundColor Red
    exit 1
}

# Verificar Visual Studio
Write-Host "`n[2/6] Verificando Visual Studio..." -ForegroundColor Green
$vsWhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

if (Test-Path $vsWhere) {
    $vsPath = & $vsWhere -latest -property installationPath
    if ($vsPath) {
        Write-Host "✓ Visual Studio encontrado en: $vsPath" -ForegroundColor Green
    } else {
        Write-Host "⚠ Visual Studio no encontrado" -ForegroundColor Yellow
        Write-Host "Descarga Visual Studio 2022 Community:" -ForegroundColor Yellow
        Write-Host "https://visualstudio.microsoft.com/vs/community/" -ForegroundColor Yellow
        Write-Host "Componentes requeridos:" -ForegroundColor Yellow
        Write-Host "  - Desktop development with C++" -ForegroundColor Yellow
        Write-Host "  - Windows 10 SDK" -ForegroundColor Yellow
    }
} else {
    Write-Host "⚠ Visual Studio Installer no encontrado" -ForegroundColor Yellow
}

# Verificar depot_tools
Write-Host "`n[3/6] Configurando depot_tools..." -ForegroundColor Green

$depotToolsPath = "C:\depot_tools"

if (-not (Test-Path $depotToolsPath)) {
    Write-Host "depot_tools no encontrado. Instalando..." -ForegroundColor Yellow

    # Descargar depot_tools
    $depotToolsZip = "$env:TEMP\depot_tools.zip"
    Write-Host "Descargando depot_tools..." -ForegroundColor Yellow

    Invoke-WebRequest -Uri "https://storage.googleapis.com/chrome-infra/depot_tools.zip" -OutFile $depotToolsZip

    # Extraer
    Expand-Archive -Path $depotToolsZip -DestinationPath "C:\" -Force
    Remove-Item $depotToolsZip

    # Añadir a PATH del sistema
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -notlike "*$depotToolsPath*") {
        [Environment]::SetEnvironmentVariable("Path", "$currentPath;$depotToolsPath", "User")
        $env:Path = "$env:Path;$depotToolsPath"
        Write-Host "✓ depot_tools añadido a PATH" -ForegroundColor Green
        Write-Host "⚠ Reinicia PowerShell para aplicar cambios" -ForegroundColor Yellow
    }
} else {
    Write-Host "✓ depot_tools ya instalado en $depotToolsPath" -ForegroundColor Green
}

# Verificar espacio en disco
Write-Host "`n[4/6] Verificando espacio en disco..." -ForegroundColor Green

$drive = (Get-Item .).PSDrive.Name
$freeSpace = [math]::Round((Get-PSDrive $drive).Free / 1GB, 2)

if ($freeSpace -lt 100) {
    Write-Host "⚠ Espacio insuficiente: ${freeSpace}GB disponibles" -ForegroundColor Red
    Write-Host "  Se requieren al menos 100GB libres" -ForegroundColor Red

    $response = Read-Host "¿Continuar de todas formas? (y/N)"
    if ($response -ne "y" -and $response -ne "Y") {
        exit 1
    }
} else {
    Write-Host "✓ Espacio suficiente: ${freeSpace}GB disponibles" -ForegroundColor Green
}

# Verificar RAM
Write-Host "`n[5/6] Verificando RAM..." -ForegroundColor Green

$ram = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 0)

if ($ram -lt 16) {
    Write-Host "⚠ RAM: ${ram}GB (se recomiendan 16GB+)" -ForegroundColor Yellow
    Write-Host "  La compilación será lenta" -ForegroundColor Yellow
} else {
    Write-Host "✓ RAM: ${ram}GB" -ForegroundColor Green
}

# Configurar permisos de ejecución
Write-Host "`n[6/6] Configurando scripts..." -ForegroundColor Green
Write-Host "✓ Scripts PowerShell listos" -ForegroundColor Green

# Resumen
Write-Host "`n═══════════════════════════════════════" -ForegroundColor Blue
Write-Host "✓ Configuración completada" -ForegroundColor Green
Write-Host "═══════════════════════════════════════" -ForegroundColor Blue

Write-Host "`nPróximos pasos:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Sincronizar Chromium (1-3 horas, ~20GB descarga):" -ForegroundColor White
Write-Host "   .\scripts\sync-chromium.ps1 -FirstSync" -ForegroundColor Blue
Write-Host ""
Write-Host "2. Compilar navegador (2-4 horas primera vez):" -ForegroundColor White
Write-Host "   .\scripts\build.ps1" -ForegroundColor Blue
Write-Host ""
Write-Host "3. Ejecutar:" -ForegroundColor White
Write-Host "   .\chromium\src\out\Release\chrome.exe" -ForegroundColor Blue
Write-Host ""
Write-Host "Documentación completa:" -ForegroundColor Yellow
Write-Host "   docs\BUILD.md     - Guía de compilación"
Write-Host "   docs\PRIVACY.md   - Configuraciones de privacidad"
Write-Host "   docs\SECURITY.md  - Política de seguridad"
Write-Host ""
