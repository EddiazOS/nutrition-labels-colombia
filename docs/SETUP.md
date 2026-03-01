# Guía de Instalación y Configuración

## 🚀 Requisitos del Sistema

### Hardware Mínimo
- RAM: 2 GB
- Espacio disco: 500 MB
- Procesador: Cualquiera de los últimos 10 años

### Software Requerido

#### 1. Python (3.8 o superior)

**Linux/macOS:**
```bash
# Verificar si ya está instalado
python3 --version

# Si no está, instalar
# En Ubuntu/Debian:
sudo apt-get update
sudo apt-get install python3 python3-pip python3-venv

# En macOS (con Homebrew):
brew install python3
```

**Windows:**
- Descargar desde https://www.python.org/downloads/
- Seleccionar “Add Python to PATH” durante instalación
- Verificar: Abrir PowerShell/CMD y ejecutar `python --version`

#### 2. Typst (Compilador de documentos)

Typst es el motor que convierte nuestros archivos a PDF profesionales.

**Linux:**
```bash
# Opción 1: Desde repositorio (recomendado)
sudo apt-get install typst

# Opción 2: Descargar binario
wget https://github.com/typst/typst/releases/download/v0.11.0/typst-x86_64-unknown-linux-gnu.tar.xz
tar xf typst-x86_64-unknown-linux-gnu.tar.xz
sudo mv typst /usr/local/bin/
```

**macOS:**
```bash
# Con Homebrew
brew install typst

# Con MacPorts
sudo port install typst
```

**Windows:**
1. Descargar desde: https://github.com/typst/typst/releases
2. Buscar `typst-x86_64-pc-windows-msvc.zip`
3. Extraer a `C:\Program Files\Typst\`
4. Añadir a PATH en variables de entorno

**Verificación:**
```bash
typst --version
# Debería mostrar: typst 0.11.0 (o superior)
```

#### 3. Git (Control de versiones)

```bash
# Linux/macOS
sudo apt-get install git  # Ubuntu/Debian
brew install git          # macOS

# Windows: Descargar desde https://git-scm.com/
git --version
```

## 💾 Instalación del Proyecto

### Paso 1: Clonar el repositorio

```bash
# Ir a directorio de trabajo
cd ~/proyectos  # O tu ubicación preferida

# Clonar repositorio
git clone https://github.com/EddiazOS/nutrition-labels-colombia
cd nutrition-labels-colombia

# Verificar contenido
ls -la
```

### Paso 2: Crear entorno virtual Python (opcional pero recomendado)

**Linux/macOS:**
```bash
# Crear entorno virtual
python3 -m venv venv

# Activar entorno
source venv/bin/activate

# Verificación: Debería mostrar (venv) al inicio
which python
```

**Windows:**
```bash
# Crear entorno virtual
python -m venv venv

# Activar entorno (PowerShell)
.\venv\Scripts\Activate.ps1

# Activar entorno (CMD)
venv\Scripts\activate
```

### Paso 3: Hacer scripts ejecutables

**Linux/macOS:**
```bash
chmod +x scripts/generate_labels.py
chmod +x scripts/compile_pdfs.sh

# Verificar
ls -la scripts/
```

**Windows:**
- Los archivos .py se ejecutan automáticamente
- Para .sh se puede usar Git Bash o WSL

## 🗑 Estructura de Carpetas

Verificar que existan estas carpetas:

```bash
# Crear estructura si no existe
mkdir -p data/csv
mkdir -p templates
mkdir -p scripts
mkdir -p output/typst
mkdir -p output/pdf
mkdir -p docs

# Verificar
tree nutrition-labels-colombia/
```

## 😋 Primeros Pasos

### 1. Verificar instalación

```bash
# Verificar Python
python --version
# Salida esperada: Python 3.x.x

# Verificar Typst
typst --version
# Salida esperada: typst 0.x.x

# Verificar Git
git --version
# Salida esperada: git version 2.x.x
```

### 2. Generar etiqueta de prueba

```bash
# Ir al directorio del proyecto
cd nutrition-labels-colombia

# Generar todos los Typst
python scripts/generate_labels.py --all

# Debería mostrar:
# Generando: Harina de Plátano Verde - ASOREPP... ✓
```

### 3. Compilar a PDF

```bash
# Compilar archivos Typst a PDF
bash scripts/compile_pdfs.sh

# Los PDFs estarán en:
ls -lh output/pdf/
```

## 🛠 Troubleshooting

### Error: "python: command not found"

```bash
# Intenta con python3
python3 scripts/generate_labels.py --all

# Si esto funciona, crear alias
alias python=python3

# Hacerlo permanente (agregar a ~/.bashrc o ~/.zshrc):
echo 'alias python=python3' >> ~/.bashrc
source ~/.bashrc
```

### Error: "typst: command not found"

```bash
# 1. Verificar si está instalado
which typst

# 2. Si no muestra ruta, instalar:
# Linux:
sudo apt-get install typst

# macOS:
brew install typst

# 3. Verificar que funciona
typst --version
```

### Error: "No se encontraron archivos .typ"

```bash
# Primero, generar los archivos Typst
python scripts/generate_labels.py --all

# Verificar que se crearon
ls -lh output/typst/

# Luego, compilar
bash scripts/compile_pdfs.sh
```

### Error: "Permisos denegados en script bash"

```bash
# Hacer ejecutable
chmod +x scripts/compile_pdfs.sh

# Ejecutar con bash explícito
bash scripts/compile_pdfs.sh
```

### Caracteres especiales rotos en PDF

```bash
# Verificar encoding del archivo JSON
file -i data/products.json
# Debería mostrar: "text/plain; charset=utf-8"

# Convertir si es necesario
iconv -f ISO-8859-1 -t UTF-8 data/products.json > data/products.json.tmp
mv data/products.json.tmp data/products.json
```

## 🏠 Configuración Avanzada

### Usar editor de código recomendado

**VS Code** (Recomendado):
```bash
# Descargar desde https://code.visualstudio.com/
# Extensiones recomendadas:
# - "Typst" (Myriad-Dreamin)
# - "Python" (Microsoft)
# - "JSON" (Microsoft)

code .
```

**VIM:**
```bash
vim data/products.json
```

**Nano:**
```bash
nano data/products.json
```

### Configurar Git (primera vez)

```bash
# Configurar usuario
git config --global user.name "Tu Nombre"
git config --global user.email "tu.email@example.com"

# Verificar
git config --list
```

### Automatizar generación (Opcional)

**Linux/macOS - Cron job:**

```bash
# Editar crontab
crontab -e

# Añadir esta línea para generar diariamente a las 2 AM:
0 2 * * * cd /home/usuario/nutrition-labels-colombia && python scripts/generate_labels.py --all && bash scripts/compile_pdfs.sh
```

## 📋 Validación de Instalación

Cuando todo esté listo:

```bash
# Listar archivos generados
ls -lh output/pdf/*.pdf

# Abrir PDF (Linux/macOS)
open output/pdf/harina-platano-001.pdf

# Abrir PDF (Windows)
start output\pdf\harina-platano-001.pdf
```

El PDF debería mostrar:
- ✓ Título "INFORMACIÓN NUTRICIONAL"
- ✓ Líneas gruesas negras separando secciones
- ✓ Panel lateral con metadata rotado 90°
- ✓ Tabla nutricional bien formateada
- ✓ Valores numéricos correctos

## 퉰d Siguientes Pasos

1. Leer `README.md` para entender la estructura
2. Revisar `docs/METHODOLOGY.md` para metodología
3. Modificar `data/products.json` con tus datos
4. Ejecutar `python scripts/generate_labels.py --all`
5. Compilar con `bash scripts/compile_pdfs.sh`
6. ¡Disfrutar tus etiquetas PDF profesionales!

## 📧 Soporte

Para problemas:

1. Revisar este documento
2. Revisar logs del script
3. Contactar: eldiazo@unal.edu.co

---

**Configuración completada. ¡Listo para generar etiquetas nutricionales!** 🌟
