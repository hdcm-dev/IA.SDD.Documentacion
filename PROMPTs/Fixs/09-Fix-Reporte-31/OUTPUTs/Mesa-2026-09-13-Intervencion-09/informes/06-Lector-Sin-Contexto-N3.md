## Informe — Comisión Lector sin contexto (N3, núcleo permanente)

**Fecha:** 2026-09-13. **Siglas:** `M9-LEC-NN`.

**Base leída.** Contrato de entrada de la mesa; `plan/Expediente-Rules.md` 1.0 (para el ejercicio 1, sólo §1–§3 y §8 antes de escribir; el resto después); `plan/20-Plan-De-Aplicacion.md`; folio 016 entero, y de 014/015 lo referido a R-08, Q2 y Q11; norma 13.17 en `IA.SDD-i09` (`intervencion/09-reporte-31` = `main` `a501857`): `Master-Prompt.md` §7.0, §8.1, §9, §12.1 T4; `Master-Prompt-Migracion.md` §1 l.40–50, §3, §8 M4; `Master-Prompt-Reanudacion.md` §2 R0, §5, §5.1; `Mesa-Rules.md` §0.0, §2.1, §5.5, §7, §7.1; `Vocabulario-Rules.md` §9; `README.md` D3. El caso `scratchpad/caso/` y el guion `a1a10.sh`. No abrí ev-01..ev-03 ni los destinos: mi mandato no los necesita y el ejercicio 1 exigía no leer de más.

**Fuentes externas:** ninguna. No consulté ISO 15489 ni ninguna norma archivística; mis observaciones son de lector, no de archivista.

**Orden en que trabajé, para que la medición valga.** Escribí el expediente del ejercicio 1 **antes** de leer el contrato, el dictamen, §0 y §4–§7 de la regla, y el caso de prueba. Lo que sigue en «Ejercicio 1» refleja ese estado de ignorancia.

---

### Ejercicio 1 — abrir

**Qué hice.** Dos lecturas (`grep '^#'` para ubicar secciones; `sed -n` de §1–§3 y §8), una escritura de tres archivos, un `git init` con un commit vacío previo y un commit del expediente, una corrida del guion y una comprobación de diagnóstico. Tiempo de escritura: minutos; la forma mínima **sí se llena en minutos**. El expediente quedó en `<scratchpad>/mesa/tmp-lec/SDD/Expedientes/00001-Intake-Con-Cuatro-Unidades-De-Entrega/` (README, `001-presentacion-…`, `002-resolucion-…`), commit `666d1b9` sobre base `47d9684`, rama `master`.

**Dudas que tuve que resolver por mi cuenta (once):**

1. `Base` es «el commit corto al abrir»: en un repositorio recién iniciado no hay ninguno; hice un commit vacío para tener base. Tampoco dice de qué repositorio es la base cuando el caso atraviesa dos.
2. «Cuatro filas de cabecera» del folio: ¿tabla de dos columnas como la carátula, o `Tipo: …`? Supuse tabla (acerté: A4 sólo acepta `^| Tipo |`).
3. `Huella`: §3.3 remite «al comando de A8», que está en §6, fuera de lo que tenía. Calculé `sha256sum` del texto entre cercos, con salto final, y lo declaré en la celda. **A8 falló igual** (ver M9-LEC-01).
4. `Fecha-hora con zona`: formato libre. Escribí `2026-09-13 10:15 -03:00 (…)`; el caso de prueba usa ISO 8601. Ningún criterio lo mira.
5. `Autor` de una `presentacion` asentada por otro: ¿el Product Owner o quien asienta? Puse los dos.
6. `Título-Con-Guiones (D3)`: D3 no está en la regla; lo inferí del nombre.
7. Slug del archivo: ¿minúsculas con guiones? No lo dice; lo copié de la forma del ejemplo del árbol (`NNN-<tipo>-<slug>`).
8. Pase de una `resolucion`: qué acto sigue si la corrección todavía no se aplicó; escribí «aplicar… y asentar constancia».
9. `resolucion` pide «veredicto por criterio» (§3.2) pero la forma mínima la cuenta como 4 + 1 campos: ¿qué criterios tiene un caso de dos folios? Ninguno; escribí motivo y no veredicto.
10. **Si el caso abre expediente.** Por §1, un pedido por chat que cambia el intake tiene casa (§13 del intake, control de cambios); pero el bloque literal de §3.3 no cabe en una fila de control de cambios, y §1 dice que la forma de §3.3 «rige donde el testimonio se asiente». Con la letra a mano, la condición 2 («material externo que ningún artefacto con casa aloja») se cumple y **abrí**. Ver M9-LEC-03.
11. Cómo se clasifica «el intake dice cuatro»: afirmación de estado, ancla `C` (§3.3): eso sí estaba claro.

**Corrida de A1–A10** (`bash …/a1a10.sh …/mesa/tmp-lec SDD/Expedientes/00001-Intake-Con-Cuatro-Unidades-De-Entrega`):

```
== A1
0
== A2
== A3
== A4
0
== A5
== A6
== A7
fatal: bad revision 'main'
(fusión: )
fatal: bad revision '..main'
== A8
HUELLA SDD/Expedientes/00001-Intake-Con-Cuatro-Unidades-De-Entrega/actuaciones/001-presentacion-intake-dice-cuatro-unidades.md
== A9
== A10
== fin
rc=0
```

Dos fallas, ninguna de contenido:
- **A7**: mi rama principal es `master` (`git -C …/tmp-lec branch --show-current` → `master`); el comando lleva `main` fijo. Y lo grave: el `fatal` va a stderr y **la salida estándar del comando de la regla es vacía**, que es exactamente el «→ vacío» que declara PASS.
- **A8**: la huella era correcta —`awk … | sha256sum | cut -c1-64` → `acd95db2e27579390872c07b27752b9357d10956dbe5d21539a9747e857b256f`, igual a la asentada—, pero A8 exige la forma `| Huella | \`<hex>\`` (acentos graves, nada más en la celda) y §3.3 no la declara.

---

### Ejercicio 2 — retomar

Abrí `README.md` y el último folio (`002-resolucion-corregir.md`) del caso `00001-Enlace-Roto-En-Roadmap`. Con eso: **estado** = `resuelto` (tipo del último folio, tabla §3.2); **qué sigue** = «aplicar la fila 1.15 en `Roadmap-Producto.md`»; **quién** = orquestador. Dos archivos y lo tengo. Hasta ahí, el plan (cambio 4, R0 paso 4 y §5) funciona.

**Lo que me faltó:**
- **Si el acto del pase ya se hizo.** El roadmap ya tiene la fila 1.15 (`git -C …/caso grep -n '1.15' main -- SDD/Docs/Roadmap-Producto.md` → `main:SDD/Docs/Roadmap-Producto.md:1:| 1.15 | 2026-09-13 | Enlace a la etapa k corregido; …`). El pase es viejo y nada lo cerró. Un orquestador de reanudación que aplique R0 paso 4 como lo redacta el plan asentaría un pendiente falso, o tiene que abrir un tercer archivo para saberlo (M9-LEC-04).
- **Que hubo un borrado después de la fusión.** Sólo A7 lo muestra (`1d6a3dc borro evidencia`); ni el README ni el último folio lo dicen, y el plan no manda correr A7 en R0.
- **Una base que no resuelve.** `git -C …/caso cat-file -e abc1234` → `fatal: Not a valid object name abc1234`, rc=128. A2 sólo mira que la fila exista.
- Que «resuelto» significa *decidido* y no *aplicado*: con «Sigue: aplicar…» al pie de un expediente «resuelto», un lector sin contexto duda si está terminado. La tabla de §3.2 lo resuelve si uno la lee; el README no.

---

### Ejercicio 3 — tropezar

**Con la norma vigente 13.17**, a mitad de M4: M4 «Correcciones manuales» (l.291) manda al subagente devolver la diferencia con el snapshot como ambigüedad §9; el orquestador calcula origen del hecho contra la base; si es de la corrida, autocorrige; si es ajeno, enumera y espera confirmación. La contradicción con un ADR aprobado es «contradecir un conjunto cerrado aprobado» = arbitraje §7.0, que l.640 declara **bloqueante: sale en el momento** con la forma §8.1. Respuesta vigente: **me detengo, ahora, con dos hechos en una detención** (o en dos). Mesa: no, porque no hay punto de invocación en M4 y l.46 dice «no la reconvoca dos veces».

**Con el plan** (cambio 2 + cambio 3), sigo el orden de Q11: (1) origen del hecho; (2) de la corrida → autocorrección; (3) lo que sobrevive y cumple `Mesa-Rules.md` §0.0 → una mesa por lote de fase; (4) lo que sale de la mesa → lote §7.0; (5) «sólo salen en el momento los bloqueantes de §7.0 y los disparadores 2 y 3». Y acá **dudo tres veces**:

- ¿Mi contradicción con el ADR es bloqueante? Por `Master-Prompt.md` l.640 sí (arbitraje §7.0). Por `Mesa-Rules.md` l.562 es el disparador **7** («reapertura de una decisión cerrada», familia §7.0), y sólo 2 y 3 bloquean. El paso 5 nombra «los bloqueantes de §7.0 **y** los disparadores 2 y 3» como si fueran conjuntos distintos: no sé si el 7 entra.
- Si es bloqueante, ¿salteo el paso 3 o la mesa se convoca igual y el bloqueante sale mientras tanto? El resumen del plan no lo dice.
- Si convoco mesa a mitad de M4, ¿qué contrato de entrada tiene? §0.0 pide «estado leído con la forma de §4»; el de M1 describe un árbol que M4 ya cambió. El plan no dice quién lo escribe ni si el registro de M1 alcanza.

**Si lo que tropieza es la confirmación del plan de M1 o el traspaso T4:** el plan las excluye por nombre, y con eso no dudo: se detienen como hoy (§3 de migración: «presenta el plan completo y espera aprobación»; T4: «se detiene y entrega»). Lo único que el texto tiene que decir es que la exclusión es de *la familia*, no del momento: una ambigüedad §9 que aparezca **durante** M1 sigue pasando por el orden.

**Qué tiene que decir el texto para que yo no dude:** (a) que un tropiezo puede llevar dos hechos de dos familias y cada uno sigue su vía; (b) que lo bloqueante sale en el momento **sin esperar** la mesa, y la mesa —si se convoca— toma sólo lo que no bloquea; (c) qué disparadores de `Mesa-Rules.md` §7 cuentan como «bloqueante de §7.0» a los efectos del paso 5, resolviendo la diferencia entre l.640 y l.562; (d) qué es «lote de fase» en M4 (ver M9-LEC-06); (e) con qué contrato de entrada se convoca una mesa a mitad de fase.

---

### Hallazgos

**M9-LEC-01 · P1 · E1 · A8 verifica una forma que §3.3 no declara, y un lector de la forma mínima falla con la huella correcta.**
§3.3 pide «el SHA-256 del bloque, obtenido con el comando de A8»; A8 está en §6 y no en el snippet §8. Mi folio con hash correcto (`awk … | sha256sum | cut -c1-64` → `acd95db2…56f`, igual al asentado) falló: A8 exige `^| Huella | \`<hex>\`` (salida del guion arriba: `HUELLA …/001-presentacion-…`). Además, «huella del bloque» admite dos lecturas (con o sin líneas de cerco; con o sin salto final) y sólo el comando las fija. **Impacto:** el primer expediente de cualquier destino nace fallando A8 o el lector lee §6 entero, y la trampa declarada («ceremonia que nadie completa») se cumple en el campo más sensible. **Dirección:** §3.3 declara la forma exacta de la celda y qué bytes se hashean (o el snippet §8 lleva el comando), o A8 tolera el hex en cualquier parte de la celda.

**M9-LEC-02 · P1 · E1 · A7 lleva `main` fijo y su fallo se lee como PASS.**
En un repositorio cuya rama principal no es `main` (`git branch --show-current` → `master` en mi repo) el comando de A7 da `fatal: bad revision 'main'` por stderr y **nada por stdout**, que es el «→ vacío» que la regla declara conforme. La salida del guion está arriba. **Impacto:** S1 —la única garantía de que el expediente es registro— no se verifica en destinos con otra rama principal, y nadie lo nota. **Dirección:** la rama se deriva (`git symbolic-ref --short refs/remotes/origin/HEAD`) o se declara como parámetro `<principal>`, y la regla dice que un `fatal` no es «vacío».

**M9-LEC-03 · P1 · E3 · Un pedido por chat que cambia el intake no tiene casa para su bloque literal, y §1 empuja a abrir un expediente por cada mensaje.**
Caso construido (el del ejercicio): §1 dice que el testimonio se asienta «donde corresponda» con la forma de §3.3 y enumera folio, registro de mesa, `Decisiones-Pendientes.md` o bitácora de validación. Un pedido que se resuelve editando el intake bajo `Master-Prompt.md` §13 va a **una fila de control de cambios**, que no puede alojar un bloque de cerco byte a byte; y no es una decisión pendiente ni una validación. Con la letra a mano, la condición 2 de §1 se cumple y el lector abre. Es el anti-patrón I1 y la reserva CB que el jurado dejó en 015 Q2 («esa rama abre un expediente por cada mensaje del Product Owner»). **Impacto:** o proliferan expedientes de dos folios por cada chat que toca el intake, o el testimonio queda sin custodia, según el carácter del lector. **Dirección:** §1 nombra la casa del testimonio que funda un cambio de intake sin expediente (qué artefacto y con qué forma), o declara que la fila de §13 cita una pieza literal en un lugar fijo.

**M9-LEC-04 · P1 · E1 · El pase no tiene evento de cierre y R0 paso 4 lo lee como pendiente aunque el acto ya se hizo.**
En el caso de prueba, el pase del último folio dice «aplicar la fila 1.15 en `Roadmap-Producto.md`» y el roadmap ya la tiene (`git -C …/caso grep -n '1.15' main -- SDD/Docs/Roadmap-Producto.md` → una línea, arriba). Nada en la regla obliga a cerrar el pase con un folio cuando el acto se cumple; `archivo` con `Motivo: aplicado y verificado` existe pero no tiene disparador. El plan (cambio 4) contrasta `Suspende hasta:` y no el pase, a diferencia de los diferidos de `Root-Rules.md` §12.2, cuyo evento de cierre «se contrasta». **Impacto:** cada reanudación arrastra pendientes falsos, o abre un tercer archivo por expediente para saber si el pase sigue vivo. **Dirección:** el pase nombra su evento de cierre observable (artefacto §sección o comando, la forma del punto 4 de §12.2) y R0 paso 4 lo contrasta como a los diferidos; o la regla hace obligatorio el folio de cierre al cumplir el acto del pase.

**M9-LEC-05 · P1 · E2 · El paso 5 de Q11 combina dos listas de «bloqueante» que no coinciden, y un arbitraje por contradicción con un ADR no sabe si sale ahora o espera la mesa.**
`Master-Prompt.md` l.640: «Lo bloqueante son dos casos, y sólo dos. El arbitraje de este mismo §7.0 —extender o contradecir un conjunto cerrado aprobado…». `Mesa-Rules.md` l.562: «| 7 | Reapertura de una decisión cerrada … | §7.0, arbitraje |» sin la marca «Bloquea el ciclo» que llevan 2 y 3. El plan (cambio 2) escribe «sólo salen en el momento los bloqueantes de §7.0 y los disparadores 2 y 3». Mi tropiezo del ejercicio 3 es un arbitraje §7.0 (bloqueante por l.640) y un disparador 7 (no bloqueante por l.562). Tampoco dice el resumen si un bloqueante saltea el paso 3. **Impacto:** el orquestador o detiene de más (rompe el objetivo de Q11) o convoca una mesa sobre algo que el humano tenía que ver ya. **Dirección:** el texto de la subsección declara la relación entre «bloqueante de §7.0» y los disparadores 2, 3 y 7, y que lo bloqueante sale sin esperar la mesa; una sola lista, en un solo lugar.

**M9-LEC-06 · P2 · E1 · «Una vez por lote de fase» no es decidible en M4, porque «lote de fase» no existe en el prompt de migración y M4 tiene cortes con audit.**
`git grep -n 'lote' main -- SDD/Devs/Orchestrator/Master-Prompt-Migracion.md` → 2 líneas (l.154 y l.374), ninguna define un lote; `git grep -n 'lote de fase\|lote de la fase' main -- SDD/Devs/Orchestrator` → sólo `Master-Prompt.md:631`. En `Master-Prompt.md` §7.0 el lote «sale al cerrar la fase, junto con el informe de audit»; en M4 el audit corre **por corte** (l.292–293: «M4 se corta por categoría de nivel producto y por unidad de entrega. En cada corte se invoca el audit»). **Impacto:** el cambio 3 («la reconvoca sólo cuando… una vez por lote de fase») admite «una mesa por corte de M4» y «una por toda M4», y las dos son legales. **Dirección:** el cambio 3 dice qué es el lote en M4 (el corte, que ya tiene audit y confirmación) y qué es en M2/M3/M5.

**M9-LEC-07 · P2 · E4 · Una mesa convocada a mitad de fase no tiene declarado su contrato de entrada.**
`Mesa-Rules.md` §0.0 condición 2: «El estado ya está leído y disponible con la forma del contrato de entrada de §4». A mitad de M4 el estado que leyó M1 ya no es el del árbol; el plan (cambios 2, 3 y 5) no dice quién escribe el contrato, con qué base ni si el registro de M1 se reutiliza como corpus. **Impacto:** el orquestador que tropieza no sabe si la condición 2 se cumple, y ante la duda vuelve a detener, que es lo que Q11 quería evitar. **Dirección:** el paso 3 de Q11 nombra el contrato: base de la corrida, el registro de M1 como corpus previo, y el lote de tropiezos como «decisión de alcance por tomar».

**M9-LEC-08 · P2 · E1 · Palabras de la regla sin definición en la 13.17: la regla define la mayoría en línea, pero no todas, y `resolucion` ya nombra un campo en otra regla.**
Medido con `git -C …/IA.SDD-i09 grep -niw '<palabra>' main -- SDD PROMPTS README.md | wc -l`: `folio` 0, `foliatura` 0, `foja` 0, `carátula` 0, `actuación` 0, `actuaciones` 0, `providencia` 0, `presentacion` 0 (34 con tilde, otro sentido), `pase` 13 (ninguna en este sentido: «pase de QA», «no pase por»), `testimonio` 1 (`Coherencia-Mesa-De-Expertos-A-Pedido.md:55`, como E4, que el plan cambia), `sellado` 1 (binarios), `aplastando`/`aplastamiento` 0, `suspende`/`suspendido` 0, `custodia` 0, `en trámite` 0, `expediente` 1 (`Migracion-Rules.md:669`, sentido histórico). **La regla define ella misma:** folio y foliatura (§3.1), carátula (§3), providencia y los estados (tabla §3.2), pase (§3), testimonio y huella (§3.3), foja (§4 S3, «el orden de incorporación de los folios»). **No define:** «actuación» (sólo aparece como carpeta y como «La actuación. Un archivo por folio»), «custodia», «aplastar la historia» (jerga por *squash*; §4 S3 explica el efecto, no la palabra), «incorporación de antecedentes» (§5.1 la usa, no la define). Y `resolucion` sin tilde ya existe como campo: `git grep -nw 'resolucion' main -- SDD/Devs/Rules/Rules-Documentacion.md` → `514:| \`resolucion\` | Qué se hizo, con el comando o la configuración exacta |` y `953:resolucion: >`. Los contextos de lectura (`Vocabulario-Rules.md` §9.2) son disjuntos —bitácora de eventualidades de un destino vs. carpeta de expediente—, así que **no afirmo colisión**; afirmo que la nota de coherencia (cambio 16) tiene que adjuntar esa medición, porque §9.4 la exige para toda afirmación de no colisión, y el barrido del cambio 16 no lista `resolucion`. **Impacto:** el glosario §15 (cambio 2) sólo suma «expediente»; un lector nuevo lee «actuación», «foja», «aplastamiento» sin ancla. **Dirección:** §15 o un cuadro de vocabulario en la regla con una línea por término, y `resolucion` en el barrido del cambio 16.

---

### Respuestas a las preguntas del mandato

**(a) ¿Abrir en minutos?** Sí, escribir sí: tres archivos, once dudas menores, ninguna que impida escribir. **Verificar, no**: dos de diez criterios fallan por forma no declarada (A8) y por parámetro fijo (A7), y en A7 el fallo se lee como éxito. La forma mínima se llena en minutos; la verificación enumerando no es todavía la de la regla sino la de §6 leído entero.

**(b) ¿Retomar?** Sí, con README + último folio sé estado, acto y responsable. No sé si el acto ya ocurrió (LEC-04), si alguien tocó la carpeta después de fusionar (sólo A7), ni si la base existe.

**(c) ¿Tropezar?** Con la 13.17, me detengo y no convoco. Con el plan tal como está resumido, no sé si convoco, me detengo o las dos (LEC-05, LEC-06, LEC-07). Confirmación de M1 y T4: claro, se detienen como hoy.

**Fuera de mi competencia:** si la huella debe cubrir los cercos o no (Evidencia digital); si «lote de fase» debe ser el corte de M4 (orquestación de migración); si `resolucion` merece forma calificada (Vocabulario, con la medición de §9.4 que adjunto).

---

### Lo que revisé y está bien

1. **El estado derivado del último folio funciona sin contexto.** La tabla de §3.2 es total: con los dos casos (el mío y el de prueba) el estado se lee en un segundo y no hay campo que pueda desincronizarse.
2. **El tipo `archivo` no colisiona con «archivo» dentro de la regla.** `grep -n 'archivo' plan/Expediente-Rules.md | grep -v '\`archivo\`'` → 11 líneas, todas con el sentido de fichero; cada uso del tipo va entre acentos graves. Es la forma calificada más barata de §9.3 aplicada de manera consistente.
3. **Dos mesas el mismo día no chocan de nombre.** `Mesa-Rules.md` §2.1 l.156: «`Mesa-<AAAA-MM-DD>[-ciclo-<N>].md` … El sufijo de ciclo entra cuando hay más de uno en la misma fecha». La reconvocatoria del cambio 3 tiene dónde asentarse.

---

### Solicitudes de convocatoria

- **Evidencia digital**: señal en LEC-01 — qué bytes exactos cubre la huella del bloque `testimonio` (con o sin cercos, con o sin salto final); la regla lo fija sólo por el comando de A8.
- **Orquestación / Migración**: señal en LEC-05 y LEC-06 — la relación entre «bloqueante de §7.0» (`Master-Prompt.md` l.640) y los disparadores de `Mesa-Rules.md` §7 (l.562), y qué es «lote de fase» en M4 (l.291–293 de `Master-Prompt-Migracion.md`).
- **Vocabulario**: señal en LEC-08 — `resolucion` como campo vivo en `Rules-Documentacion.md` l.514 y l.953; la medición de no colisión que §9.4 exige no está en el cambio 16.
