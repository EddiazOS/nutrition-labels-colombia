# Arquitectura del Sistema - Nutrition Labels Colombia

## 🏗 Diagrama de Flujo General

```
┌─────────────────────────────────────────────────────────────────────┐
│                    NUTRITION LABELS SYSTEM                          │
└─────────────────────────────────────────────────────────────────────┘

                        INPUT SOURCES
                            │
            ┌───────────────┼───────────────┐
            │               │               │
        CSV Files    products.json    Manual Entry
            │               │               │
            └───────────────┴───────────────┘
                            │
                            ▼
                 ┌──────────────────────┐
                 │  data/products.json  │
                 │   (Golden Source)    │
                 └──────────────────────┘
                            │
                            ▼
        ┌─────────────────────────────────────┐
        │   scripts/generate_labels.py       │
        │   (Python Generator)               │
        │                                   │
        │   • Lee products.json             │
        │   • Carga templates Typst         │
        │   • Genera archivos .typ          │
        └─────────────────────────────────────┘
                            │
                            ▼
        ┌─────────────────────────────────────┐
        │   output/typst/*.typ               │
        │   (Archivos Intermedios Typst)     │
        └─────────────────────────────────────┘
                            │
                            ▼
        ┌─────────────────────────────────────┐
        │   scripts/compile_pdfs.sh          │
        │   (Bash Compiler)                 │
        │                                   │
        │   • Ejecuta typst compile         │
        │   • Genera PDFs profesionales     │
        └─────────────────────────────────────┘
                            │
                            ▼
        ┌─────────────────────────────────────┐
        │   output/pdf/*.pdf                 │
        │   (Etiquetas Finales Profesionales)│
        └─────────────────────────────────────┘
                            │
            ┌───────────────┼───────────────┐
            │               │               │
        Download     Print/Share    Archive
            │               │               │
            └───────────────┴───────────────┘
```

## 📂 Estructura de Directorios Detallada

```
nutrition-labels-colombia/
│
├── 📁 data/                          # Datos de entrada
│   ├── products.json                 # Base de datos de productos (JSON)
│   ├── sources.json                  # Referencias bibliográficas
│   └── 📁 csv/                       # Archivos CSV fuente
│       └── harina-platano-ejemplo.csv
│
├── 📁 templates/                     # Plantillas Typst
│   ├── tabla_nutricional.typ         # Plantilla principal (grid layout)
│   │   └── Contiene:
│   │       • Función nutrition_label()
│   │       • Grid con 2 columnas
│   │       • Panel rotado 90°
│   │       • Líneas gruesas 2pt
│   │
│   └── estilos.typ                   # Sistema de estilos
│       └── Define:
│           • Colores corporativos
│           • Tipografía
│           • Espaciamiento
│           • Funciones auxiliares
│
├── 📁 scripts/                       # Scripts de automatización
│   ├── generate_labels.py            # Generador principal (Python)
│   │   ├── Lee: data/products.json
│   │   ├── Genera: output/typst/*.typ
│   │   └── Uso:
│   │       • python generate_labels.py --all
│   │       • python generate_labels.py --product ID
│   │
│   └── compile_pdfs.sh               # Compilador batch (Bash)
│       ├── Lee: output/typst/*.typ
│       ├── Genera: output/pdf/*.pdf
│       └── Uso: bash compile_pdfs.sh
│
├── 📁 output/                        # Archivos generados
│   ├── 📁 typst/                     # Archivos intermedios
│   │   └── harina-platano-001.typ    # Generado automáticamente
│   │
│   └── 📁 pdf/                       # Salida final
│       └── harina-platano-001.pdf    # Etiqueta compilada
│
├── 📁 docs/                          # Documentación
│   ├── README.md                     # Guía principal
│   ├── SETUP.md                      # Instalación
│   ├── METHODOLOGY.md                # Métodos analíticos
│   └── ARCHITECTURE.md               # Este archivo
│
├── 📁 .github/                       # Configuración GitHub
│   └── 📁 workflows/
│       └── generate.yml              # CI/CD Workflow
│           ├── Trigger: Push a main
│           ├── Instala: Python, Typst
│           ├── Ejecuta: Scripts
│           └── Sube: Artifacts
│
├── .gitignore                        # Configuración Git
├── README.md                         # Inicio
└── ARCHITECTURE.md                   # Este archivo
```

## 🔄 Ciclo de Vida de un Producto

```
FASE 1: ENTRADA DE DATOS
┌─────────────────────────────────────┐
│ 1. Usuario agrega datos a:          │
│    data/products.json               │
│                                     │
│ Estructura JSON:                    │
│ {                                   │
│   "products": [                     │
│     {                               │
│       "id": "producto-001",         │
│       "name": "Nombre Producto",    │
│       "nutrition": {...},           │
│       "batch": "LOTE-001",          │
│       ...                           │
│     }                               │
│   ]                                 │
│ }                                   │
└─────────────────────────────────────┘
                    │
                    ▼
FASE 2: GENERACIÓN TYPST
┌─────────────────────────────────────┐
│ 2. Ejecutar:                        │
│    python scripts/generate_labels   │
│    .py --all                        │
│                                     │
│ Resultado:                          │
│ ✓ output/typst/producto-001.typ     │
│ ✓ output/typst/producto-002.typ     │
│ ... (uno por cada producto)         │
└─────────────────────────────────────┘
                    │
                    ▼
FASE 3: COMPILACIÓN PDF
┌─────────────────────────────────────┐
│ 3. Ejecutar:                        │
│    bash scripts/compile_pdfs.sh     │
│                                     │
│ Typst compila cada .typ a PDF:      │
│ typst compile *.typ --root output   │
│                                     │
│ Resultado:                          │
│ ✓ output/pdf/producto-001.pdf       │
│ ✓ output/pdf/producto-002.pdf       │
│ ... (etiquetas finales)             │
└─────────────────────────────────────┘
                    │
                    ▼
FASE 4: VALIDACIÓN Y DISTRIBUCIÓN
┌─────────────────────────────────────┐
│ 4. Verificar y distribuir:          │
│                                     │
│ ✓ Revisar PDFs                      │
│ ✓ Validar contenido                 │
│ ✓ Compartir/Imprimir                │
│ ✓ Archivar (Git)                    │
└─────────────────────────────────────┘
```

## 🎨 Estructura del PDF (Diseño)

```
┌──────────────────────────────────────────────────────────────────┐
│                     ETIQUETA NUTRICIONAL                          │
├─────────────────────────────────────┬─────────────────────────────┤
│   COLUMNA 1: TABLA NUTRICIONAL      │ COLUMNA 2: METADATA ROTADA  │
│                                     │  (Texto rotado 90°)         │
│   ┌─────────────────────────────┐  │  ┌──────────────────────────┤
│   │ INFORMACIÓN NUTRICIONAL     │  │  │ TRAZABILIDAD              │
│   │ Tamaño porción: 1 cda (5g)  │  │  │ ─────────────────────     │
│   │ Porciones por envase: 20    │  │  │                           │
│   ├─────────────────────────────┤  │  │ Lote: HP-2026-001        │
│   │ Calorías (kcal)  │ 100g│5g  │  │  │ Fecha Análisis:          │
│   │ ─────────────────┼────┼─────┤  │  │ 2026-02-15               │
│   │ 309.0            │309 │15.4 │  │  │ Validez: 24 meses        │
│   ├─────────────────────────────┤  │  │                           │
│   │ Grasa Total                 │  │  │ NORMA APLICADA:          │
│   │  Saturada:   0.72g  │ 0g   │  │  │ NTC 5219 (Colombia)      │
│   │  Trans:      0mg    │ 0mg  │  │  │ Resolución 810/2021      │
│   ├─────────────────────────────┤  │  │                           │
│   │ Carbohidratos Totales: 44.5 │  │  │ MÉTODOS:                 │
│   │  Fibra: 22.5g  │ 1.1g       │  │  │ • Humedad: AOAC 925.10   │
│   │  Azúcares: 3.1g │ 0.1g      │  │  │ • Fibra: USDA Factor     │
│   │  Añadidos: 0g   │ 0g        │  │  │ • Sodio: Mohr            │
│   ├─────────────────────────────┤  │  │                           │
│   │ Proteína    │ 9.7g  │ 0.5g  │  │  │ LABORATORIO:             │
│   │ Sodio       │ 37mg  │ 1.8mg │  │  │ ASOREPP - Cartagena      │
│   └─────────────────────────────┘  │  │                           │
│                                     │  └──────────────────────────┤
└─────────────────────────────────────┴──────────────────────────────┘
```

## 🔌 Integración GitHub Actions

```
GIT PUSH a main
    │
    ▼
┌────────────────────────────────────┐
│  .github/workflows/generate.yml    │
│  (Workflow GitHub Actions)         │
└────────────────────────────────────┘
    │
    ├─ Setup Python 3.11
    │
    ├─ Install Typst
    │
    ├─ Generate Typst
    │   └─ python scripts/generate_labels.py --all
    │
    ├─ Compile PDFs
    │   └─ bash scripts/compile_pdfs.sh
    │
    ├─ Upload Artifacts
    │   └─ output/pdf/*.pdf
    │
    └─ Notify (Summary)
        └─ GitHub Workflow Summary
```

## 🔧 Tecnologías: Por Qué Esta Decisión

### Typst (vs LaTeX, HTML, etc.)

**Ventajas de Typst:**
- ✅ Sintaxis más limpia que LaTeX
- ✅ Compilación 100x más rápida
- ✅ Excelente soporte para tablas profesionales
- ✅ Rotación de texto nativa
- ✅ Control fino de espaciado
- ✅ PDFs de alta calidad
- ✅ Grid layout intuitivo

**vs HTML:**
- ✅ PDFs más predecibles (no depende del navegador)
- ✅ Control tipográfico preciso
- ✅ Mejor para documentos impresos

### Python (vs Node.js, Go, etc.)

**Ventajas de Python:**
- ✅ Excelente para procesamiento JSON
- ✅ Comunidad grande
- ✅ Fácil mantenimiento
- ✅ Sin dependencias externas necesarias
- ✅ Perfectamente escalable

### GitHub (vs GitLab, Gitea, etc.)

- ✅ Actions integrado (CI/CD gratuito)
- ✅ Mejor para proyectos públicos
- ✅ Visibilidad comunitaria
- ✅ Excelente documentación

## 📊 Volumetría y Performance

### Capacidad del Sistema

```
Por Operación (Local):
├─ Generar 1 archivo Typst:    ~10ms
├─ Compilar 1 PDF:            ~500ms
├─ Procesar 100 productos:    ~5 segundos total
└─ Procesar 1000 productos:   ~50 segundos total

En GitHub Actions:
├─ Setup inicial:             ~15 segundos
├─ Generate + Compile (100):  ~45 segundos
└─ Upload artifacts:          ~5 segundos
```

### Recomendaciones de Escalado

```
Para > 1000 productos:
├─ Paralelizar generación Typst
├─ Usar compilación paralela de PDFs
├─ Separar en múltiples workflows
└─ Considerar runner dedicado (GitHub Enterprise)
```

## 🔐 Seguridad y Validación

```
Validación de Entrada (data/products.json):
├─ Estructura JSON válida
├─ Campos requeridos presentes
├─ Valores numéricos en rangos válidos
├─ Encoding UTF-8
└─ Nombres de productos únicos

Control de Calidad (PDF):
├─ Archivo generado exitosamente
├─ Tamaño > 0 bytes
├─ Contiene texto esperado
└─ Metadatos correctos

Seguridad Git:
├─ .gitignore para archivos temporales
├─ PDFs versionados (importantes)
├─ Commits con mensajes descriptivos
└─ Branches protegidas recomendadas
```

## 🚀 Mejoras Futuras Posibles

```
V1.1:
├─ Soporte para múltiples idiomas
├─ Generación automática de CSV a JSON
├─ Visor de PDFs en GitHub Pages
└─ Webhooks para sincronización externa

V1.2:
├─ Base de datos (SQLite) en lugar de JSON
├─ API REST para consultas
├─ Dashboard de monitoreo
└─ Exportación a múltiples formatos

V2.0:
├─ Interfaz web (Django/FastAPI)
├─ Sistema de usuarios y roles
├─ Auditoría completa
└─ Integración INVIMA/certificación
```

---

**Arquitectura Versión:** 1.0
**Última actualización:** 2026-03-01
**Mantenedor:** ASOREPP
