#!/bin/bash
# Script de configuración inicial para Navegador Pereira

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}"
cat << "EOF"
╔═══════════════════════════════════════╗
║   NAVEGADOR PEREIRA - SETUP           ║
║   Navegador Chromium con Privacidad   ║
╚═══════════════════════════════════════╝
EOF
echo -e "${NC}"

# Verificar sistema operativo
OS="unknown"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    OS="macos"
else
    echo -e "${RED}Sistema operativo no soportado: $OSTYPE${NC}"
    exit 1
fi

echo -e "${GREEN}[1/6] Verificando dependencias...${NC}"

# Verificar Python
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Python 3 no encontrado. Por favor instálalo.${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Python $(python3 --version)${NC}"

# Verificar Git
if ! command -v git &> /dev/null; then
    echo -e "${RED}Git no encontrado. Por favor instálalo.${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Git $(git --version)${NC}"

# Verificar depot_tools
echo -e "${GREEN}[2/6] Configurando depot_tools...${NC}"
if ! command -v gclient &> /dev/null; then
    echo -e "${YELLOW}depot_tools no encontrado. Instalando...${NC}"

    if [ ! -d "../depot_tools" ]; then
        cd ..
        git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
        cd navegador_pereira
    fi

    # Añadir a PATH temporalmente
    export PATH="$(pwd)/../depot_tools:$PATH"

    # Añadir a .bashrc/.zshrc
    SHELL_RC="$HOME/.bashrc"
    if [[ "$OS" == "macos" ]]; then
        SHELL_RC="$HOME/.zshrc"
    fi

    if ! grep -q "depot_tools" "$SHELL_RC"; then
        echo "export PATH=\"\$HOME/depot_tools:\$PATH\"" >> "$SHELL_RC"
        echo -e "${GREEN}✓ depot_tools añadido a $SHELL_RC${NC}"
        echo -e "${YELLOW}⚠ Ejecuta: source $SHELL_RC${NC}"
    fi
else
    echo -e "${GREEN}✓ depot_tools ya instalado${NC}"
fi

# Verificar dependencias del sistema
echo -e "${GREEN}[3/6] Verificando dependencias del sistema...${NC}"

if [[ "$OS" == "linux" ]]; then
    # Detectar distribución
    if [ -f /etc/debian_version ]; then
        echo -e "${YELLOW}Distribución Debian/Ubuntu detectada${NC}"
        echo -e "${YELLOW}Instalando dependencias (requiere sudo)...${NC}"

        sudo apt-get update
        sudo apt-get install -y \
            build-essential ninja-build \
            libglib2.0-dev libgtk-3-dev \
            libpango1.0-dev libcairo2-dev \
            libasound2-dev libcups2-dev \
            libdbus-1-dev libnss3-dev

        echo -e "${GREEN}✓ Dependencias instaladas${NC}"
    elif [ -f /etc/redhat-release ]; then
        echo -e "${YELLOW}Distribución RedHat/Fedora detectada${NC}"
        echo -e "${YELLOW}Instalando dependencias (requiere sudo)...${NC}"

        sudo dnf install -y \
            gcc gcc-c++ ninja-build \
            glib2-devel gtk3-devel \
            pango-devel cairo-devel \
            alsa-lib-devel cups-devel \
            dbus-devel nss-devel

        echo -e "${GREEN}✓ Dependencias instaladas${NC}"
    fi
elif [[ "$OS" == "macos" ]]; then
    if ! command -v brew &> /dev/null; then
        echo -e "${YELLOW}Homebrew no encontrado. Instálalo desde: https://brew.sh${NC}"
    else
        echo -e "${GREEN}✓ Homebrew instalado${NC}"
    fi
fi

# Verificar espacio en disco
echo -e "${GREEN}[4/6] Verificando espacio en disco...${NC}"
AVAILABLE=$(df -BG . | tail -1 | awk '{print $4}' | sed 's/G//')
if [ "$AVAILABLE" -lt 100 ]; then
    echo -e "${RED}⚠ Espacio insuficiente: ${AVAILABLE}GB disponibles${NC}"
    echo -e "${RED}  Se requieren al menos 100GB libres${NC}"
    read -p "¿Continuar de todas formas? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
else
    echo -e "${GREEN}✓ Espacio suficiente: ${AVAILABLE}GB disponibles${NC}"
fi

# Verificar RAM
echo -e "${GREEN}[5/6] Verificando RAM...${NC}"
if [[ "$OS" == "linux" ]]; then
    RAM=$(free -g | awk '/^Mem:/{print $2}')
elif [[ "$OS" == "macos" ]]; then
    RAM=$(sysctl -n hw.memsize | awk '{print int($1/1024/1024/1024)}')
fi

if [ "$RAM" -lt 16 ]; then
    echo -e "${YELLOW}⚠ RAM: ${RAM}GB (se recomiendan 16GB+)${NC}"
    echo -e "${YELLOW}  La compilación será lenta${NC}"
else
    echo -e "${GREEN}✓ RAM: ${RAM}GB${NC}"
fi

# Hacer scripts ejecutables
echo -e "${GREEN}[6/6] Configurando permisos...${NC}"
chmod +x scripts/*.sh
echo -e "${GREEN}✓ Scripts configurados${NC}"

# Resumen
echo ""
echo -e "${BLUE}═══════════════════════════════════════${NC}"
echo -e "${GREEN}✓ Configuración completada${NC}"
echo -e "${BLUE}═══════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}Próximos pasos:${NC}"
echo ""
echo -e "1. Sincronizar Chromium (1-3 horas, ~20GB descarga):"
echo -e "   ${BLUE}./scripts/sync-chromium.sh${NC}"
echo ""
echo -e "2. Compilar navegador (2-4 horas primera vez):"
echo -e "   ${BLUE}./scripts/build.sh${NC}"
echo ""
echo -e "3. Ejecutar:"
echo -e "   ${BLUE}./chromium/src/out/Release/chrome${NC}"
echo ""
echo -e "${YELLOW}Documentación completa:${NC}"
echo -e "   docs/BUILD.md     - Guía de compilación"
echo -e "   docs/PRIVACY.md   - Configuraciones de privacidad"
echo -e "   docs/SECURITY.md  - Política de seguridad"
echo ""
