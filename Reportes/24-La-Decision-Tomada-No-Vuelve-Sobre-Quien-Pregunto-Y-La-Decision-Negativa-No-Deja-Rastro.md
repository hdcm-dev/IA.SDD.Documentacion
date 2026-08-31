# Reporte 24 — La decisión tomada no vuelve sobre quien preguntó, y la decisión negativa no deja rastro

| Campo | Valor |
|---|---|
| Reporte | 24 |
| Fecha | 2026-08-31 |
| Origen | Una jornada de cierre de puntos abiertos en el destino `Lab-Geometria`, el **2026-08-31**, en la que **cuatro decisiones correctas, fechadas y registradas** aparecieron declaradas como pendientes por los documentos que existen para enumerarlas. Los cuatro casos son independientes entre sí y tienen disparadores distintos |
| Versión del framework evaluada | SDD **13.8** (`Root-Rules.md` §12.1 y §12.2, `Master-Prompt.md` §10.0 comprobación 6, `Master-Prompt-Reanudacion.md` §2 paso 4, `Mesa-Rules.md` §5.1) |
| Artefactos del framework alcanzados | `SDD/Devs/Rules/Root-Rules.md` §12.1 y §12.2 · `SDD/Devs/Orchestrator/Master-Prompt.md` §10.0 · `SDD/Devs/Orchestrator/Master-Prompt-Reanudacion.md` §2 |
| Naturaleza | **Dos huecos con una misma raíz.** El primero es de **reciprocidad**: §12.1 y §12.2 obligan a quien difiere a nombrar el evento que lo hará volver, y **nada obliga al evento a volver**. El segundo es de **testimonio**: hay una clase de decisión —la que resuelve *no hacer*— **cuyo cumplimiento consiste en que no exista nada**, y para ésa la verificación contra el árbol, que es el remedio habitual del método, **produce la conclusión opuesta** |
| Estado | **Abierto** |
| Reportes relacionados | **`21`**, con el que comparte el terreno y del que se distingue por la dirección: aquél es sobre **el barrido hacia adelante** de una decisión —qué categorías alcanza y quién lo declara—; **éste es sobre el camino de vuelta**, hacia el artefacto que había planteado la pregunta y se quedó esperando. **`17`**, cuyo hallazgo `HM-02` —el diferimiento se contrasta contra el calendario y no contra los hechos— **explica por qué el saneamiento no atrapa esto**, y que acá se mide por segunda vez |

---

## 1. Resumen

**`Root-Rules.md` §12.1 y §12.2 obligan a que un ítem diferido nombre el evento que lo cierra —«qué evento obliga a volver sobre este artefacto»—. Nada, en ninguna parte del método, obliga a ese evento a volver.**

La obligación existe **de un solo lado**: el que pregunta declara cuándo lo vendrán a buscar. El que contesta no tiene ninguna que lo mande a buscarlo. Y como no hay estado intermedio, **una decisión bien tomada y una decisión bien tomada y propagada se ven exactamente iguales desde afuera**: las dos tienen fecha, autor, fundamento y registro. La diferencia sólo se ve parándose en el artefacto que preguntó, y nadie tiene mandato de pararse ahí.

**Y hay un segundo hueco, que aparece cuando se intenta el remedio obvio.** El remedio obvio es no creerle al documento y verificar contra el árbol —es lo que este destino viene usando bien, y con él cerró más de veinte puntos «por lectura»—. **Ese remedio falla, y falla al revés, para las decisiones cuyo contenido es no hacer algo:** adoptar un valor por omisión, no incorporar una herramienta, no fijar un número. **Su cumplimiento consiste, exactamente, en que en el árbol no haya nada** — que es indistinguible de que la decisión nunca se haya tomado.

---

## 2. La evidencia: cuatro casos en un día, con cuatro disparadores distintos

Los cuatro son del destino `Lab-Geometria` y **ninguno es un error de juicio**: las cuatro decisiones son correctas, están fechadas y están registradas en algún lado.

| # | Qué se decidió, y cuándo | Qué siguió diciendo lo contrario | Cuánto duró |
|---|---|---|---|
| **1** | **`D1`**: el Product Owner confirma los umbrales de asunción, **2026-08-26**. Cerró doce filas vencidas y volvió bloqueantes diez puertas de calidad | **`PRODUCT-INTAKE` §22**, que es **la sección que declara esas asunciones**, siguió enumerando cuatro vivas cuando quedaba un fragmento de una | 5 días |
| **2** | **`PT-01.a`**: se mide sobre el hosting real, **2026-08-13**. La versión de plataforma queda resuelta, con evidencia en tres documentos | **Diez apariciones en nueve documentos** siguieron declarando la marca `[A VERIFICAR]` abierta, `PRODUCT-INTAKE` §17.2.P.9 entre ellas | 18 días |
| **3** | **`PA-01`**: se cierra por lectura, **2026-08-20**. No hay biblioteca de componentes, y su ausencia es una decisión declarada en el archivo de proyecto | **Diez lugares** siguieron pidiendo anclar su versión, incluida **la fuente que acuñó la marca** | 11 días |
| **4** | **`D4`, `D5` y `D8`**: tres decisiones del Product Owner, **2026-08-20**, en un commit que las cerró sobre **cinco documentos** | **`A3-Decisiones-Del-Product-Owner.md`**, que es **el documento que existe para enumerar las decisiones pendientes**, no fue tocado por ese commit | 11 días |

### 2.1 El caso 2 muestra que el saneamiento tampoco lo atrapa

**El 2026-08-27 la mesa de evaluación del destino miró tres de las filas del caso 2 y les dio más plazo.**

Detectó, con evidencia `E4` y voto `PROCEDE 5-0`, que estaban **vencidas por un evento que no podía cerrarlas**, y aplicó un parche que **les movió el evento de cierre de la etapa `a` a la fase `i`**, con este fundamento: *«la fuente las rotula `[A VERIFICAR]` y esas marcas se resuelven midiendo, no decidiendo»*.

**El fundamento es correcto. La conclusión no: la medición existía desde hacía catorce días.** Las tres filas pasaron de `VENCIDO` a `Vigente` y **el corpus registró como saneamiento el haberle dado más plazo a una pregunta ya contestada**.

La mesa hizo bien las cinco cosas que `Mesa-Rules.md` le pide. **Ninguna de las cinco es contrastar el ítem contra los hechos** — que es exactamente el hallazgo `HM-02` del reporte `17`, acá **medido por segunda vez y con un agravante**: el primer caso lo produjo el olvido; **éste lo produjo el mecanismo de saneamiento funcionando como está escrito**.

### 2.2 El caso 4 es el que trae la figura nueva, y se midió cometiéndolo

**El error lo cometió quien estaba escribiendo el informe de los otros tres**, lo cual lo vuelve una medición limpia de qué tan invisible es el hueco.

Antes de declarar abiertas a `D4`, `D5` y `D8`, **se verificó contra el árbol** — que es el remedio que los tres casos anteriores enseñaban:

```text
¿hay MaxRequestBodySize o equivalente?            no    ->  «D4 sin decidir»
¿hay herramienta de cálculo de versión?           no    ->  «D7 sin decidir»
¿hay herramienta de mutación?                     no    ->  «D8 sin decidir»
```

**Dos de las tres conclusiones son falsas, y la verificación es correcta.** Lo que el árbol no puede decir es esto:

- **`D4` se decidió adoptando el valor por omisión** del servidor HTTP, y no fijar uno propio.
- **`D8` se decidió con un NO**: la puntuación de mutación no entra al flujo.

**El cumplimiento de las dos consiste, literalmente, en que no haya nada.** La ausencia de `MaxRequestBodySize` **no es la falta de la decisión: es la decisión, ejecutada.** Y es idéntica, byte por byte, a la ausencia que dejaría no haberla tomado nunca.

> **Una decisión afirmativa deja huella y una negativa no.** Para la negativa, **el registro no es una copia redundante del árbol: es la única fuente que existe.** Y el registro es, precisamente, lo que ninguna regla obliga a actualizar cuando la decisión se toma.

---

## 3. Qué dice hoy el framework, y por qué no alcanza

**Lo que el framework resuelve bien, y no hay que tocar.**

`Root-Rules.md` **§12.1** exige que una referencia pendiente declare *«cuándo se cierra: qué evento obliga a volver sobre este artefacto»*, y **§12.2** pide lo equivalente para un ítem diferido, con sus cuatro campos. Las dos formas son correctas y las dos nombran el regreso.

`Master-Prompt.md` **§10.0 comprobación 6** detecta el ítem cuyo evento **ya ocurrió** y sigue abierto, y `Master-Prompt-Reanudacion.md` §2 paso 4 lo repite en la reanudación. **Funcionan**: es lo que hace que un vencido se vea.

**Lo que no está.**

1. **La obligación recíproca.** §12.1 y §12.2 le piden al **artefacto que difiere** que nombre el evento. **Ninguna regla le pide al acto que resuelve ese evento que enumere y cierre lo que estaba esperándolo.** El método tiene la flecha de ida escrita y la de vuelta no.

2. **El estado intermedio.** No existe «decidida, sin propagar». Una decisión se registra y con eso queda completa a los ojos de toda comprobación del método. **La comprobación 6 no la alcanza**, porque la comprobación 6 mira ítems abiertos con evento vencido y **acá el problema está del otro lado**: el ítem abierto ya no debería existir.

3. **El testimonio de la decisión negativa.** Ninguna regla distingue una decisión que **agrega** de una que **resuelve no agregar**, y por lo tanto ninguna advierte que para la segunda **la verificación contra el árbol no es válida**. El destino ya cerró más de veinte puntos «por lectura del árbol» con muy buen criterio; **nada le dice dónde ese criterio deja de aplicar**.

---

## 4. El hueco, en una frase

> **El método obliga a declarar por qué evento se volverá, y no obliga a volver; y para la clase de decisión que resuelve no hacer nada, el árbol —que es el remedio del método contra los documentos desactualizados— testimonia lo contrario de lo que ocurrió.**

---

## 5. Qué se propone evaluar

**Ninguna de las tres es una propuesta de redacción: son las preguntas que el framework tiene que contestar.**

1. **Si el acto de decidir se considera completo sin haber vuelto sobre quien preguntó.** Si la respuesta es no, la forma más barata es simétrica a la que ya existe: así como §12.2 exige nombrar el evento de cierre, **el acto que resuelve ese evento debería enumerar los ítems que lo nombraban**. La lista ya existe y es mecánica: son los que citan ese evento.

2. **Si conviene un estado «decidida, sin propagar»**, o si alcanza con que la comprobación 6 gane una simétrica: **no sólo «ítems abiertos cuyo evento ya ocurrió», sino «decisiones registradas cuyos ítems dependientes siguen abiertos»**. La segunda parece más barata y no agrega estados al modelo.

3. **Si la decisión negativa necesita una forma propia.** Es la que este reporte considera más urgente, porque es la única de las tres que **no se puede compensar con disciplina**: quien verifica contra el árbol y concluye mal **no cometió un descuido**. Una figura mínima sería obligar a que una decisión cuyo cumplimiento es la ausencia de algo **lo declare como tal** —«se decide no incorporar X; su cumplimiento se verifica en el registro y no en el árbol»— y que **cerrar ese ítem por lectura del árbol quede prohibido**.

---

## 6. Lo que este reporte no afirma

- **No afirma que las decisiones estuvieran mal tomadas.** Las cuatro son correctas, fechadas y fundadas. El hueco está en el trayecto, no en el acto.
- **No afirma que el destino se haya descuidado.** Tres de los cuatro casos los encontró el propio destino barriendo; el cuarto lo produjo el barrido mismo y lo encontró al abrir un archivo por otro motivo.
- **No pide una matriz de propagación.** Eso es el reporte `21` y es la dirección contraria. Acá la lista de destinatarios **ya está escrita** —son los ítems que nombran el evento—; lo que falta es la obligación de recorrerla.
- **No propone que la comprobación 6 cambie.** Funciona, y su cobertura ya la discute el reporte `17`.

---

## 7. Cómo reproducirlo

Sobre cualquier destino con ítems diferidos según §12.2:

1. Listar los ítems que nombran un evento de cierre y agruparlos **por evento**.
2. Para cada evento, establecer **si ya ocurrió** — no por fecha, sino buscando el acto: un commit, un informe, una medición.
3. Para los que ocurrieron, contar cuántos ítems del grupo **siguen abiertos**. Ése es el retraso de propagación, y no hay ninguna comprobación del método que lo reporte.
4. Aparte, listar las decisiones cuyo contenido sea **no hacer algo** y comprobar si el árbol podría testimoniarlas. Para las que no, comprobar si algún documento las declara todavía pendientes.

En `Lab-Geometria`, al 2026-08-31, el paso 3 daba **cuatro eventos ocurridos** con este reparto:

| Evento ocurrido | Ítems que seguían abiertos |
|---|---|
| `D1`, confirmada el 2026-08-26 | **4** filas de asunción en `PRODUCT-INTAKE` §22 |
| `PT-01.a`, medida el 2026-08-13 | **10** apariciones en 9 documentos |
| `PA-01`, cerrada el 2026-08-20 | **10** lugares |
| `D4`, `D5` y `D8`, decididas el 2026-08-20 | **3** entradas de `A3` §2, más el recuento de §4 y el orden de §3 |

Y el paso 4 daba **dos de dos**: las dos decisiones negativas del destino —`D4` y `D8`— **estaban declaradas pendientes**, y las dos por el mismo motivo.

---

## Control de cambios

| Versión | Fecha | Cambios | Autor |
|---|---|---|---|
| 1.0 | 2026-08-31 | Emisión inicial. Documenta **dos huecos con una raíz común**, con cuatro casos medidos en una sola jornada del destino `Lab-Geometria` y con cuatro disparadores independientes. **El primero es de reciprocidad**: `Root-Rules.md` §12.1 y §12.2 obligan a quien difiere a nombrar el evento que lo hará volver, y ninguna regla obliga a ese evento a volver; como no hay estado intermedio, una decisión propagada y una sin propagar **son indistinguibles desde afuera**. **El segundo es de testimonio**, y es el que el reporte considera más urgente porque **no se puede compensar con disciplina**: la decisión que resuelve *no hacer* —adoptar un valor por omisión, no incorporar una herramienta— **tiene por cumplimiento que en el árbol no haya nada**, de modo que la verificación contra el árbol, que es el remedio habitual del método contra los documentos desactualizados, **concluye lo contrario de lo que ocurrió**. Se registra que el caso que trae esa figura **se midió cometiéndolo**, al verificar tres ausencias en el código y leerlas como tres decisiones pendientes. Se registra además que el saneamiento no lo atrapa: la mesa del destino, con evidencia `E4` y voto unánime, **le dio más plazo a una pregunta contestada catorce días antes**, que es el hallazgo `HM-02` del reporte `17` medido por segunda vez. | Orquestador SDD |
