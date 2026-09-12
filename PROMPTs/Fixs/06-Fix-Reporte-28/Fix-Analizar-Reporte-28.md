# Tool-Prompt — Análisis y Fix del reporte 28

> **Invocación**: Leer y ejecutar `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/06-Fix-Reporte-28/Fix-Analizar-Reporte-28.md`
>
> **Overview**: Evaluar el `Framework SDD` contra el reporte **28** —la afirmación de colisión léxica no tiene compuerta, ni regla que la alcance—, decidir un plan de corrección y aplicarlo sobre el framework.

---

## Contexto

Leer `/IA/SDD/IA.SDD/README.md`: es un `Framework SDD` (Spec-Driven Development) para especificar y programar con asistencia de IA.

**El reporte a aplicar es uno solo:**

- [`28-La-Afirmacion-De-Colision-Lexica-No-Tiene-Compuerta-Ni-Regla-Que-La-Alcance.md`](../../../Reportes/28-La-Afirmacion-De-Colision-Lexica-No-Tiene-Compuerta-Ni-Regla-Que-La-Alcance.md) — estado **Abierto**, evaluado contra SDD **13.10**.

**Y sus expedientes de mesa, que son evidencia primaria y no resumen:**
[`05-Fix-Reporte-27/OUTPUTs/Mesa-2026-09-12-Colision-Lexica/`](../05-Fix-Reporte-27/OUTPUTs/Mesa-2026-09-12-Colision-Lexica/) — contrato de entrada, cuatro informes verbatim, la refutación y el cierre. **Viven en la carpeta de la `05` porque el caso nació ahí**; esta intervención los lee, no los mueve.

**Por qué no entran los otros.** Verificar el estado en [`Reportes/README.md`](../../../Reportes/README.md) **antes** de fijar el alcance, y no heredarlo del nombre de la carpeta. **Ninguno entra acá.**

**El orden, y por qué ésta va segunda.** Las cuatro intervenciones de la corrida del 2026-09-12 se aplican en este orden: **`04` (reporte `26`) → ésta → `05` (reporte `27`) → `03` (reporte `25`)**. Ésta va antes que la `05` por una dependencia concreta: **la `05` tiene que decidir el nombre de un campo** que colisiona o no según la unidad de contexto de `Migracion-Rules.md`, y esa unidad es lo que esta intervención declara (§5.4 del reporte). Aplicar la `05` antes obligaría a decidir un nombre con la regla que se está por corregir. **Verificar al empezar que la `04` esté aplicada**; si no lo está, decidir explícitamente si se espera o se avanza, y declararlo.

**Lo que este reporte tiene de distinto, y conviene saber antes de empezar.** Es el único de la serie cuya evidencia central son **errores de quien lo escribió**: seis afirmaciones sin verificar, en un cuadro. **Esta intervención va a producir afirmaciones sobre el mismo terreno** —cuántas ocurrencias, en qué sección, si colisiona—, y el reporte mide que el modo de falla no se compensa con cuidado. **Toda afirmación de colisión o de recuento que esta intervención escriba lleva su comando y su salida al lado**, desde el primer borrador. Es aplicarse el criterio que se viene a escribir antes de escribirlo.

---

## Permisos y límites, que son distintos de los habituales

- **Acá SÍ se escribe sobre `/IA/SDD/IA.SDD/`.** Es una intervención sobre el framework y es su propósito. En todo el resto del trabajo ese repositorio es de sólo lectura; ésta es la excepción y no se extiende a nada más.
- **`PROMPTs/` es del usuario: sólo lectura**, incluida esta carpeta salvo sus `OUTPUTs`.
- **No se toca ningún repositorio de destino.** Si la corrección impacta destinos, se **declara** en el plan.
- Trabajar sobre árbol limpio. Si `git status` no está limpio en `IA.SDD`, detenerse y decirlo.

---

## Objetivo

Determinar si los huecos que el reporte 28 describe siguen vivos en la versión vigente del framework y, si lo están, **decidir si corresponde cerrarlos y con qué alcance**, corrigiéndolos con una intervención verificada contra los criterios que el propio reporte declara.

**«Si corresponde» no es una fórmula de cortesía.** Una decisión negativa con fundamento escrito es un desenlace válido —precedente, el reporte `12`—. Lo que no es legítimo es no decidir.

---

## Solicitudes

**1 · Verificar primero qué ya está resuelto.** El reporte evaluó **SDD 13.10**. Por **cada** cita —`Vocabulario-Rules.md` cabecera, §1, §8, §9.1 a §9.6 y §10; `Master-Prompt.md` §10.0 y §15; la cabecera de `Migracion-Rules.md`; los insumos de `Master-Prompt-Migracion.md`; `Root-Rules.md` §13; `SDD-Development-Guide.md` §VI.3.1—, abrir el archivo vigente y decir si sigue siendo literal. **Un reporte es evidencia, no autoridad, y éste en particular documenta seis citas que estaban mal.**

**2 · Reproducir los recuentos con sus comandos, no citarlos.** El reporte trae tres: los 19/18/0 de §2.1, los 23 + 22 de §2.6 y la sección de §15 con cero. **Correr los comandos que el propio reporte muestra** y pegar la salida en `OUTPUTs`. Si alguno no da, ése es el primer hallazgo de la intervención.

**3 · Respetar las seis cosas que el reporte declara que NO afirma (§6).** En particular, las tres que son trampas:

- **No crear un registro de términos acuñados.** Se evaluó a pedido del Product Owner y se rechazó con evidencia —`Mesa-Rules.md` §6.1—. Si la intervención llega a algo que se le parece, **eso es el hallazgo**, no la solución.
- **No mecanizar los trece criterios.** Se pide **uno**. Mecanizar de más es declarar enumerable lo que no lo es, y `Vocabulario-Rules.md` §10 nombra esa falsa confianza como el error peor.
- **No hacer que la compuerta decida colisiones.** Localiza; decide un lector.

**4 · Decidir la pregunta de fondo, que ordena a las otras cuatro: el alcance de la regla (§5.1).** `Vocabulario-Rules.md` §8 declara gobernar seis términos, la cabecera todos, y §9.6 ya aplica §9 a uno que no es de los seis. **Decidirlo primero**, porque §5.2 a §5.5 no se pueden ubicar sin saber qué archivo gobierna. La mesa llegó a una posición —§8 está desactualizado— y la dejó escrita como punto de partida, **no como decisión**.

**Y decir qué pasa con `Master-Prompt.md` §15**, al que §8 remite el vocabulario del método: si §15 **define** y §9 **decide la colisión**, el reparto queda limpio y el reporte `11` no se reabre. Si la intervención concluye otra cosa, **declarar si reabre el `11`** y por qué.

**Si la contradicción no se puede resolver con el árbol**, `Root-Rules.md` §13 **no alcanza** —el conflicto es interno a un archivo, no entre dos reglas— y rige `Master-Prompt.md` §8.1: se detiene con el formato completo, incluido qué pasa si no se responde. **No resolverla por criterio propio.**

**5 · Las otras cuatro preguntas de §5 se deciden explícitamente, una por una**, con fundamento escrito, aunque la decisión sea no hacer nada:

| # | La pregunta | Qué hay que decidir |
|---|---|---|
| §5.2 | El criterio enumerable | Si entra, con qué redacción, y **si exige comando reproducible** —no prosa que diga «revisé»—. La refutación lo atacó con el caso del comando falso; el reporte dice por qué sobrevive. **Verificar ese argumento, no heredarlo** |
| §5.3 | Dónde corre | Si vive sólo en `Vocabulario-Rules.md` §10 o también en `Mesa-Rules.md` y en la guía §VI.3. **Si vive sólo en §10, es cosmético para el acto que lo originó** —la refutación lo marcó P1—; decir cómo alcanza a la verificación previa de una intervención, que es donde ocurrió el caso |
| §5.4 | La unidad de contexto por lector | Si §9.2 declara la unidad **para cada tipo de lector**. La tabla ya existe dispersa en los insumos de cada orquestador: **enumerarla desde ahí**, no suponerla |
| §5.5 | La mitad mecánica en la compuerta | Si §10.0 localiza ocurrencias de términos **declarados como acuñados o renombrados**, por la unidad de §5.4, **como insumo del auditor y nunca como veredicto**. Medir el volumen sobre el árbol real antes de decidir |

**6 · §5.6 no se decide acá.** El nombre de los campos de los reportes `26` y `27` es de las intervenciones `04` y `05`. Esta intervención **sólo deja las reglas con las que se va a decidir**, y declara en su cierre qué cambió para esas dos.

**7 · Diagnosticar y producir evidencia en `OUTPUTs`.** Escribir en `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/06-Fix-Reporte-28/OUTPUTs/`: el resultado de las solicitudes 1 y 2 **con los comandos y sus salidas**, la decisión de la solicitud 4 con su fundamento, el plan, y la verificación criterio por criterio.

**8 · Generar un plan de aplicación unificado.** Por cada cambio: qué artefacto toca, qué versión sube y con qué severidad, qué se preserva, y **qué destinos existentes quedan alcanzados**.

**9 · Aplicar el plan, y corroborar que lo aplicado se corresponde con lo propuesto.** Un cambio aplicado que el plan no declara es un hallazgo de la propia intervención. **Si el cambio agrega o modifica un término, el barrido de §VI.3.1 se corre y su comando queda en la nota de coherencia.**

**10 · Verificar contra los seis criterios de §7 del reporte, uno por uno, con veredicto explícito.**

**Los decisivos son el 3 y el 4**, porque reproducen los dos errores reales: afirmar una colisión sin comando **tiene que ser hallazgo por vía del método**, y proponer calificar una sección de un archivo que se lee íntegro **tiene que dar el costo del archivo sin que haga falta un refutador**. Si alguno de los dos no se puede reproducir dentro del framework, **declararlo cumplido a medias** con el precedente del reporte `18`.

**Y el criterio 6 es el que protege contra la sobrecorrección**: un término con contextos disjuntos **no** puede aparecer como hallazgo.

**11 · Cerrar el circuito documental**, que el README de la serie declara incumplido **seis veces**. En el **mismo commit** que el cambio:

1. El reporte `28` pasa a `RESUELTO en SDD <versión>` y suma su sección **«Cómo se resolvió»**, con el desenlace de cada pregunta de §5 y el veredicto de cada criterio de §7.
2. `Reportes/README.md` cierra la fila y actualiza el estado de la serie.
3. El `CHANGELOG.md` del framework suma su entrada con la decisión major/minor.
4. El README de esta serie (`PROMPTs/Fixs/README.md`) actualiza el estado de la intervención `06`.

**12 · Declarar el impacto sobre destinos existentes.** Si la corrección de §8 cambia qué términos gobierna la regla, **todo destino generado queda alcanzado** por una regla de alcance mayor. El bloque «Impacto sobre destinos existentes» del `CHANGELOG.md` **no puede decir «ninguno»** sin haberlo medido.

**13 · Si encontrás un conflicto entre dos reglas que la corrección no pueda resolver**, aplicá `Root-Rules.md` §13 y declaralo; no lo resuelvas por criterio propio.

---

## Reglas

- **No inventar información.**
- **Toda afirmación debe estar respaldada por evidencia verificable**: archivo y sección, o comando y su salida.
- **Toda afirmación de colisión o de recuento lleva su comando al lado, desde el primer borrador.** Es el criterio que esta intervención viene a escribir.
- **Medir antes de corregir.** Los números del reporte se reproducen, no se citan.
- **Declarar lo que no se pudo verificar**, y por qué.
- **Una decisión negativa es un desenlace válido y se escribe.** El precedente es el reporte `12`.
- Entregar: el resultado de las solicitudes 1 y 2 con sus comandos, la decisión de la solicitud 4 con su fundamento, el plan, los cambios aplicados con su verificación criterio por criterio, y el cierre documental de la solicitud 11.
