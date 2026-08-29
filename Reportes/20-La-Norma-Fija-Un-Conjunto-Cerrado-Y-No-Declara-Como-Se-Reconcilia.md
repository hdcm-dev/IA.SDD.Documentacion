# Reporte 20 — La norma fija un conjunto cerrado y no declara qué hacer cuando el destino no lo puede satisfacer

| Campo | Valor |
|---|---|
| Reporte | 20 |
| Fecha | 2026-08-29 |
| Origen | El destino `RPI.VideoControl`. Dos hallazgos independientes, levantados con **once días de diferencia** por instrumentos distintos —la cuarta ronda del audit de migración y la mesa de evaluación—, que el registro de decisiones pendientes del destino tenía anotados como `DEC-00008` y `DEC-00004` sin poder cerrarlos: **los dos son del framework y ningún destino los puede tocar** |
| Versión del framework evaluada | SDD **13.9** (`Master-Prompt-Migracion.md` 2.9 §10, `Migracion-Rules.md` 3.19 §6, `Rules-Arquitectura-Tecnica.md` 4.5 §4.1) |
| Artefactos del framework alcanzados | `SDD/Devs/Orchestrator/Master-Prompt-Migracion.md` §10 · `SDD/Devs/Rules/Migracion-Rules.md` §6 · `SDD/Devs/Rules/Rules-Arquitectura-Tecnica.md` §4.1 |
| Naturaleza | **Dos conjuntos cerrados que el framework declara y no sabe reconciliar.** Uno se contradice consigo mismo dentro del propio conjunto normativo; el otro no admite lo que un destino real necesitó. Ninguno de los dos tiene procedimiento declarado, y el destino terminó inventando uno distinto para cada caso |
| Estado | **Abierto** |
| Reportes relacionados | `12`, que este reporte **no reabre**: aquél era sobre una compuerta declarada que no se ejecutaba. Éste es sobre un conjunto que sí se ejecuta y cuyo contenido no cierra |

---

## 1. Resumen

El framework declara conjuntos cerrados —de criterios, de categorías, de estados— y los declara bien: un conjunto cerrado es lo que impide que cada destino invente su propio vocabulario. **Lo que no declara es qué hacer el día que uno de esos conjuntos no se puede satisfacer.**

Hay dos formas de que eso pase, y este reporte trae una instancia medida de cada una:

- **El conjunto se contradice consigo mismo.** `Master-Prompt-Migracion.md` §10 le dice al auditor que verifique «los **catorce** criterios de aceptación de `Migracion-Rules.md` §6», y §6 tiene **41 casillas**. El auditor enumera contra un total equivocado, y ninguna de las dos cifras está anclada a la otra.
- **El conjunto no alcanza.** `Rules-Arquitectura-Tecnica.md` §4.1 fija siete valores para el campo `Categoría` de un ADR, y un destino necesitó un octavo —`Calidad`, para una decisión sobre umbrales de cobertura—. No hay figura para extenderlo, ni para declarar que no se puede.

**Lo que los une no es el tema: es que el destino queda sin salida declarada y tiene que improvisar una.** En un caso improvisó usar las 41 casillas y anotar la discrepancia; en el otro, escribir una nota en prosa dentro del propio ADR. La segunda improvisación **el framework la prohíbe explícitamente**, y quien la escribió lo sabía.

## 2. Lo que el framework ya resuelve bien, y por qué esto no lo contradice

**La existencia de conjuntos cerrados no está en discusión.** `Vocabulario-Rules.md` los sostiene y son la razón de que dos destinos distintos hablen el mismo idioma; sin ellos, «Categoría» significaría una cosa por producto y el audit no podría verificar nada.

**Y el framework ya tiene la figura correcta para lo que no puede satisfacer:** el apartamiento de `Root-Rules.md` §11, con sus seis campos, su estado y su evento de cierre. Funciona, se usa, y el reporte `19` acaba de proponer extenderla.

Lo que falta no es la figura. Es que **§11 gobierna la no emisión de un artefacto obligatorio**, y ninguno de estos dos casos es eso: acá el artefacto se emite, y lo que no cierra es **un valor dentro de él**. El destino lo usó igual —`ADR-00077` declara su apartamiento con los seis campos— y dejó escrito que lo estaba forzando.

## 3. La evidencia

### 3.1 Instancia A — catorce contra cuarenta y uno

`SDD/Devs/Orchestrator/Master-Prompt-Migracion.md` §10, línea 317, literal:

> **Qué se suma a los criterios de §10:** los catorce criterios de aceptación de `Migracion-Rules.md` §6.

Medido sobre `SDD/Devs/Rules/Migracion-Rules.md` 3.19:

```
awk '/^## 6\./,/^## 7\./' SDD/Devs/Rules/Migracion-Rules.md | grep -c "^- \[ \]"
→ 41
```

**Cuarenta y uno, no catorce.** El destino lo levantó como hallazgo `C-13` de su cuarta ronda de auditoría de migración, el 2026-08-18, y lo registró como `DEC-00008` con esta regla interina: «se usan **las 41 casillas** y no las catorce, que es lo que §6 efectivamente tiene».

**Lo que hace este caso instructivo no es el número.** Es que el framework **le exige a los destinos exactamente lo que acá no cumple**: `Root-Rules.md` §10 R1 a R5 obliga a que todo dato derivado que aparezca en prosa esté anclado a su fuente, y este destino lo verifica en cada integración con una comprobación mecánica —la 2 de su compuerta— que encuentra esta clase de defecto de a decenas. Si esa comprobación se corriera sobre el conjunto normativo, **habría encontrado ésta el primer día**.

### 3.2 Instancia B — siete categorías y una octava que hizo falta

`SDD/Devs/Rules/Rules-Arquitectura-Tecnica.md` 4.5 §4.1, cabecera obligatoria del ADR:

> **Categoría:** Estilo | Persistencia | Comunicación | Seguridad | Observabilidad | Despliegue | Extensibilidad

Siete valores. El destino emitió `ADR-00077 — Umbral de cobertura de los adaptadores`, una decisión sobre qué exigirle a la cobertura de una capa que no se puede probar sin hardware. **Ninguno de los siete la nombra.** «Estilo» es de forma del código; «Despliegue» y «Observabilidad» son de operación; «Extensibilidad» es la más cercana y significa otra cosa.

Lo que el destino hizo, en la cabecera del propio ADR:

> **Categoría:** Calidad — *fuera del conjunto cerrado de `Rules-Arquitectura-Tecnica.md` §4.1; la extensión no está declarada*

Y una nota en §1 explicando el conflicto.

**Esa nota es la parte que importa, porque el framework la prohíbe con estas palabras.** `Master-Prompt.md` §7.0 declara por qué existe el registro de decisiones pendientes, y describe la alternativa que vino a reemplazar: una nota en prosa dentro del artefacto que se chocó con el problema *«tiene el mismo peso visual que el resto del texto, no interrumpe a nadie, y sobrevive a todos los audits»*.

Es exactamente lo que pasó. La nota sobrevivió **seis rondas de auditoría** sin que ninguna la levantara, y la que finalmente lo hizo fue la mesa de evaluación del destino, once días después, como hallazgo `S-12`.

### 3.3 El destino resolvió las dos de forma distinta, y ninguna es reutilizable

| | Instancia A | Instancia B |
|---|---|---|
| Qué hizo | Usar 41 y anotarlo en el registro de decisiones | Escribir el valor fuera del conjunto, con nota en el artefacto |
| Cuánto tardó en detectarse | 1 ronda | **6 rondas** |
| Qué la detectó | El audit de migración | La mesa de evaluación |
| Por qué no se corrigió | Es del framework | Es del framework |
| Qué queda en el destino | Un ítem abierto que nadie puede cerrar | Un ADR con un valor que su propia regla no admite |

**Las dos improvisaciones son razonables y ninguna es el procedimiento.** Un destino que se choque mañana con un tercer conjunto cerrado va a improvisar una tercera.

## 4. La causa raíz

**El framework declara conjuntos cerrados sin declarar su régimen de reconciliación.** Un conjunto cerrado tiene tres preguntas que hay que contestar al declararlo, y hoy se contesta una sola:

1. **Cuáles son sus valores.** Contestada, siempre.
2. **Qué pasa si el conjunto se contradice consigo mismo** —si dos artefactos de la norma declaran cardinalidades distintas del mismo conjunto—. **Sin contestar.**
3. **Qué pasa si un destino necesita un valor que no está.** **Sin contestar.**

La segunda es la más incómoda, porque es una pregunta que la norma se hace sobre sí misma: **el framework le exige a los destinos anclar sus recuentos derivados y no se lo exige a su propio corpus.** No es una omisión de redacción. Es que el conjunto normativo no tiene compuerta.

## 5. El patrón, enunciado

> **Un conjunto cerrado sin régimen de reconciliación traslada al destino una decisión que el destino no puede tomar.** El valor que falta y la cardinalidad que no coincide no son casos de excepción: son el modo normal en que un método vivo se encuentra con un producto real. Si la norma no declara qué hacer, el destino no deja de resolverlo —lo resuelve igual, cada vez de una forma distinta, y en el lugar donde nadie lo va a leer.

El corolario es el que este reporte considera más importante: **la norma se aplica a sí misma las reglas que impone, o no las puede exigir con autoridad.** El destino que levantó la instancia A tiene una compuerta mecánica que verifica esa misma regla sobre 290 documentos en cada integración. El conjunto normativo no tiene ninguna.

## 6. Propuestas de intervención

### 6.1 Un campo de reconciliación en la declaración de todo conjunto cerrado

Que toda regla que declare un conjunto cerrado declare, junto a él, **qué hace un destino que no lo pueda satisfacer**. Tres salidas, y el conjunto elige la suya al declararse:

| Salida | Cuándo | Qué produce el destino |
|---|---|---|
| `cerrado-estricto` | El conjunto es del método y admitir un valor nuevo lo rompe | Una **detención de §7**, y el valor no se usa |
| `cerrado-con-reporte` | El conjunto es del método y puede crecer | El destino **usa el valor**, lo declara en su ADR y **emite un reporte** como éste |
| `abierto-por-destino` | El conjunto orienta y no restringe | El destino lo extiende y lo declara en su corpus |

**El valor de esto no es la clasificación: es que la pregunta se conteste al declarar el conjunto** y no cuando alguien se choca con él.

### 6.2 Aplicar `Root-Rules.md` §10 al propio conjunto normativo

Que el corpus del framework pase su propia comprobación de recuentos anclados. La instancia A es una afirmación derivada —«catorce»— escrita en prosa, sobre una fuente contable —las casillas de §6—, exactamente la forma que R1 a R5 prohíben.

**No hace falta construir el instrumento**: el destino `RPI.VideoControl` tiene uno que lo hace, y la comprobación 2 de su `compuerta.py` es directamente portable. Lo que hace falta es la decisión de correrlo sobre `SDD/Devs/`.

### 6.3 Las dos correcciones puntuales, que son de una línea cada una

- `Master-Prompt-Migracion.md` §10: «los catorce criterios» → **«los 41 criterios»**, o mejor, una redacción que no fije el número y remita a §6.
- `Rules-Arquitectura-Tecnica.md` §4.1: agregar **`Calidad`** al conjunto, o declarar por qué una decisión sobre umbrales de verificación tiene que caber en los siete que hay.

**Se proponen últimas y a propósito.** Corregirlas sin 6.1 deja el patrón intacto y garantiza una tercera instancia.

### 6.4 Lo que conviene NO hacer

**No abrir el conjunto de categorías de ADR.** El destino necesitó un valor, no la libertad de inventarlos: un campo abierto acá haría que dos productos clasificaran la misma decisión distinto y el audit no pudiera comparar nada.

**No resolver la instancia A subiendo §6 a catorce casillas.** Las 41 son criterios reales que alguien escribió; el número equivocado es el de §10.

## 7. Cómo verificar que la corrección funcionó

| Qué | Cómo se mide | Hoy |
|---|---|---|
| Conjuntos cerrados sin salida de reconciliación declarada | Recorrer las reglas y contar los que declaran valores sin declarar qué hacer si no alcanzan | **Sin medir**: la figura no existe |
| Recuentos en prosa del conjunto normativo que no coinciden con su fuente | La comprobación 2 de `compuerta.py`, corrida sobre `SDD/Devs/` | **Sin medir**: nadie la corre ahí. **Se conoce al menos uno** |
| ADR de destinos con `Categoría` fuera del conjunto | Barrido sobre los corpus | **Uno**, `ADR-00077` de `RPI.VideoControl` |

## 8. Lo que este reporte no afirma

**No afirma que los dos hallazgos sean graves por sí mismos.** Uno es un número mal escrito y el otro es una palabra que falta en una lista. Tomados de a uno, son patch.

Lo que se reporta es que **ninguno de los dos tenía dónde resolverse**, y que el destino los cargó como decisiones pendientes que nadie puede cerrar —`DEC-00008` desde el 2026-08-18 y `DEC-00004` desde el 2026-08-27—. Un registro de decisiones que acumula ítems que su dueño no puede decidir deja de ser un registro de decisiones.

**Y no afirma que el conjunto normativo esté mal medido en general.** Se conoce **una** instancia de recuento desanclado, la de §10. Cuántas más hay es exactamente lo que 6.2 propone averiguar, y este reporte no lo sabe.
