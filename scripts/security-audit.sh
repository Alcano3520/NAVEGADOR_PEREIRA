#!/bin/bash
# Script de auditoría de seguridad
# Analiza commits recientes en busca de parches de seguridad

set -e

CHROMIUM_DIR="chromium/src"
DAYS=${1:-7}  # Días a revisar (default: 7)

if [ ! -d "$CHROMIUM_DIR" ]; then
    echo "Error: Directorio Chromium no encontrado"
    exit 1
fi

cd "$CHROMIUM_DIR"

echo "=== Auditoría de Seguridad - Últimos $DAYS días ==="
echo ""

# Obtener commits de seguridad
echo "📊 COMMITS DE SEGURIDAD:"
git log --since="$DAYS days ago" --grep="Security\|CVE\|vulnerability" --oneline --no-merges | head -20

echo ""
echo "📈 ESTADÍSTICAS:"
SECURITY_COUNT=$(git log --since="$DAYS days ago" --grep="Security\|CVE" --oneline --no-merges | wc -l)
TOTAL_COUNT=$(git log --since="$DAYS days ago" --oneline --no-merges | wc -l)

echo "  Total commits: $TOTAL_COUNT"
echo "  Commits de seguridad: $SECURITY_COUNT"

if [ $SECURITY_COUNT -gt 0 ]; then
    echo ""
    echo "⚠️  ACCIÓN REQUERIDA: Hay $SECURITY_COUNT parches de seguridad"
    echo "   Recomendación: Actualizar y recompilar cuanto antes"
fi

echo ""
echo "🔍 CVEs MENCIONADOS:"
git log --since="$DAYS days ago" --all-match --grep="CVE-" --oneline | grep -oP 'CVE-\d{4}-\d+' | sort -u

echo ""
echo "✓ Auditoría completada"
