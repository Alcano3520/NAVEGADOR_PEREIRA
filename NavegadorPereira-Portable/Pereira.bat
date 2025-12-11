@echo off
title Navegador Pereira

REM Obtener directorio del script
set "BASE_DIR=%~dp0"
set "CHROME_EXE=%BASE_DIR%chromium\chrome.exe"
set "PROFILE_DIR=%BASE_DIR%profile"
set "FLAGS_FILE=%BASE_DIR%config\flags.txt"

REM Verificar si Chromium está instalado
if not exist "%CHROME_EXE%" (
    echo.
    echo ERROR: Chromium no encontrado
    echo.
    echo Ejecuta INSTALAR.bat primero para descargar el navegador
    echo.
    pause
    exit /b 1
)

REM Leer flags desde archivo
set "FLAGS="
if exist "%FLAGS_FILE%" (
    for /f "usebackq eol=# tokens=*" %%a in ("%FLAGS_FILE%") do (
        set "FLAGS=!FLAGS! %%a"
    )
)

REM Ejecutar Chromium con configuraciones de privacidad
start "" "%CHROME_EXE%" ^
    --user-data-dir="%PROFILE_DIR%" ^
    --disable-background-networking ^
    --disable-sync ^
    --disable-features=MediaRouter ^
    --disable-default-apps ^
    --no-first-run ^
    --no-default-browser-check ^
    --dns-prefetch-disable ^
    --disable-domain-reliability ^
    --enable-features=ParallelDownloading ^
    --ssl-version-min=tls1.2 ^
    --enable-do-not-track

exit
