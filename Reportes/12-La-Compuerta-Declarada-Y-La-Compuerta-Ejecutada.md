# Reporte 12 — La compuerta mecánica está declarada en prosa y su ejecución depende del agente

| Campo | Valor |
|---|---|
| Reporte | 12 |
| Fecha | 2026-08-17 |
| Origen | Intervenciones SDD 9.11 a 9.13, sobre el catálogo de criterios y la compuerta mecánica. Discusión con el Product Owner sobre qué es un motor de decisiones y si el método puede tener uno |
| Versión del framework evaluada | SDD 9.13 (`Master-Prompt.md` §10.0; `SDD/Devs/Rules/Catalogo-De-Criterios.md` 1.2) |
| Artefactos del framework alcanzados | `SDD/Devs/Orchestrator/Master-Prompt.md` §10.0; las 16 reglas con tabla de anti-patrones; por extensión, la definición de alcance del framework |
| Naturaleza | Una propuesta de alcance, no un defecto. El framework funciona; la pregunta es si debe incorporar código ejecutable |
| Estado | **RESUELTO** — la decisión de alcance se tomó y se aplicó sobre el framework en **SDD 12.1**. Ver «Cómo se resolvió», al final |
| Reportes relacionados | `09-El-Audit-Como-Unica-Compuerta.md`, que originó la compuerta mecánica que este reporte propone volver ejecutable |

Este documento está escrito para ser **insumo de un prompt de intervención sobre el framework**, y
sigue la forma de los reportes `00` a `11`: evidencia primero, propuesta después, y lo que no se sabe
declarado como tal.

## Tabla de contenido

- [1. Resumen](#1-resumen)
- [2. Qué es la compuerta hoy, con evidencia](#2-qué-es-la-compuerta-hoy-con-evidencia)
- [3. Qué cambió en la 9.13 y qué no](#3-qué-cambió-en-la-913-y-qué-no)
- [4. La propuesta: un verificador reproducible](#4-la-propuesta-un-verificador-reproducible)
- [5. Lo que hay que decidir antes, y no es de implementación](#5-lo-que-hay-que-decidir-antes-y-no-es-de-implementación)
- [6. Argumentos en contra, que también son del framework](#6-argumentos-en-contra-que-también-son-del-framework)
- [7. Qué haría falta para decidir](#7-qué-haría-falta-para-decidir)
- [8. Referencias](#8-referencias)
- [Control de cambios](#control-de-cambios)

## 1. Resumen

`Master-Prompt.md` §10.0 define una **compuerta mecánica** que evalúa propiedades enumerables sobre el
árbol de una fase, antes de que el audit interprete nada. Desde la **9.13** su conjunto de reglas
incluye los **97 anti-patrones marcados `[enumerable]`** del catálogo, además de sus cinco
comprobaciones transversales.

**Está escrita en prosa, y la ejecuta un agente leyéndola.** No hay verificador: no existe un artefacto
que, dado un árbol, devuelva el mismo resultado dos veces sin intervención de un modelo.

**La propuesta de este reporte es escribir ese verificador**, y su costo real no es el código: es que
**el framework pasaría a contener software**, con todo lo que eso arrastra en versionado, auditoría y
mantenimiento. Es una decisión de alcance del método, y por eso se emite como reporte y no como
intervención.

## 2. Qué es la compuerta hoy, con evidencia

`Master-Prompt.md` §10.0 enumera cinco comprobaciones transversales, todas de naturaleza enumerable:

```text
1. Enlaces y anclas: toda referencia resuelve
2. Recuentos anclados contra su fuente (Root-Rules §10 R2)
3. Idempotencia de los generadores: correr dos veces produce los mismos bytes
4. Identificadores: forma y ancho conformes, sin duplicados
5. Anclaje de las referencias (Root-Rules §10 R5)
```

*Evidencia: `awk '/^### §10\.0/,/^### §10\.1/' SDD/Devs/Orchestrator/Master-Prompt.md` sobre la versión
9.13 del conjunto.*

**La distinción que la sostiene ya existía**: `[enumerable]` frente a `[interpretativo]`, incorporada
por la intervención de los reportes `00` a `11` a raíz del reporte `09`. En la 9.13 hay **645 usos** de
esa marca en criterios de aceptación y **202** en tablas de anti-patrones.

**Y funciona.** Durante la migración de un destino real, la comprobación de enlaces detectó **44 y
luego 94 enlaces rotos** producidos por retirar carpetas de fusión, en dos categorías consecutivas. Sin
ella, esas roturas se habrían descubierto tarde o nunca.

## 3. Qué cambió en la 9.13 y qué no

**Cambió el alcance:** la compuerta pasó de cinco reglas cableadas a esas cinco **más los anti-patrones
`[enumerable]` de la regla de la categoría en curso**.

**No cambió la naturaleza:** sigue siendo **prosa normativa que un agente lee y ejecuta**. Las
consecuencias son tres, y ninguna es hipotética:

| Consecuencia | Por qué |
| --- | --- |
| **No es reproducible por definición** | Dos agentes —o el mismo dos veces— pueden aplicar la misma prosa con distinto rigor |
| **No deja evidencia estructurada** | El resultado de la compuerta es lo que el agente escribe, no un registro con formato fijo |
| **Su cobertura no se puede medir** | No hay forma de saber cuántas de las 97 se evaluaron efectivamente en una corrida |

**Ninguna de las tres es un defecto de la 9.13.** Son propiedades de un framework que es normativa y no
software. Se enuncian acá porque son exactamente lo que un verificador resolvería.

## 4. La propuesta: un verificador reproducible

Un artefacto que, dado el árbol de una fase, evalúe las comprobaciones enumerables y devuelva un
resultado con formato fijo. **No reemplaza a la compuerta: la ejecuta.**

**Lo que resuelve:**

- **Reproducibilidad.** El mismo árbol da el mismo resultado, sin depender de qué agente corre.
- **Evidencia estructurada.** Un informe con una fila por comprobación y su veredicto, que el audit
  consume en lugar de rehacer.
- **Cobertura medible.** Se puede afirmar «se evaluaron 97 de 97», que hoy no se puede.

**Lo que no resuelve, y conviene no prometerlo:** las comprobaciones `[interpretativo]` —**105 de las
202**— siguen siendo del audit y del humano. Un verificador cubre poco más de la mitad del catálogo.

## 5. Lo que hay que decidir antes, y no es de implementación

**El framework, hasta hoy, no contiene código ejecutable.** Es normativa en Markdown, versionada por
intervención, archivada por versión en `_legacy/` y auditada leyendo. Incorporar un verificador cambia
cuatro cosas, y **ninguna es técnica**:

1. **Qué significa versionar el conjunto.** Hoy una versión es un estado del texto. Con código, una
   versión es texto **más** un comportamiento, y los dos pueden divergir: un verificador que
   implementa la regla anterior es peor que no tenerlo, porque decide con autoridad de máquina.
2. **Cómo se audita.** `SDD-Development-Guide.md` §VI.3 define doce comprobaciones para intervenir el
   framework, todas sobre texto. Ninguna contempla probar código.
3. **Quién lo mantiene.** Cada regla nueva con anti-patrones enumerables exigiría actualizar el
   verificador, y el método ya tiene registrado qué pasa cuando algo depende de que alguien se acuerde.
4. **Dónde vive.** En el repositorio del framework —y entonces todo destino depende de poder
   ejecutarlo— o en cada destino —y entonces hay tantas versiones como destinos—.

**El punto 1 es el que más pesa**, y tiene precedente en el propio método: la 9.10 registró que un
snapshot de `_legacy/` corrido un lugar hacía que el diff normativo de un salto **saliera vacío**, y
una migración se declarara completa sin aplicar nada. Un verificador desincronizado produce la misma
clase de falla: **una afirmación de conformidad que nadie comprobó**.

## 6. Argumentos en contra, que también son del framework

**El principio de estado objetivo.** `Migracion-Rules.md` §3 rechazó escribir playbooks por salto de
versión con un fundamento que aplica igual acá:

> El estado objetivo ya está declarado y no hay que escribirlo. […] Un playbook la duplicaría, y **una
> duplicación que hay que mantener en paralelo se desincroniza**.

Un verificador que reimplementa las condiciones **es** esa duplicación. La 9.13 evitó el problema
haciendo que la compuerta **lea la regla de la categoría** en vez de copiarla; un verificador escrito
aparte lo reintroduce, salvo que **derive sus reglas del texto** en lugar de codificarlas — que es
posible y es la variante que este reporte recomienda evaluar primero.

**Y una observación sobre la dirección de la industria, que corta para los dos lados.** La gobernanza
de agentes de 2026 pide registrar por cada acción la decisión de política y el paso de razonamiento
previo, con la auditabilidad como requisito crítico. Eso **favorece** tener un verificador —produce
justamente ese registro—. Pero el mismo cuerpo de práctica ubica el control **en tiempo de ejecución
del agente**, no en un artefacto separado que el agente podría no invocar.

## 7. Qué haría falta para decidir

Este reporte **no propone una decisión**: propone lo que hay que medir para tomarla.

| Pregunta | Cómo se contesta |
| --- | --- |
| ¿Cuántos de los 97 `[enumerable]` son evaluables sin leer prosa? | Muestra de una regla completa, clasificando cada anti-patrón por lo que haría falta para verificarlo |
| ¿Puede el verificador **derivar** sus reglas del texto en vez de codificarlas? | Prueba sobre una tabla: ¿alcanza la columna de detección y el nombre del anti-patrón? |
| ¿Cuánto cuesta mantenerlo? | Contar cuántas intervenciones de la serie 9.x habrían exigido tocarlo |
| ¿Dónde vive? | Depende de si un destino debe poder correrlo sin el repositorio del framework |

**Ninguna de las cuatro está contestada hoy**, y el reporte se emite sin contestarlas a propósito: son
mediciones, no opiniones.

## 8. Referencias

| # | Fuente | Consultada |
|---|---|---|
| 1 | [OMG — Standard for Decision Model and Notation (DMN)](https://www.omg.org/intro/DMN.pdf) | 2026-08-17 |
| 2 | [DMN Tutorial — Camunda](https://camunda.com/dmn/), de donde se verifican las políticas de coincidencia `Unique` y `Collect` | 2026-08-17 |
| 3 | [Agentic AI Governance Playbook — IBM](https://www.ibm.com/think/insights/agentic-ai-governance-playbook) | 2026-08-17 |
| 4 | [Runtime Governance for AI Agents: Policies on Paths — arXiv](https://arxiv.org/html/2603.16586v1) | 2026-08-17 |

**Evidencia interna**, reproducible sobre `IA.SDD` en la versión 9.13:

| Afirmación | Cómo verificarla |
|---|---|
| Las cinco comprobaciones transversales de §10.0 | `awk '/^### §10\.0/,/^### §10\.1/' SDD/Devs/Orchestrator/Master-Prompt.md` |
| 97 `[enumerable]` y 105 `[interpretativo]` en anti-patrones | `Catalogo-De-Criterios.md` §4, tabla por regla |
| 645 marcas en criterios de aceptación | `grep -rn '\[enumerable\]\|\[interpretativo\]' SDD/Devs/Rules` |
| El framework no contiene código ejecutable | `find SDD -type f -not -name '*.md'` |


---

## Cómo se resolvió

**Estado: RESUELTO.** La decisión de alcance se tomó y quedó escrita en el framework en la intervención
**SDD 12.1**. Su nota de coherencia es `SDD/Devs/Guides/Coherencia-Sin-Codigo-Ejecutable.md`.

### La decisión

**El framework no distribuye código ejecutable.** Quedó como `SDD-Development-Guide.md` **§II.7**, el
séptimo contrato interno, con el anti-patrón correspondiente en la Parte V y su fila en
`Catalogo-De-Criterios.md`.

### Por qué se decidió sin contestar las cuatro mediciones del §7

**Porque el fundamento en contra no dependía de ellas.** Este reporte lo dejó escrito en su propio §6:
`Migracion-Rules.md` §3 rechazó los playbooks por salto de versión con el argumento de que *«una
duplicación que hay que mantener en paralelo se desincroniza»*, y **un verificador que reimplementa las
condiciones de las reglas es exactamente esa duplicación**. Las cuatro mediciones dimensionan el costo
de construirlo; ninguna toca el argumento que lo desaconseja.

**Y hay un hecho que el reporte no podía ver en su fecha:** entre la 9.13 que evaluó y la 12.1, el
framework publicó **treinta y cuatro versiones** resolviendo con texto todo lo que este reporte
imaginaba resolviendo con código —la compuerta mecánica, el barrido por concepto, la migración por
árbol declarado—. `find SDD -type f -not -name '*.md'` devuelve vacío en las cuarenta y siete versiones
publicadas. **La pregunta se contestó por acumulación de decisiones y nadie la había registrado.**

### Lo que este reporte consiguió, y no es lo que proponía

**Su §5 pedía que la decisión se tomara antes que la implementación, y eso es lo que ocurrió.** El
reporte se emitió a propósito sin proponer una decisión —*«propone lo que hay que medir para
tomarla»*—, y esa abstención es lo que evitó que el framework incorporara un verificador por inercia
técnica. **El aporte fue la pregunta, no la respuesta.**

### Lo que quedó abierto, y cómo se reabre

**Las cuatro mediciones del §7 siguen sin hacer** y §II.7 las declara como su **condición de
reapertura**: cuántos de los 97 `[enumerable]` son evaluables sin leer prosa, si un verificador puede
**derivar** sus reglas del texto en vez de codificarlas, cuánto cuesta mantenerlo, y dónde viviría. Si
alguien las mide y dan a favor, §II.7 se revisa por §III.8 como cualquier contrato interno.

**Un cierre que declara qué lo revertiría es contestable; uno que no lo declara se lee como definitivo
sin serlo.**

### La frontera, que es lo que faltaba

§II.7 no prohíbe los comandos: el corpus **ya publica comandos** —el barrido de §VI.3.2 es el caso—, y
una prohibición sin frontera los habría vuelto ilegítimos. Lo que la sección declara es **por qué no son
código distribuido**: no se versionan aparte, no se instalan, y **no pueden desincronizarse de la regla
porque viven en el mismo documento que la regla**. Lo prohibido es el artefacto ejecutable **con versión
propia**, que es el que puede divergir del texto sin que ninguna comprobación lo vea.

## Control de cambios

| Versión | Fecha | Cambios |
|---|---|---|
| 1.0 | 2026-08-17 | Reporte inicial. La compuerta mecánica está declarada en prosa y su ejecución depende del agente que la lee: no es reproducible, no deja evidencia estructurada y su cobertura no se puede medir. Se propone evaluar un verificador, se declara que la decisión es **de alcance del método y no de implementación**, y se enumeran las cuatro mediciones que faltan para decidir. |
| 1.1 | 2026-08-23 | **Cerrado.** La decisión de alcance se tomó: el framework **no** distribuye código ejecutable, y quedó escrita como `SDD-Development-Guide.md` §II.7 en **SDD 12.1**. Se decidió sin contestar las cuatro mediciones del §7 porque el fundamento en contra —la duplicación que se desincroniza, `Migracion-Rules.md` §3— no dependía de ellas, y porque entre la 9.13 evaluada y la 12.1 el framework resolvió con texto todo lo que este reporte imaginaba resolviendo con código. Las cuatro mediciones quedan declaradas en §II.7 como **condición de reapertura**. Entra la sección «Cómo se resolvió» y el estado pasa a **RESUELTO**. |
