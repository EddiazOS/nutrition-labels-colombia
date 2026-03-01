# Nutrition Labels Colombia 🇨🇴

**Sistema profesional de generación de etiquetas nutricionales en PDF**

Proyecto especializado en la creación de etiquetas nutricionales que cumplen normativas colombianas (NTC 5219, Resolución 810/2021) usando tecnología de composición tipográfica moderna (Typst) integrada con Python.

## ✨ Características Principales

✅ **Cumplimiento Normativo**
- Adherencia a NTC 5219 (Colombia)
- Resolución 810 de 2021 (INVIMA)
- Formato profesional de presentación

✅ **Automatización Completa**
- Generación dinámica de archivos desde JSON
- Compilación batch a PDF
- Versionado de productos en Git

✅ **Diseño Profesional**
- Líneas gruesas para separación de secciones
- Panel lateral rotado 90° con metadata
- Trazabilidad integrada (lote, fecha análisis)
- Metodología de determinación visible

✅ **Extensibilidad**
- Soporte para múltiples productos
- Sistema de plantillas modular
- Fácil customización de estilos

## 📁 Estructura del Proyecto

```
nutrition-labels-colombia/
├── data/
│   ├── products.json          # Datos de productos
│   ├── sources.json          # Referencias bibliográficas
│   └── csv/                  # CSVs originales
├── templates/
│   ├── tabla_nutricional.typ # Plantilla principal Typst
│   └── estilos.typ           # Estilos compartidos
├── scripts/
│   ├── generate_labels.py    # Generador Typst (Python)
│   └── compile_pdfs.sh       # Compilador bash
├── output/
│   ├── typst/                # Archivos Typst generados
│   └── pdf/                  # PDFs compilados
├── docs/
│   ├── README.md
│   ├── METHODOLOGY.md
│   └── SETUP.md
└── .github/
    └── workflows/
        └── generate.yml          # CI/CD automation
```

## 🚀 Inicio Rápido

### Requisitos Previos

```bash
# Python 3.8+
python --version

# Typst (compilador de documentos)
wget https://github.com/typst/typst/releases/download/v0.9.0/typst-x86_64-unknown-linux-gnu.tar.xz
tar xf typst-x86_64-unknown-linux-gnu.tar.xz
sudo mv typst /usr/local/bin/

# Verify
typst --version
```

### Instalación y Configuración

```bash
# 1. Clonar el repositorio
git clone https://github.com/EddiazOS/nutrition-labels-colombia
cd nutrition-labels-colombia

# 2. Crear entorno virtual (opcional pero recomendado)
python -m venv venv
source venv/bin/activate  # En Windows: venv\Scripts\activate

# 3. Instalar dependencias Python (si las hubiera)
pip install -r requirements.txt  # Actual: sin dependencias externas

# 4. Hacer scripts ejecutables
chmod +x scripts/*.sh scripts/*.py
```

### Generación de Etiquetas

#### Opción 1: Generar todos los productos

```bash
# Generar archivos Typst para todos los productos
python scripts/generate_labels.py --all

# Compilar a PDF
bash scripts/compile_pdfs.sh

# Los PDFs estarán en: output/pdf/
ls -lh output/pdf/
```

#### Opción 2: Generar un producto específico

```bash
# Generar solo "Harina de Plátano Verde"
python scripts/generate_labels.py --product harina-platano-001

# Compilar
typst compile output/typst/harina-platano-001.typ output/pdf/harina-platano-001.pdf
```

## 📊 Formato de Datos

### Estructura JSON de Productos

```json
{
  "products": [
    {
      "id": "harina-platano-001",
      "name": "Harina de Plátano Verde",
      "brand": "ASOREPP",
      "batch": "HP-2026-001",
      "analysis_date": "2026-02-15",
      "portion_size": "5.0 g",
      "portions_per_container": 20,
      "nutrition": {
        "energy_kcal_100g": 309.0,
        "energy_kcal_portion": 15.4,
        "proteins_g_100g": 9.7,
        "proteins_g_portion": 0.5,
        "grasa_total_g_100g": 3.3,
        "grasa_total_g_portion": 0.2,
        "...": "..."
      },
      "source_references": [
        {
          "method": "AOAC 925.10",
          "parameter": "Humedad",
          "standard": "AOAC 2019"
        }
      ]
    }
  ]
}
```

## 🎨 Personalización

### Modificar Estilos

Edita `templates/estilos.typ`:

```typst
// Cambiar colores corporativos
#let color-primary = rgb("#1a472a")    // Verde ASOREPP
#let color-secondary = rgb("#2d6a4f")  // Verde oscuro

// Cambiar tamaños de fuente
#let size-title = 14pt
#let size-heading = 11pt
#let size-body = 10pt
```

### Añadir Nuevos Productos

Edita `data/products.json`:

```bash
# 1. Añadir entrada en products.json
vim data/products.json

# 2. Generar etiqueta
python scripts/generate_labels.py --product nuevo-producto-id

# 3. Compilar
typst compile output/typst/nuevo-producto-id.typ output/pdf/nuevo-producto-id.pdf
```

## 📋 Metodología de Determinación

Cada etiqueta incluye:

- **Lote y Fecha**: Para trazabilidad
- **Métodos Analíticos**: AOAC, USDA, Estándares colombianos
- **Referencias**: Bibliografía científica
- **Normativa Aplicable**: NTC 5219, Resolución 810

Ver `docs/METHODOLOGY.md` para detalles completos.

## 🔄 Flujo de Trabajo

```
1. Recolectar datos nutricionales
   ↓
2. Ingresar en data/products.json
   ↓
3. python scripts/generate_labels.py
   ↓
4. bash scripts/compile_pdfs.sh
   ↓
5. PDFs listos en output/pdf/
```

## 🤖 Automatización con GitHub Actions

Este proyecto incluye workflow de CI/CD para generar automáticamente PDFs:

```bash
# Los PDFs se generan automáticamente en cada push
git add data/products.json
git commit -m "Añadir nuevo producto"
git push  # GitHub Actions genera el PDF automáticamente
```

Ver `.github/workflows/generate.yml`

## 📚 Documentación Adicional

- **SETUP.md**: Instrucciones detalladas de instalación
- **METHODOLOGY.md**: Detalles de metodología y normativa
- **TYPST.md**: Guía de sintaxis Typst (próximamente)

## 🛠 Troubleshooting

### Error: "typst: command not found"

```bash
# Instalar Typst
which typst  # Verificar si está instalado

# Si no está, descargar desde:
https://github.com/typst/typst/releases
```

### Error: "No se encontraron archivos .typ"

```bash
# Primero genera los archivos Typst
python scripts/generate_labels.py --all

# Luego compila
bash scripts/compile_pdfs.sh
```

### Caracteres especiales en PDF

Asegura que `products.json` esté en UTF-8:

```bash
file -i data/products.json  # Debería ser UTF-8
```

## 📝 Licencia

MIT License - Ver LICENSE.md

## 👥 Contribuciones

Las contribuciones son bienvenidas:

1. Fork el repositorio
2. Crea una rama (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Añadir funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

## 📧 Contacto

- **Email**: eldiazo@unal.edu.co
- **Organización**: ASOREPP (Asociación de Productores de Plátano)

## 🔗 Enlaces Ütiles

- [Typst Documentation](https://typst.app/docs/)
- [NTC 5219 - Colombia](https://www.icontec.org/)
- [INVIMA Normativa](https://www.invima.gov.co/)
- [USDA FoodData Central](https://fdc.nal.usda.gov/)

---

**Hecho con ♥ en Cartagena, Colombia**
