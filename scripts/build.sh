#!/bin/bash
# Script de compilación optimizada para Navegador Pereira

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

CHROMIUM_DIR="chromium/src"
BUILD_TYPE="Release"
OUTPUT_DIR="out/$BUILD_TYPE"
CORES=$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 4)

echo -e "${BLUE}=== Navegador Pereira - Build System ===${NC}"

# Verificar que estamos en el directorio correcto
if [ ! -d "$CHROMIUM_DIR" ]; then
    echo -e "${RED}Error: Directorio Chromium no encontrado${NC}"
    echo "Ejecuta primero: ./scripts/sync-chromium.sh"
    exit 1
fi

cd "$CHROMIUM_DIR"

echo -e "${GREEN}[1/5] Aplicando configuraciones de privacidad...${NC}"
# Copiar configuraciones
cp ../../configs/privacy/disable-google-services.gn build/config/privacy.gn
cp ../../configs/performance/optimization.gn build/config/performance.gn

echo -e "${GREEN}[2/5] Generando archivos GN...${NC}"

# Crear args.gn con todas las optimizaciones
mkdir -p "$OUTPUT_DIR"
cat > "$OUTPUT_DIR/args.gn" << 'EOF'
# Navegador Pereira - Build Configuration
# Auto-generado por scripts/build.sh

# === IMPORTAR CONFIGURACIONES ===
import("//build/config/privacy.gn")
import("//build/config/performance.gn")

# === BUILD TYPE ===
is_debug = false
is_official_build = true
is_component_build = false

# === COMPILADOR ===
use_thin_lto = true
chrome_pgo_phase = 0  # 0=none, 1=instrument, 2=use profile
symbol_level = 0

# === OPTIMIZACIONES ===
optimize_webui = true
enable_nacl = false
remove_webcore_debug_symbols = true
exclude_unwind_tables = true

# === PRIVACIDAD ===
enable_google_now = false
enable_hangout_services_extension = false
enable_one_click_signin = false
safe_browsing_mode = 0
enable_reporting = false
use_official_google_api_keys = false
google_api_key = ""
google_default_client_id = ""
google_default_client_secret = ""

# === BRANDING ===
is_chrome_branded = false
chrome_product_full_name = "Navegador Pereira"
chrome_product_short_name = "Pereira"

# === FEATURES ===
enable_extensions = true
enable_pdf = true
enable_print_preview = true
enable_widevine = true
proprietary_codecs = true
ffmpeg_branding = "Chrome"

# === MEDIA ===
enable_av1_decoder = true
enable_dav1d_decoder = true

# === NETWORK ===
enable_quic = true

# === V8 ===
v8_enable_lazy_source_positions = true
v8_enable_fast_mksnapshot = true

# === PLATFORM SPECIFIC ===
EOF

# Añadir configuraciones específicas de plataforma
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    cat >> "$OUTPUT_DIR/args.gn" << 'EOF'
use_sysroot = true
use_lld = true
clang_use_chrome_plugins = false
EOF
elif [[ "$OSTYPE" == "darwin"* ]]; then
    cat >> "$OUTPUT_DIR/args.gn" << 'EOF'
use_lld = true
EOF
fi

echo -e "${GREEN}[3/5] Ejecutando gn gen...${NC}"
gn gen "$OUTPUT_DIR"

echo -e "${GREEN}[4/5] Compilando Chromium (esto tomará 1-4 horas)...${NC}"
echo -e "${YELLOW}Usando $CORES cores de CPU${NC}"

# Mostrar progreso
ninja -C "$OUTPUT_DIR" chrome -j $CORES

echo -e "${GREEN}[5/5] Aplicando parches post-build...${NC}"

# Copiar preferencias por defecto
mkdir -p "$OUTPUT_DIR/initial_preferences"
cp ../../configs/privacy/default-preferences.json "$OUTPUT_DIR/initial_preferences/master_preferences"

# Copiar lista de dominios bloqueados
cp ../../configs/privacy/blocked-domains.txt "$OUTPUT_DIR/"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}✓ Build completado exitosamente${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo -e "Binario: ${BLUE}$OUTPUT_DIR/chrome${NC}"
echo -e "Tamaño: $(du -h $OUTPUT_DIR/chrome | cut -f1)"
echo ""
echo -e "${YELLOW}Para ejecutar:${NC}"
echo -e "  cd $CHROMIUM_DIR"
echo -e "  ./$OUTPUT_DIR/chrome"
echo ""
echo -e "${YELLOW}Para crear instalador:${NC}"
echo -e "  ./scripts/package.sh"
