#!/usr/bin/env python3
"""
Generador de Etiquetas Nutricionales - Typst Generator

Este script lee los archivos JSON con información de productos
y genera automáticamente archivos Typst listos para compilar a PDF.

Usage:
    python generate_labels.py [--product ID]
    python generate_labels.py --all

Autor: ASOREPP Data Systems
Licencia: MIT
"""

import json
import sys
import argparse
from pathlib import Path
from datetime import datetime

# Configuración de rutas
PATH_DATA = Path(__file__).parent.parent / "data"
PATH_TEMPLATES = Path(__file__).parent.parent / "templates"
PATH_OUTPUT = Path(__file__).parent.parent / "output" / "typst"

# Crear directorios si no existen
PATH_OUTPUT.mkdir(parents=True, exist_ok=True)

class NutritionLabelGenerator:
    """
    Generador de etiquetas nutricionales en formato Typst.
    Convierte datos JSON en archivos Typst optimizados para PDF.
    """

    def __init__(self, template_path: Path):
        """Inicializar el generador con la plantilla Typst."""
        self.template_path = template_path
        self.template_base = self._load_template()
        self.metadata = {
            "generated_at": datetime.now().isoformat(),
            "generator_version": "1.0.0"
        }

    def _load_template(self) -> str:
        """Cargar la plantilla Typst base."""
        template_file = self.template_path / "tabla_nutricional.typ"
        with open(template_file, 'r', encoding='utf-8') as f:
            return f.read()

    def generate_from_product(self, product: dict) -> str:
        """
        Generar contenido Typst para un producto específico.
        
        Args:
            product: Diccionario con datos del producto
            
        Returns:
            Contenido Typst generado
        """
        
        # Extraer datos del producto
        nutrition = product['nutrition']
        regulatory = product.get('regulatory_info', {})
        
        # Construir contenido Typst con llamadas a función
        typst_content = f'''#import "../../templates/tabla_nutricional.typ": nutrition_label
#import "../../templates/estilos.typ": *

// Documento generado automáticamente
// Producto: {product['name']}
// Marca: {product['brand']}
// Fecha de generación: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
// ============================================

#show page: set page(size: "letter", margin: 0.5cm)
#set text(font: "Calibri", size: 10pt)

#nutrition_label(
  product_name: "{product['name']}",
  brand: "{product['brand']}",
  batch: "{product['batch']}",
  analysis_date: "{product['analysis_date']}",
  portion_size: "{product['portion_size']}",
  portions_per_container: {product['portions_per_container']},
  portion_description: "{product['portion_description']}",
  nutrition_data: (
    energy_kcal_100g: {nutrition['energy_kcal_100g']},
    energy_kcal_portion: {nutrition['energy_kcal_portion']},
    proteins_g_100g: {nutrition['proteins_g_100g']},
    proteins_g_portion: {nutrition['proteins_g_portion']},
    total_fat_g_100g: {nutrition['total_fat_g_100g']},
    total_fat_g_portion: {nutrition['total_fat_g_portion']},
    saturated_fat_g_100g: {nutrition['saturated_fat_g_100g']},
    saturated_fat_g_portion: {nutrition['saturated_fat_g_portion']},
    trans_fat_mg_100g: {nutrition['trans_fat_mg_100g']},
    trans_fat_mg_portion: {nutrition['trans_fat_mg_portion']},
    available_carbs_g_100g: {nutrition['available_carbs_g_100g']},
    available_carbs_g_portion: {nutrition['available_carbs_g_portion']},
    dietary_fiber_g_100g: {nutrition['dietary_fiber_g_100g']},
    dietary_fiber_g_portion: {nutrition['dietary_fiber_g_portion']},
    total_sugars_g_100g: {nutrition['total_sugars_g_100g']},
    total_sugars_g_portion: {nutrition['total_sugars_g_portion']},
    added_sugars_g_100g: {nutrition['added_sugars_g_100g']},
    added_sugars_g_portion: {nutrition['added_sugars_g_portion']},
    sodium_mg_100g: {nutrition['sodium_mg_100g']},
    sodium_mg_portion: {nutrition['sodium_mg_portion']},
  ),
  regulatory_info: (
    standard: "{regulatory.get('standard', 'NTC 5219')}",
    regulation: "{regulatory.get('regulation', 'Resolución 810')}",
    country: "{regulatory.get('country', 'Colombia')}",
  )
)
'''
        
        return typst_content

    def save_typst_file(self, content: str, filename: str) -> Path:
        """
        Guardar contenido Typst en archivo.
        
        Args:
            content: Contenido Typst a guardar
            filename: Nombre del archivo (sin extensión)
            
        Returns:
            Ruta del archivo guardado
        """
        output_file = PATH_OUTPUT / f"{filename}.typ"
        output_file.write_text(content, encoding='utf-8')
        return output_file

    def process_all_products(self) -> list:
        """
        Procesar todos los productos en data/products.json.
        
        Returns:
            Lista de rutas de archivos generados
        """
        products_file = PATH_DATA / "products.json"
        
        if not products_file.exists():
            print(f"Error: {products_file} no encontrado")
            return []
        
        with open(products_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        generated_files = []
        
        for product in data.get('products', []):
            product_id = product['id']
            print(f"Generando: {product['name']}... ", end="", flush=True)
            
            try:
                typst_content = self.generate_from_product(product)
                output_path = self.save_typst_file(typst_content, product_id)
                generated_files.append(output_path)
                print(f"✓ {output_path}")
            except Exception as e:
                print(f"✗ Error: {e}")
        
        return generated_files

    def process_single_product(self, product_id: str) -> Path:
        """
        Procesar un producto específico por ID.
        
        Args:
            product_id: ID del producto
            
        Returns:
            Ruta del archivo generado
        """
        products_file = PATH_DATA / "products.json"
        
        with open(products_file, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        product = next(
            (p for p in data.get('products', []) if p['id'] == product_id),
            None
        )
        
        if not product:
            raise ValueError(f"Producto '{product_id}' no encontrado")
        
        print(f"Generando: {product['name']}... ", end="", flush=True)
        typst_content = self.generate_from_product(product)
        output_path = self.save_typst_file(typst_content, product_id)
        print(f"✓ {output_path}")
        
        return output_path

def main():
    """Punto de entrada del script."""
    parser = argparse.ArgumentParser(
        description="Generador de Etiquetas Nutricionales - Typst"
    )
    parser.add_argument(
        '--product',
        help='ID del producto a generar',
        type=str
    )
    parser.add_argument(
        '--all',
        action='store_true',
        help='Generar todos los productos'
    )
    parser.add_argument(
        '--output',
        help='Directorio de salida',
        type=str,
        default=str(PATH_OUTPUT)
    )
    
    args = parser.parse_args()
    
    print("\n" + "="*60)
    print("NUTRITION LABELS GENERATOR - TYPST")
    print("="*60)
    
    generator = NutritionLabelGenerator(PATH_TEMPLATES)
    
    try:
        if args.all or (not args.product):
            print("\nMode: Generar TODOS los productos\n")
            files = generator.process_all_products()
            print(f"\n✓ {len(files)} archivos generados en {PATH_OUTPUT}")
        
        elif args.product:
            print(f"\nMode: Generar producto '{args.product}'\n")
            file = generator.process_single_product(args.product)
            print(f"\n✓ Archivo generado: {file}")
        
        print("\n" + "="*60 + "\n")
        
    except Exception as e:
        print(f"\n✗ Error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
