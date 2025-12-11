@echo off
chcp 65001 >nul
title Navegador Pereira - Instalación
color 0A

echo.
echo ╔═══════════════════════════════════════════════════╗
echo ║    NAVEGADOR PEREIRA - INSTALACION INICIAL       ║
echo ╚═══════════════════════════════════════════════════╝
echo.
echo Esto descargará Chromium portable (~200MB)
echo.
pause

powershell.exe -ExecutionPolicy Bypass -File "%~dp0scripts\instalar.ps1"

echo.
echo ═══════════════════════════════════════════════════
echo   INSTALACION COMPLETADA
echo ═══════════════════════════════════════════════════
echo.
echo Para ejecutar el navegador, abre: Pereira.bat
echo.
pause
