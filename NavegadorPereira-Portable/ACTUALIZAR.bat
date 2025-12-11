@echo off
chcp 65001 >nul
title Navegador Pereira - Actualización
color 0B

echo.
echo ╔═══════════════════════════════════════════════════╗
echo ║    NAVEGADOR PEREIRA - ACTUALIZACION             ║
echo ╚═══════════════════════════════════════════════════╝
echo.
echo Esto descargará la última versión de Chromium
echo.
echo IMPORTANTE: Tus marcadores y datos se conservarán
echo.
pause

powershell.exe -ExecutionPolicy Bypass -File "%~dp0scripts\actualizar.ps1"

echo.
echo ═══════════════════════════════════════════════════
echo   ACTUALIZACION COMPLETADA
echo ═══════════════════════════════════════════════════
echo.
pause
