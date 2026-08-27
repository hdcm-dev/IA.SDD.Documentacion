---
doc_id: OUT-2026-08-27-etapa-preplanificadora
doc_type: analisis
title: La etapa preplanificadora — evaluación, decisión de ubicación e integración de la mesa evaluadora
status: vigente
origin: agent
confidence: alta — toda afirmación se sostiene con cita al archivo y sección del framework o de sus informes
owner: AG-00990 (Arquitecto de Soluciones)
fecha: 2026-08-27
---

# La etapa preplanificadora — evaluación, decisión de ubicación e integración

**Prompt de origen:** `PROMPTs/Features/18-Migracion-Planificacion/Crear-Estapa-Pre-Planificadora-Migracion.md`
**Insumo:** `INPUTs/Mesa-Evaluadora.md`
**Conjunto resultante:** SDD **13.7**

---

## Resumen ejecutivo

**Qué se pedía.** Evaluar los prompts de reanudación y de migración, evaluar el marco de la mesa
evaluadora, integrarlo como motor de orquestación previo a reparar/migrar/continuar, y **determinar en
qué momento conviene aplicarlo**.

**Qué se encontró.** El hueco existe y **no era una impresión: estaba medido dos veces en el propio
framework**, de los dos lados del mismo defecto. Nadie abre el corpus de un destino antes de decidir
qué hacer con él.

**Qué se decidió.** La mesa entra como **mecanismo, no como cuarto orquestador**, y corre en **un solo
momento** —después de leer el estado, antes de aprobar el plan— que aparece en dos prompts porque el
plan es el contrato entre ellos.

**Qué se rechazó.** Cuatro de los nueve mecanismos del marco de origen, porque el método ya los tiene
y duplicarlos habría creado conjuntos cerrados en conflicto.

---

## 1. Evaluación de lo que hay

### 1.1 El diagnóstico del prompt de origen es correcto, y el framework ya lo había medido

El prompt de origen afirma que el método *«entra en rondas solicitando o consultando sobre temas que
se suponen ya resueltos»* y que *«no hace una mirada analítica y estratégica completa de la
especificación/implementación ya existente antes de retomarla»*.

**Las dos afirmaciones tienen respaldo registrado, y ninguno es nuevo:**

| Afirmación del prompt | Evidencia en el framework | Cifra |
| --- | --- | --- |
| Consulta cosas que ya estaban resueltas | `Master-Prompt.md` §8.1 y `Coherencia-La-Pregunta-Previa.md` §2, sobre una corrida real de consolidación y cierre de migración | **3 de 5 detenciones** presentadas al Product Owner **no eran suyas**: tenían respuesta en el árbol |
| No mira analíticamente lo que ya existe | `IA.SDD.Documentacion/Informes/Memoria-De-Antecedentes-Casos-Resueltos.md` §2.2 | **3 de 10 hallazgos abiertos no eran lo que declaraban ser**; cuatro falsos «enlaces rotos» **viajaron tres informes** antes de que alguien los abriera |

**Son el mismo defecto visto de los dos lados.** Del lado del humano, consultas que el árbol
contestaba; del lado del árbol, afirmaciones que nadie contrastó. Los produce la misma ausencia.

### 1.2 El framework ya intentó corregirlo, y su corrección es correcta pero insuficiente

La **9.19** incorporó **la pregunta previa** a `Master-Prompt.md` §8.1: *«¿esto tiene respuesta en el
árbol? Si la tiene, no es una detención: es trabajo propio»*, con la **cita literal como criterio**.

**Es la regla correcta y no alcanza, por dos motivos estructurales:**

1. **Es un filtro por detención, no un análisis del conjunto.** Se aplica de a una pregunta, por el
   agente que ya está a mitad del trabajo. Filtra las consultas espurias que aparecen; **no evita que
   aparezcan de a una en el medio de la ejecución**.
2. **No tiene la otra mitad.** Fija el criterio —¿tiene respuesta en el árbol?— y **no enumera los
   casos en que la respuesta es no**. Sin esa lista, ante la duda se detiene, y la propia sección
   admite que la asimetría de costos empuja siempre hacia detener.

### 1.3 Dónde está el hueco, exactamente

**Dos mecanismos parecen cubrirlo y los dos declaran por escrito que no lo hacen:**

| Mecanismo | Lo que declara de sí mismo | Por qué no cubre |
| --- | --- | --- |
| `Master-Prompt-Reanudacion.md` §2 | *«No se abre ninguna categoría documental para juzgar su contenido. La reanudación reconstruye dónde está el trabajo, no si está bien hecho»* | Lee **ubicación**, nunca contenido |
| `Master-Prompt.md` §10 | *«Cada cierre de fase dispara un audit independiente»* | Corre **después de producir**. Sobre un corpus que nadie tocó, no corre nunca |

**Y el plan que se compone en ese intervalo se construye con el diff normativo**
(`Master-Prompt-Migracion.md` §5), que compara dos versiones del framework: dice **qué cambió
afuera** y **nada de lo que el destino dice de sí mismo**. Las contradicciones internas del corpus
aparecen igual, pero en **M4, documento por documento**, y cada una es una detención sobre un árbol ya
en escritura. **Ése es el mecanismo que produce las rondas.**

---

## 2. Evaluación del marco de la mesa evaluadora

**El marco es sólido y su §0 —«qué cambia respecto del pedido original»— es su mejor parte**: llega
con sus propias condiciones de corte, su escala de evidencia y su separación de funciones ya
resueltas. El riesgo no es su calidad: es que **la mitad de sus mecanismos ya existen en SDD con otro
nombre**, y adoptarlos tal cual habría creado dos escalas para las mismas preguntas.

| Mecanismo del marco | Decisión | Fundamento |
| --- | --- | --- |
| Panel por **señal observable**, núcleo permanente, ad hoc con carta de mandato | **Entra** | SDD no tiene nada que elija revisores por lo que el artefacto contiene. Es el aporte más grande |
| **Jurado de cinco funciones objetivo**, votando por hallazgo | **Entra** | SDD detecta y corrige, y **nunca pesa si corregir vale la pena**: todo hallazgo se vuelve trabajo |
| **Separación entre quien diseña el parche y quien lo aprueba** | **Entra** | Hoy el que encuentra es el que corrige |
| **Escaladas agrupadas con default declarado** | **Entra** | Es la respuesta directa a las rondas. §8.1 fijaba la **forma**; faltaba el **lote** |
| **Lista cerrada de siete disparadores** | **Entra** | Es la mitad que le faltaba a la pregunta previa de §8.1 |
| Severidades **S1-S4** | **Rechazado** | SDD tiene **P0-P3** (§10). Dos escalas para la misma pregunta son dos conjuntos cerrados en conflicto, que es lo que §7.0 existe para arbitrar |
| Cinco **chequeos mecánicos** propios | **Rechazado** | Es la **compuerta de §10.0**, que desde la 13.6 exige además banco de casos. La mesa la corre, no la redefine |
| Parada por **20 % de rendimientos decrecientes** y `ciclos_max` | **Rechazado** | **§10.1** ya lo fija: dos rondas sin hallazgo interpretativo; cuatro rondas suben al humano declarando que cerró por decisión |
| **Esquemas JSON** | **Rechazado** | Los informes de SDD son documentos con tablas sujetos a D1-D9. Un formato paralelo obligaría a auditar dos |

**Lo único que se importó como escala nueva es la clase del ancla, E1-E4 y C**, porque SDD exige cita
literal desde la 9.19 y **no la gradúa**. Graduar el ancla resuelve mecánicamente la pregunta previa: con
ancla, lo cierra el agente; sin ancla posible, es del humano.

**Y trae un efecto secundario valioso**: un hallazgo **heredado de un informe anterior** entra como `C`
y **no funda ningún parche hasta que alguien lo abre**. Es exactamente lo que les faltaba a los cuatro
falsos enlaces rotos que viajaron tres informes.

---

## 3. La decisión de forma: mecanismo, no cuarto orquestador

**La tentación era escribir `Master-Prompt-Preplanificacion.md`. Se descartó**, y el criterio lo da el
propio método.

Los tres orquestadores están separados por **cardinalidad**, y cada uno la declara: una vez por
producto, una por salto de versión, una por reanudación
(`Master-Prompt-Reanudacion.md` §0). **La preplanificación no tiene cardinalidad propia**: ocurre una
vez por **plan de cambios**, que es un evento de dentro de las otras tres.

**El precedente correcto es el audit.** `Master-Prompt.md` §10 es un mecanismo con su regla, su rol y
su artefacto, que los tres orquestadores invocan y **no es un orquestador**. La mesa se construyó con
esa forma: mecánica en `Mesa-Rules.md`, invocación en el orquestador, por el principio de delegación
de la especialidad de `Master-Prompt.md` §1 — *«un cambio de mecánica toca la regla y no este
archivo»*.

---

## 4. La decisión de momento — la respuesta a la solicitud 2

El prompt planteaba dos ubicaciones posibles: **antes, como recurso previo para componer el plan**, o
**durante la migración, para crear y aprobar el plan de migración**.

> **Son el mismo momento visto desde dos prompts.** El método ya tiene el artefacto que los une:
> `Master-Prompt-Migracion.md` §12 declara que el plan de migración es *«el contrato entre el
> orquestador de generación y el de migración»*.

**El momento es uno: después de leer el estado, antes de aprobar el plan.**

### 4.1 Los tres argumentos, cada uno con su cita

**1 · Antes no se puede.** El contrato de entrada de la mesa es la salida de R0 —las seis dimensiones,
las divergencias, los pendientes, el diff normativo—. Convocarla antes sería planificar sobre lo que
se supone, que es lo que `Migracion-Rules.md` §3 rechazó **con cinco fundamentos** al descartar los
playbooks por salto, y lo que `Master-Prompt.md` §8.1 generaliza: *«un plan escrito antes de tener el
estado a la vista planifica sobre lo que se supone»*.

**Esto también responde a la objeción obvia**: la mesa **no viola** esa regla, la cumple. Corre con el
estado ya leído. Lo que la violaría es convocarla antes de R0.

**2 · Después es tarde.** R2 es donde el humano elige entre las cinco salidas y M4 es donde el plan se
aplica. Elegir sin saber si el corpus se sostiene es elegir sobre la mitad de la información —el mismo
argumento por el que `Master-Prompt-Reanudacion.md` §3 presenta **las divergencias antes que las
salidas**—. Y los hallazgos que aparecen en M4 aparecen de a uno, sobre un árbol ya en escritura.

**3 · Es el único punto donde una corrida sirve a las cinco salidas.**

| Salida | Qué consume de la mesa |
| --- | --- |
| **A · Reparar** | El plan de cambios **es** su lista de trabajo, con parches de texto exacto y criterio de verificación |
| **B · Migrar** | El registro viaja a M1, que **lo verifica en lugar de reconvocarla** |
| **C · Seguir en la versión declarada** | Funda la verificación artefacto por artefacto que §4 exige para actualizar la procedencia sin migrar |
| **D · Continuar la construcción** | Es su punto de continuación — la salida que no tiene prompt y sólo tiene el informe |
| **E · Retomar la migración en vuelo** | Refuta **el plan a medias**, que es un plan que nadie revisó |

### 4.2 Cómo queda cableado

```text
R0 reconocimiento  →  R1 presentación  →  R1.5 MESA  →  R2 salidas  →  R3 informe  →  R4 continuación
                                              │
                                              ├─ plan de cambios ─→ salida A (lo aplica)
                                              ├─ registro ────────→ salida B/E ─→ M1 (lo verifica)
                                              ├─ deuda declarada ─→ Root-Rules §12.2
                                              └─ escaladas ───────→ Decisiones-Pendientes.md

Invocación directa de migración (sin pasar por reanudación):
M0 reconocimiento  →  M1 diff normativo + MESA (la convoca)  →  M2 … M6
```

**R1.5 es la única fase del prompt de reanudación sin detención**: no pregunta, analiza. Y **M1 no la
reconvoca** cuando llega desde la reanudación, por el precedente que la 2.3 del orquestador de
migración ya fijó para el diff normativo: *«reconstruirlo desde cero no lo hace más confiable: lo hace
más lento, y arriesga dos diffs del mismo salto que no coinciden»*.

### 4.3 Dónde NO se convoca, y por qué decirlo importa

- **Generación desde cero.** No hay corpus previo que refutar, y lo que se produce lo audita §10 fase
  por fase. Convocarla ahí duplicaría el audit sobre el mismo material.
- **`SDD/Docs/` vacía.** Corresponde el prompt de bootstrap.
- **Cuando el humano quiere sólo el diagnóstico.** Se ofrece y se puede declinar; el informe declara
  que no corrió. Lo que no es válido es lo inverso: correrla y no registrarla.

---

## 5. Qué cambia para quien lo opera

| Antes | Después |
| --- | --- |
| Las consultas llegan **de a una**, durante la ejecución, sobre un árbol ya en escritura | Llegan **en lote, antes del plan**, con opciones, recomendación y **qué pasa si no se responde** |
| Toda consulta que el agente duda, se eleva | Sólo se eleva lo que cae en **los siete disparadores de `Mesa-Rules.md` §7**; el resto se resuelve y se registra |
| Un hallazgo heredado de un informe anterior **funda trabajo** | Entra como `C` y **no funda parche hasta que alguien lo abre** |
| Todo hallazgo detectado se convierte en trabajo | Un **jurado** pesa impacto, costo y reversibilidad; lo que no se corrige queda como **deuda declarada con su evento de cierre**, no ignorado |
| El plan sale del diff normativo, ciego al corpus | El plan sale del diff **y** de lo que el corpus dice de sí mismo |

---

## 6. Lo que queda abierto, y se declara

**Nadie corrió una mesa sobre un destino real todavía.** Un panel de núcleo más hasta cinco variables,
con jurado de cinco y cuerpo de parches, es el despacho más caro que el método declara. Los topes de
`Mesa-Rules.md` §5.5 y §6.7 lo **acotan y no lo miden**.

Queda como ítem diferido con los cuatro campos de `Root-Rules.md` §12.2, declarado en el `CHANGELOG.md`
del framework, entrada **13.7**. **Su evento de cierre es la primera corrida real**, y lo que hay que
medir está escrito: **hallazgos procedentes sobre convocados**, y **detenciones presentadas al humano
antes y después** — que es la cifra que originó todo esto y la única que dice si funcionó.

**Y el modo de falla a vigilar es el teatro deliberativo**: un panel que produce actas y ningún parche.
La salvaguarda está escrita —todo voto con fundamento, todo parche con texto exacto— y el indicador que
lo delata es el registro de convocatoria contrastado al cierre: si una especialidad se convoca cinco
veces y nunca aporta un `PROCEDE`, **el defecto es de la señal, no del destino**.

---

## 7. Inventario de la intervención

| Archivo del framework | Versión | Qué cambió |
| --- | --- | --- |
| `SDD/Devs/Rules/Mesa-Rules.md` | **1.0** | Nuevo. La mecánica completa: 11 secciones, 14 criterios de aceptación, 12 anti-patrones |
| `SDD/Devs/Orchestrator/Master-Prompt-Reanudacion.md` | 1.9 → **1.10** | §3.1 nueva: **R1.5** |
| `SDD/Devs/Orchestrator/Master-Prompt-Migracion.md` | 2.8 → **2.9** | **M1** convoca o verifica; M6 suma un P0 |
| `PROMPTS/PROMPT-Agente-Reanudacion-SDD.md` | 1.3 → **1.4** | Declara R1.5 y el lote de consultas |
| `PROMPTS/PROMPT-Agente-Migracion-SDD.md` | 2.0 → **2.1** | M1 nombra la mesa |
| `SDD/Devs/Rules/Root-Rules.md` | 8.5 → **8.6** | Alta de **`AG-00970`**, presidente de mesa |
| `SDD/Devs/Rules/Catalogo-De-Criterios.md` | 1.13 → **1.14** | 5 criterios y 12 situaciones nuevas; totales 220 / 107 / 113 |
| `SDD/Devs/Guides/Coherencia-Mesa-De-Evaluacion.md` | **1.0** | Nueva. Nota de coherencia de la intervención |
| `README.md`, `SDD-Development-Guide.md` **1.29**, `SDD-User-Guide.md` **1.20** | — | Barrido de recuentos: 19 → **20** reglas, 7 → **8** transversales, y **dos «los dos orquestadores» que ya estaban viejos** |
| `CHANGELOG.md` | **13.7** | Entrada del conjunto, con su impacto sobre destinos y su ítem diferido |
