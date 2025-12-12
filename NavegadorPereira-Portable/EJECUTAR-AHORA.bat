@echo off
title Navegador Pereira - Iniciando
cd /d "%~dp0"

if not exist "chromium\chrome.exe" (
    echo ERROR: Chromium no instalado
    echo Ejecuta INSTALAR-SIMPLE.bat primero
    pause
    exit
)

echo Abriendo Navegador Pereira...
start "" "chromium\chrome.exe" --user-data-dir="%~dp0profile" --disable-background-networking --disable-sync --disable-features=MediaRouter --no-first-run --no-default-browser-check --dns-prefetch-disable --enable-do-not-track

exit
