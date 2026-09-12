# Reporte 27 — La especificación no se puede correlacionar con el ciclo que la produjo

| Campo | Valor |
|---|---|
| Reporte | 27 |
| Fecha | 2026-09-12 |
| Origen | Un requisito de diseño que el Product Owner de `Lab-Geometria` formuló el 2026-09-12: *«si se reestructura y surgen huecos de especificación, se debe evaluar de dejarlos de tal forma que sean correlacionables con el ciclo de diseño y/o codeo en su historial»* |
| Versión del framework evaluada | SDD **13.10** (`Root-Rules.md` §9, §10, §12.1 y §12.2 · `Migracion-Rules.md` §3 y §4 · `Deriva-Rules.md` · `Rules-Documentacion.md` §0.6) |
| Artefactos del framework alcanzados | `SDD/Devs/Rules/Root-Rules.md` §12.1 —donde nace—, §9 y §10 · `SDD/Devs/Rules/Migracion-Rules.md` §3 y §4 · `SDD/Devs/Rules/Deriva-Rules.md` |
| Naturaleza | **Un enlace que sólo existe hacia adelante.** El método sabe declarar que algo **falta** (`referencia pendiente`, `ítem diferido`) y sabe declarar que algo **se apartó** de la norma, pero ninguno de esos instrumentos registra **en qué momento del ciclo se produjo el hueco ni qué trabajo lo produjo**. Un hueco declarado hoy es indistinguible de un hueco que nació con el producto |
| Estado | **RESUELTO en SDD 13.13** — ver §8, «Cómo se resolvió» |
| Reportes relacionados | **`25`**, que documenta que el producto evoluciona y el método no tiene dónde registrarlo: es la causa; éste es el efecto sobre la **trazabilidad**. Comparten la corrida de origen y **no el artefacto** —`25` toca el disparador del ciclo, éste toca el formato del hueco—, por lo que van separados. **`26`**, que trata el momento en que un hueco se convierte en pregunta al humano: éste trata qué queda escrito cuando **no** se convierte |

---

## 1. Resumen

**El método tiene tres instrumentos para lo que no está**, y los tres miran hacia adelante:

- **`referencia pendiente`** (`Root-Rules.md` §12.1) dice *«esto va a existir»* y apunta al artefacto futuro.
- **`ítem diferido`** (§12.2) dice *«esto se decidió no hacer ahora»* y apunta a la decisión que lo reabre.
- **`apartamiento declarado`** (§11) dice *«esto se hizo distinto de la norma»* y apunta a la norma.

**Ninguno de los tres apunta hacia atrás.** Ninguno registra en qué fase del ciclo apareció el hueco, qué
unidad de trabajo lo produjo, ni contra qué estado del producto se lo evaluó. Los tres son declaraciones
**atemporales**: se leen igual el día que se escriben y dos ciclos después.

**La consecuencia se ve cuando llega una migración.** El principio de estado objetivo de
`Migracion-Rules.md` §3 manda llevar el árbol al estado que la norma vigente pide. Para hacerlo, el
agente tiene que decidir, hueco por hueco, si **falta porque nunca se escribió** o si **falta porque la
norma cambió después**. Y esa distinción **no está en el hueco**: hay que reconstruirla leyendo historia
de git, fechas de control de cambios y ADRs sueltos.

**Cuando no se puede reconstruir, el hueco se eleva.** Es exactamente el mecanismo que produce lo que el
Product Owner describe: una tanda de preguntas sobre situaciones que el propio ciclo generó, que
llegan al humano porque el artefacto no dice de dónde vienen.

**Y hay un caso medido.** El propio `Lab-Geometria` acumula **118 ítems diferidos** —87 + 25 + 6, según
tres cortes distintos—. Ninguno dice contra qué versión del producto se difirió. Los tres cortes no se
pueden sumar ni restar entre sí sin abrirlos uno por uno.

---

## 2. La evidencia

### 2.1 Los tres instrumentos, y qué campo les falta

| Instrumento | Qué declara | Apunta a | ¿Registra el ciclo que lo produjo? |
|---|---|---|---|
| `referencia pendiente` (§12.1) | Lo que va a existir | El artefacto futuro | **No** |
| `ítem diferido` (§12.2) | Lo que se decidió no hacer ahora | La decisión que lo reabre | **No** |
| `apartamiento declarado` (§11) | Lo que se hizo distinto | La norma de la que se aparta | **No** |

**Los tres tienen destino y ninguno tiene origen.** Es la misma forma del hueco del reporte `26` —allí
falta de dónde salió el hecho, acá falta de dónde salió el faltante— y por eso los dos reportes se leen
juntos, aunque toquen artefactos distintos.

**Y una advertencia de nombre, verificada contra el árbol**: el término `procedencia` **ya está tomado**
por el framework con otro significado —la versión de formato bajo la que el destino se estructuró,
`Intake-Rules.md` §2.1 y `Migracion-Rules.md` §4.5—, y con decenas de ocurrencias en ese sentido. El
campo que este reporte propone **no puede llamarse así**: acá se lo nombra **`ciclo de origen`**, y la
elección definitiva es de la intervención, bajo `Vocabulario-Rules.md`.

### 2.2 El identificador no lleva tiempo

`Root-Rules.md` §9 fija la forma de los identificadores del método. Son estables y únicos, que es lo que
se les pide. **Lo que no llevan es ninguna marca del ciclo** en que se emitieron. Dos ítems con
identificadores contiguos pueden ser de fases separadas por meses, y el identificador no lo dice.

El dato de tiempo existe en el **control de cambios** de cada documento, pero está a nivel de
**documento**, no de **ítem**: un documento en versión 4.0 con seis filas de cambios no dice cuál de sus
veinte ítems entró en cuál de las seis.

### 2.3 La migración tiene que reconstruir lo que nadie escribió

`Migracion-Rules.md` §3 —principio de estado objetivo— y §4 no disponen de ningún campo que les diga la
el origen de un hueco. El agente de migración enfrenta, para cada uno, una pregunta que el artefacto
no contesta:

> ¿Este `pendiente` falta porque el ciclo que lo declaró no llegó a escribirlo, o porque la norma que lo
> exige es posterior al ciclo?

**Son dos situaciones con dos tratamientos opuestos.** La primera se completa. La segunda se declara como
deuda de migración y **no** se completa retroactivamente. Confundirlas escribe especificación falsa —el
modo de falla que el framework ya midió como *«el producto afirma lo que no hizo»*.

### 2.4 El caso medido: 118 diferidos sin ciclo de origen

El corte de estado del destino de `Lab-Geometria` del 2026-09-12 registra **118 ítems diferidos** en tres
recuentos —**87**, **25** y **6**— tomados en momentos distintos por instrumentos distintos.

**Ninguno de los tres recuentos se puede cruzar con los otros**, porque ningún ítem declara contra qué
estado del producto se difirió. No se sabe si los 25 están contenidos en los 87, si son posteriores, o si
se solapan parcialmente. **La única forma de saberlo es abrir los 118**, que es el costo que el método
ya identificó como inaceptable en otro contexto.

### 2.5 La evidencia de deriva sí lleva tiempo — y muestra que la pieza es construible

`Deriva-Rules.md` define tipos de evidencia y uno de ellos es `ejecucion`, que **sí** queda anclado a un
momento: una corrida tiene fecha, salida y artefacto versionado.

**Esto prueba que el framework sabe fechar una afirmación cuando decide hacerlo.** Lo que no hace es
aplicar el mismo criterio a los huecos. La evidencia de lo que **se hizo** lleva estampa temporal; la
declaración de lo que **falta**, no.

---

## 3. Qué dice hoy el framework, y por qué no alcanza

### 3.1 Lo que resuelve bien

- **Los tres instrumentos cubren bien sus casos.** Un pendiente, un diferido y un apartamiento son tres
  cosas distintas y está bien que sean tres figuras distintas. **Este reporte no propone fusionarlas.**
- **El principio de estado objetivo es correcto.** La migración debe llevar al árbol al estado que la
  norma vigente pide, no a un estado intermedio. El problema no es el principio: es que para aplicarlo
  hace falta un dato que no está.
- **Los identificadores estables son la decisión correcta.** Meterles el ciclo adentro los volvería
  inestables. **La marca temporal va como campo, no como parte del identificador.**
- **`Deriva-Rules.md` ya demuestra el patrón**: una afirmación anclada a un momento verificable.

### 3.2 Lo que no está

**a) Los huecos no llevan ciclo de origen.** Ninguno de los tres instrumentos registra la fase, la unidad
de trabajo ni el estado del producto contra el que se declaró.

**b) La migración no tiene cómo clasificar un hueco** entre «no se escribió» y «la norma es posterior», y
sin esa clasificación cada hueco es candidato a elevarse.

**c) Los recuentos de diferidos no son comparables entre sí**, porque no comparten eje temporal. El caso
de los 118 lo muestra.

**d) No hay criterio de aceptación** que verifique que un hueco declarado sea correlacionable. Se puede
declarar un pendiente sin decir de dónde sale, y ninguna compuerta lo detiene.

---

## 4. El hueco, en una frase

**El método sabe declarar que algo falta y hacia dónde apunta, pero no de qué ciclo salió; de modo que
cuando una migración tiene que decidir si un hueco se completa o se declara como deuda, el dato que lo
resolvería no está en el artefacto y hay que reconstruirlo a mano o preguntárselo al humano.**

---

## 5. Qué se propone evaluar

### 5.1 El campo de ciclo de origen del hueco

¿Corresponde que `referencia pendiente`, `ítem diferido` y `apartamiento declarado` lleven un campo que
registre **el ciclo y la unidad de trabajo en que se declararon**, derivado del contexto de la corrida y
no escrito a mano?

**Con el mismo fundamento que el reporte `26` §5.3**: un campo que el agente llena a mano se llena de
buena fe con lo que el agente cree, y el resultado se lee como verificación sin serlo. **Y sin el nombre
`procedencia`**, que está tomado (§2.1).

### 5.2 El estado del producto contra el que se declaró

¿Corresponde que además registren **contra qué versión del producto** se evaluó el hueco, de modo que
dos recuentos tomados en momentos distintos se puedan cruzar sin abrirlos?

### 5.3 La clasificación que la migración necesita

¿Corresponde que `Migracion-Rules.md` derive de esos dos campos una clasificación explícita —**hueco del
ciclo** (se completa) vs. **hueco de norma posterior** (se declara como deuda de migración)— y que sólo
eleve al humano los que **ninguna de las dos reglas alcanza**?

Es la conexión con el reporte `26`: **la clasificación derivada es lo que evita la tanda de preguntas.**

### 5.4 El tratamiento retroactivo

**Es la pregunta de aplicación, y no es menor.** Los huecos ya declarados —los 118 de `Lab-Geometria`
entre ellos— **no tienen el campo**. ¿Corresponde exigirlo retroactivamente, dejarlo vacío con un valor
explícito de *«anterior al mecanismo»*, o derivarlo donde se pueda y marcarlo como no derivable donde no?

La respuesta tiene que ser una de las tres **antes** de que el mecanismo se aplique, porque si no la
primera migración que corra se encuentra 118 huecos sin campo y **eleva los 118** — el problema que el
mecanismo venía a evitar.

### 5.5 El criterio de aceptación enumerable

¿Corresponde un criterio con la forma de los que ya existen: **ningún hueco declarado después de la
aplicación del mecanismo carece de ciclo de origen**, verificable contando?

### 5.6 A qué rol se le atribuye

El Product Owner pidió que la habilidad de correlacionar **se atribuya a un agente existente o se sume
uno nuevo si es necesario**. ¿Corresponde un rol nuevo, o alcanza con que el agente de migración lo
ejerza usando los campos de §5.1 y §5.2?

**La posición de este reporte es que no hace falta un rol nuevo si el dato está en el artefacto**, y que
un rol nuevo sin el dato no resuelve nada: seguiría reconstruyendo a mano. **El dato primero, el rol
después si se demuestra que hace falta.**

---

## 6. Lo que este reporte no afirma

- **No propone fusionar los tres instrumentos.** Son tres figuras distintas por buenas razones.
- **No propone meter el ciclo dentro del identificador.** Eso los volvería inestables, contra `Root-Rules.md` §9.
- **No afirma que los 118 diferidos de `Lab-Geometria` estén mal declarados.** Están declarados según la
  norma vigente cuando se declararon. Lo que afirma es que **esa norma no pedía el dato** que ahora hace
  falta.
- **No afirma que un rol nuevo sea necesario.** Afirma que el dato es necesario, y que la pregunta del rol
  se contesta después.
- **No reemplaza al reporte `25`.** El `25` trata el disparador del ciclo; éste trata qué queda escrito
  dentro de él. El `25` puede resolverse sin éste, y quedaría un método cíclico cuyos huecos siguen sin
  correlacionarse.

---

## 7. Cómo verificar que la corrección funcionó

1. **Declarar un hueco nuevo** en una corrida real y comprobar que su ciclo de origen queda escrito **sin
   que ningún agente lo haya tipeado**.
2. **Cruzar dos recuentos** de diferidos tomados en momentos distintos y comprobar que se pueden
   comparar **sin abrir los ítems**.
3. **Correr una migración** sobre un árbol con huecos de las dos clases y contar cuántos se elevan al
   humano. **El número tiene que ser menor que la cantidad total de huecos**; si es igual, la
   clasificación de §5.3 no está funcionando.
4. **Probar el caso retroactivo**: correr la migración sobre los 118 de `Lab-Geometria` y comprobar que
   la decisión de §5.4 los absorbe sin elevarlos uno por uno.
5. **El criterio de §5.5, enumerable**: ningún hueco posterior a la aplicación sin ciclo de origen.

---

## 8. Cómo se resolvió

**Aplicado en SDD 13.13**, con nota de coherencia `SDD/Devs/Guides/Coherencia-Ciclo-De-Origen.md`. El
framework estaba en la **13.10** cuando este reporte lo evaluó, y llegó a la 13.13 sin cambios en las
secciones que este reporte cita: la 13.11 (reporte `26`) y la 13.12 (reporte `28`) no tocaron
`Root-Rules.md` §9/§10/§11/§12.1/§12.2 ni `Migracion-Rules.md` §3/§4. La verificación de las citas, el
recuento de los 118, la decisión de la solicitud 4 con su costo medido, el plan y la verificación
criterio por criterio están en
[`PROMPTs/Fixs/05-Fix-Reporte-27/OUTPUTs/`](../PROMPTs/Fixs/05-Fix-Reporte-27/OUTPUTs/).

### 8.1 Lo que la verificación le corrigió a este reporte antes de intervenir

**El cuerpo no se reescribe**: es evidencia con su fecha. Lo que la verificación encontró queda acá.

| Lo que el reporte afirma | Lo medido contra 13.12 y contra `Lab-Geometria` |
|---|---|
| Todas las citas a `Root-Rules.md` §9, §10, §11, §12.1, §12.2, `Migracion-Rules.md` §3, §4 y `Deriva-Rules.md` | **Siguen siendo literales.** Ninguna de las dos intervenciones anteriores de esta corrida las tocó |
| §2.4: los 118 diferidos de `Lab-Geometria` en **«tres recuentos… tomados en momentos distintos por instrumentos distintos»**, que **«no se pueden cruzar sin abrir los 118 uno por uno»** | **Sobredimensionado en este punto.** Los tres números —87, 25 y 6— salen de **una** tabla, en **un** documento, de **una** fecha (`Estado-Del-Destino-2026-09-12.md` §4), y ese documento cruza su propio recuento contra el del 08-27 con aritmética exacta (86+9+12+11=118 → 87+25+6=118, transición de 20 filas verificada), sin abrir los 118 ítems uno por uno. La reconciliación existe y **fue manual**, escrita por un orquestador de reanudación — que es el costo de reconstrucción que el reporte describe, no la ausencia de él |
| §2.4: ningún ítem declara contra qué estado del producto se difirió | **Se sostiene.** El campo que §12.2 ya exige —«en qué evento se cierra»— apunta hacia adelante, no hacia atrás. Ninguno de los 118 lleva un dato de origen |
| §2.1: el nombre `ciclo de origen`, elegido en la v1.1 sin verificar y reabierto en la v1.2 | **Confirmado, con la verificación que faltaba**: `grep -rn "ciclo de origen" SDD/Devs --include='*.md'` da cero antes de esta intervención, en los tres archivos donde el campo vive y en el resto del árbol |

**Ninguna corrección cae sobre el patrón central del reporte**, que seguía vivo en 13.12: los tres
instrumentos apuntaban hacia adelante y ninguno hacia atrás.

### 8.2 Desenlace de las seis preguntas de §5

| # | Pregunta | Desenlace |
|---|---|---|
| §5.1 | El campo de procedencia del hueco | **Sí: `ciclo de origen`**, con fase, unidad de trabajo y base de la corrida, calculado y congelado al declararse — no recalculado como el origen del hecho, porque el hueco se lee en corridas futuras y cada una tiene su propia base. `Root-Rules.md` §11/§12.1/§12.2; mecanismo en `Master-Prompt.md` §8.2 |
| §5.2 | El estado del producto contra el que se declaró | **No como campo declarado.** Se deriva del commit del ciclo de origen con `git show {{base}}:{{manifiesto}}`: lo que se puede derivar de un commit no se declara aparte (`Root-Rules.md` §10) |
| §5.3 | La clasificación que la migración necesita | **Sí**, `Migracion-Rules.md` §4.8: hueco del ciclo (se completa) contra hueco de norma posterior (se declara deuda), derivada del ciclo de origen contra el control de cambios de la regla citada. Sólo eleva lo que ninguna de las dos alcanza |
| §5.4 | El tratamiento retroactivo | **Derivar donde se pueda, marcar `no derivable — anterior al mecanismo` donde no** (`Migracion-Rules.md` §4.9), probado sobre una fila real de `Lab-Geometria` sin tocar ese destino. Ni exigir retroactivo ni vaciar sin más: las dos elevarían o perderían información que el propio commit todavía tiene |
| §5.5 | El criterio de aceptación enumerable | **Sí**: fila de escalamiento P1 en `Root-Rules.md` §12.2, dos criterios en `Migracion-Rules.md` §6, y comprobación 8 de `Master-Prompt.md` §10.0 que verifica presencia en generación |
| §5.6 | A qué rol se le atribuye | **Ninguno nuevo.** El orquestador que ya calcula el origen del hecho calcula el ciclo de origen con el mismo mecanismo y dos datos más. Confirma la posición del propio reporte: el dato primero, y con el dato el rol no hacía falta |

**§6, respetado.** Los tres instrumentos no se fusionaron. El ciclo de origen es un campo, no una marca
dentro del identificador. Ningún rol nuevo. No se afirma que los 118 de `Lab-Geometria` estén mal
declarados: se declaró qué versión les faltaba para poder derivarse. El reporte `25` no se tocó.

### 8.3 Los cinco criterios de §7, uno por uno

| # | Criterio | Veredicto |
|---|---|---|
| 1 | Declarar un hueco nuevo y comprobar que su ciclo de origen queda escrito sin que ningún agente lo tipee | **SIN VEREDICTO: requiere una corrida real posterior a la 13.13.** El mecanismo está escrito y no se ejerció, porque esta intervención no generó documentación de producto |
| 2 | Cruzar dos recuentos de diferidos sin abrir los ítems | **CUMPLIDO A MEDIAS, con el precedente del reporte `18`.** Se comprobó sobre `Lab-Geometria` que el total se cruza sin abrir los 118 (§8.1), pero con reconstrucción manual anterior al mecanismo, no con el campo puesto: no hay todavía un par de recuentos posteriores a la 13.13 que lo ejerzan |
| 3 | Correr una migración sobre huecos de las dos clases; el número elevado tiene que ser menor que el total | **SIN VEREDICTO: requiere correr `Migracion-Rules.md` §4.8 sobre un destino real**, y los destinos son de solo lectura para esta intervención. El criterio enumerable que lo exige está escrito |
| 4 | Probar el caso retroactivo sobre los 118 de `Lab-Geometria` | **CUMPLIDO A MEDIAS.** El mecanismo de §4.9 se probó con éxito sobre **una** fila real y no sobre las 118: correrlo entero es una migración sobre un destino, fuera de alcance acá |
| 5 | El criterio de §5.5, enumerable | **CUMPLIDO** |

**Un cumplido, dos a medias y dos sin veredicto.** El reporte se cierra **en el framework** —sus seis
preguntas tienen desenlace escrito y su hueco central está corregido— y **no se declara funcionando**:
tres de sus cinco criterios dependen de correr contra un destino real, que esta intervención no hace
por regla propia.

### 8.4 Lo que este reporte deja andando

- **Los tres criterios sin corrida real** (1, 3 y a medias 2 y 4) se ejercen recién cuando una
  migración normativa corra sobre un destino con huecos declarados — `Lab-Geometria` es el candidato
  natural, con sus 118.
- **El registro de coherencia queda para la próxima intervención sobre `Lab-Geometria`**: correr
  `Migracion-Rules.md` §4.8 y §4.9 sobre sus ocho documentos es lo que cerraría los criterios 2, 3 y 4
  enteros, no a medias.
- **Un hallazgo propio de esta verificación**: la mesa que originó el reporte `28` había medido el
  costo de calificar `procedencia` para el sentido de este reporte —35, y después 23— dando por
  supuesto que había que reusar esa palabra. Verificado antes de aplicar: **no hacía falta reusarla**,
  porque `ciclo de origen` no colisiona con nada. El costo de calificación correcto para este reporte
  es **cero**, no 23.

---

## Control de cambios

| Versión | Fecha | Cambios | Autor |
|---|---|---|---|
| 1.0 | 2026-09-12 | Emisión inicial. Documenta que los tres instrumentos del método para declarar lo que falta **apuntan hacia adelante y ninguno hacia atrás**, y que por eso una migración no puede distinguir un hueco del ciclo de un hueco de norma posterior sin reconstruirlo a mano. Mide el caso de los **118 ítems diferidos** de `Lab-Geometria` en tres recuentos no cruzables. Señala que `Deriva-Rules.md` ya demuestra que el framework sabe fechar una afirmación cuando decide hacerlo. Toma posición sobre el rol —**el dato primero, el rol después**— y declara el tratamiento retroactivo como pregunta de aplicación previa. | Mesa R1.5, ciclo 4 (AH-007 correlación con el historial), sobre un requisito del Product Owner |
| 1.1 | 2026-09-12 | **Corrección de nombre levantada al verificar el árbol**, antes de intervenir: el término **`procedencia` ya está tomado** por el framework con otro significado —la versión de formato bajo la que el destino se estructuró, con decenas de ocurrencias— de modo que el campo propuesto **no puede llamarse así** sin colisionar con un término vigente. Pasa a nombrarse **`ciclo de origen`**, y la acuñación definitiva queda para la intervención bajo `Vocabulario-Rules.md`. Se explicita además que §5.1 comparte fundamento con §5.3 del reporte `26` —el campo se **deriva**, no se pide—, que es la razón por la que las dos intervenciones van en ese orden. | Verificación previa de la intervención `05` |
| 1.2 | 2026-09-12 | **Corrección de una cita propia, levantada por el refutador de la mesa del 2026-09-12 y verificada contra el árbol**: §2.1 citaba `Intake-Rules.md` **§1.1**, sección que **no existe** en ese archivo; la oración está en **§2.1**, «Tabla maestra de documentos», línea 39. **Y queda declarado lo que importa más que la cita**: el renombre de `procedencia` a `ciclo de origen` que esta v1.1 introdujo **se hizo sin verificar las secciones destino del propio campo**. `Root-Rules.md` §11/§12.1/§12.2 —donde el campo viviría— tiene **cero** ocurrencias de `procedencia`. La decisión de nombre queda **reabierta** y es de la intervención `05`, con la evidencia del expediente de mesa en `PROMPTs/Fixs/05-Fix-Reporte-27/OUTPUTs/`. | Refutación del ciclo 5 |
| 1.3 | 2026-09-12 | **RESUELTO en SDD 13.13**, con su §8. La intervención confirmó `ciclo de origen` con la verificación que faltaba —cero colisiones— y corrigió una afirmación de evidencia: los 118 de `Lab-Geometria` no son tres recuentos inconexos, son tres categorías de una tabla que su propio destino ya cruzó una vez con reconstrucción manual, que es el costo que este reporte describe y no su ausencia. El campo entra como `Root-Rules.md` §11/§12.1/§12.2, calculado y congelado por `Master-Prompt.md` §8.2, y la clasificación de `Migracion-Rules.md` §4.8/§4.9 no exige retroactivo: deriva donde puede y marca no derivable donde no. Un criterio cumplido, dos a medias y dos sin veredicto hasta una migración real sobre un destino. | Intervención `05` |

