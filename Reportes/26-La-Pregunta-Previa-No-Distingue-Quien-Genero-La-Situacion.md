# Reporte 26 — La pregunta previa no distingue quién generó la situación

| Campo | Valor |
|---|---|
| Reporte | 26 |
| Fecha | 2026-09-12 |
| Origen | Un requisito de diseño que el Product Owner de `Lab-Geometria` formuló el 2026-09-12, durante el ciclo 4 de la mesa de la sexta reanudación: *«los agentes se encuentran con situaciones que han generado ellos y de golpe me descargan a mí problemas que han generado ellos y que pudieron haber resuelto si el análisis se hubiese hecho sobre todo el conjunto y luego afinando donde corresponda»* |
| Versión del framework evaluada | SDD **13.10** (`Master-Prompt.md` §7.0, §8, §8.1 y §9 · `Mesa-Rules.md` §0.1, §0.2 y §7 · `Master-Prompt-Reanudacion.md` §6) |
| Artefactos del framework alcanzados | `SDD/Devs/Orchestrator/Master-Prompt.md` **§8.1** —donde nace—, §7.0 y §9 · `SDD/Devs/Rules/Mesa-Rules.md` §7.1 · `SDD/Devs/Orchestrator/Master-Prompt-Reanudacion.md` §6 |
| Naturaleza | **Un eje de corte que falta, y un mecanismo que existe y no se usa para esto.** La decisión de elevar algo al humano se toma con **una sola pregunta** —¿esto tiene respuesta en el árbol?— y ninguna regla pregunta **quién produjo el estado que motiva la consulta**. Un estado que el propio agente dejó a medias **no tiene respuesta en el árbol por construcción**, y con el criterio literal cae del lado de «se detiene». Y el dato que lo resolvería —el estado previo, archivado antes de despachar— **ya se toma y no se usa para esto** |
| Estado | **Abierto** |
| Reportes relacionados | **`13`**, que estableció la pregunta previa de §8.1 y **rechazó con fundamento** la alternativa de tres estratos: este reporte **no la reabre**, agrega una cláusula anterior. **`23`**, sobre la reconciliación entre roles de la mesa: comparte el terreno de las detenciones y no el objeto. **`24`**, que mide la decisión que no vuelve sobre quien preguntó: es el camino de vuelta, éste es el de ida. **`25`**, con el que comparte la corrida de origen y **no el artefacto**, por lo que va separado |

---

## 1. Resumen

**El método tiene una sola pregunta para decidir si algo se eleva**, y está bien elegida:
`Master-Prompt.md` §8.1 la formula como *«¿esto tiene respuesta en el árbol?»*. Resolvió un problema
real y medido —de cinco detenciones presentadas a un Product Owner, **tres no eran suyas**— y su
alternativa más cara ya fue evaluada y descartada con fundamento en el reporte `13`.

**Lo que esa pregunta no distingue es quién produjo el estado por el que se pregunta.** Y hay una clase
de estado para la que la respuesta es siempre la misma: **lo que el propio agente dejó a medias**. Un
documento que empezó y no cerró, una decisión que tomó y no asentó, una inconsistencia que introdujo en
una unidad anterior de la misma corrida. Para todo eso, **el árbol no tiene la respuesta por
construcción** —porque el agente no la escribió—, y el criterio literal manda detener.

**El resultado es que la pregunta llega al humano con la forma de una pregunta legítima.** Trae su
contexto, sus opciones y su propuesta, cumple la lista cerrada de disparadores, y es indistinguible de
una consulta real. Lo único que la distingue es un dato que nadie mira: **que el estado que la motiva no
existía antes de que este agente empezara**.

**Y hay un segundo hueco, de momento y no de criterio.** La pieza que el método tiene para mirar el
conjunto antes de preguntar —la mesa de evaluación— **corre en puntos fijos**. Entre uno y otro, cada
agente que tropieza se detiene en el momento en que tropieza, y su consulta sale sin pasar por ningún
filtro que la mire junto a las demás de la misma fase. **Dos preguntas que se resuelven mirándose entre
sí llegan separadas**, que es exactamente lo que el Product Owner describe.

---

## 2. La evidencia

### 2.1 La pregunta previa, y el caso que no cubre

`Master-Prompt.md` §8.1 declara el criterio con una sola línea, y su tabla de resolución tiene **dos
filas**: un **defecto propio** —un enlace mal derivado, un recuento desactualizado—, que el agente
corrige en la misma unidad y declara en el cierre; y una **decisión de diseño**, que es del humano.

**Falta la tercera fila, y no es una variante de ninguna de las dos.** Un estado a medias que el propio
agente produjo y no cerró **no se corrige con una edición local** —hay que reconstruir qué se hizo, en
qué unidades, y qué quedó sin escribir— pero **tampoco es una decisión de producto**. Forzado a la
primera, se corrige apurado y mal. Forzado a la segunda, se eleva algo que nunca fue del humano.

**Verificado por ausencia**: ningún artefacto del conjunto normativo tiene un término para «estado que
el propio agente produjo y no cerró». La única coincidencia léxica cercana pertenece a otro dominio, y
conviene decirlo para que la intervención no lo tropiece: **el término `procedencia` ya está tomado** por
el framework con otro significado —la versión del framework bajo la que el destino se estructuró, el
bloque §1.1 del `PRODUCT-MANIFEST`—, con 14 ocurrencias en `Master-Prompt.md` y 16 en
`Migracion-Rules.md`.

**Pero acá no colisiona, y eso se verificó en vez de suponerse.** Las 14 de `Master-Prompt.md` están en
§0, §2.1, §3, §5 y §7; **ninguna en §8, §8.1 ni §9**, que son las secciones donde viviría el campo que
este reporte propone. `Vocabulario-Rules.md` §9.2 fija que **el contexto de lectura de un subagente es
la sección, no el documento**, y §9.1 que un término polisémico **se desambigua sólo cuando sus sentidos
pueden aparecer en el mismo contexto de lectura**. Acá no pueden.

**De modo que este reporte no pide desambiguar nada**, y §9.4 es explícita sobre por qué importa:
declarar una desambiguación sin haber verificado que los contextos colisionan **es** el defecto, y una
vez hecho el patrón queda primado para el término siguiente. En este documento el campo se nombra
**`origen del hecho`** por claridad de lectura, no por obligación léxica; la intervención puede
llamarlo `procedencia` si le conviene, y **la verificación de §9.1 ya está hecha y da que puede**.

**La advertencia sí aplica al reporte `27`**, que toca `Migracion-Rules.md` — donde el término ya vive,
y desnudo, en §4.5, §4.6 y la checklist de §6. **Esta línea decía §4.7 hasta la v1.2**, y §4.7 no tiene
una sola ocurrencia: es la sección de revisión de apartamientos. El error es del orquestador, no del
reporte `27`, y se corrige acá con su constancia porque es el mismo defecto que el reporte denuncia.

### 2.1.1 La cláusula que produce el caso, y que estaba a la vista

**Hay una línea que convierte el hueco en obligación, y no está en §8.1 sino en §8**, en el bloque
`Estado previo del entregable` que todo despacho lleva:

> *«Si al abrir el entregable encontrás contenido que el snapshot no refleja, **detenete y devolvelo
> como ambigüedad según §9, sin editar**.»*

**Léase contra el caso de este reporte.** Un agente que dejó algo a medias en una unidad anterior de la
misma corrida produjo, por definición, **contenido que el snapshot no refleja** —el snapshot se tomó
antes—. La cláusula entonces **no es ambigua ni permisiva: manda detener**, y por la vía de §9, que es
la que menos contexto lleva de las cuatro familias.

**Esto no debilita la cláusula, que resuelve bien su caso**: protege contra editar sobre un entregable
que alguien tocó por fuera del método, y sin ella una edición ciega pisa trabajo ajeno. Lo que muestra
es **dónde está el hueco con precisión de línea**: la cláusula no distingue el contenido que apareció
**por fuera** del método del que puso **el propio agente**, y para los dos manda lo mismo.

**Y muestra que el dato para distinguirlos está en el mismo párrafo.** El snapshot que la cláusula usa
para detectar la diferencia es exactamente el insumo con el que se puede calcular quién la produjo.

### 2.2 Los siete disparadores tampoco lo miran

`Mesa-Rules.md` §7 cierra la lista de lo que se eleva en siete casos, y ninguno nombra la procedencia
del estado. Los siete preguntan **qué clase de decisión es** —ambigüedad de intención, conflicto entre
restricciones duras, cambio de alcance, irreversibilidad, consecuencia externa, empate, reapertura—.
**Ninguno pregunta de dónde salió el hecho.**

**Y la misma sección hace algo que conviene leer con atención, porque es el precedente de lo que este
reporte pide.** §7 **invierte deliberadamente** la asimetría de costos de §8.1 —ante la duda la mesa
**no** escala: aplica el criterio por defecto y lo registra— y lo funda en que *«una consulta de más en
un lote de veinte entrena a firmar el lote sin leerlo»*. **Es exactamente el razonamiento de este
reporte**, aplicado a otra causa. Lo que muestra es que el framework **ya aceptó que la asimetría de
§8.1 no es universal**, y que hay clases de caso donde detener es lo caro. Este reporte sostiene que el
estado propio es otra de esas clases.

### 2.3 El formato de la detención no declara la procedencia, y por eso no es auditable

Los tres bloques de detención del método —el de §8.1, el de ambigüedad de §9 y el de la escalada de
mesa— tienen campos para qué pasó, qué opciones hay, cuál se propone y qué se necesita. **Ninguno tiene
un campo que diga si el hecho es preexistente o lo produjo quien pregunta.**

La consecuencia es que el requisito **no se puede comprobar después**. El único criterio de aceptación
que roza el tema verifica que toda consulta pertenezca a la lista cerrada; no verifica procedencia. Un
auditor tendría que reconstruir la historia de la corrida a mano, que es exactamente el costo que el
propio método midió como *«hubo que abrir los cinco y cruzarlos a mano»*.

### 2.4 La causa que el Product Owner describe no está medida — es una cuarta

El framework tiene **dos** mediciones de consultas que no debieron llegar al humano, y las dos son de
**otras** causas:

| Medición | Qué mide | Causa |
|---|---|---|
| `Mesa-Rules.md` §0.1 | De cinco detenciones, **tres no eran del Product Owner** | **Contenido que ya estaba en el árbol** y que nadie miró antes de preguntar |
| `Memoria-De-Antecedentes-Casos-Resueltos.md` §2.2 | De diez hallazgos en cinco informes, **tres no eran lo que declaraban** | **Hallazgos reenviados** de informe en informe sin reverificar |

**La del Product Owner es una tercera**: el agente **genera** la situación con su acción y la descarga
sin mirar el conjunto de lo que él mismo hizo. Las tres comparten el síntoma y no la causa. **Un
mecanismo diseñado contra las dos medidas no ataca necesariamente la tercera**, y por eso este reporte
la declara como **medición pendiente**: el mecanismo que se proponga tiene que verificarse contra un
caso real de esta clase antes de darse por resuelto.

### 2.5 El agrupamiento ocurre después de la primera salida, no antes

La mesa de evaluación es la pieza que encarna «mirar el conjunto y después afinar», y su propia regla la
distingue del audit por eso. **Pero corre en puntos fijos**: entre dos fases de la reanudación, o en una
fase de la migración.

**Y adentro de la mesa el agrupamiento ya existe, hecho y probado.** `Mesa-Rules.md` §7.1 lo declara sin
vueltas —*«las escaladas se entregan agrupadas al cierre del ciclo, no de a una»*, con las de tipo 2 y 3
como única excepción por bloqueantes— y le agrega el campo `SI NO RESPONDÉS`, que es lo que hace el lote
contestable: el humano contesta las que le importan y sabe qué pasa con el resto.

**Entonces la pieza que §5.4 pide no hay que inventarla: hay que sacarla de donde está encerrada.** Está
escrita, fundada y confinada a la mesa, que corre en puntos fijos.

**Dentro del bucle de fases, en cambio, no hay filtro.** El registro de decisiones pendientes agrupa
**lo que el humano ya difirió** —es decir, agrupa después de que cada consulta ya salió una por una—. No
existe un momento en que las detenciones de una misma fase se miren juntas **antes** de presentarse por
primera vez, ni existe fuera de la mesa el campo que dice qué pasa si no se contesta.

---

## 3. Qué dice hoy el framework, y por qué no alcanza

### 3.1 Lo que resuelve bien, y no hay que tocar

- **La pregunta previa de §8.1 es correcta y su alternativa cara ya fue descartada.** El reporte `13`
  evaluó el eje de tres estratos y lo rechazó con fundamento a favor de una sola línea. **Este reporte
  no lo reabre**: agrega una cláusula **anterior**, no un eje paralelo.
- **La asimetría de costos de §8.1 está bien razonada**: ante la duda se detiene, porque el error barato
  y el caro no son simétricos. Es el principio que este reporte propone **reutilizar**, no cambiar.
- **La lista cerrada de siete disparadores hace su trabajo.** El problema no es que admita de más: es
  que se la consulta después de una pregunta que ya dejó pasar el caso.
- **El método ya archiva el estado previo antes de despachar cada unidad.** La pieza existe, funciona y
  se toma siempre. **Lo que no hace es usarse para esto.**
- **La mesa declara su condición de convocatoria y no una lista de puntos**, y lo justifica con un caso
  real que una lista fija habría dejado afuera. Es la forma correcta, y **es la razón por la que este
  hueco no se arregla agregando un punto de invocación más**.

### 3.2 Lo que no está

**a) No hay una pregunta sobre la procedencia del estado.** La decisión de elevar se toma con un solo
eje —si el árbol responde— y ese eje **no puede distinguir** «el árbol no lo dice porque nadie lo
decidió» de «el árbol no lo dice porque yo no lo escribí».

**b) La tabla de autocorrección tiene dos filas y el caso necesita tres.**

**c) Ningún formato de detención declara la procedencia**, de modo que el requisito no tiene criterio de
aceptación enumerable.

**d) El agrupamiento llega tarde.** Lo que se mira junto es lo ya diferido, no lo que está por salir.

**e) Y el dato que resolvería (a) y (c) ya se toma.** El estado previo archivado antes de despachar
permite **calcular** la procedencia en lugar de preguntarla. Ninguna regla lo usa para eso.

---

## 4. El hueco, en una frase

**La decisión de elevar algo al humano se toma preguntando si el árbol tiene la respuesta, y nunca
preguntando quién produjo el estado por el que se pregunta; de modo que un estado que el propio agente
dejó a medias —que por construcción no está en el árbol— es indistinguible de una consulta legítima, y
el dato que los separaría ya se archiva antes de cada despacho sin que ninguna regla lo lea.**

---

## 5. Qué se propone evaluar

**Ninguna es una propuesta de redacción: son las preguntas que el framework tiene que contestar.**

### 5.1 La cláusula que falta, y dónde va

¿Corresponde una pregunta **anterior** a la pregunta previa —«¿la situación la generó el propio agente,
en esta unidad o en una sin cerrar de esta corrida?»— tal que, si la respuesta es sí, **no se evalúe
contra el árbol** sino contra la autocorrección, y sólo se eleve si de por sí constituye un arbitraje o
una reapertura?

### 5.2 La tercera fila de la autocorrección

¿Corresponde una fila para el estado a medias que el propio agente produjo, cuya resolución sea **el
agente mirando el conjunto de lo que produjo** y no el punto donde tropezó, y que se declare en el
cierre como una autocorrección con su alcance ampliado a las unidades tocadas?

### 5.3 El origen del hecho: **derivado, no declarado**

**Es la pregunta decisiva, y tiene una trampa que conviene nombrar.** Si el campo lo llena el agente,
**un agente que no se dio cuenta de que generó el problema va a declarar «preexistente» de buena fe**, y
el requisito queda cumplido en la forma y no en el fondo — el mismo modo de falla que el método ya midió
dos veces como «confirmaciones que se leen como verificación sin serlo».

**Pero el dato ya existe, y la cláusula que lo usa también.** El estado previo se archiva antes de
despachar cada unidad, y §8 ya compara el entregable contra ese snapshot para detectar diferencias
(§2.1.1). Entonces el origen del hecho se **calcula** con la comparación que ya se hace: si el hecho que
originó la detención no está en el snapshot tomado antes de esta unidad, es **propio**, **diga lo que
diga el agente**. ¿Corresponde definirlo así, y **ante la duda declararlo propio**, por la misma
asimetría de costos que el método ya usa para decidir si detiene?

**El nombre del campo queda abierto.** §2.1 verificó que `procedencia` no colisiona en estas secciones,
así que la elección es de la intervención y no una restricción de este reporte.

### 5.4 El agrupamiento antes de la primera salida

¿Corresponde que el registro agrupe **toda** detención producida durante la fase en curso —no sólo lo
diferido— y que la cláusula de §5.1 se aplique **sobre el lote completo** antes de presentarlo, de modo
que dos consultas que se resuelven entre sí no lleguen separadas?

**La pregunta concreta, y es más barata de lo que parece: ¿corresponde generalizar `Mesa-Rules.md` §7.1
fuera de la mesa?** Su forma —lote al cierre, excepción para lo bloqueante, campo `SI NO RESPONDÉS`— ya
está escrita y fundada. Lo que hay que decidir es si el bucle de fases de `Master-Prompt.md` §7 la
hereda, y qué es «lo bloqueante» ahí.

### 5.5 El criterio de aceptación enumerable

¿Corresponde un criterio con la forma del que ya existe para la lista cerrada: **ninguna detención con
procedencia propia sale sin declarar por qué la autocorrección no alcanzaba**?

---

## 6. Lo que este reporte no afirma

- **No reabre el reporte `13`.** La pregunta previa de una sola línea es correcta; lo que se propone es
  una cláusula anterior, no un eje de estratos.
- **No propone un rol nuevo.** El orquestador que hoy exhibe el registro al cerrar cada fase, y el
  presidente de mesa cuando la mesa corre, ya tienen ese mandato. Sumar una figura duplicaría uno
  existente.
- **No afirma que las dos mediciones existentes estén mal.** Miden bien otras dos causas. Lo que afirma
  es que la tercera no está medida, y que por eso el mecanismo que se diseñe tiene que verificarse
  contra un caso real de esta clase.
- **No afirma que los agentes actúen de mala fe.** El modo de falla que describe es el contrario: **el
  agente que no se dio cuenta**, que es precisamente por lo que la procedencia no puede depender de su
  declaración.

---

## 7. Cómo verificar que la corrección funcionó

1. **Reproducir el caso.** En una corrida real, provocar que un agente deje un estado a medias en una
   unidad y encuentre ese estado en la siguiente. Comprobar si la consulta llega al humano.
2. **Comprobar que la procedencia se calcula.** Tomar una detención cualquiera y verificar que su
   procedencia se puede reproducir contrastando el hecho contra el estado archivado antes del despacho,
   **sin leer lo que el agente declaró**.
3. **Contar.** En una corrida con la corrección aplicada, contar detenciones con procedencia propia.
   **Si la cuenta es cero, la corrección no está funcionando**: ningún agente se autoincrimina, y ese
   número es el síntoma de que el campo se está autoinformando.
4. **Comprobar el agrupamiento.** Verificar que, al cerrar una fase, el lote presentado contiene todas
   las detenciones de esa fase y que ninguna salió antes por su cuenta.
5. **El criterio de §5.5, enumerable**: ninguna detención con procedencia propia sin su declaración de
   por qué la autocorrección no alcanzaba.

---

## Control de cambios

| Versión | Fecha | Cambios | Autor |
|---|---|---|---|
| 1.0 | 2026-09-12 | Emisión inicial. Documenta que la decisión de elevar se toma por **un solo eje** y que un estado producido por el propio agente **no tiene respuesta en el árbol por construcción**. Su propuesta central —que la procedencia se **derive del estado previo ya archivado** en vez de declararse— la levantó el refutador del ciclo 4 al atacar la versión autoinformada, que habría dejado el requisito cumplido en la letra. Declara además que la causa que lo origina es una **tercera medición pendiente**, distinta de las dos que el framework ya midió. | Mesa R1.5, ciclo 4 (AH-008 disciplina de escalada; corrección del refutador), sobre un requisito del Product Owner |
| 1.1 | 2026-09-12 | **Correcciones levantadas al verificar las citas contra SDD 13.10**, antes de intervenir. **(a)** Se deja constancia de que el término **`procedencia` ya está tomado** por el framework con otro significado, **y de que acá no colisiona**: las 14 ocurrencias de `Master-Prompt.md` están en §0, §2.1, §3, §5 y §7, y ninguna en §8, §8.1 ni §9. La verificación se hizo porque `Vocabulario-Rules.md` §9.4 declara que **desambiguar sin verificar la colisión es el defecto**, y la primera redacción de esta versión afirmaba la colisión sin medirla — el mismo falso positivo que esa regla nombra. El campo se llama `origen del hecho` por claridad, no por obligación. **(b)** Aparece **§2.1.1**, la cláusula que convierte el hueco en obligación y que la v1.0 no había citado: `Master-Prompt.md` §8, bloque `Estado previo del entregable`, manda *«si al abrir el entregable encontrás contenido que el snapshot no refleja, detenete y devolvelo como ambigüedad según §9, sin editar»* — y un estado que el propio agente dejó a medias **es** contenido que el snapshot no refleja. El hueco queda localizado con precisión de línea, y en el mismo párrafo está el insumo que lo resuelve. **(c)** El agrupamiento de §5.4 **no hay que inventarlo**: `Mesa-Rules.md` §7.1 ya lo hace, con su campo `SI NO RESPONDÉS`, y está confinado a la mesa; y §7 **ya invirtió la asimetría de §8.1** con el mismo razonamiento que este reporte, lo que prueba que el framework no la considera universal. | Verificación previa de la intervención `04` |
| 1.2 | 2026-09-12 | **Corrección de una cita propia, levantada por el refutador de la mesa del 2026-09-12 y verificada contra el árbol**: §2.1 citaba `Migracion-Rules.md` **§4.7** como el lugar donde `procedencia` colisiona, y §4.7 —«La revisión de apartamientos»— **no tiene una sola ocurrencia** del término. Las que hay viven en §4.5, §4.6 y la checklist de §6. Es la tercera cita de sección equivocada de esta serie de trabajo, todas del orquestador y todas detectadas por relectura ajena, que es exactamente el dato que el reporte `28` mide. | Refutación del ciclo 5 |

