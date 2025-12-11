# Inicio Rápido - Navegador Pereira

**5 pasos para tener tu navegador privado y seguro**

## ⚡ Resumen de 30 Segundos

1. Ejecutar setup
2. Sincronizar Chromium (~2 horas)
3. Compilar (~3 horas)
4. Ejecutar
5. Configurar actualizaciones automáticas

**Tiempo total:** 5-6 horas (mayormente automatizado)

---

## 📋 Paso 1: Setup Inicial (5 minutos)

### Windows

```powershell
# Abrir PowerShell como Administrador
cd C:\Mis_Proyectos\navegador_pereira
.\scripts\setup.ps1
```

### Linux/Mac

```bash
cd navegador_pereira
chmod +x scripts/setup.sh
./scripts/setup.sh
```

**Qué hace:**
- Verifica dependencias
- Instala depot_tools
- Configura permisos

---

## 📥 Paso 2: Sincronizar Chromium (1-3 horas)

**⚠️ IMPORTANTE:** Esta descarga es de ~20-30GB

### Windows

```powershell
.\scripts\sync-chromium.ps1 -FirstSync
```

### Linux/Mac

```bash
./scripts/sync-chromium.sh
```

**Mientras tanto:**
- Toma un café ☕
- Lee la documentación en `docs/`
- Configura GitHub Actions (opcional)

**Progreso:**
```
Clonando Chromium...  [████████░░] 80%
```

---

## 🔨 Paso 3: Compilar (2-4 horas)

### Windows

```powershell
.\scripts\build.ps1
```

### Linux/Mac

```bash
./scripts/build.sh
```

**Qué compila:**
- Motor de renderizado Blink
- Motor JavaScript V8
- Interfaz gráfica
- APIs web completas
- +10 millones de líneas de código

**Monitorear:**
```
[1234/5678] Compiling src/chrome/browser/ui/views/...
```

---

## 🚀 Paso 4: Ejecutar (¡Por fin!)

### Windows

```powershell
.\chromium\src\out\Release\chrome.exe
```

### Linux

```bash
./chromium/src/out/Release/chrome
```

### macOS

```bash
./chromium/src/out/Release/Chromium.app/Contents/MacOS/Chromium
```

**Primera ejecución:**
1. No te pedirá cuenta Google ✓
2. Sin telemetría activa ✓
3. Cookies de terceros bloqueadas ✓
4. Do Not Track activado ✓

---

## 🔐 Paso 5: Configurar Actualizaciones (Crítico para Seguridad)

### Opción A: GitHub Actions (Recomendado)

1. Sube el proyecto a GitHub:

```bash
git init
git add .
git commit -m "Initial commit: Navegador Pereira"
git remote add origin https://github.com/TU-USUARIO/navegador_pereira.git
git push -u origin main
```

2. Las GitHub Actions se ejecutarán automáticamente cada lunes

3. Recibirás issues cuando haya parches de seguridad

### Opción B: Cron Local (Linux/Mac)

```bash
# Editar crontab
crontab -e

# Añadir (ejecutar cada lunes a las 3 AM):
0 3 * * 1 cd /ruta/a/navegador_pereira && ./scripts/sync-chromium.sh
```

### Opción C: Task Scheduler (Windows)

```powershell
# Crear tarea programada
$action = New-ScheduledTaskAction -Execute "powershell.exe" `
    -Argument "-File C:\Mis_Proyectos\navegador_pereira\scripts\sync-chromium.ps1"

$trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday -At 3am

Register-ScheduledTask -TaskName "Sync Navegador Pereira" `
    -Action $action -Trigger $trigger
```

---

## ✅ Verificación Post-Instalación

### 1. Verificar Privacidad

Visita `chrome://settings/privacy` y confirma:
- ❌ SafeBrowsing deshabilitado
- ❌ Sugerencias de búsqueda deshabilitadas
- ✅ Do Not Track habilitado
- ✅ Cookies de terceros bloqueadas

### 2. Verificar Conexiones de Red

```bash
# Linux/Mac - Ver conexiones activas
lsof -i -n -P | grep chrome

# Windows
netstat -ano | findstr "chrome"
```

**Deberías ver:**
- Conexiones a sitios que visitas
- NO conexiones a google.com (excepto si visitas Google)

### 3. Probar Funcionalidad

- [x] Navegar a https://www.youtube.com
- [x] Reproducir video (verificar codecs)
- [x] Probar Netflix (verificar Widevine)
- [x] Descargar archivo
- [x] Imprimir página
- [x] Instalar extensión

---

## 🎨 Personalización Básica

### Cambiar Motor de Búsqueda

1. Ir a `chrome://settings/searchEngines`
2. Añadir:
   - **DuckDuckGo**: `https://duckduckgo.com/?q=%s`
   - **Startpage**: `https://www.startpage.com/do/search?query=%s`
   - **Brave Search**: `https://search.brave.com/search?q=%s`

### Extensiones Recomendadas

Instalar desde Chrome Web Store:

1. **uBlock Origin** - Bloqueador de anuncios/rastreadores
2. **Privacy Badger** - Anti-rastreo inteligente
3. **HTTPS Everywhere** - Forzar HTTPS
4. **Bitwarden** - Gestor de contraseñas

### Tema Oscuro

1. `chrome://settings/appearance`
2. Theme: Dark
3. O instalar tema personalizado

---

## 🔄 Rutina de Mantenimiento

### Semanal

```bash
# Verificar actualizaciones de seguridad
./scripts/security-audit.sh 7
```

### Mensual

```bash
# Sincronizar y recompilar
./scripts/sync-chromium.sh
./scripts/build.sh
```

### Cuando hay CVE crítico

```bash
# Actualización urgente
./scripts/sync-chromium.sh
./scripts/build.sh

# Verificar que se aplicó el parche
cd chromium/src
git log --grep="CVE-YYYY-NNNNN" -1
```

---

## 🆘 Problemas Comunes

### "No se puede ejecutar el navegador"

```bash
# Verificar que la compilación terminó correctamente
ls -lh chromium/src/out/Release/chrome
```

### "Falta una librería (Linux)"

```bash
ldd chromium/src/out/Release/chrome
# Instalar librería faltante con apt/dnf
```

### "Build muy lento"

```bash
# Reducir jobs paralelos
ninja -C chromium/src/out/Release chrome -j 2
```

### "Sitio web no funciona correctamente"

1. Probar en modo incógnito
2. Deshabilitar extensiones temporalmente
3. Verificar en Chrome normal (para comparar)
4. Reportar en GitHub Issues

---

## 📚 Próximos Pasos

Una vez que el navegador funcione:

1. **Lee la documentación completa:**
   - `docs/PRIVACY.md` - Entender configuraciones
   - `docs/SECURITY.md` - Política de seguridad
   - `docs/BUILD.md` - Opciones avanzadas de compilación

2. **Personaliza según tus necesidades:**
   - Modifica `configs/privacy/*.gn`
   - Ajusta `configs/performance/*.gn`
   - Crea parches personalizados en `patches/`

3. **Contribuye al proyecto:**
   - Reporta bugs en GitHub Issues
   - Comparte configuraciones útiles
   - Mejora la documentación

4. **Mantente seguro:**
   - Suscríbete a [Chromium Security Blog](https://chromereleases.googleblog.com/)
   - Monitorea CVEs en [NVD](https://nvd.nist.gov/)
   - Actualiza regularmente

---

## 🎓 Recursos de Aprendizaje

### Entender Chromium

- [The Chromium Projects](https://www.chromium.org/developers/)
- [Chromium Architecture](https://www.chromium.org/developers/design-documents/)
- [How Chromium Displays Web Pages](https://www.chromium.org/developers/design-documents/displaying-a-web-page-in-chrome/)

### Privacidad y Seguridad Web

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Mozilla Web Security](https://infosec.mozilla.org/guidelines/web_security)
- [Privacy Guides](https://www.privacyguides.org/)

---

**¿Listo para empezar?**

```bash
./scripts/setup.sh  # o .ps1 en Windows
```

**¿Necesitas ayuda?**
- GitHub Issues: https://github.com/TU-USUARIO/navegador_pereira/issues
- Documentación: `docs/`
- Chromium Help: https://chromium.googlesource.com/chromium/src/+/main/docs/

---

**Última actualización:** 2025-12-10
