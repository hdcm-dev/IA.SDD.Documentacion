# Mapeo de renumeración de la familia `AG` — de dónde parte y hacia dónde va

**Documento:** Mapeo-Renumeracion-AG.md
**Versión:** 1.0 — **para evaluación, antes de que se toque un archivo**
**Fecha:** 2026-08-22
**Framework vigente:** SDD **11.2**

**Por qué existe.** Los tramos T2 y T3 se retiraron tras cinco rondas de auditoría, y el error de
método fue el mismo: **se declaró la regla aplicable sin haber producido el mapeo que la hace
cumplible**. El corpus pasaba de *«coherente con una excepción declarada»* a *«incumpliendo su propia
regla en 706 lugares»*. **Este documento es el paso que faltaba: el mapeo se arma, se evalúa, y recién
después se aplica.**

---

## 1. De dónde parte — inventario completo, con su comando

```bash
grep -rhoE "AG-[0-9A-Za-z]+" SDD PROMPTS Templates README.md CHANGELOG.md | sort | uniq -c | sort -rn
```

| Identificador | Ocurrencias | Clase |
|---|---|---|
| `AG-00` `AG-01` `AG-02` `AG-03` `AG-04` `AG-05` `AG-06` `AG-07` `AG-08` `AG-09` `AG-10` `AG-11` | 78·29·42·**105**·25·51·34·17·44·34·40·54 | **A · Titular de categoría.** Uno por cada una de las doce categorías de `Docs/` |
| `AG-ROOT` | **91** | **B · Titular de nivel producto.** No gobierna una categoría: compone la narrativa global y valida la coherencia transversal |
| `AG-03M` | **32** | **C · Subagente de fase.** El de la Fase B2. *«No altera el número de especialidades porque **no es titular de ninguna categoría**»* |
| `AG-XX` | **30** | **D · Marcador de plantilla.** No es un identificador: es el hueco que un ejemplo o una regla deja para «cualquier AG» |
| **TOTAL** | **706 en 63 archivos** | |

**El total que este plan venía citando —585— era falso**: el patrón que lo produjo excluía `AG-ROOT`.
Es el defecto de R2 —un recuento sin fuente declarada— cometido por el documento que lo denuncia.

**Las cuatro clases se tratan distinto, y confundirlas rompe algo:**

- La **D** no se renumera: **se reescribe** como `AG-XXXXX`, porque es un marcador de ancho, no una instancia.
- La **C** no puede recibir un número «siguiente libre» sin decidir antes qué se hace con su relación con la **A** que la origina.

## 2. Hacia dónde va — dos diseños, y la tensión es real

`Root-Rules.md` §9.2 exige **prefijo y cinco dígitos uniformes**, y declara que *«el ancho no se negocia
por familia»*. Las cuatro clases tienen que caber ahí.

### Diseño 1 · Rango con significado

La categoría `NN` toma `AG-00NN0`; sus subagentes de fase toman `AG-00NN1`, `AG-00NN2`…

| Viejo | Nuevo | |
|---|---|---|
| `AG-00` … `AG-11` | `AG-00000` … `AG-00110` | El número de categoría **queda legible** |
| `AG-03M` | **`AG-00031`** | **La hermandad con el `03` queda escrita en el número** |
| `AG-ROOT` | `AG-00990` | Bloque reservado para roles que no son de categoría |

**A favor:** no se pierde nada de lo que hoy se lee de un vistazo, y **el framework ya usa rangos** —
*«el reparto de rangos es dentro de cada familia»*.

**En contra, y es del propio corpus:** **§10 R5 dice que un identificador no debe cargar una relación**
— *«una ruta codifica identidad y posición; la segunda se rompe cuando algo la altera»*. Codificar
«hermano del 03» en el número **es meter una relación adentro de la identidad**. Si la categoría 03 se
renombrara o se moviera, el identificador **mentiría**.

### Diseño 2 · Identificador opaco, relación declarada

Correlativo simple, y la hermandad vive en el catálogo:

| Viejo | Nuevo |
|---|---|
| `AG-00` … `AG-11` | `AG-00001` … `AG-00012` |
| `AG-ROOT` | `AG-00013` |
| `AG-03M` | `AG-00014`, **con `Marco-Teorico-SDD.md` §4.2 declarando que es subagente de fase de `AG-00004`** |

**A favor:** coherente con R5 — la identidad no carga relaciones, y la relación se declara donde se
puede cambiar sin renumerar.

**En contra:** se pierde la legibilidad inmediata. Hoy `AG-03M` se entiende sin abrir nada.

### Recomendación

**Diseño 1**, con una salvedad declarada: **el riesgo que R5 advierte no aplica acá**, porque el
conjunto de las doce categorías **es cerrado y estable** —`Docs/` 00 a 11— y cambiarlo es, por §III.1
de la guía, una intervención mayor que renumeraría igual. **Donde R5 muerde es en colecciones que
crecen; ésta no crece.**

**Y si se elige el Diseño 2**, la relación tiene que quedar **declarada en el mismo acto**, no diferida:
un `AG-00014` sin nadie que diga de quién es hermano es información perdida, no información movida.

## 3. Cómo se evalúa el mapeo **antes** de aplicarlo

**Las cinco pruebas, y las cinco son mecánicas salvo la última:**

| # | Prueba | Cómo se corre |
|---|---|---|
| 1 | **Total** | Cada uno de los **15 identificadores distintos** del inventario tiene destino. Se cuentan las filas del mapeo contra las del inventario |
| 2 | **Inyectivo** | Ningún destino repetido: `sort` sobre la columna nueva, `uniq -d` vacío |
| 3 | **Sin colisión** | Ningún destino existe ya en el árbol: `grep` de cada nuevo sobre el árbol vivo devuelve cero |
| 4 | **Conforme** | Los quince destinos cumplen `AG-[0-9]{5}`, y el marcador `AG-XXXXX` cumple el ancho |
| 5 | **Preserva significado** *(interpretativo)* | Por cada identificador, **qué se leía de él antes y qué se lee después**. Es la única que no la decide un comando |

**Y una prueba de reversibilidad**, porque la renumeración toca artefactos ya emitidos: el mapeo tiene
que poder **leerse al revés** para que un destino con la forma vieja se pueda migrar. Eso lo cubre
`Master-Prompt.md` §2 paso 1, la tolerancia de nombres legados — **y hay que declarar que aplica**.

## 4. Alcance de la aplicación

| Dónde | Qué pasa |
|---|---|
| **63 archivos del framework** | Reemplazo por el mapeo, con barrido y residuo cero fuera de las clases estables |
| **Artefactos ya emitidos de destinos** | Los `README.md` de producto que copiaron la columna «Responsable» del ejemplo de §7.1 — que **§4.2 punto 4 no exige**. Es **migración**, y va al bloque «Impacto sobre destinos existentes» |
| **Plantillas y ejemplos cercados** | `AG-XX` → `AG-XXXXX`. **Entrar a los cercos es obligatorio**: §VI.3.1 regla 5, con el caso medido de las 26 cabeceras |

## 5. Qué se decide antes de empezar

| # | Decisión | Sin ella no se puede |
|---|---|---|
| **A** | **Diseño 1 o 2** | Escribir el mapeo |
| **B** | Si es el 1: **qué bloque toma `AG-ROOT`** y si se reservan otros | Cerrar la tabla |
| **C** | Si es el 2: **dónde se declara la relación de `AG-03M`** | No perder información |
| **D** | Si el ámbito y **D3** entran en el mismo tramo o en el siguiente | Fijar el bump y el bloque de impacto |

**Lo que este documento no hace, a propósito: no toca un solo archivo.** El mapeo se evalúa con las
cinco pruebas de §3 y **recién entonces** se aplica — que es el orden que los dos tramos retirados no
siguieron.
