@echo off
chcp 65001 >nul
echo.
echo ═══════════════════════════════════════════════════════
echo   NAVEGADOR PEREIRA - INSTALACION SIMPLE
echo ═══════════════════════════════════════════════════════
echo.
echo OPCION 1: Descarga automática (puede ser lenta)
echo OPCION 2: Descarga manual (más rápido y confiable)
echo.
echo ═══════════════════════════════════════════════════════
echo.
echo OPCION 2 RECOMENDADA - DESCARGA MANUAL:
echo.
echo 1. Abre tu navegador y ve a:
echo    https://chromium.woolyss.com/download/
echo.
echo 2. Busca "Chromium 64-bit (Windows)"
echo.
echo 3. Descarga el archivo ZIP
echo.
echo 4. Extrae el ZIP en esta carpeta:
echo    %~dp0chromium
echo.
echo 5. Asegurate que quede asi:
echo    %~dp0chromium\chrome.exe
echo.
echo 6. Ejecuta: Pereira.bat
echo.
echo ═══════════════════════════════════════════════════════
echo.
echo Presiona ENTER si quieres intentar descarga automatica...
echo (O cierra esta ventana y descarga manualmente)
echo.
pause
echo.
echo Descargando... (esto puede tomar varios minutos)
echo.

powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://download-chromium.appspot.com/dl/Win_x64?type=snapshots' -OutFile 'chromium-temp.zip' -UseBasicParsing; Expand-Archive -Path 'chromium-temp.zip' -DestinationPath '.' -Force; if (Test-Path 'chrome-win') { if (Test-Path 'chromium') { Remove-Item 'chromium' -Recurse -Force }; Rename-Item 'chrome-win' 'chromium' }; Remove-Item 'chromium-temp.zip' -Force; Write-Host 'Instalacion completada!' -ForegroundColor Green}"

echo.
echo ═══════════════════════════════════════════════════════
echo   INSTALACION COMPLETADA
echo ═══════════════════════════════════════════════════════
echo.
echo Para ejecutar el navegador: Pereira.bat
echo.
pause
