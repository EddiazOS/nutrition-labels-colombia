# 🚀 QUICK START - Inicio Rápido

## 30 segundos para tu primera etiqueta

### 1. Requisitos (instalar una sola vez)

```bash
# Linux
sudo apt-get install python3 typst

# macOS
brew install python3 typst

# Windows
# Descargar Python desde: https://www.python.org/
# Descargar Typst desde: https://github.com/typst/typst/releases
```

### 2. Clonar el repositorio

```bash
git clone https://github.com/EddiazOS/nutrition-labels-colombia
cd nutrition-labels-colombia
```

### 3. Generar etiqueta (2 pasos)

```bash
# Paso 1: Generar archivo Typst
python scripts/generate_labels.py --all

# Paso 2: Compilar a PDF
bash scripts/compile_pdfs.sh
```

### 4. ✅ Listo - Ver resultado

```bash
# Abrir el PDF generado
open output/pdf/harina-platano-001.pdf  # macOS
xdg-open output/pdf/harina-platano-001.pdf  # Linux
start output/pdf/harina-platano-001.pdf  # Windows
```

---

## 🏃 Casos de Uso Rápidos

### Agregar un nuevo producto

```bash
# 1. Editar data/products.json
vim data/products.json  # O tu editor favorito

# 2. Agregar nuevo objeto en array "products"
# 3. Guardar

# 4. Generar
python scripts/generate_labels.py --all
bash scripts/compile_pdfs.sh
```

### Generar un solo producto

```bash
# En lugar de --all, usar --product
python scripts/generate_labels.py --product harina-platano-001

# Compilar solo ese archivo
typst compile output/typst/harina-platano-001.typ output/pdf/harina-platano-001.pdf
```

### Agregar a un repositorio existente

```bash
# Después de generar los PDFs
git add -A
git commit -m "🔄 Generar etiquetas nutricionales"
git push

# GitHub Actions compilará automáticamente al hacer push
```

---

## 🌏 Archivo JSON: Estructura Básica

En `data/products.json`:

```json
{
  "products": [
    {
      "id": "tu-producto-id",
      "name": "Nombre del Producto",
      "brand": "Tu Marca",
      "batch": "LOTE-2026-001",
      "analysis_date": "2026-03-01",
      "portion_size": "5.0 g",
      "portions_per_container": 20,
      "portion_description": "1 cucharadita",
      "nutrition": {
        "energy_kcal_100g": 309.0,
        "energy_kcal_portion": 15.4,
        "proteins_g_100g": 9.7,
        "proteins_g_portion": 0.5,
        "total_fat_g_100g": 3.3,
        "total_fat_g_portion": 0.2,
        "saturated_fat_g_100g": 0.0,
        "saturated_fat_g_portion": 0.0,
        "trans_fat_mg_100g": 0.0,
        "trans_fat_mg_portion": 0.0,
        "available_carbs_g_100g": 44.5,
        "available_carbs_g_portion": 2.2,
        "dietary_fiber_g_100g": 22.5,
        "dietary_fiber_g_portion": 1.1,
        "total_sugars_g_100g": 3.1,
        "total_sugars_g_portion": 0.1,
        "added_sugars_g_100g": 0.0,
        "added_sugars_g_portion": 0.0,
        "sodium_mg_100g": 37.0,
        "sodium_mg_portion": 1.8
      }
    }
  ]
}
```

---

## 🛠 Troubleshooting Rápido

**Error: "python: command not found"**
```bash
python3 scripts/generate_labels.py --all
```

**Error: "typst: command not found"**
```bash
# Reinstalar
sudo apt-get install --reinstall typst  # Linux
brew install typst  # macOS
```

**Error: "No se encontraron archivos .typ"**
```bash
# Primero generar los archivos
python scripts/generate_labels.py --all
# Luego compilar
bash scripts/compile_pdfs.sh
```

**El PDF sale en blanco o con errores**
```bash
# Verificar que products.json esté en UTF-8
file -i data/products.json

# Si no dice UTF-8, convertir:
iconv -f ISO-8859-1 -t UTF-8 data/products.json > data/products.json.tmp
mv data/products.json.tmp data/products.json
```

---

## 📈 Exportar a diferentes formatos

Typst también puede exportar a otros formatos:

```bash
# PDF (por defecto)
typst compile output/typst/producto.typ output/pdf/producto.pdf

# PNG (cada página es una imagen)
typst compile output/typst/producto.typ output/png/producto.png

# SVG (vector graphics)
typst compile output/typst/producto.typ output/svg/producto.svg
```

---

## 📧 Más información

- **Documentación completa**: Ver `README.md`
- **Instalación detallada**: Ver `docs/SETUP.md`
- **Arquitectura**: Ver `ARCHITECTURE.md`
- **Metodología**: Ver `docs/METHODOLOGY.md`

---

**¿Preguntas?** Contactar: eldiazo@unal.edu.co
