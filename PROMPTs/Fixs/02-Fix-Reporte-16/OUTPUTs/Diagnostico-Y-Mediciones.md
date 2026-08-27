# Diagnóstico y mediciones — Fix del reporte 16

**Documento:** Diagnostico-Y-Mediciones.md
**Versión:** 1.0
**Fecha:** 2026-08-23
**Origen:** `PROMPTs/Fixs/02-Fix-Reporte-16/Fix-Analizar-Reporte-16.md`
**Aplicado en:** SDD **13.6**

---

## 1. Estado del árbol al arrancar

| Comprobación | Resultado |
| --- | --- |
| `git status --short` en `IA.SDD` | **0 líneas.** Árbol limpio |
| Versión del conjunto | **13.5** |
| Versión que el reporte evaluó | 13.3 |
| Versión que el prompt del fix declara | 13.4 |

**Se declara la deriva**: el prompt se escribió contra 13.4 y el framework publicó la 13.5 antes de que
esta intervención corriera. No amplía el alcance —la 13.5 no tocó §10.0— pero se registra porque el
propio prompt pide decirlo si algo cambió.

## 2. Solicitud 1 — qué ya estaba resuelto, propuesta por propuesta

| Propuesta | Comando | Salida | Veredicto |
| --- | --- | --- | --- |
| **6.1** | `grep -c "banco de inyección\|caso que la ejerce"` sobre `Master-Prompt.md` y `SDD-Development-Guide.md` | `0` y `0` | **No entró** |
| **6.2** | Lectura de §10.0 | «La compuerta declara qué no mira… enuncia explícitamente el alcance» | **Parcial**: obliga a declarar, en prosa, sin enumerar recortes |
| **6.3** | `grep -c "no se declara cerrado sin\|cerrado sin su caso"` sobre `Master-Prompt.md` | `0` | **No entró** |
| **§7 crit. 4** | `grep -n "proporción\|detectables por guion"` sobre `Master-Prompt.md` | Línea 1310: «6.2. Proporción de hallazgos detectables por guion…» | **Ya existía.** No se toca |

## 3. Solicitud 5, §8.1 — la medición del recuento

**El prompt obliga a medir antes de corregir**, porque si el reporte contó mal el hallazgo es del
reporte.

**Método.** Contar filas de tabla (`^|`) que llevan marca `[enumerable]` o `[interpretativo]` en los
diecinueve archivos de regla, **excluyendo las filas de control de cambios** por su patrón de fecha
`20NN-NN-NN`. Sin esa exclusión el conteo crudo da 274 / 430, porque las marcas aparecen también en
prosa, en criterios de aceptación y en el registro histórico.

| Archivo | `[enum]` | `[interp]` | Total |
| --- | --- | --- | --- |
| `Deriva-Rules.md` | 5 | 10 | 15 |
| `Maqueta-Rules.md` | 2 | 12 | 14 |
| `Migracion-Rules.md` | 3 | 5 | 8 |
| `Root-Rules.md` | 3 | 4 | 7 |
| `Rules-Arquitectura-Tecnica.md` | 7 | 4 | 11 |
| `Rules-Backlog-Tecnico.md` | 5 | 6 | 11 |
| `Rules-Base-Conocimiento.md` | 3 | 3 | 6 |
| `Rules-Calidad-Y-Pruebas.md` | 8 | 2 | 10 |
| `Rules-Contexto.md` | 4 | 4 | 8 |
| `Rules-Devops.md` | 8 | 5 | 13 |
| `Rules-Documentacion.md` | 5 | 14 | 19 |
| `Rules-Especificacion-Funcional.md` | 8 | 7 | 15 |
| `Rules-Examples.md` | 9 | 8 | 17 |
| `Rules-Necesidades-Negocio.md` | 4 | 4 | 8 |
| `Rules-Plan-Sprint.md` | 7 | 4 | 11 |
| `Rules-Prompts-AI.md` | 7 | 3 | 10 |
| `Rules-UX-UI-DX.md` | 12 | 13 | 25 |
| **TOTAL MEDIDO** | **100** | **108** | **208** |

**Contraste:**

| Fuente | Declara | Veredicto |
| --- | --- | --- |
| Medición | 100 / 108 / 208 | — |
| `Catalogo-De-Criterios.md` §4 | 100 / 108 / 208 | **Correcto** |
| `Master-Prompt.md` §10.0 | 97 / — / 202 | **Viejo** |

**El hallazgo no es del reporte.** Y la corrección aplicada **no fue actualizar el número**: §10.0 dejó
de transcribirlo y cita el catálogo, porque un dato derivado en la prosa que ya envejeció dos veces sin
que nada lo detectara es lo que `Root-Rules.md` §10 prohíbe.

## 4. Barrido de pendientes del framework, anexado a esta intervención

| # | Hallazgo | Evidencia | Severidad |
| --- | --- | --- | --- |
| 1 | **Ítem diferido con su evento de cierre cumplido, abierto tres versiones.** El ítem 4 de `Coherencia-Renumeracion-AG.md` §8 no escribía el reparto del bloque `009xx` porque «no hay un segundo rol que fuerce la decisión»; `AG-00980` lo fue, en la **13.2** | Lectura del ítem contra el control de cambios de `Root-Rules.md` | **P1** por `Root-Rules.md` §12.2 |
| 2 | **Afirmación falsa en una entrada publicada.** `CHANGELOG.md` [13.5] dice que `SDD-User-Guide.md` 1.19 declara que `AG-00980` «existe pero todavía no se convoca». `grep -c "AG-00980"` sobre esa guía devuelve **0** | Medición | S2 |
| 3 | **Afirmación vencida.** `SDD-Development-Guide.md` §III.11 decía lo mismo, y ahí sí era cierto hasta la 13.5 | Lectura | S2 |
| 4 | **Solapamiento `009xx` con categorías `90`-`99`**, agravado a dos ocupantes | Ítem diferido 5, su evento **no** ocurrió | S3, sigue diferido |

**Sobre el 2, y es lo que corresponde declarar**: la entrada [13.5] **no se reescribe**. El
`CHANGELOG.md` es acumulativo y su historia es su contenido; la corrección se declara en la [13.6].

**Sobre el 1, cómo pasó.** La intervención que acuñó `AG-00980` verificó que el identificador estuviera
libre y que el bloque lo admitiera. **Lo que no hizo fue preguntarse a qué ítem diferido le cumplía la
condición.** La comprobación existía —`Master-Prompt.md` §10.0 la enumera— y nadie la corrió contra el
registro de diferidos.

## 5. Falsos positivos declarados

Dos rutas que un barrido de referencias marca y **no son defectos**:

| Ruta | Dónde | Por qué no es defecto |
| --- | --- | --- |
| `Rules-Observabilidad.md` | `SDD-User-Guide.md` §1284 | Es un **ejemplo hipotético** de un recorrido de extensión |
| `devs/Rules/decisiones-D1-D8.md` | `Marco-Teorico-SDD.md` §1961 | Es una **fila histórica** de control de cambios que describe una corrección pasada |

## 6. Lo que no se pudo verificar, y por qué

**Los cuatro criterios de §7 del reporte no son verificables sobre el framework.** Los tres primeros se
verifican **sobre la compuerta de un destino**, que es donde vive el instrumento; el framework sólo
puede declarar la obligación. Lo que sí se verificó acá es que la obligación quedó escrita y con qué
alcance temporal.

**Los incidentes de §3 del reporte no se re-verificaron.** Son de un destino real y el reporte declara
que están en su historial de commits; esta intervención no abrió ese repositorio, porque su prompt
declara que **no se toca ningún repositorio de destino**.
