#!/bin/bash

# Script de Compilación - Nutrition Labels Colombia
# Compila todos los archivos Typst generados a formato PDF

set -e

echo "="
echo "NUTRITION LABELS - TYPST TO PDF COMPILER"
echo "="

# Directorios
DIR_TYPST="$(dirname "$0")/../output/typst"
DIR_PDF="$(dirname "$0")/../output/pdf"

# Crear directorio PDF si no existe
mkdir -p "$DIR_PDF"

echo ""
echo "Directorio de entrada (Typst): $DIR_TYPST"
echo "Directorio de salida (PDF): $DIR_PDF"
echo ""

# Verificar que Typst está instalado
if ! command -v typst &> /dev/null; then
    echo "✗ Error: 'typst' no está instalado"
    echo "  Instalar desde: https://github.com/typst/typst/releases"
    exit 1
fi

echo "Versiones detectadas:"
typst --version
echo ""

# Contar archivos
COUNT=$(find "$DIR_TYPST" -name "*.typ" 2>/dev/null | wc -l)

if [ "$COUNT" -eq 0 ]; then
    echo "✗ No se encontraron archivos .typ en $DIR_TYPST"
    echo "  Primero ejecuta: python scripts/generate_labels.py --all"
    exit 1
fi

echo "✓ Encontrados $COUNT archivos Typst para compilar"
echo ""

# Compilar cada archivo
COMPILED=0
FAILED=0

for typ_file in "$DIR_TYPST"/*.typ; do
    if [ -f "$typ_file" ]; then
        filename=$(basename "$typ_file" .typ)
        pdf_file="$DIR_PDF/$filename.pdf"
        
        echo -n "Compilando: $filename... "
        
        if typst compile "$typ_file" "$pdf_file" 2>/dev/null; then
            echo "✓"
            ((COMPILED++))
        else
            echo "✗ Error durante compilación"
            ((FAILED++))
        fi
    fi
done

echo ""
echo "="
echo "RESULTADO:"
echo "  Compilados: $COMPILED"
echo "  Errores: $FAILED"
echo "  Total: $COUNT"
echo ""

if [ "$COMPILED" -gt 0 ]; then
    echo "✓ Archivos PDF guardados en: $DIR_PDF"
    echo ""
    ls -lh "$DIR_PDF"/*.pdf 2>/dev/null || true
fi

echo ""
echo "="

exit 0
