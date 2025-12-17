@echo off
title Navegador Pereira

echo.
echo ================================================
echo          NAVEGADOR PEREIRA - VINTAGE
echo ================================================
echo.

REM Verificar si Chromium está instalado
if not exist "%~dp0chromium\chrome.exe" (
    echo ERROR: Chromium no encontrado
    echo.
    echo Ejecuta INSTALAR.bat primero para descargar el navegador
    echo.
    pause
    exit /b 1
)

echo Iniciando navegador con tema vintage...
echo.

REM Ejecutar con PowerShell para mejor compatibilidad
powershell -Command "Start-Process '%~dp0chromium\chrome.exe' -ArgumentList '--user-data-dir=%~dp0profile','--disable-background-networking','--disable-sync','--disable-features=MediaRouter','--disable-default-apps','--no-first-run','--no-default-browser-check','--dns-prefetch-disable','--disable-domain-reliability','--enable-features=ParallelDownloading,WebUIDarkMode,WebContentsForceDark','--ssl-version-min=tls1.2','--enable-do-not-track','--force-dark-mode','--simulate-outdated-no-au=\""Tue, 31 Dec 2099 23:59:59 GMT\""','file:///%~dp0config/nueva-pestana.html' -WindowStyle Normal"

echo.
echo Navegador iniciado correctamente!
echo.
timeout /t 2 /nobreak >nul
