# OUTPUT 20 — La decisión de fondo (solicitud 5) y las cuatro restantes de §5

## Solicitud 5 — ¿corresponde un tercer caso de escritura del intake?

**No.**

### Fundamento

`Master-Prompt.md` §13 regla 1: *«Toda invocación al manifiesto o a un intake **durante la generación**
es lectura»*. La regla 2 lista dos casos y ambos comparten una propiedad que el reporte no nombra pero
que es la que decide la pregunta: **los dos ocurren durante una corrida de un orquestador** — el caso
(a) durante la generación misma, el caso (b) durante la fase M2 de la migración normativa, con sus tres
condiciones acumulativas de propuesta/diff/aprobación porque un agente reescribe una sección que no
decidió él.

Una decisión de alcance del Product Owner posterior al handoff no tiene esa forma: ocurre con el sistema
en producción, sin ninguna corrida en curso. El intake es, por `Migracion-Rules.md` §4.4, **documento
humano** — su autoría no se delega. La regla 1 nunca prohibió que su autor lo edite fuera de una
corrida, porque nunca tuvo que hacerlo: su ámbito es «durante la generación».

**Evidencia de que esto ya es así, medida y no supuesta.** El propio reporte, §2.4, midió veinte
decisiones de producto absorbidas en el intake de `Lab-Geometria`, diecisiete después de «Aprobado».
Ninguna de esas veinte violó la regla 1 ni necesitó ampararse en la regla 2: ocurrieron fuera del
ámbito que esas reglas gobiernan. La v4.0 del intake, que el reporte describe como «un tercer caso de
facto» (§2.4, párrafo final), no lo es: es un caso que §13 nunca tuvo jurisdicción para prohibir ni para
exigir en una forma particular.

**Por qué escribir un tercer caso sería la trampa que el propio reporte nombra en su §6 y en el
prompt de esta intervención («corregir en el lugar equivocado»).** Ponerle a este acto las tres
condiciones acumulativas de la migración estructural —propuesta antes de escritura, nada se rellena,
bump major— regularía como si fuera un agente reescribiendo trabajo ajeno lo que en realidad es el
Product Owner escribiendo lo suyo. La consecuencia sería invertir la relación de autoría que
`Migracion-Rules.md` §4.4 ya fija: el intake dejaría de ser del Product Owner y pasaría a necesitar el
permiso de un orquestador que, en el momento en que la decisión se toma, no está corriendo.

**Precedente.** Es una decisión negativa con fundamento escrito, del mismo tipo que el reporte `12`
resolvió — citado en el prompt de esta intervención como el antecedente de que «no» es un desenlace
legítimo.

**Consecuencia sobre el orden de las preguntas.** El prompt de intervención advierte: «si la respuesta
es que no, las preguntas §5.2 a §5.5 cambian de forma o dejan de tener objeto». Cambian de forma: dejan
de preguntar por el intake y pasan a preguntar por lo que está aguas abajo de él — el criterio y el
disparo hacia el backlog, el plan y el roadmap, que es donde realmente faltaba algo.

### Qué eje de extensión se probó antes de escribir algo nuevo (solicitud 4)

`SDD-Development-Guide.md` §III.4 («agregar una fase al orquestador») se aplicó primero, por instrucción
explícita del prompt. Sus tres preguntas —¿corre una vez, por unidad o por incremento?; ¿qué
precondición?; ¿qué se regenera y qué se preserva?— no tienen respuesta útil acá: el hueco no es de una
fase del orquestador de generación, es de un evento que ocurre **fuera de toda corrida**, con el sistema
ya en producción. No hay cardinalidad de §III.4 que lo cubra porque §III.4 resuelve extensiones del
bucle de fases, y este caso vive fuera del bucle. Se declara explícitamente: **§III.4 no alcanzaba**, no
por defecto de la guía, sino porque el objeto que hay que extender no es una fase.

Lo que se ensambló en su lugar no es una figura nueva: son los instrumentos que el método ya tiene —
`Rules-Backlog-Tecnico.md` §3.4 (versionado por cambio de alcance, que ya existía) y `Root-Rules.md`
§12.2 (ítem diferido, que ya existía) — con el disparador que les faltaba.

## §5.2 — El evento que reabre backlog, plan y roadmap

**Sí, existe y se declara: la entrada de control de cambios que el Product Owner asienta en el
`PRODUCT-INTAKE` al registrar una decisión de alcance posterior al handoff.**

Es el mismo evento para los tres artefactos (backlog, roadmap; el plan de sprint no se reabre porque
`Rules-Plan-Sprint.md` §3.6 ya declara que un plan cerrado no cambia de versión — lo que se reabre es el
backlog, que alimenta el sprint siguiente). Cumple el criterio de `Master-Prompt-Reanudacion.md` §1.1
R3: es subproducto del acto de decidir y asentarlo, no una tarea nueva que alguien tiene que acordarse
de ejecutar por separado.

Implementado en `Master-Prompt.md` §13.1 (declara el evento y remite), `Rules-Backlog-Tecnico.md` §3.6
(declara la mecánica una sola vez) y `Rules-Contexto.md` §3.5 (cita la misma mecánica para
`Roadmap-Producto.md`, sin duplicarla).

## §5.3 — El criterio para distinguir nomenclatura, enmarcamiento y cambio estructural

**Sí, el que propuso la mesa que originó el reporte, adoptado tras verificarlo contra los dos casos que
el propio reporte midió.**

> El hecho nuevo modifica una fila de la matriz fase-épica-sprint-release del roadmap —incluido el
> contenido declarado de una fila ya existente, no solo el alta o la baja de una fila— o el conjunto de
> proyectos de código del manifiesto.

**Verificación contra los dos casos del reporte:**

- **Caso 1 (topología de despliegue, X-10 realizada el 2026-09-06).** `Roadmap-Producto.md` 1.9 fila
  `i` declaraba el entregable «front por FTP» y el criterio de transición correspondiente. La decisión
  del Product Owner cambia el **contenido declarado de esa fila** (qué topología se entrega), no
  agrega ni quita filas. El criterio, en su forma ampliada («incluido el contenido de una fila ya
  existente»), lo alcanza. En su forma literal de la mesa («modifica una fila») sin esa ampliación, no
  lo habría alcanzado — es la corrección que esta intervención le hizo al criterio antes de adoptarlo.
- **Caso 2 (todos los proyectos de código bajo el árbol de la solución, especificado el 2026-09-11 y
  fusionado el 2026-09-12).** Cambia directamente el conjunto de proyectos de código de
  `PRODUCT-MANIFEST` §13. El criterio lo alcanza en su forma original.

**Conclusión: el criterio es observable y suficiente para los dos casos medidos**, con el ajuste
explícito de que «modificar una fila» incluye modificar su contenido y no solo su presencia. Se declara
la ampliación porque, sin ella, el primer caso medido —el que más costo produjo, según §2.3 del
reporte— habría quedado fuera del criterio que se supone que lo cubre.

## §5.4 — El estado de vida del producto

**Sí hace falta nombrarlo, y no en `Vocabulario-Rules.md`.**

`Vocabulario-Rules.md` §2 titula su sección «Los seis términos» y §8 (13.12) declara que esa sección
gobierna significado y precedencia **sobre esos seis**, no sobre cualquier término del framework. Un
estado de un producto —no una entidad de identidad como producto, unidad de entrega o proyecto de
código— no es del dominio de §2, y agregarlo ahí rompería el propio título de la sección y su alcance
recién fijado por la 13.12.

El vocabulario propio del método, por el mismo §8 (13.12) y por `Vocabulario-Rules.md` §9 (criterio de
colisión, aplicable a todo término), se define en el glosario operativo de `Master-Prompt.md` §15. Se
adopta ahí el término **`vigencia operativa abierta`**, verificado sin colisión antes de escribirse:

```bash
grep -rn "vigencia operativa\|evento de cambio de alcance" SDD/Devs --include='*.md'
```

Cero ocurrencias en el árbol previo a esta intervención (verificado con `git stash` sobre el árbol de
trabajo modificado, exit code 1 de `grep`).

**Qué gobierna el trabajo en ese estado.** No se crea gobierno nuevo: el roadmap sigue gobernando qué
sigue (con la salvedad de la salida D de la reanudación, ver §7 más abajo), el backlog y el plan de
sprint gobiernan el trabajo del incremento, y la operación (runbooks, `Rules-Documentacion.md` §0.6)
gobierna los incidentes. Lo que el término nombra es la condición bajo la cual ninguno de los tres puede
darse por descontado sin verificar si el evento de §5.2 ocurrió.

## §5.5 — El salto de la decisión al control

**Sí, reusando instrumentos existentes y no inventando un control ejecutable** (prohibición explícita
del reporte en su §6, y del prompt de intervención en su solicitud 3).

Cuando el evento de §5.2 dispara la clasificación de §5.3 como estructural, `Rules-Backlog-Tecnico.md`
§3.6 exige que se emita **al menos una `BT-XXXXX` con criterio de aceptación**, o —si la decisión
todavía no se puede resolver en el sprint en curso— **un ítem diferido de `Root-Rules.md` §12.2**, con
su evento de cierre nombrado como artefacto y sección. Las dos figuras ya existen; no se crea una
tercera.

**Aplicado al costo medido en el reporte (§2.3):** la decisión de mantener el canal de FTP «como
alternativa y como antecedente de despliegue» —correcta y sin ningún artefacto que la sostenga, según
el propio reporte— es exactamente el caso que un ítem diferido de `Root-Rules.md` §12.2 resuelve: «qué
falta» (una restricción operativa: no publicar automáticamente por ese canal), «por qué no se puede hoy»
(depende de una decisión de infraestructura que el Product Owner ya declaró), «quién lo cierra» y «en
qué evento», en lugar de quedar, como quedó, indistinguible de un descuido.
