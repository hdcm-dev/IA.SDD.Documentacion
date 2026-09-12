# 00 — Qué sigue vivo: las citas del reporte `26` y sus dos afirmaciones por ausencia

**Fecha:** 2026-09-12
**Framework evaluado:** `IA.SDD` en `476f927` (SDD **13.10**), árbol limpio
**Evidencia cruda:** [`evidencia/ev12.sh`](evidencia/ev12.sh) y su salida [`evidencia/ev12.out`](evidencia/ev12.out). Cada fila de abajo nombra el bloque de esa salida donde está el comando y lo que devolvió.

**Orden de ejecución.** Esta intervención corre **primera** de las cuatro (`04` → `06` → `05` → `03`), como pide su prompt: `PROMPTs/Fixs/README.md` declara las otras tres «Sin aplicar» y `IA.SDD` no tiene ninguna versión posterior a la 13.10 (`git log` en `476f927`). **No hay nada de este reporte que ya esté resuelto por otra vía.**

---

## 1. Solicitud 1 — cita por cita

**Un reporte es evidencia, no autoridad.** Una cita puede seguir literal y la lectura que el reporte hace de ella no sostenerse, y por eso la tabla separa las dos columnas.

| # | Lo que el reporte cita | ¿Literal en 13.10? | ¿Se sostiene la lectura? | Evidencia |
|---|---|---|---|---|
| 1 | `Master-Prompt.md` §7.0: el registro agrupa **lo que el humano difirió** y se exhibe **al cerrar cada fase** | **Sí** — líneas 622 y 626 | **Sí** | `S1.a` |
| 2 | `Master-Prompt.md` §8: *«Si al abrir el entregable encontrás contenido que el snapshot no refleja, detenete y devolvelo como ambigüedad según §9, sin editar»* | **Sí** — línea 810, verbatim | **No, y es el hallazgo más importante de esta verificación.** Ver §1.1 | `S1.b`, `S1.c`, `S1.k` |
| 3 | `Master-Prompt.md` §8.1: la pregunta previa en una línea, la tabla de **dos filas** y «ante la duda, se detiene» | **Sí** — líneas 934, 914–915 y 944 | **Sí** | `S1.d` |
| 4 | `Master-Prompt.md` §9: el formato de ambigüedad no declara procedencia | **Sí** — bloque de las líneas 1016–1027 | **Sí.** Pero el reporte afirma en §2.5 que *«ni existe fuera de la mesa el campo que dice qué pasa si no se contesta»*, y **§9 lo tiene**: línea 1027, *«Qué pasa si no se responde ahora»*. Lo que no lo tiene es el bloque general de §8.1 | `S1.e`, `S1.n` |
| 5 | `Mesa-Rules.md` §0.1: de cinco detenciones, **tres no eran del Product Owner** | **Sí** — línea 64 | **Sí.** Con una salvedad de recuento: la tabla se presenta como *«Tres mediciones del framework»* (línea 60) y sus filas 2 y 3 citan el **mismo** informe. Son **dos causas** medidas, que es la lectura del cuerpo del reporte (*«es una tercera»*, línea 136) y no la de su título (*«es una cuarta»*, línea 126). **El reporte se contradice entre su título y su cuerpo**; esta intervención usa «tercera causa» | `S1.f`, `S1.n` |
| 6 | `Mesa-Rules.md` §0.2: la frontera con el audit | **Sí** — línea 75 | **Sí** | `S1.f` |
| 7 | `Mesa-Rules.md` §7: siete disparadores, la inversión de la asimetría y *«una consulta de más en un lote de veinte entrena a firmar el lote sin leerlo»* | **Sí** — 7 filas contadas; la frase aparece literal con un salto de línea en medio | **Sí** | `S1.g` |
| 8 | `Mesa-Rules.md` §7.1: *«las escaladas se entregan agrupadas al cierre del ciclo, no de a una»* y el campo `SI NO RESPONDÉS` | **Sí** — líneas 572 y 579 (la cita difiere sólo en la mayúscula inicial) | **Sí** | `S1.g` |
| 9 | `Mesa-Rules.md`: la mesa *«corre en puntos fijos»* (reporte §2.5, línea 145) | — | **No contra 13.10.** Desde la 13.8 la mesa se convoca **por condición** (`Mesa-Rules.md` §0.0, línea 23), y el propio reporte lo reconoce en §3.1. **§2.5 quedó vieja; su sustancia no**: dentro del bucle de fases sigue sin haber filtro que mire las detenciones juntas | `S1.f`, `S1.n` |
| 10 | `Master-Prompt-Reanudacion.md` §6: el único criterio que roza el tema verifica que toda consulta sea de la lista cerrada | **Sí** — línea 501 | **Sí** | `S1.h` |
| 11 | `Memoria-De-Antecedentes-Casos-Resueltos.md` §2.2: diez hallazgos, tres no eran lo que declaraban; *«hubo que abrir los cinco y cruzarlos a mano»* | **Sí** — líneas 80, 82 y 90 | **Sí** | `S1.i` |
| 12 | Reporte §2.1: `procedencia` tiene **14 ocurrencias** en `Master-Prompt.md`, en §0, §2.1, §3, §5 y §7, **ninguna en §8, §8.1 ni §9**; y **16** en `Migracion-Rules.md` | — | **La conclusión se sostiene; los números no son lo que dicen ser.** Medido: `Master-Prompt.md` tiene **17 ocurrencias en 14 líneas** —el «14» son líneas— y la lista de secciones **omite §16** (3 líneas, control de cambios); «§5» es §5.1 y «§7» es §7.0. **Ninguna en §8, §8.1 ni §9: confirmado.** `Migracion-Rules.md` tiene **23 ocurrencias en 16 líneas**, y la frase de la v1.2 del reporte *«viven en §4.5, §4.6 y la checklist de §6»* omite §0, §2.3, §3, §4.3.2, §5, §7 y §9. Esto último es alcance de la intervención `05`, y se le deja anotado acá | `S1.j` |

### 1.1 La cláusula de §8 no produce el caso del reporte

**El reporte §2.1.1 lee la cláusula así:** un agente que dejó algo a medias en una unidad anterior de la
misma corrida produjo *«contenido que el snapshot no refleja —el snapshot se tomó antes—»*, y por eso la
cláusula lo manda detener.

**El snapshot no se tomó antes de la corrida: se toma al construir cada despacho.**

- Línea 810: *«el orquestador ya archivó el estado previo del entregable en la ruta indicada, **antes de construir este despacho**»*.
- Línea 843: *«Cuando resuelve `EXISTENTE`, **el orquestador toma el snapshot en ese momento**»*.

**De modo que lo que dejó una unidad anterior de la misma corrida está adentro del snapshot**, y al abrir el
entregable no hay diferencia que detectar. La cláusula **no se dispara** en el caso del reporte. Se dispara
cuando el entregable cambió **entre el archivado y la apertura**, que es una edición ajena o un despacho
paralelo de la misma corrida sobre un documento compartido (`Master-Prompt.md` §7: *«unidades del mismo
nivel paralelizables»*, y §8: *«Los compartidos con otras unidades de entrega van marcados»*, bloque
`S3.a` de [`evidencia/ev-decision.out`](evidencia/ev-decision.out)).

**Lo que eso cambia no es el hueco sino la pieza que lo resuelve.** El reporte localizó la cláusula correcta
por el motivo equivocado, y de ahí sacó que el snapshot es el insumo con que se calcula la procedencia.
**No lo es**, y el análisis completo está en [`10-Decision-Origen-Del-Hecho.md`](10-Decision-Origen-Del-Hecho.md) §3.

**Y la cláusula existe dos veces**, cosa que el reporte no cita: `Master-Prompt-Migracion.md` §8 M4, línea
291, la repite para las correcciones manuales de una migración (`S1.k`). Cualquier corrección que la toque en
un lugar tiene que tocarla en los dos.

### 1.2 Lo que queda en pie

**El hueco central sigue vivo en 13.10**: la decisión de elevar se toma con una sola pregunta (§8.1, línea
934), la tabla de autocorrección tiene dos filas (líneas 914–915), ningún formato declara de dónde salió el
hecho (§2 abajo), y el agrupamiento del bucle de fases mira lo diferido y no lo que está por salir (§7.0,
línea 622). **Las cuatro inexactitudes de arriba corrigen la evidencia, no la tesis.**

---

## 2. Solicitud 2 — las dos afirmaciones por ausencia

### 2.1 Ningún artefacto tiene un término para «estado que el propio agente produjo y no cerró»

**Búsqueda:** `grep -rniw --include='*.md' --exclude-dir=_legacy` sobre todo `IA.SDD`, con **diecisiete
términos** (`S2.a`):

| Término | Ocurrencias | Sentido de las que aparecen |
|---|---|---|
| «a medias» | 26 | El **objeto** de una decisión («lo que se decide está a medias», línea 873), la migración a medias, «entregar trabajo a medias» de la autocorrección. **Ninguna dice quién produjo lo que está a medias** |
| «sin cerrar» | 4 | Placeholders de tabla y ADR sin cerrar |
| «estado propio» | 2 | Estado de un componente, en los dos documentos de conocimiento de maqueta |
| «de esta corrida» | 2 | Prosa de notas de coherencia |
| «de la corrida» | 11 | Prosa ordinaria, **salvo una**: `Mesa-Rules.md` §0.2, línea 77, define el objeto de la mesa como *«el corpus que ya existía **antes de la corrida**»*. Es la única línea del árbol que corta por el momento de la corrida, y lo hace **sin instrumento** que diga qué había antes |
| «preexistente» | 24 | Base de datos preexistente, `ISSUE-XXXXX` preexistente, fin de línea CRLF preexistente. Ninguna clasifica el hecho de una detención |
| «dejó a medias», «estado a medias», «propio agente», «que el agente produjo», «produjo y no cerró», «generó el propio», «origen del hecho», «procedencia del hecho», «autoinformad», «quién produjo», «quién generó» | **0** cada uno | — |

**Confirmado: no hay término.** Lo más cercano es **«defecto propio»** (§8.1, líneas 909 y 914), que es
*«un defecto del propio trabajo»* corregible **en la misma unidad**: no alcanza un estado que atraviesa
unidades, que es el caso del reporte.

**Límite de la búsqueda, declarado.** Es léxica: un concepto dicho con otras palabras se le escapa. Por eso
se leyeron **enteras** las secciones donde el concepto viviría —`Master-Prompt.md` §7.0, §8, §8.1 y §9,
`Mesa-Rules.md` §0 y §7, `Master-Prompt-Reanudacion.md` §2, §3 y §6— y ninguna lo contiene.

### 2.2 Ningún formato de detención tiene campo de procedencia

**El reporte nombra tres formatos. Hay más, y se revisaron todos** (`S2.b`):

| # | Formato | Dónde | ¿Detiene o presenta al humano? | Campo de procedencia |
|---|---|---|---|---|
| 1 | `DETENCIÓN —` | `Master-Prompt.md` §8.1 | Sí | **No** |
| 2 | `CIERRE DE UNIDAD —`, bloque de decisiones pendientes | `Master-Prompt.md` §8.1 | Sí | **No.** La coincidencia `Corregido: defectos propios` es la lista de la autocorrección, no el origen de una detención |
| 3 | `AMBIGÜEDAD DETECTADA` | `Master-Prompt.md` §9 | Sí | **No** (bloque completo en `S1.e`; la coincidencia «33:» de `S2.b` cae **fuera** del bloque, en §9.1, porque el cerco está indentado y el `awk` siguió de largo) |
| 4 | `PEDIDO DE CONOCIMIENTO` | `Master-Prompt.md` §9.1 | **No va al humano**: lo resuelve el orquestador | No |
| 5 | Escalada de mesa (§8.1 más `SI NO RESPONDÉS`) | `Mesa-Rules.md` §7.1 | Sí | **No.** La coincidencia es el adjetivo en «un campo propio de la mesa» |
| 6 | `TRABAJO ENTREGADO —` | `Master-Prompt.md` §12.1 T4 | Sí | No |
| 7 | `COMPUERTA DE ARRANQUE —` | `Master-Prompt.md` §12.1 T0 | Detiene | No, **y tampoco lleva el commit sobre el que corrió** (`S1.l`), que va a importar en la decisión |
| 8 | `Estado del destino` | `Master-Prompt-Reanudacion.md` §3 R1 | Detención obligatoria | **No.** «Procedencia declarada: SDD» es la versión del framework, el otro sentido del término |
| 9 | `RECOMENDACIÓN —` | `Master-Prompt-Reanudacion.md` §4.0 | Sí | No. «Continuidad del origen» es la versión de origen |
| 10 | Fila del registro de decisiones pendientes | `Master-Prompt.md` §7.0 | Se exhibe al cerrar fase | **No.** Lo más parecido del árbol: *«quién la origina —categoría, proyecto de código y fase—»* (líneas 619–620). Dice **quién levanta** la decisión, no **quién produjo** el hecho, y lo declara quien la levanta |

**Las detenciones de la migración no tienen formato propio**: `Master-Prompt-Migracion.md` línea 50
declara que *«todas las de este prompt siguen `Master-Prompt.md` §8.1»*, y sus dos bloques de presentación
—el reconocimiento de M0 y el diff de estructura de M2— son informativos.

**Confirmado: ninguno de los diez tiene el campo.** El reporte nombró tres y la afirmación vale para diez.

---

## Control de cambios

| Versión | Fecha | Cambios | Autor |
|---|---|---|---|
| 1.0 | 2026-09-12 | Emisión. Verifica las doce citas del reporte `26` contra SDD 13.10 y sus dos afirmaciones por ausencia con la búsqueda a la vista. Levanta **cuatro inexactitudes de evidencia** —la cláusula de §8 no se dispara en el caso del reporte porque el snapshot se toma por despacho; §9 sí tiene el campo de qué pasa si no se responde; la mesa se convoca por condición desde la 13.8; los recuentos de `procedencia` son de líneas y con secciones omitidas— y la contradicción entre el título y el cuerpo de §2.4. **Ninguna cae sobre la tesis**, que sigue viva. | Intervención `04` |
