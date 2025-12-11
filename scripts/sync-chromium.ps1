# PowerShell version para Windows
# Script de sincronización automática con Chromium upstream

param(
    [switch]$FirstSync,
    [string]$Branch = "main"
)

$ErrorActionPreference = "Stop"

# Configuración
$CHROMIUM_REPO = "https://chromium.googlesource.com/chromium/src.git"
$CHROMIUM_DIR = "chromium"
$LOG_FILE = "sync-$(Get-Date -Format 'yyyyMMdd-HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $color = switch ($Level) {
        "ERROR" { "Red" }
        "WARNING" { "Yellow" }
        "SUCCESS" { "Green" }
        default { "White" }
    }

    $logMessage = "[$timestamp] [$Level] $Message"
    Write-Host $logMessage -ForegroundColor $color
    Add-Content -Path $LOG_FILE -Value $logMessage
}

Write-Host "=== Navegador Pereira - Sincronización con Chromium ===" -ForegroundColor Green

# Verificar depot_tools
try {
    gclient --version | Out-Null
} catch {
    Write-Log "depot_tools no encontrado. Descarga de: https://storage.googleapis.com/chrome-infra/depot_tools.zip" "ERROR"
    exit 1
}

# Verificar Python
try {
    python --version | Out-Null
} catch {
    Write-Log "Python no encontrado. Instala Python 3.8+" "ERROR"
    exit 1
}

# Primera sincronización o actualización
if (-not (Test-Path $CHROMIUM_DIR) -or $FirstSync) {
    Write-Log "Primera sincronización - esto tomará varias horas..." "WARNING"
    Write-Log "Clonando Chromium..."

    New-Item -ItemType Directory -Force -Path $CHROMIUM_DIR | Out-Null
    Set-Location $CHROMIUM_DIR

    # Configurar gclient
    gclient config --name src $CHROMIUM_REPO
    gclient sync --no-history

    Set-Location src
    git remote add upstream $CHROMIUM_REPO
    git checkout -b pereira-main

    Write-Log "Primera sincronización completada" "SUCCESS"
} else {
    Write-Log "Actualizando Chromium existente..."
    Set-Location "$CHROMIUM_DIR\src"

    # Verificar cambios locales
    $hasChanges = git status --porcelain
    if ($hasChanges) {
        Write-Log "Cambios locales detectados, guardando..." "WARNING"
        git stash save "Auto-stash before sync $(Get-Date)"
    }

    # Actualizar desde upstream
    Write-Log "Obteniendo últimos cambios de Chromium..."
    git fetch upstream

    # Versiones
    $currentVersion = git rev-parse HEAD
    $latestVersion = git rev-parse "upstream/$Branch"

    if ($currentVersion -eq $latestVersion) {
        Write-Log "Ya estás en la última versión de Chromium" "SUCCESS"
    } else {
        Write-Log "Nueva versión disponible"
        Write-Log "Versión actual: $($currentVersion.Substring(0,8))"
        Write-Log "Nueva versión: $($latestVersion.Substring(0,8))"

        # Contar commits nuevos
        $newCommits = (git log --oneline "$currentVersion..$latestVersion" | Measure-Object).Count
        Write-Log "Nuevos commits: $newCommits"

        # Buscar commits de seguridad
        $securityCommits = (git log --grep="Security" --grep="CVE" --oneline "$currentVersion..$latestVersion" | Measure-Object).Count
        if ($securityCommits -gt 0) {
            Write-Log "¡$securityCommits commits de SEGURIDAD encontrados!" "WARNING"
        }

        # Merge
        Write-Log "Integrando cambios..."
        try {
            git merge "upstream/$Branch" --no-edit
        } catch {
            Write-Log "Conflictos de merge detectados. Resuelve manualmente." "ERROR"
            exit 1
        }

        # Sincronizar dependencias
        Write-Log "Sincronizando dependencias..."
        gclient sync

        Write-Log "Actualización completada exitosamente" "SUCCESS"
    }

    # Restaurar cambios locales
    $stashList = git stash list
    if ($stashList -match "Auto-stash") {
        Write-Log "Restaurando cambios locales..."
        git stash pop
    }
}

Write-Log "Sincronización completada. Log: $LOG_FILE" "SUCCESS"
Write-Host "✓ Listo para compilar con .\scripts\build.ps1" -ForegroundColor Green
