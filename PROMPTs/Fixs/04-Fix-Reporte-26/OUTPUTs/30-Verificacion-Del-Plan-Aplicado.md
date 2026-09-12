# 30 — Verificación del plan aplicado, criterio por criterio

**Fecha:** 2026-09-12
**Commit verificado:** `IA.SDD` **`eb5c794`** en la rama `intervencion/04-reporte-26`, sobre la base `476f927`
**Evidencia:** [`evidencia/verif.sh`](evidencia/verif.sh) → [`verif.out`](evidencia/verif.out) (bloques `V0` a `V10`), y [`evidencia/criterio2.sh`](evidencia/criterio2.sh) → [`criterio2-arbol.out`](evidencia/criterio2-arbol.out), contra el árbol antes del commit, y [`criterio2-commit.out`](evidencia/criterio2-commit.out), contra `HEAD`. Las mediciones de colisión que cita `10` están en [`col.out`](evidencia/col.out) y [`col2.out`](evidencia/col2.out)

---

## 1. Solicitud 9 — lo aplicado contra lo propuesto

| # del plan | Propuesto | Aplicado | Evidencia |
|---|---|---|---|
| 0 | `_legacy/13.10/` antes de editar | **Sí.** 127 archivos, los mismos que `476f927` fuera de las exclusiones, **0 diferencias byte a byte** | `V10` |
| 1a–1i | `Master-Prompt.md` 8.14 → 8.15 | **Sí**, las nueve partes | `V0`, `V1`, `V3`, `V7`, `V8` |
| 2 | `Mesa-Rules.md` 1.1 → 1.2 | **Sí** | `V1`, `V4` |
| 3 | `Master-Prompt-Reanudacion.md` 1.11 → 1.12 | **Sí** | `V1`, `V3` |
| 4 | `Master-Prompt-Migracion.md` 2.9 → 2.10 | **Sí** | `V1`, `V3` |
| 5 | `Catalogo-De-Criterios.md` 1.15 → 1.16 | **Sí**: §3 pasa de 44 a 46 filas y el total de 222 no cambia | `V9` |
| 6 | `CHANGELOG.md` `[13.11]` | **Sí** | `V0` |
| 7 | Nota de coherencia | **Sí**, `Coherencia-Origen-Del-Hecho.md` 1.0 | commit `eb5c794` |
| §4 | Reporte `26`, `Reportes/README.md`, `PROMPTs/Fixs/README.md` | **Sí** | este commit |

### 1.1 Lo aplicado que el plan no declaraba — hallazgos de la propia intervención

**Tres, y se declaran como pide la solicitud 9:**

1. **`origen` suelto en el texto nuevo del framework.** La primera redacción usó nueve veces `origen` sin «del hecho»,
   en las mismas secciones —§7.0 y §8.1— donde el término ya tenía otro referente, **y en el mismo cambio que declaraba
   en §15 que se escribe siempre completo**. Lo levantó la regla 4 del barrido corrida sobre el texto propio, antes de
   verificar, y se corrigió. **La intervención cometió el defecto que su glosario prohíbe**; queda en la nota de
   coherencia §4.
2. **La nota de coherencia afirmaba recuentos del barrido que su propia existencia cambiaba** («3 líneas», «0»). La
   nota entra en el árbol que el barrido recorre. Se corrigió antes del commit a **4** y **1**, con el motivo.
3. **`Reportes/README.md` tenía dos recuentos en prosa ya viejos** —«los cuatro últimos» encabezaba una tabla de cinco
   filas, y «los cinco llevan» pasaba a seis con la fila del `26`— y **se reescribieron sin contar**. El plan §4 decía
   «cabecera, fila de desenlace del `26` y control de cambios», y esto no estaba. Queda declarado en la fila 1.26 del
   índice.

**Ningún cambio aplicado cae fuera de los archivos del plan.**

---

## 2. Verificación de la lista de `SDD-Development-Guide.md` §VI.3

| # | Resultado | Evidencia |
|---|---|---|
| 1 · Invariantes | Sin violaciones | Lectura; nota §5 |
| 2 · Autosuficiencia | **0** citas afuera en el texto agregado a `SDD/` | `V6` |
| 3 · Referencias | Las nuevas resuelven | `V7` |
| 4 · Contradicción con lo que estaba | **Una, encontrada y corregida**: «Qué no cambia» de §8.1 negaba que la sección quite detenciones, falso desde la 9.19 | `V8` |
| 5 · Fila por archivo | Cinco | `V1` |
| 7 · Alcance | Seis archivos modificados más la nota y el snapshot | `V0` |
| 8 · Barrido | Formas anteriores: **1** cada una, la tabla de patrones de la nota (clase estable de §VI.3.2). Cláusula del snapshot: **4** líneas, **las 4** con `origen del hecho` | `V3` |
| 9 · Coherencia interna | Tres filas en la autocorrección y «tres» en el texto; «ante la duda, se detiene» acotado a lo ajeno | `V8` |
| 10 · Integridad del registro | **Cinco de cinco**: cabecera igual a la mayor fila, en orden, sin repetidas, con salto final. **4 filas fechadas quitadas y las 4 reaparecen idénticas**, más 5 nuevas | `V1`, `V2` |
| 11 · Nota | `Coherencia-Origen-Del-Hecho.md`, conjunto 13.11 | commit |
| 12 · Catálogo | 44 → 46 situaciones; total de anti-patrones 222 intacto | `V9` |
| 13 · Devolución al origen | §3 de este documento | — |

**Regla 4, sobre el texto propio:** dos coincidencias de `origen` suelto en las líneas agregadas, y las dos son
legítimas —la mención entre comillas del glosario y un salto de línea que parte «origen del / hecho»—; **0** de
`procedencia` (`V5`).

---

## 3. Solicitud 10 — los cinco criterios de §7 del reporte, uno por uno

| # | Criterio | Veredicto | Con qué |
|---|---|---|---|
| **1** | Reproducir el caso en una corrida real | **A MEDIAS** | El mecanismo está en `Master-Prompt.md` §8.1. **No hay caso real**: el único candidato es un hallazgo de mesa clasificado por lectura y resuelto sin llegar como detención (`10` §11). Precedente: criterio 4 del reporte `18` |
| **2** | La procedencia se reproduce contrastando contra el estado previo, sin leer lo que el agente declaró | **CUMPLIDO, contra la base de la corrida** | `criterio2-commit.out`: **H1** no está en `476f927` y lo agregó la corrida → de la corrida; **H2** está en la base y el diff no lo toca → ajeno; **H3** estaba en la base y la corrida la reescribió → de la corrida. **Caso real `E-04`**: sus dos documentos existen en `5c95dab` y el diff hasta el archivo de la corrida es vacío → ajena. **`E-05`**: `DESPLIEGUE.md` no está en el árbol en la base → no calculable. **En ninguna fuente había un campo de origen que leer** |
| **3** | Contar; **si da cero, la corrección no funciona** | **SIN VEREDICTO** | Requiere una corrida con la corrección aplicada. **No hay cuenta, y por lo tanto no hay cero que celebrar.** Queda escrita la forma de contar y la advertencia contra el cero y contra el «todo por duda» (§8.1, «Qué obliga en el cierre») |
| **4** | El lote de la fase contiene todas sus detenciones y ninguna salió antes | **SIN VEREDICTO** | Mismo motivo. La regla que lo vuelve contable está en `Master-Prompt.md` §7.0: lo bloqueante son dos casos |
| **5** | Ninguna detención con procedencia propia sin su porqué | **CUMPLIDO** | `[enumerable]` en `Mesa-Rules.md` §8 y `Master-Prompt-Reanudacion.md` §6 (`V4`), y obligación de cierre en §8.1 |

### 3.1 Una aplicación que no cuenta como medición, y se dice

**La propia intervención corrió su regla.** Sus tres hallazgos de §1.1 más los dos defectos preexistentes que encontró
se clasifican así, contra la base `476f927`:

| Hecho | Origen del hecho | Qué se hizo |
|---|---|---|
| «Qué no cambia» niega que se quiten detenciones | **Ajeno**: está en la base sin cambios | Pregunta previa: tenía cita (la pregunta previa de la 9.19). Trabajo propio |
| Dos registros desordenados | **Ajeno** | Pregunta previa: cita en la comprobación 10. Trabajo propio |
| `origen` suelto en el texto nuevo | **De la corrida**: no estaba en la base | Autocorrección **sobre el conjunto**: se barrieron los cinco archivos, no la línea donde se vio |
| Recuentos de la nota | **De la corrida** | Autocorrección |
| Recuentos viejos de `Reportes/README.md` | **Ajeno** a esta corrida, en otro repositorio | Pregunta previa: tenía cita (el reporte `04`). Trabajo propio |

**Cero detenciones y dos hechos de la corrida resueltos por la tercera fila.** **No es la medición del criterio 3**: es
la corrida de quien escribió la regla, sobre el framework y no sobre un destino, y el propio criterio existe porque
ese autor es el menos confiable para contar.

---

## 4. Solicitud 11 — la medición pendiente

**La tercera causa sigue sin medir.** El criterio 1 queda **a medias** y los criterios 3 y 4 **sin veredicto**. La
nota de coherencia §8 deja escritas las dos lecturas que la primera corrida real tiene que mirar: todo por duda —la
base no se publica— y todo ajeno mientras el humano sigue recibiendo problemas de la corrida —se calcula contra otra
cosa—.

---

## 5. Detenciones

**Ninguna pendiente.** Las situaciones que la solicitud 14 y `Master-Prompt.md` §8.1 podrían haber mandado detener
tenían respuesta en el árbol, y se verificó antes de decidir:

| Situación | Respuesta en el árbol |
|---|---|
| Qué nombre lleva el campo | `Vocabulario-Rules.md` §9.1 con la medición de colisión (`10` §5.1) |
| Si la severidad es minor o major | `SDD-Development-Guide.md` §VI.1, `Master-Prompt.md` §16 y el precedente de `Mesa-Rules.md` 1.1 (`10` §9) |
| Si el reordenamiento de los registros reescribe historia | §VI.2 prohíbe reescribir **filas**, no moverlas; comprobación 10 exige el orden; corrida contra la base (`V2`) |
| Si el lote contradice la condición de convocatoria de la mesa | No agrega punto de invocación: el corte de §7.0 ya existía (`10` §8). **No hubo conflicto para `Root-Rules.md` §13** |
| Si se podía cerrar el reporte con criterios sin veredicto | Comprobación 13 exige veredicto por criterio, no cumplimiento; precedente del reporte `18` |

---

## 6. Lo que no se pudo verificar

- **Ninguna corrida real con la corrección aplicada**: criterios 1, 3 y 4.
- **Que dos rondas de corrección del mismo documento el mismo día sobrescriban su snapshot**: es una inferencia de
  `Master-Prompt.md` §5 y §8, no medida sobre un destino. No sostiene la decisión: la primera fila de `10` §3 alcanza sola.
- **Otros destinos del workspace**: no se inventariaron.
- **Dónde vive `DESPLIEGUE.md` de `Lab-Geometria`**, y si el destino lleva su registro de decisiones con otro nombre.
- **El comportamiento de la línea `Base` en una corrida sin remoto**: T0 contrasta contra el remoto y el framework no
  declara el caso; la base es un commit local y no depende del remoto, pero no se corrió.
- **La intervención `05`**: su prompt y el párrafo del orden en `PROMPTs/Fixs/README.md` nombran la pieza como
  «procedencia derivada del estado previo». `PROMPTs/` es de sólo lectura salvo la fila `04`, y **no se tocó**: queda
  para quien la aplique.

## Control de cambios

| Versión | Fecha | Cambios | Autor |
|---|---|---|---|
| 1.0 | 2026-09-12 | Emisión: lo aplicado contra lo propuesto con tres hallazgos de la propia intervención, las trece comprobaciones de §VI.3, los cinco criterios del reporte `26` —dos cumplidos, uno a medias, dos sin veredicto—, la ausencia de detenciones con su respuesta en el árbol, y lo que no se pudo verificar. | Intervención `04` |
