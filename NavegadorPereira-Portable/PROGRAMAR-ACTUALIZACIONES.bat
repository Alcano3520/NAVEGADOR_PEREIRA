@echo off
chcp 65001 >nul
title Navegador Pereira - Programar Actualizaciones Automáticas
color 0E

echo.
echo ╔═══════════════════════════════════════════════════╗
echo ║  PROGRAMAR ACTUALIZACIONES AUTOMATICAS           ║
echo ╚═══════════════════════════════════════════════════╝
echo.
echo Esto creará una tarea programada en Windows que
echo ejecutará ACTUALIZAR.bat automáticamente cada mes
echo.
echo Frecuencia: El día 1 de cada mes a las 3:00 AM
echo.
echo IMPORTANTE: Requiere permisos de Administrador
echo.
pause

powershell.exe -ExecutionPolicy Bypass -File "%~dp0scripts\programar-updates.ps1"

pause
