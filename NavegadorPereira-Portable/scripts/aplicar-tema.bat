@echo off
title Aplicar Tema Vintage
echo.
echo ========================================
echo    APLICANDO TEMA VINTAGE PEREIRA
echo ========================================
echo.

REM Cerrar navegador si está abierto
taskkill /F /IM chrome.exe >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] Navegador cerrado
    timeout /t 2 /nobreak >nul
)

REM Copiar master_preferences
if exist "%~dp0..\config\master_preferences" (
    copy /Y "%~dp0..\config\master_preferences" "%~dp0..\chromium\master_preferences" >nul
    echo [OK] master_preferences aplicado
)

REM Copiar preferencias al perfil
if exist "%~dp0..\config\preferences.json" (
    if not exist "%~dp0..\profile\Default" mkdir "%~dp0..\profile\Default"
    copy /Y "%~dp0..\config\preferences.json" "%~dp0..\profile\Default\Preferences" >nul
    echo [OK] Preferencias vintage aplicadas
)

echo.
echo ========================================
echo    TEMA VINTAGE APLICADO
echo ========================================
echo.
echo Colores vintage en toda la interfaz:
echo - Marco/Frame: Marron oscuro
echo - Barra herramientas: Negro vintage
echo - Pestanas: Texto crema
echo - Enlaces: Dorado antiguo
echo.
echo Ejecuta Pereira.bat para ver los cambios
echo.
pause
