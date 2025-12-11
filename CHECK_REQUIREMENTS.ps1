# Script de verificacion rapida de requisitos

Write-Host ""
Write-Host "=== VERIFICACION DE REQUISITOS ===" -ForegroundColor Cyan
Write-Host ""

$allGood = $true

# Python
Write-Host "[1/5] Python..." -NoNewline
$pythonExists = Get-Command python -ErrorAction SilentlyContinue
if ($pythonExists) {
    $pyVersion = python --version 2>&1
    Write-Host " OK - $pyVersion" -ForegroundColor Green
}
else {
    Write-Host " FALTA" -ForegroundColor Red
    Write-Host "      Descarga: https://www.python.org/downloads/" -ForegroundColor Yellow
    $allGood = $false
}

# Git
Write-Host "[2/5] Git..." -NoNewline
$gitExists = Get-Command git -ErrorAction SilentlyContinue
if ($gitExists) {
    $gitVersion = git --version
    Write-Host " OK - $gitVersion" -ForegroundColor Green
}
else {
    Write-Host " FALTA" -ForegroundColor Red
    Write-Host "      Descarga: https://git-scm.com/download/win" -ForegroundColor Yellow
    $allGood = $false
}

# Visual Studio
Write-Host "[3/5] Visual Studio 2022..." -NoNewline
$vsWhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"
if (Test-Path $vsWhere) {
    $vsPath = & $vsWhere -latest -property installationPath 2>$null
    if ($vsPath) {
        Write-Host " OK - Instalado" -ForegroundColor Green
    }
    else {
        Write-Host " FALTA" -ForegroundColor Red
        Write-Host "      Descarga: https://visualstudio.microsoft.com/vs/community/" -ForegroundColor Yellow
        Write-Host "      Componentes: Desktop development with C++ + Windows 10 SDK" -ForegroundColor Yellow
        $allGood = $false
    }
}
else {
    Write-Host " NO INSTALADO" -ForegroundColor Red
    Write-Host "      CRITICO: Visual Studio 2022 es obligatorio" -ForegroundColor Red
    Write-Host "      Descarga: https://visualstudio.microsoft.com/vs/community/" -ForegroundColor Yellow
    $allGood = $false
}

# depot_tools
Write-Host "[4/5] depot_tools..." -NoNewline
if (Test-Path "C:\depot_tools") {
    Write-Host " OK - Instalado" -ForegroundColor Green
}
else {
    Write-Host " NO INSTALADO (se instalara automaticamente)" -ForegroundColor Yellow
}

# Espacio en disco
Write-Host "[5/5] Espacio en disco..." -NoNewline
$drive = (Get-Location).Drive.Name
$freeSpace = [math]::Round((Get-PSDrive $drive).Free / 1GB, 2)
if ($freeSpace -ge 100) {
    Write-Host " OK - ${freeSpace} GB disponibles" -ForegroundColor Green
}
else {
    Write-Host " INSUFICIENTE - Solo ${freeSpace} GB (necesitas 100GB+)" -ForegroundColor Red
    $allGood = $false
}

# RAM
$ram = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB, 0)
Write-Host "    RAM:" -NoNewline
if ($ram -ge 16) {
    Write-Host " ${ram} GB (Excelente)" -ForegroundColor Green
}
else {
    Write-Host " ${ram} GB (Minimo 16GB, sera LENTO)" -ForegroundColor Yellow
}

# Cores
$cores = (Get-CimInstance Win32_ComputerSystem).NumberOfLogicalProcessors
Write-Host "    CPU Cores: $cores"

# Estimacion de tiempo
$estimatedHours = 8 - ($cores / 2)
if ($estimatedHours -lt 2) { $estimatedHours = 2 }

Write-Host ""
Write-Host "=== RESUMEN ===" -ForegroundColor Cyan
Write-Host ""

if ($allGood) {
    Write-Host "TODOS LOS REQUISITOS CUMPLIDOS" -ForegroundColor Green
    Write-Host ""
    Write-Host "Tiempo estimado de compilacion: $estimatedHours horas" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Proximo paso:" -ForegroundColor Cyan
    Write-Host "  .\scripts\setup.ps1" -ForegroundColor White
}
else {
    Write-Host "FALTAN REQUISITOS CRITICOS (ver arriba)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Instala lo que falta y vuelve a ejecutar este script" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Quieres ver una DEMO RAPIDA sin compilar? (5 minutos)" -ForegroundColor Cyan
Write-Host "Ejecuta: .\DEMO_QUICK.ps1" -ForegroundColor White
Write-Host ""
