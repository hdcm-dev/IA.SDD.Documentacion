# 30 — Verificación del plan aplicado, contra el diff real y contra los seis criterios de §7

**Fecha:** 2026-09-12 · **Base:** `IA.SDD` `9dc8ded` (SDD 13.11) · **Resultado:** SDD **13.12**
**Evidencia cruda:** [`evidencia/ev-30.sh`](evidencia/ev-30.sh) y su salida [`evidencia/ev-30.out`](evidencia/ev-30.out)

**Contexto de esta pieza.** Esta corrida retoma una sesión que se cortó por límite antes de escribir este archivo.
Los `OUTPUTs/00`, `10` y `20`, el `CHANGELOG.md`, la nota de coherencia y el cierre documental (reporte `28` y los
dos `README.md`) ya estaban escritos y sin commitear cuando se retomó. Esta pieza contrasta lo que esos documentos
**declaran haber aplicado** contra lo que el árbol de trabajo **efectivamente tiene**, con comando al lado en cada
afirmación, tal como exige la propia intervención.

---

## 1. Solicitud 9 — el plan (`20`) contra el diff real

`git diff --stat main` sobre `IA.SDD` (`evidencia/ev-30.out`, bloque 1 y 8) da exactamente los siete archivos que
`20-Plan-De-Aplicacion.md` declara como ítems 1 a 7, ni uno más:

| Archivo | Declarado en el plan | Aplicado |
|---|---|---|
| `CHANGELOG.md` | Ítem 7 | Sí |
| `SDD/Devs/Orchestrator/Master-Prompt.md` | Ítem 2 | Sí |
| `SDD/Devs/Rules/Catalogo-De-Criterios.md` | Ítem 6 | Sí |
| `SDD/Devs/Rules/Mesa-Rules.md` | Ítem 3 | Sí |
| `SDD/Devs/Rules/Vocabulario-Rules.md` | Ítem 1 | Sí |
| `SDD/Guides/SDD-Development-Guide.md` | Ítem 4 | Sí |
| `SDD/Guides/SDD-User-Guide.md` | Ítem 5 | Sí |
| `SDD/Devs/Guides/Coherencia-Colision-Lexica.md` (nuevo) | Ítem 8 | Sí |
| `_legacy/13.11/` (nuevo) | Ítem 0 | Sí, verificado en §2 |

**No hay ningún archivo tocado que el plan no declare, y no hay ningún archivo del plan sin tocar. No es un
hallazgo de la propia intervención**, a diferencia de lo que la solicitud 9 previene: el conjunto aplicado
corresponde uno a uno con el propuesto.

**Por dentro de cada archivo**, releído contra la tabla «Qué cambia» del plan y contra la entrada 13.12 del
`CHANGELOG.md`: `Vocabulario-Rules.md` trae §8 en tabla, §9.2 por lector, §9.4 con la obligación de comando, §9.6
con la cita ajustada y el primer `[enumerable]` de §10 — los cinco puntos que el plan anuncia. `Master-Prompt.md`
trae la comprobación 7 de §10.0, el criterio de polisemia de §10 y las tres entradas de §15. `Mesa-Rules.md` trae
§6.1 y §8. Las dos guías y el catálogo traen exactamente lo que sus filas anuncian, más el reordenamiento de
registro que el propio `CHANGELOG.md` declara como hallazgo de la intervención (ver §3).

## 2. Fidelidad del snapshot `_legacy/13.11/`

`evidencia/ev-30.out` bloque 2: **128 de 128 archivos** de `_legacy/13.11/` son byte a byte idénticos al blob de
`main` en la misma ruta (`git rev-parse main:<ruta>` contra `git hash-object` del archivo local, uno por uno,
`fail=0`). `git ls-tree -r --name-only main` fuera de `_legacy/`, `CHANGELOG.md`, `.gitignore` y `vs.bat` da
también **128**: el snapshot no le falta ni le sobra nada respecto de las exclusiones de `SDD-Development-Guide.md`
§VI.5. **Confirma lo que la nota de coherencia §6 fila 10 y el `CHANGELOG.md` afirman**, con comando propio y no
heredado.

## 3. Lo que la propia intervención encontró al tocar, y qué se hizo

El `CHANGELOG.md` ya declaraba, bajo «Corregido — lo que la intervención encontró al tocar», tres hallazgos de la
propia corrida. Se verificó cada uno contra el diff:

1. **Dos registros de control de cambios en orden inverso** (`SDD-Development-Guide.md` filas 1.25–1.29,
   `SDD-User-Guide.md` filas 1.17–1.19). Verificado en el diff de ambos archivos ([sección previa de esta
   sesión](00-Verificacion-De-Citas-Y-Recuentos.md) y relectura directa): las filas se reordenaron y **su texto no
   cambió** — se comparó carácter a carácter el contenido de cada fila movida contra su versión anterior en el
   diff, y son idénticas salvo la posición.
2. **El «45» del reporte suma dos archivos como si fueran un contexto.** `evidencia/ev-30.out` bloque 4 reproduce
   el conteo: `grep -o procedencia Migracion-Rules.md | wc -l` → **23**, `grep -o procedencia
   Master-Prompt-Migracion.md | wc -l` → **22**. El texto aplicado en `Vocabulario-Rules.md` §9.2 y en el
   `CHANGELOG.md` declara el costo real (23, o 45 sólo si el sentido nuevo se escribe en los dos archivos) en vez
   del 45 heredado sin más.
3. **La fila 3.1 de `Vocabulario-Rules.md` atribuye a §9.4 una cita que vive en §9.2.** No se reescribe, por
   §VI.2 (una fila ya escrita no se corrige); se declara en la nota de coherencia §8. Verificado: la fila 3.1
   del control de cambios del archivo no fue tocada por este diff (no aparece en `git diff` de la sección de
   control de cambios salvo la fila 3.3 nueva al final).

**Estos tres son autocorrección de la propia corrida, no hallazgos nuevos de esta pieza `30`.** Se re-verifican acá
porque la solicitud 9 pide corroborar que lo aplicado se corresponde con lo declarado, y los tres estaban
correctamente declarados y correctamente aplicados.

**No se encontró ningún cambio aplicado sin declarar, ni ningún cambio declarado sin aplicar.**

## 4. Los seis criterios de §7 del reporte, verificados de nuevo con comando propio

El reporte `28`, en su §8 ya escrito, da veredicto a los seis. Se reproduce cada uno de manera independiente:

| # | Criterio | Comando | Resultado | Veredicto |
|---|---|---|---|---|
| 1 | El recuento cambia: al menos un `[enumerable]` en `Vocabulario-Rules.md` | `awk` acotado a §10 (bloque 3), sobre 13.12 y, para contraste, sobre 13.10 (`git show 476f927:...`) | 13.12: **enum=1, interp=13** (14 criterios). 13.10: **enum=0, interp=13** (13 criterios) | **CUMPLIDO** |
| 2 | Cabecera, §8 y §9.6 dejan de contradecirse | Relectura de §8 (tabla con dos filas: significado/precedencia sobre los seis, colisión sobre todo término) contra la cabecera (`Archivo target`) y §9.6 (aplica «migración») | Los tres leen el mismo alcance | **CUMPLIDO** |
| 3 | Afirmar una colisión sin comando en una verificación previa es hallazgo por vía del método | Comprobación 14 de la guía (§VI.3) + criterio `[enumerable]` de §10, aplicados a la entrada 13.11 del `CHANGELOG.md`, que descartó `procedencia` sin comando | Marca la afirmación **por vía del método**, aunque resultó cierta al reproducirla (1, 2 y 1 ocurrencias por sección, `00` §3). **No se ejerció sobre una verificación previa en vivo** dentro de esta misma corrida | **CUMPLIDO A MEDIAS**, declarado, precedente reporte `18` |
| 4 | El costo de calificar en un archivo que se lee íntegro sale sin refutador | `grep -o procedencia` sobre los dos archivos (bloque 4) | `Migracion-Rules.md`: **23**. Costo declarado en la regla sin necesidad de que un tercero lo objete | **CUMPLIDO** |
| 5 | La compuerta localiza sin decidir | Lectura de la comprobación 7 de `Master-Prompt.md` §10.0: la salida es tabla de ocurrencias por sección/archivo, sin palabra de veredicto | El texto de la comprobación no emite juicio, sólo cuenta y entrega al auditor | **CUMPLIDO sobre el texto publicado** (no se ejecutó el banco del destino, que es del destino y no del framework — decisión del reporte `12`) |
| 6 | Un término con contextos disjuntos no es hallazgo | `grep -n disjunt Vocabulario-Rules.md` (bloque 5) | §9.6 declara expresamente disjunto el sentido de «migración» entre `Migracion-Rules.md` y `Rules-Devops.md`, y §9.2 nueva impide sumarlos por viajar juntos | **CUMPLIDO** |

**Cinco cumplidos, uno a medias — coincide con el veredicto que ya llevaban el reporte `28` §8 y la nota de
coherencia §7.** No se encontró ninguna discrepancia entre lo verificado de manera independiente en esta pieza y lo
que esos dos documentos ya declaraban.

## 5. Integridad del registro en los seis archivos tocados (comprobación 10)

`evidencia/ev-30.out` bloque 6: en los seis archivos, la versión de cabecera coincide con la última fila fechada de
su propio control de cambios (`Vocabulario-Rules.md` 3.3, `Master-Prompt.md` 8.16, `Mesa-Rules.md` 1.3,
`SDD-Development-Guide.md` 1.30, `SDD-User-Guide.md` 1.21, `Catalogo-De-Criterios.md` 1.17). Sin discrepancias.

## 6. §II.7 — no se distribuyó código ejecutable

`find SDD -type f -not -name '*.md'` (bloque 7) → **vacío**. El conjunto sigue siendo únicamente `.md`.

## 7. Lo que esta pieza no pudo verificar

- **El criterio 3** no se pudo ejercer sobre una verificación previa en vivo dentro de esta misma corrida — no hubo
  una nueva afirmación de colisión que produjera esta intervención sobre un término inédito para probar la
  comprobación 14 en caliente. Queda **a medias**, como ya declaraban el reporte y la nota, con el precedente del
  `18`.
- **El banco del destino de la comprobación 7** (`Master-Prompt.md` §10.0) no se corrió en un destino real: es del
  destino, no del framework, y el reporte `12` fija que el framework no lo distribuye. Se verificó el texto de la
  comprobación, no su ejecución.
- **La localización por cadena** (`colisi`, `disjunt`, `polisem`) tiene el límite declarado de dejar escapar
  sinónimos («choca», «se pisa»); no se intentó medir cuántos casos reales se le escapan, porque el propio criterio
  declara que separar afirmación de mención es lectura y no un recuento.

## 8. Conclusión

**El plan se aplicó según lo declarado, sin cambios no declarados y sin declaraciones sin aplicar.** El snapshot es
fiel. Los seis criterios de §7 dan el mismo veredicto que ya llevaban escrito el reporte `28` y la nota de
coherencia, verificados de nuevo con comando propio en esta pieza. No se encontró necesidad de corregir ninguna
pieza de `00`, `10` o `20`.
