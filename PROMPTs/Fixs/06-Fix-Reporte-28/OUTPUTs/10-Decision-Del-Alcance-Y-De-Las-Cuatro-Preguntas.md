# 10 — La decisión de fondo y las cuatro preguntas que ordena

**Fecha:** 2026-09-12 · **Base:** `IA.SDD` `9dc8ded` (SDD 13.11) · **Evidencia:** [`00`](00-Verificacion-De-Citas-Y-Recuentos.md) y [`evidencia/ev-06.out`](evidencia/ev-06.out)

---

## 1. Solicitud 4 — el alcance de `Vocabulario-Rules.md` (§5.1)

### 1.1 Decisión

**§8 se corrige para declarar lo que la regla ejerce.** La regla gobierna **el significado y la precedencia** de los
seis términos de §2, y **el criterio de colisión de §9 sobre todo término** del framework y de la documentación que
genera, **incluido el vocabulario propio del método**.

### 1.2 Fundamento, y por qué no es una detención

**Primero el origen del hecho** (`Master-Prompt.md` §8.1, vigente desde la 13.11). El párrafo de §8 está en la base
de la corrida sin cambios: `git diff 476f927 9dc8ded -- SDD/Devs/Rules/Vocabulario-Rules.md | wc -l` → **0**, y la
fila 2.2 de su registro lo fecha el 2026-08-15. **Ajeno a la corrida, calculado.**

**Después la pregunta previa**: ¿tiene respuesta en el árbol, sostenible con cita literal? **Sí, y con cuatro citas
contra una** ([`00`](00-Verificacion-De-Citas-Y-Recuentos.md) §1.1): la cabecera, la letra de §9, R6 y §9.6 en el
mismo archivo, y `Master-Prompt.md` §10 fuera de él. No es una ambigüedad de intención: es un párrafo que dice lo
contrario que el resto de su regla y que la regla que la audita. **Es trabajo propio.**

**`Root-Rules.md` §13 no hace falta y no alcanzaría**: su criterio compara dos reglas por si viajan en el despacho,
y acá hay una sola. Lo advertía la solicitud 4; la pregunta previa lo resuelve antes de llegar ahí.

**El argumento de la mesa, verificado y no heredado.** Resolvió con §9.6 y lo llamó *«desactualizado por la práctica
posterior»*. **§9.6 es anterior al párrafo** (2.1 del 2026-07-29 contra 2.2 del 2026-08-15). El argumento de la mesa
alcanzaba —§9.6 es una de las cuatro citas— pero su cronología no; la decisión se funda en las cuatro.

### 1.3 `Master-Prompt.md` §15 y el reporte `11`

**§15 define y §9 decide la colisión.** El reparto queda limpio:

- El `11` resolvió **dónde se define** el vocabulario del método, contra nueve destinos distintos para la misma
  pregunta: en §15. **No cambia.**
- Lo que el párrafo de la 2.2 agregó de más fue negarle a §9 la colisión de esos términos. **Eso es lo que se corrige.**
- §15 **no recibe criterio de colisión**. Ya define «colisión de sentidos» y «contexto de lectura» remitiendo a §9.2
  —el reporte afirmaba que no tenía nada del criterio, y es inexacto—; se actualiza la segunda y se declara en «Glosario
  operativo» que define y no decide.

**El reporte `11` no se reabre.**

### 1.4 Y los tres términos que sumó la `04`

`Base de la corrida`, `Origen del hecho` y `Lote de la fase` son vocabulario propio del método. **Con §8 vigente en
13.11, su colisión con otro término del método no estaba gobernada por ninguna pieza**; desde la 13.12, **§15 los
define y §9 decide si chocan**. La `04` midió antes de nombrar ([`00`](00-Verificacion-De-Citas-Y-Recuentos.md) §3) y
su descarte de `procedencia` se sostiene; lo que no hizo fue adjuntar el comando, que es lo que esta intervención
vuelve obligatorio **hacia adelante**.

---

## 2. §5.2 — el criterio enumerable

**Entra, con comando reproducible obligatorio.** Redacción en `Vocabulario-Rules.md` §10:

> `[enumerable]` Toda afirmación de colisión o de no colisión de un término —en un glosario, en una decisión de
> nombre, en una resolución como la de §9.6, en un informe— adjunta en el mismo punto el comando reproducible que
> localiza sus ocurrencias por el contexto de lectura de §9.2, y su salida. Las afirmaciones se localizan por las
> cadenas `colisi`, `disjunt` y `polisem`. Decide la presencia de la medición; no decide si la colisión es real.
> Remitir con su sección a una resolución ya escrita no es una afirmación nueva. Su ausencia es hallazgo aunque la
> conclusión resulte correcta. Rige para lo escrito desde la 3.3.

**El ataque del comando falso, verificado y no heredado.** El refutador lo planteó —un `grep` sobre el archivo
equivocado cumple la letra— y el reporte dice que el criterio sobrevive porque promete reproducibilidad, no
infalibilidad. **Se verificó con casos de esta misma corrida, y los tres van en la misma dirección:**

| Caso | Qué pasó | Con el comando a la vista |
|---|---|---|
| Fila 6 del cuadro del reporte | «16 + 19» leído como ocurrencias | Es `grep -c`: se ve que cuenta líneas ([`00`](00-Verificacion-De-Citas-Y-Recuentos.md) §2) |
| `Master-Prompt-Migracion.md`, «22» | Depende de distinguir mayúsculas | `grep -o` da 22 y `grep -oi` da 24: la diferencia está en el comando |
| **Una séptima, fuera del cuadro**: el orquestador que lanza esta intervención, al entregar la `04`, afirmó cinco archivos «no declarados» en un commit **filtrando `git show --stat`**, que trunca las rutas largas con `.../` y ocultó el prefijo `_legacy/` | Afirmación sobre el estado del árbol leída de una salida recortada | Con el comando citado, cualquiera ve que es `--stat` y que trunca; `--name-only` lo desmiente en una línea |

**Ninguno de los tres fue un comando inventado**: fueron comandos reales que medían otra cosa. **El criterio no los
impide y los vuelve visibles**, que es la condición «reproducible» de D9 (`Deriva-Rules.md` §1). La prosa «revisé tal
sección» no habría dejado ver ninguno de los tres. **La cláusula de comando no es opcional.**

**Límite declarado.** La localización de «afirmaciones» es por cadena. Un sinónimo —«choca», «se pisa»— escapa, y
separar una afirmación de una mención es lectura. Es enumerable en su mitad de presencia, y se declara así.

---

## 3. §5.3 — dónde corre

**En tres lugares, uno por cada acto donde se afirma una colisión:**

| Acto | Pieza | Quién la aplica |
|---|---|---|
| Generación y migración de documentación | `Vocabulario-Rules.md` §9.4 y §10 | El auditor de fase, que ya aplica §10 (`Master-Prompt.md` §10) |
| Mesa de evaluación | `Mesa-Rules.md` §6.1 —**una afirmación de colisión sólo se ancla en E1; sin comando es `C` y no funda parche**— y §8 | El presidente y el jurado, al consolidar |
| **Intervención sobre el framework, incluida su verificación previa y lo que trae del origen** | `SDD-Development-Guide.md` §VI.3, **comprobación 14** | Quien emite la nota de coherencia |

**Cómo alcanza a la verificación previa, que es donde ocurrió el caso.** La comprobación 14 exige que la nota
contenga, con su comando, **toda afirmación de colisión de la que la intervención parte**. La del caso —«no puede
llamarse `procedencia` porque colisionaría»— fue la premisa de un nombre que la intervención publicó: con la
comprobación 14 tenía que estar en la nota con su comando, **y la nota de la 13.11 la tiene sin él**. La comprobación
la marca por vía del método ([`30`](30-Verificacion-Del-Plan-Aplicado.md), criterio 3).

**Lo que no alcanza, y se decide no alcanzar.** Escribir un reporte en `IA.SDD.Documentacion` no es intervenir, y
ninguna regla del framework puede gobernar ese repositorio sin romper la autosuficiencia (comprobación 2). **Se lo
alcanza en los dos momentos en que toca al método**: cuando lo produce una mesa (`Mesa-Rules.md`) y cuando lo usa una
intervención (comprobación 14: lo que llega del origen sin comando se reproduce antes de usarse). **Desenlace
negativo con fundamento**, en la parte que queda afuera.

---

## 4. §5.4 — el contexto de lectura por lector

**Se declara en `Vocabulario-Rules.md` §9.2, enumerado desde los insumos de cada lector** ([`00`](00-Verificacion-De-Citas-Y-Recuentos.md), bloques `S4`):

| Lector | Qué recibe | Fuente | Contexto |
|---|---|---|---|
| Subagente de generación | Intake, `Vocabulario-Rules.md` y `Root-Rules.md` por sección; regla de categoría, upstream y conocimiento por ruta | `Master-Prompt.md` §8, esqueleto (`S4.a`) | Sección / archivo |
| Orquestador de generación | Intake íntegro | `Master-Prompt.md` §2 paso 2 (`S4.c`) | Archivo |
| Auditor de fase | Entregables, upstream que citan, archivos de reglas | `Master-Prompt.md` §10, perfil (`S4.b`) | Archivo |
| Orquestador de migración | `Migracion-Rules.md` y `Mesa-Rules.md` íntegras; `Master-Prompt.md` por mecanismos; reglas de categoría por ruta | `Master-Prompt-Migracion.md` §2 (`S1.l`) | Archivo; sección en `Master-Prompt.md` |
| Especialista de mesa | Su lista, `Vocabulario-Rules.md`, contrato | `Mesa-Rules.md` §10 (`S4.d`) | Lo que nombre su lista |
| Humano | El documento | `Master-Prompt.md` §15 (`S4.f`) | Documento |

**`Master-Prompt-Reanudacion.md` no entra a la tabla**: R0 declara que no abre categorías para juzgar su contenido
(`S4.e`), y no hay insumo del que leer una unidad. Se deja fuera en vez de suponerla.

**Dos consecuencias, y la segunda corrige al reporte.**

1. **Co-ocurrencia en el contexto mayor, y costo con él.** Es lo que habría evitado el `P0` de la mesa: calificar en
   `Migracion-Rules.md`, que el orquestador de migración lee íntegra, cuesta el archivo.
2. **La suma de lo que un lector recibe no es un contexto.** El refutador sumó `Migracion-Rules.md` y
   `Master-Prompt-Migracion.md` —*«que la misma corrida lee junto con ella»*— y llegó a 45. **El árbol ya había
   contestado lo contrario**: el orquestador de migración recibe íntegras `Migracion-Rules.md` **y** la regla de cada
   categoría migrada (`S1.l`, línea 72), y §9.6 declaró **disjuntos** «migración» de la primera y de `Rules-Devops.md`
   (`S4.g`). Sumar por viajar juntos convertiría ese descarte en colisión: **es la sobrecorrección que el criterio 6
   del reporte protege**. **El costo es 23 por `Migracion-Rules.md`, y 45 sólo si el sentido nuevo se escribe
   también en `Master-Prompt-Migracion.md`.**

---

## 5. §5.5 — la mitad mecánica en la compuerta

**Volumen medido antes de decidir** (`S5`, sobre `SDD/` de 13.11: 95 archivos, 30 431 líneas):

| Qué se localiza | Ocurrencias | Archivos | Tiempo |
|---|---|---|---|
| `base de la corrida` (acuñado en 13.11) | 22 | 6 | 15 ms |
| `origen del hecho` (acuñado en 13.11) | 52 | 6 | 17 ms |
| `lote de la fase` (acuñado en 13.11) | 8 | 4 | 16 ms |
| `procedencia` (término vivo) | 116 | 15 | 15 ms |
| `estado`, palabra entera, prosa libre | **711** | **90** | — |
| `registro`, palabra entera, prosa libre | **290** | **70** | — |

**Decisión: entra, como comprobación 7 de `Master-Prompt.md` §10.0**, con cuatro condiciones que son las de
viabilidad:

1. **Sólo términos declarados** —agregados por la fase a un glosario de categoría o a §15, o de un registro de
   sustitución de §9.5—, **calculados contra la base de la corrida**. Nunca prosa libre: `estado` apaga el instrumento.
2. **Por sección y por archivo**, para que el auditor aplique el contexto de cada lector.
3. **Insumo, nunca veredicto**: es la única comprobación de §10.0 que no emite hallazgo.
4. **El comando se publica en el texto**, como el barrido de §VI.3.2, y no como código distribuido (§II.7).

**¿Se parece a un registro de términos?** Se evaluó, porque la solicitud 3 lo pide: **no**. No persiste, no guarda
el resultado de ninguna decisión y no se consulta en lugar de medir; recalcula en cada corrida desde fuentes que ya
existen.

---

## 6. §5.6 — no se decide acá

Queda para la `05`. Lo que cambia para ella está en [`30`](30-Verificacion-Del-Plan-Aplicado.md) §5.
