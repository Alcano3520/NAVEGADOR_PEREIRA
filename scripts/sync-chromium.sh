#!/bin/bash
# Script de sincronización automática con Chromium upstream
# Este script mantiene tu navegador actualizado con los últimos parches de seguridad

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuración
CHROMIUM_REPO="https://chromium.googlesource.com/chromium/src.git"
CHROMIUM_DIR="chromium"
BRANCH="main" # o "stable" para versiones estables
LOG_FILE="sync-$(date +%Y%m%d-%H%M%S).log"

echo -e "${GREEN}=== Navegador Pereira - Sincronización con Chromium ===${NC}"

# Función de logging
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" | tee -a "$LOG_FILE"
    exit 1
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1" | tee -a "$LOG_FILE"
}

# Verificar depot_tools
if ! command -v gclient &> /dev/null; then
    error "depot_tools no encontrado. Instala desde: https://commondatasource.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/depot_tools_tutorial.html"
fi

# Crear directorio si no existe
if [ ! -d "$CHROMIUM_DIR" ]; then
    log "Primera sincronización - esto tomará varias horas..."
    log "Clonando Chromium..."

    mkdir -p "$CHROMIUM_DIR"
    cd "$CHROMIUM_DIR"

    # Configurar gclient
    gclient config --name src "$CHROMIUM_REPO"
    gclient sync --no-history

    cd src
    git remote add upstream "$CHROMIUM_REPO"
    git checkout -b pereira-main

    log "Primera sincronización completada"
else
    log "Actualizando Chromium existente..."
    cd "$CHROMIUM_DIR/src"

    # Guardar cambios locales
    if [ -n "$(git status --porcelain)" ]; then
        warning "Cambios locales detectados, guardando..."
        git stash save "Auto-stash before sync $(date)"
    fi

    # Actualizar desde upstream
    log "Obteniendo últimos cambios de Chromium..."
    git fetch upstream

    # Obtener versión actual y nueva
    CURRENT_VERSION=$(git rev-parse HEAD)
    LATEST_VERSION=$(git rev-parse upstream/$BRANCH)

    if [ "$CURRENT_VERSION" == "$LATEST_VERSION" ]; then
        log "Ya estás en la última versión de Chromium"
    else
        log "Nueva versión disponible"
        log "Versión actual: ${CURRENT_VERSION:0:8}"
        log "Nueva versión: ${LATEST_VERSION:0:8}"

        # Contar commits nuevos
        NEW_COMMITS=$(git log --oneline $CURRENT_VERSION..$LATEST_VERSION | wc -l)
        log "Nuevos commits: $NEW_COMMITS"

        # Buscar commits de seguridad
        SECURITY_COMMITS=$(git log --grep="Security" --grep="CVE" --oneline $CURRENT_VERSION..$LATEST_VERSION | wc -l)
        if [ $SECURITY_COMMITS -gt 0 ]; then
            warning "¡$SECURITY_COMMITS commits de SEGURIDAD encontrados!"
        fi

        # Merge
        log "Integrando cambios..."
        if ! git merge upstream/$BRANCH --no-edit; then
            error "Conflictos de merge detectados. Resuelve manualmente."
        fi

        # Sincronizar dependencias
        log "Sincronizando dependencias..."
        gclient sync

        log "Actualización completada exitosamente"
    fi

    # Restaurar cambios locales si existían
    if git stash list | grep -q "Auto-stash"; then
        log "Restaurando cambios locales..."
        git stash pop
    fi
fi

# Generar reporte
log "Generando reporte de seguridad..."
cd "$(git rev-parse --show-toplevel)/../.."
./scripts/security-audit.sh

log "Sincronización completada. Log guardado en: $LOG_FILE"
echo -e "${GREEN}✓ Listo para compilar con ./scripts/build.sh${NC}"
