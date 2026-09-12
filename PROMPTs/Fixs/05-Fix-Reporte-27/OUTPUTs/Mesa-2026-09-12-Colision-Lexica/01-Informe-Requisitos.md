# Expediente 01 — Requisitos y alcance

> **Transcripción verbatim.** Entregado el 2026-09-12. No editado.
> Mandato: delimitar **qué** hay que resolver (no cómo), el alcance del hueco, lo que queda fuera, y si
> corresponde reporte nuevo o arista de uno abierto.

---

# Informe del agente de Requisitos — Mesa sobre el caso "procedencia / renombre sin verificar colisión"

## 0. Corrección a la evidencia que se me entregó (verificada, no heredada)

Antes de entrar al análisis: dos de los datos que traía la evidencia "ya levantada" no resisten la verificación directa. Los marco porque el propio caso es sobre *afirmar sin verificar*, así que este informe no puede cometer el mismo defecto.

- **§10 de `Vocabulario-Rules.md` no tiene once criterios: tiene trece.** Conteo directo (`grep -n "^\- \[ \]"`): 7 en el primer bloque (líneas 294-300) + 6 en el bloque de desambiguación léxica (líneas 304-309) = 13. Los trece están marcados `[interpretativo]`; cero `[enumerable]` en la sección. Esa parte de la evidencia sí se sostiene: **el hueco de mecanización es real**, solo que el numerador estaba mal. Ancla **E1** (conteo reproducible).
- **`Master-Prompt.md` no tiene 14 ocurrencias de `procedencia`, tiene 13** en el cuerpo vivo (excluyendo las 3 del control de cambios, que no son contexto de lectura de un despacho). Sí se sostiene la conclusión que importa: las secciones donde aparecen son §0, §2.1 (la mayoría), §3, §5/§5.1 y §7 — **ninguna en §8, §8.1, §9 ni §10**, que es donde el reporte `26` propone su campo. Ancla **E1**.
- **La cita "`Migracion-Rules.md` §4.7 colisiona con ocho usos desnudos en la misma checklist" es falsa.** Verificado literal: §4.7 ("La revisión de apartamientos", líneas 568-603) tiene **cero** ocurrencias de `procedencia` — trata la absorción/contradicción/supervivencia de apartamientos frente a un salto de versión, tema distinto. Lo confirma además `Catalogo-De-Criterios.md` línea 51, que indexa §4.7 exactamente para ese tema. La colisión real de `procedencia` desnuda está en **§4.5** ("Destinos sin procedencia declarada"), **§4.6** y en la checklist de **§6** (`Criterios de aceptación`, con 3 ocurrencias desnudas en dos ítems, no ocho). El total de ocurrencias en todo el archivo es **23**, no acotado a una sola sección. Ancla **E1**, severidad de esta corrección puntual: no afecta la conclusión del caso (sí hay colisión en `Migracion-Rules.md`), pero el número y la sección citados en la evidencia previa no son utilizables como estaban. **No los arrastro al resto del informe.**

---

## 1. El requisito real, traducido de la frase del PO

La frase del PO tiene tres componentes verificables por separado, y conviene no fusionarlos:

**R1 — Detección.** *"la mesa debió verlo"*: tiene que existir un punto del método donde una acción como la del caso —renombrar un término dentro de un reporte, afirmando colisión sin haberla verificado— sea observable por *algún* mecanismo (compuerta, criterio de auditoría, o regla de mesa), no solo por la casualidad de que el propio agente se autocorrigió al releerse.

**R2 — Tratamiento como caso, no como parche puntual.** *"debió tratar una solución o propuesta"*: el PO no pide que se arregle el reporte `27` (ya se corrigió: sigue llamándose `ciclo de origen`, que es una elección legítima de la intervención según `Vocabulario-Rules.md` §9.6-style). Pide que el framework tenga **un mecanismo repetible** para esta clase de acto, no una corrección ad hoc del episodio.

**R3 — Armonización de ambigüedades, "asignando un contexto o algo similar".** Esta es la pista de diseño y hay que evaluarla, no adoptarla ni descartarla de oficio:

La pista apunta, con notable precisión, a algo que **ya existe como concepto** en `Vocabulario-Rules.md` §9.2: *"el contexto de lectura de un subagente es la sección, no el documento"*. El PO —sin conocer esa sección— está describiendo el mismo mecanismo que §9.1/§9.2 ya declaran: la colisión se decide por contexto compartido, no por la mera coexistencia del término en el árbol.

**Dónde la pista acierta:** el criterio de §9.1-§9.2 es correcto y ya cubre el caso general (`procedencia` en `Migracion-Rules.md` sí colisiona porque comparte sección con el campo nuevo propuesto; en `Master-Prompt.md` no, porque las secciones son disjuntas). El reporte `26` lo aplicó bien. **El requisito no es inventar el criterio de contexto: ya está escrito.**

**Dónde la pista queda corta, verificado:** §9.2 define "contexto de lectura" para el caso de un **subagente que recibe un despacho de `Master-Prompt.md` §8 con secciones nombradas**. Un agente que redacta un reporte de hallazgos sobre el framework **no opera bajo ese despacho** — lee el corpus libremente, sin una lista de "insumos" que le acote la sección. La definición de §9.2 tiene una premisa (*"el despacho... entrega secciones nombradas y no archivos completos; de ahí se sigue..."*) que **no se cumple** para el acto de este caso. Por eso "asignar un contexto" no es aplicable tal cual: hay que decidir **qué es "el contexto de lectura" cuando quien escribe no es un subagente despachado sino un agente que redacta un informe de auditoría propio**. Ancla **E2** (dos citas: §9.2 + la ausencia de despacho formal para reportes en `Mesa-Rules.md`/README de Reportes).

**Traducción a requisitos verificables:**
- **RV1**: debe existir una comprobación —mecánica o interpretativa, a decidir en el diseño— que se dispare cuando un agente declara que un término colisiona, y que la obligue a citar la verificación por sección antes de aceptarse (extensión operativa de §9.4 fuera del universo de "documentación que el framework genera").
- **RV2**: debe quedar definido qué cuenta como "sección"/"contexto de lectura" para un agente que **no** recibe despacho de §8 (el caso de quien escribe un reporte, un ADR, o cualquier artefacto fuera de las doce categorías).
- **RV3**: debe quedar declarado si esa comprobación alcanza a los reportes de la serie `IA.SDD.Documentacion/Reportes/` o si esa carpeta queda fuera de alcance por diseño (ver §2).

---

## 2. Alcance del hueco: los tres frentes, con evidencia por archivo

### (a) Hueco de criterios no enumerables — confirmado, pero no es la causa del caso

Los 13 criterios de §10 son interpretativos y §10.0 de `Master-Prompt.md` no tiene ninguna comprobación léxica entre sus seis comprobaciones transversales (enlaces/anclas, recuentos anclados, idempotencia, identificadores, anclaje de referencias, ítems diferidos — las seis verificadas línea por línea, ninguna es léxica). **Esto es real pero es un síntoma estructural, no la causa puntual del caso**: aunque §9.4 fuera enumerable mañana, seguiría sin aplicar al reporte, porque el problema (b) es anterior. Severidad **P2** si se lo mira aislado (afecta la mecanización general de §9, no bloquea nada hoy); no es lo que hay que resolver primero.

### (b) Hueco de alcance normativo — es el frente principal, con evidencia directa

`Vocabulario-Rules.md` declara su target en la cabecera: *"Archivo target: todo artefacto del framework y toda documentación que el framework genera"* (línea 3), y el bloque de §10 que trae los criterios de §9 lo repite explícito: *"Sobre desambiguación léxica (§9), en la documentación que el framework genera"* (línea 302).

Los reportes viven en `IA.SDD.Documentacion/Reportes/`, un repositorio **distinto** del normativo (`IA.SDD/SDD/`), y el propio README de esa carpeta los define como *"insumo de prompts de intervención... ninguno modifica el framework"* — es decir, son documentación **sobre** el framework, no una salida de sus doce categorías ni del despacho de §8. Tampoco son el "Registro de mesa" que `Mesa-Rules.md` §2.1 define como único artefacto propio de la mesa (ese vive en `SDD/Docs/Audit/` del repositorio destino, con estructura obligatoria de 9 puntos que no incluye nada parecido a un reporte de hallazgos contra el framework mismo).

**Conclusión verificada: los reportes de esta serie no están cubiertos por ningún target declarado.** No son alcanzados por `Vocabulario-Rules.md` §9/§10 (target explícito), no son el artefacto de `Mesa-Rules.md` §2, y `Master-Prompt.md` §10.0 solo corre "antes del audit" de una fase de generación — no antes de emitir un reporte de esta serie. Ancla **E1/E2** (cita literal + cruce con el README). Severidad **P1**: es un hueco de alcance que deja fuera de toda regla a un tipo de artefacto que el propio framework produce y usa como insumo de sus propias correcciones.

### (c) Hueco de momento de verificación — confirmado, es consecuencia de (b)

No hay compuerta en el punto donde el acto ocurrió. La secuencia real (visible en el changelog de ambos reportes) fue: v1.0 → un refutador de mesa detecta un problema de otra naturaleza (la premisa de auto-declaración) → en la misma pasada de "verificación previa de la intervención" se revisan las citas → el reporte `26` **sí** hace el barrido por sección (§9.2/§9.4) y concluye correctamente que no colisiona en `Master-Prompt.md`; el reporte `27`, escrito en la misma pasada e inmediatamente después, **hereda la premisa** ("`procedencia` ya está tomado") sin repetir el barrido por sección, y renombra directamente. Esto es exactamente el mecanismo que §9.4 nombra: *"el patrón queda primado: una vez que un producto declara una invariante para un término, la forma del patrón... se aplica al siguiente término sin volver a verificar la premisa"*. Ancla **E2** (cruce de los dos changelogs v1.1) y coincide con **C** de contradicción respecto de la prohibición literal de §9.4.

No existe hoy ningún punto —ni compuerta mecánica, ni criterio de mesa, ni paso de "verificación previa de la intervención"— que obligue a repetir la verificación por término en vez de por episodio. Es consecuencia directa de (b): si el tipo de artefacto no está en el alcance de ninguna regla, tampoco puede estar en el alcance de ninguna compuerta.

**Veredicto sobre la pregunta 2 del mandato: es (b) con (c) como consecuencia, y (a) como telón de fondo que no hay que confundir con la causa.** No se resuelva (b) tiene sentido diseñar (c), y (a) es un problema aparte y ya conocido (reporte `11`, resuelto en su momento con el alcance declarado de §8, que fue precisamente el intento anterior de resolver "el vocabulario del método no tiene glosario" — este caso no lo reabre, es un frente distinto: aquel era sobre dónde vive el vocabulario propio del método, éste es sobre quién audita el *acto* de desambiguar en un artefacto fuera de las doce categorías).

### (d) Sobre el criterio "invariante de desambiguación" citado en la evidencia

Verificado: el ítem de §10 que dice *"Toda invariante de desambiguación declarada cita la verificación de colisión que la justifica (§9.4)"* no aplica literalmente al acto del caso, porque el reporte `27` no declaró una **invariante de producto con prohibición de fusión** (la forma más cara de §9.3) — hizo una sustitución directa de nombre dentro de un documento propio. Es un acto **más barato** que una invariante, y por eso **cae en un vacío más profundo**: ni siquiera el criterio interpretativo existente (mal cubierto igual, por (b)) lo alcanzaría en su letra. Confirma que el hueco no es "el criterio de §10 está mal redactado", sino "no hay ningún criterio pensado para el acto de rebautizar dentro de una revisión de citas, sea o no invariante formal". Ancla **E2**.

---

## 3. Qué queda explícitamente fuera de este caso

- **No es un caso sobre si `procedencia` debía renombrarse o no en el reporte `27`.** Eso ya está resuelto: el reporte usa `ciclo de origen` y deja la decisión final a la intervención, que es el tratamiento correcto según `Vocabulario-Rules.md` §9.6. No hay que reabrir esa elección léxica puntual.
- **No es una reapertura del reporte `13`** (pregunta previa de escalada) ni del **`26`** en su contenido sustantivo (procedencia del estado a medias) — comparten corrida de origen pero **no artefacto**, exactamente como el propio `26` se cuida de declarar frente a `25`.
- **No es el hueco de (a) tomado aisladamente.** Mecanizar los 13 criterios de §9/§10 es un proyecto propio (marcarlos `[enumerable]` donde se pueda) que no depende de resolver este caso y que este caso no debe forzar a resolver como prerrequisito.
- **No propone fusionar ni tocar `Migracion-Rules.md` §4.5/§4.6/§4.7** — esas secciones están bien y no son el objeto de la corrección; solo sirvieron para verificar que la colisión real (no la citada erróneamente en la evidencia) existe donde el reporte `27` la ubica en sustancia, aunque cite mal el número de sección en la evidencia previa a este informe (esa cita errónea es del proceso de esta mesa, no de los reportes `26`/`27`, que no citan `§4.7` en ningún lado).
- **No es un juicio sobre si el agente actuó de mala fe.** El propio §9.4 lo nombra como mecanismo de sesgo estructural ("el patrón queda primado"), no como falta de cuidado.

---

## 4. ¿Reporte nuevo o arista de uno existente?

**Es un reporte nuevo.** Fundamento:

- El README de la serie (v1.24) ya declara la regla de corte: *"Un reporte nuevo evalúa SDD 12.1 o posterior"* — el caso es de SDD 13.10, corte cumplido.
- **No hay superposición de artefacto con ningún reporte abierto.** `26` toca `Master-Prompt.md` §7.0/§8/§8.1/§9 y `Mesa-Rules.md` §7 (procedencia del *estado*, quién generó la situación). `27` toca `Root-Rules.md` §12.1/§9/§10, `Migracion-Rules.md` §3/§4 y `Deriva-Rules.md` (correlación del *hueco* con el ciclo). Este caso toca `Vocabulario-Rules.md` §9.2/§9.4/§10 y el alcance de `Mesa-Rules.md`/README de Reportes frente a un tipo de artefacto que ninguno cubre. **El objeto es distinto de los dos**: no es "quién generó el estado" ni "de qué ciclo salió el hueco", es "quién verifica que un agente no rebautice por patrón heredado en un artefacto que ninguna regla mira". Con el mismo criterio que usan `26` y `27` para no fusionarse entre sí (comparten corrida de origen, no artefacto), este caso tampoco se funde con ninguno de los dos: comparte corrida (la misma sesión de "verificación previa de la intervención") pero el artefacto normativo que interpela es otro.
- El precedente más cercano en forma es el reporte **`24`** — *"el primero que incluye entre su evidencia un error del propio orquestador, cometido mientras escribía el informe de los otros tres casos"* — porque también es un hallazgo que nace de observar al propio proceso de redacción fallar en tiempo real. Pero `24` mide el mecanismo de "la decisión no vuelve sobre quien preguntó"; este caso mide "la verificación de colisión léxica no se repite por término y no hay compuerta que la exija fuera de las doce categorías". Son mecanismos distintos aunque el modo de detección (auto-observación durante la redacción) sea análogo. No corresponde fusionarlos: haría con `24` lo mismo que `26`/`27` se cuidan de no hacer entre sí.
- El reporte **`11`** (resuelto) ya cerró "el vocabulario del método no tiene glosario" con el alcance declarado de §8 de `Vocabulario-Rules.md`. Este caso no reabre esa resolución: opera **dentro** del alcance ya declarado por `11` (los seis términos de §2 más el mecanismo de §9), y encuentra un hueco distinto —de auditoría del *acto* de desambiguar, no de dónde vive el vocabulario—.

**Recomendación de numeración**: correspondería como reporte `28`, con reportes relacionados declarados como `24` (forma de detección análoga, mecanismo distinto), `26` y `27` (mismo corpus de origen, artefactos normativos distintos), y `11` (alcance ya resuelto que este caso no reabre sino que usa como base).

---

## 5. Lo que no pude verificar

- No corrí ninguna compuerta mecánica real (no hay script ejecutable de §10.0 en este árbol para invocar) — la comprobación de "ninguna es léxica" es por lectura de las seis comprobaciones enumeradas en `Master-Prompt.md` §10.0, no por ejecución.
- No verifiqué si existe, en `_legacy/` o en versiones intermedias, algún intento previo de cubrir este tipo de acto para reportes fuera de las doce categorías; solo miré el árbol vivo (`SDD/Devs/`).
- No tengo el informe de los otros miembros de esta mesa (trabajo a ciegas por mandato), así que no puedo saber si el frente de diseño (RV1-RV3) coincide o choca con lo que evalúan los agentes de Arquitectura o Riesgo.
