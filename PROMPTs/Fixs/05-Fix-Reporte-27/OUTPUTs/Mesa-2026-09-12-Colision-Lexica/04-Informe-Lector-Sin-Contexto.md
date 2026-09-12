# Expediente 04 — Lector sin contexto

> **Transcripción verbatim.** Entregado el 2026-09-12. No editado.
> Mandato: leer `Vocabulario-Rules.md` §9 y §10 y `Master-Prompt.md` §10.0 **en frío**, sin conocer el
> hilo, y decir si un agente que acuña un término sabe qué tiene que hacer.

---

# Lectura en frío — Vocabulario-Rules.md §9/§10, Master-Prompt.md §10.0, Reportes 26 y 27

## 1. ¿Un agente que acuñó un término sabe qué hacer, cuándo, y contra qué comparar?

Parcialmente. Sabe el **criterio de decisión** (E1): *"Un término polisémico se desambigua solo cuando sus sentidos pueden aparecer en el mismo contexto de lectura"* (§9.1), y sabe la **escalera de formas** por costo creciente (§9.3: entrada de glosario → forma calificada → invariante con prohibición de fusión), con la instrucción de usar *"la más barata que resuelva el caso"*.

Pero le faltan tres cosas concretas para poder **ejecutarlo**, no solo entenderlo:

- **Contra qué corpus buscar.** El único precedente de ejecución real, §9.6, dice *"antes de adoptarla se corrió el barrido que §9.4 exige"* (E1), pero no define qué es "el barrido" — ¿grep sobre qué árbol, qué archivos, con qué comando se decide que está completo? El agente ve el resultado del barrido, no el procedimiento.
- **Si la regla lo alcanza a él.** §8 declara explícitamente (E1): *"Esta regla gobierna los términos del framework que colisionan con el vocabulario del dominio de un cliente: los seis de §2 [...] No gobierna el resto del vocabulario propio del framework [...] que vive en el glosario operativo de `Master-Prompt.md` §15"*. Un agente que acuña un término que **no** es uno de los seis de §2 — que es el caso más común — no tiene, leyendo solo este archivo, la certeza de que §9 sea la puerta correcta. Esto contradice la premisa misma de la pregunta 1: no siempre "puedo usar §9" es la pregunta correcta.
- **Quién verifica y con qué evidencia formal.** Ver punto 3.

Ancla: E1/E2.

## 2. "Mismo contexto de lectura" / "la sección" — ¿es operativo?

No queda claro el nivel de granularidad, y el propio corpus lo usa de dos maneras distintas:

- §9.6 aplica la colisión a nivel de subsección `###`: *"los dos sentidos coexisten dentro de §9.5 de este mismo archivo"* (E1).
- El ejemplo que §9.2 cita de `Master-Prompt.md` §8 nombra unidades ad hoc del despacho: *"«Parte A negocio; §13 composición; §17 bloque técnico de la unidad de entrega»"* (E1) — no son necesariamente headers de un nivel fijo, sino lo que el despacho de esa fase particular decidió recortar.

Es decir, "la sección" no es una unidad estructural fija del documento (no dice "nivel 2" ni "nivel 3"): es **lo que cada despacho, caso por caso, decide nombrar como insumo**. Eso es operable para el orquestador que arma el despacho, pero no es autocontenido para un lector que solo tiene `Vocabulario-Rules.md` en la mano y quiere decidir en abstracto si dos sentidos "comparten sección" (E3).

Sobre el conjunto de documentos contra el que se compara: hay una tensión no resuelta entre la cabecera del archivo — *"Archivo target: todo artefacto del framework y toda documentación que el framework genera"* (E1, línea 3) — y §8, que acota **todo el archivo, §9 incluido**, a los seis términos de §2. §9.1 y el encabezado de §10 (*"en la documentación que el framework genera"*, E1, línea 302) están redactados en términos generales, sin repetir la acotación de §8. El archivo no dice cuál de las dos lecturas prevalece.

## 3. §9.4 — ¿quién verifica, cuándo, y qué pasa si nadie lo hace?

§9.4 dice (E1): *"No se declara una invariante de desambiguación sin haber verificado que los contextos colisionan [...] La verificación es por ocurrencia y es afirmación sobre el estado del sistema: cae bajo D9."*

No nombra **quién** — no dice si es el mismo agente que acuña, un auditor, o el orquestador. El "cuándo" se infiere (antes de declarar), pero no está explícito como paso obligatorio previo con checkpoint. La consecuencia declarada es indirecta: caer bajo D9 remite a `Master-Prompt.md` §10, donde *"Una afirmación sin evidencia es P1; una evidencia que no resuelve es P0"* (E1) — pero esa comprobación de D9 vive en la matriz **interpretativa** del audit de fase, no en la compuerta mecánica de §10.0 (que no la lista entre sus seis comprobaciones enumerables). Es decir: si nadie corre un audit de fase sobre ese artefacto puntual, **nada mecánico la atrapa** (E2).

El caso real lo confirma por el lado bueno: en el Reporte 26, el control de cambios v1.1 admite (E1): *"la primera redacción de esta versión afirmaba la colisión sin medirla — el mismo falso positivo que esa regla nombra"*, y la corrección vino de *"el refutador del ciclo 4"* de una mesa de evaluación — un mecanismo de `Mesa-Rules.md`, no el audit de `Master-Prompt.md` §10 ni la compuerta de §10.0. Eso sugiere que, en la práctica, quien terminó verificando §9.4 no es el rol que las propias reglas de vocabulario o de audit nombran para hacerlo — funcionó, pero por una vía distinta a la declarada (E3).

## 4. Los criterios de §10 frente a "renombró un campo afirmando una colisión no verificada"

Antes de responder: conté **13 ítems** en §10 de `Vocabulario-Rules.md` (7 transversales + 6 bajo "Sobre desambiguación léxica"), no once (E1, verificado línea por línea). Lo dejo asentado porque el enunciado da por sentado un número que no coincide con lo que hay en el archivo.

Repaso uno por uno contra el caso (agente renombra un campo en un reporte, afirma colisión, no verifica):

1. "proyecto" a secas — No, otro término.
2. "solución" a secas — No.
3. Cuatro campos de identidad de §3 — No.
4. `Nombre-Producto` vs `Raiz-Codigo` — No.
5. Choque con glosario del dominio cliente — No.
6. Sinónimo nuevo sin incorporar a §2 — No, es sobre los seis términos, no sobre un campo de reporte.
7. "migración" a secas — No.
8. Término acuñado en >1 artefacto sin entrada de glosario — No comprueba verificación, solo declaración.
9. Término con >1 referente sin glosario/forma calificada — Tampoco exige que la colisión haya sido *verificada*, solo que esté *resuelta*.
10. Forma desnuda sin resolver en sección despachada — No aplica al caso (no hay forma desnuda, hay un rename).
11. **Criterio negativo** (no reportar como defecto una polisemia con contextos disjuntos) — Cerca, pero mira la dirección opuesta: castiga sobre-reportar una colisión inexistente como defecto del documento auditado, no exige que quien renombra *demuestre* haber verificado antes de actuar.
12. **"Toda invariante de desambiguación declarada cita la verificación de colisión que la justifica (§9.4)"** — Es el más cercano (E1), pero su alcance textual es "invariante de desambiguación", que en la escalera de §9.3 es el escalón más caro (prohibición de fusión con alcance a las doce categorías). Un simple rename de campo dentro de un reporte, sin declarar una invariante formal, **no necesariamente cae bajo este ítem** — podría colarse como "solo forma calificada", que ningún criterio obliga a acompañar de evidencia de verificación.
13. Sustitución global de cadena con registro de ocurrencias — No aplica; es sobre reemplazo masivo en corpus ya escrito, no sobre un rename puntual al redactar.

Conclusión: **ninguno atrapa con certeza** el caso descripto si el rename no llega al rango de "invariante declarada"; el #12 es el candidato, pero tiene un hueco de alcance (E3).

## 5. Alcance — ¿los Reportes de `IA.SDD.Documentacion/Reportes/` están gobernados por Vocabulario-Rules.md?

No lo encontré declarado en ningún sentido explícito (busqué "Reportes" en `Vocabulario-Rules.md` y `Master-Prompt.md`: la única coincidencia es una fila de control de cambios que *cita* el reporte 13 como origen de una versión, no una declaración de alcance sobre el directorio).

Lo que sí hay es la tensión ya señalada en 2: la cabecera del archivo dice "todo artefacto del framework y toda documentación que el framework genera" (E1), y los reportes son producidos siguiendo reglas del framework (mesas de evaluación, `Mesa-Rules.md`), lo que los haría entrar por esa lectura amplia. Pero §8 acota **la regla entera** —§9 incluido— a los seis términos de §2 que colisionan con vocabulario de cliente. Los términos que los Reportes 26 y 27 tratan ("procedencia", "origen del hecho", "ciclo de origen") **no son ninguno de los seis** ni colisionan con dominio de cliente: son vocabulario interno de trazabilidad/migración, que §8 remite explícitamente a *"el glosario operativo de `Master-Prompt.md` §15"* (E1), no a Vocabulario-Rules.md.

Es decir: leído en frío, los propios Reportes 26 y 27 invocan §9.1/§9.2/§9.4 como autoridad para justificar sus decisiones de nombrar campos, sobre un tipo de término que, según §8 de la misma regla que citan, **no está gobernado por esa regla**. Ningún artefacto de los tres leídos resuelve esta contradicción ni la menciona (E2/E3).

## 6. Lo que llamó la atención sin que nadie lo preguntara

- **El hallazgo más fuerte es el del punto 5**: dos reportes normativos aplican §9 a términos que, por la propia acotación de §8 del mismo archivo, no le corresponden a §9 sino al glosario operativo de `Master-Prompt.md` §15. Nadie lo audita porque, según el punto 3, la verificación de §9.4 cae en D9/audit interpretativo y no en la compuerta mecánica — y los Reportes no parecen pasar por ningún audit de fase (no encontré ese vínculo).
- **El propio Reporte 26 documenta, en su changelog, haber cometido el defecto que la regla nombra** (E1: *"la primera redacción de esta versión afirmaba la colisión sin medirla"*) y haberlo corregido gracias a un rol de mesa (`refutador`), no gracias al mecanismo que las reglas de vocabulario o de audit describen. Es un caso real, encima documentado, de que el instrumento que efectivamente funcionó no es el que el marco normativo señala como responsable — coincide con la propia advertencia de `Master-Prompt.md` §10 sobre que *"dos agentes del mismo modelo [...] tienden a coincidir"* y que la independencia real hay que fabricarla aparte.
- **El "once" del enunciado no coincide con el conteo real (13)** — lo señalo porque la consigna pide no confirmar de más: si alguien va a auditar contra "los once criterios", ya arranca con un desajuste de referencia.
- Dato menor pero curioso: los dos reportes proponen nombres provisorios ("origen del hecho", "ciclo de origen") explícitamente **porque** "procedencia" ya está tomado, y ambos delegan el nombre final "a la intervención bajo `Vocabulario-Rules.md`" — pero, por el punto 5, esa delegación apunta a una regla que quizás no tiene jurisdicción sobre ese término. Si eso es así, la intervención podría terminar acuñando el nombre sin ningún artefacto que efectivamente lo gobierne, ni Vocabulario-Rules.md ni el glosario operativo (que tampoco vi que lo liste todavía).
