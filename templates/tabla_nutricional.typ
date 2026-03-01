#import "estilos.typ": *

// Función principal para generar etiqueta nutricional
#let nutrition_label(
  product_name: "Producto",
  brand: "Marca",
  batch: "Lote",
  analysis_date: "2026-01-01",
  portion_size: "5 g",
  portions_per_container: 20,
  portion_description: "1 cucharadita",
  nutrition_data: none,
  methodology_refs: none,
  regulatory_info: none,
) = {

  set page(size: "letter", margin: 0.5cm)
  set text(font: "Calibri", size: 10pt)

  // ESTRUCTURA: Tabla principal + Panel de metadata rotado
  grid(
    columns: (1fr, 2.5cm),
    gutter: 0.3cm,

    // ============================================
    // COLUMNA 1: TABLA NUTRICIONAL PRINCIPAL
    // ============================================
    box(
      width: 100%,
      inset: 0.3cm,
      [
        // ENCABEZADO: Información del Producto
        #box(
          width: 100%,
          stroke: (bottom: 2pt + black),
          inset: (x: 0.3cm, y: 0.2cm),
          [
            #align(center, text(weight: "bold", size: 11pt, [INFORMACIÓN NUTRICIONAL]))
            #v(0.2cm)
            #text(size: 8pt, [
              *Tamaño de porción:* #portion_size #portion_description\
              *Porciones por envase:* #portions_per_container
            ])
          ]
        )

        // SECCIÓN 1: Energía (destacada)
        #table(
          columns: (1fr, 1fr, 1fr),
          stroke: none,
          align: (center, right, right),
          inset: (x: 0.3cm, y: 0.3cm),
          text(weight: "bold", size: 11pt, [*Calorías (kcal)*]),
          text(weight: "bold", size: 9pt, [Por 100g]),
          text(weight: "bold", size: 9pt, [Por porción]),
          [
            #box(
              width: 100%,
              stroke: (top: 2pt + black, bottom: 2pt + black),
              inset: (x: 0.3cm, y: 0.4cm),
              align(center, text(size: 12pt, weight: "bold", nutrition_data.energy_kcal_100g))
            )
          ],
          [
            #box(
              width: 100%,
              stroke: (top: 2pt + black, bottom: 2pt + black),
              inset: (x: 0.3cm, y: 0.4cm),
              align(center, text(size: 12pt, weight: "bold", nutrition_data.energy_kcal_portion))
            )
          ],
        )

        // SECCIÓN 2: Grasas
        #box(
          width: 100%,
          stroke: (top: 2pt + black, bottom: 2pt + black),
          inset: (x: 0.3cm, y: 0.3cm),
          [
            #text(weight: "bold", size: 10pt, [Grasa Total])
            #table(
              columns: (1fr, 1fr, 1fr),
              stroke: none,
              align: (left, right, right),
              inset: (x: 0.2cm, y: 0.2cm),
              text(size: 9pt, [*Tipo*]),
              text(size: 9pt, [*Por 100g*]),
              text(size: 9pt, [*Por porción*]),
              [Saturada],
              nutrition_data.saturated_fat_g_100g + " g",
              nutrition_data.saturated_fat_g_portion + " g",
              [Trans],
              nutrition_data.trans_fat_mg_100g + " mg",
              nutrition_data.trans_fat_mg_portion + " mg",
            )
          ]
        )

        // SECCIÓN 3: Carbohidratos
        #box(
          width: 100%,
          stroke: (top: 2pt + black, bottom: 2pt + black),
          inset: (x: 0.3cm, y: 0.3cm),
          [
            #table(
              columns: (1fr, 1fr, 1fr),
              stroke: none,
              align: (left, right, right),
              inset: (x: 0.2cm, y: 0.2cm),
              text(weight: "bold", size: 9pt, [Carbohidratos Totales]),
              nutrition_data.available_carbs_g_100g + " g",
              nutrition_data.available_carbs_g_portion + " g",
              text(size: 9pt, [  Fibra Dietética]),
              nutrition_data.dietary_fiber_g_100g + " g",
              nutrition_data.dietary_fiber_g_portion + " g",
              text(size: 9pt, [  Azúcares Totales]),
              nutrition_data.total_sugars_g_100g + " g",
              nutrition_data.total_sugars_g_portion + " g",
              text(size: 9pt, [  Azúcares Añadidos]),
              nutrition_data.added_sugars_g_100g + " g",
              nutrition_data.added_sugars_g_portion + " g",
            )
          ]
        )

        // SECCIÓN 4: Proteína y Sodio (destacados)
        #table(
          columns: (1fr, 1fr, 1fr),
          stroke: none,
          align: (left, right, right),
          inset: (x: 0.2cm, y: 0.3cm),
          [
            #box(
              width: 100%,
              stroke: (top: 2pt + black, bottom: 2pt + black),
              inset: (x: 0.3cm, y: 0.2cm),
              text(weight: "bold", [Proteína])
            )
          ],
          [
            #box(
              width: 100%,
              stroke: (top: 2pt + black, bottom: 2pt + black),
              inset: (x: 0.3cm, y: 0.2cm),
              align(right, nutrition_data.proteins_g_100g + " g")
            )
          ],
          [
            #box(
              width: 100%,
              stroke: (top: 2pt + black, bottom: 2pt + black),
              inset: (x: 0.3cm, y: 0.2cm),
              align(right, nutrition_data.proteins_g_portion + " g")
            )
          ],
          [
            #box(
              width: 100%,
              stroke: (top: 2pt + black, bottom: 2pt + black),
              inset: (x: 0.3cm, y: 0.2cm),
              text(weight: "bold", [Sodio])
            )
          ],
          [
            #box(
              width: 100%,
              stroke: (top: 2pt + black, bottom: 2pt + black),
              inset: (x: 0.3cm, y: 0.2cm),
              align(right, nutrition_data.sodium_mg_100g + " mg")
            )
          ],
          [
            #box(
              width: 100%,
              stroke: (top: 2pt + black, bottom: 2pt + black),
              inset: (x: 0.3cm, y: 0.2cm),
              align(right, nutrition_data.sodium_mg_portion + " mg")
            )
          ],
        )
      ]
    ),

    // ============================================
    // COLUMNA 2: PANEL ROTADO CON METADATA
    // ============================================
    box(
      width: 100%,
      height: 100%,
      rotate(90deg,
        align(center + horizon, [
          #text(size: 6pt, weight: "bold", [
            *TRAZABILIDAD Y METODOLOGÍA*\
            #v(0.1cm)
            *Lote:* #batch\
            *Fecha An.:* #analysis_date\
            *Validez:* 24 meses\
            #v(0.15cm)
            *Estándar:* NTC 5219\
            *Resolución:* 810/2021\
            #v(0.15cm)
            *MÉTODO DETERMINACIÓN*\
            Humedad: AOAC 925.10\
            Fibra: USDA Factor\
            Sodio: Mohr
          ])
        ])
      )
    )
  )
}

// Exportar función
#let nutrition_label = nutrition_label
