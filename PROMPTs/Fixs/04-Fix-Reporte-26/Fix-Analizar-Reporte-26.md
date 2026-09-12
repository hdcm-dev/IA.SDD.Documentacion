# Tool-Prompt — Análisis y Fix del reporte 26

> **Invocación**: Leer y ejecutar `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/04-Fix-Reporte-26/Fix-Analizar-Reporte-26.md`
>
> **Overview**: Evaluar el `Framework SDD` contra el reporte **26** —la pregunta previa no distingue quién generó la situación—, decidir un plan de corrección y aplicarlo sobre el framework.

---

## Contexto

Leer `/IA/SDD/IA.SDD/README.md`: es un `Framework SDD` (Spec-Driven Development) para especificar y programar con asistencia de IA.

**El reporte a aplicar es uno solo:**

- [`26-La-Pregunta-Previa-No-Distingue-Quien-Genero-La-Situacion.md`](../../../Reportes/26-La-Pregunta-Previa-No-Distingue-Quien-Genero-La-Situacion.md) — estado **Abierto**, evaluado contra SDD **13.10**.

**Por qué no entran los otros que quedan sin aplicar.** Verificar el estado en
[`Reportes/README.md`](../../../Reportes/README.md) **antes** de fijar el alcance, y no heredarlo del
nombre de la carpeta anterior. Al emitirse este prompt hay reportes abiertos sin intervención asignada
(`19` a `24`) y dos intervenciones emitidas y sin aplicar (`02` sobre el `16`, `03` sobre el `25`).
**Ninguno entra acá.**

**Y hay una razón de orden, no sólo de alcance.** Esta intervención es **la primera de cuatro** que
salieron de la misma corrida, y el orden decidido es **ésta → `06` (reporte `28`) → `05` (reporte `27`) →
`03` (reporte `25`)**. El motivo es concreto: las otras tres tocan mecanismos que, mientras este hueco
siga vivo, **van a producir consultas al humano** durante su propia aplicación. Corregir primero la
compuerta de escalada hace que las otras no lleguen como una tanda de preguntas sueltas. **Si esta intervención se ejecuta fuera
de ese orden, declararlo y decir por qué.**

**El nombre del campo, y una advertencia medida.** El reporte `26` llama al dato `origen del hecho`. **La
mesa del 2026-09-12 verificó que `procedencia` no colisiona en `Master-Prompt.md` §8, §8.1 ni §9**, así
que el nombre es libre y lo decide esta intervención. Pero esa mesa también documentó —reporte `28`— **seis
afirmaciones de colisión o recuento escritas sin medir en el mismo trabajo**. Toda afirmación de ese tipo
que esta intervención escriba **lleva su comando y su salida al lado**.

**Lo que este reporte tiene de distinto.** No dice que una regla esté mal escrita: dice que **una
decisión se toma con un solo eje** y que falta un eje anterior. Su modo de falla típico no es corregir
mal, es **corregir en la forma y no en el fondo** —agregar un campo que el agente llena solo, y que un
agente que no se dio cuenta de que generó el problema va a llenar de buena fe con el valor equivocado—.
Esa trampa está nombrada en el propio reporte, §5.3, y la corrección que propone es **derivar el dato en
vez de pedirlo**.

---

## Permisos y límites, que son distintos de los habituales

- **Acá SÍ se escribe sobre `/IA/SDD/IA.SDD/`.** Es una intervención sobre el framework y es su propósito. En todo el resto del trabajo ese repositorio es de sólo lectura; ésta es la excepción y no se extiende a nada más.
- **`PROMPTs/` es del usuario: sólo lectura**, incluida esta carpeta salvo sus `OUTPUTs`.
- **No se toca ningún repositorio de destino** (`PROG2/`, `Ng/`, `Repos-RPIs/`, etc.). `Lab-Geometria` es el destino que originó el reporte y **acá no se modifica**: si la corrección impacta destinos, se **declara** en el plan.
- Trabajar sobre árbol limpio. Si `git status` no está limpio en `IA.SDD`, detenerse y decirlo.

---

## Objetivo

Determinar si el hueco que el reporte 26 describe sigue vivo en la versión vigente del framework y, si
lo está, **decidir si corresponde cerrarlo y con qué alcance**, corrigiéndolo con una intervención
verificada contra los criterios que el propio reporte declara.

**«Si corresponde» no es una fórmula de cortesía.** Una intervención que concluya, con fundamento
escrito, que la asimetría de costos de `Master-Prompt.md` §8.1 **debe seguir mandando detener incluso
sobre estado propio** —porque el costo de que un agente se autoabsuelva es mayor que el de una consulta
de más— es un desenlace legítimo, y hay precedente: el reporte `12` se resolvió decidiendo que no. Lo
que no es legítimo es no decidir.

---

## Solicitudes

**1 · Verificar primero qué ya está resuelto.** El reporte evaluó **SDD 13.10**. Por **cada** cita que
usa como evidencia —`Master-Prompt.md` §7.0, §8, §8.1 y §9; `Mesa-Rules.md` §0.1, §0.2 y §7;
`Master-Prompt-Reanudacion.md` §6; y la medición de `Memoria-De-Antecedentes-Casos-Resueltos.md` §2.2—,
abrir el archivo vigente y decir si la cita sigue siendo literal. **Un reporte es evidencia, no
autoridad.**

**2 · Verificar las dos afirmaciones por ausencia**, que son las que sostienen el reporte y las que más
fácil se dan por buenas:

- Que **ningún** artefacto del conjunto normativo tiene un término para «estado que el propio agente
  produjo y no cerró». Verificar con búsqueda sobre todo `/IA/SDD/IA.SDD/`, y **decir con qué términos
  se buscó**.
- Que **ninguno** de los formatos de detención tiene un campo de procedencia. Enumerar los formatos que
  se revisaron; si hay más de los tres que el reporte nombra, decirlo.

**3 · Respetar las cuatro cosas que el reporte declara que NO afirma (§6).** En particular:

- **No reabrir el reporte `13`.** La pregunta previa de una sola línea está decidida con fundamento. Lo
  que se evalúa es una cláusula **anterior**, no un eje de estratos paralelo. Si la corrección termina
  pareciéndose a lo que el `13` rechazó, **eso es el hallazgo**, no la solución.
- **No proponer un rol nuevo sin demostrar que los existentes no alcanzan.** El orquestador al cerrar
  fase y el presidente de mesa cuando la mesa corre ya tienen el mandato de mirar el conjunto.

**4 · Decidir la pregunta de fondo, que ordena a las otras cuatro: ¿la procedencia se deriva o se
declara?** Es §5.3. **Decidirla primero**, porque si se decide que se declara, §5.1, §5.2 y §5.5 cambian
de forma —y el criterio de verificación del reporte, paso 3 de §7, deja de poder distinguir una
corrección real de una cosmética.

**Si se decide derivar**, hay que resolver dónde está el dato: el método archiva el estado previo antes
de despachar cada unidad. Verificar **que ese archivo efectivamente contiene lo necesario** para
decidir si un hecho preexistía, y si no lo contiene, decir qué le falta. **No suponerlo.**

**5 · Las otras cuatro preguntas de §5 se deciden explícitamente, una por una**, con fundamento escrito,
aunque la decisión sea no hacer nada:

| # | La pregunta | Qué hay que decidir |
|---|---|---|
| §5.1 | La cláusula anterior a la pregunta previa | Si existe, dónde vive —`Master-Prompt.md` §8.1 o una regla aparte— y qué hace cuando la respuesta es «sí, la generé yo» |
| §5.2 | La tercera fila de la tabla de autocorrección | Si el estado a medias propio merece fila propia, y cuál es su resolución: mirar el conjunto de lo producido, no el punto donde se tropezó |
| §5.4 | El agrupamiento antes de la primera salida | Si el registro debe agrupar **toda** detención de la fase en curso y no sólo lo ya diferido, y si la cláusula de §5.1 se aplica sobre el lote |
| §5.5 | El criterio de aceptación enumerable | Si se exige que ninguna detención con procedencia propia salga sin declarar por qué la autocorrección no alcanzaba |

**6 · Declarar el efecto sobre la mesa.** `Mesa-Rules.md` declara su condición de convocatoria y **no**
una lista de puntos, y lo justifica con un caso real. Si la corrección de §5.4 termina agregando un
punto fijo de invocación, **está contradiciendo esa decisión** y hay que decirlo y resolverlo por
`Root-Rules.md` §13, no por criterio propio.

**7 · Diagnosticar y producir evidencia en `OUTPUTs`.** Escribir los resultados intermedios en
`/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/04-Fix-Reporte-26/OUTPUTs/`: el resultado de las solicitudes
1 y 2, la decisión de la solicitud 4 con su fundamento, el plan, y la verificación criterio por criterio.

**8 · Generar un plan de aplicación unificado.** Por cada cambio: qué artefacto toca, qué versión sube y
con qué severidad, qué se preserva, y **qué destinos existentes quedan alcanzados**.

**9 · Aplicar el plan, y corroborar que lo aplicado se corresponde con lo propuesto.** Un cambio
aplicado que el plan no declara es un hallazgo de la propia intervención.

**10 · Verificar contra los cinco criterios de §7 del reporte, uno por uno, con veredicto explícito.**

**El decisivo es el criterio 3, y está escrito al revés a propósito**: si en una corrida con la
corrección aplicada la cuenta de detenciones con procedencia propia es **cero**, la corrección **no**
está funcionando. Ese cero es el síntoma de que el campo se está autoinformando. Una intervención que
festeje el cero no leyó el reporte.

**11 · Declarar la medición pendiente.** El reporte §2.4 dice que la causa que lo origina es una
**tercera**, distinta de las dos que el framework ya midió, y que **no está medida**. La intervención no
puede darla por medida: o aporta el caso real de esta clase, o **declara el criterio 1 de §7 como
cumplido a medias**, con el precedente del reporte `18`, que hizo exactamente eso en vez de darse por
resuelto.

**12 · Cerrar el circuito documental**, que el README de la serie declara incumplido **seis veces**. En
el **mismo commit** que el cambio:

1. El reporte `26` pasa a `RESUELTO en SDD <versión>` y suma su sección **«Cómo se resolvió»**, con el
   desenlace de cada una de las cinco preguntas de §5 y el veredicto de cada criterio de §7.
2. `Reportes/README.md` cierra la fila y actualiza el estado de la serie.
3. El `CHANGELOG.md` del framework suma su entrada con la decisión major/minor.
4. El README de esta serie (`PROMPTs/Fixs/README.md`) actualiza el estado de la intervención `04`.

**13 · Declarar el impacto sobre destinos existentes.** Si la corrección obliga a un destino ya generado
a declarar procedencia en detenciones abiertas, **el bloque «Impacto sobre destinos existentes» no puede
decir «ninguno»**. `Lab-Geometria` tiene escaladas abiertas al emitirse este prompt: decir qué les exige.

**14 · Si encontrás un conflicto entre dos reglas que la corrección no pueda resolver**, aplicá
`Root-Rules.md` §13 (precedencia entre reglas) y declaralo; no lo resuelvas por criterio propio.

---

## Reglas

- **No inventar información.**
- **Toda afirmación debe estar respaldada por evidencia verificable**: archivo y sección, o comando y su salida.
- **Medir antes de corregir.** Si el reporte afirma un número o una cita, verificalo antes de usarlo como base.
- **Las afirmaciones por ausencia se verifican con la búsqueda a la vista**, no se heredan del reporte.
- **Declarar lo que no se pudo verificar**, y por qué.
- **Una decisión negativa es un desenlace válido y se escribe.** El precedente es el reporte `12`.
- Entregar: el resultado de las solicitudes 1 y 2, la decisión de la solicitud 4 con su fundamento, el plan, los cambios aplicados con su verificación criterio por criterio, y el cierre documental de la solicitud 12.
