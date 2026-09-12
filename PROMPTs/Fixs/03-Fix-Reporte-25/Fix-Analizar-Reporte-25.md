# Tool-Prompt — Análisis y Fix del reporte 25

> **Invocación**: Leer y ejecutar `/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/03-Fix-Reporte-25/Fix-Analizar-Reporte-25.md`
>
> **Overview**: Evaluar el `Framework SDD` contra el reporte **25** —el producto evoluciona y el método no tiene dónde registrarlo—, decidir un plan de corrección y aplicarlo sobre el framework.

---

## Contexto

Leer `/IA/SDD/IA.SDD/README.md`: es un `Framework SDD` (Spec-Driven Development) para especificar y programar con asistencia de IA.

**El reporte a aplicar es uno solo:**

- [`25-El-Producto-Evoluciona-Y-El-Metodo-No-Tiene-Donde-Registrarlo.md`](../../../Reportes/25-El-Producto-Evoluciona-Y-El-Metodo-No-Tiene-Donde-Registrarlo.md) — estado **Abierto**, evaluado contra SDD **13.10**.

**Por qué no entran los otros que quedan sin aplicar.** Verificar el estado en
[`Reportes/README.md`](../../../Reportes/README.md) **antes** de fijar el alcance, y no heredarlo del
nombre de la carpeta anterior —es la advertencia que el README de esta serie deja escrita—. **El
estado que este párrafo declaraba al emitirse ya cambió, y se corrige acá en vez de dejarlo envejecer**:
decía que el `16` tenía su intervención (`02`) «sin aplicar», y la `02` está declarada **sin objeto**
porque el `16` se resolvió en SDD 13.6. El `17` y los `19` a `24` siguen abiertos sin intervención
asignada. **Ninguno entra acá**: el `25` se aplica solo porque **toca un eje que ninguno de los otros
toca** —qué hace el método cuando cambia el alcance del producto— y mezclarlo con correcciones de otros
ejes produciría una intervención que nadie puede auditar por partes.

**Esta intervención es la última de cuatro, y corre sobre un framework que ya cambió.** El orden de la
corrida del 2026-09-12 es **`04` (reporte `26`) → `06` (reporte `28`) → `05` (reporte `27`) → ésta**, y
el reporte `25` se evaluó contra SDD **13.10**, antes de las tres. **Verificar al empezar, en el
`CHANGELOG.md`, que las tres estén aplicadas**, y leer sus entradas: las tres tocan terreno que esta
intervención pisa.

- La `04` agregó **el origen del hecho**, calculado contra **la base de la corrida**, y **el lote de la
  fase**. Una decisión de producto posterior al handoff es exactamente la clase de hecho cuyo origen hay
  que calcular antes de elevarla.
- La `06` fijó **qué términos gobierna `Vocabulario-Rules.md` y con qué unidad de contexto**. Si esta
  intervención acuña vocabulario —un estado de vida del producto, por ejemplo, que es su pregunta
  §5.4—, la colisión se decide con esa regla y **se afirma con su comando al lado**.
- La `05` decidió **cómo se registra el ciclo de origen de un hueco**. El disparador que esta
  intervención decide abre un ciclo nuevo: **los huecos que ese ciclo declare tienen que salir ya
  correlacionables**, y conviene reutilizar la pieza de la `05` en vez de inventar otra.

**Lo que este reporte tiene de distinto, y conviene saber antes de empezar.** Los veinticuatro
anteriores señalan defectos en cómo el método especifica, propaga o audita. **El `25` señala algo que
el método no hace**, y su corrección **agrega** en lugar de arreglar. Eso cambia el riesgo: el modo de
falla típico de esta intervención no es corregir mal, es **corregir de más** —inventar una maquinaria
paralela a la que ya existe— o **corregir en el lugar equivocado** —enganchar el disparador aguas abajo
de donde nace la decisión—. Las dos trampas están nombradas en el propio reporte, §6.

---

## Permisos y límites, que son distintos de los habituales

- **Acá SÍ se escribe sobre `/IA/SDD/IA.SDD/`.** Es una intervención sobre el framework y es su propósito. En todo el resto del trabajo ese repositorio es de sólo lectura; ésta es la excepción y no se extiende a nada más.
- **`PROMPTs/` es del usuario: sólo lectura**, incluida esta carpeta salvo sus `OUTPUTs`.
- **No se toca ningún repositorio de destino** (`PROG2/`, `Ng/`, `Repos-RPIs/`, etc.). `Lab-Geometria` es el destino que originó el reporte y **acá no se modifica**: si la corrección impacta destinos, se **declara** en el plan.
- Trabajar sobre árbol limpio. Si `git status` no está limpio en `IA.SDD`, detenerse y decirlo.

---

## Objetivo

Determinar si el hueco que el reporte 25 describe sigue vivo en la versión vigente del framework y, si
lo está, **decidir si corresponde cerrarlo y con qué alcance**, corrigiéndolo con una intervención
verificada contra los criterios que el propio reporte declara.

**«Si corresponde» no es una fórmula de cortesía.** El reporte pregunta cinco cosas y **ninguna
presupone su respuesta**. Una intervención que concluya, con fundamento escrito, que el método **no
debe** recibir cambios de alcance posteriores al handoff, es un desenlace legítimo y hay precedente: el
reporte `12` se resolvió **decidiendo que no**, y esa decisión se escribió en la guía de desarrollo.
Lo que no es legítimo es no decidir.

---

## Solicitudes

**1 · Verificar primero qué ya está resuelto.** El reporte evaluó **SDD 13.10**. Por **cada** cita que
usa como evidencia —`Master-Prompt.md` §7, §12 y §13; `Master-Prompt-Reanudacion.md` §0, §1 y §4;
`Rules-Backlog-Tecnico.md` §3.4 y §3.6; `Rules-Plan-Sprint.md` §3.6; `Rules-Documentacion.md` §0.6;
`Migracion-Rules.md` §0 y §3; `Vocabulario-Rules.md` §2 y §3; el glosario de `Master-Prompt.md` §15—,
abrir el archivo en la versión vigente y decir si la cita sigue siendo literal. **Un reporte es
evidencia, no autoridad**: si alguna cita ya no dice lo que el reporte transcribe, eso se declara antes
de usarla.

**2 · Leer el reporte por sus secciones, con la función que el README de la serie les asigna**: los
incidentes como evidencia de que el hueco produce defectos reales; «lo que el framework resuelve bien»
como delimitación de **lo que no hay que tocar**; la causa raíz para que la corrección no ataque el
síntoma; **el patrón enunciado (§4) como lo que hay que corregir**; las propuestas de §5 como punto de
partida y no como decisión tomada; y §7 como criterio de aceptación.

**3 · Respetar las seis cosas que el reporte declara que NO afirma (§6).** En particular, las dos que
son trampas de esta intervención:

- **No enganchar el disparador al backlog.** El reporte lo dice con su fundamento: el backlog es aguas
  abajo de la `US`, que es aguas abajo del caso de uso, que es aguas abajo del intake. Empezar por ahí
  **invierte la trazabilidad que el propio método declara**, y produce un `Backlog-Tecnico.md v2.0`
  sobre un intake que sigue afirmando el alcance viejo.
- **No pedirle al framework un control ejecutable.** El framework no distribuye código y no debe
  hacerlo —está decidido y escrito—. La pregunta §5.5 es por un **ítem de trabajo con criterio de
  verificación**, que es un artefacto documental.

**4 · Empezar por el eje de extensión que ya existe, en vez de inventar uno.**
`SDD-Development-Guide.md` Parte III §III.4 resolvió este mismo tipo de problema al agregar las Fases I
y J, y hace las preguntas correctas: si el instrumento corre una vez, una vez por unidad o una vez por
incremento; cuál es su precondición; qué regenera y qué preserva. **Aplicarlo antes de proponer una
figura nueva**, y si se concluye que la figura nueva hace falta, decir por qué §III.4 no alcanzaba.

**5 · Decidir la pregunta de fondo, que ordena a las otras cuatro: ¿corresponde un tercer caso de
escritura del intake?** `Master-Prompt.md` §13 cierra la lista en dos, con esas palabras. El reporte
sostiene que falta uno simétrico al de migración pero disparado por un evento de producto. **Decidirlo
primero**, porque si la respuesta es que no, las preguntas §5.2 a §5.5 cambian de forma o dejan de
tener objeto.

**6 · Las otras cuatro preguntas de §5 se deciden explícitamente, una por una**, con su fundamento
escrito, aunque la decisión sea no hacer nada:

| # | La pregunta | Qué hay que decidir |
|---|---|---|
| §5.2 | El evento que reabre backlog, plan de sprint y roadmap | Si existe, cuál es, y quién lo declara. Conviene que sea **el mismo** que el de §5.1, para que no haya dos |
| §5.3 | El criterio para distinguir nomenclatura, enmarcamiento y cambio estructural | Si el criterio que la mesa propuso —¿el hecho modifica una fila de la matriz del roadmap, o el conjunto de proyectos de código del manifiesto?— es observable y suficiente, o hace falta otro |
| §5.4 | El estado de vida del producto | Si `Vocabulario-Rules.md` necesita un término para «en producción con fase de construcción abierta», y qué gobierna el trabajo en ese estado |
| §5.5 | El salto de la decisión al control | Si una decisión de esta clase debe producir un ítem de trabajo con criterio de verificación, o basta con el ADR |

**7 · Declarar qué pasa con la salida `D` de la reanudación.** `Master-Prompt-Reanudacion.md` §4 supone
que la etapa siguiente ya está en el roadmap. Si la corrección introduce un caso en que **no lo está**,
esa salida necesita decir qué hace; y si no lo introduce, declararlo.

**8 · Diagnosticar y producir evidencia en `OUTPUTs`.** Escribir los resultados intermedios en
`/IA/SDD/IA.SDD.Documentacion/PROMPTs/Fixs/03-Fix-Reporte-25/OUTPUTs/`: el resultado de la solicitud 1,
el plan, y la verificación criterio por criterio.

**9 · Generar un plan de aplicación unificado.** El plan declara, por cada cambio: qué artefacto toca,
qué versión sube y con qué severidad, qué se preserva, y **qué destinos existentes quedan alcanzados**.

**10 · Aplicar el plan, y corroborar que lo aplicado se corresponde con lo propuesto.** Un cambio
aplicado que el plan no declara es un hallazgo de la propia intervención.

**11 · Verificar contra los criterios de §7 del reporte, uno por uno, con veredicto explícito.** Son
enumerables y se reproducen sobre un destino: los seis pasos de §7 tienen que dar un resultado distinto
del que dieron cuando se escribió el reporte, **o la intervención declara por qué no**.

**El decisivo es el paso 5 de §7**: hoy `Rules-Backlog-Tecnico.md` §3.4 sabe **qué hacer** y ninguna
regla dice **cuándo**. Si después de la intervención sigue sin decirlo, el hueco sigue vivo por más que
se haya escrito una fase nueva.

**12 · Cerrar el circuito documental**, que el README de la serie declara incumplido **seis veces** —tres
al emitir un reporte sin su fila y tres al resolverlo sin cerrarla—. En el **mismo commit** que el
cambio:

1. El reporte `25` pasa a `RESUELTO en SDD <versión>` y suma su sección **«Cómo se resolvió»**, con el
   desenlace de cada una de las cinco preguntas de §5 y **el veredicto de cada criterio de §7, uno por
   uno**.
2. `Reportes/README.md` cierra la fila y actualiza el estado de la serie.
3. El `CHANGELOG.md` del framework suma su entrada con la decisión major/minor.
4. El README de esta serie (`PROMPTs/Fixs/README.md`) actualiza el estado de la intervención `03`.

**13 · Declarar el impacto sobre destinos existentes.** Si la corrección obliga a un destino ya generado
a emitir un artefacto nuevo, a reabrir su backlog o a renombrar algo, **el bloque «Impacto sobre
destinos existentes» del `CHANGELOG.md` no puede decir «ninguno»**, y la severidad del salto se decide
con eso a la vista. Hay un destino que va a consumir esta corrección de inmediato —`Lab-Geometria`, con
dos cambios de producto sin recibir—, y conviene decir qué le va a exigir.

**14 · Si encontrás un conflicto entre dos reglas que la corrección no pueda resolver**, aplicá
`Root-Rules.md` §13 (precedencia entre reglas) y declaralo; no lo resuelvas por criterio propio.

---

## Reglas

- **No inventar información.**
- **Toda afirmación debe estar respaldada por evidencia verificable**: archivo y sección, o comando y su salida.
- **Medir antes de corregir.** Si el reporte afirma un número o una cita, verificalo antes de usarlo como base.
- **Declarar lo que no se pudo verificar**, y por qué.
- **Una decisión negativa es un desenlace válido y se escribe.** El precedente es el reporte `12`.
- Entregar: el resultado de la solicitud 1, la decisión de la solicitud 5 con su fundamento, el plan, los cambios aplicados con su verificación criterio por criterio, y el cierre documental de la solicitud 12.
