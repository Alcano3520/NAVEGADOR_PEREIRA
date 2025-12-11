# 🌐 Navegador Pereira

**Navegador web basado en Chromium con enfoque en privacidad, rendimiento y seguridad**

[![Licencia](https://img.shields.io/badge/license-BSD--3--Clause-blue.svg)](LICENSE)
[![Chromium](https://img.shields.io/badge/based%20on-Chromium-brightgreen.svg)](https://www.chromium.org/)
[![Privacidad](https://img.shields.io/badge/privacy-first-success.svg)]()

---

## 🎯 Dos Versiones Disponibles

Este repositorio ofrece **DOS formas** de tener tu navegador con privacidad:

### 📦 **OPCIÓN 1: Versión Portable** ⭐ RECOMENDADA ⭐

**✅ Lista para usar, sin compilar**

- 📂 Carpeta: `NavegadorPereira-Portable/`
- ⚡ Listo en 5 minutos
- 💾 100% portable (funciona desde USB)
- 🔄 Actualización automática con scripts
- 📦 NO requiere compilar nada

👉 **[IR A LA GUÍA PORTABLE](#-versión-portable-recomendada)**

---

### 🛠️ **OPCIÓN 2: Compilar desde Fuente**

**Para usuarios avanzados que quieren compilar Chromium**

- 📂 Carpeta raíz del proyecto
- ⏱️ Toma 5-6 horas
- 💻 Requiere Visual Studio, 100GB espacio, 16GB+ RAM
- 🔧 Control total del código fuente
- 🎓 Aprendizaje profundo de navegadores

👉 **[IR A LA GUÍA DE COMPILACIÓN](#-compilar-desde-fuente)**

---

## 📦 Versión Portable (RECOMENDADA)

### ✨ Características

- ✅ **100% Portable**: Funciona desde USB, disco externo, carpeta
- ✅ **Sin telemetría Google**: 0 conexiones a servicios Google
- ✅ **Privacidad hardcodeada**: Configuraciones aplicadas en código
- ✅ **Actualizaciones fáciles**: Scripts automatizados
- ✅ **Sin compilar**: Descarga Chromium pre-compilado y aplica configs
- ✅ **Perfil portable**: Tus marcadores viajan contigo
- ✅ **Dominios bloqueados**: Lista de rastreadores bloqueados

### 🚀 Inicio Rápido (3 pasos)

#### 1️⃣ Descargar el proyecto

```bash
git clone https://github.com/Alcano3520/NAVEGADOR_PEREIRA.git
cd NAVEGADOR_PEREIRA/NavegadorPereira-Portable
```

#### 2️⃣ Instalar (primera vez - 5 minutos)

**Windows:**
```batch
Doble clic en: INSTALAR.bat
```

**O por línea de comandos:**
```powershell
.\INSTALAR.bat
```

Esto descargará Chromium (~200MB) y aplicará todas las configuraciones de privacidad.

#### 3️⃣ Ejecutar el navegador

```batch
Doble clic en: Pereira.bat
```

¡Listo! El navegador se abre con todas las configuraciones de privacidad aplicadas.

### 📁 Estructura de la Versión Portable

```
NavegadorPereira-Portable/
│
├── 🚀 Pereira.bat                    ← EJECUTAR navegador
├── 📥 INSTALAR.bat                   ← Instalar (primera vez)
├── 🔄 ACTUALIZAR.bat                 ← Actualizar navegador
├── ⏰ PROGRAMAR-ACTUALIZACIONES.bat  ← Auto-update mensual
│
├── 📄 README.txt                     ← Guía rápida
├── 📄 COMO-USAR.txt                  ← Guía completa
│
├── 📂 config/                        ← Configuraciones
│   ├── preferences.json              ← Preferencias de privacidad
│   ├── blocked-domains.txt           ← Dominios bloqueados
│   └── flags.txt                     ← Flags de Chromium
│
├── 📂 profile/                       ← Tu perfil (marcadores, etc.)
├── 📂 chromium/                      ← Binarios (se descarga)
└── 📂 scripts/                       ← Scripts internos
```

### 🔄 Actualizar el Navegador

**Opción A - Manual (mensual recomendado):**
```batch
.\ACTUALIZAR.bat
```

**Opción B - Automático:**
```batch
.\PROGRAMAR-ACTUALIZACIONES.bat
```
Esto programa una tarea que actualiza automáticamente cada mes.

### 💼 Hacer Portable (USB)

1. Copia TODA la carpeta `NavegadorPereira-Portable`
2. Pégala en USB, disco externo, o donde quieras
3. Ejecuta `Pereira.bat` desde la nueva ubicación

¡Todo funciona igual desde cualquier lugar!

### 🔒 Configuraciones de Privacidad Incluidas

#### Preferencias (`config/preferences.json`):
- ❌ SafeBrowsing de Google deshabilitado
- ❌ Sincronización con cuenta Google deshabilitada
- ❌ Cookies de terceros bloqueadas
- ❌ Telemetría deshabilitada
- ❌ Precarga DNS deshabilitada
- ❌ Sugerencias de búsqueda deshabilitadas
- ✅ Do Not Track activado
- ✅ HTTPS preferido (TLS 1.2+)

#### Dominios Bloqueados (`config/blocked-domains.txt`):
```
clients*.google.com       # Telemetría Google
analytics.google.com      # Google Analytics
doubleclick.net          # Ads
safebrowsing.google.com  # SafeBrowsing
googleadservices.com     # Ads
facebook.com/pixel       # Tracking Facebook
...y más
```

#### Flags de Chromium (`config/flags.txt`):
```
--disable-background-networking   # Sin telemetría
--disable-sync                    # Sin sincronización
--dns-prefetch-disable           # Sin precarga DNS
--enable-do-not-track            # Do Not Track
--ssl-version-min=tls1.2         # TLS mínimo 1.2
...y más
```

### ⚙️ Personalizar Configuraciones

Puedes editar estos archivos para personalizar:

**Cambiar preferencias:**
```
Edita: config/preferences.json
Reinicia el navegador
```

**Bloquear más dominios:**
```
Edita: config/blocked-domains.txt
Añade dominios (uno por línea)
```

**Modificar flags:**
```
Edita: config/flags.txt
Añade/elimina flags
Reinicia el navegador
```

### 📚 Documentación Completa

- **README.txt** - Guía rápida de inicio
- **COMO-USAR.txt** - Guía completa con todos los detalles
- Ambos archivos están en la carpeta `NavegadorPereira-Portable/`

---

## 🛠️ Compilar desde Fuente

Si prefieres compilar Chromium completamente desde el código fuente con tus propias modificaciones:

### 📋 Requisitos

- **OS**: Windows 10/11, Linux, macOS
- **RAM**: 16GB mínimo (32GB recomendado)
- **Disco**: 100GB+ espacio libre
- **CPU**: 8+ cores recomendado
- **Tiempo**: 2-4 horas primera compilación

**Herramientas:**
- Python 3.8+
- Git
- Visual Studio 2022 (Windows) / GCC/Clang (Linux/Mac)
- depot_tools (Google)

### 🚀 Proceso de Compilación

#### 1. Clonar repositorio

```bash
git clone https://github.com/Alcano3520/NAVEGADOR_PEREIRA.git
cd NAVEGADOR_PEREIRA
```

#### 2. Setup inicial

**Windows:**
```powershell
.\scripts\setup.ps1
```

**Linux/Mac:**
```bash
./scripts/setup.sh
```

#### 3. Sincronizar Chromium (1-3 horas, ~20GB)

**Windows:**
```powershell
.\scripts\sync-chromium.ps1 -FirstSync
```

**Linux/Mac:**
```bash
./scripts/sync-chromium.sh
```

#### 4. Compilar (2-4 horas)

**Windows:**
```powershell
.\scripts\build.ps1
```

**Linux/Mac:**
```bash
./scripts/build.sh
```

#### 5. Ejecutar

**Windows:**
```powershell
.\chromium\src\out\Release\chrome.exe
```

**Linux:**
```bash
./chromium/src/out/Release/chrome
```

**macOS:**
```bash
./chromium/src/out/Release/Chromium.app/Contents/MacOS/Chromium
```

### 📚 Documentación de Compilación

- **[QUICK_START.md](QUICK_START.md)** - Guía rápida de compilación
- **[docs/BUILD.md](docs/BUILD.md)** - Guía completa de compilación
- **[docs/PRIVACY.md](docs/PRIVACY.md)** - Configuraciones de privacidad
- **[docs/SECURITY.md](docs/SECURITY.md)** - Política de seguridad
- **[docs/FAQ.md](docs/FAQ.md)** - Preguntas frecuentes

### 🔐 Seguridad y Actualizaciones

#### Sincronización Automática (CI/CD)

El proyecto incluye GitHub Actions para:
- ✅ Sincronización semanal con Chromium upstream
- ✅ Detección automática de parches de seguridad
- ✅ Creación de issues cuando hay CVEs
- ✅ Reportes de auditoría de seguridad

Ver: `.github/workflows/auto-sync-chromium.yml`

#### Actualización Manual

```bash
./scripts/sync-chromium.sh    # Sincronizar con Chromium
./scripts/security-audit.sh   # Auditar parches de seguridad
./scripts/build.sh            # Recompilar
```

---

## 📊 Comparación: Portable vs Compilar

| Característica | Versión Portable | Compilar desde Fuente |
|----------------|------------------|----------------------|
| **Tiempo de setup** | 5 minutos | 5-6 horas |
| **Espacio en disco** | ~500 MB | ~100 GB |
| **Requiere compilar** | ❌ No | ✅ Sí |
| **Privacidad** | ✅ Alta | ✅ Alta |
| **Portable** | ✅ Sí | ⚠️ Requiere empaquetado |
| **Actualizaciones** | ✅ Scripts automáticos | ⚠️ Manual/CI/CD |
| **Control del código** | ⚠️ Usa binarios pre-compilados | ✅ Total |
| **Dificultad** | ⭐ Fácil | ⭐⭐⭐⭐⭐ Avanzado |
| **Recomendado para** | Usuarios normales | Desarrolladores |

---

## 🔒 Características de Privacidad

Ambas versiones incluyen:

### ❌ Servicios Google Deshabilitados

| Servicio | Estado | Alternativa |
|----------|--------|-------------|
| Google Analytics | ❌ Bloqueado | - |
| Crash Reporting | ❌ Deshabilitado | - |
| Google Sync | ❌ Deshabilitado | Sync local/propio |
| Google DNS | ❌ Bloqueado | DNS del sistema |
| SafeBrowsing | ❌ Deshabilitado | Listas locales |
| Google Translate | ❌ Deshabilitado | Extensiones |

### ✅ Configuraciones Activas

- ✅ **Cookies de terceros bloqueadas**
- ✅ **Do Not Track habilitado**
- ✅ **Referrers deshabilitados**
- ✅ **DNS prefetch deshabilitado**
- ✅ **Precarga de páginas deshabilitada**
- ✅ **HTTPS preferido (TLS 1.2+)**
- ✅ **Permisos sensibles denegados por defecto**

### 🚫 Dominios Bloqueados

- Google telemetría y analytics
- Redes de publicidad (DoubleClick, etc.)
- Rastreadores de terceros
- Beacons de telemetría
- Píxeles de tracking

---

## 📱 Compatibilidad

### Sistemas Operativos

- ✅ **Windows 10/11** (Portable y compilar)
- ✅ **Linux** (Ubuntu, Debian, Fedora - solo compilar)
- ✅ **macOS** (Intel y Apple Silicon - solo compilar)

### Funcionalidades Web

- ✅ YouTube, Netflix, Spotify (con Widevine DRM)
- ✅ Office 365, Google Docs (sin telemetría)
- ✅ Extensiones de Chrome Web Store
- ✅ Todos los estándares web modernos
- ✅ WebRTC, WebGL, WebGPU
- ✅ HTTP/3 (QUIC)

---

## 🤝 Contribuir

¡Las contribuciones son bienvenidas!

1. Fork el proyecto
2. Crea una rama (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -m 'Añadir nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

### Áreas de Contribución

- 📝 Mejorar documentación
- 🔒 Nuevas configuraciones de privacidad
- 🤖 Automatización y scripts
- 🐛 Reportar bugs
- 🌍 Traducciones

---

## 📄 Licencia

Este proyecto está licenciado bajo **BSD-3-Clause** (misma que Chromium).

Ver archivo [LICENSE](LICENSE) para más detalles.

**Nota:** Este proyecto está basado en Chromium, que es mantenido por Google y la comunidad. La licencia completa de Chromium se encuentra en el código fuente descargado.

---

## 🔗 Enlaces Útiles

- **Chromium Releases**: https://chromereleases.googleblog.com/
- **Chromium Source**: https://chromium.googlesource.com/chromium/src/
- **Chromium Security**: https://www.chromium.org/Home/chromium-security/
- **Ungoogled Chromium**: https://github.com/ungoogled-software/ungoogled-chromium (inspiración)
- **Privacy Guides**: https://www.privacyguides.org/

---

## ⚠️ Avisos Importantes

### Sobre Actualizaciones

**⚠️ CRÍTICO**: Actualiza regularmente para mantener la seguridad.

- **Versión Portable**: Ejecuta `ACTUALIZAR.bat` mensualmente
- **Versión Compilada**: Sincroniza con `sync-chromium.sh` semanalmente

### Sobre Telemetría

Este navegador NO envía datos a Google, pero:
- Los sitios web que visitas pueden rastrearte
- Usa extensiones de privacidad adicionales (uBlock Origin, etc.)
- Considera usar VPN para anonimato completo

### Sobre Compatibilidad

- Algunos sitios pueden requerir cookies de terceros (permitir manualmente)
- DRM funciona (Netflix, Spotify) con Widevine incluido
- Extensiones de Chrome Web Store compatibles

---

## 🎓 Aprende Más

### Tutoriales

- **[QUICK_START.md](QUICK_START.md)** - Inicio rápido de 5 pasos
- **[docs/BUILD.md](docs/BUILD.md)** - Compilación detallada
- **[docs/PRIVACY.md](docs/PRIVACY.md)** - Guía de privacidad completa
- **[docs/SECURITY.md](docs/SECURITY.md)** - Política de seguridad
- **[docs/FAQ.md](docs/FAQ.md)** - Preguntas frecuentes

### Comunidad

- GitHub Issues: Reporta problemas
- GitHub Discussions: Preguntas y discusiones
- Pull Requests: Contribuye al proyecto

---

## 🙏 Agradecimientos

- **The Chromium Project**: Por el navegador de código abierto
- **Ungoogled Chromium**: Por la inspiración y enfoque en privacidad
- **Comunidad de código abierto**: Por las herramientas y conocimiento

---

## 📈 Estado del Proyecto

- ✅ **Versión Portable**: Estable y lista para producción
- ⚠️ **Versión Compilada**: Para usuarios avanzados y desarrollo
- 🔄 **Actualizaciones**: Sincronización semanal con Chromium upstream
- 📚 **Documentación**: Completa y en español

---

<div align="center">

**🌐 Navegador Pereira**

Privacidad · Seguridad · Rendimiento

Made with ❤️ for privacy-conscious users

[Reportar Bug](https://github.com/Alcano3520/NAVEGADOR_PEREIRA/issues) · [Solicitar Funcionalidad](https://github.com/Alcano3520/NAVEGADOR_PEREIRA/issues) · [Documentación](docs/)

</div>
