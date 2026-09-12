# Reporte 25 — El producto evoluciona y el método no tiene dónde registrarlo

| Campo | Valor |
|---|---|
| Reporte | 25 |
| Fecha | 2026-09-12 |
| Origen | La **sexta reanudación** del destino `Lab-Geometria`, el 2026-09-12, y su mesa de evaluación de dos ciclos (`SDD/Docs/Audit/Mesa-2026-09-12.md`). El producto había cerrado su alcance comprometido, se había desplegado, y **después** recibió dos cambios de producto —uno ya ejecutado y otro propuesto— que **ningún artefacto del método pudo recibir**. La reanudación midió cuatro divergencias y **las cuatro tienen la misma causa** |
| Versión del framework evaluada | SDD **13.10** (`Master-Prompt.md` §7, §12 y §13 · `Master-Prompt-Reanudacion.md` §1 y §4 · `Rules-Backlog-Tecnico.md` §3.4 y §3.6 · `Rules-Plan-Sprint.md` §3.6 · `Rules-Documentacion.md` §0.6 · `Migracion-Rules.md` §0 y §3) |
| Artefactos del framework alcanzados | `SDD/Devs/Orchestrator/Master-Prompt.md` **§13** —donde nace— · `SDD/Devs/Orchestrator/Master-Prompt-Reanudacion.md` §4 · `SDD/Devs/Rules/Rules-Backlog-Tecnico.md` §3.4 · `SDD/Devs/Rules/Rules-Documentacion.md` §0.6 · `SDD/Devs/Rules/Vocabulario-Rules.md` §2 |
| Naturaleza | **Un hueco de disparador y de criterio, no de figura.** El método tiene mecanismo para re-alinearse cuando **la normativa avanza** (migración normativa, con orquestador y regla propios) y para actualizarse cuando **el sistema se construye** (Fases I y J, ciclo de documentación viva). **No tiene ninguno para cuando avanza el alcance comprometido del producto**, y el evento «el Product Owner decidió cambiar el alcance después del handoff» **no está declarado como evento en ninguna regla**. **Y donde el método sí escribe de hecho —el intake— lo hace sin criterio: decisiones del mismo peso reciben trato distinto** (§2.4) |
| Estado | **RESUELTO en SDD 13.14** |
| Reportes relacionados | **`21`**, del que toma el patrón y al que no reemplaza: aquél enuncia en general que **una decisión barre hacia arriba y la categoría que la ejercita queda atrás**, y que no hay matriz de propagación para un ADR. **Éste aporta la instancia que le faltaba**: cuando lo que la decisión cambia es el **alcance**, no hay siquiera una categoría a la cual barrer, porque el artefacto que debería recibirla —el backlog, el plan, el roadmap— está cerrado y nada lo reabre. **`08`**, con el que **no** se confunde: aquél es sobre el **nivel de aplicación** del artefacto de iteración (del equipo o del proyecto de código); éste es sobre **qué evento lo reabre**. **`19`** y **`22`**, con los que comparte la forma —mecanismo bien diseñado sin evento que lo active— y no el objeto |

---

## 1. Resumen

**El framework tiene dos mecanismos de re-alineación y los dos miran hacia el mismo lado.** La
migración normativa existe porque *«cuando el framework avanza, la documentación ya emitida queda
descripta contra reglas que dejaron de estar vigentes»* (`Migracion-Rules.md` §0), y resuelve el caso
con un principio claro: *«la normativa vigente es la especificación del estado al que hay que llegar.
El documento existente es la fuente del contenido»* (§3). Las Fases I y J existen porque el sistema se
construye después del handoff, y actualizan la evidencia de los contratos de verificación y el cuerpo
documental de entrega.

**Falta el tercero, y es el que el producto necesita más seguido.** Cuando lo que avanza no es la
normativa ni la construcción de lo ya especificado sino **el alcance comprometido** —una decisión del
Product Owner que cambia qué se entrega, cómo se entrega o cómo está compuesto el producto—, el
método **no tiene dónde recibirla**. No hay fase que la tome, no hay cardinalidad que la nombre, no hay
evento declarado que reabra el backlog, el plan de sprint o el roadmap, y **no hay caso de escritura
del intake que la admita**.

**El resultado observable no es que la decisión se pierda: es que se ejecuta igual y el corpus queda
describiendo el producto anterior.** El destino que originó este reporte tiene su documentación de
especificación completa, auditada y al día contra la normativa, **y describe una topología de
despliegue que se retiró hace seis días**. Ninguna regla lo impidió porque ninguna regla lo mira.

**Y hay un segundo efecto, más caro, que aparece al intentar el remedio obvio.** El remedio obvio es
parchear los documentos que quedaron viejos. Pero cuando la decisión cambió **la composición del
producto** —qué proyectos de código existen, cómo se agrupan, cómo se integran—, parchear la
documentación produce un corpus coherente **sobre un plan que nadie replanificó**: quedan al día los
documentos y desactualizado el trabajo. Las tres vías posibles —corregir nomenclatura, reencuadrar la
documentación, o reconocer el estado nuevo y replanificar— **exigen decisiones distintas, y el método
no da criterio para elegir entre ellas**.

---

## 2. La evidencia: dos cambios de producto en seis días, ninguno recibido por el método

### 2.1 El caso que lo reveló, con su fundamento a la vista

El destino `Lab-Geometria` cerró su alcance comprometido —ocho etapas, `a` a `h`— el 2026-08-18, y el
2026-08-27 abrió la etapa `i`, «despliegue real», cuyo entregable declarado era **«el front publicado
por FTP en el hosting y el servicio de datos en el servidor propio»** (`Roadmap-Producto.md` 1.9 §2.1;
`PRODUCT-INTAKE` §4 `F-14`).

**Esa topología no era un capricho: tenía una razón escrita.** La red de la facultad bloquea el acceso
al servidor doméstico, de modo que el front vivía «donde no lo bloquean» y los datos «donde persisten».
El intake incluso **declaró la alternativa y su condición de reevaluación**, con años de anticipación
al hecho:

> `X-10` · Túnel saliente con dominio propio para el backend — *exige un dominio propio y **debilita la
> premisa de la topología***. **Reevaluar si aparece un dominio propio.**

**El 2026-09-06 apareció el dominio propio.** El Product Owner lo declara así:

> *«se terminó el producto y se cambió el despliegue porque i7infra ahora tiene un dominio pago en
> cloudflare y se cuenta con la posibilidad de desplegar mediante un túnel bajo un dominio público
> —cosa que de esta manera **satisface mejor la razón de por qué el primer despliegue**—. No obstante,
> quedó como decisión **mantener el yml para hacer el despliegue del front por FTP hacia somee**, la
> razón de esto último fue **dejarlo como alternativa y como antecedente de despliegue**.»*

**Las dos decisiones son correctas y están fundadas.** La condición de reevaluación de `X-10` se
cumplió y el desenlace fue realizarla; y conservar el canal anterior como alternativa documentada es
una decisión de ingeniería legítima.

**Lo que no ocurrió es que el método las recibiera.** Seis días después:

| Artefacto | Qué dice | Qué es cierto |
|---|---|---|
| `PRODUCT-INTAKE` §4 `F-14`, §9 `X-10`, §22 | El entregable es «front por FTP en el hosting»; `X-10` es exclusión **vigente**; la incógnita del dominio propio sigue **viva** | La exclusión se realizó el 2026-09-06 |
| `Roadmap-Producto.md` **1.9**, del 2026-08-23 | Fila `i` con el entregable viejo; criterio de transición «el front está publicado en el hosting por el flujo de FTP declarado» | La topología es otra desde hace seis días |
| Los **cuatro** documentos de `06-Backlog-Tecnico` y los **dos** de `07-Plan-Sprint` | Sin modificar desde el 2026-08-25 | Anteceden a los dos cambios; **ninguno de los dos entró como ítem** |
| `scripts/verify-stage-i.sh`, criterio `I-1` | Comprueba que exista el flujo de FTP | Corrido contra la dirección real **aprueba en verde midiendo el instrumento equivocado** |
| **25 líneas** en la categoría 09, los ADR y los índices | Afirman en presente un canal retirado | — |

**El intake se reemitió dos veces el 2026-09-12 —versiones 4.0 y 4.1— y ninguna de las dos absorbió la
decisión del 2026-09-06.** No por olvido: porque el caso de escritura que lo habría permitido **no
existe** (§3.2 de este reporte).

### 2.2 El segundo cambio, que todavía no se ejecutó y ya tiene el mismo problema

El mismo Product Owner decidió el 2026-09-11 que **todos los proyectos de código queden bajo el árbol
de la solución**, incluido un paquete que no es .NET, y hay una especificación completa de la
reestructuración. Eso cambia **la composición del producto**: qué agrupa el agrupador, cómo se
construye el artefacto de un proyecto de código, y qué proyectos son visibles como unidad de trabajo.

**La primera parte se fusionó el 2026-09-12.** Y el propio instrumento que la planificó había escrito
la precondición: *«No se fusionó: fusionar publica el front en producción y el paso 0 reescribe el
intake, las dos cosas del Product Owner»*. **El paso 0 —la reescritura del intake— no se ejecutó, y la
fusión ocurrió igual.** No hay registro de quién autorizó cruzar esa puerta, porque **no hay puerta**:
el método no declara que un cambio de composición exija reabrir nada.

### 2.3 El costo medido, que no es documental

**El mismo `main` se publicó dos veces, a dos topologías distintas, el mismo día.** El flujo de FTP
sigue armado sobre las rutas del front, y una fusión que las tocó lo disparó. La decisión de conservar
ese canal «como alternativa y antecedente» era correcta, **pero nunca se tradujo a una restricción
ejecutable ni a un ítem de trabajo**: no hay tarea técnica que diga «mantener el canal alternativo,
sin publicación automática». Una decisión correcta quedó **indistinguible de un descuido**, y lo único
que la distingue hoy es el testimonio oral de quien la tomó.

**Y las seis reanudaciones del destino llegan a la misma encrucijada.** La del 2026-09-12 tuvo que
declarar que el producto **no encaja en ningún estado que el método nombre**: corre en producción con
su revisión sellada, y su fase de construcción sigue formalmente abierta.

### 2.4 El intake sí se escribe después, y ése es el hallazgo — no lo contrario

**La lectura intuitiva de §2.1 y §2.2 es que el intake quedó congelado y la evolución se fue por otro
lado. Es falsa, y medirla cambia la pregunta.** El intake del destino tiene **47 entradas de control de
cambios** entre la 1.0 y la 4.1, y al clasificarlas contra su propio texto:

| Clase de entrada | Cuántas |
|---|---|
| Migraciones normativas o estructurales | 3 |
| Correcciones, consolidaciones de hallazgo, cierre de contradicción interna | ~24 |
| **Decisiones nuevas de producto** | **~20** |

**El intake recibió veinte decisiones de producto, diecisiete de ellas después de estar «Aprobado».** Lo
que no tiene es **criterio declarado de cuándo corresponde**.

**Y el caso que lo prueba son dos ADR gemelos.** El mismo día, la misma familia de decisión —el contrato
de la fachada del visor—, y dos destinos distintos:

| ADR | Qué decidió | ¿Está en el intake? |
|---|---|---|
| `ADR-08006` · el visor recibe piezas reconstruidas y no el texto | Cambia qué cruza la frontera | **Sí.** Absorbido en la versión **2.2**, con autorización explícita del Product Owner y citando el mecanismo de ambigüedad de `Master-Prompt.md` §9 |
| `ADR-08007` · el aviso de selección va en las opciones, **no en una séptima función** | Agrega el **canal de retorno** del visor hacia su anfitrión —un miembro nuevo de las opciones de inicialización— y **sube de versión el contrato de la fachada**. Deliberadamente **no** toca el recuento de seis funciones, que el Product Owner fijó y cinco documentos citan | **No.** Cero ocurrencias del identificador del aviso y del tipo de opciones en todo el intake. La sección que describe la frontera sigue enumerando las seis funciones y **ninguna vía de vuelta** |

**Los dos tienen el mismo peso y el mismo tipo de efecto, y siguieron caminos distintos.** No hay regla
que los separe: los separó que alguien se acordara de uno.

**Y conviene decir con precisión qué es el hueco del segundo, porque la primera lectura de esta mesa lo
describió mal y su propio refutador lo corrigió.** El `ADR-08007` **no agrega una séptima función**: su
título dice lo contrario y su tabla de alternativas descarta esa salida con fundamento —el recuento de
seis lo fijó el Product Owner y está citado en cinco documentos—. Lo que el intake no absorbió es más
fino y por eso más fácil de perder: **el contrato ganó una dirección de vuelta** que antes no tenía, y
subió de versión. Un cruce que sólo mire recuentos no lo encuentra; hay que abrir el ADR y leer qué
decidió. **Esa es la medida de cuán fino tiene que ser el mecanismo que se proponga**, y es la razón por
la que una comparación por fecha global de documento no alcanza (§5.1.b).

**El tercer caso de escritura, además, ya existe de hecho.** `Master-Prompt.md` §13 acota el caso (a)
con las palabras *«es el caso que ocurre durante la generación»*. La versión **4.0** del intake de este
destino es una reescritura de una sección aprobada, hecha el 2026-09-11, **en respuesta a una escalada
de una mesa de evaluación** —es decir, mucho después de la generación— y con exactamente la forma del
caso (a). **El framework ya opera un tercer caso: lo que no hace es nombrarlo**, y por eso no tiene
condiciones.

**Esto es lo que el Product Owner observó con otras palabras**: *«los añadidos funcionales y las
decisiones de diseño que se toman después no se reflejan en el intake: quedan en la documentación de
especificación»*. La medición dice que **a veces sí se reflejan y a veces no**, y que la diferencia no
la decide ninguna regla.


---

## 3. Qué dice hoy el framework, y por qué no alcanza

### 3.1 Lo que el framework resuelve bien, y no hay que tocar

- **El versionado semántico del backlog ya contempla el cambio de alcance.** `Rules-Backlog-Tecnico.md`
  §3.4: *«Cuando el backlog evoluciona de manera significativa —por ejemplo, una nueva épica grande o
  un cambio de alcance del MVP—, se pasa de v1.0 a v2.0»*. **El instrumento existe y funciona.**
- **La inmutabilidad de lo cerrado es correcta.** §3.6: una `US` o `BT` cerrada con `Done` no cambia de
  versión; si la funcionalidad evoluciona, **se crea una nueva**. Es la regla adecuada y no está en
  discusión.
- **El principio de estado objetivo de `Migracion-Rules.md` §3 es sólido**, y además **prohíbe con
  fundamento** la salida fácil de resolver esto con un procedimiento por caso: *«una duplicación que
  hay que mantener en paralelo se desincroniza»*.
- **El método declara su frontera con honestidad.** `Master-Prompt-Reanudacion.md` §1 dice, con todas
  las letras, que el ciclo de construcción es *«el ciclo de construcción, que el método no gobierna»*.
  **Eso es una virtud y este reporte no pide que se borre**: pide que, si el método no gobierna ese
  ciclo, declare al menos **qué hace cuando ese ciclo le devuelve una decisión que invalida sus
  propios artefactos**.
- **El eje de extensión para resolverlo ya está probado.** `SDD-Development-Guide.md` Parte III §III.4
  («agregar una fase») resolvió exactamente este tipo de problema para las Fases I y J, y se pregunta
  lo que hay que preguntarse: *«¿corre una vez, una vez por unidad, o una vez por incremento? ¿Qué
  precondición? ¿Qué se regenera y qué se preserva?»*.

### 3.2 Lo que no está

**a) No hay caso de escritura del intake para un cambio de alcance posterior al handoff.**
`Master-Prompt.md` §13 declara **dos** casos, y cierra la lista: *«Casos de escritura permitidos. Son
dos, y ningún otro»*. El primero está acotado a tiempo de generación —consolidar la respuesta del
humano a una ambigüedad—; el segundo es la migración estructural por cambio de versión **del
framework**. **Ninguno es «el Product Owner decidió, con el producto ya entregado, que el alcance
comprometido cambia».** Y como el intake es el documento que declara alcance, exclusiones y
priorización, **sin ese caso no hay por dónde entrar**: todo lo demás es aguas abajo.

**b) No hay evento que reabra el backlog, el plan de sprint ni el roadmap.** La regla de versionado
existe (§3.1), pero **nada la dispara desde un hecho posterior al handoff**. El defecto no es de
instrumento: es de activación.

**c) Las fases posteriores al handoff son de documentación, no de alcance.** `Master-Prompt.md` §12 lo
dice bien —*«el handoff no cierra el alcance de SDD; cierra el tramo de especificación»*— y abre las
Fases I y J. Pero las siete actividades que §7 les asigna **no invocan ninguna regla de backlog ni de
plan de sprint, y no emiten ningún identificador de trabajo nuevo**. El glosario lo confirma: la Fase I
*«completa la evidencia de los contratos de verificación, actualiza la categoría 11, refresca
`AGENTS.md` y corre el ensayo»*.

**d) No hay una cuarta cardinalidad.** `Master-Prompt-Reanudacion.md` §0 declara tres —*«una vez por
producto, una vez por salto de versión, una vez por reanudación»*—. **No existe «una vez por
incremento de alcance».** La Fase I es «re-ejecutable una vez por incremento», pero ese incremento es
de construcción de lo ya especificado, y vive dentro de la cardinalidad del orquestador de generación.

**e) La salida `D` de la reanudación supone que la etapa siguiente ya existe.** §4 la describe como
«continuar la construcción» y su punto de continuación lleva *«la etapa, su puerta de entrada y los
documentos que la gobiernan»*. **No contempla el caso en que lo que hay que continuar no esté en el
roadmap**, que es exactamente el caso cuando el alcance cambió.

**f) No hay término para el caso.** Ni los seis términos del framework ni los cuatro planos de
identidad nombran la evolución posterior al alcance comprometido. Y la entrada «Fase» del glosario
enumera **A a H**, sin mencionar I y J, que el mismo glosario define dos filas más abajo.

**g) La bitácora de eventualidades no tiene destino para esto.** `Rules-Documentacion.md` §0.6 da seis
destinos de triaje y el más cercano —*«reveló un problema de diseño, no de documentación»*— desemboca
en una ADR más *«escalamiento al usuario»*. **El escalamiento no es un destino: es el final del
procedimiento.**

---

## 4. El hueco, en una frase

**Todo mecanismo de re-alineación del framework tiene como referente el conjunto normativo vigente o el
estado observable del repositorio; ninguno tiene como referente el alcance comprometido vigente
confrontado contra una decisión de producto posterior. El framework sabe re-expresar documentación bajo
una regla que cambió, y no sabe re-expresar backlog, plan y roadmap bajo un alcance que cambió — por la
misma estructura que le permite lo primero.**

---

## 5. Qué se propone evaluar

**Ninguna de las cinco es una propuesta de redacción: son las preguntas que el framework tiene que
contestar.** El orden importa: la primera es la que habilita a las demás.

### 5.1 Qué es el intake, y con qué criterio se lo escribe después

**La pregunta no es si se puede escribir el intake después del handoff: ya se lo escribe** (§2.4). Son
tres preguntas encadenadas, y la primera ordena a las otras dos:

**a) ¿Qué es el intake en el eje origen/vigencia?** Ni `PRODUCT-INTAKE-template.md` ni `Intake-Rules.md`
usan las expresiones «línea base» ni «declaración vigente»: el template lo describe sólo como *«el único
documento de entrada de un producto»* que el orquestador lee, valida y del que deriva el manifiesto —una
descripción de **origen y disparo**—. **El framework no tiene nombre para lo que el intake es después de
la generación**, y ese vacío de vocabulario es la raíz del resto.

**b) ¿Con qué criterio una decisión posterior se absorbe?** Hoy no hay ninguno, y el par de ADR gemelos
de §2.4 lo demuestra: dos decisiones del mismo día, del mismo peso y de la misma familia, una absorbida
y la otra no. **Si el intake es la declaración vigente**, hace falta la regla de qué entra —por ejemplo:
todo lo que reabre una capacidad declarada en §4, una exclusión de §9 o un contrato de §17, sin
excepción por quién lo escaló—. **Si el intake es la línea base de origen**, hace falta decir **qué
artefacto declara el alcance vigente**, porque hoy no hay ninguno que lo haga: está repartido entre el
intake, los ADR, el roadmap, las actas de mesa y el historial del repositorio.

**c) ¿Qué condiciones tiene el tercer caso, que ya se ejerce?** `Master-Prompt.md` §13 cierra la lista en
dos y acota el primero a «durante la generación», y sin embargo la versión 4.0 del intake del destino se
escribió el 2026-09-11 en respuesta a una escalada de mesa, con la forma del caso (a). **Un caso que se
ejerce sin estar declarado no tiene condiciones**: ni de procedencia, ni de autorización, ni de
severidad del salto, ni de archivado.

**Y hay una consecuencia sobre la reproducibilidad que conviene mirar antes de responder que el intake
está vivo.** `Migracion-Rules.md` §4.4 reconoce que *«los dos conjuntos no coinciden hoy: la plantilla
declara secciones obligatorias que la validación no comprueba»*, y el archivado en `_legacy/` dispara en
saltos **major**. Un intake que se reescribe en cada consolidación menor **deja de poder reconstruir qué
intake exacto leyó el orquestador en cada fase**.

### 5.2 El evento que reabre los artefactos de planificación

Existiendo el caso anterior: **¿qué reabre el backlog, el plan de sprint y el roadmap, y quién lo
declara?** La regla de versionado ya sabe qué hacer cuando el backlog evoluciona; falta decir **qué
hecho la activa**. Conviene que el evento sea el mismo que el de 5.1, para que no haya dos.

### 5.3 El criterio para decidir de qué clase es el cambio

El Product Owner que originó este reporte propuso una taxonomía útil: **nomenclatura**, **enmarcamiento
de la documentación**, o **estructural del propio proyecto** —y sólo la tercera exige replanificar—.
**¿Cómo se decide de cuál se trata, con un criterio observable y no con juicio?** La mesa propuso uno
que conviene evaluar: *¿el hecho nuevo modifica una fila de la matriz fase-épica-sprint-release del
roadmap, o el conjunto de proyectos de código del manifiesto?* Si sí, es estructural y reabre la
planificación; si sólo cambia cómo algo se nombra o se explica, es nomenclatura o enmarcamiento y se
resuelve en la categoría 11.

### 5.4 El estado de vida del producto

`Vocabulario-Rules.md` no tiene término para un producto que **corre en producción con una fase de
construcción abierta**. **¿Hace falta nombrarlo, y qué gobierna el trabajo en ese estado** —el roadmap,
el backlog, o la operación—? La ausencia de esta distinción hizo que **seis reanudaciones** del mismo
destino llegaran a la misma encrucijada.

### 5.5 El salto de la decisión al control

Una decisión de producto que no se traduce en un artefacto verificable **queda indistinguible de un
descuido**. El framework no distribuye código ejecutable y no debe hacerlo. **¿Corresponde exigir que
una decisión de esta clase produzca al menos un ítem de trabajo con criterio de verificación**, que es
el instrumento que el propio método ya tiene, en lugar de quedar sólo en un ADR o en un testimonio?

---

## 6. Lo que este reporte no afirma

- **No afirma que alguna regla esté mal escrita.** Cada regla revisada cumple lo que declara cumplir; el
  defecto está en lo que ninguna declara.
- **No afirma que el framework deba gobernar la cadencia del equipo.** La frontera entre especificar y
  gestionar el trabajo es correcta y está declarada. Lo que se pide es que el método declare qué hace
  cuando ese ciclo ajeno le devuelve una decisión que invalida **sus propios artefactos**.
- **No afirma que corresponda enganchar el disparador al backlog.** Esa fue la primera propuesta de la
  mesa y su propio refutador la corrigió: el backlog es aguas abajo de la `US`, que es aguas abajo del
  caso de uso, que es aguas abajo del intake. **Empezar por el backlog invierte la trazabilidad.**
- **No afirma cuál de las tres vías del Product Owner corresponde** en el caso que lo originó. Eso es
  decisión suya, y la pregunta 5.3 existe para que el método le dé criterio, no respuesta.
- **No afirma que el framework deba producir controles ejecutables.** §5.5 pregunta por un ítem de
  trabajo con criterio de verificación, que es un artefacto documental, no un guion.
- **No es un reporte sobre el destino.** Los defectos del destino están en su propia mesa y no se
  reportan acá.

---

## 7. Cómo reproducirlo

Sobre cualquier destino con su alcance comprometido cerrado y su sistema en producción:

1. Registrar una decisión de producto posterior al handoff que cambie **qué se entrega, cómo se entrega
   o cómo está compuesto** el producto.
2. Buscar el caso de escritura del intake que la reciba: `Master-Prompt.md` §13 declara **dos**, y
   ninguno aplica.
3. Buscar la fase que la tome: `Master-Prompt.md` §6 y §7 tienen diez, y las dos posteriores al handoff
   son de documentación y de contratos de verificación.
4. Buscar la cardinalidad que la nombre: `Master-Prompt-Reanudacion.md` §0 declara **tres**.
5. Buscar el evento que reabra el backlog: `Rules-Backlog-Tecnico.md` §3.4 sabe **qué hacer** y ninguna
   regla dice **cuándo**.
6. Verificar el efecto sobre los artefactos de planificación: comparar la fecha de la decisión con la
   fecha de la última modificación de los documentos de `06-Backlog-Tecnico` y `07-Plan-Sprint`.

En `Lab-Geometria`, al 2026-09-12, el paso 6 daba **dieciocho días de distancia** entre la última
modificación de los seis documentos de planificación (2026-08-25) y la más reciente de las dos
decisiones de producto (2026-09-11), con **cero altas** en el medio.

---

## Cómo se resolvió

**Resuelto en SDD 13.14**, por la intervención `03-Fix-Reporte-25`
(`IA.SDD.Documentacion/PROMPTs/Fixs/03-Fix-Reporte-25/`). Verificación completa, plan y evidencia en
`OUTPUTs/10-Verificacion-Citas.md`, `OUTPUTs/20-Decision-Solicitud-5-Y-Las-Cuatro-Restantes.md` y
`OUTPUTs/30-Plan-Y-Verificacion-Criterios.md`.

### La pregunta de fondo (§5.1 en su forma original): no corresponde un tercer caso de escritura del intake

`Master-Prompt.md` §13 sigue cerrando su regla 2 en **dos casos**. Los dos ocurren durante una corrida
de un orquestador; una decisión de alcance del Product Owner posterior al handoff ocurre sin ninguna
corrida en curso, y la regla 1 de §13 solo gobierna «durante la generación». El intake es documento
humano (`Migracion-Rules.md` §4.4): su autor ya podía editarlo fuera de una corrida sin que esta regla
se lo prohibiera, que es lo que explica que el reporte haya medido veinte decisiones de producto
absorbidas de hecho (§2.4). Es una decisión negativa con fundamento escrito, con el mismo precedente que
el reporte `12`. `Master-Prompt.md` §13.1 (nueva) lo declara.

### Las cuatro preguntas restantes de §5

- **§5.2 (evento que reabre planificación)**: sí. La entrada de control de cambios que el Product Owner
  asienta en el `PRODUCT-INTAKE` al registrar la decisión, el mismo evento para backlog y roadmap.
  `Master-Prompt.md` §13.1, `Rules-Backlog-Tecnico.md` §3.6, `Rules-Contexto.md` §3.5.
- **§5.3 (criterio de clasificación)**: sí, el de la mesa —modifica una fila de la matriz del roadmap,
  incluido su contenido, o el conjunto de proyectos de código del manifiesto—, verificado contra los dos
  casos que este mismo reporte midió. `Rules-Backlog-Tecnico.md` §3.6.
- **§5.4 (estado de vida del producto)**: sí hace falta nombrarlo. `vigencia operativa abierta`, en el
  glosario operativo de `Master-Prompt.md` §15 y no en `Vocabulario-Rules.md` (que gobierna seis
  términos de identidad, no un estado), sin gobierno nuevo: reusa roadmap, backlog/plan y operación.
- **§5.5 (salto de la decisión al control)**: sí, reusando instrumentos existentes. Una `BT-XXXXX` con
  criterio de aceptación, o un ítem diferido de `Root-Rules.md` §12.2 cuando todavía no se puede
  resolver — sin crear ningún control ejecutable, conforme a §6 de este mismo reporte.

### Verificación de §7, criterio por criterio

| Paso | Resultado |
| --- | --- |
| 1 | Sin cambio: sigue siendo el paso que arma el caso de reproducción |
| 2 | El caso de escritura sigue sin existir, **y se decide con fundamento que no hace falta uno**: la edición del Product Owner nunca necesitó que §13 la autorizara |
| 3 | Sin cambio, y se declara por qué: `SDD-Development-Guide.md` §III.4 no alcanzaba porque el hueco no es de una fase, y no se creó ninguna |
| 4 | Sin cambio, y se declara por qué: no hace falta una cuarta cardinalidad; el evento es un asiento de control de cambios, no una corrida |
| **5 (el decisivo)** | **Cambia.** `Rules-Backlog-Tecnico.md` §3.6 declara el evento y el criterio que antes faltaban; `Rules-Contexto.md` §3.5 lo replica para el roadmap |
| 6 | No se re-ejecutó sobre `Lab-Geometria`, de solo lectura para esta intervención; queda para su próxima reanudación |

### Lo que no se tocó

`Master-Prompt.md` §13 no ganó un tercer caso ni cambió sus dos existentes. `Vocabulario-Rules.md` no se
modificó. No se creó ningún control ejecutable ni ninguna fase nueva del orquestador. `Lab-Geometria` no
se tocó: el `CHANGELOG.md` de `IA.SDD` 13.14 declara qué le exige a su próxima reanudación.

---

## Control de cambios

| Versión | Fecha | Cambios | Autor |
|---|---|---|---|
| 1.3 | 2026-09-12 | **Estado pasa a RESUELTO en SDD 13.14.** Suma la sección «Cómo se resolvió» con el desenlace de las cinco preguntas de §5 y el veredicto de §7 criterio por criterio. La decisión de fondo es negativa: no corresponde un tercer caso de escritura del intake (`Master-Prompt.md` §13.1), con precedente en el reporte `12`. El hueco del paso 5 de §7 —el decisivo— se cierra en `Rules-Backlog-Tecnico.md` §3.6 y `Rules-Contexto.md` §3.5. Intervención `03-Fix-Reporte-25`, evidencia completa en `PROMPTs/Fixs/03-Fix-Reporte-25/OUTPUTs/`. | Intervención del disparador de alcance |
| 1.2 | 2026-09-12 | **Corrige la caracterización de `ADR-08007` en §2.4**, que decía que agregaba «el séptimo miembro del contrato de la fachada». El ADR decide **exactamente lo contrario**: el aviso va en las opciones **y no** como séptima función, y las funciones siguen siendo seis. **El hueco sigue existiendo y es el mismo** —el intake no tiene ninguna ocurrencia del aviso ni del tipo de opciones—, pero es más fino: lo que no se absorbió es que **el contrato ganó una dirección de vuelta y subió de versión**. Lo levantó el refutador del ciclo 4 al verificar el ADR, y se corrige acá porque un reporte que describe mal su propia evidencia no puede fundar una intervención. Sube patch. | Mesa R1.5, ciclo 4 (refutador) |
| 1.1 | 2026-09-12 | **Suma §2.4 y reescribe §5.1**, por una reflexión del Product Owner que la mesa verificó midiendo: el intake **sí** recibe decisiones de producto —unas veinte de sus cuarenta y siete entradas, diecisiete después de estar «Aprobado»— y **la versión 4.0 ya es un tercer caso de escritura de facto**, hecha en respuesta a una escalada de mesa y fuera de «la generación». La pregunta de §5.1 deja de ser «¿se puede escribir el intake?» y pasa a ser **qué es el intake y con qué criterio se lo escribe**, con el par de ADR gemelos —`08006` absorbido, `08007` no— como la evidencia de que hoy no hay criterio. La Naturaleza suma «y de criterio». Sube minor: no cambia el patrón de §4, lo precisa. | Mesa R1.5, ciclo 3 (AH-004 gestión de requisitos y línea base) |
| 1.0 | 2026-09-12 | Emisión inicial. Documenta **un hueco de disparador**: el método tiene mecanismo de re-alineación para cuando avanza la normativa y para cuando se construye lo especificado, y **ninguno para cuando avanza el alcance comprometido del producto**. Origen: la sexta reanudación de `Lab-Geometria` y su mesa de dos ciclos, con once especialistas. La calibración de dónde nace el defecto —**`Master-Prompt.md` §13 y no `Rules-Backlog-Tecnico.md` §3.4**— la corrigió el refutador del ciclo 2, y es lo que evita que la intervención invierta la trazabilidad del método. Se distingue del reporte `21`, que enuncia el patrón general del barrido de una decisión, y del `08`, que es sobre el nivel de aplicación del artefacto de iteración. | Mesa de evaluación R1.5, ciclo 2 (AH-001 metodologías ágiles, AH-002 gestión de proyecto, AH-003 normativa del ciclo, refutador), sobre el planteo del Product Owner |
