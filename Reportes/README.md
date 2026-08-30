# Reportes de evidencia sobre el Framework SDD

**Documento:** README.md
**Versión:** 1.19
**Fecha:** 2026-08-30
**Estado:** **Serie reabierta** — diecisiete reportes (`00` a `16`) **RESUELTOS**, y el **`18` RESUELTO en SDD 13.8**, primer reporte contra la mesa de evaluación, el primero que **cierra un ítem diferido del propio framework con medición** (`CHANGELOG.md` 13.7) y el primero que **declara un criterio de aceptación cumplido a medias** en lugar de darlo por resuelto. Los tres hallazgos ya medidos en la migración de `Lab-Geometria` esperan su reporte y conservan el **`17`**. La serie **no se reanaliza**: ver «Línea de corte». Un reporte nuevo evalúa **SDD 12.1 o posterior**
**Cierre:** los doce primeros, sobre **SDD 7.0** (2026-08-15), como una sola intervención. Los siguientes, de a uno: el `13` en **9.19**, el `14` en **10.0** y **11.0** —dos intervenciones, porque la primera dejó un criterio sin auditar— y el `15` en **10.1**, el `16` en **13.6** y el `18` en **13.8**

Índice de los reportes de hallazgos contra el `Framework SDD`, escritos para ser **insumo de prompts de intervención sobre el framework**. Ninguno modifica el framework: cada uno documenta un hueco con evidencia reproducible, para que la corrección se decida con datos y no con impresiones.

## Cómo se usan

Un prompt que vaya a intervenir el framework cita el reporte por su número y usa sus secciones así:

| Sección del reporte | Para qué sirve en el prompt |
|---|---|
| Los incidentes | Evidencia de que el hueco produce defectos reales, no hipotéticos |
| Lo que la normativa dice y lo que no dice | Delimita qué no hay que reescribir. Todos los reportes son explícitos sobre lo que el framework ya resuelve bien |
| La causa raíz | Impide que la corrección ataque el síntoma |
| **El patrón, enunciado** | Es lo que hay que corregir. Está escrito en forma general a propósito, para que la intervención no se limite al caso que lo reveló |
| Propuestas de intervención | Punto de partida, no decisión tomada |
| Cómo verificar que la corrección funcionó | Criterio de aceptación de la intervención |

## Los reportes

| # | Título | Patrón que captura | Origen |
|---|---|---|---|
| [00](00-Regla-Transcripción.md) | Regla de transcripción | El framework exige transcribir de fuentes y no declara qué obliga la transcripción; una corrección en la fuente no llega al artefacto que la copió | Fase A |
| [01](01-Ambito-De-Unicidad-De-Identificadores.md) | Ámbito de unicidad de los identificadores | El framework declara la forma de sus identificadores y no su ámbito de unicidad; en un producto multiproyecto alguien decide sin saber que hay una decisión que tomar | Fase B |
| [02](02-Propagacion-De-La-Fase-B2.md) | Propagación de la Fase B2 | Una fase iterativa con propagación puntual acumula distancia entre lo aprobado y lo documentado; y una matriz de propagación cerrada convierte cada caso no previsto en omisión silenciosa | Fase B2 |
| [03](03-Conjuntos-Cerrados-Entre-Categorias.md) | Conjuntos cerrados entre categorías | Dos categorías pueden afirmar cosas incompatibles sobre el mismo conjunto; el framework tiene trazabilidad pero no arbitraje, y ningún audit cruza categorías buscando contradicciones | Fase B2 |
| [04](04-Recuentos-Declarados-En-Prosa.md) | Recuentos declarados en prosa | El framework escribe datos derivados con la misma forma que los datos declarados, no exige que nombren su fuente y no los verifica; el defecto es silencioso y se detecta por casualidad | Fases A, B y B2 |
| [05](05-Ancho-De-Los-Identificadores.md) | Ancho de los identificadores | El framework fija el ancho como convención de forma, sin declarar de qué colección es función ni qué hacer al agotarse el rango; la tabla que define como derivada de todas las otras es la que con más seguridad desborda | Fase B2 |
| [06](06-Obligatoriedad-Por-Tipo-Sin-Condicion.md) | Obligatoriedad por tipo sin condición | El framework decide qué artefactos son obligatorios por el tipo del proyecto, que describe su forma, cuando lo que la determina es una responsabilidad que en un producto multiproyecto se reparte; las dos salidas que deja para cumplir la letra producen peor documentación que el incumplimiento | Fase C |
| [07](07-Obligacion-Hacia-Una-Fase-Posterior.md) | Obligación hacia una fase posterior | Una regla de categoría obliga a referenciar un artefacto que otra categoría emite en una fase posterior, hasta cinco más adelante; el framework ordena las fases por dependencia de contenido y no comprueba ese orden contra las obligaciones que sus propias reglas declaran | Fases D y E |
| [08](08-El-Sprint-Es-Del-Equipo-Y-La-Categoria-Es-Del-Proyecto.md) | La iteración es del equipo y la categoría es del proyecto de código | El framework declara el nivel de aplicación por categoría; cuando una categoría contiene artefactos de dos niveles, los del nivel equivocado se replican por proyecto de código y dejan de medir lo que su nombre dice | Fase D |
| [09](09-El-Audit-Como-Unica-Compuerta.md) | El audit como única compuerta | El framework verifica cada fase con un solo instrumento —un lector independiente— y lo aplica igual a propiedades enumerables y a propiedades interpretativas; las primeras consumen la atención que sólo las segundas necesitan, y el método no declara criterio de corte para las rondas | Fase E |
| [10](10-Criterios-Que-Se-Satisfacen-Trivialmente.md) | Criterios que se satisfacen trivialmente | Los criterios de aceptación preguntan si una declaración está presente y no si es verdadera; el único que pregunta por la relación cuenta lo que falta, de modo que una declaración falsa lo ayuda a cumplirse | Fase G |
| [11](11-El-Vocabulario-Del-Metodo-No-Tiene-Glosario.md) | El vocabulario del método no tiene glosario | El framework acuña vocabulario propio fuera de los seis términos que su regla gobierna y no lo declara en ningún glosario suyo; el criterio que exige declararlo está replicado en once reglas que mandan a nueve destinos distintos, y una de ellas ya enuncia la política correcta sobre términos que no la necesitaban | Fase G |
| [12](12-La-Compuerta-Declarada-Y-La-Compuerta-Ejecutada.md) | La compuerta declarada y la compuerta ejecutada | El método declara una compuerta y no comprueba que se haya corrido; una compuerta que nadie ejecuta se lee igual que una que pasó | Migración de un destino real |
| [13](13-El-Estrato-Del-Hallazgo-Y-La-Legitimidad-De-La-Detencion.md) | El estrato del hallazgo y la legitimidad de la detención | El framework clasifica **cómo** se verifica un hallazgo y no **quién** puede cerrarlo; medido en una corrida real, tres de cinco detenciones llevadas al humano no eran del humano | Fase M6 de una migración real |
| [14](14-El-Item-Obligatorio-Contestado-Con-Un-Diferimiento.md) | El ítem obligatorio contestado con un diferimiento | Un ítem de contenido obligatorio puede contestarse con la promesa de contestarlo; la promesa se lee igual que el dato, se ata a un evento del producto y **nada comprueba ese evento cuando ocurre** | Tercera reanudación de un destino real |
| [15](15-Las-Exclusiones-Estructurales-Del-Barrido.md) | Las exclusiones estructurales del barrido | Una lista de excepciones que vive lejos del momento en que se enumera **se reescribe a mano aunque esté completa**; y la excepción que la mecánica de la comprobación produce siempre —la declaración de la propia intervención— no estaba en ella | Tres intervenciones consecutivas sobre el framework y un destino real |
| [16](16-La-Exclusion-De-Alcance-Se-Concede-Contra-Una-Declaracion.md) | La exclusión de alcance se concede contra una declaración | `Master-Prompt.md` §10.0 le quita alcance al auditor a cambio de lo que la compuerta **declara**, sin exigir evidencia de que lo declarado sea lo medido; el instrumento que sobredeclara produce la misma salida verde que el correcto, y el único que podría notarlo es a quien la exclusión se lo prohíbe | Ocho rondas de auditoría de una migración real |
| [18](18-Un-Mecanismo-Se-Cablea-A-Sus-Puntos-Y-No-A-Su-Condicion.md) | Un mecanismo se cablea a sus puntos y no a su condición | El framework declara **cuándo** se convoca un mecanismo y no **qué condición** lo hace necesario. La especificación es correcta el día que se escribe —los puntos y la condición coinciden— y se vuelve incompleta con el primer caso que satisface la condición desde otro lugar. Agregar el punto que faltó deja el defecto donde estaba | Tres corridas reales de la mesa de evaluación, la tercera **convocada fuera de norma** |
| [19](19-El-Apartamiento-Declara-Hacia-Adelante-Y-Nadie-Barre-Lo-Que-Deja-Atras.md) | El apartamiento declara hacia adelante y nadie barre lo que deja atrás | Toda regla nueva tiene una población que la precede, y el método sólo barre las que vienen de arriba: cuando la regla nace en el destino por apartamiento declarado, el corpus que la incumple queda sin inventariar, sin plan y sin evento | Dos ciclos de la mesa de evaluación sobre `Lab-Geometria` |
| [20](20-La-Norma-Fija-Un-Conjunto-Cerrado-Y-No-Declara-Como-Se-Reconcilia.md) | La norma fija un conjunto cerrado y no declara qué hacer cuando el destino no lo puede satisfacer | Un conjunto cerrado tiene tres preguntas y el framework contesta una: cuáles son sus valores. Qué pasa si el conjunto se contradice consigo mismo, y qué pasa si a un destino le falta un valor, quedan sin contestar, y el destino improvisa una salida distinta cada vez | Dos hallazgos de `RPI.VideoControl`, levantados con once días de diferencia por instrumentos distintos |
| [21](21-La-Decision-Barre-Hacia-Arriba-Y-La-Categoria-Que-La-Ejercita-Queda-Atras.md) | La decisión barre hacia arriba y la categoría que la ejercita queda atrás | El framework declara el alcance de una propagación cuando el disparador es una fase suya, y no cuando es una decisión del destino: un barrido incompleto y uno completo se ven igual, porque no hay lista de categorías contra la cual verificar la cobertura | La implementación de los dieciséis samples de `Lab-Geometria` |

**Los cuatro últimos están fuera del cierre de SDD 7.0** y de la lectura común de más abajo, que se
escribió sobre los doce primeros. Su desenlace, uno por uno:

| # | Desenlace |
|---|---|
| `12` | **Resuelto en 12.1.** No era un fix sino una **decisión de alcance** —si el framework debe distribuir un verificador ejecutable— y la decisión fue **que no**, escrita como `SDD-Development-Guide.md` **§II.7**. El fundamento estaba en el propio reporte, en su §6: un verificador que reimplementa las condiciones **es** la duplicación que `Migracion-Rules.md` §3 rechaza. Las cuatro mediciones de su §7 siguen sin hacer y §II.7 las declara como **condición de reapertura** |
| `13` | **Resuelto en 9.19.** Su eje de estratos fue **rechazado con fundamento escrito** y el resto entró como *la pregunta previa* de §8.1 |
| `14` | **Resuelto en 10.0**, con `Root-Rules.md` §12.2, y **completado en 11.0**: su criterio 4 —auditar el empaquetado sobre las quince reglas— se había declarado resuelto sin correrse. De ese desvío salió la **comprobación 13** del framework |
| `15` | **Resuelto en 10.1**, con la séptima clase de exclusión de §VI.3.2 |
| `16` | **Resuelto en 13.6.** Sus tres propuestas de §6 entraron —el caso que ejerce cada comprobación, el caso inverso por recorte declarado y el hallazgo que no cierra sin su caso—, la cuarta se **descartó con fundamento** por `SDD-Development-Guide.md` §II.7, y su §8.1 se corrigió **distinto de lo propuesto**: medido, el catálogo estaba bien y el recuento **salió de la prosa** en vez de actualizarse. Su §8.2 **se difirió** con los cuatro campos de `Root-Rules.md` §12.2 |

**Los cinco llevan al final su sección «Cómo se resolvió»**, con el desenlace de cada propuesta y **el veredicto de cada criterio de aceptación, uno por uno** — salvo el `12`, que no se aplicó.

> **Quien agrega un reporte, agrega su fila.** El `12` y el `13` estuvieron en la carpeta **sin fila
> acá** hasta el 2026-08-18, y el `15` se empujó sin indexar y se corrigió el 2026-08-20 — **tres
> veces el mismo defecto**, y la tercera dos días después de declarar las dos primeras. Es la forma
> que varios de estos reportes describen: un índice cuyo mantenimiento depende de que alguien se
> acuerde reproduce el problema que vino a resolver. La regla es la misma que `SDD-Development-Guide.md`
> §VI.3 comprobación 12 fija para el catálogo de criterios.

> **Y la mitad que faltaba: quien resuelve un reporte, cierra su fila.** Las tres fallas de arriba son
> de **emisión**; después aparecieron tres de **resolución** —el `13`, el `14` y el `15` siguieron
> declarando «para evaluación, ninguna modificación aplicada» **después de aplicados**, y este índice
> llegó a contradecirse a sí mismo—. **La causa es la misma que describe el reporte `14`**: el acto que
> cambia el estado ocurre afuera —una intervención sobre el framework— y **nadie del lado de acá lo ve
> pasar**.
>
> **Cómo se contrasta, y es enumerable.** Desde `SDD 11.1` la **comprobación 13** obliga a que la nota
> de coherencia de toda intervención **enumere los criterios de aceptación de su origen y los conteste
> uno por uno**. El desenlace de un reporte no se recuerda: **se lee de esa devolución**, y la sección
> «Cómo se resolvió» de cada reporte la transcribe.
>
> **Lo que eso no compra**, declarado igual que lo declara el framework: obliga a que haya veredicto,
> **no a que el veredicto sea verdadero**. El `14` es la prueba — se declaró resuelto con un criterio
> sin contestar, y hoy ese mismo criterio está escrito con su «incumplido en 10.0».

## Lo que los doce tienen en común

No es casualidad que los doce sean del mismo tipo. **Ninguno es un error de un agente**: en los doce, los agentes cumplieron la regla que tenían, o la única que había no se podía cumplir sin empeorar el resultado. Son huecos del método, y comparten una forma:

> El framework declara **qué** hay que producir y con **qué forma**, y con menos frecuencia declara **qué propiedad tiene que conservarse** cuando eso que produjo cambia, se copia, se cuenta o entra en conflicto con otra cosa que también produjo.

Dentro de esa forma común hay cuatro familias, y distinguirlas importa porque cada una se corrige de otra manera.

**Cinco aparecen al modificar y no al escribir** —los reportes `00` a `04`—. Son los que más deberían pesar en cualquier intervención, porque su defecto es invisible en la primera pasada: el artefacto se emite bien y se rompe después, cuando su fuente cambia, cuando alguien lo copia, cuando el recuento que declara deja de coincidir o cuando otra categoría afirma lo contrario.

**Tres aparecen al escribir, y son el mismo error tres veces**: un atributo fijado sin declarar de qué depende, derivado de la forma cuando lo determinaba otra cosa. El `05` fijó el ancho de un identificador sin declarar de qué colección es función. El `06` fijó la obligatoriedad de un artefacto sin declarar de qué responsabilidad es función. El `08` fijó el nivel de aplicación sin declarar de qué habla el artefacto, y lo derivó de en qué categoría está. Los tres se corrigen igual: declarando la dependencia.

**Uno es un conflicto entre reglas.** El `07` no es un atributo mal derivado sino una regla local escrita sin mirar el conjunto: cada regla de categoría es correcta leída sola, y el conflicto está entre ellas y el plan que las ordena. Su corrección no vive dentro de ninguna de las reglas involucradas.

**Y los dos últimos son del instrumento con que el método se mira a sí mismo.** El `09` no habla de lo que el framework produce sino de cómo lo verifica: una sola compuerta, un solo instrumento, y ninguna distinción entre lo que se decide contando y lo que se decide leyendo. Es el único de los doce que se descubrió no al escribir ni al modificar, sino **al auditar tres veces la misma fase y ver que el rendimiento no llegaba a cero**.

El `10` es el otro lado de esa misma cuestión: el `09` habla del **instrumento** —quién mira— y el `10` del **criterio** —qué se le pide que confirme—. Un criterio que se cumple mejor con una declaración falsa que con una honesta no lo arregla ningún instrumento.

Cuatro de los doce salieron de la **Fase B2**, y tampoco es casualidad: es la primera fase que produce información que sólo puede nacer aguas abajo, y por lo tanto la primera en que el método se encuentra con lo que no previó. Dos salieron de la **Fase D**, que es la primera en que el método tiene que hablar del equipo y del calendario y no sólo de los artefactos. El `07` siguió creciendo en la **Fase E**, que le aportó un cuarto incidente: cada fase nueva encuentra otra obligación apuntando hacia adelante, y no hay motivo para suponer que la lista esté cerrada.

## Control de cambios

| Versión | Fecha | Descripción |
|---|---|---|
| 1.0 | 2026-08-10 | Índice inicial, con los cinco reportes emitidos hasta la fecha, la guía de uso para un prompt de intervención y la propiedad común a los cinco. |
| 1.1 | 2026-08-11 | Se incorpora el reporte `05`, emitido al cerrar la Fase B2: el ancho de los identificadores. Se ajusta la sección de lo común: el `05` es el único de los seis que aparece al escribir y no al modificar, y cuatro de los seis salieron de la Fase B2. |
| 1.2 | 2026-08-11 | Se incorpora el reporte `06`, emitido al cerrar la Fase C: la obligatoriedad de un artefacto decidida por el tipo del proyecto. Se ajusta la sección de lo común: son dos, y no uno, los reportes que aparecen al escribir, y los dos comparten la misma forma —un atributo fijado sin declarar de qué depende, derivado de la forma cuando lo determinaba otra cosa—. |
| 1.3 | 2026-08-11 | Se incorporan los reportes `07` y `08`, emitidos al cerrar la Fase D. Se reescribe la sección de lo común: las nueve entradas se agrupan ahora en tres familias —las cinco que aparecen al modificar, las tres que fijan un atributo sin declarar de qué depende y la única que es un conflicto entre reglas y el plan que las ordena—. Se corrigen dos recuentos que habían quedado desactualizados en la versión anterior, que es el defecto que el propio reporte `04` documenta. |
| 1.4 | 2026-08-11 | Corrección de la segunda ronda del audit: la fila del reporte `07` conservaba la medida «dos fases más tarde» que ese mismo reporte ya había corregido, de modo que el índice contradecía al documento que indexa. |
| 1.5 | 2026-08-11 | Correcciones del audit de la Fase E: la cabecera declaraba 1.3 con una fila 1.4 posterior, las dos últimas filas estaban en orden invertido, y la fila del reporte `07` seguía declarando la Fase D como único origen y «hasta cuatro fases» como distancia máxima. Se ajusta también la sección de lo común, que daba por cerrada una lista que la Fase E amplió. |
| 1.6 | 2026-08-12 | Se incorpora el reporte `09`, emitido al cerrar la Fase E tras tres rondas de audit: el audit como única compuerta de fase, sin ninguna comprobación mecánica delante. Se agrega una cuarta familia a la sección de lo común, para el hallazgo que no es sobre lo que el método produce sino sobre cómo lo verifica. |
| 1.7 | 2026-08-12 | Actualización tras la Fase G, sin reportes nuevos. El reporte `06` suma una segunda instancia de su patrón, en `Rules-Examples.md`: la categoría es obligatoria para `library` porque «el integrador la necesita», y los cuatro `library` de este producto tienen `redistribuible` en `false` en el manifiesto, campo que la regla no lee. El reporte `07` registra el desenlace de su cuarto incidente: las matrices de sensado faltantes se emitieron, pero las emitió el generador de otra categoría, de modo que la reapertura que ese reporte propone tiene que devolver el insumo y no sólo el turno. Se decidió no abrir reportes nuevos: los dos hallazgos son instancias de patrones ya enunciados, y contarlos aparte inflaría el recuento sin agregar un patrón. |
| 1.8 | 2026-08-12 | Se incorpora el reporte `10`, emitido al cerrar la primera ronda del audit de la Fase G: tres contratos de verificación nombraban seis casos de uso que su comando no ejercita, y cumplían todos los criterios de aceptación de su regla. El patrón que documenta es que los criterios preguntan por la presencia de una declaración y no por su verdad, con el agravante de que el único que pregunta por la relación cuenta casos de uso sin cubrir, de modo que una sonda mentirosa lo acerca a cumplirse en vez de alejarlo. El propio framework nombró este patrón en el control de cambios de esa regla, a propósito del glosario, y lo reparó sin generalizarlo. |
| 1.9 | 2026-08-12 | Se incorpora el reporte `11`, emitido durante la Fase G a partir de una pregunta de revisión humana: de dónde salían cinco términos que la categoría 10 usaba sin declarar. Cuatro son del framework y sólo uno está definido en un glosario suyo; `sonda`, que nombra la unidad del sensado de deriva y las 376 filas de una matriz, no está definida en ninguno. El framework además da tres respuestas distintas sobre dónde vive el vocabulario de una categoría. |
| 1.10 | 2026-08-12 | El reporte `11` pasa a v1.1 tras una revisión humana que pidió evidencia suficiente para el análisis de corrección. Su §4 pasa de una tabla de tres filas a un inventario de las once reglas que llevan el criterio, con cita textual, los nueve destinos a los que mandan, la evidencia de que la inconsistencia se replica en el destino, y lo que cada respuesta posible exige y rompe. Se actualiza la fila del índice. |
| 1.11 | 2026-08-17 | Suma el **reporte 12**, primero emitido después del cierre de los doce originales. La cabecera distingue los RESUELTOS del que está para evaluación. |
| 1.12 | 2026-08-20 | Suma el **reporte 15**, empujado a la carpeta sin indexar, y reescribe el desenlace de los cuatro últimos como tabla, uno por uno. **Esta fila faltaba**: la intervención subió la cabecera a 1.12 y no la escribió, de modo que el índice declaró durante dos días una versión que su propio registro no conocía. Se restituye acá, con su fecha real, al detectarla la comprobación 10 de `SDD-Development-Guide.md` §VI.3. |
| 1.13 | 2026-08-20 | **El índice declaraba «para evaluación» a tres reportes ya aplicados y se contradecía a sí mismo**: la tabla de desenlaces daba el `13` por resuelto en 9.19 y la sección del `12` lo seguía listando abierto. Los `13`, `14` y `15` pasan a **RESUELTO** —cada uno con su sección «Cómo se resolvió» y el veredicto de cada criterio de aceptación—, el `14` suma su segunda intervención, la **11.0**, y la sección del `12` deja de repetir el estado de otros reportes. Se declara además la mitad que faltaba de la regla del índice: **quien resuelve, cierra la fila**, contrastable desde `SDD 11.1` contra la **devolución al origen** de la comprobación 13. |
| 1.14 | 2026-08-23 | **El `12` pasa a RESUELTO y el índice queda sin reportes abiertos.** La decisión de alcance que el reporte pedía —si el framework distribuye código ejecutable— se tomó y se escribió como `SDD-Development-Guide.md` §II.7 en **SDD 12.1**: **no lo distribuye**, con la frontera declarada —un comando publicado dentro del texto que lo funda no es código distribuido— y con las cuatro mediciones del §7 del reporte como condición de reapertura. La cabecera pasa de «catorce resueltos y uno para evaluación» a **los quince resueltos**. |
| 1.15 | 2026-08-23 | **La serie `00` a `15` se declara cerrada y no reanalizable**, y entra la sección «Línea de corte» que lo funda. El motivo es de aritmética: un reporte declara la versión que evaluó, y entre la `9.13` del `12` y la `12.1` vigente se publicaron más de treinta versiones que reescribieron los mecanismos que estos reportes examinaban — un hallazgo contra un artefacto reescrito tres veces describe algo que ya no está. La práctica de **volver a medir antes de retomar** existía desde el prompt que resolvió el `12` al `14` y **nunca fue regla**. Se declara además lo que la línea de corte **no** cierra: los ítems diferidos de §12.2, que nombran un evento futuro y no un estado pasado. La sección «Reporte 12, abierto» se reescribe como su cierre. |


---

## Reporte 12, cerrado — y con él la serie entera

**El `12` fue el último en cerrarse, seis días después de emitido.** Se emitió el 2026-08-17 sobre la
compuerta mecánica —declarada en prosa, con su ejecución dependiendo del agente que la lee— y **proponía
evaluar un verificador**, declarando que la decisión *no era de implementación sino de alcance del
método*. Se emitió **sin conclusión a propósito**, con las cuatro mediciones que faltaban para decidir.

**La decisión se tomó en `SDD 12.1`: el framework no distribuye código ejecutable**, escrito como
`SDD-Development-Guide.md` §II.7. Se tomó **sin contestar las cuatro mediciones**, y el motivo estaba en
el propio reporte: su §6 arma el caso en contra citando a `Migracion-Rules.md` §3 —*«una duplicación que
hay que mantener en paralelo se desincroniza»*— y un verificador que reimplementa las condiciones **es**
esa duplicación. Las mediciones dimensionan el costo de construirlo; ninguna toca el argumento que lo
desaconseja. Las cuatro quedan declaradas en §II.7 como **condición de reapertura**.

**Lo que el `12` consiguió no es lo que proponía.** Su abstención deliberada es lo que evitó que el
framework incorporara un verificador por inercia técnica. **El aporte fue la pregunta.**

---

## Línea de corte: la serie 00–15 no se reanaliza

**Los dieciséis reportes están cerrados y la serie se declara terminada.** Ninguno se reabre por su
cuenta, y **ninguno es insumo válido de una intervención nueva sin volver a medirlo antes**.

**El motivo es de aritmética, no de cansancio.** Un reporte declara en su cabecera **la versión del
framework que evaluó**, y esa versión ya no existe: el `00` al `11` evaluaron hasta `SDD 6.x`, el `12`
evaluó **9.13**, el `14` evaluó **9.19**. El conjunto está en **12.1**. Entre la 9.13 y la 12.1 se
publicaron **más de treinta versiones**, y varias reescribieron exactamente los mecanismos que estos
reportes examinaban —la compuerta de §10.0, el barrido por concepto, el sistema de identificadores, la
figura del ítem diferido—. **Un hallazgo contra un artefacto que se reescribió tres veces no es un
hallazgo: es una descripción de algo que ya no está.**

**La práctica ya existía y no estaba escrita.** El prompt que resolvió el `12` al `14` la enunció así:
*«verificar primero qué ya está resuelto… una intervención que reescribe lo que ya está hecho es peor
que no haberla corrido»*. Se aplicó cada vez y **nunca fue regla**, que es la misma figura que §II.7
vino a cerrar del otro lado.

**Qué significa en la práctica:**

| | |
|---|---|
| **Un reporte de esta serie** | Es **registro histórico**. Se lee para entender por qué el framework es como es, no para derivar trabajo |
| **Si alguien quiere retomar uno** | **Vuelve a medir contra el conjunto vigente primero.** Si el defecto sigue vivo, se emite un **reporte nuevo** con la versión actual en su cabecera; no se reabre el viejo |
| **Un reporte nuevo** | Evalúa **12.1 o posterior** y lo declara en su cabecera, como todos |

**Lo que esta línea de corte NO cierra, y se dice para que no se lea de más.** Los **ítems diferidos**
que las intervenciones dejaron abiertos **no son reportes y siguen vigentes**: viven con la forma de
cuatro campos de `Root-Rules.md` §12.2, cada uno nombrando el artefacto y la sección donde se cierra.
Los seis de la `12.0` están en `SDD/Devs/Guides/Coherencia-Renumeracion-AG.md` §8. **Un ítem diferido
nombra un evento futuro; un reporte describe un estado pasado.** Cerrar la serie no toca los primeros.

---

## Cierre de los doce reportes

**Los doce se aplicaron sobre el framework en una sola intervención, la SDD 7.0**, y cada uno lleva al
final su sección «Cómo se resolvió» con dónde quedó escrito y qué pasó después. La nota de coherencia
de esa intervención es `SDD/Devs/Guides/Coherencia-Reportes-00-11.md`, con la trazabilidad reporte por
reporte en su §4.

**Por qué se trataron juntos y no de a uno.** Los doce salieron de la misma corrida sobre el mismo
destino, y **alcanzaban artefactos compartidos**: `Root-Rules.md` aparece en cinco de ellos y
`Master-Prompt.md` en seis. Aplicarlos por separado habría producido seis versiones sucesivas del
mismo archivo, cada una sin ver lo que la siguiente iba a cambiar.

**La propiedad que tenían en común, y que los volvió insumo del método.** Ninguno era un error de un
agente: en los doce, **el agente cumplió la regla que tenía**, o la única que había no se podía cumplir
sin inventar. Un reporte donde el agente se equivocó se corrige en el destino; uno donde el agente
acertó y el resultado igual está mal **se corrige en el framework**, y por eso estos doce llegaron acá.

**Cinco de los doce siguieron dando trabajo después de la 7.0**, y está anotado en cada uno: el `01` en
la 8.2, el `05` en la 8.1, el `06` disuelto por la 8.0, el `07` mejorado por la 8.0, y el `09` llevado
más lejos por la 8.4. Los reportes `04` y `10` tienen la constancia más incómoda: **su patrón se volvió
a cometer**, y uno de los dos lo cometió la intervención que lo tenía presente.
| 1.17 | 2026-08-29 | **Entra el reporte `18`, y con él la primera evidencia de campo sobre la mesa de evaluación.** Nace de **tres corridas reales** en un destino, la tercera de ellas **convocada fuera de los tres puntos que `Mesa-Rules.md` declara**, porque el caso más caro del destino —un `P0` que ocho rondas de auditoría no lograron cerrar— no tenía ninguno. El patrón se enuncia **por la condición y no por el punto que faltó**, deliberadamente: agregar el cuarto punto restauraría la coincidencia hasta el siguiente caso no previsto, que es cómo se llegó acá. Es además el primer reporte que **cierra un ítem diferido del framework con su medición**: el de la entrada `13.7`, cuyo evento era «la primera corrida real», con las cifras que el propio análisis había declarado que había que mirar. Y trae su parte incómoda: **§3.5 mide dos errores de la propia mesa**, los dos de la misma clase —confiar en una fuente declarativa sin contrastarla—, que es el anti-patrón que el método nombra primero. Un reporte que sólo pidiera ensanchar el mecanismo, escrito por quien lo usó, se leería como pedido. | Product Owner, con la evidencia de `RPI.VideoControl` |
| 1.18 | 2026-08-29 | **El reporte `18` pasa a RESUELTO en SDD 13.8**, con su §9. La intervención aplicó las tres propuestas de §6 y los tres hallazgos menores de §8, y **respetó lo que el reporte pedía no tocar** —refutador, ceguera del panel, escala de ancla, jurado, cuerpo de parches y contrato de entrada—, que la nota de coherencia enumera para que la próxima intervención no los toque por inercia. **De los cinco criterios de §7, cuatro quedaron cumplidos y uno a medias**: el caso de banco que pedía el criterio 4 **no lo puede aportar el framework**, porque el banco es del destino por la decisión del reporte `12`. Se declara en lugar de darse por resuelto. Y la intervención destapó, sin ser un hallazgo de este reporte, que **`_legacy/` llegaba hasta la 13.5**: las publicaciones de la 13.6 y la 13.7 no tomaron su snapshot, y sin él el diff normativo de un salto desde esas versiones **salía vacío**. Repuestos y verificados. | Intervención de la condición de convocatoria |
| 1.19 | 2026-08-30 | **Entra el reporte `21`**, nacido de la implementación de los dieciséis samples de `Lab-Geometria`: un barrido de alcance de ADR hecho con criterio que **no alcanzó la categoría que ejercita el contrato cambiado**, medido con `grep` sobre el documento que lo enumeró. Se distingue del `19` por la figura y se propone cerrar los dos con la misma pieza. **Se corrige además la cabecera, que declaraba 1.17 mientras la última fila de esta tabla ya era la 1.18.** **Lo que esta versión NO hace: escribir las filas de los reportes `19` y `20`**, que están indexados arriba y no tienen entrada acá. Faltan, se declara que faltan, y **no se inventan**: una fila de control de cambios la escribe quien hizo el cambio, y escribirla ahora le pondría a dos emisiones ajenas un relato que no es suyo. |
