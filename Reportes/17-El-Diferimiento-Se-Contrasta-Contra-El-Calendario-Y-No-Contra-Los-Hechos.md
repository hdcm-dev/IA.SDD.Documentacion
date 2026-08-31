# Reporte 17 — El diferimiento se contrasta contra el calendario y no contra los hechos, y la política de archivado que el destino aplica no está escrita

| Campo | Valor |
|---|---|
| Reporte | 17 |
| Fecha | 2026-08-31 |
| Origen | La migración normativa **10.0 → 13.3** de `Lab-Geometria`, cerrada el **2026-08-25**. Los dos hallazgos son de su §5.2 y §7, medidos al migrar y **no reparados por ella**: los dos son del framework |
| Versión del framework evaluada | SDD **13.3** al medirse, revisado contra **13.8** al emitirse. Los dos huecos siguen |
| Artefactos del framework alcanzados | `SDD/Devs/Orchestrator/Master-Prompt.md` §5.1 y §10.0 comprobación 6 · `SDD/Devs/Orchestrator/Master-Prompt-Reanudacion.md` §2 paso 4 · `SDD/Devs/Rules/Root-Rules.md` §12.2 |
| Naturaleza | Dos huecos independientes que la misma migración destapó. El primero es **de cobertura de una comprobación**; el segundo es **una práctica correcta que ninguna regla admite** |
| Estado | **Abierto** |
| Reportes relacionados | El **`14`**, que nació de este mismo producto y de la misma figura —un ítem que empaqueta dos decisiones—. El **`22`**, emitido hoy, que ataca la otra mitad del campo 6 de `Root-Rules.md` §11 |
| Por qué este número | La numeración es **por orden de emisión y no se reserva**. El `17` quedó libre cuando el `16` lo tomó otro reporte el 2026-08-27, y estos dos hallazgos lo esperaban desde el **2026-08-25** |

---

## 1. `HM-02` — Un ítem cuyo evento no ocurrió pero cuya premisa ya murió

### 1.1 Qué falla

**El método sabe detectar el diferimiento vencido y no sabe detectar el diferimiento sin objeto.**

`Master-Prompt.md` §10.0, comprobación **6**, tiene el test del vencimiento y lo tiene bien: *«es hallazgo el que nombre un evento de cierre que ya ocurrió»*. `Master-Prompt-Reanudacion.md` §2 paso 4 lo repite al reanudar, contrastando el evento **contra el calendario**.

**Los dos preguntan lo mismo: ¿ya pasó la fecha?** Ninguno pregunta **si la pregunta sigue teniendo sentido**.

Un ítem puede estar **formalmente impecable** —los cuatro campos de `Root-Rules.md` §12.2, un evento que todavía no ocurrió, estado `Vigente`— y estar difiriendo **una pregunta que los hechos ya contestaron**. Ese ítem no dispara ninguna comprobación: su fecha no venció.

### 1.2 El caso, medido

**`PA-01` de `Lab-Geometria`: la unidad de estimación de las historias.**

Se difirió al punto de control de la etapa `c`. Y mientras esperaba:

| Hecho | Fuente |
| --- | --- |
| **Ocho etapas se planificaron, se construyeron y se cerraron sin una sola estimación** | `changelog.md` del destino |
| El equipo es de **una persona** | `PRODUCT-INTAKE` §2, `equipo_n = 1` |
| El plan **se niega a declarar capacidad numérica**, y lo declara deliberado | `Mini-Plan.md` §1.2 |

**La pregunta estaba contestada por los hechos: no hay unidad de estimación porque el producto demostró que no la necesita.** El ítem siguió `Vigente`.

**Y hay un dato que cierra el caso: si se hubiera resuelto, habría entrado a 144 historias.** No es un ítem menor que sobrevive por inercia — es uno cuyo cierre habría tocado el corpus entero.

### 1.3 Dónde está el hueco, acotado

**Conviene acotarlo, porque no está donde parece.** La comprobación 6 **sí** habría disparado sobre `PA-01`: nombraba artefacto y sección, y su evento venció el 2026-08-14.

**Lo que falló ahí fue la cobertura, no el test.** La comprobación alcanza a los ítems que **el árbol de la fase** declara, y **ninguna fase volvió a abrir la categoría 06** entre esa fecha y la migración. Eso es un problema de alcance de una comprobación que funciona.

**El hueco propio —el que ninguna pieza cubre— es el otro:** un ítem cuyo **evento todavía no ocurrió** y cuya **premisa ya murió**. Ése no lo detectan:

- ni §10.0 comprobación 6, que mira el evento contra el calendario;
- ni el paso 4 de la reanudación, que hace lo mismo;
- ni la clasificación por enunciado de un plan de cierre de pendientes, que en este destino **mandó `PA-01` a «decisión del Product Owner»** cuando el árbol ya lo tenía contestado.

**Tres piezas lo miraron y las tres preguntaron por la fecha.**

### 1.4 Qué se propone evaluar

**1.4.a Un tercer estado, junto a vencido y vigente: «sin objeto».** Con obligación de **citar el hecho que lo cerró**, que es lo que impide que se use para archivar lo incómodo.

**1.4.b Que el paso 4 de la reanudación contraste la premisa además del evento.** La pregunta que falta es barata de enunciar: *«¿el árbol ya contestó esto?»*.

**Y hay un precedente en el propio destino:** `ADR-14004` —«un ítem obligatorio sin objeto se declara no aplica»— resolvió la figura análoga **para los ítems obligatorios de una regla**, con tres partes obligatorias: que no aplica, por qué no tiene objeto con cita, y qué lo reabriría. **Lo que falta es la misma figura para el ítem diferido.**

## 2. `HM-03` — La política de archivado que el destino aplica no está escrita

### 2.1 Qué falla

`Master-Prompt.md` §5.1 dice, sin excepción: **«Al ser superado se copia completo»**.

**El destino no archiva cada estado superado: archiva el estado previo a la unidad de trabajo.** Y lo hace de forma uniforme:

| Documento | Archivó | No archivó |
| --- | --- | --- |
| README raíz | `v1.6` | `v2.0` |
| `Supply-Chain-Seguridad.md` | `v2.0` | `v2.1` ni `v3.0` |
| El manifiesto | `v4.0` | `v5.0` |

**Diez commits, 160 snapshots, todos por unidad de trabajo y ninguno por estado intermedio.**

### 2.2 Por qué importa, y no es una discusión de estilo

**La práctica es razonable**: un archivado por estado intermedio produce snapshots de documentos que nunca fueron el vigente de nada, y multiplica `_legacy/` por la cantidad de veces que una unidad de trabajo toca un archivo.

**Lo que no existe es el documento que la declare.** Y sin él, **un archivado legítimo y uno omitido se ven exactamente igual**: los dos son un `_legacy/` con menos snapshots de los que la letra pide.

**Eso ya costó una discusión real** en la ronda 2 del corte de esta migración, y la discusión **no se podía resolver**: el método no permite decidir cuál de las dos cosas era.

### 2.3 Qué se propone evaluar

**Una de dos, y el framework tiene que elegir:**

**(a)** §5.1 **admite la excepción y la nombra**: se archiva el estado previo a la unidad de trabajo, no cada estado superado. Con eso, un `_legacy/` con un solo snapshot por unidad **es conforme**, y uno que omite el primero **es un defecto visible**.

**(b)** La práctica es incorrecta y hay que archivar cada estado superado. Con eso, este destino tiene **una deuda medida y acotada**, y sabe cuál es.

**Lo que no sirve es lo de hoy**, que es que las dos lecturas sean defendibles.

## 3. Lo que este reporte no afirma

**No afirma que la migración haya hecho algo mal.** Los dos hallazgos son **de la migración hacia el framework**, y ella los registró sin repararlos porque no son suyos.

**No afirma que `HM-01` sea del framework.** El tercer hallazgo de esa migración —dos ítems cerrados «por lectura» con el generador del inventario adentro y sin resolver— **es de la categoría 09 del destino** y no se eleva acá. Se declara para que su ausencia no se lea como olvido.

**No propone la redacción de ninguna de las dos.** Enumera el hueco y sus opciones.

## 4. Cómo reproducirlo

**`HM-02`:** diferir un ítem a un evento futuro; dejar que el producto conteste la pregunta por los hechos, sin tocar el ítem; correr las comprobaciones del método antes de que el evento ocurra. **Ninguna lo levanta.**

**`HM-03`:** aplicar el archivado por unidad de trabajo durante una migración de diez commits; contar los snapshots contra la letra de §5.1. **Faltan, y no hay regla que diga si eso está bien.**

---

## Control de cambios

| Versión | Fecha | Descripción |
|---|---|---|
| 1.0 | 2026-08-31 | Emisión, con **seis días de demora** sobre la migración que los midió: los dos hallazgos esperaban desde el 2026-08-25 y su número quedó libre el 2026-08-27. `HM-02`: el método pregunta por la fecha del diferimiento y no por su premisa; el caso medido es un ítem impecable que difería una pregunta que ocho etapas cerradas ya habían contestado, y que **habría entrado a 144 historias**. Se acota el hueco: la comprobación 6 de §10.0 funciona y lo que falló fue su cobertura; lo que ninguna pieza cubre es el ítem **cuyo evento no ocurrió y cuya premisa murió**. `HM-03`: el destino archiva **por unidad de trabajo** —160 snapshots en diez commits— y §5.1 dice «al ser superado se copia completo», sin excepción; sin regla, **un archivado legítimo y uno omitido se ven igual**. Se declara que el tercer hallazgo de esa migración, `HM-01`, **no es del framework**. |
