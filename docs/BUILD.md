# Guía de Compilación - Navegador Pereira

## 📋 Requisitos del Sistema

### Hardware Mínimo

| Componente | Mínimo | Recomendado |
|------------|--------|-------------|
| **CPU** | 4 cores | 8+ cores |
| **RAM** | 16 GB | 32+ GB |
| **Disco** | 100 GB libres | 150+ GB SSD |
| **Internet** | Banda ancha | Fibra óptica |

### Tiempo de Compilación Estimado

| Hardware | Primera compilación | Recompilación |
|----------|---------------------|---------------|
| 4 cores, 16GB RAM | 4-6 horas | 30-60 min |
| 8 cores, 32GB RAM | 2-4 horas | 15-30 min |
| 16 cores, 64GB RAM | 1-2 horas | 5-15 min |

## 🖥️ Requisitos por Sistema Operativo

### Windows 10/11

**Software necesario:**
```powershell
# Visual Studio 2022 (Community Edition)
# Componentes requeridos:
- Desktop development with C++
- Windows 10 SDK (10.0.20348.0 o superior)

# Instalar con winget
winget install Microsoft.VisualStudio.2022.Community

# Otros requisitos
- Python 3.11+
- Git for Windows
- depot_tools
```

**Descargar depot_tools:**
```powershell
# Opción 1: Download ZIP
https://storage.googleapis.com/chrome-infra/depot_tools.zip

# Extraer a C:\depot_tools
# Añadir a PATH del sistema

# Opción 2: Git
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git C:\depot_tools
```

### Linux (Ubuntu/Debian)

```bash
# Actualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependencias base
sudo apt install -y \
  git curl wget python3 python3-pip \
  build-essential ninja-build \
  libglib2.0-dev libgtk-3-dev \
  libpango1.0-dev libatk1.0-dev \
  libcairo2-dev libx11-dev \
  libxcomposite-dev libxcursor-dev \
  libxdamage-dev libxext-dev \
  libxfixes-dev libxi-dev \
  libxrandr-dev libxrender-dev \
  libxss-dev libxtst-dev \
  libasound2-dev libcups2-dev \
  libdbus-1-dev libnss3-dev \
  libpci-dev libpulse-dev \
  libudev-dev

# depot_tools
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
echo 'export PATH="$PATH:$HOME/depot_tools"' >> ~/.bashrc
source ~/.bashrc
```

### macOS

```bash
# Instalar Xcode Command Line Tools
xcode-select --install

# Instalar Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Instalar dependencias
brew install python3 git

# depot_tools
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
echo 'export PATH="$PATH:$HOME/depot_tools"' >> ~/.zshrc
source ~/.zshrc
```

## 🚀 Proceso de Compilación

### 1. Clonar Navegador Pereira

```bash
git clone https://github.com/TU-USUARIO/navegador_pereira.git
cd navegador_pereira
```

### 2. Sincronizar Chromium (Primera Vez)

**Advertencia:** Esta descarga es de ~20-30 GB y toma 1-3 horas

```bash
# Linux/Mac
./scripts/sync-chromium.sh

# Windows (PowerShell)
.\scripts\sync-chromium.ps1 -FirstSync
```

**Proceso:**
1. Descarga código fuente de Chromium
2. Descarga todas las dependencias
3. Configura el repositorio

### 3. Compilar

```bash
# Linux/Mac
./scripts/build.sh

# Windows (PowerShell)
.\scripts\build.ps1
```

**El script hace:**
1. Aplica configuraciones de privacidad
2. Aplica optimizaciones de rendimiento
3. Genera archivos de build con GN
4. Compila con Ninja

### 4. Ejecutar

```bash
# Linux
./chromium/src/out/Release/chrome

# Windows
.\chromium\src\out\Release\chrome.exe

# macOS
./chromium/src/out/Release/Chromium.app/Contents/MacOS/Chromium
```

## ⚙️ Opciones de Compilación

### Build de Debug

Para desarrollo y debugging:

```bash
# Editar scripts/build.sh o build.ps1
# Cambiar:
BUILD_TYPE="Debug"

# Compilar
./scripts/build.sh
```

**Diferencias:**
- Incluye símbolos de debug
- Sin optimizaciones
- 3-4x más lento
- 2-3x más grande

### Build con Símbolos

Para profiling:

```gn
# En chromium/src/out/Release/args.gn
symbol_level = 2
```

### Build Incremental

Después de la primera compilación:

```bash
# Solo recompila archivos modificados
cd chromium/src
ninja -C out/Release chrome
```

## 🔧 Personalización de Build

### Modificar args.gn

El archivo `chromium/src/out/Release/args.gn` controla la compilación:

```gn
# Ejemplo: Habilitar WebRTC
enable_webrtc = true

# Deshabilitar Widevine DRM
enable_widevine = false

# Cambiar branding
chrome_product_full_name = "Mi Navegador"
```

### Flags Comunes

```gn
# Performance
is_debug = false                    # Release build
is_official_build = true           # Optimizaciones máximas
use_thin_lto = true                # Link-Time Optimization
chrome_pgo_phase = 2               # Profile-Guided Optimization

# Privacidad
safe_browsing_mode = 0             # 0=off, 1=local, 2=google
enable_reporting = false           # Sin telemetría
enable_google_now = false          # Sin servicios Google

# Features
enable_pdf = true                  # Viewer PDF integrado
enable_printing = true             # Soporte impresión
proprietary_codecs = true          # MP3, H264, AAC
enable_widevine = true             # Netflix, Spotify, etc.

# Seguridad
is_component_build = false         # Build monolítico (más seguro)
```

### Recompilar Después de Cambios

```bash
# Regenerar archivos de build
cd chromium/src
gn gen out/Release

# Compilar
ninja -C out/Release chrome
```

## 🐛 Solución de Problemas

### Error: "No module named 'pkg_resources'"

```bash
# Linux/Mac
pip3 install setuptools

# Windows
python -m pip install setuptools
```

### Error: "MSVC not found"

Windows: Asegúrate de tener Visual Studio 2022 con "Desktop development with C++"

```powershell
# Verificar
where cl.exe
# Debe mostrar ruta a Visual Studio
```

### Error: "Out of disk space"

La compilación requiere ~100GB libres:

```bash
# Linux: Limpiar builds anteriores
rm -rf chromium/src/out

# Windows
Remove-Item -Recurse chromium\src\out
```

### Error: "Ninja build failed"

Recompilar con más verbosidad:

```bash
ninja -C out/Release chrome -v
```

### Build Extremadamente Lento

Optimizaciones:

```bash
# 1. Usar ccache (Linux/Mac)
sudo apt install ccache
echo 'export PATH="/usr/lib/ccache:$PATH"' >> ~/.bashrc

# 2. Más jobs paralelos (según tu RAM)
ninja -C out/Release chrome -j 16

# 3. Usar LLD linker (más rápido)
# En args.gn
use_lld = true
```

### Memoria Insuficiente

```bash
# Reducir jobs paralelos
ninja -C out/Release chrome -j 2

# O añadir swap (Linux)
sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

## 📦 Crear Instalador

### Windows

```powershell
# Usar mini_installer
cd chromium\src
ninja -C out\Release mini_installer

# Resultado:
# out\Release\mini_installer.exe
```

### Linux (DEB package)

```bash
# Instalar dependencias
sudo apt install dpkg-dev

# Crear estructura
mkdir -p navegador-pereira_1.0.0/DEBIAN
mkdir -p navegador-pereira_1.0.0/usr/bin
mkdir -p navegador-pereira_1.0.0/usr/share/applications

# Copiar binario
cp chromium/src/out/Release/chrome navegador-pereira_1.0.0/usr/bin/pereira

# Crear archivo control
cat > navegador-pereira_1.0.0/DEBIAN/control << EOF
Package: navegador-pereira
Version: 1.0.0
Architecture: amd64
Maintainer: Tu Nombre <tu@email.com>
Description: Navegador web basado en Chromium con enfoque en privacidad
Depends: libnss3, libxss1
EOF

# Construir paquete
dpkg-deb --build navegador-pereira_1.0.0
```

### macOS (DMG)

```bash
cd chromium/src/out/Release

# Crear DMG
hdiutil create -volname "Navegador Pereira" -srcfolder Chromium.app -ov -format UDZO NavegadorPereira.dmg
```

## 🔄 Actualización de Código

### Sincronizar con Chromium Upstream

```bash
# Obtener últimos cambios
./scripts/sync-chromium.sh

# Verificar qué cambió
./scripts/security-audit.sh

# Recompilar
./scripts/build.sh
```

### Aplicar Parches Personalizados

Crear parches en `patches/`:

```bash
# Crear parche
cd chromium/src
git diff > ../../patches/mi-cambio.patch

# Aplicar parche
git apply ../../patches/mi-cambio.patch
```

## 📊 Verificar Build

### Ejecutar Tests

```bash
cd chromium/src

# Unit tests
ninja -C out/Release unit_tests
out/Release/unit_tests

# Browser tests
ninja -C out/Release browser_tests
out/Release/browser_tests --gtest_filter=*Privacy*
```

### Verificar Binario

```bash
# Linux: Ver librerías enlazadas
ldd chromium/src/out/Release/chrome

# Verificar tamaño
du -h chromium/src/out/Release/chrome

# Verificar versión
./chromium/src/out/Release/chrome --version
```

## 📚 Recursos Adicionales

- [Chromium Build Instructions](https://chromium.googlesource.com/chromium/src/+/main/docs/README.md)
- [GN Reference](https://gn.googlesource.com/gn/+/main/docs/reference.md)
- [Ninja Manual](https://ninja-build.org/manual.html)

---

**Última actualización:** 2025-12-10
