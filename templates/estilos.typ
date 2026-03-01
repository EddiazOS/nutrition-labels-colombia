// Estilos compartidos para etiquetas nutricionales
// Define colores, fuentes y constantes utilizadas en todo el proyecto

// ============================================
// COLORES CORPORATIVOS
// ============================================

#let color-primary = rgb("#1a472a")  // Verde ASOREPP
#let color-secondary = rgb("#2d6a4f") // Verde oscuro
#let color-accent = rgb("#40916c")   // Verde claro
#let color-neutral = rgb("#333333")  // Gris oscuro
#let color-border = rgb("#000000")   // Negro puro
#let color-background = rgb("#ffffff") // Blanco

// ============================================
// TIPÓGRAFA
// ============================================

#let font-body = "Calibri"
#let font-heading = "Calibri Bold"
#let font-mono = "Courier New"

#let size-title = 14pt
#let size-heading = 11pt
#let size-body = 10pt
#let size-small = 8pt
#let size-tiny = 6pt

// ============================================
// ESTILOS DE LÍNEAS
// ============================================

#let stroke-thick = 2pt + color-border      // Líneas de sección principal
#let stroke-medium = 1pt + color-border     // Líneas intermedias
#let stroke-thin = 0.5pt + color-neutral    // Líneas auxiliares

// ============================================
// FUNCIONES AUXILIARES
// ============================================

// Celda de tabla con estilo consistente
#let table-cell(content, bold: false, align: left, bg: none) = {
  box(
    inset: (x: 0.3cm, y: 0.2cm),
    fill: bg,
    align(align, text(
      weight: if bold { "bold" } else { "regular" },
      size: size-body,
      content
    ))
  )
}

// Sección con encabezado y borde grueso
#let section(title, content) = {
  box(
    width: 100%,
    stroke: (top: stroke-thick, bottom: stroke-thick),
    [
      #text(weight: "bold", size: size-heading, title)
      #v(0.3cm)
      #content
    ]
  )
}

// Referencias de metodología
#let methodology-ref(method, parameter, standard) = {
  text(size: size-tiny, [
    *#method* | #parameter | #standard
  ])
}

// ============================================
// CONSTANTES DE DISEÑO
// ============================================

#let spacing-xs = 0.1cm
#let spacing-sm = 0.2cm
#let spacing-md = 0.3cm
#let spacing-lg = 0.5cm
#let spacing-xl = 1cm

// ============================================
// INFORMACIÓN REGULATORIA
// ============================================

#let regulatory-colombia = [
  *Estándar:* NTC 5219 (Colombia)\
  *Regulación:* Resolución 810 de 2021\
  *INVIMA:* Normativa aplicable
]

#let disclaimers = [
  Los valores se basan en la formulación del producto y cálculos USDA.
  Variaciones naturales pueden ocurrir entre lotes.
  Para consultas: contacto@asorepp.org
]

// Exportar constantes
#let _ = (
  color-primary,
  color-secondary,
  color-accent,
  color-neutral,
  color-border,
  color-background,
  font-body,
  font-heading,
  stroke-thick,
  stroke-medium,
  stroke-thin,
  table-cell,
  section,
  methodology-ref,
)
