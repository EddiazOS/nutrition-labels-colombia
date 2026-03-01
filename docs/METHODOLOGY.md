# Metodología de Determinación Nutricional

## Introducción

Este documento describe la metodología utilizada para determinar los valores nutricionales de los productos ASOREPP, cumpliendo con:

- **NTC 5219** - Norma Técnica Colombiana (Información nutricional)
- **Resolución 810 de 2021** - Normativa INVIMA
- **AOAC International** - Métodos analíticos estándar
- **USDA FoodData Central** - Base de datos de composición de alimentos

## 1. Métodos Analíticos Directos

### 1.1 Humedad (AOAC 925.10)

**Procedimiento:**
- Método: Gravimetría directa
- Equipo: Balanza analítica de precisión (precisar 0.001 g)
- Temperatura: 105°C
- Tiempo: Hasta peso constante
- Muestras: 3 repéticiones mínimo

**Fórmula:**
```
Humedad (%) = [(Peso inicial - Peso final) / Peso inicial] × 100
```

**Laboratorio:** Laboratorio de Análisis de Alimentos - ASOREPP

### 1.2 Cenizas Totales (AOAC 923.03)

**Procedimiento:**
- Método: Calcinación en horno a mufla
- Temperatura: 550°C
- Tiempo: 3-4 horas hasta residuo blanco
- Muestras: 3 repéticiones

**Fórmula:**
```
Cenizas (%) = (Peso residuo / Peso muestra) × 100
```

### 1.3 Sodio - Método Mohr

**Procedimiento:**
- Método: Potenciometría (Medición de cloruros)
- Preparación: Mineralización ácida
- Equipamiento: Electrodo de cloruro selectivo
- Cálculo estequiométrico Na = Cl × (22.99/35.45)

## 2. Métodos Calculados

### 2.1 Fibra Dietética - USDA Factor

**Procedimiento:**
- Fuente: USDA FoodData Central (SR Legacy v28)
- Aplicación: Factor de corrección por concentración
- Para harina de plátano verde: Factor 1.85 (textura y procesamiento)

**Cálculo:**
```
Fibra (g/100g) = Fibra base USDA × Factor concentración × (100 - Humedad)/100
```

### 2.2 Proteínas - Cálculo por Nitrógeno

**Método Kjeldahl (referencia):**
- Factor de conversión estándar: 6.25
- Factor específicos por producto disponibles en laboratorio

**Cálculo:**
```
Proteínas (g) = Nitrógeno Total (g) × Factor
```

### 2.3 Carbohidratos Disponibles - Por Diferencia

**Procedimiento:**
- Fórmula estándar internacional

**Cálculo:**
```
Carbohidratos disponibles = 100 - (Humedad + Cenizas + Proteínas + Grasa Total + Fibra)
```

### 2.4 Grasas - Cálculo Teoríco

**Fuente:** USDA FoodData Central ajustado por:
- Tipo de procesamiento
- Condiciones de almacenamiento
- Variabilidad natural de la materia prima

## 3. Tablas de Referencias

### 3.1 Métodos por Parámetro

| Parámetro | Método | Estándar | Laboratorio |
|-----------|--------|----------|-------------|
| Humedad | AOAC 925.10 | Gravimetría | ASOREPP |
| Cenizas | AOAC 923.03 | Calcinación | ASOREPP |
| Proteína | Kjeldahl | AOAC 979.09 | ASOREPP |
| Grasa Total | Cálculo | USDA | USDA |
| Sodio | Mohr | Potenciometría | ASOREPP |
| Carbohidratos | Diferencia | Estándar Int'l | Calculado |
| Fibra Dietética | Cálculo | USDA Factor | USDA |

### 3.2 Factores de Conversión de Energía

- **Proteínas:** 4 kcal/g
- **Grasas:** 9 kcal/g  
- **Carbohidratos disponibles:** 4 kcal/g
- **Fibra dietética:** 2 kcal/g (factor colombiano)

**Cálculo de energía:**
```
Energía (kcal) = (Proteína × 4) + (Grasa × 9) + (Carbs disp × 4) + (Fibra × 2)
```

## 4. Control de Calidad

### 4.1 Criterios de Aceptación

- **Coeficiente de variación (CV):** < 5% entre réplicas
- **Recuperación de estándares:** 95-105%
- **Blancos:** < 2% de la muestra
- **Replicabilidad:** Diferencia máxima 5% entre réplicas

### 4.2 Documentación

- Certificados de análisis archivados
- Trazabilidad de muestras
- Calibración de equipos (trimestral)
- Documentación de desviaciones

## 5. Normas Aplicables

### Normativa Colombiana
- **NTC 5219:2020** - Etiquetado Nutricional
- **Resolución 810 de 2021** - Normativa de Etiquetado
- **Decreto 1575 de 2007** - Agua Potable y Minerales

### Normas Internacionales
- **AOAC International 2019** - Métodos Analíticos
- **FAO/WHO Codex Alimentarius** - Estándares Internacionales
- **USDA FoodData Central** - Composición de Alimentos

## 6. Variabilidad y Tolerancias

### 6.1 Causas de Variabilidad Natural

- Variabilidad genética de la materia prima
- Condiciones de cultivo y clima
- Grado de madurez
- Procesamiento y deshidratación
- Condiciones de almacenamiento

### 6.2 Tolerancias Permitidas

Según NTC 5219:

| Contenido Decl. | Tolerancia |
|-----------------|------------|
| < 100 kcal | ±20 kcal |
| 100-200 kcal | ±20% |
| > 200 kcal | ±10% |
| Componentes | ±20% (máximo) |

## 7. Validez de la Información

- **Vigencia:** 24 meses desde fecha de análisis
- **Condición:** Producto almacenado en condiciones óptimas
- **Revisión:** Análisis cada lote o cambio de proveedores de materia prima

## 8. Referencias Bibliográficas

1. AOAC International (2019). *Official Methods of Analysis of AOAC International* (21st ed.)
2. USDA (2021). *FoodData Central - SR Legacy v28*. United States Department of Agriculture
3. ICONTEC (2020). *NTC 5219:2020 - Etiquetado Nutricional de Alimentos*
4. Instituto Nacional de Salud (2021). *Resolución 810 de 2021 - Normativa de Etiquetado*
5. FAO/WHO (2019). *Codex Alimentarius: General Standard for the Labeling of Food*

## 9. Historial de Revisiones

| Versión | Fecha | Cambios | Autor |
|---------|-------|---------|-------|
| 1.0 | 2026-02-15 | Documento inicial | ASOREPP Lab |
| 1.1 | 2026-03-01 | Actualización metodología | Sistema |

---

**Documento de Referencia Oficial - ASOREPP**

*Para consultas técnicas: lab@asorepp.org*
