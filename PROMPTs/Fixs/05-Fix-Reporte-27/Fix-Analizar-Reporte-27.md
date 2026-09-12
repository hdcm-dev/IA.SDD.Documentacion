# Tool-Prompt — Análisis y Fix del reporte 27

> **Invocación**: Leer y ejecutar `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/05-Fix-Reporte-27/Fix-Analizar-Reporte-27.md`
>
> **Overview**: Evaluar el `Framework SDD` contra el reporte **27** —la especificación no se puede correlacionar con el ciclo que la produjo—, decidir un plan de corrección y aplicarlo sobre el framework.

---

## Contexto

Leer `/IA/SDD/IA.SDD/README.md`: es un `Framework SDD` (Spec-Driven Development) para especificar y programar con asistencia de IA.

**El reporte a aplicar es uno solo:**

- [`27-La-Especificacion-No-Se-Puede-Correlacionar-Con-El-Ciclo-Que-La-Produjo.md`](../../../Reportes/27-La-Especificacion-No-Se-Puede-Correlacionar-Con-El-Ciclo-Que-La-Produjo.md) — estado **Abierto**, evaluado contra SDD **13.10**.

**Por qué no entran los otros.** Verificar el estado en
[`Reportes/README.md`](../../../Reportes/README.md) **antes** de fijar el alcance, y no heredarlo del
nombre de la carpeta anterior. Al emitirse este prompt hay reportes abiertos sin intervención asignada
(`19` a `24`) y tres intervenciones emitidas y sin aplicar (`02`, `03`, `04`). **Ninguno entra acá.**

**El orden importa, y es una precondición de ésta.** Esta intervención es **la tercera de cuatro** de
la misma corrida: el orden decidido es **`04` (reporte `26`) → `06` (reporte `28`) → ésta → `03`
(reporte `25`)**.

**De la `06` depende el nombre del campo.** El reporte `27` v1.1 renombró `procedencia` a `ciclo de
origen` **sin verificar sus propias secciones destino** —`Root-Rules.md` tiene **cero** ocurrencias— y
esa decisión **quedó reabierta** en su v1.2. El nombre se decide acá, pero **con la unidad de contexto
que fija la `06`**: la mesa midió que si la clasificación que el `27` propone se escribe en
`Migracion-Rules.md`, ese archivo **se declara a sí mismo como un único contexto de lectura** y el costo
de una familia calificada es de **45 ocurrencias**, no cero. **Verificar al empezar que la `06` esté
aplicada.** La evidencia está en esta misma carpeta, `OUTPUTs/Mesa-2026-09-12-Colision-Lexica/`.

**Y de la `04` depende el mecanismo.** La razón es que el mecanismo que acá se
decide —un campo derivado que se calcula en vez de declararse— **es la misma forma** que la intervención
`04` resuelve para la procedencia de una detención. Si el `26` ya se aplicó, acá se **reutiliza** su
pieza en vez de inventar una segunda. **Verificar al empezar si el `26` está aplicado**, y si no lo
está, decidir explícitamente si se espera o se avanza declarando el riesgo de duplicar mecanismo.

**Lo que este reporte tiene de distinto.** Como el `25`, señala algo que el método **no hace**, y su
corrección **agrega** en vez de arreglar. Pero tiene una particularidad que ninguno de los otros tiene:
**su aplicación se topa de entrada con un pasivo ya escrito** —118 ítems diferidos sin el campo que se
va a exigir—, y si eso no se decide antes, la primera migración que corra los eleva a los 118. Es §5.4
del reporte y es la pregunta de aplicación, no un detalle de implementación.

---

## Permisos y límites, que son distintos de los habituales

- **Acá SÍ se escribe sobre `/IA/SDD/IA.SDD/`.** Es una intervención sobre el framework y es su propósito. En todo el resto del trabajo ese repositorio es de sólo lectura; ésta es la excepción y no se extiende a nada más.
- **`PROMPTs/` es del usuario: sólo lectura**, incluida esta carpeta salvo sus `OUTPUTs`.
- **No se toca ningún repositorio de destino.** `Lab-Geometria` es el destino que originó el reporte y aporta el caso medido de los 118; **acá no se modifica**. Si la corrección lo alcanza, se **declara** en el plan.
- Trabajar sobre árbol limpio. Si `git status` no está limpio en `IA.SDD`, detenerse y decirlo.

---

## Objetivo

Determinar si el hueco que el reporte 27 describe sigue vivo en la versión vigente del framework y, si
lo está, **decidir si corresponde cerrarlo y con qué alcance**, corrigiéndolo con una intervención
verificada contra los criterios que el propio reporte declara.

**«Si corresponde» no es una fórmula de cortesía.** Una intervención que concluya, con fundamento
escrito, que el costo de anotar procedencia en cada hueco **no compensa** —porque la historia de git ya
la contiene y reconstruirla es barato— es un desenlace legítimo. Lo que no es legítimo es no decidir, ni
decidirlo sin medir ese costo de reconstrucción sobre un caso real.

---

## Solicitudes

**1 · Verificar primero qué ya está resuelto.** El reporte evaluó **SDD 13.10**. Por **cada** cita que
usa como evidencia —`Root-Rules.md` §9, §10, §11, §12.1 y §12.2; `Migracion-Rules.md` §3 y §4;
`Deriva-Rules.md` y sus tipos de evidencia; `Rules-Documentacion.md` §0.6—, abrir el archivo vigente y
decir si la cita sigue siendo literal. **Un reporte es evidencia, no autoridad.**

**2 · Verificar el caso medido antes de usarlo.** El reporte afirma **118 ítems diferidos** de
`Lab-Geometria` en tres recuentos —**87**, **25** y **6**— y que **no se pueden cruzar**. Verificar los
tres números contra sus fuentes, y verificar la afirmación fuerte: que ningún ítem declara contra qué
estado del producto se difirió. **Si alguno lo declara, el reporte está sobredimensionado y eso se dice
antes de usarlo como fundamento.**

**3 · Respetar las cinco cosas que el reporte declara que NO afirma (§6).** En particular:

- **No fusionar los tres instrumentos.** `referencia pendiente`, `ítem diferido` y `apartamiento
  declarado` son tres figuras distintas por buenas razones. Lo que se evalúa es un campo común, no una
  figura común.
- **No meter el ciclo dentro del identificador.** `Root-Rules.md` §9 los quiere estables; un
  identificador que lleve el ciclo adentro deja de serlo. **El dato va como campo.**
- **No resolver esto con un rol nuevo.** La posición del reporte es explícita: **el dato primero, el rol
  después**. Un rol de correlación sin el dato sigue reconstruyendo a mano.

**4 · Decidir la pregunta de aplicación antes que las de diseño: ¿qué pasa con los huecos ya
declarados?** Es §5.4, y tiene tres salidas posibles —exigirlo retroactivamente, dejarlo vacío con un
valor explícito de «anterior al mecanismo», o derivarlo donde se pueda y marcarlo como no derivable
donde no—. **Decidirla primero**, porque las tres producen intervenciones distintas y porque la
respuesta equivocada convierte la primera migración en la tanda de preguntas que el reporte `26` quiere
evitar. El costo de cada salida se mide sobre los 118 de `Lab-Geometria`, no se estima.

**5 · Las otras cinco preguntas de §5 se deciden explícitamente, una por una**, con fundamento escrito,
aunque la decisión sea no hacer nada:

| # | La pregunta | Qué hay que decidir |
|---|---|---|
| §5.1 | El campo de procedencia del hueco | Si los tres instrumentos llevan ciclo y unidad de trabajo, y **si se deriva del contexto de la corrida o se escribe a mano** |
| §5.2 | El estado del producto contra el que se declaró | Si además llevan versión del producto, y cuál es la fuente de ese dato |
| §5.3 | La clasificación que la migración necesita | Si `Migracion-Rules.md` deriva de esos campos **hueco del ciclo** vs. **hueco de norma posterior**, y qué eleva: sólo lo que ninguna de las dos reglas alcanza |
| §5.5 | El criterio de aceptación enumerable | Si se exige que ningún hueco posterior a la aplicación carezca de ciclo de origen |
| §5.6 | La atribución del rol | Si alcanza con que el agente de migración lo ejerza, o hace falta sumar uno a la orquestación — **y esto se contesta después de §5.1, no antes** |

**6 · Reutilizar antes de inventar.** Dos piezas del framework ya resuelven la forma de este problema y
hay que evaluarlas explícitamente antes de proponer una tercera:

- **`Deriva-Rules.md`**, cuyo tipo de evidencia `ejecucion` ya ancla una afirmación a un momento
  verificable. El reporte lo señala como prueba de que el framework sabe fechar cuando decide hacerlo.
- **`SDD-Development-Guide.md` Parte III §III.4**, que hace las preguntas correctas para agregar un
  instrumento: si corre una vez, una vez por unidad o una vez por incremento; cuál es su precondición;
  qué regenera y qué preserva.

Si se concluye que hace falta una figura nueva, **decir por qué ninguna de las dos alcanzaba**.

**7 · Declarar la relación con el reporte `25` y con el `26`.**

- Con el **`25`**: aquél trata el **disparador** del ciclo y éste el **formato del hueco** dentro de él.
  Son separables y se decidió aplicarlos separados. **Si durante la intervención aparece que no lo son,
  eso es un hallazgo** y se declara en vez de fusionarlos por comodidad.
- Con el **`26`**: los dos piden un dato de procedencia derivado. **Si el `26` ya se aplicó, reutilizar
  su mecanismo**; si se crea uno paralelo, decir por qué el existente no servía.

**8 · Diagnosticar y producir evidencia en `OUTPUTs`.** Escribir los resultados intermedios en
`/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/05-Fix-Reporte-27/OUTPUTs/`: el resultado de las solicitudes
1 y 2, la decisión de la solicitud 4 con su costo medido, el plan, y la verificación criterio por
criterio.

**9 · Generar un plan de aplicación unificado.** Por cada cambio: qué artefacto toca, qué versión sube y
con qué severidad, qué se preserva, y **qué destinos existentes quedan alcanzados**.

**10 · Aplicar el plan, y corroborar que lo aplicado se corresponde con lo propuesto.** Un cambio
aplicado que el plan no declara es un hallazgo de la propia intervención.

**11 · Verificar contra los cinco criterios de §7 del reporte, uno por uno, con veredicto explícito.**

**El decisivo es el criterio 3**: correr una migración sobre un árbol con huecos de las dos clases y
contar cuántos se elevan. **Si el número es igual a la cantidad total de huecos, la clasificación de
§5.3 no está funcionando**, por más que el campo se esté escribiendo. Y el criterio 4 —el caso
retroactivo sobre los 118— es el que prueba que la decisión de la solicitud 4 era la correcta.

**Si alguno de los criterios no se puede reproducir dentro del framework** —porque exige correr una
migración sobre un destino, y los destinos son de sólo lectura acá—, **declararlo cumplido a medias**
con el precedente del reporte `18`, en vez de darlo por resuelto.

**12 · Cerrar el circuito documental**, que el README de la serie declara incumplido **seis veces**. En
el **mismo commit** que el cambio:

1. El reporte `27` pasa a `RESUELTO en SDD <versión>` y suma su sección **«Cómo se resolvió»**, con el
   desenlace de cada una de las seis preguntas de §5 y el veredicto de cada criterio de §7.
2. `Reportes/README.md` cierra la fila y actualiza el estado de la serie.
3. El `CHANGELOG.md` del framework suma su entrada con la decisión major/minor.
4. El README de esta serie (`PROMPTs/Fixs/README.md`) actualiza el estado de la intervención `05`.

**13 · Declarar el impacto sobre destinos existentes.** Esta corrección alcanza a **todo destino con
huecos declarados**, que son todos. El bloque «Impacto sobre destinos existentes» del `CHANGELOG.md`
**no puede decir «ninguno»**, y la severidad del salto se decide con la decisión de la solicitud 4 a la
vista.

**14 · Si encontrás un conflicto entre dos reglas que la corrección no pueda resolver**, aplicá
`Root-Rules.md` §13 (precedencia entre reglas) y declaralo; no lo resuelvas por criterio propio.

---

## Reglas

- **No inventar información.**
- **Toda afirmación debe estar respaldada por evidencia verificable**: archivo y sección, o comando y su salida.
- **Medir antes de corregir.** Los 118 se cuentan, no se citan.
- **El costo de una salida se mide sobre el caso real**, no se estima.
- **Declarar lo que no se pudo verificar**, y por qué.
- **Una decisión negativa es un desenlace válido y se escribe.** El precedente es el reporte `12`.
- Entregar: el resultado de las solicitudes 1 y 2, la decisión de la solicitud 4 con su costo medido, el plan, los cambios aplicados con su verificación criterio por criterio, y el cierre documental de la solicitud 12.
