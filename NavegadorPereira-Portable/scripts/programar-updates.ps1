# Script para programar actualizaciones automaticas mensuales

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "Configurando tarea programada..." -ForegroundColor Cyan
Write-Host ""

$baseDir = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$updateBat = Join-Path $baseDir "ACTUALIZAR.bat"

# Verificar permisos de administrador
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "ERROR: Este script requiere permisos de Administrador" -ForegroundColor Red
    Write-Host ""
    Write-Host "Haz clic derecho en PROGRAMAR-ACTUALIZACIONES.bat" -ForegroundColor Yellow
    Write-Host "y selecciona 'Ejecutar como administrador'" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

# Crear tarea programada
$taskName = "Navegador Pereira - Actualizacion Mensual"

# Eliminar tarea existente si existe
$existingTask = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
if ($existingTask) {
    Write-Host "Eliminando tarea anterior..." -ForegroundColor Yellow
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
}

Write-Host "Creando nueva tarea programada..." -ForegroundColor Green

# Configurar accion
$action = New-ScheduledTaskAction -Execute $updateBat

# Configurar trigger (el día 1 de cada mes a las 3 AM)
$trigger = New-ScheduledTaskTrigger -Monthly -DaysOfMonth 1 -At 3am

# Configurar settings
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

# Crear la tarea
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -Description "Actualiza Navegador Pereira automaticamente el primer dia de cada mes"

Write-Host ""
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Green
Write-Host "  TAREA PROGRAMADA CREADA" -ForegroundColor Green
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor Green
Write-Host ""
Write-Host "Nombre: $taskName" -ForegroundColor Cyan
Write-Host "Frecuencia: Mensual (día 1 a las 3:00 AM)" -ForegroundColor Cyan
Write-Host "Script: $updateBat" -ForegroundColor Cyan
Write-Host ""
Write-Host "Para ver/modificar la tarea:" -ForegroundColor Yellow
Write-Host "  1. Abre el Programador de tareas de Windows" -ForegroundColor White
Write-Host "  2. Busca: $taskName" -ForegroundColor White
Write-Host ""
Write-Host "Para desactivar actualizaciones automáticas:" -ForegroundColor Yellow
Write-Host "  - Elimina la tarea desde el Programador de tareas" -ForegroundColor White
Write-Host ""
