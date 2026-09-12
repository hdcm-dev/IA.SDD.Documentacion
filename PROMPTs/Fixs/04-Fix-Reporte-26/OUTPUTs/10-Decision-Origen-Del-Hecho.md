# 10 — La decisión de fondo: el origen del hecho se deriva, y no del archivo que el reporte proponía

**Fecha:** 2026-09-12
**Insumos:** [`00-Verificacion-De-Citas-Y-Ausencias.md`](00-Verificacion-De-Citas-Y-Ausencias.md), y la evidencia [`evidencia/ev-decision.sh`](evidencia/ev-decision.sh) con su salida [`evidencia/ev-decision.out`](evidencia/ev-decision.out). Los bloques `S3.x` y `S4` citados abajo son de esa salida.

---

## 1. Solicitud 4 — ¿se deriva o se declara?

**Se deriva.** Y se decide primero porque ordena las otras cuatro, como pide el prompt.

**Tres fundamentos:**

1. **Declarado, el dato es el juicio del agente sobre su propio trabajo**, que es exactamente el límite que
   `Coherencia-La-Pregunta-Previa.md` §9 dejó anotado para la pregunta previa: *«sigue siendo un juicio del
   agente sobre su propio trabajo»*. Un agente que no se dio cuenta de que generó el problema declara
   «preexistente» de buena fe, y **el criterio 3 del reporte deja de poder distinguir** una corrección real
   de una cosmética: las dos producen una cuenta en cero.
2. **Declarado, sería el estrato que el reporte `13` propuso y la 9.19 rechazó**, con otro nombre: una
   clasificación por juicio de de quién es el hecho. **Calculado, es otra cosa** (§6).
3. **Hay un observable que lo resuelve sin preguntarle a nadie**, y no es el que el reporte proponía (§3 y §4).

---

## 2. El reporte proponía derivarlo del snapshot de §8

*«El estado previo se archiva antes de despachar cada unidad, y §8 ya compara el entregable contra ese
snapshot […]. Entonces el origen del hecho se calcula con la comparación que ya se hace»* (reporte §5.3).

**El prompt pide verificar que ese archivo contenga lo necesario, y no suponerlo.** No lo contiene.

---

## 3. Lo que el snapshot de §8 tiene, y lo que le falta

| Propiedad que el cálculo necesita | Lo que el snapshot de §8 tiene | Evidencia |
|---|---|---|
| **Momento: antes de la corrida** | Se toma **al construir cada despacho**. Contiene lo que dejaron las unidades anteriores **de la misma corrida** | `Master-Prompt.md` líneas 810 y 843 (`00` §1.1) |
| **Alcance: el árbol** | El **entregable** de ese despacho. El hecho que motiva una detención puede estar en otro documento —una inconsistencia entre dos unidades— | Línea 810: *«el estado previo del entregable»* |
| **Tramo: todos** | **No rige en las Fases I y J** | Línea 745: *«La regla de §8 que obliga al orquestador a archivar el estado previo antes de despachar **no rige acá**»* |
| **Permanencia** | Ruta por **fecha** y sufijo por **versión** (línea 460); las correcciones de audit **se absorben sin subir versión** (línea 459); el despacho de corrección **es siempre `EXISTENTE`** (línea 842). **Inferencia de texto, no medida sobre un destino:** dos rondas de corrección del mismo documento el mismo día producen el mismo nombre de archivado | Líneas 459, 460 y 842 |

**La primera fila es la decisiva, y no es un matiz.** Comparado contra el snapshot, el estado que otra unidad
de la corrida dejó a medias **se lee como previo**. Es el valor equivocado que §5.3 quería evitar, y el que
lo produce **ya no es el agente distraído sino el instrumento**. La trampa de §5.3 no se evita cambiando de
declarado a calculado: **se evita calculando contra el ancla correcta**.

**Qué le falta, en una línea:** un ancla tomada **una vez**, **al abrir la corrida**, **sobre el árbol
entero**, que **no se sobrescriba**.

---

## 4. El ancla que sí existe: la base de la corrida

**Las cuatro propiedades ya las garantiza el método, en §12.1**, y nadie las usa para esto:

| Propiedad | Quién la garantiza | Evidencia |
|---|---|---|
| Momento | **T0** corre *«antes de la primera escritura de cualquier unidad de trabajo»* y **publica su salida siempre** | `S3.b`: línea 1469 |
| Todo commiteado | **T2**: *«Antes de la primera escritura, el árbol de trabajo tiene que estar limpio»* | `S3.b`: línea 1513 |
| Árbol entero y permanente | Un commit. El historial no lo sobrescribe | — |
| Todos los tramos | §12.1 *«la leen los tres»* orquestadores, y rige también en las Fases I y J | Cabecera de §12.1 |

**Lo que falta es exactamente lo que el reporte decía del snapshot, aplicado a otra pieza: el dato se toma y
ninguna regla lo exige ni lo lee.** El formato de T0 **no lleva el commit** (`00`, formato 7). Y el destino
que originó el reporte **lo escribió igual, por su cuenta**: *«**Revisión leída:** `5c95dab` de `main`, árbol
de trabajo limpio»* (`S4`, `Estado-Del-Destino-2026-09-12.md` línea 8).

**Y el concepto ya estaba en el árbol, sin instrumento.** `Mesa-Rules.md` §0.2 define lo que mira la mesa como
*«el corpus que ya existía **antes de la corrida**»* (línea 77). La base es lo que vuelve contestable ese
«antes».

---

## 5. La definición adoptada

**Base de la corrida.** El commit sobre el que la **primera** T0 de una invocación devolvió EN ORDEN. T0 la
publica en una línea nueva, **T5 la vuelve a publicar sin cambiarla** —T5 ya republica con el formato de T0,
`S3.c`, línea 1568—, la continuación de R4 la hereda, y una invocación nueva abre una corrida nueva.

**Origen del hecho**, con dos valores:

| Valor | Cuándo |
|---|---|
| **De la corrida** | Las líneas que sostienen el hecho **no están en la base**, o están y **un commit de las ramas de esta corrida** las cambió. Para un hecho que es una ausencia, se mira el documento donde falta |
| **Ajeno a la corrida** | Están en la base **sin cambios**, o las cambió **un commit que no es de esta corrida** —el trabajo de otra persona que T5 paso 3 ya obliga a detectar— |

**Por qué «ajeno» y no «preexistente».** Un commit del humano fusionado **durante** la corrida no es previo a
ella y tampoco es de ella. «Preexistente» lo clasificaría mal; «ajeno» no.

**Ante la duda, de la corrida.** Si no se puede calcular —el hecho no vive en ningún repositorio, la base no se
publicó, el historial se reescribió— se trata como de la corrida y **se dice por qué no se calculó**. Es la
misma asimetría de costos con que §8.1 decide detener, aplicada a la otra punta: tratar como ajeno lo que
produjo la corrida devuelve al humano un problema que no era suyo. **Con dos guardas**: lo calculado como ajeno
no se reescribe «corrigiendo», y la contraparte de la autocorrección —si corregir cambia una decisión que el
humano ya tomó, se detiene— sigue intacta.

**Quién lo calcula.** El **orquestador**, que tiene la base y los despachos; en la mesa, el presidente. **Nunca
el subagente que tropezó**: su bloque de §9 suma el campo con la leyenda de que no lo completa él.

**Cómo queda escrito en la detención:**

```text
  ORIGEN DEL HECHO
    Valor:      {{de la corrida | ajeno a la corrida}}
    Cómo:       {{calculado contra la base {{commit}}: {{qué se contrastó}} | no calculable: {{motivo}}}}
    Por qué la autocorrección no alcanzaba: {{obligatorio si el valor es «de la corrida»}}
```

**El renglón `Cómo` es lo que vuelve auditable el criterio 3.** Distingue lo calculado de lo tratado como de la
corrida por duda: una corrida con muchas detenciones «de la corrida» **todas por duda** muestra que la base no
se está usando, que es el mismo síntoma que el cero, desde el otro lado.

### 5.1 El nombre

| Candidato | Medición | Decisión |
|---|---|---|
| `procedencia` | **Colisiona en las secciones que se tocan**: `Master-Prompt.md` §7.0 (línea 631, la procedencia declarada del destino), `Master-Prompt-Reanudacion.md` §3 (líneas 170 y 172) y §6 (línea 507). `Vocabulario-Rules.md` §9.1 obligaría a desambiguar ahí | **Descartado.** El reporte verificó §8, §8.1 y §9 y **tenía razón para esas tres**; la corrección no vive sólo ahí |
| `origen` a secas | Aparece con otro referente en §7.0 (líneas 624 y 631) y en §8.1 (línea 929, *«verificables contra su origen»*) | **Descartado** como forma suelta |
| **`origen del hecho`** | **0** ocurrencias en el árbol vivo | **Adoptado**, y **se escribe siempre completo**. El glosario de §15 lo declara |
| **`base de la corrida`** | **0** ocurrencias | **Adoptado** |
| **`ajeno a la corrida`** · **`lote de la fase`** | **0** y **0** | **Adoptados** |

Mediciones: `S3.d`.

---

## 6. Solicitud 3 — lo que el reporte declara que no afirma, respetado

**No reabre el `13`.** Se compara contra lo que la 9.19 rechazó, porque el prompt pide que el parecido, si
aparece, sea el hallazgo:

| | El estrato del reporte `13` | El origen del hecho |
|---|---|---|
| **Qué es** | Una **clasificación por juicio**: de quién es el hallazgo | **Un dato calculado** contra un commit |
| **Cómo se relaciona con la pregunta previa** | Eje **paralelo**, que la volvía innecesaria o la duplicaba | Cláusula **anterior**: decide **qué prueba corre primero**. Lo ajeno sigue yendo a la pregunta previa, sin cambios |
| **Por qué se rechazó / por qué hace falta** | *«La exigencia de cita contesta la pregunta sola»* | **La cita no alcanza acá**: un estado a medias de la corrida **no tiene cita posible**, porque nadie escribió la respuesta |

**Declarado por el agente, sería aquel estrato.** La derivación no es una mejora opcional del diseño: **es lo que
lo separa del `13`**.

**No propone un rol nuevo.** Lo calcula el orquestador, que ya publica T0 y ya exhibe el registro al cerrar cada
fase; en la mesa, el presidente, que ya consolida las escaladas. **No afirma que las dos mediciones estén mal**
y **no supone mala fe**: el diseño entero parte del agente que no se dio cuenta.

---

## 7. Solicitud 5 — las otras cuatro preguntas, una por una

### §5.1 La cláusula anterior — **SÍ, en `Master-Prompt.md` §8.1**

**Dónde.** Dentro de §8.1, inmediatamente **antes** de la pregunta previa. **No en una regla aparte**, por tres
motivos del árbol: §8.1 *«gobierna las cuatro familias de detención del método, y la leen los tres
orquestadores»*; `Root-Rules.md` §13 declara que *«§8.1 corre antes que esta sección»*, de modo que el orden
queda intacto si la cláusula vive adentro; y una regla aparte necesitaría su propio cableado en los insumos de
§8.

**Qué hace cuando la respuesta es «de la corrida».** **No se evalúa contra el árbol.** Se evalúa contra la
autocorrección **sobre el conjunto** (§5.2), y **sólo se eleva** si corregir **cambia una decisión que el humano
ya tomó**, si es un **arbitraje** de §7.0, o si cerrarlo exige **intención de producto que ninguna fuente
contiene**. En los tres casos sale **declarando por qué la autocorrección no alcanzaba** (§5.5).

### §5.2 La tercera fila — **SÍ**

| Qué se detecta | Quién lo resuelve |
|---|---|
| **Un estado a medias que produjo esta corrida** —un documento empezado y no cerrado, una decisión tomada y no asentada, una inconsistencia introducida en una unidad anterior— | **El agente, sobre el conjunto de lo que la corrida produjo.** Reconstruye desde la base qué se tocó y en qué unidades, cierra lo que falta en todas, y lo declara en el cierre **con su alcance ampliado** |

**La diferencia con la primera fila es de alcance, no de dueño**: la primera se corrige en la misma unidad; ésta,
en todas las que la corrida tocó.

### §5.3 El origen del hecho — **derivado** (§1 a §5 de este documento)

### §5.4 El agrupamiento antes de la primera salida — **SÍ, con dos acotaciones**

**Se generaliza `Mesa-Rules.md` §7.1 al bucle de fases**, en `Master-Prompt.md` §7.0: lo que no bloquea espera al
lote, el lote se mira entero antes de salir —con el origen del hecho calculado sobre todas—, y cada detención
lleva `SI NO RESPONDÉS`.

**Qué es «lo bloqueante» en el bucle de fases**, que es lo que el reporte pedía decidir: **dos casos y sólo dos**.
El **arbitraje de §7.0** —extender o contradecir un conjunto cerrado aprobado, análogo a los disparadores 2 y 3
de la mesa—, y **la detención sin cuya respuesta ninguna otra unidad de la fase puede avanzar**.

**Cuándo sale el lote:** al cerrar la fase, o cuando la fase ya no puede avanzar sin respuesta, lo que ocurra
primero.

**Acotación 1 — el registro no agrupa toda detención.** El reporte pregunta si el **registro** debe agrupar toda
detención de la fase. **No**: el lote es **la forma de presentar**, y el registro conserva su identidad —lo que
queda abierto—. Lo contestado en el lote no entra; lo no contestado entra con su `SI NO RESPONDÉS` como «qué
rige mientras tanto», **que es un campo que la fila ya tiene** (línea 620). **La fila no suma columna de origen**:
se recalcula contra la base cuando hace falta, y copiarlo sería mantener dos declaraciones en paralelo. Sumarla
además convertiría la intervención en major sin necesidad: un registro ya emitido dejaría de cumplir.

**Acotación 2 — el campo `SI NO RESPONDÉS` no hay que inventarlo fuera de la mesa.** §9 ya lo tiene como *«Qué
pasa si no se responde ahora»* (línea 1027), contra lo que el reporte §2.5 afirma. **Lo que falta es en el
bloque general de §8.1**, y ahí entra, obligatorio cuando la detención sale en el lote.

### §5.5 El criterio enumerable — **SÍ**

*«Ninguna detención con origen del hecho «de la corrida» sale sin declarar por qué la autocorrección no
alcanzaba.»* Entra marcado `[enumerable]` en `Mesa-Rules.md` §8 y en `Master-Prompt-Reanudacion.md` §6, junto al
criterio de la lista cerrada que el reporte citaba, y como obligación de cierre en `Master-Prompt.md` §8.1.

---

## 8. Solicitud 6 — el efecto sobre la mesa

**No se agrega ningún punto de invocación.** El lote lo arma el orquestador **en el corte de fase que §7.0 ya
declara** (*«El orquestador lo exhibe al cerrar cada fase»*, línea 626). La mesa no se convoca por el lote, y
`Mesa-Rules.md` §0.0 —la condición y no la lista— **queda intacto**. **No hay contradicción que resolver por
`Root-Rules.md` §13.**

**Lo que sí cambia en la mesa:** §7 suma la cláusula de origen **antes** de la lista cerrada. El caso para el
que importa ya ocurrió: la corrida del 2026-09-12 corrió **cuatro ciclos el mismo día** sobre el mismo destino, y
cada ciclo miró un corpus que incluía lo que los anteriores habían producido. Su ciclo 2 clasificó un hallazgo
como *«un error de esta corrida, no normativo»* (`RE-REF-05`, `S4`) **por lectura del refutador**. La base
convierte esa lectura en un cálculo.

**Observación que se declara y no se resuelve.** `Mesa-Rules.md` §0.3 limita la mesa a *«lo que ya existía al
abrir la corrida, nunca lo que la fase acaba de producir»*, y una mesa de varios ciclos en una misma corrida mira,
en el ciclo `N`, parches aplicados en los ciclos anteriores. **La base vuelve ese límite calculable**; si la mesa
debe mirar esos parches o no **no es la pregunta de este reporte**, y no se toca.

---

## 9. Severidad: minor

**La pregunta de `SDD-Development-Guide.md` §VI.1** —¿un documento generado con la versión anterior sigue
cumpliendo la nueva?— **da que sí**:

- Ninguna fila del registro de decisiones pendientes cambia (§7, acotación 1).
- El formato de escalada de mesa suma un campo, y un registro de mesa ya emitido **es un registro fechado que
  sigue conforme**: es exactamente lo que `Mesa-Rules.md` 1.1 declaró al sumar el prefijo de familia a §2.2
  (*«un registro de mesa emitido bajo la 1.0 sigue cumpliendo»*).
- `Master-Prompt.md` §16: *«Cambio en el plan de §6, en la mecánica de §8 o en el flujo de §7: sube minor»*.
- No se toca ninguna invariante D1–D9 ni ninguna plantilla de intake.

**El contraargumento, escrito:** una detención nueva sin su campo `ORIGEN DEL HECHO` no cumple. **Es cierto y es
hacia adelante**, que es lo que el minor declara; lo que el major exigiría es que lo **ya emitido** dejara de
cumplir, y no deja.

---

## 10. Solicitud 13 — impacto sobre destinos existentes, que no es «ninguno»

**`Lab-Geometria`**, que el prompt nombra. Sólo lectura; nada se modificó ahí.

| Qué | Estado verificado | Qué le exige la 13.11 |
|---|---|---|
| Registro `Mesa-2026-09-12.md` | Vive en la rama **`archivo/reanudacion-6-2026-09-12`** (commit `1fe47af`), **no en `main`** (`S4`) | **Nada retroactivo.** Es un registro fechado |
| Escaladas `E-01` y `E-03` | **Respondidas** por el testimonio del ciclo 2 (línea 460) | Nada |
| Escalada `E-02` · la API alcanzable | **Abierta en parte** | Cuando se vuelva a presentar, lleva `ORIGEN DEL HECHO`. **El hecho es estado de un despliegue y no vive en el repositorio**: no calculable, **se trata como de la corrida**, y tiene que declarar por qué la autocorrección no alcanzaba. Lo tiene: **disparador 5, consecuencia externa**, que es decisión del Product Owner |
| Escalada `E-04` · el evento de etiquetado | **Abierta** | Su hecho está en `09-Devops/Estrategia-Versionado.md` de las dos unidades, que **existen en la base `5c95dab`**, y la corrida no escribió nada en `main` después de ella (`git log 5c95dab..main` = **0**). **Ajena a la corrida**: va a la pregunta previa, como hoy |
| Escalada `E-05` · el estado durable del front | **Abierta** | Su hecho está en `DESPLIEGUE.md`, que **no está en el árbol de `Lab-Geometria` en `5c95dab`** (`ls-tree` = **0**). No calculable desde este repositorio, **de la corrida por duda**, con su porqué: **disparador 4, irreversibilidad** |
| Salidas de T0 ya publicadas | Sin línea `Base`; la del 2026-09-12 escribió la revisión aparte | Nada retroactivo. **La base de esa corrida está escrita** (`5c95dab`) y alcanza para calcular |
| Registro de decisiones pendientes | `find` no encuentra `Decisiones-Pendientes.md` fuera de `_legacy/` (`S4` = **0**) | Nada. **No se investigó** si el destino lo lleva con otro nombre: no es objeto de este reporte |

**Los tres cálculos de arriba son ilustración, no trabajo del destino**: el destino los hace al volver a presentar
esas escaladas, con la versión que declare.

**Otros destinos** —`RPI.VideoControl` y los demás del workspace— **no se inventariaron**. Se declara en lugar de
decir «ninguno».

---

## 11. Solicitud 11 — la medición pendiente

**La tercera causa no está medida, y esta intervención no la mide.** Se buscó un caso real de esta clase en el
único registro que la describe, y el único candidato **no reproduce el caso**: `RE-GP-02` / `RE-REF-05` del
ciclo 2 del 2026-09-12 es un **hallazgo de mesa** clasificado como de la corrida **por lectura**, y se resolvió
con un parche (`P-15`) **sin llegar al humano como detención**. El Product Owner describe **detenciones que le
llegan**; ése no llegó.

**El criterio 1 de §7 queda cumplido a medias**, con el precedente del reporte `18`: el mecanismo está escrito y el
caso real que lo pondría a prueba no existe todavía.

---

## Control de cambios

| Versión | Fecha | Cambios | Autor |
|---|---|---|---|
| 1.0 | 2026-09-12 | Emisión. Decide que el origen del hecho **se deriva**, y verifica que **el snapshot de §8 que el reporte proponía no contiene lo necesario**: se toma por despacho y ya incluye lo que dejaron las unidades anteriores, de modo que contra él un estado a medias de la corrida se lee como previo. Adopta **la base de la corrida** —el commit sobre el que T0 devolvió EN ORDEN, que el método ya garantiza y no registra— y decide las cuatro preguntas restantes, el efecto sobre la mesa, la severidad y el impacto sobre `Lab-Geometria`. | Intervención `04` |
