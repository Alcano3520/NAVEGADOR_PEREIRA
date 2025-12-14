@echo off
title Aplicar Tema Vintage
echo.
echo Aplicando tema vintage y configuraciones...
echo.

REM Copiar master_preferences
if exist "%~dp0..\config\master_preferences" (
    copy /Y "%~dp0..\config\master_preferences" "%~dp0..\chromium\master_preferences" >nul
    echo [OK] master_preferences copiado
)

REM Copiar preferencias al perfil
if exist "%~dp0..\config\preferences.json" (
    if not exist "%~dp0..\profile\Default" mkdir "%~dp0..\profile\Default"
    copy /Y "%~dp0..\config\preferences.json" "%~dp0..\profile\Default\Preferences" >nul
    echo [OK] Preferencias de privacidad aplicadas
)

echo.
echo Tema vintage listo!
echo Ejecuta Pereira.bat para ver los cambios
echo.
pause
