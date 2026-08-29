# Reporte 18 — Un mecanismo se cablea a los puntos donde nació, y no a la condición que lo hace necesario

| Campo | Valor |
|---|---|
| Reporte | 18 |
| Fecha | 2026-08-29 |
| Origen | **Tres corridas reales de la mesa de evaluación** sobre el destino `RPI.VideoControl`, el 2026-08-27, durante la reanudación posterior a la migración normativa 9.18 → 13.3. La tercera **se convocó fuera de los tres puntos que el framework declara**, porque el caso más caro del destino no tenía ninguno |
| Versión del framework evaluada | SDD **13.7** (`Mesa-Rules.md` 1.0, `Master-Prompt-Reanudacion.md` §3.1, `Master-Prompt-Migracion.md` M1) |
| Artefactos del framework alcanzados | `SDD/Devs/Rules/Mesa-Rules.md` §0, §2.1 y §6.7; `SDD/Devs/Orchestrator/Master-Prompt-Reanudacion.md` §3.1.1; `SDD/Devs/Orchestrator/Master-Prompt-Migracion.md` M1 |
| Naturaleza | Un hueco **en el cableado y no en el mecanismo**. El análisis que creó la mesa enunció su momento como una **condición**; la intervención codificó **los dos prompts donde esa condición ocurría**, y el resto de los casos que la satisfacen quedaron sin quién los convoque |
| Estado | **ABIERTO** |
| Reportes relacionados | `16`, que este reporte **no reabre**: su corrección —el banco de casos— funcionó y se midió funcionando en estas tres corridas. Y el ítem diferido de `CHANGELOG.md` **13.7**, cuyo evento de cierre era «la primera corrida real»: **este reporte lo cierra con medición**, en §3.4 |

## Tabla de contenido

- [1. Resumen](#1-resumen)
- [2. Lo que el framework ya resuelve bien](#2-lo-que-el-framework-ya-resuelve-bien)
- [3. La evidencia](#3-la-evidencia)
- [4. La causa raíz](#4-la-causa-raíz)
- [5. El patrón, enunciado](#5-el-patrón-enunciado)
- [6. Propuestas de intervención](#6-propuestas-de-intervención)
- [7. Cómo verificar que la corrección funcionó](#7-cómo-verificar-que-la-corrección-funcionó)
- [8. Tres hallazgos menores del mismo origen](#8-tres-hallazgos-menores-del-mismo-origen)

## 1. Resumen

**La mesa de evaluación funciona, y el framework la dejó donde no se la puede llamar.**

`Mesa-Rules.md` §0 declara que los orquestadores la invocan «en un punto declarado», y los puntos son
tres: **R1.5** de la reanudación, **M1** de la migración cuando la invocación es directa, y
explícitamente **nunca** en la generación desde cero. Ninguno de los tres alcanza al caso donde el
mecanismo más rinde: **un `P0` abierto que rondas sucesivas de auditoría no logran cerrar.**

En el destino que originó este reporte, ese caso costó **ocho rondas** sin que el contador de corte de
`Master-Prompt.md` §10.1 arrancara nunca. Cuando por fin corrió una mesa sobre él —convocada **fuera
de norma**, porque no había otra forma—, resolvió en una corrida lo que ocho auditores independientes
no habían visto: **el criterio de corte pide una propiedad que ningún informe registra**, de modo que
una ronda limpia no sería demostrable como limpia. Ocho rondas no podían encontrarlo porque cada una
miraba su ronda; la mesa lo encontró porque miró **las ocho como corpus**.

**La causa no es que falte un cuarto punto de invocación.** El análisis que creó la mesa enunció su
momento correctamente, y como una **condición**: *«después de leer el estado, antes de aprobar el
plan»*. La intervención de la 13.7 cableó esa condición a **los dos prompts donde ocurría en agosto de
2026**. Todo caso futuro que satisfaga la condición sin pasar por esos dos prompts queda afuera, y no
por una decisión: por una omisión de forma.

**Agregar el punto que faltó sería repetir el mecanismo del defecto.** Lo que corresponde es declarar
la condición y dejar que los puntos se deriven de ella.

## 2. Lo que el framework ya resuelve bien

**Esta sección existe para delimitar qué no hay que reescribir**, y en este reporte es más larga de lo
habitual porque casi todo el diseño se sostuvo contra tres corridas reales.

**El momento está bien razonado, y sus tres argumentos resistieron.**
`Etapa-Preplanificadora-Analisis-Y-Decision.md` §4.1 los declara: *antes no se puede* —el contrato de
entrada es la salida de R0—, *después es tarde* —elegir sin saber si el corpus se sostiene es elegir
sobre la mitad de la información— y *es el único punto donde una corrida sirve a las cinco salidas*.
Los tres se verificaron: el ciclo 2 alimentó la salida A con su plan de parches, y el ciclo 3 alimentó
una decisión de cierre que ninguna de las cinco salidas contemplaba.

**El mecanismo funciona, y la parte que más se dudaba es la que mejor rindió.** El **refutador** de
§5.1 —el rol que entra último y ataca la lectura dominante— desarmó tres hallazgos en el ciclo 3,
**dos de ellos favorables a quien lo convocó y uno acusatorio**. Sin él, dos `P0` falsos habrían
fundado trabajo.

**La ceguera de §5.3 produjo exactamente lo que promete.** En el ciclo 2, dos especialistas
independientes llegaron a lecturas incompatibles del mismo archivo, y §6.3 lo trata como evidencia
`E2` de que el texto admite dos lecturas. Lo era: **nueve identificadores nombraban dos historias
distintas**, y el instrumento del destino no podía verlo. Sin ceguera, el segundo habría confirmado al
primero.

**La escala de ancla de §6.1 hizo su trabajo.** Ningún hallazgo de clase `C` fundó un parche en las
tres corridas, que es la línea que §6.1 no admite cruzar.

**Y la corrección del reporte `16` —el banco de casos de §10.0— se midió funcionando.** En el ciclo 2
detectó un defecto **en los parches de la propia mesa**; en el ciclo 3 detectó que uno de sus casos
había quedado anclado a una versión que la mesa acababa de subir. Es lo que un banco tiene que hacer.

**Nada de esto se propone tocar.**

## 3. La evidencia

### 3.1 El caso que no tenía quién lo convocara

El destino llevaba **ocho rondas de auditoría** sobre la misma migración, todas RECHAZADO, sin que el
criterio de §10.1 —dos rondas seguidas sin hallazgo interpretativo— llegara a arrancar. El cierre de
la séptima lo diagnostica en sus propias palabras:

> *«La migración no está en condiciones de cerrarse, y no por lo que le falta sino por cómo se está
> reparando. Tres de los últimos cuatro `P0` no vinieron del árbol 9.18: los produjo el pull request
> que venía a cerrarlo.»*

**Ninguno de los tres puntos de invocación alcanza a ese estado.** No hay una reanudación en curso
—la del día ya había pasado por R1.5—, no hay una migración que se invoque directa —está corriendo
desde hace días— y no es una generación desde cero. El mecanismo existía, el caso lo pedía, y **no
había quién lo llamara**.

Se convocó igual, fuera de norma, porque el Product Owner lo pidió con estas palabras: *«plantearía la
mesa de evaluación para analizar y debatir cerrar el problema, antes de lanzar rondas sin
planificar»*.

### 3.2 Lo que encontró, y por qué ocho rondas no podían encontrarlo

| Hallazgo | Por qué el audit por rondas no lo alcanza |
|---|---|
| **El criterio de corte pide una propiedad que ningún informe registra.** §10.1 corta por «hallazgo de la clase interpretativa»; §10 punto 6 exige una **marca de detectabilidad** en cada hallazgo. `grep -ric "detectab\|interpretativ"` sobre los siete informes devuelve **0** | Es una propiedad **de la serie de informes**, no de ninguno. Un auditor invocado desde cero ve su ronda |
| **La condición de cierre está enunciada cuatro veces y las cuatro dicen cosas distintas**, y ni «ronda limpia» ni «hallazgo interpretativo» están definidos en el destino | Cada enunciado vive en un artefacto distinto. Sólo se ve cruzándolos |
| **El rendimiento no decae**: 16 · 12 · 12 · 13 · 16 · 12 · 14 · ≥8 | Es una serie. Ninguna ronda la ve |
| **La válvula de §10.1 —cuatro rondas y la decisión sube al humano— venció y nadie la ejerció.** `grep 'cerró por decisión'` sobre los siete informes: **cero** | Ídem |

La salida no fue un veredicto sino un plan: **no despachar la novena ronda y cerrar por decisión**, con
la alternativa razonable declarada. El Product Owner la adoptó. Ocho rondas habían producido ocho
veredictos y ningún plan.

### 3.3 Y la condición sí se satisfacía

El momento que el análisis declara —*«después de leer el estado, antes de aprobar el plan»*— **se
cumplía exactamente**: el estado estaba leído por la reanudación del mismo día, y lo que había que
aprobar era el plan de cómo cerrar la migración. **La condición se cumplía y el cableado no la
alcanzaba**, que es la forma precisa del defecto.

### 3.4 Lo que cierra el ítem diferido de la 13.7

`Etapa-Preplanificadora-Analisis-Y-Decision.md` §6 dejó un ítem diferido con los cuatro campos de
`Root-Rules.md` §12.2, declarado en el `CHANGELOG.md` del framework en la entrada **13.7**. Su evento
de cierre: **la primera corrida real**. Lo que había que medir estaba escrito: *«hallazgos procedentes
sobre convocados, y detenciones presentadas al humano antes y después»*.

**Hubo tres corridas. Las mediciones:**

| | Ciclo 1 | Ciclo 2 | Ciclo 3 |
|---|---|---|---|
| Especialistas que emiten | sin registro | 8 | 5 |
| Hallazgos procedentes | sin registro | **39** | **29** |
| Procedentes por especialista | — | **4,9** | **5,8** |
| Parches con texto exacto | 2 medidos | **13** | **7** |
| Especialidades con aporte nulo | — | **0** | **0** |
| Detenciones al humano | — | **6, en lote y con default** | **1** |

**Las cuatro lecturas que el diferido pedía:**

1. **El panel produce, y no es teatro deliberativo.** El modo de falla que §6 declaraba vigilar —*«un
   panel que produce actas y ningún parche»*— **no ocurrió**: 20 parches con texto exacto y criterio
   de verificación entre las dos corridas registradas.
2. **El criterio de señales de §5.2 está bien calibrado.** Cero especialidades con aporte nulo en las
   dos corridas, contra la regla de no reconvocatoria de §5.5.
3. **Las detenciones cambiaron de forma, que era el objetivo.** La medición que originó el mecanismo
   era *cinco detenciones, tres de ellas con respuesta en el árbol*. En el ciclo 2 fueron **seis, en
   lote, con default declarado y aplicado**, y el Product Owner **no contestó ninguna** — que es una
   respuesta válida y por diseño, porque cada una declara qué pasa si no se responde. En el ciclo 3
   fue **una sola**.
4. **El tope de cinco variables de §5.5 se ejerció y se registró.** Cuatro especialidades quedaron
   postergadas por cupo en el ciclo 2, con su motivo, y siguen registradas.

**El ítem diferido se puede cerrar.** Y con una advertencia que la medición agrega y el análisis no
anticipaba: **el rendimiento por especialista no cae entre corridas** —4,9 y 5,8—, lo que sugiere que
el corpus tenía mucho más de lo que una sola corrida agota. `Mesa-Rules.md` §6.7 corta el ciclo por
§10.1; con estos números, **el corte va a llegar por decisión y no por criterio de forma sistemática**,
igual que le pasó al audit por rondas. Es la misma clase de defecto un nivel más arriba, y conviene
mirarlo antes de que cueste ocho ciclos.

### 3.5 La contraprueba: dónde el mecanismo se equivocó

**Dos veces, en la misma dirección, y las dos las destapó el Product Owner con una pregunta.**

**Primera.** El ciclo 3 elevó como `P0` que cuatro filas del plan de migración declaraban «pendiente
de respuesta humana». Es la columna **«Fuente de contenido»** que `Migracion-Rules.md` §2.1 define
como *de dónde sale el contenido*, escrita al planificar. **No es un campo de estado.** La fase que
las gobernaba las había resuelto tres días antes. El `P0` se renivelo a `P1` después de que el humano
preguntara *«la capacidad y las fechas de qué»*.

**Segunda.** Al ir a buscar esos campos apareció que el documento que los declaraba indisponibles
afirmaba que *«ninguna de las dos cifras existe en ninguna parte del árbol»*, sobre cuatro planes con
su columna de estimación **completa en las 47 tareas técnicas**. Nadie las había sumado. La mesa había
dado por buena la declaración, dos veces.

**Por qué esto refuerza el reporte en lugar de debilitarlo.** Las dos son el mismo error —**confiar en
una fuente declarativa sin contrastarla**—, que es el anti-patrón que `Master-Prompt-Reanudacion.md`
§7 nombra **primero**. El mecanismo lo comete porque **su contrato de entrada (§4) le prohíbe relevar
el estado por su cuenta**, con un fundamento correcto: una mesa que releva duplica R0 y puede
contradecirlo. Lo que falta no es permitirle relevar: es **obligarla a contrastar la fuente que le
entregan cuando funda un `P0`**. La regla existe para el destino y no para la mesa.

## 4. La causa raíz

**El análisis enunció una condición y la intervención codificó los lugares donde esa condición
ocurría.**

`Etapa-Preplanificadora-Analisis-Y-Decision.md` §4 es explícito, y es correcto:

> **«El momento es uno: después de leer el estado, antes de aprobar el plan.»**

Y aclara por qué parecían dos: *«Son el mismo momento visto desde dos prompts. El método ya tiene el
artefacto que los une: el plan de migración es el contrato entre el orquestador de generación y el de
migración»*.

**El razonamiento es de condición. El cableado de §4.2 es de enumeración**: R1.5 en la reanudación,
M1 en la migración. Y §4.3 enumera los tres lugares donde **no** se convoca. Entre las dos listas
—dónde sí y dónde no— quedó un espacio que ninguna cubre: **todo caso que satisface la condición y no
pasa por esos dos prompts.**

**No fue una decisión: fue un efecto de la forma.** En agosto de 2026 los únicos dos prompts que leían
estado y aprobaban plan eran ésos, de modo que enumerarlos y declarar la condición **producían la
misma lista**. La diferencia sólo se vuelve visible cuando aparece el tercer caso — y apareció ocho
días después.

**Y hay una segunda cara del mismo defecto, en la dirección contraria.** §0.3 declara que la mesa
*«no corre sobre un destino vacío»*, con fundamento: sin corpus previo no hay nada que refutar. De ahí
§4.3 derivó *«no se convoca en la generación desde cero»*. **Las dos afirmaciones no son la misma.**
Un destino deja de estar vacío apenas la primera fase produce algo, y a partir de ahí la generación
tiene corpus previo y **nadie lo mira como conjunto**: el audit de §10 corre fase por fase, sobre lo
que se acaba de producir. La condición correcta —*hay corpus previo que refutar*— se convirtió en una
exclusión categórica de un orquestador entero.

## 5. El patrón, enunciado

> **El framework declara CUÁNDO se convoca un mecanismo, y no QUÉ CONDICIÓN lo hace necesario.**
>
> Cuando un mecanismo se especifica por los puntos donde nació en lugar de por la condición que lo
> pide, la especificación es correcta el día que se escribe —los puntos y la condición coinciden— y se
> vuelve incompleta en cuanto aparece un caso que satisface la condición desde otro lugar. El defecto
> **no se manifiesta como error**: se manifiesta como ausencia, y su síntoma es que el caso más caro
> queda sin quién lo atienda mientras el mecanismo que lo resolvería existe y está probado.
>
> **Y se agrava por su propia corrección.** Agregar el punto que faltó restaura la coincidencia entre
> la lista y la condición **hasta el siguiente caso no previsto**, de modo que cada corrección deja el
> defecto exactamente donde estaba.

**El patrón no es exclusivo de la mesa**, y por eso se enuncia así. Alcanza a todo mecanismo del
método que declare puntos de invocación en lugar de una condición: el audit entre fases, el barrido de
pendientes, la compuerta de arranque. La pregunta que el patrón obliga a hacerle a cada uno es la
misma: **¿está escrito cuándo hace falta, o sólo dónde se llama?**

## 6. Propuestas de intervención

**Punto de partida, no decisión tomada.**

### 6.1 Declarar la condición de convocatoria, y derivar los puntos de ella

En `Mesa-Rules.md` §0, junto a la declaración de que los orquestadores la invocan «en un punto
declarado», entra la condición:

> **La mesa se convoca cuando se cumplen las tres:** existe **corpus previo** que no fue producido en
> esta corrida; el **estado ya está leído** y disponible como contrato de entrada de §4; y hay **un
> plan por aprobar o una decisión de alcance por tomar** sobre ese corpus.
>
> Los puntos de invocación de los orquestadores **son casos de esta condición y no su definición**. Un
> caso que la cumple y no tiene orquestador que la convoque **se convoca igual**, y el registro declara
> desde dónde.

Con eso, los tres puntos actuales quedan como ejemplos y el caso de §3.1 queda cubierto sin agregar un
cuarto.

### 6.2 Corregir la exclusión de la generación, que es la otra cara

§0.3 y `Master-Prompt-Reanudacion.md` §3.1.1 declaran que no se convoca en la generación desde cero.
Lo correcto es lo que §0.3 ya dice —**no corre sobre un destino vacío**— sin la derivación categórica:
una generación que lleva varias fases cerradas **tiene corpus previo**, y hoy nadie lo mira como
conjunto.

**Y hay un límite que hay que escribirle**, o esto duplica el audit: la mesa mira **lo que ya existía
al abrir la corrida**, no lo que la fase acaba de producir. Es la frontera que §0.2 ya declara; lo que
falta es decir que sigue valiendo dentro de una generación.

### 6.3 Obligar a contrastar la fuente cuando funda un `P0`

Es la corrección de §3.5, y es acotada. En `Mesa-Rules.md` §6.1, junto a la escala de ancla:

> **Un hallazgo de nivel `P0` cuya ancla es una fuente declarativa del contrato de entrada exige
> contrastarla contra su observable antes de proceder.** Una fila de plan, una casilla de checklist o
> un campo de estado son afirmaciones sobre el trabajo, no el trabajo. La mesa no releva el estado
> —§4 se lo prohíbe— pero **sí abre la fuente que va a citar**.

Los dos errores medidos habrían sido detenidos por esta regla, y ninguno de los 68 hallazgos restantes
se ve afectado.

### 6.4 Lo que este reporte NO propone

- **No propone un cuarto orquestador.** La decisión de §3 del análisis —mecanismo y no orquestador—
  se sostuvo en tres corridas.
- **No propone que la mesa releve el estado.** El fundamento del contrato de entrada es correcto.
- **No propone tocar el panel, el jurado, el cuerpo de parches ni la escala de ancla**, que se
  midieron funcionando.

## 7. Cómo verificar que la corrección funcionó

| # | Criterio | Cómo se mide |
|---|---|---|
| 1 | La condición está declarada y los puntos derivan de ella | `Mesa-Rules.md` §0 enuncia las tres cláusulas, y los tres puntos actuales figuran como **casos** y no como definición |
| 2 | Un caso que cumple la condición sin orquestador **se convoca** | Se toma el caso de §3.1 —un `P0` que las rondas no cierran— y se recorre la regla: tiene que resolver a «se convoca», sin agregar ningún punto nuevo |
| 3 | La generación deja de estar excluida categóricamente | §0.3 y `Master-Prompt-Reanudacion.md` §3.1.1 distinguen «destino vacío» de «generación», y declaran el límite contra el audit de fase |
| 4 | Un `P0` anclado en una fuente declarativa exige su contraste | Se inyecta un hallazgo `P0` cuya única ancla es una fila de plan, y el ciclo tiene que rechazarlo o exigir el contraste. **Es un caso de banco**, y por el reporte `16` entra con su prueba |
| 5 | El ítem diferido de la 13.7 queda cerrado con su medición | El `CHANGELOG.md` declara el cierre citando §3.4 de este reporte, con las cifras y **con la advertencia sobre el criterio de corte del ciclo** |

## 8. Tres hallazgos menores del mismo origen

**Los tres los produjo la propia mesa al usarse más de lo previsto**, y ninguno es del destino: son
huecos de `Mesa-Rules.md` que sólo aparecen con volumen.

### 8.1 La regla no gobierna el espacio de nombres de sus propios hallazgos

`Mesa-Rules.md` §6.1 fija el **nivel** y la **clase de ancla** de cada hallazgo, y no dice nada sobre
su identificador. En el destino, la tabla de deuda del ciclo 2 usó la familia `M`, que ya nombraba los
hallazgos de dos informes de migración: **`M-01` quedó con cuatro significados distintos** en la misma
carpeta. La colisión precedía a la mesa y la mesa la agravó, y ninguna comprobación mecánica podía
verla.

**Corrección propuesta:** §2.2 declara que el registro lleva un **prefijo propio del ciclo**, y que
ningún identificador de hallazgo de mesa reusa una familia ya presente en la carpeta de auditoría.

### 8.2 La forma del nombre no admite dos ciclos el mismo día

§2.1 fija `SDD/Docs/Audit/Mesa-<AAAA-MM-DD>.md`. El destino corrió **tres ciclos el 2026-08-27**, y el
tercero tuvo que apartarse de la forma. Con la corrección de §6.1 de este reporte —que hace la
convocatoria más frecuente— el caso deja de ser excepcional.

**Corrección propuesta:** sufijo de ciclo cuando hay más de uno por fecha.

### 8.3 §6.7 reusa §10.1 y quedan dos contadores vivos sobre la misma regla

§6.7 declara, correctamente, que el criterio de corte del ciclo **no se inventa: es el de
`Master-Prompt.md` §10.1**. Pero §10.1 también gobierna el cierre de una fase por rondas de auditoría.
En el destino quedaron **dos contadores simultáneos** —uno de rondas de migración, en ocho; otro de
ciclos de mesa, en uno— y **ningún artefacto declara cuál gobierna qué**. Un especialista lo levantó
como `P1` acusando al registro de mesa de certificar una migración; el refutador tuvo que abrir §6.7
para dirimir que el registro estaba aplicando la regla **a su propio ciclo**, que es lo que corresponde.

**Que un panel independiente lo lea mal es la medición del defecto.**

**Corrección propuesta:** §6.7 declara explícitamente que el contador del ciclo de mesa **es propio y
no acumula con el de las rondas de audit**, y que el registro lo nombra al cerrar.

---

**Fin del reporte 18.**
